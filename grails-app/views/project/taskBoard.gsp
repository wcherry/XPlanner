<%@ page import="org.sss.xplanner.Project" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
    <g:javascript library="jquery" />
    <g:javascript library="jquery/jquery-ui-1.8.10.custom.min" />

<g:javascript>
    
      function completed(){
        clearPost();
        showSpinner(false);
        showForm(false);
      }
      function clearPost(){
        $('caption').value ='';
        $('body').value='';
      }
      function showError(e){
        $('errorMsg').append(e)
      }
      
      function showSpinner(visible){
        $('spinner').show(visible); // .style.display= visible?"inline":"none";
      }
      
      function showForm(visible){
        if(visible)
          $('.postForm').slideDown("slow");
        else
          $('.postForm').slideUp("slow");
      }
      
      $(function() {
        $('#postId').click(function(){showForm(true);});
      	$( "#sortable1, #sortable2" ).sortable({connectWith: ".connectedSortable2"}).disableSelection();
        $( "#sortable1, #sortable2" ).droppable({
      		  drop: function( event, ui ) {
			  	    //text = ui.draggable[0].children[0].item[0].id;
              text = ui.draggable.attr('id');
              $('#console').html("dropped "+text+" on "+this.id+"</br>"+$('#console').html());
              return true;
			      }
		    });
      });
    </g:javascript>
        <g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>

<table valign="top" width="1020">
<tr><td class="list-header" width="500">Unassigned</td><td class="list-header" width="500">Iteration 1 (Current)</td></tr>
<tr valign="top"><td height="500">
<ul id="sortable1" class="connectedSortable2" >
            <g:each in="${tasks}" status="i" var="task">
            <li class="ui-state-default" id="${task.id}">			
        		<div class="notecard shadow" >
			        <div>${task.title}</div>
			        <hr/>
              <div>${task.description}</div>
        		</div>
	          </li>
            </g:each>
</ul>
</td><td>
<ul id="sortable2" class="connectedSortable2">
</ul>
</td></tr>
</table>
            
<div id="console" class="console">
Logging...<br>
</div>
    </body>
</html>
