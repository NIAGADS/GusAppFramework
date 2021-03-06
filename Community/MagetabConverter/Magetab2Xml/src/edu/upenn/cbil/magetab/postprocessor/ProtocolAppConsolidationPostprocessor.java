package edu.upenn.cbil.magetab.postprocessor;

import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.output.XMLOutputter;

import com.google.common.collect.ArrayListMultimap;
import com.google.common.collect.Multimap;

import edu.upenn.cbil.limpopo.utils.AppUtils;
import edu.upenn.cbil.magetab.utilities.ApplicationException;

/**
 * This postprocessor is employed to consolidate multiple edges as defined by protocol applications
 * from Limpopo, into a smaller set of protocol applications amenable to use in the GUS 4.0 schema.
 * MAGE-TAB specifications do not completely define exactly where an single instance of a protocol
 * is applied.  As a result, Limpopo and the LimpopoExtensions wrapper make edges and protocol
 * applications equivalent.  A split or a merge may involve the same protocol but constitute the same
 * or different protocol applications.  The definition of a protocol application is really somewhat
 * nebulous.  To get around this issue, the MAGE-TAB curator may add a parameter column in the SDRF
 * after a protocol reference ('cbil_run') that identifies edges that should be combined into one
 * protocol application.  That is in turn, translated into an attribute on the protocol application tag
 * in the xml.  This postprocessor uses that attribute to collapse multiple edges into a single edge
 * having multiple inputs or outputs.
 * @author Cris Lawrence
 *
 */
public class ProtocolAppConsolidationPostprocessor {
  private Document document;
  public static Logger logger = Logger.getLogger(ProtocolAppConsolidationPostprocessor.class);
  
  /**
   * Constructor accepts the current xml document for postprocessing
   * @param document - the current xml document generated by LimpopoExtensions
   */
  public ProtocolAppConsolidationPostprocessor(Document document) {
    this.document = document;
  }
  
  /**
   * This method takes the raw xml document and collapses protocol application elements identified by the same
   * run number into one protocol application element.  The first element in a list of elements associated
   * with the same run number is used as the prototype.  The input/output values of the remaining
   * elements are folded into the prototype and then discarded from the xml.  As a validation check, the
   * hash of each element is compared against that of the prototype.  If the hashes differ, an application
   * exception is thrown and the process quits.  Protocol applications with dissimilar data for series,
   * parameters, performer, protocol names cannot be grouped and suggests that the curator erred.
   * @return - post-processed xml document with appropriate edges collapsed into one protocol application
   */
  public Document process() {
    Element SDRFElement = document.getRootElement().getChild(AppUtils.SDRF_TAG);
    List<Element> protocolApps = SDRFElement.getChildren(AppUtils.PROTOCOL_APP_TAG);
    Multimap<String,Element> map = partitionByRunNumber(protocolApps);
    Iterator<String> iterator = map.keySet().iterator();
    while(iterator.hasNext()) {
      String runNumber = iterator.next();
      Collection<Element> elements = map.get(runNumber);
      Element prototypeElement = null;
      int prototypeHash = 0;
      Set<String> inputs = new HashSet<>();
      Set<String> outputs = new HashSet<>();
      for(Element element : elements) {
        inputs.add(element.getChildText(AppUtils.INPUT_TAG));
        outputs.add(element.getChildText(AppUtils.OUTPUT_TAG));
        if(prototypeElement == null) {
          prototypeElement = element.clone();
          prototypeHash = createHash(prototypeElement);
          prototypeElement.removeChild(AppUtils.INPUT_TAG);
          prototypeElement.removeChild(AppUtils.OUTPUT_TAG);
        }
        else {
          if(prototypeHash != createHash(element)) {
            throw new ApplicationException("The protocols for location = " + prototypeElement.getAttributeValue(AppUtils.ID_ATTR) + " and location = " + element.getAttributeValue(AppUtils.ID_ATTR) + " cannot be grouped together.  Please corrent the run numbers");
          }
        }
        SDRFElement.removeContent(element);
      }
      for(String input : inputs) {
        prototypeElement.addContent(new Element(AppUtils.INPUT_TAG).setText(input));
      }
      for(String output : outputs) {
        prototypeElement.addContent(new Element(AppUtils.OUTPUT_TAG).setText(output));
      }
      SDRFElement.addContent(prototypeElement);
    }
    return document;
  }

  /**
   * Helper method to partition the protocol application elements into a map with the key being the
   * run number (the run attribute value) associated with the element.  Protocol application elements
   * having no run number are not included in the partition since presumably, they need not be grouped.
   * @param elements - the protocol application elements to be partitioned
   * @return - a multimap in which the key is the run number and the value is a list of protocol application
   * elements for which that run number was an attribute.
   */
  protected Multimap<String,Element> partitionByRunNumber(List<Element> elements) {
    Multimap<String,Element> map = ArrayListMultimap.create(); 
    for(Element element : elements) {
      String runNumber = element.getAttributeValue(AppUtils.RUN_ATTR);
      if(StringUtils.isNotEmpty(runNumber)) {
        map.put(runNumber, element);
      }
    }
    return map;
  }
  
  /**
   * Helper method to create a hash of the provided protocol application element.  The hash is formed
   * by removing the tag attributes (id, dbid, run, addition) and the input and output child tags.  The
   * remaining contents are attached to an xml document and that document is translated into the string
   * to be hashed
   * @param protocolAppElement - the protocol application to hash
   * @return - the integer representing the hash
   */
  protected final int createHash(Element protocolAppElement) {
    Element element = protocolAppElement.clone();
    element.removeAttribute(AppUtils.ID_ATTR);
    element.removeAttribute(AppUtils.DBID_ATTR);
    element.removeAttribute(AppUtils.RUN_ATTR);
    element.removeAttribute(AppUtils.ADDITION_ATTR);
    element.removeChild(AppUtils.INPUT_TAG);
    element.removeChild(AppUtils.OUTPUT_TAG);
    Document tmpDocument = new Document();
    tmpDocument.addContent(element);
    XMLOutputter xmlOut = new XMLOutputter();
    return xmlOut.outputString(tmpDocument).hashCode();
  }

}
