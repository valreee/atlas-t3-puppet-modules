# Definition: hadoop_fuse 
#   This definition manages the fuse storage  installation
# 
# Parameters:
#   - $fsDefaultName file system default name should be of the
#                 for hdfs://host:port
#   - $mountPoint where to mount hdfs, default is /mnt/hdfs
# Actions:
#   - Downloads and intalls Sun Java
#   - Download, Configures, installs and starts Cloudera's Hadoop
#     fuse  service
#
# Requires:
#   - A hadoop cluster should be up and running
#
# Sample Usage:
#
#
define hadoop::hadoop_fuse($fsDefaultName,$dataNodes,$nameNodes,$mountPoint="/mnt/hdfs") {
  
  class { 'hadoop::cls_hadoop_cluster_config':
    dataNodes	=> $dataNodes,
    fsDefaultName => $fsDefaultName,
    nameNodes	  => $nameNodes,
    clusterName   => 'atlas'
  }
  
  
  package { ['hadoop-0.20-libhdfs.x86_64','hadoop-0.20-native.x86_64']:
    ensure	=> installed,
    require	=> Class['hadoop::cls_hadoop_cluster_config'],
  }

  package { ['hadoop-0.20-fuse.x86_64']:
    ensure	=> installed,
    require	=> [ Package['hadoop-0.20-libhdfs.x86_64'],Package['hadoop-0.20-native.x86_64']],
  }

 file { [$mountPoint]:
    ensure  => directory,
    require	=> [Package['hadoop-0.20-fuse.x86_64']],
  }

  # hadoop-fuse-dfs#dfs://namenode:54310    /mnt/hdfs       fuse    allow_other,usetrash,rw 2       0
  mount { [$mountPoint]:
    atboot	=> true,
    device	=> "hadoop-fuse-dfs#dfs://${fsDefaultName}",
    ensure	=> mounted,
    fstype	=> fuse,
    pass	=> 0,
    dump	=> 0,
    options	=> 'allow_other,usetrash,rw',
    remounts    => true,
    require	=> File[$mountPoint],
  }
  
}

