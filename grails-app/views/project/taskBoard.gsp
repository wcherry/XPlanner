<%@ page import="org.sss.xplanner.*" %>
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
        $('#console').html($('#console').html()+"</br>"+msg).scrollTop(9999999);
      }
      
      function updateCallback(e, status){
        showSpinner(false);
        log("Call back "+status);
        if(status == 'error'){
          alert(e);
        }
        sumEfforts($("#sortable2"));

      }
      
      function updateCallback2(e, obj){
        showSpinner(false);
        log("Call back "+e.status);
        if(status == 'error'){
          alert(e);
        }
        hideNewCard();
        loadTasksForIteration($("#sortable1"), 0);
      }
      
      function loadTasksForIteration(el, direction){
        showSpinner(true);
        str = Number(el.attr("data-iteration"));
        log("Iteration "+str);
        iter = Number(el.attr("data-iteration")) + direction;
        params = {project: "${project.id}", iteration: iter};
        el.load('/XPlanner/task/ajaxLoadProjectIterationTasks',params, updateCallback);
        
        //
        //TODO: This code should be moved into the callback. If we are unable to get the iteration requested then there will be a mismatch.
        //
        el.attr("data-iteration", iter);
        
        //
        //TODO: Currently the table headers and the sortable list are not tied together. If we add addtional list then this code will break.
        //
        if(el.attr("id")=="sortable2"){
          $('#iter_number').text(""+iter);    
          if(iter == ${project.currentIteration}){
            $('#current_id').text("(Current)");
            } else {
            $('#current_id').text("");
          }
        }
      }
      
      function updateTaskPositions(){
        showSpinner(true);
        
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
      
      function displayNewCard(){
        //TODO: Clear Card
        $("#id").val("");
        $("#iteration").val("0");
        $("#displayPosition").val("999");
        $("#title").val("");
        $("#description").val("");
        $("#effort").val("");        
        $("#status").val("${TaskStatus.defaultStatus.id}");
        $("#new_card").show();
      }
      
      function hideNewCard(){
        $("#new_card").hide();
      }
      
      function editCallback(e, status){
        showSpinner(false);
        log("Call back "+status);
        if(status == 'error'){
          alert(e);
        } else 
          $("#new_card").offset({top: $(window).height()/2-100, left: $(window).width()/2-100}).show();
      }
      
      function displayEditCard(id){
        log("Calling displayEditCard with argument "+id);
        params = {task: id};
        $("#new_card_container").load('/XPlanner/task/ajaxLoadTask',params, editCallback);
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
      
      function updateLists(){
        loadTasksForIteration($("#sortable1"), 0);
        loadTasksForIteration($("#sortable2"), 0);
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
      
      function sumEfforts(list){
        total = 0;
        list.find(".notecard").each(function(index, el){total += Number($(el).attr("data-effort"))});
        //alert("Total effort for "+list.attr('id')+" is "+total);
        $('#effort').text(total);
        
      }
      
      function deleteCard(id, action){
        log(action+"ing card with id "+id);
        params.id = id;
        params.deleteAction = action
        $.post('/XPlanner/task/ajaxMarkTaskDeleted',params, function(e,s){log("Task deleted "+s); updateLists();});
      }

      function resizeFrame() 
      {
        var h = $(window).height();
        var w = $(window).width();
        $("#sortable1, #sortable2").css('height',(h < 1024 || w < 768) ? 500 : 400);
      }
          
      $(function() {
        $('#postId').click(function(){showForm(true);});
      	$( "#sortable1, #sortable2" ).sortable({
          connectWith: ".connectedSortable2",
          update: function(event, ui){updateTaskPositions();}
          }).disableSelection().droppable();

        $.event.add(window, "load", resizeFrame);
        $.event.add(window, "resize", resizeFrame);
          
        $(".notecard").live("dblclick", function(){
            id = $(this).parent().attr("id");
            log("Double Click: "+id);
            displayEditCard(id);
          });
        loadTasksForIteration($("#sortable1"), 0);
        loadTasksForIteration($("#sortable2"), 0);
        $("#prev_it").click(function(){prevIteration('#sortable2');});
        $("#next_it").click(function(){nextIteration('#sortable2');});
        $("#new_card").offset({top: $(window).height()/2-100, left: $(window).width()/2-100});//top(400).left(400);
        $("#new_card_close").live("click", function(){
          $(this).parent().hide();
        });
        $(".delete_card").live("click", function(){
          id = $(this).closest(".ui-state-default").attr("id");
          deleteCard(id, "delete");
          });
      });
    </g:javascript>
    <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
  </head>
  <body>
    <div id="console" class="console">
      Logging...
    </div>
    <div class="body">
      <input type="button" id="show_effort" onClick="sumEfforts($('#sortable2'));" value="Effort"/>
      <input type="button" id="update" onClick="updateTaskPositions();" value="Update"/>  
      <input type="button" id="new" onClick="displayNewCard();" value="New"/>
      <g:if test="${flash.message}">
        <div class="message">${flash.message}</div>
      </g:if>

      <table valign="top" width="1020">
      <tr>
          <td class="list-header" width="500">Unassigned</td>
          <td class="list-header" width="500"><span id="prev_it" class="clickable">&lt;&lt;&nbsp;</span>
            Iteration <span id="iter_number">1</span> <span id="current_id">(Current)</span><span id="effort"> </span>  <span id="next_it" class="clickable">&gt;&gt;&nbsp;</span></td>
        </tr>
        <tr valign="top">
          <td height="500">
            <ul id="sortable1" class="connectedSortable2" data-iteration="0"/>
          </td>
          <td>
            <ul id="sortable2" class="connectedSortable2" data-iteration="${project.currentIteration}"/>
          </td>
        </tr>
      </table>
    </div>
    <div id="new_card_container">
    <g:render template="../task/editCard"/>
    </div>
  </body>
</html>
