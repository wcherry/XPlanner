package org.sss.xplanner

import grails.converters.JSON

class UserStoryController {
  static scaffold = true

  def ajaxLoad = {
    println "Params for ajaxLoad $params"
    def story = UserStory.get(params.story.toLong())
    render(template: "editableStoryCard", bean: story, var: 'story')
  }

  def ajaxSave = {
    def story = null
    println params
    params.status = Status.get(params.status)
    if(params.id){
      story = UserStory.get(params.id)
      story.title = params.title
      story.description = params.description
      story.effort = new BigDecimal(params.effort)
      story.status = params.status
    } else {
      story = new UserStory(params)
      story.iteration = Iteration.findByProjectAndIterationNumber(Project.get(params.project), 0)
    }
    story.save()
    if(story.hasErrors()){
      response.status = 500
      render(story.errors)
    } else render("User story saved successfully")

  }
  def ajaxUpdatePriority = {
    if (!isLoggedIn()) {
      render(status: 401, text: "action not supported - user is not logged in")
      return
    }
    def project = Project.get(params.project.toLong())
    if(!project.isUserAssignedToProject(authenticatedUser)){
      render(status: 401, text: "user is not authorized to make this change")
      return
    }
    params.each {key, value->
      if(key.startsWith('story')){
        def (dummy, iter, pri) = key.split('_')
        def story = UserStory.get(value.toLong())
        def orgIt = story.iteration
        def iterationNumber = iter.toLong()
        def newIt = Iteration.findByProjectAndIterationNumber(project, iterationNumber)
        if(orgIt != newIt){
//        if(iter.toInt()!=story.iteration.iterationNumber.toInt()){
          println "Moving story $story from iteration $orgIt to iteration $newIt"
          orgIt.removeFromStories(story)
          newIt.addToStories(story)
          orgIt.save(true)
          newIt.save(true)
        }
        println "Changing story $story priority from ${story.priority} to $pri"
        story.priority = pri.toInteger()
        story.save(true)
      }
    }
    render(text: "updated all user stories successfully")
  }
  
  def ajaxGetAllByProjectAndIteration = {
    println "Params for ajaxGetAllByProjectAndIteration $params"
    def allErrors = []
    def project = null
    if((project = Project.get(params.project.toLong()))){
      def iterationNumber = params.iteration.toLong()
      def iteration = null
      if((iteration = Iteration.findByProjectAndIterationNumber(project, iterationNumber))){
          def stories = UserStory.findAllByIterationAndDeleted(iteration, false, [max:30, sort:'priority',order:'asc'])
          render(template: "summaryStoryCard", collection: stories, var: 'story')
          log.info "My Stories: $stories"
      } else {
            allErrors << "Unable to load iteration for iteration number ${params.iteration}"
        }
    } else {
      allErrors << "Unable to load project for id ${params.project}"
    }
    if(allErrors){
      response.status = 500
      render(allErrors)
    }
  }
  
  def ajaxMarkDeleted = {
    def story = UserStory.get(params.id)
    story.deleted = params.deleteAction =="delete" // undelete is the default action
    story.save(true)
    if(story.hasErrors()){
      response.status = 500
      render(story.errors)
    } else render story as JSON
  }
    
}
