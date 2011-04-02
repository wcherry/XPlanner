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
  static mapping = {
    sort sequence:'asc'
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
  
  def compareTo(other){
    name.compareTo(other.toString())
  }
  
  boolean equals(other){
    boolean x = compareTo(other) == 0
    println "Comparing $this to $other: $x"
    return x
  }
}
