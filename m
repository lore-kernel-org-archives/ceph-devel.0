From: charles L <charlesboy009@hotmail.com>
Subject: testing ceph
Date: Thu, 31 Oct 2013 05:54:15 +0100
Message-ID: <DUB116-W8372DACD4F54B9145260E4E00B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dub0-omc4-s16.dub0.hotmail.com ([157.55.2.91]:26277 "EHLO
	dub0-omc4-s16.dub0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752452Ab3JaFA1 convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 31 Oct 2013 01:00:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,
Pls is this a good setup for a production environment test of ceph? My =
focus is on the SSD ... should it be partitioned(sdf1,2 ,3,4) and share=
d by the four OSDs on a host? or is this a better configuration for the=
 SSD to be just one partition(sdf1) while all osd uses that one partiti=
on?
my setup:
- 6 Servers with one 250gb boot disk for OS(sda),
four-2Tb Disks each for the OSDs i.e Total disks =3D 6x4 =3D 24 disks (=
sdb -sde)
and one-60GB SSD for Osd Journal(sdf).=A0
-RAM =3D 32GB on each server with 2 GB network link.
hostname for servers: Server1 -Server6

[osd.0]
=A0host =3D server1
devs =3D /dev/sdb
osd journal =3D /dev/sdf1
[osd.1]
host =3D server1
devs =3D /dev/sdc
osd journal =3D /dev/sdf2

[osd.3]
host =3D server1
devs =3D /dev/sdd
osd journal =3D /dev/sdf2

[osd.4]
host =3D server1
devs =3D /dev/sde
osd journal =3D /dev/sdf2
[osd.5]
host =3D server2
devs =3D /dev/sdb
osd journal =3D /dev/sdf2
=2E..
[osd.23]
host =3D server6
devs =3D /dev/sde
osd journal =3D /dev/sdf2

Thanks. 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
