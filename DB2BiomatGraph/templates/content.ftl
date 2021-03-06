<#include "header.ftl"> 

<h1>Biomaterial Graph Derived from Database for Study ${studyId}</h1>
<#if studyName??>
  <h3>${studyName}</h3>
</#if>
<p class="note">
  Click on each node or edge label in the graph below for detailed information (you may
  need to disable your popup blocker).  The node tooltip provides characteristics or file
  information while the edge label tooltip offers parameter settings, if any.  Nodes
  representing material entities are outlined in <span class="material">blue</span> while
  nodes representing data items are outlined in <span class="data">red</span>.  Some of
  the graphs are rather large.  Horizontal scroll bars above and below the diagram can be
  employed to scan across the image.
</p>
<div class="scroll2">
  <div id="biomaterials">
    <div id="panzoom" style="transform: matrix(1, 0, 0, 1, 0, 0);">
      <img src="${gifFileName}" usemap="#biomatGraph">
    </div>
    <#if map??>
      ${map}
    </#if>
    <#list nodes as node>
      <div id="text${node.getNodeId()?c}" class="popupData">
        <#if node.nodeId??>
          <p><span>DB ID: ${node.getNodeId()?c}</span></p> 
        </#if>
        <#if node.description??>
          <div class="subheading">Description</div>
          <p>${node.getDescription()}</p>
        </#if>
        <#if node.taxon?? || node.characteristics??>
          <div class="subheading">Characteristics</div>
        </#if>
        <ul>
          <#if node.taxon??>
            <li>${node.getTaxon()}</li>
          </#if>
          <#if node.uri??>
            <li>File Location = ${node.getUri()}</li>
          </#if>
          <#if node.characteristics??>
            <#list node.characteristics as characteristic>
              <li>${characteristic}</li>
            </#list>
          </#if>
          <#if !node.taxon?? && !node.uri?? && !node.characteristics?? && !node.description??>
            NA
          </#if>
        </ul>
      </div>
    </#list>
    <#list edges as edge>
      <div id="text${edge.getFromNode()?c}_${edge.getToNode()?c}" class="popupData">
        <#if edge.edgeId??>
          <p><span>DB ID: ${edge.getEdgeId()?c}</span></p> 
        </#if>
        <#assign i = 1>
        <#list edge.applications as application>
          <div class="subheading">${i}. ${application.name}</div>
          <#if application.description??>
            <p>${application.description}</p>
          </#if>
          <#if application.performer?? && application.performer?has_content>
            <div class="subheading">Performer</div>
            <p>${application.performer}</p>  
          </#if>
          <#if application.parameters?? && application.parameters?has_content>  
            <div class="subheading">Parameter Setting(s)</div>
            <ul>
              <#list application.parameters as parameter>
                <li>
                 ${parameter}
                </li>
              </#list>
            </ul>
          </#if>
          <#assign i=i+1>
          <#if i <= edge.applications?size>
            <hr class="separator" />
          </#if>
        </#list>
      </div>
    </#list>
  </div>
</div>
<#include "footer.ftl"> 