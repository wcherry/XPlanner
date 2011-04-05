<sel:test name="move task back">
  <sel:row command="open" target="${request.contextPath}/project/taskBoard/1"/>
  <sel:row line="waitForVisible|id=4" />
  <sel:row line="dragAndDropToObject|id=4|id=sortable1"/>
  <sel:row line="verifyElementPresent|xpath=//ul[@id='sortable1']/li[@id='4']"/>
  <sel:row line="verifyElementNotPresent|xpath=//ul[@id='sortable2']/li[@id='4']"/>
</sel:test>
