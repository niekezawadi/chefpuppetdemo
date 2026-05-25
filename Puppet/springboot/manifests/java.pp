class springboot::java {
  package { 'openjdk-21-jdk':
    ensure => installed,
  }
}
