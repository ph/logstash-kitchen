class {
  'apt':
    always_apt_update => true;
}
Package {
  require => Class['apt']
}
class { 'elasticsearch': 
  version => '1.5.0',
          manage_repo => true,
          repo_version => '1.5',
}
elasticsearch::instance { 'logstash-es-1': }
