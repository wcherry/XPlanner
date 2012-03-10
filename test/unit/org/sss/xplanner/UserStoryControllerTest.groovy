class PostControllerUnitTests extends grails.test.ControllerUnitTestCase {
    void testAjaxUpdatePriority() {
      def p = this.controller.params
      p."storyId_0_1" = "3"
      
      mockDomain(User, [
                new User(userId: "glen"),
                new User(userId: "peter") ]
        this.controller.params.id = "peter"
        def model = this.controller.show()
        assertEquals "peter", model["viewUser"]?.userId
    }
}

