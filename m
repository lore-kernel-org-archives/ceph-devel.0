From: =?UTF-8?B?0JLQsNGB0LjQu9C40Lkg0JDQvdCz0LDQv9C+0LI=?=
	<angapov@gmail.com>
Subject: Re: ceph-disk disk partition alignment
Date: Tue, 23 Feb 2016 15:09:19 +0800
Message-ID: <CAGtbiz0Ks4NU58YBjNoVNNUy1+gApMCZhuC7o3i4ti+r7M5rxA@mail.gmail.com>
References: <BN1PR02MB0555D538EB56A2908359F32F4A30@BN1PR02MB055.namprd02.prod.outlook.com>
	<56CBEA15.4090309@dachary.org>
	<BN1PR02MB0550FC810BB08A29F672683F4A40@BN1PR02MB055.namprd02.prod.outlook.com>
	<56CBF2DB.10602@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33478 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbcBWHJV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Feb 2016 02:09:21 -0500
Received: by mail-wm0-f53.google.com with SMTP id g62so187683516wme.0
        for <ceph-devel@vger.kernel.org>; Mon, 22 Feb 2016 23:09:20 -0800 (PST)
In-Reply-To: <56CBF2DB.10602@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

In my case (Hammer 0.94.5) I see actually the proper alignment made by
ceph-disk. Thing is that fdisk is not able to see GPT partitions:

root@slpeah001:[~]:# fdisk -l /dev/sdf

Disk /dev/sdf: 4000.8 GB, 4000787030016 bytes, 7814037168 sectors
Units =3D sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x00000000

   Device Boot      Start         End      Blocks   Id  System
/dev/sdf1               1  4294967295  2147483647+  ee  GPT
root@slpeah001:[~]:# gdisk -l /dev/sdf
GPT fdisk (gdisk) version 0.8.6

Partition table scan:
  MBR: protective
  BSD: not present
  APM: not present
  GPT: present

=46ound valid GPT with protective MBR; using GPT.
Disk /dev/sdf: 7814037168 sectors, 3.6 TiB
Logical sector size: 512 bytes
Disk identifier (GUID): E1063D97-3EFF-4F81-A08F-81D069625677
Partition table holds up to 128 entries
=46irst usable sector is 34, last usable sector is 7814037134
Partitions will be aligned on 2048-sector boundaries
Total free space is 2014 sectors (1007.0 KiB)

Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048      7814037134   3.6 TiB     FFFF  ceph data

So I think ceph-disk does things right... But  before I use ceph-disk
I create an empty GPT with gdisk.

2016-02-23 13:49 GMT+08:00 Loic Dachary <loic@dachary.org>:
> Here it is http://tracker.ceph.com/issues/14842
>
> On 23/02/2016 12:24, Somnath Roy wrote:
>> eph-deploy is creating data partition from sector 1 ignoring what sg=
disk is recommending (256 in my disk). Basically, it should be aligned =
with physical sector size (reported in /sys/block/<device>/queue/physic=
al_block_size). In my case it is 16K physical and 4K logical...256 is p=
erfectly fine as sgdisk/fdisk internally decides.
>>> Disk performance will be severely impacted because of partitioning =
this way from ceph-deploy ,
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
