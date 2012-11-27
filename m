From: Rick Richardson <rick.richardson@gmail.com>
Subject: error creating empty object store
Date: Tue, 27 Nov 2012 12:07:15 -0500
Message-ID: <CA+kMGwCmOZt-=YnVq-yn4Yv9izCsfqDGSO7rBcxT_pF4OcbhrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33965 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932122Ab2K0RHR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Nov 2012 12:07:17 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so5267479bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 27 Nov 2012 09:07:16 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I have 4 ubuntu 12.04 with 3.6.7 kernel that I'm trying to configure.
Each will have 1 btrfs drive for an OSD, and 1 drive for its journal.
both drives on each host are formatted with mkfs.btrfs.

I am using github/ceph master.  I have osd.0-3 assigned to the 4
hosts, then in [osd] I have
osd journal = /dev/sdc1

I'm hoping that it will universally apply to all 4 nodes.

------

root@blargle1:/etc/ceph# mount
...
/dev/sdb1 on /var/lib/ceph/osd/ceph-0 type btrfs (rw)

root@blargle1:/etc/ceph# sudo mkcephfs -a -c /etc/ceph/ceph.conf -k ceph.keyring
temp dir is /tmp/mkcephfs.54pDJ56uZN
preparing monmap in /tmp/mkcephfs.54pDJ56uZN/monmap
/usr/local/bin/monmaptool --create --clobber --add a 172.17.9.234:6789
--add b 172.17.9.235:6789 --add c 172.17.9.236:6789 --add d
172.17.9.237:6789 --print /tmp/mkcephfs.54pDJ56uZN/monmap
/usr/local/bin/monmaptool: monmap file /tmp/mkcephfs.54pDJ56uZN/monmap
/usr/local/bin/monmaptool: generated fsid 8681d07b-d8f1-4f2a-8008-cd72997eb912
epoch 0
fsid 8681d07b-d8f1-4f2a-8008-cd72997eb912
last_changed 2012-11-27 11:47:27.852699
created 2012-11-27 11:47:27.852699
0: 172.17.9.234:6789/0 mon.a
1: 172.17.9.235:6789/0 mon.b
2: 172.17.9.236:6789/0 mon.c
3: 172.17.9.237:6789/0 mon.d
/usr/local/bin/monmaptool: writing epoch 0 to
/tmp/mkcephfs.54pDJ56uZN/monmap (4 monitors)
=== osd.0 ===
SG_IO: bad/missing sense data, sb[]:  70 00 05 00 00 00 00 0a 00 00 00
00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SG_IO: bad/missing sense data, sb[]:  70 00 05 00 00 00 00 0a 00 00 00
00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SG_IO: bad/missing sense data, sb[]:  70 00 05 00 00 00 00 0a 00 00 00
00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
2012-11-27 11:47:30.461827 7faac2144780 -1 provided osd id 0 != superblock's -1
2012-11-27 11:47:30.463239 7faac2144780 -1  ** ERROR: error creating
empty object store in /var/lib/ceph/osd/ceph-0: (22) Invalid argument
failed: '/usr/local/sbin/mkcephfs -d /tmp/mkcephfs.54pDJ56uZN
--init-daemon osd.0'

----

Thoughts?
