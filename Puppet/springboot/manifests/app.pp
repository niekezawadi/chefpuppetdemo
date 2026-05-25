class springboot::app {
  file { '/opt/springboot':
    ensure => directory,
  }
  exec { 'start-springboot':
    command => 'java -jar /opt/springboot/app.jar &',
    path    => '/usr/bin:/usr/local/bin',
  }
}

