package org.sss.xplanner

class TaskStatus {
  static defaultStatus
  String name
  int sequence
  String description

  static constraints = {
    name()
    sequence(range: 0..100)
    description(maxSize: 255)
  }

  static TaskStatus getDefaultStatus(){
    if(defaultStatus==null){
      defaultStatus = TaskStatus.findBySequence(0)
    }
    return defaultStatus
  }
    
   String toString(){
    name
  }
}
