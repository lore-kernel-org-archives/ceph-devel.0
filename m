From: Loic Dachary <loic@dachary.org>
Subject: Re: puzzling disapearance of /dev/sdc1
Date: Fri, 18 Dec 2015 17:32:02 +0100
Message-ID: <56743502.4010406@dachary.org>
References: <5672AAD7.8030004@dachary.org>
 <alpine.DEB.2.00.1512170530200.10312@cobra.newdream.net>
 <5672C258.1020700@dachary.org>
 <CAOi1vP_602U1BB0+epJ6ROJjiF7d-1uLv75M_SYPDeR2Oa47ig@mail.gmail.com>
 <5673FE37.8010408@dachary.org>
 <CAOi1vP_2s7KFvxWJZSJB-=rY0eA7GR7AqAvaKHcQfkUWtOr+hg@mail.gmail.com>
 <56743316.1040805@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4rh8rBCrvQpscaueWA6EOagoriQLQkcgg"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52665 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932151AbbLRQcF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Dec 2015 11:32:05 -0500
In-Reply-To: <56743316.1040805@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4rh8rBCrvQpscaueWA6EOagoriQLQkcgg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


>> AFAICT udevd started doing this in v214.

Do you have a specific commit / changelog entry in mind ? I'd like to add=
 it to the commit message fixing the problem reference.

Thanks !


--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--4rh8rBCrvQpscaueWA6EOagoriQLQkcgg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZ0NQIACgkQ8dLMyEl6F20P+wCfTIPyclI7KiGkVrrSWIkbtAZg
mDoAnAj9ZdwD8sxiwKLhlt2HaoKKNlcy
=n3pE
-----END PGP SIGNATURE-----

--4rh8rBCrvQpscaueWA6EOagoriQLQkcgg--
