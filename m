From: Samuel Just <samuelj@hq.newdream.net>
Subject: Re: adding/removing osd problem
Date: Thu, 17 Mar 2011 15:50:25 -0700
Message-ID: <4D829031.5090701@hq.newdream.net>
References: <AANLkTimXAypm-DXDu6RC_VzPRE2K-Jx_RYZCRunAdwNP@mail.gmail.com>	<4D8152EC.5010200@hq.newdream.net> <AANLkTik7ePGrLbvk1E4Sjotpj6dZ86nZooZZS-vfCwKN@mail.gmail.com>
Reply-To: samuel.just@dreamhost.com
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54225 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab1CQWvo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Mar 2011 18:51:44 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 343BEC066
	for <ceph-devel@vger.kernel.org>; Thu, 17 Mar 2011 15:51:44 -0700 (PDT)
Received: from [10.0.1.162] (ip-66-33-206-8.dreamhost.com [66.33.206.8])
	by mail.hq.newdream.net (Postfix) with ESMTP id 31A39C065
	for <ceph-devel@vger.kernel.org>; Thu, 17 Mar 2011 15:51:44 -0700 (PDT)
In-Reply-To: <AANLkTik7ePGrLbvk1E4Sjotpj6dZ86nZooZZS-vfCwKN@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

 Ah, that seems to be a bug in the init script. Are you using a recent
master branch?
-Sam

On 03/17/2011 12:20 AM, Upendra Moturi wrote:
> I too had the same problem.
> Only one option i found(just for testing)i had to stop the cluster an=
d
> start it again.
>
> /etc/init.d/ceph start osd<n> does not do anything as this not even
> going into start case .
>
>
> 2011/3/17 Samuel Just <samuelj@hq.newdream.net
> <mailto:samuelj@hq.newdream.net>>
>
>     From the looks of the fdisk output, it seems that the disk was no=
t
>     recognized by the OS when it was reinserted? The OSD daemon won't=
 be
>     able to start if the disk is not found.
>     -Sam
>
>     On 03/16/2011 05:08 PM, huang jun wrote:
>     > Hi=A3=AC
>     > Recently, I try to do =A1=B0adding/removing osds =A1=B1 in ceph=
 wiki
>     > Here is what I ave done
>     > <1> build a cluster with mon/mds/osd0 in the same machine =A1=B0=
host0=A1=B1
>     > And start it,everything is ok
>     > <2> follow the wiki ceph ,add a disk (/dev/sdb4)into host0
>     > It=A1=AFs ok ,=A1=B1ceph osd dump =A8Co =A8C =A1=B0show that th=
ere are two osds and
>     > state are in/up
>     > <3> write a 4G file
>     > pull out the osd1 when it about writes 2G ,the osd1 was marked =
down
>     > and 5 mins laster
>     > it was marked out,but use =A1=B0df =A8Chl =A1=B1
>     > I find =A1=B0/dev/sdb4 885G 2.7M 885G 1% /data/osd1=A1=B1 (it=A1=
=AFs right?)
>     > so when re-insert the disk ,=A1=B1 fdisk =A8Cl=A1=B0 show me:
>     >
>     > Disk /dev/sda: 1000.2 GB, 1000204886016 bytes
>     > 255 heads, 63 sectors/track, 121601 cylinders
>     > Units =3D cylinders of 16065 * 512 =3D 8225280 bytes
>     > Disk identifier: 0x000d6542
>     > Device Boot Start End Blocks Id System
>     > /dev/sda1 * 1 3263 26210016 83 Linux
>     > /dev/sda2 3264 6134 23061307+ f W95 Ext'd (LBA)
>     > /dev/sda3 6135 121601 927488677+ 83 Linux
>     > /dev/sda5 3264 4307 8385898+ 82 Linux swap / Solaris
>     > /dev/sda6 4308 5612 10482381 83 Linux
>     > /dev/sda7 5613 6134 4192933+ 83 Linux
>     >
>     > Disk /dev/sdc: 1000.2 GB, 1000204886016 bytes
>     > 255 heads, 63 sectors/track, 121601 cylinders
>     > Units =3D cylinders of 16065 * 512 =3D 8225280 bytes
>     > Disk identifier: 0x000549cb
>     > Device Boot Start End Blocks Id System
>     > /dev/sdc1 * 1 3263 26210016 83 Linux
>     > /dev/sdc2 3264 6134 23061307+ f W95 Ext'd (LBA)
>     > /dev/sdc4 6135 121601 927488677+ 83 Linux
>     > /dev/sdc5 3264 4307 8385898+ 82 Linux swap / Solaris
>     > /dev/sdc6 4308 5612 10482381 83 Linux
>     > /dev/sdc7 5613 6134 4192933+ 83 Linux
>     >
>     > And finally I can not start osd1
>     > Because =A1=B0/etc/init.d/ceph start osd1 =A1=B1 do nothing
>     > Where is my problem?can you find it out for me?
>     > thanks
>     > --
>     > To unsubscribe from this list: send the line "unsubscribe
>     ceph-devel" in
>     > the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     > More majordomo info at http://vger.kernel.org/majordomo-info.ht=
ml
>
>     --
>     To unsubscribe from this list: send the line "unsubscribe
>     ceph-devel" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --=20
> Thanks and Regards,
> Upendra.M

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
