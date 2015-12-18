From: Loic Dachary <loic@dachary.org>
Subject: Re: puzzling disapearance of /dev/sdc1
Date: Fri, 18 Dec 2015 17:34:38 +0100
Message-ID: <5674359E.6020006@dachary.org>
References: <5672AAD7.8030004@dachary.org>
 <alpine.DEB.2.00.1512170530200.10312@cobra.newdream.net>
 <5672C258.1020700@dachary.org>
 <CAOi1vP_602U1BB0+epJ6ROJjiF7d-1uLv75M_SYPDeR2Oa47ig@mail.gmail.com>
 <5673FE37.8010408@dachary.org>
 <CAOi1vP_2s7KFvxWJZSJB-=rY0eA7GR7AqAvaKHcQfkUWtOr+hg@mail.gmail.com>
 <56743316.1040805@dachary.org> <56743502.4010406@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="paDcqd0mwiktLO8T76xoE9xeK4thMg7F0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52670 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932264AbbLRQek (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Dec 2015 11:34:40 -0500
In-Reply-To: <56743502.4010406@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--paDcqd0mwiktLO8T76xoE9xeK4thMg7F0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Nevermind, got it:

CHANGES WITH 214:

        * As an experimental feature, udev now tries to lock the
          disk device node (flock(LOCK_SH|LOCK_NB)) while it
          executes events for the disk or any of its partitions.
          Applications like partitioning programs can lock the
          disk device node (flock(LOCK_EX)) and claim temporary
          device ownership that way; udev will entirely skip all event
          handling for this disk and its partitions. If the disk
          was opened for writing, the close will trigger a partition
          table rescan in udev's "watch" facility, and if needed
          synthesize "change" events for the disk and all its partitions.=

          This is now unconditionally enabled, and if it turns out to
          cause major problems, we might turn it on only for specific
          devices, or might need to disable it entirely. Device Mapper
          devices are excluded from this logic.


On 18/12/2015 17:32, Loic Dachary wrote:
>=20
>>> AFAICT udevd started doing this in v214.
>=20
> Do you have a specific commit / changelog entry in mind ? I'd like to a=
dd it to the commit message fixing the problem reference.
>=20
> Thanks !
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--paDcqd0mwiktLO8T76xoE9xeK4thMg7F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZ0NZ4ACgkQ8dLMyEl6F22xpACfZmjQnZp2a6mTUSp0mj13fyiQ
6nUAoJd4kQRV7RJm4vPwsdtF2qtph+OD
=0K+k
-----END PGP SIGNATURE-----

--paDcqd0mwiktLO8T76xoE9xeK4thMg7F0--
