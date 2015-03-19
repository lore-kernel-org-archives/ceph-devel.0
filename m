From: Loic Dachary <loic@dachary.org>
Subject: Keeping up with the backports
Date: Thu, 19 Mar 2015 15:44:41 +0100
Message-ID: <550AE0D9.8080107@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BE0SbMTeoOu57KxPAL7GnVCWTF2XbhSlc"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60972 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752838AbbCSOop (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 10:44:45 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alistair Israel <aisrael@gmail.com>, LOPEZ Jean-Charles <jelopez@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BE0SbMTeoOu57KxPAL7GnVCWTF2XbhSlc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alistair & Jean-Charles,

Thanks a lot for volunteering to work on the backports !

I have good news: the backlog of backports is almost empty. New backports=
 are being added every day and we are going to make sure they are handled=
 on a weekly basis so that point releases can be published every month or=
 so, if needed. To start small and learn as we make progress, I propose t=
o mentor you on a given point release, starting with cherry-picking backp=
orts and preparing an integration branch as described at http://tracker.c=
eph.com/projects/ceph-releases/wiki/Wiki (which is linked from the http:/=
/tracker.ceph.com/projects/ceph-releases/ landing page). The idea is that=
 once you feel confortable you can keep going on your own.

If you agree we can arrange an IRC meeting next week to bootstrap that. S=
ince we have multiple stable releases in flight at any given time, it can=
 conveniently be parallelized. If that's ok with you, Alistair could star=
t with Firefly and Jean-Charles with Dumpling.=20

Please let me know if you have any question :-)

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--BE0SbMTeoOu57KxPAL7GnVCWTF2XbhSlc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUK4NkACgkQ8dLMyEl6F22/WQCcCUVc/R792flxxL08/orupB58
vp4AninNfmi35extJbOPDBTJpsrwO8aZ
=Ddt7
-----END PGP SIGNATURE-----

--BE0SbMTeoOu57KxPAL7GnVCWTF2XbhSlc--
