<%@ page import="org.sss.xplanner.*" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  
    <title>Project ${project}</title>
  </head>
  <body>
    <sec:ifLoggedIn>
      Logged in as <sec:loggedInUserInfo field="username"/> <i>(<g:link controller='logout'>logout</g:link>)</i><br/>
    </sec:ifLoggedIn>
    <sec:ifNotLoggedIn>
      <g:link controller='login' action='auth'>Login</g:link>
    </sec:ifNotLoggedIn>
    
    <div id="console" class="console">
      Logging...
    </div>
    <div class="body">
    <div class="button_bar">
<!--      <input type="button" id="show_effort" onClick="sumEfforts($('#sortable2'));" value="Effort"/>-->
      <input type="image" id="new" onClick="displayNewCard();" src="${resource(dir:'images',file:'new.png')}"/>
      <input type="image" id="update" onClick="updateTaskPositions();" src="${resource(dir:'images',file:'refresh.png')}"/>  
      </div>
      <div id="message"></div>
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
            <ul id="sortable1" data-iteration="0"/>
          </td>
          <td>
            <ul id="sortable2" data-iteration="${project.currentIteration()}"/>
          </td>
        </tr>
      </table>
    </div>
    <div id="new_card_container">
    <g:render template="../userStory/editableStoryCard"/>
    </div>
    <g:javascript library="jquery" />
    <g:javascript library="jquery/jquery-ui-1.8.10.custom.min" />

  <g:javascript>
      function showSpinner(visible){
        if(visible) $('#spinner').show(); else $('#spinner').hide();
      }
    
      function log(msg){
        $('#console').html($('#console').html()+"</br>"+msg).scrollTop(9999999);
      }

    log("Project max iterations: ${project.maxIteration}");
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
        el.load('/XPlanner/userStory/ajaxGetAllByProjectAndIteration',params, function(event, status){
          showSpinner(false);
          log("Call back "+status);
          if(status == 'error'){
            alert(event);
          }
          sumEfforts($("#sortable2"));
        });
        
        //
        //TODO: This code should be moved into the callback. If we are unable to get the iteration requested then there will be a mismatch.
        //
        el.attr("data-iteration", iter);
        
        //
        //TODO: Currently the table headers and the sortable list are not tied together. If we add additional list then this code will break.
        //
        if(el.attr("id")=="sortable2"){
          $('#iter_number').text(""+iter);    
          if(iter == ${project.currentIteration()}){
            $('#current_id').text("(Current)");
            } else {
            $('#current_id').text("");
          }
        }
      }

      function updateTaskPositions(event, ui){
        var list = $(ui.item).parent();
        log("Updating list..."+list.attr('id'));
        showSpinner(true);
        
        params = new Object();
        params.timeout = 10000;
        //
        //TODO: If we add addtional list then this code will break. Should grab ALL sortable list.
        //
        params.project = ${project.id}
        it = list.attr("data-iteration");
        list.children().each(function(i,el){ params['storyId_'+it+"_"+i] = el.id; });
        
        $.post('/XPlanner/userStory/ajaxUpdatePriority',params)
          .success(function(data){
            alert("Success:"+data);
            if(list.attr('id')!='sortable1') sumEfforts(list);
          })
          .error(function(data){alert(data.statusText+":"+data.responseText);})
          .complete(function(data){showSpinner(false);})
        log("Done updating list..."+list.attr('id'));
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
        $("#status").val("${Status.defaultStatus.id}");
        $("#new_card").show();
      }
      
      function hideNewCard(){
        $("#new_card").hide();
      }
      
      function displayEditCard(id){
        log("Calling displayEditCard with argument "+id);
        params = {story: id};
        $("#new_card_container").load('/XPlanner/userStory/ajaxLoad',params, function(event, status) {
          showSpinner(false);
          log("Call back "+status);
          if(status == 'error'){
            alert(event);
          } else {
            $("#new_card").offset({top: $(window).height()/2-100, left: $(window).width()/2-100}).show();
          }
        });
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
        $.post('/XPlanner/task/ajaxMarkTaskDeleted',params, function(event, status){
          log("Task deleted "+status); 
          updateLists();
          if(event.deleted){
            $("#message").stop(true).addClass("clickable").bind("click", function(){
              id = $(this).attr("data-id");
              deleteCard(id, "undelete")});        
            $("#message").attr("data-id", event.id).text("Undelete task "+event.title).effect("highlight", {}, 3000).delay(18000).fadeOut(3000);
            } else {
            $("#message").unbind("click").stop(true).attr("data-id", 0).text("Task "+event.title+" undeleted").effect("highlight", {}, 3000).delay(4000).fadeOut(3000);
          } 
        });
      }

      function resizeFrame() 
      {
        var h = $(window).height();
        var w = $(window).width();
        $("#sortable1, #sortable2").css('height',(h < 1024 || w < 768) ? 500 : 400);
      }
          
      $(function() {
    log("Ready to run bootstrap...");
<sec:ifAllGranted roles="ROLE_USER">
        $.ajaxSetup({timeout: 1000});
        $('#postId').click(function(){showForm(true);});
        
        $( "#sortable1, #sortable2" ).addClass("connectedSortable");
      	$( "#sortable2" ).sortable({
          connectWith: ".connectedSortable",
          update: function(event, ui){updateTaskPositions(event, ui);}
          }).disableSelection().droppable();

      	$( "#sortable1" ).sortable({
          connectWith: ".connectedSortable"
          
          }).disableSelection().droppable();



        $.event.add(window, "load", resizeFrame);
        $.event.add(window, "resize", resizeFrame);
//    log("Project max iterations: ${project.maxIteration}");
        $(".notecard").live("dblclick", function(){
            id = $(this).parent().attr("id");
            log("Double Click: "+id);
            displayEditCard(id);
          });
        $("#new_card").offset({top: $(window).height()/2-100, left: $(window).width()/2-100});//top(400).left(400);
        $("#new_card_close").live("click", function(){
          $(this).parent().hide();
        });
        $(".delete_card").live("click", function(){
          id = $(this).closest(".ui-state-default").attr("id");
          deleteCard(id, "delete");
          });
</sec:ifAllGranted>          
        loadTasksForIteration($("#sortable1"), 0);
        loadTasksForIteration($("#sortable2"), 0);
        $("#prev_it").click(function(){prevIteration('#sortable2');});
        $("#next_it").click(function(){nextIteration('#sortable2');});
          
      });
    </g:javascript>
  </body>
</html>
