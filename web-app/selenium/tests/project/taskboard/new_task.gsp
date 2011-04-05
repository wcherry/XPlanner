<sel:test name="edit task">
  <sel:row command="open" target="${request.contextPath}/project/taskBoard/1"/>
  <sel:row line="waitForVisible|id=4" />
  <sel:row line="assertNotVisible|id=new_card"/>
  <sel:row line="doubleClick|//li[@id='4']/div"/>
  <sel:row line="pause|3000"/>
  <sel:row line="verifyElementPresent|id=new_card"/>
  <sel:row line="assertVisible|id=new_card"/>
  <sel:row line="click|id=new_card_close" />
  <sel:row line="assertNotVisible|id=new_card" />
  <sel:row line="click|id=new" />
  <sel:row line="assertVisible|id=new_card"/>
  <sel:row line="verifyValue|id=title|"/>
  <sel:row line="verifyValue|id=description|"/>
  <sel:row line="verifyValue|id=effort|"/>
</sel:test>
