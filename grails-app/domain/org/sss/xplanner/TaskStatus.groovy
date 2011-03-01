package org.sss.xplanner

class TaskStatus {
  String name
  int sequence
  String description

  static constraints = {
    name()
    sequence(range: 0..100)
    description(maxSize: 255)
  }

   String toString(){
    name
  }
}
