package org.sss.xplanner

class ProjectController {
  static scaffold = true
 
  def taskBoard = {
    def p = Project.get(params.id)
    [project: p, tasks: p.tasks]  
  }
}
