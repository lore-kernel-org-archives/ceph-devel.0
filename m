From: Tim Flavin <tim.flavin@gmail.com>
Subject: mkcehfs: ** ERROR: error creating empty object store in /data/sd1:
 (2) No such file or directory
Date: Tue, 28 Aug 2012 13:12:22 -0400
Message-ID: <CAEj+kbmZs=x+8MVRwDs4PDbozFqSk+Qgd4EYEEe4HVQUYjxGLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63278 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab2H1RMY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Aug 2012 13:12:24 -0400
Received: by vcbfk26 with SMTP id fk26so6138740vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 28 Aug 2012 10:12:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi:

I am having a problem with mkcephfs.  I built ceph from the 48.1 tarball.

When I type:   sudo mkcephfs -a -c ceph.conf -k ceph.keyring

I get:

(monmap tool related stuff is ok)


=== osd.0 ===
2012-08-28 11:51:49.549651 b6f85000 -1 OSD::mkfs: FileStore::mkfs
failed with error -2
2012-08-28 11:51:49.549767 b6f85000 -1  ** ERROR: error creating empty
object store in /data/sd1: (2) No such file or directory
failed: '/usr/local/sbin/mkcephfs -d /tmp/mkcephfs.mKzTuonWuF
--init-daemon osd.0'


user1@ceph4:~$ cat ceph.conf
[osd]
	osd journal size = 1000
	filestore xattr use omap = true

[mon.a]
	host = ceph4
	mon addr = 64.20.246.210

[osd.0]
	host = ceph4
        osd data = /data/sd1
	; osd data = /dev/user1/data
	; osd journal = /dev/sdc1
	osd journal = /user1/log


user1@ceph4:~$ ls /data/sd1
current  d1  fsid  lost+found  store_version

/data/sd1 is an ext4 file system with -o noatime,user_xattr

Any ideas?


Tim Flavin
