class springboot::postgresql {
  package { 'postgresql':
    ensure => installed,
  }
  service { 'postgresql':
    ensure => running,
    enable => true,
  }
}
