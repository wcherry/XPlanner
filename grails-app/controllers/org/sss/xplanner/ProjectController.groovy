package org.sss.xplanner

class ProjectController {
  static scaffold = true
 
  def storyBoard = {
    def p = Project.get(params.id)
    [project: p]  
  }
}
