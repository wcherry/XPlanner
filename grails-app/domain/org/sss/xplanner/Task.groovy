package org.sss.xplanner

class Task {
  String title
  String description
  Date dateCreated
  Date dateModified
  BigDecimal effort
  Date dateStarted
  TaskStatus status
  User assignee
  User creator
  int iteration

  static belongsTo = [project: Project]
  static constraints = {
    title(blank: false)
    description(maxSize: 2048)
    effort(range: 1..14)
    status()
    assignee()
    iteration(range: 0..26)
    dateModified(display: false)
    dateCreated(display: false)
    dateStarted(display: false)
  }
}
