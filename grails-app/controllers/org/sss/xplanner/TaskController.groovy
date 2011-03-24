package org.sss.xplanner

class TaskController {
  static scaffold = true

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
      [status: "OK"]
    }
    
    def ajaxLoadProjectIterationTasks = {
        render(template: "taskCard", collection: Task.findAllByIteration(params.iteration.toInteger(),
        [max:30, sort:'displayPosition',order:'asc']), var: 'task')
    }
    
}
