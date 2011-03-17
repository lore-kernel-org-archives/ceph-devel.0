From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: adding/removing osd problem
Date: Wed, 16 Mar 2011 17:16:44 -0700
Message-ID: <4D8152EC.5010200@hq.newdream.net>
References: <AANLkTimXAypm-DXDu6RC_VzPRE2K-Jx_RYZCRunAdwNP@mail.gmail.com>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48858 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036Ab1CQASE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2011 20:18:04 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 98065C066
	for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2011 17:18:03 -0700 (PDT)
Received: from [10.0.1.162] (ip-66-33-206-8.dreamhost.com [66.33.206.8])
	by mail.hq.newdream.net (Postfix) with ESMTP id 917F1C065
	for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2011 17:18:03 -0700 (PDT)
In-Reply-To: <AANLkTimXAypm-DXDu6RC_VzPRE2K-Jx_RYZCRunAdwNP@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: ceph-devel@vger.kernel.org

 From the looks of the fdisk output, it seems that the disk was not
recognized by the OS when it was reinserted? The OSD daemon won't be
able to start if the disk is not found.
-Sam

On 03/16/2011 05:08 PM, huang jun wrote:
> Hi=A3=AC
> Recently, I try to do =A1=B0adding/removing osds =A1=B1 in ceph wiki
> Here is what I ave done
> <1> build a cluster with mon/mds/osd0 in the same machine =A1=B0host0=
=A1=B1
>     And start it,everything is ok
> <2> follow the wiki ceph ,add a disk (/dev/sdb4)into host0
>    It=A1=AFs ok ,=A1=B1ceph osd dump =A8Co =A8C =A1=B0show that there=
 are two osds and
> state are in/up
> <3> write a 4G file
> pull out the osd1 when it about writes 2G ,the osd1 was marked down
> and 5 mins laster
> it was marked out,but use =A1=B0df =A8Chl =A1=B1
> I  find =A1=B0/dev/sdb4 885G  2.7M  885G   1% /data/osd1=A1=B1 (it=A1=
=AFs right?)
> so when re-insert the disk ,=A1=B1 fdisk =A8Cl=A1=B0 show me:
>
> Disk /dev/sda: 1000.2 GB, 1000204886016 bytes
> 255 heads, 63 sectors/track, 121601 cylinders
> Units =3D cylinders of 16065 * 512 =3D 8225280 bytes
> Disk identifier: 0x000d6542
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sda1   *           1        3263    26210016   83  Linux
> /dev/sda2            3264        6134    23061307+   f  W95 Ext'd (LB=
A)
> /dev/sda3            6135      121601   927488677+  83  Linux
> /dev/sda5            3264        4307     8385898+  82  Linux swap / =
Solaris
> /dev/sda6            4308        5612    10482381   83  Linux
> /dev/sda7            5613        6134     4192933+  83  Linux
>
> Disk /dev/sdc: 1000.2 GB, 1000204886016 bytes
> 255 heads, 63 sectors/track, 121601 cylinders
> Units =3D cylinders of 16065 * 512 =3D 8225280 bytes
> Disk identifier: 0x000549cb
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sdc1   *           1        3263    26210016   83  Linux
> /dev/sdc2            3264        6134    23061307+   f  W95 Ext'd (LB=
A)
> /dev/sdc4            6135      121601   927488677+  83  Linux
> /dev/sdc5            3264        4307     8385898+  82  Linux swap / =
Solaris
> /dev/sdc6            4308        5612    10482381   83  Linux
> /dev/sdc7            5613        6134     4192933+  83  Linux
>
> And finally I can not start osd1
> Because =A1=B0/etc/init.d/ceph start osd1 =A1=B1 do nothing
> Where is my problem?can you find it out for me?
> thanks
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
