package edu.upenn.cbil.biomatgraph;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Writer;
import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.google.common.base.Charsets;
import com.google.common.io.Files;

import freemarker.template.Configuration;
import freemarker.template.Template;


public class Display {
  public Study study;
  public String fileName;
  public static final String DOT_EXT = ".dot";
  public static final String IMG_EXT = ".gif";
  public static final String HTML_EXT = ".html";
  public static Logger logger = Logger.getLogger(Display.class);
   
  public Display(Study study) {
    this.study = study;
    fileName = ApplicationConfiguration.filePrefix + "_" + study.getStudyId();
  }
  
  public File createDotFile() {
    StringBuffer output = new StringBuffer();
    output.append("digraph biomatGraph {\n");
    output.append("graph [rankdir=LR, margin=0.001]\n");
    for(Node node : study.getNodes()) {
      String label = "label = \"" + node.getLabel() + "\""; 
      String color = "color = \"" + node.getColor() + "\"";
      String url = "URL = \"node.html?id=" + node.getNodeId() + "\"";
      String font = "fontsize = 12";
      output.append(node.getNodeId() + " [" + color + ", " + label + ", " + url + ", " + font + "]\n");
    }
    for(Edge edge : study.getEdges()) {
      String label = "label = \"" + edge.getLabel() + "\"";
      String url = "labelURL = \"edge.html?id=" + edge.getFromNode() + "_" + edge.getToNode() + "\"";
      String font = "fontsize = 10";
      output.append(edge.getFromNode() + "->" + edge.getToNode() + "[" + label + ", " + url + ", " + font + "]\n");
    }
    output.append("}");
    String dotFileName = fileName + DOT_EXT;
    File dotFile = new File(dotFileName);
    try {
      Files.write(output.toString(), dotFile, Charsets.UTF_8);
      return dotFile;
    }
    catch(IOException ioe) {
      throw new ApplicationException("Problem writing to file " + dotFileName);
    }
  }
   
   public File createImageMapFile(File dotFile) {
     String DOT = ApplicationConfiguration.graphvizDotPath;
     File mapFile = null;
     try {
        File imageFile = new File(fileName + IMG_EXT);
        mapFile = File.createTempFile("map", HTML_EXT);
        Runtime rt = Runtime.getRuntime();
        String[] args = {DOT, "-Tgif", dotFile.getAbsolutePath(), "-o", imageFile.getAbsolutePath(), "-Tcmapx", "-o", mapFile.getAbsolutePath()};
        Process p = rt.exec(args);
        p.waitFor();
     }
     catch (java.io.IOException ioe) {
       throw new ApplicationException("Unable to read dot file or create image or map files.");
     }
     catch (java.lang.InterruptedException ie) {
       throw new ApplicationException("The dot program was interrupted.");
     }
     return mapFile;
   }
   
   public String retrieveMap(File mapFile) {
     String map = null;
     try {
       map = Files.toString(mapFile, Charset.defaultCharset());
     }
     catch (IOException ioe) {
       throw new ApplicationException("Unable to open map temp file for reading.");
    }
    return map;
   }
   
   public void createHtmlFile(String map) {
     Writer file = null;
     Configuration cfg = new Configuration();
     try {
       cfg.setDirectoryForTemplateLoading(new File("templates"));
       Template template = cfg.getTemplate("content.ftl");
       Map<String, Object> input = new HashMap<String, Object>();
       input.put("studyId", study.getStudyId());
       input.put("studyName", study.getStudyName());
       input.put("gifFileName", fileName + IMG_EXT);
       input.put("nodes", study.getNodes());
       input.put("edges", study.getEdges());
       input.put("map", map);
       file = new FileWriter(new File(fileName + HTML_EXT));
       template.process(input, file);
       file.flush();
     }
     catch (Exception e) {
       throw new ApplicationException("Unable to create the study html file.");
     }
     finally {
       if (file != null) {
         try {
           file.close();
         } catch (Exception ex) {
           logger.warn("Could not close the study html file.");
         }
       }
    }
  }
}
