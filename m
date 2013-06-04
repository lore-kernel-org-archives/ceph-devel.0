From: Loic Dachary <loic@dachary.org>
Subject: PGLog::merge_log clarification
Date: Tue, 04 Jun 2013 22:18:12 +0200
Message-ID: <51AE4B84.7060609@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDF1101A7F34ACB4E8E7F759F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:58753 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390Ab3FDUSQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Jun 2013 16:18:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDF1101A7F34ACB4E8E7F759F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

When calling merge_log on the following : http://pastealacon.com/32449 ( =
where the first column are the versions of the log entries and the second=
 column are the versions of the olog entries ) I expect 5,2 and 6,1 from =
log to be added to divergent
https://github.com/ceph/ceph/blob/master/src/osd/PGLog.cc#L493
however, because the 1 from 6,1 compares lower than the 2 of 3,2 ( lower_=
bound ), the loop stops
https://github.com/ceph/ceph/blob/master/src/osd/PGLog.cc#L490
and divergent is empty.=20

I am missing something and a hint would be much appreciated :-)

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.




--------------enigDF1101A7F34ACB4E8E7F759F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGuS4QACgkQ8dLMyEl6F23R0QCgl9FCCtnNRIQz+S1ShUQqg5b+
p5kAoJqw23KJlEkAdiNhFN7Jd8f5vdw2
=15rL
-----END PGP SIGNATURE-----

--------------enigDF1101A7F34ACB4E8E7F759F--
