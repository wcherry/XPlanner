import grails.util.Environment
import org.sss.xplanner.*

class BootStrap {

    def init = { servletContext ->
      switch (Environment.current) {
        case Environment.DEVELOPMENT:
          new Status(name: "Unassigned", sequence: 0,description: "Unassigned").save()
          new Status(name: "In Progress", sequence: 1,description: "na").save()
          new Status(name: "Completed",sequence: 2,description: "na").save()
          new Status(name: "Postponed",sequence: 3,description: "na").save()
          new Status(name: "Canceled",sequence: 4,description: "na").save()
          def u = new User(username: "admin").save()
          new User(username: "guest").save()
          
          User.metaClass.'static'.loggedOnUser = {
            return u
          }
          
          
          
          def p = new Project(title: "Default", description: "Default").save()
          p.addToStories(new UserStory(creator: u, title: "Title #1", effort: 1, iteration: 0, status: Status.defaultStatus))
          p.addToStories(new UserStory(creator: u,  title: "Title #2", effort: 1, iteration: 0, status: Status.defaultStatus))
          p.addToStories(new UserStory(creator: u,  title: "Title #3", effort: 1, iteration: 0, status: Status.defaultStatus))
          p.addToStories(new UserStory(creator: u,  title: "Title #4", effort: 1, iteration: 0, status: Status.defaultStatus))
          p.addToStories(new UserStory(creator: u,  title: "Title #5", effort: 1, iteration: 0, status: Status.defaultStatus))
          p.save()
          break;

        case Environment.TEST:
          new Status(name: "Unassigned", sequence: 0,description: "Unassigned").save()
          new Status(name: "In Progress", sequence: 1,description: "na").save()
          new Status(name: "Completed",sequence: 2,description: "na").save()
          new Status(name: "Postponed",sequence: 3,description: "na").save()
          new Status(name: "Canceled",sequence: 4,description: "na").save()
          def u = new User(username: "admin").save()
          new User(username: "guest").save()
          
          User.metaClass.'static'.loggedOnUser = {
            return u
          }
          break;
      }
    }
    def destroy = {
    }
}
