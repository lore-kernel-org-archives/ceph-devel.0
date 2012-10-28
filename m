From: Andrey Korolyov <andrey@xdel.ru>
Subject: Different geoms for an rbd block device
Date: Sun, 28 Oct 2012 13:02:39 +0300
Message-ID: <CABYiri_v2mP61oHOM0G9ndSOKn=i7fPGHir9pSCXg-2z_5s0RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:33431 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab2J1KDD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 28 Oct 2012 06:03:03 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3779904obb.19
        for <ceph-devel@vger.kernel.org>; Sun, 28 Oct 2012 03:03:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

Should following behavior considered to be normal?

$ rbd map test-rack0/debiantest --user qemukvm --secret qemukvm.key
$ fdisk /dev/rbd1

Command (m for help): p

Disk /dev/rbd1: 671 MB, 671088640 bytes
255 heads, 63 sectors/track, 81 cylinders, total 1310720 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 4194304 bytes / 4194304 bytes
Disk identifier: 0x00056f14

     Device Boot      Start         End      Blocks   Id  System
/dev/rbd1p1            2048       63487       30720   82  Linux swap / Solaris
Partition 1 does not start on physical sector boundary.
/dev/rbd1p2           63488     1292287      614400   83  Linux
Partition 2 does not start on physical sector boundary.

Meanwhile, in the guest vm over same image:

fdisk /dev/vda

Command (m for help): p

Disk /dev/vda: 671 MB, 671088640 bytes
16 heads, 63 sectors/track, 1300 cylinders, total 1310720 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00056f14

   Device Boot      Start         End      Blocks   Id  System
/dev/vda1            2048       63487       30720   82  Linux swap / Solaris
/dev/vda2           63488     1292287      614400   83  Linux

The real pain starts when I try to repartition disk from after 'rbd
map' using its geometry - it simply broke partition layout, for
example, first block offset moves from 2048b to 8192. Of course I can
specify geometry by hand, but before that I may need to start vm at
least once or do something else which will print me out actual layout.

Thanks!
