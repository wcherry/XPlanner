<sel:test name="edit task">
  <g:set var="title" value="${org.sss.xplanner.Task.get(4).title}"/>
  <sel:row command="open" target="${request.contextPath}/project/taskBoard/1"/>
  <sel:row line="waitForVisible|id=4" />
  <sel:row line="assertNotVisible|id=new_card"/>
  <sel:row line="doubleClick|//li[@id='4']/div"/>
  <sel:row line="pause|3000"/>
  <sel:row line="verifyElementPresent|id=new_card"/>
  <sel:row line="assertVisible|id=new_card"/>
  <sel:row line="echo|${title}" />
  <sel:row line="verifyValue|id=title|exact:${title}"/>
</sel:test>
