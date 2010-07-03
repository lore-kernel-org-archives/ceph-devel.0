From: Christian Baun <cray@unix-ag.uni-kl.de>
Subject: ubuntu problem while trying to get Ceph working with 2 servers
Date: Sat, 3 Jul 2010 22:21:24 +0200
Message-ID: <201007032221.24831.cray@unix-ag.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:35627 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0GCUV3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Jul 2010 16:21:29 -0400
Received: from sushi.unix-ag.uni-kl.de (sushi.unix-ag.uni-kl.de [IPv6:2001:638:208:ef34:0:ff:fe00:65])
	by mailgw1.uni-kl.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o63KLR8Q016916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sat, 3 Jul 2010 22:21:27 +0200
Received: from localhost.localdomain (sushi.unix-ag.uni-kl.de [IPv6:2001:638:208:ef34:0:ff:fe00:65])
	by sushi.unix-ag.uni-kl.de (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o63KLQvu020233
	for <ceph-devel@vger.kernel.org>; Sat, 3 Jul 2010 22:21:27 +0200
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I want to use Ceph inside Amazon EC2. Therefore I compiled and installed ceph-0.20.tar.gz and ceph-kclient-0.20.tar.gz

3 Ubuntu-Instances are running.
2 are Servers and one shall be the Client.

Server 1 => mon, mds, osd
Server 2 => osd

This is my /etc/ceph/ceph.conf at server 1 and server 2:

[global]
    pid file = /var/run/ceph/$name.pid
    debug ms = 1
[mon]
    mon data = /srv/ceph/mon
[mon0]
    host = ip-10-243-150-209
    mon addr = 10.243.150.209:6789
[mds]
    keyring = /data/keyring.$name
[mds0]
    host = ip-10-243-150-209
[osd]
    sudo = true
    osd data = /data/osd$id
[osd1]
    host = ip-10-243-150-209
    btrfs devs = /dev/sdc
[osd2]
    host = ip-10-212-118-67
    btrfs devs = /dev/sdc

The compilation worked without problems but now I have the problem that I cannot create the filesystem.

# mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs
/usr/local/bin/monmaptool --create --clobber --add 10.243.150.209:6789 --print /tmp/monmap.19567
/usr/local/bin/monmaptool: monmap file /tmp/monmap.19567
/usr/local/bin/monmaptool: generated fsid 7b562e4d-25d1-54e6-ad33-a4b51d80a8b7
epoch 1
fsid 7b562e4d-25d1-54e6-ad33-a4b51d80a8b7
last_changed 10.07.03 20:12:13.389729
created 10.07.03 20:12:13.389729
	mon0 10.243.150.209:6789/0
/usr/local/bin/monmaptool: writing epoch 1 to /tmp/monmap.19567 (1 monitors)
max osd in /etc/ceph/ceph.conf is 2, num osd is 3
/usr/local/bin/osdmaptool: osdmap file '/tmp/osdmap.19567'
/usr/local/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.19567
Building admin keyring at /tmp/admin.keyring.19567
creating /tmp/admin.keyring.19567
Building monitor keyring with all service keys
creating /tmp/monkeyring.19567
importing contents of /tmp/admin.keyring.19567 into /tmp/monkeyring.19567
creating /tmp/keyring.mds.0
importing contents of /tmp/keyring.mds.0 into /tmp/monkeyring.19567
creating /tmp/keyring.osd.1
importing contents of /tmp/keyring.osd.1 into /tmp/monkeyring.19567
creating /tmp/keyring.osd.2
importing contents of /tmp/keyring.osd.2 into /tmp/monkeyring.19567
=== mon0 === 
10.07.03 20:12:13.627255 b74236d0 store(/srv/ceph/mon) mkfs
10.07.03 20:12:13.627348 b74236d0 store(/srv/ceph/mon) test -d /srv/ceph/mon && /bin/rm -rf /srv/ceph/mon ; mkdir -p /srv/ceph/mon
10.07.03 20:12:13.636152 b74236d0 mon0(starting).class v0 create_initial -- creating initial map
10.07.03 20:12:13.637668 b74236d0 mon0(starting).auth v0 create_initial -- creating initial map
10.07.03 20:12:13.637678 b74236d0 mon0(starting).auth v0 reading initial keyring 
/usr/local/bin/mkmonfs: created monfs at /srv/ceph/mon for mon0
`/tmp/admin.keyring.19567' -> `/srv/ceph/mon/admin_keyring.bin'
=== mds0 === 
`/tmp/keyring.mds.0' -> `/data/keyring.mds.0'
=== osd1 === 
umount: /dev/sdc: not mounted

WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL
WARNING! - see http://btrfs.wiki.kernel.org before using

fs created label (null) on /dev/sdc
	nodesize 4096 leafsize 4096 sectorsize 4096 size 10.00GB
Btrfs Btrfs v0.19
Scanning for Btrfs filesystems
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
 ** WARNING: No osd journal is configured: write latency may be high.
             If you will not be using an osd journal, write latency may be
             relatively high.  It can be reduced somewhat by lowering
             filestore_max_sync_interval, but lower values mean lower write
             throughput, especially with spinning disks.
created object store for osd1 fsid 7b562e4d-25d1-54e6-ad33-a4b51d80a8b7 on /data/osd1
WARNING: no keyring specified for osd1
=== osd2 === 
lost connection
lost connection
Permission denied (publickey).
failed: 'ssh ip-10-212-118-67 test -d /data/osd2 || mkdir -p /data/osd2'

I tried to enable the login without password like described here:
http://ceph.newdream.net/wiki/Creating_a_new_file_system

But Ubuntu does not allow to login as root.

# ssh root@ec2-67-202-18-178.compute-1.amazonaws.com
Permission denied (publickey).

Any ideas what I can do here to get it working? 

Best Regards,
   Christian 


