From: Isaac Otsiabah <zmoo76b@yahoo.com>
Subject: what is the syntax  to use to specify xfs in ceph.conf
Date: Tue, 22 Jan 2013 11:16:45 -0800 (PST)
Message-ID: <1358882205.98747.YahooMailNeo@web121906.mail.ne1.yahoo.com>
Reply-To: Isaac Otsiabah <zmoo76b@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nm24-vm2.bullet.mail.ne1.yahoo.com ([98.138.91.212]:20852 "EHLO
	nm24-vm2.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753153Ab3AVTQr convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Jan 2013 14:16:47 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



When my ceph data drives use btrfs as the underneath fileystem, the dev=
ices in my ceph.conf contain the lines "btrfs devs =3D /dev/sdx" as sho=
wn below.


ceph.conf
=3D=3D=3D=3D=3D=3D=3D
=2E......
=2E......
=2E......
=2E.....

[osd.0]
=A0=A0=A0=A0=A0=A0=A0 host =3D host1
=A0=A0=A0=A0=A0=A0=A0 public address =3D 10.5.0.123
=A0=A0=A0=A0=A0=A0=A0 cluster address =3D 10.5.1.123
=A0=A0=A0=A0=A0=A0=A0 btrfs devs =3D /dev/sde

[osd.1]
=A0=A0=A0=A0=A0=A0=A0 host =3D host2
=A0=A0=A0=A0=A0=A0=A0 public address =3D 10.5.0.123
=A0=A0=A0=A0=A0=A0=A0 cluster address =3D 10.5.1.123
=A0=A0=A0=A0=A0=A0=A0 btrfs devs =3D /dev/sdf

=2E......
=2E......
=2E.....


Now, i want to use xfs as the underneath filesystem so in the ceph.conf=
 file, should the lines "btrfs devs =3D /dev/sdx" be changed to "xfs de=
vs =3D /dev/sdx" ?

Isaac

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
