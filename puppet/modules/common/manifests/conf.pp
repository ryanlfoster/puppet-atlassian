
define common::conf ($export = '/common_data') {
  if !defined(File[$export]) {
    file { $export: ensure => directory, }
  }

  include nfs::server

  nfs::server::export { $export:
    ensure  => 'mounted',
    clients => '192.168.0.0/24(rw,async,no_root_squash) localhost(rw)',
    require => File[$export],
  }

  class { '::mysql::server':
    root_password    => 'descartes',
    override_options => {
      'mysqld' => {
        'max_connections' => '1024'
      }
    }
  }

  common::user { 'jira':
    username => 'jira',
    uid      => '20001'
  }

  file { "${export}/jira":
    group   => 'atlassian',
    owner   => 'jira',
    ensure  => directory,
    require => [File[$export], User['jira']]
  }

  user { 'confluence':
    ensure           => present,
    name             => 'confluence',
    uid              => '20002',
    groups           => 'atlassian',
    password         => 'confluence',
    password_min_age => '0',
    password_max_age => '99999',
    managehome       => true,
  }

  file { "${export}/confluence":
    group   => 'atlassian',
    owner   => 'confluence',
    ensure  => directory,
    require => [File[$export], User['confluence']]
  }

  user { 'fisheye':
    ensure           => present,
    name             => 'fisheye',
    uid              => '20003',
    groups           => 'atlassian',
    password         => 'fisheye',
    password_min_age => '0',
    password_max_age => '99999',
    managehome       => true,
  }

  file { "${export}/fisheye":
    group   => 'atlassian',
    owner   => 'fisheye',
    ensure  => directory,
    require => [File[$export], User['fisheye']]
  }

  user { 'crowd':
    ensure           => present,
    name             => 'crowd',
    uid              => '20004',
    groups           => 'atlassian',
    password         => 'crowd',
    password_min_age => '0',
    password_max_age => '99999',
    managehome       => true,
  }

  file { "${export}/crowd":
    group   => 'atlassian',
    owner   => 'crowd',
    ensure  => directory,
    require => [File[$export], User['crowd']]
  }

  user { 'stash':
    ensure           => present,
    name             => 'stash',
    uid              => '20005',
    groups           => 'atlassian',
    password         => 'stash',
    password_min_age => '0',
    password_max_age => '99999',
    managehome       => true,
  }

  file { "${export}/stash":
    group   => 'atlassian',
    owner   => 'stash',
    ensure  => directory,
    require => [File[$export], User['stash']]
  }

  user { 'bamboo':
    ensure           => present,
    name             => 'bamboo',
    uid              => '20006',
    groups           => 'atlassian',
    password         => 'bamboo',
    password_min_age => '0',
    password_max_age => '99999',
    managehome       => true,
  }

  file { "${export}/bamboo":
    group   => 'atlassian',
    owner   => 'bamboo',
    ensure  => directory,
    require => [File[$export], User['bamboo']]
  }

}