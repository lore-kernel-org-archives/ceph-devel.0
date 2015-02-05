From: Loic Dachary <loic@dachary.org>
Subject: RBD tests on the next dumpling release
Date: Thu, 05 Feb 2015 23:30:14 +0100
Message-ID: <54D3EEF6.1070701@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="nv1rxLovoLN4d3SbU6RreGCWwkLLfwLrI"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39495 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751079AbbBEWaR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Feb 2015 17:30:17 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>, Josh Durgin <jdurgin@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nv1rxLovoLN4d3SbU6RreGCWwkLLfwLrI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jason & Josh,

http://tracker.ceph.com/issues/10773 is the last unresolved issue for the=
 next dumpling point release. I tried to collect information about the pr=
oblem but I'm not sure if it should be a blocker or not. I suspect it's n=
ot but ... what do you think ?

For the record, the commits that are included in the backport branch bein=
g tested are summarized here : http://workbench.dachary.org/ceph/ceph-bac=
kports/wikis/dumpling up to and including http://workbench.dachary.org/ce=
ph/ceph-backports/wikis/dumpling#pull-requests-waiting-to-be-integrated

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--nv1rxLovoLN4d3SbU6RreGCWwkLLfwLrI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTT7vYACgkQ8dLMyEl6F23cKQCeMg26pU30wbvCL98fZCppSqvB
eOMAniR+dzw2b054TCwogIg/YRK7q44r
=ehpM
-----END PGP SIGNATURE-----

--nv1rxLovoLN4d3SbU6RreGCWwkLLfwLrI--
