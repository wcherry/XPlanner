package org.sss.xplanner

class Project {
  String title
  String description
  int currentIteration = 1

  static hasMany = [stories: UserStory]
  static constraints = {
    title()
    description(maxSize: 2048)
  }
  
  String toString(){
    title
  }
}
