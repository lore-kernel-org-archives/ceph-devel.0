From: Christian Baun <cray@unix-ag.uni-kl.de>
Subject: Problem with Ceph installation inside Amazon EC2
Date: Tue, 20 Apr 2010 15:38:34 +0200
Message-ID: <201004201538.34232.cray@unix-ag.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:38149 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab0DTNuy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Apr 2010 09:50:54 -0400
Received: from sushi.unix-ag.uni-kl.de (sushi.unix-ag.uni-kl.de [IPv6:2001:638:208:ef34:0:ff:fe00:65])
	by mailgw1.uni-kl.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o3KDcTIk003524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 20 Apr 2010 15:38:29 +0200
Received: from localhost.localdomain (sushi.unix-ag.uni-kl.de [IPv6:2001:638:208:ef34:0:ff:fe00:65])
	by sushi.unix-ag.uni-kl.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o3KDcSlT011723
	for <ceph-devel@vger.kernel.org>; Tue, 20 Apr 2010 15:38:29 +0200
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I want to test Ceph inside Amazon EC2. Therefore I compiled and installed ceph-0.19.1.tar.gz and ceph-kclient-0.19.1.tar.gz

Two Ubuntu instances are running inside EC2. 
One server with cmon, cmds, and cosd and one client.

# cat /etc/ceph/ceph.conf
[global]
       pid file = /var/run/ceph/$name.pid
       debug ms = 1

[mon]
       mon data = /srv/ceph/mon

[mon0]
       host = ceph01
       mon addr = 10.194.145.203:6789

[mds]

[mds0]
       host = ceph01

[osd]
       sudo = true
       osd data = /srv/ceph/osd

[osd1]
       host = ceph01
       btrfs devs = /dev/sdc


# cat /etc/hosts
127.0.0.1 localhost
10.194.145.203   ceph01


# mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs -k ~/admin.keyring
.conf --allhosts --mkbtrfs -k ~/admin.keyring
/usr/local/bin/monmaptool --create --clobber --add 10.194.145.203:6789 --print /tmp/monmap.9681
/usr/local/bin/monmaptool: monmap file /tmp/monmap.9681
/usr/local/bin/monmaptool: generated fsid 7a008165-58df-733f-deca-90faecaef60a
epoch 1
fsid 7a008165-58df-733f-deca-90faecaef60a
last_changed 10.04.20 13:34:52.518583
created 10.04.20 13:34:52.518583
	mon0 10.194.145.203:6789/0
/usr/local/bin/monmaptool: writing epoch 1 to /tmp/monmap.9681 (1 monitors)
max osd in /etc/ceph/ceph.conf is 1, num osd is 2
/usr/local/bin/osdmaptool: osdmap file '/tmp/osdmap.9681'
/usr/local/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.9681
Building admin keyring at /root/admin.keyring
creating /root/admin.keyring
Building monitor keyring with all service keys
creating /tmp/monkeyring.9681
importing contents of /root/admin.keyring into /tmp/monkeyring.9681
creating /tmp/keyring.mds.0
importing contents of /tmp/keyring.mds.0 into /tmp/monkeyring.9681
creating /tmp/keyring.osd.1
importing contents of /tmp/keyring.osd.1 into /tmp/monkeyring.9681
=== mon0 === 
10.04.20 13:34:54.805739 store(/srv/ceph/mon) mkfs
10.04.20 13:34:54.805853 store(/srv/ceph/mon) test -d /srv/ceph/mon && /bin/rm -rf /srv/ceph/mon ; mkdir -p /srv/ceph/mon
10.04.20 13:34:54.831017 mon0(starting).class v0 create_initial -- creating initial map
10.04.20 13:34:54.832277 mon0(starting).auth v0 create_initial -- creating initial map
10.04.20 13:34:54.832308 mon0(starting).auth v0 reading initial keyring 
/usr/local/bin/mkmonfs: created monfs at /srv/ceph/mon for mon0
admin.keyring                                    100%  119     0.1KB/s   00:00    
=== mds0 === 
WARNING: no keyring specified for mds0
=== osd1 === 
umount: /srv/ceph/osd: not mounted
umount: /dev/sdc: not mounted

WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL
WARNING! - see http://btrfs.wiki.kernel.org before using

fs created label (null) on /dev/sdc
	nodesize 4096 leafsize 4096 sectorsize 4096 size 419.97GB
Btrfs Btrfs v0.19
Scanning for Btrfs filesystems
monmap.9681                                      100%  187     0.2KB/s   00:00    
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
created object store for osd1 fsid 7a008165-58df-733f-deca-90faecaef60a on /srv/ceph/osd
WARNING: no keyring specified for osd1



# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/sda1             10403128   4038372   5945328  41% /
none                   3804316       112   3804204   1% /dev
none                   3941904         0   3941904   0% /dev/shm
none                   3941904        60   3941844   1% /var/run
none                   3941904         0   3941904   0% /var/lock
none                   3941904         0   3941904   0% /lib/init/rw
/dev/sdb             433455904    203016 411234584   1% /mnt
/dev/sdc             440366080        32 440366048   1% /srv/ceph/osd


# mount | grep ceph
/dev/sdc on /srv/ceph/osd type btrfs (rw,flushoncommit)


At the server:
# ./ceph start
10.04.20 13:35:39.757563 7f6485c32720 -- :/10726 messenger.start
10.04.20 13:35:39.757808 7f6485c32720 -- :/10726 --> mon0 10.194.145.203:6789/0 -- auth(proto 0 30 bytes) -- ?+0 0x1e46910
10.04.20 13:35:39.757990 7f6482eb3710 -- :/10726 >> 10.194.145.203:6789/0 pipe(0x1e426a0 sd=-1 pgs=0 cs=0 l=0).fault first fault


At the client:
# mount -t ceph 10.194.145.203:/ /mnt/ceph/
mount: 10.194.145.203:/: can't read superblock


What can I do at this point?

Thanks in advance
    Christian 

