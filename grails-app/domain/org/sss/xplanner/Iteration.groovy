package org.sss.xplanner
import java.util.Date

class Iteration {
  Integer iterationNumber = 0
  Date startDate
  Date endDate
  String description = ""

  static belongsTo = [project: Project]
  static hasMany = [stories: UserStory]
  
  static constraints = {
  }

  @Override
  String toString(){
    "$iterationNumber"
  }
}
