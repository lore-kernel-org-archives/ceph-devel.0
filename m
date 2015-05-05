From: Loic Dachary <loic@dachary.org>
Subject: release notes script dependencies
Date: Tue, 05 May 2015 20:56:25 +0200
Message-ID: <55491259.4010003@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4ugNw2aIA0CSM2JoVclqowMxfA1uMJ6Ni"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:58048 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752330AbbEES42 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 May 2015 14:56:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4ugNw2aIA0CSM2JoVclqowMxfA1uMJ6Ni
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

It would be useful to add instructions on what dependencies to pull to ru=
n http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_write_the_rel=
ease_notes. Something like

virtualenv /tmp/foo
=2E /tmp/foo/bin/activate
pip install GitPython # I recognized the library from the import ;-)
pip install ?? # I tried half a dozen but could not find one that matches=
 the import github semantic

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--4ugNw2aIA0CSM2JoVclqowMxfA1uMJ6Ni
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVJElkACgkQ8dLMyEl6F20IawCfcpRy4lPXgAV+3azeXMpay6i7
2T8AoLZT1z7Jg3t64PG9GcDy/Xc4Eiwb
=eYLO
-----END PGP SIGNATURE-----

--4ugNw2aIA0CSM2JoVclqowMxfA1uMJ6Ni--
