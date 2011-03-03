package org.sss.xplanner

class ProjectController {
  static scaffold = true
 
  def taskBoard = {
    [tasks: Project.get(params.id).tasks]  
  }
}
