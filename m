From: Zenon Panoussis <oracle@provocation.net>
Subject: ext4 store and device-mapper
Date: Thu, 14 Apr 2011 20:41:50 +0200
Message-ID: <4DA73FEE.2060404@provocation.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from host-88-80-6-138.cust.prq.se ([88.80.6.138]:51005 "EHLO
	mail.nettheatre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019Ab1DNSlx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 14:41:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Hi all

Attempting to create a store on a device-mapper ext4 partition fails.
Creating the exact same store in the same directory on a native ext4
partition works just fine. Success and failure output below.

It's not the presence of lost+found in the store that confuses ceph,
because it also fails if pointed to an empty subdirectory in a
device-mapper partition. So the problem seems to be a conflict between
ceph (0.26) and device-mapper. That's unfortunate because it makes it
impossible to use LUKS underneath the store.

Is this a bug or is it so by design?

Z


======

_Failure:_

# mount
mount/dev/sda1 on / type ext4 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/sda2 on /var type ext4 (rw)
/dev/sda5 on /var/log type ext4 (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
/dev/mapper/sda6 on /mnt/osd type ext4 (rw)


# mkcephfs -c /etc/ceph/ceph.conf  -a  -k /etc/ceph/admin.keyring
temp dir is /tmp/mkcephfs.ShIRgaTSnR
preparing monmap in /tmp/mkcephfs.ShIRgaTSnR/monmap
/usr/bin/monmaptool --create --clobber --add 0 192.168.178.100:6789 --print /tmp/mkcephfs.ShIRgaTSnR/monmap
/usr/bin/monmaptool: monmap file /tmp/mkcephfs.ShIRgaTSnR/monmap
/usr/bin/monmaptool: generated fsid 5276de4c-f236-965b-172e-456dce1d5af1
epoch 1
fsid 5276de4c-f236-965b-172e-456dce1d5af1
last_changed 2011-04-14 20:22:24.311930
created 2011-04-14 20:22:24.311930
0: 192.168.178.100:6789/0 mon.0
/usr/bin/monmaptool: writing epoch 1 to /tmp/mkcephfs.ShIRgaTSnR/monmap (1 monitors)
=== osd.0 ===
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
2011-04-14 20:22:24.887172 7fdc84de1720 OSD::mkfs: couldn't mount FileStore: error -95
2011-04-14 20:22:24.887226 7fdc84de1720  ** ERROR: error creating empty object store in /mnt/osd: error 95: Operation not supported
failed: '/sbin/mkcephfs -d /tmp/mkcephfs.ShIRgaTSnR --init-daemon osd.0'


_Success:_

# mount
/dev/sda1 on / type ext4 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/sda2 on /var type ext4 (rw)
/dev/sda5 on /var/log type ext4 (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)

# mkcephfs -c /etc/ceph/ceph.conf  -a  -k /etc/ceph/admin.keyring
temp dir is /tmp/mkcephfs.Lda9H0V5fD
preparing monmap in /tmp/mkcephfs.Lda9H0V5fD/monmap
/usr/bin/monmaptool --create --clobber --add 0 192.168.178.100:6789 --print /tmp/mkcephfs.Lda9H0V5fD/monmap
/usr/bin/monmaptool: monmap file /tmp/mkcephfs.Lda9H0V5fD/monmap
/usr/bin/monmaptool: generated fsid 9a605d32-ff84-5d6f-cb4f-1e0f61fbe44d
epoch 1
fsid 9a605d32-ff84-5d6f-cb4f-1e0f61fbe44d
last_changed 2011-04-14 20:31:42.623231
created 2011-04-14 20:31:42.623231
0: 192.168.178.100:6789/0 mon.0
/usr/bin/monmaptool: writing epoch 1 to /tmp/mkcephfs.Lda9H0V5fD/monmap (1 monitors)
=== osd.0 ===
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
2011-04-14 20:31:43.263370 7f925a50b720 created object store /mnt/osd journal /var/ceph/data/osd0/journal for osd0 fsid 9a605d32-ff84-5d6f-cb4f-1e0f61fbe44d
creating private key for osd.0 keyring /etc/ceph/keyring.osd.0
creating /etc/ceph/keyring.osd.0
=== osd.1 ===
pushing conf and monmap to node02
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
2011-04-14 20:31:49.472772 7f92b31db720 created object store /mnt/osd journal /var/ceph/data/osd1/journal for osd1 fsid 9a605d32-ff84-5d6f-cb4f-1e0f61fbe44d
creating private key for osd.1 keyring /etc/ceph/keyring.osd.1
creating /etc/ceph/keyring.osd.1
collecting osd.1 key
=== mds.node01 ===
creating private key for mds.node01 keyring /etc/ceph/keyring.mds.node01
creating /etc/ceph/keyring.mds.node01
=== mds.node02 ===
pushing conf and monmap to node02
creating private key for mds.node02 keyring /etc/ceph/keyring.mds.node02
creating /etc/ceph/keyring.mds.node02
collecting mds.node02 key
Building osdmap
 highest numbered osd in /tmp/mkcephfs.Lda9H0V5fD/conf is osd.1
 num osd = 2
/usr/bin/osdmaptool: osdmap file '/tmp/mkcephfs.Lda9H0V5fD/osdmap'
/usr/bin/osdmaptool: writing epoch 1 to /tmp/mkcephfs.Lda9H0V5fD/osdmap
Generating admin key at /tmp/mkcephfs.Lda9H0V5fD/keyring.admin
creating /tmp/mkcephfs.Lda9H0V5fD/keyring.admin
Building initial monitor keyring
added entity mds.node01 auth auth(auid = 18446744073709551615 key=AQCQPadNWONIJhAAiCdZ0RKk8uY8rk4brQQsZg== with 0 caps)
added entity mds.node02 auth auth(auid = 18446744073709551615 key=AQCWPadNqLZ2JRAA5P+YYPfGWcu/7wIuLREvBw== with 0 caps)
added entity osd.0 auth auth(auid = 18446744073709551615 key=AQCPPadN+C5GEBAAD3E3tjdQAE/cK2Ujwan69Q== with 0 caps)
added entity osd.1 auth auth(auid = 18446744073709551615 key=AQCVPadNyMtfIBAA8Sf4TXpx0/Qm6KfSiEi3ug== with 0 caps)
=== mon.0 ===
 ** WARNING: Ceph is still under heavy development, and is only suitable for **
 **          testing and review.  Do not trust it with important data.       **
/usr/bin/cmon: created monfs at /var/ceph/data/mon0 for mon.0
placing client.admin keyring in /etc/ceph/admin.keyring


