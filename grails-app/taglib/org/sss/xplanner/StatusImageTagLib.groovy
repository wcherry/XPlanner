package org.sss.xplanner

class StatusImageTagLib {
  static align = 'right'
  static imageDirectory = 'images'
  static imageMap = [0: 'empty', 1: 'working', 2: 'completed', 3: 'empty', 4:'canceled']
  
  def displayStatusImage = {attrs->
    def sequence = attrs['status'].toInteger()
    def alt = attrs['alt']
    def image = imageMap.get(sequence, 'empty')
    def imageLoc = resource(dir:imageDirectory,file:"${image}.png")
    out << "<img border='0' align='$align' alt='$alt' src='$imageLoc' />"
  }
}
