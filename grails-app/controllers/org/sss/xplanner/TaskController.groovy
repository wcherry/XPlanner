package org.sss.xplanner

class TaskController {
  static scaffold = true

  def ajaxLoadTask = {
    def task = Task.get(params.task.toLong())
    render(template: "editCard", bean: task, var: 'task')
  }

  
  def ajaxSave = {
    println "Task:ajaxSave: $params"
    def task = null
    params.project = Project.get(params.project)
    params.status = TaskStatus.get(params.status)
    if(params.id){
      task = Task.get(params.id)
    } else {
      task = new Task()
    }
    task.properties = params
    task.save()
    if(task.hasErrors()){
      response.status = 500
      render(task.errors)
    } else render("task saved successfully")

  }
  def ajaxUpdateTaskPositions = {
    params.each {key, value->
      if(key.startsWith('task')){
        def (dummy, iter, pos) = key.split('_')
        def task = Task.get(value.toLong())
        task.iteration = iter.toInteger()
        task.displayPosition = pos.toInteger()
        task.save()
        println task.errors
      }
    }
    render("updated all tasks successfully")
  }
  
  def ajaxLoadProjectIterationTasks = {
    def allErrors = []
    def project, tasks
    if((project = Project.get(params.project.toLong()))){
      tasks = Task.findAllByProjectAndIteration(project, params.iteration.toInteger(),[max:30, sort:'displayPosition',order:'asc'])
      render(template: "taskCard", collection: tasks, var: 'task')
      } else {
        allErrors << "Unable to load project for id ${params.project}"
      }
      if(allErrors){
        response.status = 500
        render(allErrors)
      }
    }
}
