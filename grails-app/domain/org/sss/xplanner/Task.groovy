package org.sss.xplanner
  
class Task {
  String title
  String description
  Date dateCreated
  Date lastUpdated
  BigDecimal effort
  Date dateStarted
  TaskStatus status
  User assignee
  User creator
  int iteration = 0
  int displayPosition  = 999// this is currently only used as a display setting

  static mapping = { sort displayPosition:"asc"}
  static belongsTo = [project: Project]
  static constraints = {
    title(blank: false)
    description(nullable: true, maxSize: 2048)
    effort(range: 1..14)
    status(nullable: true)
    assignee(nullable: true)
    creator(nullable: true)
    iteration(nullable: true, range: 0..26)
    displayPosition(nullable: true, blank: true)
    lastUpdated(display: true, nullable: true)
    dateCreated(display: true, nullable: true)
    dateStarted(display: true, nullable: true)
  }
}
