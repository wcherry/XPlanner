package org.sss.xplanner

class Project {
  String title
  String description

  static hasMany = [tasks: Task]
  static constraints = {
    title()
    description(maxSize: 2048)
  }
  
  String toString(){
    title
  }
}
