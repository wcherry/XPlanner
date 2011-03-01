import grails.util.Environment
import org.apache.shiro.crypto.hash.Sha1Hash
import org.sss.xplanner.*

class BootStrap {

    def init = { servletContext ->
      switch (Environment.current) {
      case Environment.DEVELOPMENT:
      new TaskStatus(name: "Unassigned", sequence: 0,description: "Unassigned").save()
      new TaskStatus(name: "In Progress", sequence: 1,description: "na").save()
      new TaskStatus(name: "Completed",sequence: 2,description: "na").save()
      new TaskStatus(name: "Postponed",sequence: 3,description: "na").save()
      new TaskStatus(name: "Canceled",sequence: 4,description: "na").save()
      new User(username: "admin").save()
      new User(username: "guest").save()
      new Project(title: "Default", description: "Default").save()
      break;
      }
	
    }
    def destroy = {
    }
}
