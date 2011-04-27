import grails.util.Environment
import org.sss.xplanner.*

class BootStrap {
  def springSecurityService

  def init = { servletContext ->
    switch (Environment.current) {
      case Environment.DEVELOPMENT:
        def owner = createSecurity()
        createModel(true, owner)
      break;

      case Environment.TEST:
        createSecurity()
        createModel(false)
      break;
    }
  }
  def destroy = {
  }
  

  // These methods create security and model data for testing purposes
  private createSecurity(){
    def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
    def userRole = new Role(authority: 'ROLE_USER').save(flush: true)
    String password = springSecurityService.encodePassword('password')
    def admin = new User(username: "admin", enabled: true, password: password).save()
    UserRole.create(admin, adminRole, true)
    UserRole.create(admin, userRole, true)
    def guest = new User(username: "guest", enabled: true, password: password).save()
    UserRole.create(guest, userRole, true)
    return guest
  }

  private createModel(createData, owner=null){
    new Status(name: "Unassigned", sequence: 0,description: "Unassigned").save()
    new Status(name: "In Progress", sequence: 1,description: "na").save()
    new Status(name: "Completed",sequence: 2,description: "na").save()
    new Status(name: "Postponed",sequence: 3,description: "na").save()
    new Status(name: "Canceled",sequence: 4,description: "na").save()

    // By default, we assign the creator to be our guest user.
    if(createData){
      def p = new Project(title: "Default", description: "Default").save()
      p.addToStories(new UserStory(creator: owner, title: "Title #1", effort: 1, iteration: 0, status: Status.defaultStatus))
      p.addToStories(new UserStory(creator: owner, title: "Title #2", effort: 1, iteration: 0, status: Status.defaultStatus))
      p.addToStories(new UserStory(creator: owner, title: "Title #3", effort: 1, iteration: 0, status: Status.defaultStatus))
      p.addToStories(new UserStory(creator: owner, title: "Title #4", effort: 1, iteration: 0, status: Status.defaultStatus))
      p.addToStories(new UserStory(creator: owner, title: "Title #5", effort: 1, iteration: 0, status: Status.defaultStatus))
      p.save()
    }
  }
}
