<sel:test name="save new task">
  <sel:row command="open" target="${request.contextPath}/project/taskBoard/1"/>
  <sel:row line="waitForVisible|id=4" />
  <sel:row line="click|id=new" />
  <sel:row line="assertVisible|id=new_card"/>
  <sel:row line="verifyValue|id=title|"/>
  <sel:row line="verifyValue|id=description|"/>
  <sel:row line="verifyValue|id=effort|"/>

  <sel:row line="type|id=title|Save new task test"/>
  <sel:row line="type|id=description|This tests saving a new task"/>
  <sel:row line="type|id=effort|1"/>
  <sel:row line="click|id=save" />
  <sel:row line="pause|2000" />
  <sel:row line="verifyElementPresent|xpath=//ul[@id='sortable1']/li[@id='6']"/>
</sel:test>
