From: Prashanth Nednoor <Prashanth.nednoor@taec.toshiba.com>
Subject: Having issues trying to get the OSD up on a MIPS64!!!
Date: Thu, 23 Oct 2014 01:28:28 +0000 (UTC)
Message-ID: <loom.20141023T030922-990@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50770 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069AbaJWBaF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Oct 2014 21:30:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1Xh7E3-0002I4-3g
	for ceph-devel@vger.kernel.org; Thu, 23 Oct 2014 03:30:03 +0200
Received: from 209.243.128.191 ([209.243.128.191])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 23 Oct 2014 03:30:03 +0200
Received: from Prashanth.nednoor by 209.243.128.191 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Thu, 23 Oct 2014 03:30:03 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello Everyone,

We are using ceph-0.86, good news is we were able to compile and load=20
all the libraries and binaries needed to configure a CEPH-OSD on MIPS 6=
4=20
platform. The CEPH monitor is also able to detect the OSD, but not up=20
yet, as the osd activate failed.
Since we don=E2=80=99t have the required CEPH deploy utility for MIPS64=
, we are=20
following the manual procedure to create and activate an OSD.
We have disabled authentication between the clients and the OSD=E2=80=99=
s for=20
now.

Has any body tried CEPH on a MIPS64?
/dev/sda is a 2TB local hard drive.

This is how my partition looks after ceph-disk-prepare
/home/prashan/ceph-0.86/src# parted
GNU Parted 2.3
Using /dev/sda
Welcome to GNU Parted! Type 'help' to view a list of commands.
(parted) p
Model: ATA TOSHIBA MQ01ABB2 (scsi)
Disk /dev/sda: 2000GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt

Number  Start   End     Size    File system  Name          Flags
 2      1049kB  5369MB  5368MB               ceph journal
 1      5370MB  2000GB  1995GB  xfs          ceph data



The following are the steps to create an OSD
1)	ceph-disk zap /dev/sda
2)	ceph-disk-prepare --cluster  f615496c-b40a-4905-bbcd-
2d3e181ff21a --fs-type xfs /dev/sda
3)	mount /dev/sda1 /var/lib/ceph/osd/ceph-0/
4)	ceph-osd -i 0 =E2=80=93mkfs is giving an error ,=20
filestore(/var/lib/ceph/osd/ceph-0) could not find=20
23c2fcde/osd_superblock/0//-1 in index: (2) No such file.
After this it segfaults. We have analyzed this further with the help of=
=20
strace and root caused this as objectmap file reading issue.
open("/var/lib/ceph/osd/ceph-0/current/omap/000005.log", O_RDONLY) =3D =
11,=20
the first time it reads 32k, the read succeeds with 63 bytes and it
tries to read again with 27k and the read returns 0 bytes and the CEPH=20
osd segfaults.

Please note that ceph-disk prepare creates a journal in a path which is=
=20
not valid(dev/disk/by-partuuid/cbd4a5d1-012f-4863-b492-080ad2a505cb).
So after step3 above I remove this journal below and manually create a=20
journal file before doing step4 above.


ls -l /var/lib/ceph/osd/ceph-0/
total 16
-rw-r--r-- 1 root root 37 Oct 22 21:40 ceph_fsid
-rw-r--r-- 1 root root 37 Oct 22 21:40 fsid
lrwxrwxrwx 1 root root 58 Oct 22 21:40 journal -> /dev/disk/by-
partuuid/cbd4a5d1-012f-4863-b492-080ad2a505cb
-rw-r--r-- 1 root root 37 Oct 22 21:40 journal_uuid
-rw-r--r-- 1 root root 21 Oct 22 21:40 magic

Any pointers to move ahead will be greatly appreciated??

thanks
Prashanth



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
