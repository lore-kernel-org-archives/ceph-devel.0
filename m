From: Sage Weil <sage@newdream.net>
Subject: Re: rbd - input/output error
Date: Mon, 14 Nov 2011 14:09:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111141401270.3717@cobra.newdream.net>
References: <4EBF98B5.7040706@b1-systems.de> <Pine.LNX.4.64.1111141148220.29742@cobra.newdream.net>
 <4EC18864.4010308@b1-systems.de> <Pine.LNX.4.64.1111141338160.3717@cobra.newdream.net>
 <4EC18F46.70102@b1-systems.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1557069858-1321308592=:3717"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48107 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148Ab1KNWJx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 17:09:53 -0500
In-Reply-To: <4EC18F46.70102@b1-systems.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mario van der Linde <linde@b1-systems.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1557069858-1321308592=:3717
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 14 Nov 2011, Mario van der Linde wrote:
> Hello,
>=20
> On 14.11.2011 22:39, Sage Weil wrote:
> [...]
> >> This one gave me some output:
> >> rbd create testimg --size=3D10240 --log-to-stderr 2 --debug-ms 2
> >>
> >> See attached file.
> >=20
> > It sounds like the OSD can't find the libcls_rbd.so file.  Can you veri=
fy=20
> > that it is in /usr/lib/rados-classes, and that that location isn't be=
=20
> > overridden by something in ceph.conf?
>=20
> At first, on all Systems this file exists, but in /usr/lib64, not /usr/li=
b:
> > ceph5:~ # for f in `seq 1 5`; do ssh ceph${f} ls -l /usr/lib64/rados-cl=
asses; done | grep ' libcls_rbd.so '
> > lrwxrwxrwx 1 root root    19 Nov 10 10:15 libcls_rbd.so -> libcls_rbd.s=
o.1.0.0
> > lrwxrwxrwx 1 root root    19 Nov 10 10:15 libcls_rbd.so -> libcls_rbd.s=
o.1.0.0
> > lrwxrwxrwx 1 root root    19 Nov 10 10:16 libcls_rbd.so -> libcls_rbd.s=
o.1.0.0
> > lrwxrwxrwx 1 root root    19 Nov 10 10:16 libcls_rbd.so -> libcls_rbd.s=
o.1.0.0
> > lrwxrwxrwx 1 root root    19 Nov 10 10:16 libcls_rbd.so -> libcls_rbd.s=
o.1.0.0
>=20
> Seems to be the right place in an x86_64 system.

Argh... For now, just add
=09osd class dir =3D /usr/lib64/rados-classes
and that will sort it out. =20

My last attempt to make automake fill in the @libdirpath@ correctly in=20
common/config_opts.h failed miserably, further entrenching my frustration=
=20
with autotools.  It's bug http://tracker.newdream.net/issues/1614, if=20
someone with better autotools-fu than I wants to fix this.  IIRC I tried a=
=20
few different methods but could only make it substitute in @prefix@/lib64,=
=20
but not /usr/lib64...

sage

>=20
> In ceph.conf there is no setting regarding to lib path.
>=20
> Is ceph-radosgw needed for rbd? I think not, while radosgw is AFAIK the
> REST interface...
> This package is not installed (due to a not resolveable cgi dependency).
>=20
>=20
> Regards
> Mario
>=20
>=20
> --=20
> Mario van der Linde
> Linux Consultant & Trainer
> Tel.: +49-151-16879485
> Mail: linde@b1-systems.de
>=20
> B1 Systems GmbH
> Osterfeldstra=DFe 7 / 85088 Vohburg / http://www.b1-systems.de
> GF: Ralph Dehner / Unternehmenssitz: Vohburg / AG: Ingolstadt,HRB 3537
>=20
>=20
--557981400-1557069858-1321308592=:3717--
