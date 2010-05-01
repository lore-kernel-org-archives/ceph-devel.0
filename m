From: Thomas Mueller <thomas@chaschperli.ch>
Subject: mkcephfs 0.20 failure on debian: FAILED assert(r == 0)
Date: Sat, 1 May 2010 15:25:23 +0000 (UTC)
Message-ID: <hrhh53$gf3$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:50121 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931Ab0EAPZj (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 1 May 2010 11:25:39 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1O8EZV-0003Z6-GE
	for ceph-devel@vger.kernel.org; Sat, 01 May 2010 17:25:37 +0200
Received: from 80-219-106-215.dclient.hispeed.ch ([80.219.106.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 01 May 2010 17:25:37 +0200
Received: from thomas by 80-219-106-215.dclient.hispeed.ch with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Sat, 01 May 2010 17:25:37 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi

I wanted to do some testing. but i failed on mkcephfs.  see mkcephfs 
output below. 

this is on debian lenny, i follow the howto in the wiki http://
ceph.newdream.net/wiki/Debian and 
http://ceph.newdream.net/wiki/Installing_on_Debian

0.19 worked with the wiki-howto.

.. and what happend to the ceph-kclient-source package? 

- Thomas


node2:~# /usr/sbin/mkcephfs -c /etc/ceph/ceph.conf --mkbtrfs 
/usr/bin/monmaptool --create --clobber --add 192.168.236.211:6789 --add 
192.168.236.212:6789 --print /tmp/monmap.8485
/usr/bin/monmaptool: monmap file /tmp/
monmap.8485                                                                    
/usr/bin/monmaptool: generated fsid 9a3cf759-8e42-e69c-dc48-6926ac0e2599
epoch 1
fsid 9a3cf759-8e42-e69c-dc48-6926ac0e2599
last_changed 10.05.01 17:09:52.257140
created 10.05.01 17:09:52.257140
        mon0 192.168.236.211:6789/0
        mon1 192.168.236.212:6789/0
/usr/bin/monmaptool: writing epoch 1 to /tmp/monmap.8485 (2 monitors)
max osd in /etc/ceph/ceph.conf is 1, num osd is 2
/usr/bin/osdmaptool: osdmap file '/tmp/osdmap.8485'
/usr/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.8485
Building admin keyring at /tmp/admin.keyring.8485
creating /tmp/admin.keyring.8485
Building monitor keyring with all service keys
creating /tmp/monkeyring.8485
importing contents of /tmp/admin.keyring.8485 into /tmp/monkeyring.8485
creating /tmp/keyring.mds.node1
importing contents of /tmp/keyring.mds.node1 into /tmp/monkeyring.8485
creating /tmp/keyring.mds.node2
importing contents of /tmp/keyring.mds.node2 into /tmp/monkeyring.8485
creating /tmp/keyring.osd.0
importing contents of /tmp/keyring.osd.0 into /tmp/monkeyring.8485
creating /tmp/keyring.osd.1
importing contents of /tmp/keyring.osd.1 into /tmp/monkeyring.8485
=== mon1 ===
10.05.01 17:09:52.773759 7fee853196f0 store(/data/mon1) mkfs
10.05.01 17:09:52.774204 7fee853196f0 store(/data/mon1) test -d /data/mon1 
&& /bin/rm -rf /data/mon1 ; mkdir -p /data/mon1
10.05.01 17:09:53.442052 7fee853196f0 mon1(starting).class v0 
create_initial -- creating initial map
10.05.01 17:09:53.641892 7fee853196f0 mon1(starting).auth v0 
create_initial -- creating initial map
10.05.01 17:09:53.641927 7fee853196f0 mon1(starting).auth v0 reading 
initial keyring
/usr/bin/mkmonfs: created monfs at /data/mon1 for mon1
`/tmp/admin.keyring.8485' -> `/data/mon1/admin_keyring.bin'
=== mds.node2 ===
`/tmp/keyring.mds.node2' -> `/data/keyring.mds.node2'
=== osd1 ===
umount: /data/osd1: not mounted
umount: /dev/vdb: not mounted

WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL
WARNING! - see http://btrfs.wiki.kernel.org before using

fs created label (null) on /dev/vdb
        nodesize 4096 leafsize 4096 sectorsize 4096 size 5.00GB
Btrfs Btrfs v0.19
Scanning for Btrfs filesystems
failed to read /dev/sr0
mount: /dev/vdb already mounted or /data/osd1 busy
 ** WARNING: Ceph is still under heavy development, and is only suitable 
for **
 **          testing and review.  Do not trust it with important 
data.       **
os/FileJournal.cc: In function 'int FileJournal::_open(bool, bool)':
os/FileJournal.cc:74: FAILED assert(r == 0)
 1: (FileJournal::create()+0x7f) [0x55725f]
 2: (FileStore::mkjournal()+0x74) [0x542f04]
 3: (FileStore::mkfs()+0x4c9) [0x540dd9]
 4: (OSD::mkfs(char const*, char const*, ceph_fsid, int)+0x4a) [0x4c2dca]
 5: (main()+0x751) [0x4585e1]
 6: (__libc_start_main()+0xe6) [0x7fc412c811a6]
 7: (std::ios_base::Init::~Init()+0x61) [0x457be9]
 NOTE: a copy of the executable, or `objdump -rdS <executable>` is needed 
to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion*'
/usr/lib/ceph/ceph_common.sh: line 95:  8680 Aborted                 
(core dumped) bash -c "$1"
failed: '/usr/bin/cosd -c /etc/ceph/ceph.conf --monmap /tmp/monmap.8485 -
i 1 --mkfs --osd-data /data/osd1'

