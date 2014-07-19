
define common::remote_file ($remote_location, $mode = 0644, $owner = 'root', $group = 'root') {
  exec { "retrieve_${title}":
    command => "/usr/bin/wget -q ${remote_location} -O ${title}",
    creates => "${title}",
  }

  file { "${title}":
    mode    => "${mode}",
    require => Exec["retrieve_${title}"],
    group   => $group,
    owner   => $owner,
  }
}