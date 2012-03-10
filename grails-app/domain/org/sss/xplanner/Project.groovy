package org.sss.xplanner

class Project {
  String title
  String description
  transient Iteration currentIteration
  int maxIteration = 0

  static transients = ['currentIteration']

  static hasMany = [iterations: Iteration,users: User]

  static mappedBy = [workers:"worker"]
  
  static constraints = {
    title()
    description(maxSize: 2048)
  }
  @Override
  String toString(){
    title
  }
  
  def isUserAssignedToProject(user){
    users.contains(user)
  }
  def currentIteration(){
    if(!currentIteration){
      currentIteration = calcCurrentIteration()
    }
    return currentIteration
  }
  
  def calcCurrentIteration(){
    def currentDate = new java.util.Date()
    iterations.find {it.startDate <= currentDate && it.endDate >= currentDate}
  }
  
  def getMaxIteration(){
    if(maxIteration == 0)
      calcMaxIteration()
    maxIteration      
  }

  def calcMaxIteration(){
    def c = Iteration.createCriteria()
    def pid =  id

    maxIteration = c.get {
      eq("project", this)
	    projections {
		    max "iterationNumber"
	    }
    }
  }
}
