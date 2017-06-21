From: Prince Hamandawana <phamandawana@gmail.com>
Subject: Re: ceph-deploy mon create-initial errors on centos 7
Date: Wed, 21 Jun 2017 09:35:09 +0900
Message-ID: <CAC4_f3tHqw3xVWhHeWCJ8DWYX=x2ebj=QCPgU_jmpaUgY6O4Qg@mail.gmail.com>
References: <CAC4_f3sgoVnde6-3wTP6Q=PGzmE+3B-AZDUu4ysCCZzPs0p+YA@mail.gmail.com>
 <CAC-Np1wrCUgxQt=F56Bn6TAx+sHew0uFGoYR8MOihXci5UgpSQ@mail.gmail.com> <CAC4_f3uY_LhEYYkiqkUH9tqTXPs48SyrgOnexH+34ynm6zQYVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34764 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbdFUAfL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jun 2017 20:35:11 -0400
Received: by mail-io0-f177.google.com with SMTP id i7so1446930ioe.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 17:35:11 -0700 (PDT)
In-Reply-To: <CAC4_f3uY_LhEYYkiqkUH9tqTXPs48SyrgOnexH+34ynm6zQYVw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I also tried to run a virtual cluster with vstart trying to check
where the issue issue might be emanating from. If I start vstart i run
in the following errors

creating /root/ceph_ajou/src/keyring
./monmaptool --create --clobber --add a 172.20.1.8:6789 --add b
172.20.1.8:6790 --add c 172.20.1.8:6791 --print /tmp/ceph_monmap.31364
./monmaptool: monmap file /tmp/ceph_monmap.31364
./monmaptool: generated fsid 96a11160-5ebc-47fb-bf83-d26685ed6c37
epoch 0
fsid 96a11160-5ebc-47fb-bf83-d26685ed6c37
last_changed 2017-06-21 09:32:03.110846
created 2017-06-21 09:32:03.110846
0: 172.20.1.8:6789/0 mon.a
1: 172.20.1.8:6790/0 mon.b
2: 172.20.1.8:6791/0 mon.c
./monmaptool: writing epoch 0 to /tmp/ceph_monmap.31364 (3 monitors)
rm -rf /root/ceph_ajou/src/dev/mon.a
mkdir -p /root/ceph_ajou/src/dev/mon.a
./ceph-mon --mkfs -c /root/ceph_ajou/src/ceph.conf -i a
--monmap=/tmp/ceph_monmap.31364 --keyring=/root/ceph_ajou/src/keyring
2017-06-21 09:32:03.125803 2aade3726a80 -1 WARNING: the following
dangerous and experimental features are enabled: *
2017-06-21 09:32:03.126064 2aade3726a80 -1 WARNING: the following
dangerous and experimental features are enabled: *
./ceph-mon: set fsid to 49478204-20fc-4599-a54c-0f48a5037e33
pthread lock: Invalid argument
*** Caught signal (Aborted) **
 in thread 2aade3726a80 thread_name:ceph-mon
 ceph version 1cbcead5bbff7da39dcc93cf233c15cc3ce9b9d
(21cbcead5bbff7da39dcc93cf233c15cc3ce9b9d)
 1: (()+0x4f1082) [0x2aade32fd082]
 2: (()+0xf370) [0x2aaded996370]
 3: (gsignal()+0x37) [0x2aadef03e1d7]
 4: (abort()+0x148) [0x2aadef03f8c8]
 5: (()+0x14450) [0x2aadecfda450]
 6: (leveldb::port::Mutex::Unlock()+0) [0x2aaded007d90]
 7: (leveldb::DBImpl::~DBImpl()+0x2a) [0x2aadecfdf8ba]
 8: (leveldb::DBImpl::~DBImpl()+0x9) [0x2aadecfdfc29]
 9: (LevelDBStore::LevelDBWholeSpaceIteratorImpl::lower_bound(std::string
const&, std::string const&)+0x39) [0x2aade31db139]
 10: (LevelDBStore::get(std::string const&, std::string const&,
ceph::buffer::list*)+0x163) [0x2aade31d90a3]
 11: (Monitor::check_fsid()+0xa0) [0x2aade3079d60]
 12: (Monitor::mkfs(ceph::buffer::list&)+0x87) [0x2aade308a037]
 13: (main()+0xd4c) [0x2aade30158ec]
 14: (__libc_start_main()+0xf5) [0x2aadef02ab35]
 15: (()+0x25d2aa) [0x2aade30692aa]
2017-06-21 09:32:03.234727 2aade3726a80 -1 *** Caught signal (Aborted) **
 in thread 2aade3726a80 thread_name:ceph-mon

 ceph version 1cbcead5bbff7da39dcc93cf233c15cc3ce9b9d
(21cbcead5bbff7da39dcc93cf233c15cc3ce9b9d)
 1: (()+0x4f1082) [0x2aade32fd082]
 2: (()+0xf370) [0x2aaded996370]
 3: (gsignal()+0x37) [0x2aadef03e1d7]
 4: (abort()+0x148) [0x2aadef03f8c8]
 5: (()+0x14450) [0x2aadecfda450]
 6: (leveldb::port::Mutex::Unlock()+0) [0x2aaded007d90]
 7: (leveldb::DBImpl::~DBImpl()+0x2a) [0x2aadecfdf8ba]
 8: (leveldb::DBImpl::~DBImpl()+0x9) [0x2aadecfdfc29]
 9: (LevelDBStore::LevelDBWholeSpaceIteratorImpl::lower_bound(std::string
const&, std::string const&)+0x39) [0x2aade31db139]
 10: (LevelDBStore::get(std::string const&, std::string const&,
ceph::buffer::list*)+0x163) [0x2aade31d90a3]
 11: (Monitor::check_fsid()+0xa0) [0x2aade3079d60]
 12: (Monitor::mkfs(ceph::buffer::list&)+0x87) [0x2aade308a037]
 13: (main()+0xd4c) [0x2aade30158ec]
 14: (__libc_start_main()+0xf5) [0x2aadef02ab35]
 15: (()+0x25d2aa) [0x2aade30692aa]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

    -8> 2017-06-21 09:32:03.125803 2aade3726a80 -1 WARNING: the
following dangerous and experimental features are enabled: *
    -6> 2017-06-21 09:32:03.126064 2aade3726a80 -1 WARNING: the
following dangerous and experimental features are enabled: *
     0> 2017-06-21 09:32:03.234727 2aade3726a80 -1 *** Caught signal
(Aborted) **
 in thread 2aade3726a80 thread_name:ceph-mon

 ceph version 1cbcead5bbff7da39dcc93cf233c15cc3ce9b9d
(21cbcead5bbff7da39dcc93cf233c15cc3ce9b9d)
 1: (()+0x4f1082) [0x2aade32fd082]
 2: (()+0xf370) [0x2aaded996370]
 3: (gsignal()+0x37) [0x2aadef03e1d7]
 4: (abort()+0x148) [0x2aadef03f8c8]
 5: (()+0x14450) [0x2aadecfda450]
 6: (leveldb::port::Mutex::Unlock()+0) [0x2aaded007d90]
 7: (leveldb::DBImpl::~DBImpl()+0x2a) [0x2aadecfdf8ba]
 8: (leveldb::DBImpl::~DBImpl()+0x9) [0x2aadecfdfc29]
 9: (LevelDBStore::LevelDBWholeSpaceIteratorImpl::lower_bound(std::string
const&, std::string const&)+0x39) [0x2aade31db139]
 10: (LevelDBStore::get(std::string const&, std::string const&,
ceph::buffer::list*)+0x163) [0x2aade31d90a3]
 11: (Monitor::check_fsid()+0xa0) [0x2aade3079d60]
 12: (Monitor::mkfs(ceph::buffer::list&)+0x87) [0x2aade308a037]
 13: (main()+0xd4c) [0x2aade30158ec]
 14: (__libc_start_main()+0xf5) [0x2aadef02ab35]
 15: (()+0x25d2aa) [0x2aade30692aa]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is
needed to interpret this.

./vstart.sh: line 570: 31542 Aborted                 $cmd
[root@dumbo008 src]#

On Wed, Jun 21, 2017 at 9:29 AM, Prince Hamandawana
<phamandawana@gmail.com> wrote:
> I have overwritten my ceph.conf file but still i got the same errors.
> After that I purged all my nodes and deleted all keys so i start a new
> deployment. When I deploy the initial monitors I again run into the
> following errors;
>
> [root@dumbo008 my-cluster]# ceph-deploy mon create-initial
> [ceph_deploy.conf][DEBUG ] found configuration file at: /root/.cephdeploy.conf
> [ceph_deploy.cli][INFO  ] Invoked (1.5.37): /usr/bin/ceph-deploy mon
> create-initial
> [ceph_deploy.cli][INFO  ] ceph-deploy options:
> [ceph_deploy.cli][INFO  ]  username                      : None
> [ceph_deploy.cli][INFO  ]  verbose                       : False
> [ceph_deploy.cli][INFO  ]  overwrite_conf                : False
> [ceph_deploy.cli][INFO  ]  subcommand                    : create-initial
> [ceph_deploy.cli][INFO  ]  quiet                         : False
> [ceph_deploy.cli][INFO  ]  cd_conf                       :
> <ceph_deploy.conf.cephdeploy.Conf instance at 0x106afc8>
> [ceph_deploy.cli][INFO  ]  cluster                       : ceph
> [ceph_deploy.cli][INFO  ]  func                          : <function
> mon at 0x10625f0>
> [ceph_deploy.cli][INFO  ]  ceph_conf                     : None
> [ceph_deploy.cli][INFO  ]  default_release               : False
> [ceph_deploy.cli][INFO  ]  keyrings                      : None
> [ceph_deploy.mon][DEBUG ] Deploying mon, cluster ceph hosts dumbo007 dumbo008
> [ceph_deploy.mon][DEBUG ] detecting platform for host dumbo007 ...
> [dumbo007][DEBUG ] connected to host: dumbo007
> [dumbo007][DEBUG ] detect platform information from remote host
> [dumbo007][DEBUG ] detect machine type
> [dumbo007][DEBUG ] find the location of an executable
> [ceph_deploy.mon][INFO  ] distro info: CentOS Linux 7.3.1611 Core
> [dumbo007][DEBUG ] determining if provided host has same hostname in remote
> [dumbo007][DEBUG ] get remote short hostname
> [dumbo007][DEBUG ] deploying mon to dumbo007
> [dumbo007][DEBUG ] get remote short hostname
> [dumbo007][DEBUG ] remote hostname: dumbo007
> [dumbo007][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
> [dumbo007][DEBUG ] create the mon path if it does not exist
> [dumbo007][DEBUG ] checking for done path: /var/lib/ceph/mon/ceph-dumbo007/done
> [dumbo007][DEBUG ] create a done file to avoid re-doing the mon deployment
> [dumbo007][DEBUG ] create the init path if it does not exist
> [dumbo007][INFO  ] Running command: systemctl enable ceph.target
> [dumbo007][INFO  ] Running command: systemctl enable ceph-mon@dumbo007
> [dumbo007][INFO  ] Running command: systemctl start ceph-mon@dumbo007
> [dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
> /var/run/ceph/ceph-mon.dumbo007.asok mon_status
> [dumbo007][ERROR ] admin_socket: exception getting command
> descriptions: [Errno 111] Connection refused
> [dumbo007][WARNIN] monitor: mon.dumbo007, might not be running yet
> [dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
> /var/run/ceph/ceph-mon.dumbo007.asok mon_status
> [dumbo007][ERROR ] admin_socket: exception getting command
> descriptions: [Errno 111] Connection refused
> [dumbo007][WARNIN] monitor dumbo007 does not exist in monmap
> [dumbo007][WARNIN] neither `public_addr` nor `public_network` keys are
> defined for monitors
> [dumbo007][WARNIN] monitors may not be able to form quorum
> [ceph_deploy.mon][DEBUG ] detecting platform for host dumbo008 ...
> [dumbo008][DEBUG ] connected to host: dumbo008
> [dumbo008][DEBUG ] detect platform information from remote host
> [dumbo008][DEBUG ] detect machine type
> [dumbo008][DEBUG ] find the location of an executable
> [ceph_deploy.mon][INFO  ] distro info: CentOS Linux 7.3.1611 Core
> [dumbo008][DEBUG ] determining if provided host has same hostname in remote
> [dumbo008][DEBUG ] get remote short hostname
> [dumbo008][DEBUG ] deploying mon to dumbo008
> [dumbo008][DEBUG ] get remote short hostname
> [dumbo008][DEBUG ] remote hostname: dumbo008
> [dumbo008][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
> [dumbo008][DEBUG ] create the mon path if it does not exist
> [dumbo008][DEBUG ] checking for done path: /var/lib/ceph/mon/ceph-dumbo008/done
> [dumbo008][DEBUG ] create a done file to avoid re-doing the mon deployment
> [dumbo008][DEBUG ] create the init path if it does not exist
> [dumbo008][INFO  ] Running command: systemctl enable ceph.target
> [dumbo008][INFO  ] Running command: systemctl enable ceph-mon@dumbo008
> [dumbo008][INFO  ] Running command: systemctl start ceph-mon@dumbo008
> [dumbo008][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
> /var/run/ceph/ceph-mon.dumbo008.asok mon_status
> [dumbo008][ERROR ] admin_socket: exception getting command
> descriptions: [Errno 111] Connection refused
> [dumbo008][WARNIN] monitor: mon.dumbo008, might not be running yet
> [dumbo008][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
> /var/run/ceph/ceph-mon.dumbo008.asok mon_status
> [dumbo008][ERROR ] admin_socket: exception getting command
> descriptions: [Errno 111] Connection refused
> [dumbo008][WARNIN] monitor dumbo008 does not exist in monmap
> [dumbo008][WARNIN] neither `public_addr` nor `public_network` keys are
> defined for monitors
> [dumbo008][WARNIN] monitors may not be able to form quorum
> [ceph_deploy.mon][INFO  ] processing monitor mon.dumbo007
> [dumbo007][DEBUG ] connected to host: dumbo007
> [dumbo007][DEBUG ] detect platform information from remote host
> [dumbo007][DEBUG ] detect machine type
> [dumbo007][DEBUG ] find the location of an executable
> [dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
> /var/run/ceph/ceph-mon.dumbo007.asok mon_status
> [dumbo007][ERROR ] admin_socket: exception getting command
> descriptions: [Errno 111] Connection refused
> [ceph_deploy.mon][WARNIN] mon.dumbo007 monitor is not yet in quorum,
> tries left: 5
> [ceph_deploy.mon][WARNIN] waiting 5 seconds before retrying
> [dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
> /var/run/ceph/ceph-mon.dumbo007.asok mon_status
> [dumbo007][ERROR ] admin_socket: exception getting command
> descriptions: exception: [Errno 104] Connection reset by peer
> [ceph_deploy.mon][WARNIN] mon.dumbo007 monitor is not yet in quorum,
> tries left: 4
> [ceph_deploy.mon][WARNIN] waiting 10 seconds before retrying
>
> On Tue, Jun 20, 2017 at 11:33 PM, Alfredo Deza <adeza@redhat.com> wrote:
>> On Tue, Jun 20, 2017 at 4:43 AM, Prince Hamandawana
>> <phamandawana@gmail.com> wrote:
>>> Dear all
>>>
>>> I am having problems when trying to deploy my initial monitors via
>>> ceph-deplyoy on centos 7 . The version of ceph I am running is ceph
>>> version 10.2.7 (50e863e0f4bc8f4b9e31156de690d765af245185). When I run
>>> ceph-deploy mon create-initial, i get the following errors ;
>>>
>>> [root@dumbo008 my-cluster]# ceph-deploy mon create-initial
>>> [ceph_deploy.conf][DEBUG ] found configuration file at: /root/.cephdeploy.conf
>>> [ceph_deploy.cli][INFO  ] Invoked (1.5.37): /usr/bin/ceph-deploy mon
>>> create-initial
>>> [ceph_deploy.cli][INFO  ] ceph-deploy options:
>>> [ceph_deploy.cli][INFO  ]  username                      : None
>>> [ceph_deploy.cli][INFO  ]  verbose                       : False
>>> [ceph_deploy.cli][INFO  ]  overwrite_conf                : False
>>> [ceph_deploy.cli][INFO  ]  subcommand                    : create-initial
>>> [ceph_deploy.cli][INFO  ]  quiet                         : False
>>> [ceph_deploy.cli][INFO  ]  cd_conf                       :
>>> <ceph_deploy.conf.cephdeploy.Conf instance at 0x27b5fc8>
>>> [ceph_deploy.cli][INFO  ]  cluster                       : ceph
>>> [ceph_deploy.cli][INFO  ]  func                          : <function
>>> mon at 0x27ad5f0>
>>> [ceph_deploy.cli][INFO  ]  ceph_conf                     : None
>>> [ceph_deploy.cli][INFO  ]  default_release               : False
>>> [ceph_deploy.cli][INFO  ]  keyrings                      : None
>>> [ceph_deploy.mon][DEBUG ] Deploying mon, cluster ceph hosts dumbo007 dumbo008
>>> [ceph_deploy.mon][DEBUG ] detecting platform for host dumbo007 ...
>>> [dumbo007][DEBUG ] connected to host: dumbo007
>>> [dumbo007][DEBUG ] detect platform information from remote host
>>> [dumbo007][DEBUG ] detect machine type
>>> [dumbo007][DEBUG ] find the location of an executable
>>> [ceph_deploy.mon][INFO  ] distro info: CentOS Linux 7.3.1611 Core
>>> [dumbo007][DEBUG ] determining if provided host has same hostname in remote
>>> [dumbo007][DEBUG ] get remote short hostname
>>> [dumbo007][DEBUG ] deploying mon to dumbo007
>>> [dumbo007][DEBUG ] get remote short hostname
>>> [dumbo007][DEBUG ] remote hostname: dumbo007
>>> [dumbo007][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
>>> [dumbo007][DEBUG ] create the mon path if it does not exist
>>> [dumbo007][DEBUG ] checking for done path: /var/lib/ceph/mon/ceph-dumbo007/done
>>> [dumbo007][DEBUG ] create a done file to avoid re-doing the mon deployment
>>> [dumbo007][DEBUG ] create the init path if it does not exist
>>> [dumbo007][INFO  ] Running command: systemctl enable ceph.target
>>> [dumbo007][INFO  ] Running command: systemctl enable ceph-mon@dumbo007
>>> [dumbo007][INFO  ] Running command: systemctl start ceph-mon@dumbo007
>>> [dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
>>> /var/run/ceph/ceph-mon.dumbo007.asok mon_status
>>> [dumbo007][ERROR ] admin_socket: exception getting command
>>> descriptions: [Errno 111] Connection refused
>>> [dumbo007][WARNIN] monitor: mon.dumbo007, might not be running yet
>>> [dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
>>> /var/run/ceph/ceph-mon.dumbo007.asok mon_status
>>> [dumbo007][ERROR ] admin_socket: exception getting command
>>> descriptions: [Errno 111] Connection refused
>>> [dumbo007][WARNIN] monitor dumbo007 does not exist in monmap
>>> [dumbo007][WARNIN] neither `public_addr` nor `public_network` keys are
>>> defined for monitors
>>> [dumbo007][WARNIN] monitors may not be able to form quorum
>>> [ceph_deploy.mon][DEBUG ] detecting platform for host dumbo008 ...
>>> [dumbo008][DEBUG ] connected to host: dumbo008
>>> [dumbo008][DEBUG ] detect platform information from remote host
>>> [dumbo008][DEBUG ] detect machine type
>>> [dumbo008][DEBUG ] find the location of an executable
>>> [ceph_deploy.mon][INFO  ] distro info: CentOS Linux 7.3.1611 Core
>>> [dumbo008][DEBUG ] determining if provided host has same hostname in remote
>>> [dumbo008][DEBUG ] get remote short hostname
>>> [dumbo008][DEBUG ] deploying mon to dumbo008
>>> [dumbo008][DEBUG ] get remote short hostname
>>> [dumbo008][DEBUG ] remote hostname: dumbo008
>>> [dumbo008][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
>>> [ceph_deploy.mon][ERROR ] RuntimeError: config file
>>> /etc/ceph/ceph.conf exists with different content; use
>>> --overwrite-conf to overwrite
>>> [ceph_deploy][ERROR ] GenericError: Failed to create 1 monitors
>>>
>>>
>>> this is my ceph.conf file
>>> [root@dumbo008 my-cluster]#
>>> [root@dumbo008 my-cluster]# vim ceph.conf
>>> [global]
>>> fsid = f3207ed8-8b96-4650-a76e-f42c91ffb42c
>>> mon_initial_members = dumbo007, dumbo008
>>> mon_host = 172.20.1.7,172.20.1.8
>>> auth_cluster_required = cephx
>>> auth_service_required = cephx
>>> auth_client_required = cephx
>>>
>>> Below is the information of my Linux OS
>>> [root@dumbo008 my-cluster]# uname -a
>>> Linux dumbo008 3.10.0-327.el7.x86_64 #1 SMP Thu Nov 19 22:10:57 UTC
>>> 2015 x86_64 x86_64 x86_64 GNU/Linux
>>>
>>> [root@dumbo008 my-cluster]#
>>> [root@dumbo008 my-cluster]# lsb_release -d
>>> Description: CentOS Linux release 7.3.1611 (Core)
>>> [root@dumbo008 my-cluster]#
>>> [root@dumbo008 my-cluster]# lsb_release
>>> LSB Version: :core-4.1-amd64:core-4.1-ia32:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-ia32:cxx-4.1-noarch:desktop-4.1-amd64:
>>> desktop-4.1-ia32:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch
>>>
>>> Can someone help.
>>
>> This here tells me you have tried this more than once:
>>
>>> [ceph_deploy.mon][ERROR ] RuntimeError: config file
>>> /etc/ceph/ceph.conf exists with different content; use
>>> --overwrite-conf to overwrite
>>
>> Or possibly deployed to a host that had left overs from another
>> cluster. There are many reasons why a monitor may not come up, you
>> could
>> try looking at the logs in the `dumbo007` box and look at
>> /var/log/ceph/* and `journalctl -xe` to find out what the unit file is
>> complaining about.
>>
>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
