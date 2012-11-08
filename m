From: =?UTF-8?B?QWRhbSBPY2htYcWEc2tp?= <blink@blink.waw.pl>
Subject: problem with hanging cluster
Date: Thu, 08 Nov 2012 12:14:56 +0100
Message-ID: <509B9430.40903@blink.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from balagan.blink.waw.pl ([109.196.45.178]:39932 "EHLO
	balagan.blink.waw.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2KHLWN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 06:22:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by balagan.blink.waw.pl (Postfix) with ESMTP id 853293A13C
	for <ceph-devel@vger.kernel.org>; Thu,  8 Nov 2012 10:07:46 +0100 (CET)
Received: from balagan.blink.waw.pl ([127.0.0.1])
	by localhost (balagan.blink.waw.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bWc7g9AI3dVv for <ceph-devel@vger.kernel.org>;
	Thu,  8 Nov 2012 10:07:38 +0100 (CET)
Received: from MacBook-Pro-USER.local (cmt123.neoplus.adsl.tpnet.pl [83.31.147.123])
	by balagan.blink.waw.pl (Postfix) with ESMTPSA id C64793A138
	for <ceph-devel@vger.kernel.org>; Thu,  8 Nov 2012 10:07:37 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
our test cluster going stuck every time when one of our osd host going 
down, when mising osd go to "up" state and recovery go to 100% cluster 
still not working propertly.

When ceph crash there are some working jobs from other host which only 
mounted by rbd and CephFS kernel driver. Each 5 clients do similar job 
in loop
in. ex. dd if=/dev/zero of=/mnt/ceph/$filename bs=1M count=$random; dd 
if=/mnt/ceph/$filename of=/dev/null bs=512k; rm -f /mnt/ceph/$filename

When cluster is fresh after new deploy, this test working propertly but 
when wewill fail one of our osd some times, cluster not responding all 
dd process going to state D.

We have cluster build with 3 nodes, with journal on ssd disk:
system debian 7.0 3.2.0-3-amd64

#ceph osd tree

# id    weight    type name    up/down    reweight
-1    6    root default
-3    6        rack unknownrack
-2    2            host uranos
0    1                osd.0    up    1
1    1                osd.1    up    1
-4    3            host node04
401    1                osd.401    up    1
402    1                osd.402    up    1
403    1                osd.403    up    1
-5    1            host node03
2    1                osd.2    up    1

#mount
/dev/sdb1 /var/lib/ceph/osd/ceph-401 ext4 
rw,sync,noatime,user_xattr,barrier=0,data=writeback 0 0
/dev/sdc1 /var/lib/ceph/osd/ceph-402 ext4 
rw,sync,noatime,user_xattr,barrier=0,data=writeback 0 0
/dev/sde1 /var/lib/ceph/osd/ceph-403 ext4 
rw,sync,noatime,user_xattr,barrier=0,data=writeback 0 0
/dev/sdd1 /var/lib/ceph/journal ext4 
rw,sync,noatime,user_xattr,barrier=0,data=writeback 0 0
/dev/sdd2 /var/lib/ceph/mon ext4 
rw,sync,noatime,user_xattr,barrier=0,data=writeback 0 0


#ceph -s
    health HEALTH_WARN 111 pgs peering; 111 pgs stuck inactive; 45 pgs 
stuck unclean
    monmap e1: 1 mons at {alfa=10.32.20.46:6789/0}, election epoch 1, 
quorum 0 alfa
    osdmap e853: 6 osds: 6 up, 6 in
     pgmap v10870: 1152 pgs: 871 active+clean, 111 peering, 170 
active+clean+scrubbing; 186 GB data, 478 GB used, 6500 GB / 6979 GB avail
    mdsmap e9: 1/1/1 up {0=alfa=up:active}

### /var/log/ceph.log
http://pastebin.com/z6prrnS4

### client kernel driver CephFS
10.32.20.46:6789:/ on /mnt/ceph type ceph 
(rw,relatime,name=admin,secret=<hidden>)

strace ls -al /mnt/ceph
http://pastebin.com/hqwa3sDt

### ceph.conf
[global]

     auth supported = cephx

[osd]
     osd journal size = 1000
     filestore xattr use omap = true
     osd journal = /var/lib/ceph/journal/osd.$id/journal

[mon.alfa]
     host = node04
     mon addr = 10.32.20.46:6789

[osd.401]
     host = node04

[osd.402]
     host = node04

[osd.403]
     host = node04

[osd.2]
     host = node03

[osd.0]
     host = uranos

[osd.1]
     host = uranos

[mds.alfa]
     host = node04

Any suggest ? Thanks!
-- 
Best,
blink

