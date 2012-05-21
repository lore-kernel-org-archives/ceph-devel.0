From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: mkfs on osd - failed in 0.47
Date: Mon, 21 May 2012 22:41:21 +0200
Message-ID: <CAMwB3TgPPbPWY5814_LVvD853fnbW1gH1mQGsaUSwJMyGR0ovQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37438 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046Ab2EUUlW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 16:41:22 -0400
Received: by weyu7 with SMTP id u7so3446369wey.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 13:41:21 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ubuntu precise:
Linux obs-10-177-66-4 3.2.0-23-generic #36-Ubuntu SMP Tue Apr 10
20:39:51 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux

# mount
/dev/sdc on /vol0/data/osd.0 type ext4
(rw,noexec,nodev,noatime,nodiratime,user_xattr,data=3Dwriteback,barrier=
=3D0)

# ceph-osd -i 0 --mkjournal --mkfs --monmap /tmp/monmap
2012-05-21 22:36:54.150374 7f65fbc0b780 -1 filestore(/vol0/data/osd.0)
leveldb db created
2012-05-21 22:36:54.152699 7f65fbc0b780 -1 filestore(/vol0/data/osd.0)
Extended attributes don't appear to work. Got error (2) No such file
or directory. If you are using ext3 or ext4, be sure to mount the
underlying file system with the 'user_xattr' option.
2012-05-21 22:36:54.152729 7f65fbc0b780 -1 OSD::mkfs: couldn't mount
=46ileStore: error -95
2012-05-21 22:36:54.152761 7f65fbc0b780 -1  ** ERROR: error creating
empty object store in /vol0/data/osd.0: (95) Operation not supported

# ls -la /vol0/data/osd.0
total 524328
drwxr-xr-x  4 root root      4096 May 21 22:36 .
drwxr-xr-x 29 root root      4096 May 21 22:34 ..
drwxr-xr-x  3 root root      4096 May 21 22:36 current
-rw-r--r--  1 root root        37 May 21 22:36 fsid
-rw-r--r--  1 root root 536870912 May 21 22:36 journal
drwx------  2 root root     16384 May  9 15:06 lost+found
-rw-r--r--  1 root root         4 May 21 22:36 store_version

Is anyone have some idea ??

--=20
-----
Pozdrawiam

S=B3awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
