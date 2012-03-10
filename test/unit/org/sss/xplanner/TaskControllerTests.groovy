package org.sss.xplanner

import grails.test.*

class TaskControllerTests extends ControllerUnitTestCase {
    protected void setUp() {
        super.setUp()
    }

    protected void tearDown() {
        super.tearDown()
    }

    void testAjaxLoadProjectIterationTasks() {
      controller.params.project = 1L
      controller.params.iteration = 0;
      controller.ajaxLoadProjectIterationTasks()
      println controller.response.contentAsString
    }
    
    
}
