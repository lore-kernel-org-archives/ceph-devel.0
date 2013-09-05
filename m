From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Ceph-deploy (git from today) fails to create osd on host that does
 not have a mon
Date: Thu, 05 Sep 2013 17:56:32 +1200
Message-ID: <52281D10.9090507@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:46736 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754801Ab3IEF4l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Sep 2013 01:56:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id C642E678C1
	for <ceph-devel@vger.kernel.org>; Thu,  5 Sep 2013 17:56:37 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Ns4ibPlkHQ8 for <ceph-devel@vger.kernel.org>;
	Thu,  5 Sep 2013 17:56:36 +1200 (NZST)
Received: from [IPv6:2404:130:0:1000:222:4dff:fe88:a586] (unknown [IPv6:2404:130:0:1000:222:4dff:fe88:a586])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 9036732DF7
	for <ceph-devel@vger.kernel.org>; Thu,  5 Sep 2013 17:56:32 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Setup:

hosts: ceph1, ceph2

Command steps:

$ ceph-deploy new ceph1
$ ceph-deploy mon create ceph1
$ ceph-deploy gatherkeys ceph1
$ ceph-deploy disk zap ceph1:/dev/vdb
$ ceph-deploy disk zap ceph1:/dev/vdc
$ ceph-deploy disk zap ceph2:/dev/vdb
$ ceph-deploy disk zap ceph2:/dev/vdc
$ ceph-deploy osd create ceph1:/dev/vdb:/dev/vdc
$ ceph-deploy osd create ceph2:/dev/vdb:/dev/vdc

The last command complains:

[ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks 
ceph2:/dev/vdb:/dev/vdc
[ceph_deploy.osd][INFO  ] Distro info: Ubuntu 12.04 precise
[ceph_deploy.osd][DEBUG ] Deploying osd to ceph2
[ceph2][INFO  ] write cluster configuration to /etc/ceph/{cluster}.conf
[ceph2][INFO  ] keyring file does not exist, creating one at: 
/var/lib/ceph/bootstrap-osd/ceph.keyring
[ceph2][INFO  ] create mon keyring file
[ceph2][ERROR ] Traceback (most recent call last):
[ceph2][ERROR ]   File 
"/home/markir/develop/python/ceph-deploy/ceph_deploy/util/decorators.py", line 
10, in inner
[ceph2][ERROR ]   File 
"/home/markir/develop/python/ceph-deploy/ceph_deploy/osd.py", line 14, 
in write_keyring
[ceph2][ERROR ] NameError: global name 'key' is not defined
[ceph2][INFO  ] Running command: udevadm trigger --subsystem-match=block 
--action=add
[ceph_deploy.osd][DEBUG ] Preparing host ceph2 disk /dev/vdb journal 
/dev/vdc activate True
[ceph2][INFO  ] Running command: ceph-disk-prepare --cluster ceph -- 
/dev/vdb /dev/vdc
[ceph2][INFO  ] Information: Moved requested sector from 34 to 2048 in
[ceph2][INFO  ] order to align on 2048-sector boundaries.
[ceph2][INFO  ] The operation has completed successfully.
[ceph2][INFO  ] Information: Moved requested sector from 34 to 2048 in
[ceph2][INFO  ] order to align on 2048-sector boundaries.
[ceph2][INFO  ] The operation has completed successfully.
[ceph2][INFO  ] meta-data=/dev/vdb1              isize=2048 agcount=4, 
agsize=327615 blks
[ceph2][INFO  ]          =                       sectsz=512 attr=2, 
projid32bit=0
[ceph2][INFO  ] data     =                       bsize=4096 
blocks=1310459, imaxpct=25
[ceph2][INFO  ]          =                       sunit=0 swidth=0 blks
[ceph2][INFO  ] naming   =version 2              bsize=4096 ascii-ci=0
[ceph2][INFO  ] log      =internal log           bsize=4096 blocks=2560, 
version=2
[ceph2][INFO  ]          =                       sectsz=512 sunit=0 
blks, lazy-count=1
[ceph2][INFO  ] realtime =none                   extsz=4096 blocks=0, 
rtextents=0
[ceph2][INFO  ] The operation has completed successfully.
[ceph2][ERROR ] WARNING:ceph-disk:OSD will not be hot-swappable if 
journal is not the same device as the osd data
[ceph2][INFO  ] Running command: udevadm trigger --subsystem-match=block 
--action=add
[ceph_deploy.osd][DEBUG ] Host ceph2 is now ready for osd use.


And the osd is not created successfully:

$ ceph -w
   cluster 66b96359-771c-467e-9f9a-060d82ab6a0c
    health HEALTH_WARN 192 pgs degraded; 192 pgs stuck unclean
    monmap e1: 1 mons at {ceph1=192.168.122.21:6789/0}, election epoch 
2, quorum 0 ceph1
    osdmap e5: 1 osds: 1 up, 1 in
     pgmap v9: 192 pgs: 192 active+degraded; 0 bytes data, 34964 KB 
used, 5074 MB / 5108 MB avail
    mdsmap e1: 0/0/1 up


Regards

Mark
