From: Loic Dachary <loic@dachary.org>
Subject: Initializing paddles
Date: Fri, 24 Oct 2014 22:36:19 -0700
Message-ID: <544B36D3.8050103@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="961M71bbOJbHJ40U99xfHXiXnXj8dLxH3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52838 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751266AbaJYSf2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 25 Oct 2014 14:35:28 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack.cerza@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--961M71bbOJbHJ40U99xfHXiXnXj8dLxH3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Zack,

Now that I have a paddles server running, I'd like to populate it with tw=
o virtual machines I have running. Is there a script to do this or should=
 I just type  SQL statements to do that semi-intuitively ?=20

$ curl 'http://localhost:8080/nodes/?machine_type=3Dvps&count=3D2'
[]

Cheers=20
--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--961M71bbOJbHJ40U99xfHXiXnXj8dLxH3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRLNtMACgkQ8dLMyEl6F20iiQCeI28ncV2VrolPNQbl3gqS8Gcw
uxsAn2E+Vll1kR21B6dQxJnRclA7NxKV
=EnPD
-----END PGP SIGNATURE-----

--961M71bbOJbHJ40U99xfHXiXnXj8dLxH3--
