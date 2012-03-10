<html>
  <head>
    <title>Welcome to XPlanner</title>
    <meta name="layout" content="main" />
  </head>
  <body>
    <div class="message"><h2>What is XPlanner?</h2>
      XPlanner is an eXtreme Programming planning tool that makes keeping track of the artifacts
      of a project easy and then gets out of the way.<br/> XPlanner offers the following tools to
      help make your next XP project eaiser and leaner.<br/>
      Task Board - The task board is used to keep track of any existing tasks and assign them to
      an iteration.
    </div>
    <ul class="dialog" style="margin-left:20px;width:60%;height:90%">
      <li><g:link controller='project' action='storyBoard' id="1">View Story Board</g:link></li>
      <li><g:link controller='project' action='create'>Create new Project</g:link></li>
      <li><g:link controller='project' action='list'>List current projects</g:link></li>
      <sec:ifNotLoggedIn>
        <li><g:link controller='login' action='auth'>Login</g:link></li>
      </sec:ifNotLoggedIn>
      <g:each var="c" in="${grailsApplication.controllerClasses}">
        <li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
      </g:each>
    </ul>
        
  </body>
</html>
