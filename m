From: Loic Dachary <loic@dachary.org>
Subject: creating the issue for the v0.94.4 release
Date: Sat, 15 Aug 2015 12:30:35 +0200
Message-ID: <55CF14CB.1040900@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5t2WGpwokwsGXThAmEgU7JELpgj8xFsgE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38480 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbbHOKai (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Aug 2015 06:30:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5t2WGpwokwsGXThAmEgU7JELpgj8xFsgE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

I'll be driving the next hammer point release (v0.94.4) and theanalyst wi=
ll participate as I did for v0.94.3 (i.e. helping and mentoring when ther=
e is a need). During the v0.94.4 release you will have the opportunity to=
 participate in all the steps. When we move to v0.94.5 you'll hopefully k=
now all you need to drive it, should you want to. As you discovered over =
the past few weeks, it's not a complex process, but there are a lot of de=
tails.=20

Contrary to what I told you the other day

http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_backporti=
ng_a_stable_release/diff?utf8=3D%E2%9C%93&version=3D7&version_from=3D6&co=
mmit=3DView+differences

is not the documentation you need to create a new ticket for v0.94.4 and =
I removed this chapter to avoid further confusion. There is a more detail=
ed explanation at:

http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_working_o=
n_a_new_point_release

A section was added as a reminder that someone has to volunteer to drive =
the release.=20

http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_working_o=
n_a_new_point_release/diff?utf8=3D%E2%9C%93&version=3D9&version_from=3D8&=
commit=3DView+differences

Let me know if you need anything else to create the issue vor v0.94.4.

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--5t2WGpwokwsGXThAmEgU7JELpgj8xFsgE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXPFMsACgkQ8dLMyEl6F23DPgCgi8tECc4PY+hnObtGBl6FA0PL
ZsEAnRBL5I2Z6K1+9d429rKGj1fVJUlh
=Z9yl
-----END PGP SIGNATURE-----

--5t2WGpwokwsGXThAmEgU7JELpgj8xFsgE--
