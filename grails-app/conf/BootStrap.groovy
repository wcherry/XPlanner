import grails.util.Environment
import org.apache.shiro.crypto.hash.Sha1Hash

class BootStrap {

    def init = { servletContext ->
	
	    // def wildcardPermission = new JsecPermission(type: "org.jsecurity.authz.permission.WildcardPermission", possibleActions: "*").save()
        // new JsecUserPermissionRel(user: user1, permission: wildcardPermission, target: "book:list,show", actions: "*").save()
        // new JsecUserPermissionRel(user: user2, permission: wildcardPermission, target: "book:*", actions: "*").save()
	
      switch (Environment.current) {
      case Environment.DEVELOPMENT:
		def adminRole = new org.sss.xplanner.Role(name: "Administrator")
		adminRole.addToPermissions("printer:*:*")
		adminRole.addToPermissions("admin")
		adminRole.save()
	  
		def user = new org.sss.xplanner.User(username: "admin", passwordHash: new Sha1Hash("password").toHex())
		user.addToRoles(adminRole)
        user.addToPermissions("*:*")
        user.save()
        break;
      }
	
    }
    def destroy = {
    }
}
