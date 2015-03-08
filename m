From: Loic Dachary <loic@dachary.org>
Subject: Adding custom queries to tracker.ceph.com for stable releases
Date: Sun, 08 Mar 2015 12:44:10 +0100
Message-ID: <54FC360A.6090201@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mxOlDDpQ9hrkT98fwquEDc5w4w7IWfRCo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:54643 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751904AbbCHLoN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Mar 2015 07:44:13 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ian Colle <icolle@redhat.com>, Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mxOlDDpQ9hrkT98fwquEDc5w4w7IWfRCo
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ian & Zack,

I'm addressing you today because you have admin rights on http://tracker.=
ceph.com/. When working on the next stable release for Ceph, I find conve=
nient to use a custom query that shows only what needs to be backported, =
grouped by project and sorted by severity. These queries are=20

http://tracker.ceph.com/projects/ceph/issues?query_id=3D71 for dumpling
http://tracker.ceph.com/projects/ceph/issues?query_id=3D74 for firefly
http://tracker.ceph.com/projects/ceph/issues?query_id=3D68 for giant

It would be great if they could be made public so I can share them with Y=
uri and other developers. I confess my ignorance of the redmine process t=
o do so. Your help would be much appreciated :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--mxOlDDpQ9hrkT98fwquEDc5w4w7IWfRCo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT8NgoACgkQ8dLMyEl6F20mBACgxKOZuCdjczhHw3QrUeCeyGUo
ihgAoL3FQl0S5LPkKalp0QR9jHce4Xrt
=+iXB
-----END PGP SIGNATURE-----

--mxOlDDpQ9hrkT98fwquEDc5w4w7IWfRCo--
