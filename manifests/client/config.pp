# @summary
#   Class for Clickhouse-client user config.
#   
#
class clickhouse::client::config (
  String $user = undef,
  String $password = undef,
  String $host = '127.0.0.1',
  String $port = '9000',
  Optional[String] $db_name = undef,
  Stdlib::Unixpath $config_dir = '/root/.clickhouse-client',
  Integer $secure = 0,
  String $user_file_owner = 'root',
  String $user_file_group = 'root',
  Enum['present', 'absent'] $ensure = 'present',
) {
  file { $config_dir:
    ensure => 'directory',
  }

  file { "${config_dir}/config.xml":
    ensure  => $ensure,
    owner   => $user_file_owner,
    group   => $user_file_group,
    mode    => '0600',
    content => epp("${module_name}/client_user_config.xml.epp", {
        'user'     => $user,
        'password' => $password,
        'hostname' => $host,
        'port'     => $port,
        'secure'   => $secure,
        'db_name'  => $db_name,
    }),
  }
}
