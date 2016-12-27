From: Dong Wu <archer.wudong@gmail.com>
Subject: Re: How to use async with rdma
Date: Tue, 27 Dec 2016 17:02:50 +0800
Message-ID: <CAAL-TMezoXd0yXb2pysp5gMx9d5XVVchBMCHQJR1kh1Quy3zzw@mail.gmail.com>
References: <CAAL-TMcLoFUHNo7UUTdj-7NRsedgBaC3wxa5H79h_pk-P9yrcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36667 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbcL0JLO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Dec 2016 04:11:14 -0500
Received: by mail-qk0-f169.google.com with SMTP id n21so209655385qka.3
        for <ceph-devel@vger.kernel.org>; Tue, 27 Dec 2016 01:11:13 -0800 (PST)
In-Reply-To: <CAAL-TMcLoFUHNo7UUTdj-7NRsedgBaC3wxa5H79h_pk-P9yrcQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Sorry for my mistake to send an empty email before, here is the content:

Hi, Haomai
    I want to test async messenger with rdma, but when i ceph-deploy a
cluster with the following conf, it failed.

##ceph.conf##
[global]
fsid = d841b987-c6d6-4267-923a-2ad3e30a6e9b
mon_initial_members = ceph21
mon_host = 192.168.1.2
auth_cluster_required = cephx
auth_service_required = cephx
auth_client_required = cephx

ms_type = async
ms_async_transport_type = rdma
ms_async_rdma_device_name = mlx4_0
ms_async_rdma_port_num = 1

osd_crush_chooseleaf_type = 0
osd_pool_default_size = 1
rbd_default_features = 1

##here is ceph-deploy failed info##
cepher@ceph21:~/ceph_deploy$ ceph-deploy mon create-initial
[ceph_deploy.conf][DEBUG ] found configuration file at:
/home/cepher/.cephdeploy.conf
[ceph_deploy.cli][INFO  ] Invoked (1.5.35): /usr/bin/ceph-deploy mon
create-initial
[ceph_deploy.cli][INFO  ] ceph-deploy options:
[ceph_deploy.cli][INFO  ]  username                      : None
[ceph_deploy.cli][INFO  ]  verbose                       : False
[ceph_deploy.cli][INFO  ]  overwrite_conf                : False
[ceph_deploy.cli][INFO  ]  subcommand                    : create-initial
[ceph_deploy.cli][INFO  ]  quiet                         : False
[ceph_deploy.cli][INFO  ]  cd_conf                       :
<ceph_deploy.conf.cephdeploy.Conf instance at 0x7fe9ab01bbd8>
[ceph_deploy.cli][INFO  ]  cluster                       : ceph
[ceph_deploy.cli][INFO  ]  func                          : <function
mon at 0x7fe9ab490140>
[ceph_deploy.cli][INFO  ]  ceph_conf                     : None
[ceph_deploy.cli][INFO  ]  keyrings                      : None
[ceph_deploy.cli][INFO  ]  default_release               : False
[ceph_deploy.mon][DEBUG ] Deploying mon, cluster ceph hosts ceph21
[ceph_deploy.mon][DEBUG ] detecting platform for host ceph21 ...
[ceph21][DEBUG ] connection detected need for sudo
[ceph21][DEBUG ] connected to host: ceph21
[ceph21][DEBUG ] detect platform information from remote host
[ceph21][DEBUG ] detect machine type
[ceph21][DEBUG ] find the location of an executable
[ceph_deploy.mon][INFO  ] distro info: debian 8.5 jessie
[ceph21][DEBUG ] determining if provided host has same hostname in remote
[ceph21][DEBUG ] get remote short hostname
[ceph21][DEBUG ] deploying mon to ceph21
[ceph21][DEBUG ] get remote short hostname
[ceph21][DEBUG ] remote hostname: ceph21
[ceph21][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
[ceph21][DEBUG ] create the mon path if it does not exist
[ceph21][DEBUG ] checking for done path: /var/lib/ceph/mon/ceph-ceph21/done
[ceph21][DEBUG ] done path does not exist: /var/lib/ceph/mon/ceph-ceph21/done
[ceph21][INFO  ] creating keyring file:
/var/lib/ceph/tmp/ceph-ceph21.mon.keyring
[ceph21][DEBUG ] create the monitor keyring file
[ceph21][INFO  ] Running command: sudo ceph-mon --cluster ceph --mkfs
-i ceph21 --keyring /var/lib/ceph/tmp/ceph-ceph21.mon.keyring
--setuser 64045 --setgroup 64045
[ceph21][DEBUG ] ceph-mon: mon.noname-a 192.168.1.2:6789/0 is local,
renaming to mon.ceph21
[ceph21][DEBUG ] ceph-mon: set fsid to d841b987-c6d6-4267-923a-2ad3e30a6e9b
[ceph21][DEBUG ] ceph-mon: created monfs at
/var/lib/ceph/mon/ceph-ceph21 for mon.ceph21
[ceph21][INFO  ] unlinking keyring file
/var/lib/ceph/tmp/ceph-ceph21.mon.keyring
[ceph21][DEBUG ] create a done file to avoid re-doing the mon deployment
[ceph21][DEBUG ] create the init path if it does not exist
[ceph21][INFO  ] Running command: sudo systemctl enable ceph.target
[ceph21][INFO  ] Running command: sudo systemctl enable ceph-mon@ceph21
[ceph21][INFO  ] Running command: sudo systemctl start ceph-mon@ceph21
[ceph21][INFO  ] Running command: sudo ceph --cluster=ceph
--admin-daemon /var/run/ceph/ceph-mon.ceph21.asok mon_status
[ceph21][ERROR ] admin_socket: exception getting command descriptions:
[Errno 111] Connection refused
[ceph21][WARNIN] monitor: mon.ceph21, might not be running yet
[ceph21][INFO  ] Running command: sudo ceph --cluster=ceph
--admin-daemon /var/run/ceph/ceph-mon.ceph21.asok mon_status
[ceph21][ERROR ] admin_socket: exception getting command descriptions:
[Errno 111] Connection refused
[ceph21][WARNIN] monitor ceph21 does not exist in monmap
[ceph21][WARNIN] neither `public_addr` nor `public_network` keys are
defined for monitors
[ceph21][WARNIN] monitors may not be able to form quorum
[ceph_deploy.mon][INFO  ] processing monitor mon.ceph21
[ceph21][DEBUG ] connection detected need for sudo
[ceph21][DEBUG ] connected to host: ceph21
[ceph21][DEBUG ] detect platform information from remote host
[ceph21][DEBUG ] detect machine type
[ceph21][DEBUG ] find the location of an executable
[ceph21][INFO  ] Running command: sudo ceph --cluster=ceph
--admin-daemon /var/run/ceph/ceph-mon.ceph21.asok mon_status
[ceph21][ERROR ] admin_socket: exception getting command descriptions:
[Errno 111] Connection refused
[ceph_deploy.mon][WARNIN] mon.ceph21 monitor is not yet in quorum, tries left: 5
[ceph_deploy.mon][WARNIN] waiting 5 seconds before retrying
[ceph21][INFO  ] Running command: sudo ceph --cluster=ceph
--admin-daemon /var/run/ceph/ceph-mon.ceph21.asok mon_status
[ceph21][ERROR ] admin_socket: exception getting command descriptions:
[Errno 111] Connection refused
[ceph_deploy.mon][WARNIN] mon.ceph21 monitor is not yet in quorum, tries left: 4
[ceph_deploy.mon][WARNIN] waiting 10 seconds before retrying


when I just use async posix to deploy a cluster, and then change
ceph.conf to use rdma, and then restart ceph-mon , mon crashed.
##first use the ceph.conf to deploy a cluster##
[global]
fsid = d841b987-c6d6-4267-923a-2ad3e30a6e9b
mon_initial_members = ceph21
mon_host = 192.168.1.2
auth_cluster_required = cephx
auth_service_required = cephx
auth_client_required = cephx

ms_type = async

osd_crush_chooseleaf_type = 0
osd_pool_default_size = 1
rbd_default_features = 1

##then change ceph.conf##
ms_async_transport_type = rdma
ms_async_rdma_device_name = mlx4_0
ms_async_rdma_port_num = 1

##then restart ceph-mon, and mon crash##
2016-12-27 13:16:00.834116 7fd245de67c0  0 set uid:gid to 64045:64045
(ceph:ceph)
2016-12-27 13:16:00.834136 7fd245de67c0  0 ceph version 11.1.1
(87597971b371d7f497d7eabad3545d72d18dd755), process ceph-mon, pid
56904
2016-12-27 13:16:00.834202 7fd245de67c0  0 pidfile_write: ignore empty
--pid-file
2016-12-27 13:16:00.846997 7fd245de67c0  0 load: jerasure load: lrc load: isa
2016-12-27 13:16:00.847275 7fd245de67c0  1 leveldb: Recovering log #3
2016-12-27 13:16:00.847326 7fd245de67c0  1 leveldb: Level-0 table #5: started
2016-12-27 13:16:00.872185 7fd245de67c0  1 leveldb: Level-0 table #5:
574 bytes OK
2016-12-27 13:16:00.918333 7fd245de67c0  1 leveldb: Delete type=0 #3

2016-12-27 13:16:00.918379 7fd245de67c0  1 leveldb: Delete type=3 #2

2016-12-27 13:16:00.919215 7fd245de67c0 -1 *** Caught signal
(Segmentation fault) **
 in thread 7fd245de67c0 thread_name:ceph-mon

 ceph version 11.1.1 (87597971b371d7f497d7eabad3545d72d18dd755)
 1: (()+0x722bc7) [0x7fd24587bbc7]
 2: (()+0xf8d0) [0x7fd2439d48d0]
 3: (pthread_spin_lock()+0) [0x7fd2439d1bd0]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

--- begin dump of recent events ---
   -32> 2016-12-27 13:16:00.826676 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command perfcounters_dump hook
0x7fd24eac0030
   -31> 2016-12-27 13:16:00.826690 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command 1 hook 0x7fd24eac0030
   -30> 2016-12-27 13:16:00.826694 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command perf dump hook 0x7fd24eac0030
   -29> 2016-12-27 13:16:00.826731 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command perfcounters_schema hook
0x7fd24eac0030
   -28> 2016-12-27 13:16:00.826734 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command 2 hook 0x7fd24eac0030
   -27> 2016-12-27 13:16:00.826745 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command perf schema hook 0x7fd24eac0030
   -26> 2016-12-27 13:16:00.826749 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command perf reset hook 0x7fd24eac0030
   -25> 2016-12-27 13:16:00.826757 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command config show hook 0x7fd24eac0030
   -24> 2016-12-27 13:16:00.826767 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command config set hook 0x7fd24eac0030
   -23> 2016-12-27 13:16:00.826771 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command config get hook 0x7fd24eac0030
   -22> 2016-12-27 13:16:00.826774 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command config diff hook 0x7fd24eac0030
   -21> 2016-12-27 13:16:00.826784 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command log flush hook 0x7fd24eac0030
   -20> 2016-12-27 13:16:00.826787 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command log dump hook 0x7fd24eac0030
   -19> 2016-12-27 13:16:00.826796 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command log reopen hook 0x7fd24eac0030
   -18> 2016-12-27 13:16:00.826808 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command dump_mempools hook
0x7fd24ebc1548
   -17> 2016-12-27 13:16:00.834116 7fd245de67c0  0 set uid:gid to
64045:64045 (ceph:ceph)
   -16> 2016-12-27 13:16:00.834136 7fd245de67c0  0 ceph version 11.1.1
(87597971b371d7f497d7eabad3545d72d18dd755), process ceph-mon, pid
56904
   -15> 2016-12-27 13:16:00.834202 7fd245de67c0  0 pidfile_write:
ignore empty --pid-file
   -14> 2016-12-27 13:16:00.836477 7fd245de67c0  5
asok(0x7fd24ebfc000) init /var/run/ceph/ceph-mon.ceph21.asok
   -13> 2016-12-27 13:16:00.836489 7fd245de67c0  5
asok(0x7fd24ebfc000) bind_and_listen
/var/run/ceph/ceph-mon.ceph21.asok
   -12> 2016-12-27 13:16:00.836518 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command 0 hook 0x7fd24eabe0c8
   -11> 2016-12-27 13:16:00.836531 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command version hook 0x7fd24eabe0c8
   -10> 2016-12-27 13:16:00.836535 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command git_version hook 0x7fd24eabe0c8
    -9> 2016-12-27 13:16:00.836545 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command help hook 0x7fd24eac01e0
    -8> 2016-12-27 13:16:00.836550 7fd245de67c0  5
asok(0x7fd24ebfc000) register_command get_command_descriptions hook
0x7fd24eac01f0
    -7> 2016-12-27 13:16:00.836606 7fd23f576700  5
asok(0x7fd24ebfc000) entry start
    -6> 2016-12-27 13:16:00.846997 7fd245de67c0  0 load: jerasure
load: lrc load: isa
    -5> 2016-12-27 13:16:00.847275 7fd245de67c0  1 leveldb: Recovering log #3
    -4> 2016-12-27 13:16:00.847326 7fd245de67c0  1 leveldb: Level-0
table #5: started
    -3> 2016-12-27 13:16:00.872185 7fd245de67c0  1 leveldb: Level-0
table #5: 574 bytes OK
    -2> 2016-12-27 13:16:00.918333 7fd245de67c0  1 leveldb: Delete type=0 #3

    -1> 2016-12-27 13:16:00.918379 7fd245de67c0  1 leveldb: Delete type=3 #2

     0> 2016-12-27 13:16:00.919215 7fd245de67c0 -1 *** Caught signal
(Segmentation fault) **
 in thread 7fd245de67c0 thread_name:ceph-mon

 ceph version 11.1.1 (87597971b371d7f497d7eabad3545d72d18dd755)
 1: (()+0x722bc7) [0x7fd24587bbc7]
 2: (()+0xf8d0) [0x7fd2439d48d0]
 3: (pthread_spin_lock()+0) [0x7fd2439d1bd0]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.



2016-12-27 16:52 GMT+08:00 Dong Wu <archer.wudong@gmail.com>:
> HI, Haomai
