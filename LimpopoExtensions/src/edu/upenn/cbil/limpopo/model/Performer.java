package edu.upenn.cbil.limpopo.model;

import java.lang.reflect.Field;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.builder.ReflectionToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;

import edu.upenn.cbil.limpopo.utils.AppUtils;

import uk.ac.ebi.arrayexpress2.magetab.datamodel.sdrf.node.attribute.PerformerAttribute;
import uk.ac.ebi.arrayexpress2.magetab.exception.ConversionException;

public class Performer {
  private String name;
  private OntologyTerm role;
  private Map<String,String> comments;
  public static final String PERFORMER_ROLE = "Performer Role";
  public static final String PERFORMER_TERM = "Performer Term Source Ref";
  
  public Performer() {
    name = "";
  }
  
  /**
   * Constructs a protocol application performer, populating name and role where
   * provided.  Addition/id tokens are filtered out.
   * @param attribute - limpopo performer attribute
   * @throws ConversionException
   */
  public Performer(PerformerAttribute attribute) throws ConversionException {
    setName(attribute.getNodeName());
    setComments(attribute.comments);
    if(!getComments().isEmpty() &&
        StringUtils.isNotEmpty(getComments().get(PERFORMER_ROLE)) &&
        StringUtils.isNotEmpty(getComments().get(PERFORMER_TERM))) {
      String performerRole = getComments().get(PERFORMER_ROLE);
      String performerRef = getComments().get(PERFORMER_TERM);
      if(StringUtils.isNotEmpty(performerRole)) {
        role = new OntologyTerm(performerRole, performerRef);
      }
    }
  }
  
  /**
   * Gets filtered performer's name
   * @return - performer's name
   */
  public String getName() {
    return name;
  }
  
  /**
   * Set the performer's name and removes any and all addition tokens
   * @param name - raw name
   */
  public final void setName(String name) {
    this.name = AppUtils.removeTokens(name);
  }

  /**
   * Get's the value for the ontology term - role
   * @return - role
   */
  public OntologyTerm getRole() {
    return role;
  }
  
  /**
   * Gets filtered comments
   * @return - comments
   */
  public final Map<String, String> getComments() {
    return comments;
  }

  /**
   * Set the performer's comments with any and all addition tokens removed.
   * @param comments - raw comments
   */
  public final void setComments(Map<String, String> comments) {
    this.comments = AppUtils.removeTokens(comments);
  }

  @Override
  public String toString() {
    return (new ReflectionToStringBuilder(this, ToStringStyle.MULTI_LINE_STYLE) {
      protected boolean accept(Field f) {
        return super.accept(f);
      }
    }).toString();
  }

}