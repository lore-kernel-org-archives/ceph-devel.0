From: Denis Fondras <ceph@ledeuns.net>
Subject: Re: Ceph performance improvement
Date: Wed, 22 Aug 2012 18:23:25 +0200
Message-ID: <5035077D.8090707@ledeuns.net>
References: <50349E62.90405@ledeuns.net> <CADvuQRHQmK991u8NO3YH5qifTz-bj87YUfh2xmGRLrMVNZFGQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:33400 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab2HVQXb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Aug 2012 12:23:31 -0400
Received: from [IPv6:2a01:728:103:1::21] (unknown [IPv6:2a01:728:103:1::21])
	by mail.ledeuns.net (Postfix) with ESMTPSA id 2DA729325F
	for <ceph-devel@vger.kernel.org>; Wed, 22 Aug 2012 18:23:29 +0200 (CEST)
In-Reply-To: <CADvuQRHQmK991u8NO3YH5qifTz-bj87YUfh2xmGRLrMVNZFGQw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

>
> Are you sure your osd data and journal are on the disks you think? Th=
e
> /home paths look suspicious -- especially for journal, which often
> should be a block device.
>

I am :)

> Can you share output of "mount" and "ls -ld /home/osd.*"

Here are some details :

root@ceph-osd-0:~# ls -al /dev/disk/by-id/
lrwxrwxrwx 1 root root   9 ao=C3=BBt  21 21:19=20
scsi-SATA_C300-CTFDDAC06400000000104903008FE4 -> ../../sda
lrwxrwxrwx 1 root root   9 ao=C3=BBt  22 10:57=20
scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0124762 -> ../../sdh
lrwxrwxrwx 1 root root   9 ao=C3=BBt  21 16:03=20
scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0137898 -> ../../sdg
lrwxrwxrwx 1 root root   9 ao=C3=BBt  21 21:19=20
scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152201 -> ../../sdf
lrwxrwxrwx 1 root root   9 ao=C3=BBt  21 16:03=20
scsi-SATA_WDC_WD30EZRX-00_WD-WMAWZ0152562 -> ../../sdc

root@ceph-osd-0:~# mount
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
udev on /dev type devtmpfs=20
(rw,relatime,size=3D10240k,nr_inodes=3D1020030,mode=3D755)
devpts on /dev/pts type devpts=20
(rw,nosuid,noexec,relatime,gid=3D5,mode=3D620,ptmxmode=3D000)
tmpfs on /run type tmpfs (rw,nosuid,noexec,relatime,size=3D817216k,mode=
=3D755)
/dev/disk/by-uuid/7d95d243-1788-4c3f-9f89-166c15f880f0 on / type ext3=20
(rw,relatime,errors=3Dremount-ro,barrier=3D1,data=3Dordered)
tmpfs on /run/lock type tmpfs (rw,nosuid,nodev,noexec,relatime,size=3D5=
120k)
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,relatime,size=3D1634432k)
tmpfs on /run/shm type tmpfs (rw,nosuid,nodev,relatime,size=3D1634432k)
/dev/sda on /home type btrfs (rw,relatime,ssd,space_cache)
/dev/sdf on /home/osd.0 type btrfs (rw,noatime,space_cache)

root@ceph-osd-0:~# ls -ld /home/osd.*
drwxr-xr-x 1 root root        236 ao=C3=BBt  22 17:22 /home/osd.0
-rw-r--r-- 1 root root 1048576000 ao=C3=BBt  22 17:22 /home/osd.0.journ=
al

Regards,
Denis
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
