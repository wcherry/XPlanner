<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
    </head>
    <body>
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
        </div>
        <div id="grailsLogo"><a href="/"><img src="${resource(dir:'images',file:'xplanner_logo.png')}" alt="XPlanner" border="0" /></a></div>
        <g:layoutBody />
        <div class="footer">
        <hr/>
        <small><i>${org.codehaus.groovy.grails.commons.ApplicationHolder.application.metadata['app.name']} version ${org.codehaus.groovy.grails.commons.ApplicationHolder.application.metadata['app.version']} running on Grails v${org.codehaus.groovy.grails.commons.ApplicationHolder.application.metadata['app.grails.version']}</i></small>
        </div>
    </body>
</html>