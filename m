From: Loic Dachary <loic@dachary.org>
Subject: teuthology rados runs for next
Date: Tue, 21 Jul 2015 10:44:23 +0200
Message-ID: <55AE0667.8020000@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="e53rPvkGe5cnLg38Cmr2PqObb7X2WirJE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53482 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754211AbbGUIoZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 04:44:25 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e53rPvkGe5cnLg38Cmr2PqObb7X2WirJE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I noticed today that http://pulpito.ceph.com/?suite=3Drados&branch=3Dnext=
 is lagging three days behind. Do we want to keep all the runs or should =
we kill the older ones ? I suppose there would be value in having the res=
ults for all of them but given the current load in the sepia lab it also =
significantly delays them. What do you think ?

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--e53rPvkGe5cnLg38Cmr2PqObb7X2WirJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWuBmcACgkQ8dLMyEl6F21+lwCdEqdMZUnetCNS3pRIfw2cO7OX
GjUAn0zbKmhaMPJ4tNv9uhSfHABjPqpP
=UclG
-----END PGP SIGNATURE-----

--e53rPvkGe5cnLg38Cmr2PqObb7X2WirJE--
