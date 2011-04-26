<%@ page import="org.sss.xplanner.*" %>
<g:javascript library="jquery" />
<g:javascript library="jquery/jquery-ui-1.8.10.custom.min" />
<jv:generateValidation domain="userStory" form="cardForm" useEmbeddedJquery="false"/> 
<div id="new_card" class="floating rounded hidden">
  <div align="right" id="new_card_close" class="clickable">x</div>
  <g:formRemote url="${[controller: 'userStory', action:'ajaxSave']}" name="cardForm" method="post" onComplete="updateCallback2(event)" before="if( validateForm( this ) ) { " after="}" beforeSend="return validateForm(this);">
    <g:hiddenField name="project" value="${story?story.project.id:project?.id}"/>
    <g:hiddenField name="id" value="${story?.id}"/>
    Title<br/>
    <g:textField name="title" value="${story?.title}"/>
    Description<br/>
    <g:textArea name="description" value="${story?.description}"/>
    Effort<br/>
    <g:textField name="effort" value="${story?.effort}"/>
    Status<br/>
    <g:select name="status"
    from="${Status.list()}"
    value="${story?.status?.id?:Status.defaultStatus.id}"
    optionKey="id" />
    <input type="submit" value="Save" id="save"/>
  </g:formRemote>
</div>
