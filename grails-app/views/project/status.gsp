<%@ page import="org.sss.xplanner.*" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="layout" content="main" />
  
    <g:javascript library="jquery" />
    <g:javascript library="jquery/jquery-ui-1.8.10.custom.min" />
    <g:javascript>
      function showSpinner(visible){
        $('#spinner').show(visible); 
      }
    
      function log(msg){
        $('#console').html($('#console').html()+"</br>"+msg).scrollTop(9999999);
      }

      $(function()) {
      }
    </g:javascript>

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
      <h1>${project.title}</h1>
      <p>${project.description}</p>
      <g:each var="user" in="${project.users}">
        ${user.type}: ${user.username}</br>
      </g:each>
    </div>
  </body>
</html>
