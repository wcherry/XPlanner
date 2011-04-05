package org.sss.xplanner

import grails.plugin.spock.*

class StatusImageTagLibSpec extends TagLibSpec {

def 'test simple image ref'() {
  expect: 
    displayStatusImage(status: status, alt:alt) == html

  where:
    status  | alt           | html
    0       | "Unassigned"  | "<img border='0' align='right' alt='Unassigned' src='/images/empty.png' />"
    1       | "In Progress" | "<img border='0' align='right' alt='In Progress' src='/images/working.png' />"
    2       | "Completed"   | "<img border='0' align='right' alt='Completed' src='/images/completed.png' />"
    3       | "Postponed"   | "<img border='0' align='right' alt='Postponed' src='/images/empty.png' />"
    4       | "Canceled"    | "<img border='0' align='right' alt='Canceled' src='/images/canceled.png' />"
    9       | "User Def"    | "<img border='0' align='right' alt='User Def' src='/images/empty.png' />"

}

}
