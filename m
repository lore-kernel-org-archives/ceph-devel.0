From: Loic Dachary <loic@dachary.org>
Subject: Backport tracker migration complete
Date: Fri, 22 May 2015 10:43:44 +0200
Message-ID: <555EEC40.3040106@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="oXaO3iB3hrEc5TQsRFmPUiEiCEUu3kxdQ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49019 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751355AbbEVIns (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 May 2015 04:43:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Shu, Xinxin" <xinxin.shu@intel.com>, Abhishek L <abhishek.lekshmanan@gmail.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oXaO3iB3hrEc5TQsRFmPUiEiCEUu3kxdQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

The Backport tracker should now be fully populated. There are new custom =
queries for:

  hammer backports http://tracker.ceph.com/projects/ceph/issues?query_id=3D=
78
  firefly backports http://tracker.ceph.com/projects/ceph/issues?query_id=
=3D79

and you can quickly see which one are assigned or not, scheduled for the =
next point release or not etc.=20

To see all issues that are Pending Backport, the former queries still wor=
k:

  hammer http://tracker.ceph.com/projects/ceph/issues?query_id=3D77
  firefly http://tracker.ceph.com/projects/ceph/issues?query_id=3D75

but you can now see links to the corresponding backports in the "Related =
issues" column. It makes it convenient to visually check which issues hav=
e been backported to all desired targets: there related issues are closed=
=2E

I'll update the documentation at http://tracker.ceph.com/projects/ceph-re=
leases/wiki/HOWTO accordingly.

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--oXaO3iB3hrEc5TQsRFmPUiEiCEUu3kxdQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVe7EAACgkQ8dLMyEl6F22wSwCfWLq5pN2cE7m46ySovZFZjCvD
FpUAn2B+O6PQqZE4SMF6r5nsn0H2tGqB
=LjCL
-----END PGP SIGNATURE-----

--oXaO3iB3hrEc5TQsRFmPUiEiCEUu3kxdQ--
