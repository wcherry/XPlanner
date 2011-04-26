package org.sss.xplanner

import grails.converters.JSON

class UserStoryController {
  static scaffold = true

  def ajaxLoad = {
    def story = Task.get(params.story.toLong())
    render(template: "editableStoryCard", bean: story, var: 'story')
  }

  def ajaxSave = {
    def story = null
    params.project = Project.get(params.project)
    params.status = Status.get(params.status)
    if(params.id){
      story = UserStory.get(params.id)
    } else {
      story = new UserStory()
    }
    story.properties = params
    story.save()
    if(story.hasErrors()){
      response.status = 500
      render(story.errors)
    } else render("User story saved successfully")

  }
  def ajaxUpdatePriority = {
    params.each {key, value->
      if(key.startsWith('story')){
        def (dummy, iter, pri) = key.split('_')
        def story = UserStory.get(value.toLong())
        story.iteration = iter.toInteger()
        story.priority = pri.toInteger()
        story.save()
      }
    }
    render("updated all user stories successfully")
  }
  
  def ajaxGetAllByProjectAndIteration = {
    def allErrors = []
    def project
    if((project = Project.get(params.project.toLong()))){
      def stories = UserStory.findAll("from UserStory where project=:project and iteration=:iteration and deleted=false",
        [project: project, iteration: params.iteration.toInteger()],[max:30, sort:'priority',order:'asc'])
      render(template: "summaryStoryCard", collection: stories, var: 'story')
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
