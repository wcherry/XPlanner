package org.sss.xplanner
  
class UserStory {
  String title
  String description
  Date dateCreated
  Date lastUpdated
  BigDecimal effort
  Date dateStarted
  Status status
  User assignee
  User creator
  Integer iteration 
  Integer priority
  Boolean deleted = false

  static mapping = { sort priority:"asc"}
  static belongsTo = [project: Project]
  static constraints = {
    title(blank: false)
    effort(range: 1..14)
    status(nullable: true)
    iteration(nullable: true, range: 0..26)
    priority(nullable: true)
    assignee(nullable: true)
    creator(nullable: true)
    description(nullable: true, maxSize: 2048)
    lastUpdated(display: true, nullable: true)
    dateCreated(display: true, nullable: true)
    dateStarted(display: true, nullable: true)
    deleted(display: false, nullable: true)
  }
}
