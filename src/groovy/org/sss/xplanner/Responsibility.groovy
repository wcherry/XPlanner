package org.sss.xplanner

enum Responsibility {developer, tester, customer, stake_holder, project_manager,admin

  public String toString(){
    switch(this){
      case developer: return "Developer"
      case tester: return "Tester"
      case customer: return "Customer"
      case stake_holder: return "Stake Holder"
      case project_manager: return "Project Manager"
      case admin: return "Administrator"
      default: throw new IllegalStateException("Enum out of scope ${ordinal()}")
    }
  }
}