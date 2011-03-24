<%@ page import="org.sss.xplanner.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
    <g:javascript library="jquery" />
    <g:javascript library="jquery/jquery-ui-1.8.10.custom.min" />

<g:javascript>
  function showSpinner(visible){
    $('spinner').show(visible); 
  }
      
  function log(msg){
    $('#console').html($('#console').html()+"</br>"+msg);
  }

  function updateCallback(e, status){
    log("Call back "+status);
  }
  
  function loadTasksForIteration(el, direction){
    str = Number($(el).attr("data-iteration"));
    log("Iteration "+str);
    iter = Number($(el).attr("data-iteration")) + direction;
    params = {project: "${project.id}", iteration: iter};
    $(el).load('/XPlanner/task/ajaxLoadProjectIterationTasks',params, updateCallback);

    //
    //TODO: This code should be moved into the callback. If we are unable to get the iteration requested then there will be a mismatch.
    //
    $(el).attr("data-iteration", iter);

    //
    //TODO: Currently the table headers and the sortable list are not tied together. If we add addtional list then this code will break.
    //
    $('#iter_number').text(""+iter);    
    if(iter == ${project.currentIteration}){
      $('#current_id').text("(Current)");
    } else {
      $('#current_id').text("");
    }
  }
  
  function updateTaskPositions(){
    params = new Object();
    //
    //TODO: If we add addtional list then this code will break. Should grab ALL sortable list.
    //
    it = $("#sortable1").attr("data-iteration");
    $( "#sortable1" ).children().each(function(i,el){ params['taskId_'+it+"_"+i] = el.id; });
    it = $("#sortable2").attr("data-iteration");
    $( "#sortable2" ).children().each(function(i,el){ params['taskId_'+it+"_"+i] = el.id; });

    $.post('/XPlanner/task/ajaxUpdateTaskPositions',params, updateCallback);
  }
  
  function clearTasks(id){
    //
    //TODO: Just log that we would like to clear the list.
    //
    log("Clearing tasks for list "+id);
  }
      
  function prevIteration(id){
    //
    //TODO: This code should check the current iteration and not allow for the selection of
    // iterations less then 1. Code should be added to disable the display of the prev button
    // if the user is currently on iteration 1.
    //
    log("Previous Iteration");
    clearTasks(id);
    loadTasksForIteration($(id),-1);
  }
      
  function nextIteration(id){
    //
    //TODO: This code should check the current iteration and not allow for the selection of
    // iterations greater then the Max iteration number. Code should be added to disable the 
    // display of the next button if the user is currently on the last iteration.
    //
    log("Next Iteration");
    clearTasks($(id));
    loadTasksForIteration($(id),+1);
  }
      
  $(function() {
    $('#postId').click(function(){showForm(true);});
  	$( "#sortable1, #sortable2" ).sortable({
      connectWith: ".connectedSortable2"
      }).disableSelection().droppable();
    $(".notecard").dblclick(function(){
      log("Double Click");
      });
    loadTasksForIteration("#sortable1", 0);
    loadTasksForIteration("#sortable2", 0);
    $("#prev_it").click(function(){prevIteration('#sortable2');});
    $("#next_it").click(function(){nextIteration('#sortable2');});
    });
</g:javascript>
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
<div id="console" class="console">
Logging...
</div>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
        <input type="button" onClick="updateTaskPositions();" value="Update"/>
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>

<table valign="top" width="1020">
<tr>
  <td class="list-header" width="500">Unassigned</td>
  <td class="list-header" width="500"><span id="prev_it" class="clickable">&lt;&lt;&nbsp;</span>
  Iteration <span id="iter_number">1</span> <span id="current_id">(Current)</span><span id="next_it" class="clickable">&gt;&gt;&nbsp;</span></td></tr>
<tr valign="top"><td height="500">
<ul id="sortable1" class="connectedSortable2" data-iteration="0">
</ul>
</td><td>
<ul id="sortable2" class="connectedSortable2" data-iteration="${project.currentIteration}">
</ul>
</td></tr>
</table>
          
    </body>
</html>
