<%@ page import="org.sss.xplanner.*" %>
<g:javascript library="jquery" />
<g:javascript library="jquery/jquery-ui-1.8.10.custom.min" />
<jv:generateValidation domain="task" form="cardForm" useEmbeddedJquery="false"/> 
<div id="new_card" class="floating rounded hidden">
  <div align="right" id="new_card_close" class="clickable">x</div>
  <g:formRemote url="${[controller: 'task', action:'ajaxSave']}" name="cardForm" method="post" onComplete="updateCallback2(event)" before="if( validateForm( this ) ) { " after="}" beforeSend="return validateForm(this);">
    <g:hiddenField name="project" value="${task?task.project.id:project?.id}"/>
    <g:hiddenField name="id" value="${task?.id}"/>
    Title<br/>
    <g:textField name="title" value="${task?.title}"/>
    Description<br/>
    <g:textArea name="description" value="${task?.description}"/>
    Effort<br/>
    <g:textField name="effort" value="${task?.effort}"/>
    Status<br/>
    <g:select name="status"
    from="${TaskStatus.list()}"
    value="${task?.status?.id?:TaskStatus.defaultStatus.id}"
    optionKey="id" />
    <input type="submit" value="Save" id="save"/>
  </g:formRemote>
</div>
