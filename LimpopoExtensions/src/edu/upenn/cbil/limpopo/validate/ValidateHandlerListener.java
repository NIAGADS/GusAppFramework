package edu.upenn.cbil.limpopo.validate;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import uk.ac.ebi.arrayexpress2.magetab.handler.listener.HandlerEvent;
import uk.ac.ebi.arrayexpress2.magetab.handler.listener.HandlerListener;


public class ValidateHandlerListener implements HandlerListener {
  public static Logger logger = LoggerFactory.getLogger(ValidateHandlerListener.class);
  public static int errorCount = 0;

  public void handlingStarted(HandlerEvent evt) {
  }

  public void handlingFailed(HandlerEvent evt) {
    System.err.println(evt.getHandler().getClass().getSimpleName() + " failed.");
    errorCount++;
  }

  public void handlingSucceeded(HandlerEvent evt) {
  }
  
}
