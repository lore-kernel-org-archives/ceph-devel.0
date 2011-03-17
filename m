From: huang jun <hjwsm1989@gmail.com>
Subject: adding/removing osd problem
Date: Thu, 17 Mar 2011 08:08:44 +0800
Message-ID: <AANLkTimXAypm-DXDu6RC_VzPRE2K-Jx_RYZCRunAdwNP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48849 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132Ab1CQAIp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Mar 2011 20:08:45 -0400
Received: by vws1 with SMTP id 1so2303826vws.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 Mar 2011 17:08:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi=A3=AC
Recently, I try to do =A1=B0adding/removing osds =A1=B1 in ceph wiki
Here is what I ave done
<1> build a cluster with mon/mds/osd0 in the same machine =A1=B0host0=A1=
=B1
    And start it,everything is ok
<2> follow the wiki ceph ,add a disk (/dev/sdb4)into host0
   It=A1=AFs ok ,=A1=B1ceph osd dump =A8Co =A8C =A1=B0show that there a=
re two osds and
state are in/up
<3> write a 4G file
pull out the osd1 when it about writes 2G ,the osd1 was marked down
and 5 mins laster
it was marked out,but use =A1=B0df =A8Chl =A1=B1
I  find =A1=B0/dev/sdb4 885G  2.7M  885G   1% /data/osd1=A1=B1 (it=A1=AF=
s right?)
so when re-insert the disk ,=A1=B1 fdisk =A8Cl=A1=B0 show me:

Disk /dev/sda: 1000.2 GB, 1000204886016 bytes
255 heads, 63 sectors/track, 121601 cylinders
Units =3D cylinders of 16065 * 512 =3D 8225280 bytes
Disk identifier: 0x000d6542
   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1        3263    26210016   83  Linux
/dev/sda2            3264        6134    23061307+   f  W95 Ext'd (LBA)
/dev/sda3            6135      121601   927488677+  83  Linux
/dev/sda5            3264        4307     8385898+  82  Linux swap / So=
laris
/dev/sda6            4308        5612    10482381   83  Linux
/dev/sda7            5613        6134     4192933+  83  Linux

Disk /dev/sdc: 1000.2 GB, 1000204886016 bytes
255 heads, 63 sectors/track, 121601 cylinders
Units =3D cylinders of 16065 * 512 =3D 8225280 bytes
Disk identifier: 0x000549cb
   Device Boot      Start         End      Blocks   Id  System
/dev/sdc1   *           1        3263    26210016   83  Linux
/dev/sdc2            3264        6134    23061307+   f  W95 Ext'd (LBA)
/dev/sdc4            6135      121601   927488677+  83  Linux
/dev/sdc5            3264        4307     8385898+  82  Linux swap / So=
laris
/dev/sdc6            4308        5612    10482381   83  Linux
/dev/sdc7            5613        6134     4192933+  83  Linux

And finally I can not start osd1
Because =A1=B0/etc/init.d/ceph start osd1 =A1=B1 do nothing
Where is my problem?can you find it out for me?
thanks
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
