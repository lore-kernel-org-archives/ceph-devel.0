From: Loic Dachary <loic@dachary.org>
Subject: Pull requests : speed up the reviews
Date: Sat, 08 Nov 2014 18:32:37 +0100
Message-ID: <545E53B5.3070600@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="HqN0JfMiS1DRJk22STqPgULevmVAJ1kHU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33320 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753899AbaKHRck (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Nov 2014 12:32:40 -0500
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 4EB3742B45
	for <ceph-devel@vger.kernel.org>; Sat,  8 Nov 2014 18:32:37 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HqN0JfMiS1DRJk22STqPgULevmVAJ1kHU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

In the past few weeks the number of pending pull requests grew from aroun=
d 20 to over 80. The good thing is that there are more contributions, the=
 problem is that it requires more reviewers. Ceph is not the only project=
 suffering from this kind of problem and attending the OpenStack summit l=
ast week reminded me that the sooner it is addressed the better.

After a few IRC discussions some ideas came up and my favorite is that ev=
ery developer paid full time to work on Ceph dedicates a daily 15 minutes=
 time slot, time boxed, to review pull requests. Timeboxing is kind of fr=
ustrating because some reviews require more. It basically means one has t=
o focus on the pull request for ten minutes at most and take five minutes=
 to write a useful comment that helps the author moving forward. But it a=
lso is the only way to make room for a daily activity with no risk of pos=
tponing it because something more urgent came up.

What do you think ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--HqN0JfMiS1DRJk22STqPgULevmVAJ1kHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlReU7UACgkQ8dLMyEl6F21p3gCeOPq0G+1XxDyAEMHOD6/stX1Q
JzQAmwaBGVkNgAGsfQU1MwbPvyvvTY4H
=zm/z
-----END PGP SIGNATURE-----

--HqN0JfMiS1DRJk22STqPgULevmVAJ1kHU--
