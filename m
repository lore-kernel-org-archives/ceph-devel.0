From: Prince Hamandawana <phamandawana@gmail.com>
Subject: Re: ceph-deploy mon create-initial errors on centos 7
Date: Wed, 21 Jun 2017 09:29:49 +0900
Message-ID: <CAC4_f3uY_LhEYYkiqkUH9tqTXPs48SyrgOnexH+34ynm6zQYVw@mail.gmail.com>
References: <CAC4_f3sgoVnde6-3wTP6Q=PGzmE+3B-AZDUu4ysCCZzPs0p+YA@mail.gmail.com>
 <CAC-Np1wrCUgxQt=F56Bn6TAx+sHew0uFGoYR8MOihXci5UgpSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33036 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbdFUA3v (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jun 2017 20:29:51 -0400
Received: by mail-it0-f67.google.com with SMTP id g184so14882656ita.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jun 2017 17:29:50 -0700 (PDT)
In-Reply-To: <CAC-Np1wrCUgxQt=F56Bn6TAx+sHew0uFGoYR8MOihXci5UgpSQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I have overwritten my ceph.conf file but still i got the same errors.
After that I purged all my nodes and deleted all keys so i start a new
deployment. When I deploy the initial monitors I again run into the
following errors;

[root@dumbo008 my-cluster]# ceph-deploy mon create-initial
[ceph_deploy.conf][DEBUG ] found configuration file at: /root/.cephdeploy.conf
[ceph_deploy.cli][INFO  ] Invoked (1.5.37): /usr/bin/ceph-deploy mon
create-initial
[ceph_deploy.cli][INFO  ] ceph-deploy options:
[ceph_deploy.cli][INFO  ]  username                      : None
[ceph_deploy.cli][INFO  ]  verbose                       : False
[ceph_deploy.cli][INFO  ]  overwrite_conf                : False
[ceph_deploy.cli][INFO  ]  subcommand                    : create-initial
[ceph_deploy.cli][INFO  ]  quiet                         : False
[ceph_deploy.cli][INFO  ]  cd_conf                       :
<ceph_deploy.conf.cephdeploy.Conf instance at 0x106afc8>
[ceph_deploy.cli][INFO  ]  cluster                       : ceph
[ceph_deploy.cli][INFO  ]  func                          : <function
mon at 0x10625f0>
[ceph_deploy.cli][INFO  ]  ceph_conf                     : None
[ceph_deploy.cli][INFO  ]  default_release               : False
[ceph_deploy.cli][INFO  ]  keyrings                      : None
[ceph_deploy.mon][DEBUG ] Deploying mon, cluster ceph hosts dumbo007 dumbo008
[ceph_deploy.mon][DEBUG ] detecting platform for host dumbo007 ...
[dumbo007][DEBUG ] connected to host: dumbo007
[dumbo007][DEBUG ] detect platform information from remote host
[dumbo007][DEBUG ] detect machine type
[dumbo007][DEBUG ] find the location of an executable
[ceph_deploy.mon][INFO  ] distro info: CentOS Linux 7.3.1611 Core
[dumbo007][DEBUG ] determining if provided host has same hostname in remote
[dumbo007][DEBUG ] get remote short hostname
[dumbo007][DEBUG ] deploying mon to dumbo007
[dumbo007][DEBUG ] get remote short hostname
[dumbo007][DEBUG ] remote hostname: dumbo007
[dumbo007][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
[dumbo007][DEBUG ] create the mon path if it does not exist
[dumbo007][DEBUG ] checking for done path: /var/lib/ceph/mon/ceph-dumbo007/done
[dumbo007][DEBUG ] create a done file to avoid re-doing the mon deployment
[dumbo007][DEBUG ] create the init path if it does not exist
[dumbo007][INFO  ] Running command: systemctl enable ceph.target
[dumbo007][INFO  ] Running command: systemctl enable ceph-mon@dumbo007
[dumbo007][INFO  ] Running command: systemctl start ceph-mon@dumbo007
[dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
/var/run/ceph/ceph-mon.dumbo007.asok mon_status
[dumbo007][ERROR ] admin_socket: exception getting command
descriptions: [Errno 111] Connection refused
[dumbo007][WARNIN] monitor: mon.dumbo007, might not be running yet
[dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
/var/run/ceph/ceph-mon.dumbo007.asok mon_status
[dumbo007][ERROR ] admin_socket: exception getting command
descriptions: [Errno 111] Connection refused
[dumbo007][WARNIN] monitor dumbo007 does not exist in monmap
[dumbo007][WARNIN] neither `public_addr` nor `public_network` keys are
defined for monitors
[dumbo007][WARNIN] monitors may not be able to form quorum
[ceph_deploy.mon][DEBUG ] detecting platform for host dumbo008 ...
[dumbo008][DEBUG ] connected to host: dumbo008
[dumbo008][DEBUG ] detect platform information from remote host
[dumbo008][DEBUG ] detect machine type
[dumbo008][DEBUG ] find the location of an executable
[ceph_deploy.mon][INFO  ] distro info: CentOS Linux 7.3.1611 Core
[dumbo008][DEBUG ] determining if provided host has same hostname in remote
[dumbo008][DEBUG ] get remote short hostname
[dumbo008][DEBUG ] deploying mon to dumbo008
[dumbo008][DEBUG ] get remote short hostname
[dumbo008][DEBUG ] remote hostname: dumbo008
[dumbo008][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
[dumbo008][DEBUG ] create the mon path if it does not exist
[dumbo008][DEBUG ] checking for done path: /var/lib/ceph/mon/ceph-dumbo008/done
[dumbo008][DEBUG ] create a done file to avoid re-doing the mon deployment
[dumbo008][DEBUG ] create the init path if it does not exist
[dumbo008][INFO  ] Running command: systemctl enable ceph.target
[dumbo008][INFO  ] Running command: systemctl enable ceph-mon@dumbo008
[dumbo008][INFO  ] Running command: systemctl start ceph-mon@dumbo008
[dumbo008][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
/var/run/ceph/ceph-mon.dumbo008.asok mon_status
[dumbo008][ERROR ] admin_socket: exception getting command
descriptions: [Errno 111] Connection refused
[dumbo008][WARNIN] monitor: mon.dumbo008, might not be running yet
[dumbo008][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
/var/run/ceph/ceph-mon.dumbo008.asok mon_status
[dumbo008][ERROR ] admin_socket: exception getting command
descriptions: [Errno 111] Connection refused
[dumbo008][WARNIN] monitor dumbo008 does not exist in monmap
[dumbo008][WARNIN] neither `public_addr` nor `public_network` keys are
defined for monitors
[dumbo008][WARNIN] monitors may not be able to form quorum
[ceph_deploy.mon][INFO  ] processing monitor mon.dumbo007
[dumbo007][DEBUG ] connected to host: dumbo007
[dumbo007][DEBUG ] detect platform information from remote host
[dumbo007][DEBUG ] detect machine type
[dumbo007][DEBUG ] find the location of an executable
[dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
/var/run/ceph/ceph-mon.dumbo007.asok mon_status
[dumbo007][ERROR ] admin_socket: exception getting command
descriptions: [Errno 111] Connection refused
[ceph_deploy.mon][WARNIN] mon.dumbo007 monitor is not yet in quorum,
tries left: 5
[ceph_deploy.mon][WARNIN] waiting 5 seconds before retrying
[dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
/var/run/ceph/ceph-mon.dumbo007.asok mon_status
[dumbo007][ERROR ] admin_socket: exception getting command
descriptions: exception: [Errno 104] Connection reset by peer
[ceph_deploy.mon][WARNIN] mon.dumbo007 monitor is not yet in quorum,
tries left: 4
[ceph_deploy.mon][WARNIN] waiting 10 seconds before retrying

On Tue, Jun 20, 2017 at 11:33 PM, Alfredo Deza <adeza@redhat.com> wrote:
> On Tue, Jun 20, 2017 at 4:43 AM, Prince Hamandawana
> <phamandawana@gmail.com> wrote:
>> Dear all
>>
>> I am having problems when trying to deploy my initial monitors via
>> ceph-deplyoy on centos 7 . The version of ceph I am running is ceph
>> version 10.2.7 (50e863e0f4bc8f4b9e31156de690d765af245185). When I run
>> ceph-deploy mon create-initial, i get the following errors ;
>>
>> [root@dumbo008 my-cluster]# ceph-deploy mon create-initial
>> [ceph_deploy.conf][DEBUG ] found configuration file at: /root/.cephdeploy.conf
>> [ceph_deploy.cli][INFO  ] Invoked (1.5.37): /usr/bin/ceph-deploy mon
>> create-initial
>> [ceph_deploy.cli][INFO  ] ceph-deploy options:
>> [ceph_deploy.cli][INFO  ]  username                      : None
>> [ceph_deploy.cli][INFO  ]  verbose                       : False
>> [ceph_deploy.cli][INFO  ]  overwrite_conf                : False
>> [ceph_deploy.cli][INFO  ]  subcommand                    : create-initial
>> [ceph_deploy.cli][INFO  ]  quiet                         : False
>> [ceph_deploy.cli][INFO  ]  cd_conf                       :
>> <ceph_deploy.conf.cephdeploy.Conf instance at 0x27b5fc8>
>> [ceph_deploy.cli][INFO  ]  cluster                       : ceph
>> [ceph_deploy.cli][INFO  ]  func                          : <function
>> mon at 0x27ad5f0>
>> [ceph_deploy.cli][INFO  ]  ceph_conf                     : None
>> [ceph_deploy.cli][INFO  ]  default_release               : False
>> [ceph_deploy.cli][INFO  ]  keyrings                      : None
>> [ceph_deploy.mon][DEBUG ] Deploying mon, cluster ceph hosts dumbo007 dumbo008
>> [ceph_deploy.mon][DEBUG ] detecting platform for host dumbo007 ...
>> [dumbo007][DEBUG ] connected to host: dumbo007
>> [dumbo007][DEBUG ] detect platform information from remote host
>> [dumbo007][DEBUG ] detect machine type
>> [dumbo007][DEBUG ] find the location of an executable
>> [ceph_deploy.mon][INFO  ] distro info: CentOS Linux 7.3.1611 Core
>> [dumbo007][DEBUG ] determining if provided host has same hostname in remote
>> [dumbo007][DEBUG ] get remote short hostname
>> [dumbo007][DEBUG ] deploying mon to dumbo007
>> [dumbo007][DEBUG ] get remote short hostname
>> [dumbo007][DEBUG ] remote hostname: dumbo007
>> [dumbo007][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
>> [dumbo007][DEBUG ] create the mon path if it does not exist
>> [dumbo007][DEBUG ] checking for done path: /var/lib/ceph/mon/ceph-dumbo007/done
>> [dumbo007][DEBUG ] create a done file to avoid re-doing the mon deployment
>> [dumbo007][DEBUG ] create the init path if it does not exist
>> [dumbo007][INFO  ] Running command: systemctl enable ceph.target
>> [dumbo007][INFO  ] Running command: systemctl enable ceph-mon@dumbo007
>> [dumbo007][INFO  ] Running command: systemctl start ceph-mon@dumbo007
>> [dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
>> /var/run/ceph/ceph-mon.dumbo007.asok mon_status
>> [dumbo007][ERROR ] admin_socket: exception getting command
>> descriptions: [Errno 111] Connection refused
>> [dumbo007][WARNIN] monitor: mon.dumbo007, might not be running yet
>> [dumbo007][INFO  ] Running command: ceph --cluster=ceph --admin-daemon
>> /var/run/ceph/ceph-mon.dumbo007.asok mon_status
>> [dumbo007][ERROR ] admin_socket: exception getting command
>> descriptions: [Errno 111] Connection refused
>> [dumbo007][WARNIN] monitor dumbo007 does not exist in monmap
>> [dumbo007][WARNIN] neither `public_addr` nor `public_network` keys are
>> defined for monitors
>> [dumbo007][WARNIN] monitors may not be able to form quorum
>> [ceph_deploy.mon][DEBUG ] detecting platform for host dumbo008 ...
>> [dumbo008][DEBUG ] connected to host: dumbo008
>> [dumbo008][DEBUG ] detect platform information from remote host
>> [dumbo008][DEBUG ] detect machine type
>> [dumbo008][DEBUG ] find the location of an executable
>> [ceph_deploy.mon][INFO  ] distro info: CentOS Linux 7.3.1611 Core
>> [dumbo008][DEBUG ] determining if provided host has same hostname in remote
>> [dumbo008][DEBUG ] get remote short hostname
>> [dumbo008][DEBUG ] deploying mon to dumbo008
>> [dumbo008][DEBUG ] get remote short hostname
>> [dumbo008][DEBUG ] remote hostname: dumbo008
>> [dumbo008][DEBUG ] write cluster configuration to /etc/ceph/{cluster}.conf
>> [ceph_deploy.mon][ERROR ] RuntimeError: config file
>> /etc/ceph/ceph.conf exists with different content; use
>> --overwrite-conf to overwrite
>> [ceph_deploy][ERROR ] GenericError: Failed to create 1 monitors
>>
>>
>> this is my ceph.conf file
>> [root@dumbo008 my-cluster]#
>> [root@dumbo008 my-cluster]# vim ceph.conf
>> [global]
>> fsid = f3207ed8-8b96-4650-a76e-f42c91ffb42c
>> mon_initial_members = dumbo007, dumbo008
>> mon_host = 172.20.1.7,172.20.1.8
>> auth_cluster_required = cephx
>> auth_service_required = cephx
>> auth_client_required = cephx
>>
>> Below is the information of my Linux OS
>> [root@dumbo008 my-cluster]# uname -a
>> Linux dumbo008 3.10.0-327.el7.x86_64 #1 SMP Thu Nov 19 22:10:57 UTC
>> 2015 x86_64 x86_64 x86_64 GNU/Linux
>>
>> [root@dumbo008 my-cluster]#
>> [root@dumbo008 my-cluster]# lsb_release -d
>> Description: CentOS Linux release 7.3.1611 (Core)
>> [root@dumbo008 my-cluster]#
>> [root@dumbo008 my-cluster]# lsb_release
>> LSB Version: :core-4.1-amd64:core-4.1-ia32:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-ia32:cxx-4.1-noarch:desktop-4.1-amd64:
>> desktop-4.1-ia32:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch
>>
>> Can someone help.
>
> This here tells me you have tried this more than once:
>
>> [ceph_deploy.mon][ERROR ] RuntimeError: config file
>> /etc/ceph/ceph.conf exists with different content; use
>> --overwrite-conf to overwrite
>
> Or possibly deployed to a host that had left overs from another
> cluster. There are many reasons why a monitor may not come up, you
> could
> try looking at the logs in the `dumbo007` box and look at
> /var/log/ceph/* and `journalctl -xe` to find out what the unit file is
> complaining about.
>
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
