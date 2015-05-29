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

exec { "fetch logstash": 
  command => "wget -q -O /tmp/logstash.tar.gz ${logstash_package}", 
  creates => "/tmp/logstash.tar.gz",
  path => ["/bin", "/usr/bin"]
}
file { "/opt/logstash/":
    ensure => "directory",
}
exec { "unpack logstash": 
  command => "tar -C /opt/logstash -xf /tmp/logstash.tar.gz --strip-components=1", 
  path => ["/bin", "/usr/bin"],
  require => [Exec["fetch logstash"], File["/opt/logstash/"]]
}
