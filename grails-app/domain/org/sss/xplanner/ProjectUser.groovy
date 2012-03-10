package org.sss.xplanner

class ProjectUser {
  Project project
  User user
  private String _responsibilities
  transient String[] responsibilities

  def onLoad = {
    responsibilities = _responsibilities.split(";")
  }
  
  def beforeInsert = {
    _responsibilities = responsibilities.join(";")
  }
  
  def beforeUpdate = {
    _responsibilities = responsibilities.join(";")
  }
}
   
  