<%@ page import="org.sss.xplanner.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
    <g:javascript library="jquery" />
    <g:javascript library="jquery/jquery-ui-1.8.10.custom.min" />

<g:javascript>
  function showSpinner(visible){
    $('spinner').show(visible); // .style.display= visible?"inline":"none";
  }
      
  function log(msg){
    $('#console').html($('#console').html()+"</br>"+msg);//.autoscroll();
  }

  function updateCallback(e){
    log("Call back "+e.status);
  }
  
  function loadTasksForIteration(el, iter){
    var params = {project: "${project.id}", iteration: iter};
    $(el).load('/XPlanner/task/ajaxLoadProjectIterationTasks',params, updateCallback);
  }
  
  function updateTaskPositions(){
    log("#sortable1");
    var params = new Object();
    var it = $("#sortable1").attr("data-iteration");
    $( "#sortable1" ).children().each(function(i,el){
      text = $(el).find("div div").text();
      log("Note Id#"+el.id+" is at index "+i+" title "+text);
      params['taskId_'+it+"_"+i] = el.id;
      });
    log("#sortable2");
    it = $("#sortable2").attr("data-iteration");
    $( "#sortable2" ).children().each(function(i,el){
      text = $(el).find("div div").text();
      log("Note Id#"+el.id+" is at index "+i+" title "+text);
      params['taskId_'+it+"_"+i] = el.id;
      });
      
            
    $.post('/XPlanner/task/ajaxUpdateTaskPositions',params, updateCallback);

  }
      
  function previousIteration(id){
    log("Previous Iteration");
    loadTasksForIteration($("#sortable2"), $("#sortable2").attr("data-iteration")-1)
  }
      
  function nextIteration(){
    log("Next Iteration");
    loadTasksForIteration($("#sortable2"), $("#sortable2").attr("data-iteration")+1)
  }
      
  $(function() {
    $('#postId').click(function(){showForm(true);});
  	$( "#sortable1, #sortable2" ).sortable({
      connectWith: ".connectedSortable2"
      }).disableSelection();
    $( "#sortable1, #sortable2" ).droppable({
  		  drop: function( event, ui ) {
          //text = ui.draggable.attr('id');
          //pos = $(this).index(ui.draggable);
          //pos = $(ui.draggable).index();
          
          //log("dropped "+text+" on "+this.id+" at "+pos);
          return true;
	      }
    });
    $(".notecard").dblclick(function(){
      log("Double Click");
      });
    loadTasksForIteration($("#sortable1"), 0);
    loadTasksForIteration($("#sortable2"), $("#sortable2").attr("data-iteration"))
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
<tr><td class="list-header" width="500">Unassigned</td><td class="list-header" width="500"><span id="prev_it" class="clickable" onclick="previousIteration()">&lt;&lt;&nbsp;</span>Iteration 1 (Current)<span id="next_it" class="clickable" onclick="nextIteration()">&gt;&gt;&nbsp;</span></td></tr>
<tr valign="top"><td height="500">
<ul id="sortable1" class="connectedSortable2" data-iteration="0">
</ul>
</td><td>
<ul id="sortable2" class="connectedSortable2" data-iteration="1">
</ul>
</td></tr>
</table>
          
    </body>
</html>
