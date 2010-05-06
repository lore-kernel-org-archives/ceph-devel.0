From: =?ISO-8859-1?Q?Micka=EBl_Can=E9vet?= <canevet@embl.fr>
Subject: Error creating filesystem
Date: Thu, 06 May 2010 14:40:38 +0200
Message-ID: <4BE2B8C6.6050006@embl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from emblmta1.embl.fr ([193.49.43.176]:22384 "EHLO emblmta1.embl.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372Ab0EFMkh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 May 2010 08:40:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I have an error creating filesystem with ceph 0.20 installed in 2 nodes 
in 64bits Debian squeeze:

~# mkcephfs -c /etc/ceph/ceph.conf --allhosts --mkbtrfs
/usr/bin/monmaptool --create --clobber --add 172.26.15.234:6789 --print 
/tmp/monmap.1644
/usr/bin/monmaptool: monmap file /tmp/monmap.1644
/usr/bin/monmaptool: generated fsid d2ebbcdc-f9f4-b27e-4fa1-a7ba65debea1
epoch 1
fsid d2ebbcdc-f9f4-b27e-4fa1-a7ba65debea1
last_changed 10.05.06 14:34:27.663460
created 10.05.06 14:34:27.663460
     mon0 172.26.15.234:6789/0
/usr/bin/monmaptool: writing epoch 1 to /tmp/monmap.1644 (1 monitors)
max osd in /etc/ceph/ceph.conf is 1, num osd is 2
/usr/bin/osdmaptool: osdmap file '/tmp/osdmap.1644'
/usr/bin/osdmaptool: writing epoch 1 to /tmp/osdmap.1644
Building admin keyring at /tmp/admin.keyring.1644
creating /tmp/admin.keyring.1644
Building monitor keyring with all service keys
creating /tmp/monkeyring.1644
importing contents of /tmp/admin.keyring.1644 into /tmp/monkeyring.1644
creating /tmp/keyring.mds.pc234
importing contents of /tmp/keyring.mds.pc234 into /tmp/monkeyring.1644
creating /tmp/keyring.mds.pc238
importing contents of /tmp/keyring.mds.pc238 into /tmp/monkeyring.1644
creating /tmp/keyring.osd.0
importing contents of /tmp/keyring.osd.0 into /tmp/monkeyring.1644
creating /tmp/keyring.osd.1
importing contents of /tmp/keyring.osd.1 into /tmp/monkeyring.1644
=== mon0 ===
The authenticity of host 'pc234 (172.26.15.234)' can't be established.
RSA key fingerprint is 38:4b:fe:76:3e:fb:9a:07:a8:2b:77:c5:78:57:e6:f1.
Are you sure you want to continue connecting (yes/no)? yes
10.05.06 14:34:30.220850 7f55fbcaa710 store(/data/mon0) mkfs
10.05.06 14:34:30.220994 7f55fbcaa710 store(/data/mon0) test -d 
/data/mon0 && /bin/rm -rf /data/mon0 ; mkdir -p /data/mon0
10.05.06 14:34:30.234028 7f55fbcaa710 mon0(starting).class v0 
create_initial -- creating initial map
10.05.06 14:34:30.237482 7f55fbcaa710 mon0(starting).auth v0 
create_initial -- creating initial map
10.05.06 14:34:30.237496 7f55fbcaa710 mon0(starting).auth v0 reading 
initial keyring
/usr/bin/mkmonfs: created monfs at /data/mon0 for mon0
admin.keyring.1644                                                                                                                                                           
100%  123     0.1KB/s   00:00
=== mds.pc234 ===
keyring.mds.pc234                                                                                                                                                            
100%  125     0.1KB/s   00:00
=== mds.pc238 ===
`/tmp/keyring.mds.pc238' -> `/data/keyring.mds.pc238'
=== osd0 ===
umount: /data/osd0: not mounted
umount: /dev/sdb: not mounted

WARNING! - Btrfs Btrfs v0.19 IS EXPERIMENTAL
WARNING! - see http://btrfs.wiki.kernel.org before using

fs created label (null) on /dev/sdb
     nodesize 4096 leafsize 4096 sectorsize 4096 size 149.05GB
Btrfs Btrfs v0.19
Scanning for Btrfs filesystems
failed to read /dev/hda
monmap.1644                                                                                                                                                                  
100%  187     0.2KB/s   00:00
  ** WARNING: Ceph is still under heavy development, and is only 
suitable for **
  **          testing and review.  Do not trust it with important 
data.       **
os/FileJournal.cc: In function 'int FileJournal::_open(bool, bool)':
os/FileJournal.cc:74: FAILED assert(r == 0)
  1: (FileJournal::create()+0x7e) [0x553f9e]
  2: (FileStore::mkjournal()+0x74) [0x53f9e4]
  3: (FileStore::mkfs()+0x64c) [0x53b67c]
  4: (OSD::mkfs(char const*, char const*, ceph_fsid, int)+0x40) [0x4c25a0]
  5: (main()+0x3a9) [0x455af9]
  6: (__libc_start_main()+0xfd) [0x7f6be70e4abd]
  7: /usr/bin/cosd [0x455579]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is 
needed to interpret this.
terminate called after throwing an instance of 'ceph::FailedAssertion*'
bash: line 1:  2924 Aborted                 (core dumped) /usr/bin/cosd 
-c /etc/ceph/ceph.conf --monmap /tmp/monmap.1644 -i 0 --mkfs --osd-data 
/data/osd0
failed: 'ssh pc234 /usr/bin/cosd -c /etc/ceph/ceph.conf --monmap 
/tmp/monmap.1644 -i 0 --mkfs --osd-data /data/osd0'


FYI my ceph.conf:

[global]
     auth supported = cephx

[mon]
     mon data = /data/mon$id
     debug ms = 1

[mon0]
     host = pc234
     mon addr = 172.26.15.234:6789

[mds]
     keyring = /data/keyring.$name

[mds.pc234]
     host = pc234

[mds.pc238]
     host = pc238

[osd]
     osd data = /data/osd$id
     osd journal = /data/osd$id/journal

[osd0]
     host = pc234
     btrfs devs = /dev/sdb

[osd1]
     host = pc238
     btrfs devs = /dev/sdb





Did I make something wrong ?
