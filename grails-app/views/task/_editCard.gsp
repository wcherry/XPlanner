<%@ page import="org.sss.xplanner.*" %>
<jv:generateValidation domain="task" form="cardForm"/> 
<div id="new_card" class="floating rounded hidden">
  <div align="right" id="new_card_close" class="clickable">x</div>
  <g:formRemote url="${[controller: 'task', action:'ajaxSave']}" name="cardForm" method="post" onComplete="updateCallback2(event)" before="if( validateForm( this ) ) { " after="}" beforeSend="return validateForm(this);">
    <g:hiddenField name="project" value="${task?task.project.id:project?.id}"/>
    <g:hiddenField name="taskid" value="${task?.id}"/>
    <g:hiddenField name="iteration" value="${task?task.iteration:0}"/> <%-- Workaround to js validaton bug --%>
    <g:hiddenField name="displayPosition" value="${task?task.displayPosition:999}"/> <%-- Workaround to js validaton bug --%>
    Title<br/>
    <g:textField label="Title" name="title" value="${task?.title}"/>
    Description<br/>
    <g:textArea name="description" value="${task?.description}"/>
    Effort<br/>
    <g:textField name="effort" value="${task?.effort}"/>
    Status<br/>
    <g:select name="status"
    from="${TaskStatus.list()}"
    value="${task?.status?.sequence?:TaskStatus.defaultStatus.sequence}"
    optionKey="sequence" />
    <input type="submit" value="Add"/>
  </g:formRemote>
</div>
