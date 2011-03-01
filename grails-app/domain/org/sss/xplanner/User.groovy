package org.sss.xplanner;

class User {
    String username
    

    static constraints = {
        username(nullable: false, blank: false)
    }

    String toString(){
      username
    }
}
