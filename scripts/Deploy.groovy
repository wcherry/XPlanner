import org.hibernate.dialect.Dialect
import org.hibernate.tool.hbm2ddl.SchemaExport
import org.codehaus.groovy.grails.orm.hibernate.cfg.DefaultGrailsDomainConfiguration

grailsHome = Ant.project.properties.'environment.GRAILS_HOME'

includeTargets << grailsScript("_GrailsBootstrap")


Properties props = new Properties()

target('default': 'Deploy ') {
	depends(init, classpath, checkVersion, configureProxy,packageApp)
	loadApp()
  def dialects = ['org.hibernate.dialect.MySQL5Dialect', 'org.hibernate.dialect.Oracle10gDialect']
  dialects.each(){
    def name = it.substring(it.lastIndexOf('.')+1) -  'Dialect'
    String filename = "${basedir}/target/${name.toLowerCase()}.ddl.sql"
    echo("Generating ddl for $name")
    File file = new File(filename)
    props['hibernate.dialect'] = it

    def configuration = new DefaultGrailsDomainConfiguration(
      grailsApplication: grailsApp,
      properties: props)
      
      def schemaExport = new SchemaExport(configuration)
      .setHaltOnError(true)
      .setOutputFile(file.path)
      .setDelimiter(';')
      
      // generate
      schemaExport.execute(false, false, false, false)
      
  	if (!schemaExport.exceptions.empty) {
      ((Exception)schemaExport.exceptions[0]).printStackTrace()
    }
  }
}
