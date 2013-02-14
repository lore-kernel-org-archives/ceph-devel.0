From: charles L <charlesboy009@hotmail.com>
Subject: urgent journal conf on ceph.conf
Date: Thu, 14 Feb 2013 11:24:54 +0100
Message-ID: <DUB116-W25AEABD85893916143C7CFE00F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dub0-omc4-s35.dub0.hotmail.com ([157.55.2.110]:56773 "EHLO
	dub0-omc4-s35.dub0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753604Ab3BNKYz convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Feb 2013 05:24:55 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Pls can someone help me with the ceph.conf for 0.56.2. I have two serve=
rs for STORAGE with 3tb hard drives each and two SSD's each. =A0I want =
to use OSD data on the hard drive and osd journal on SSD.=A0

I want to know how osd journal configuration is set to SSD. My SSD is m=
ounted on /dev/sdb.

I have tried the osd data configurations =A0devs =3D /dev/sda and it wo=
rked just good.=A0

Is this line correct "osd journal =3D /dev/osd$id/journal" ?? and "=A0o=
sd journal =3D /dev/sdb " ???

[global]

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 auth cluster required =3D cephx
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 auth service required =3D cephx
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 auth client required =3D cephx
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 debug ms =3D 1

[osd]
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 osd journal size =3D 1000
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 osd journal =3D /dev/osd$id/journal
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 filestore xattr use omap =3D true
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 osd mkfs type =3D xfs
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 osd mkfs options xfs =3D -f
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 osd mount options xfs =3D rw,noatime,

[osd.0]
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D server04
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devs =3D /dev/sda
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 osd journal =3D /dev/sdb
[osd.1]
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host =3D server05
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devs =3D /dev/sda
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 osd journal =3D /dev/sdb

THANKS. 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
