From: Loic Dachary <loic@dachary.org>
Subject: Status update for the last Giant release 0.87.2
Date: Sat, 28 Mar 2015 12:10:16 +0100
Message-ID: <55168C18.9060307@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="aXno4A6gOD2Ev9Cl0VEoQeJrLXiuTAA8M"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38123 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751280AbbC1LKV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Mar 2015 07:10:21 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aXno4A6gOD2Ev9Cl0VEoQeJrLXiuTAA8M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Abhishek,

Looking at the last two issues marked as needing backport to giant:

http://tracker.ceph.com/projects/ceph/issues?query_id=3D68

(this link is at the top of http://tracker.ceph.com/projects/ceph-release=
s/wiki/HOWTO) I'm not sure what to do about http://tracker.ceph.com/issue=
s/10643. The problem is that it consistently shows up when testing upgrad=
es that involve giant. We want to be sure Giant can be upgraded to Hammer=
, therefore we need to keep testing the upgrades at least for a month or =
two after Hammer is released to catch border cases. I think issue 10643 n=
eeds to be fixed and included in 0.87.2 so that we can have clean upgrade=
 tests, otherwise it will mean more work for people watching over the upg=
rade suites (I mean Yuri here ;-). And wif 10643 is included we can squee=
ze http://tracker.ceph.com/issues/10153 in as well, I think.

Once this is dealt with and you're done with http://tracker.ceph.com/issu=
es/11259 that you found when running the rgw suite at http://tracker.ceph=
=2Ecom/issues/11153#rgw, 0.87.2 should be good, from our point of view (t=
he point of view of backporters) and we can move to the "asking approval"=
 step of the workflow ( http://tracker.ceph.com/issues/11153#Workflow ). =


What do you think ?

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--aXno4A6gOD2Ev9Cl0VEoQeJrLXiuTAA8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUWjBgACgkQ8dLMyEl6F22sVQCgwXSUobMzrRbHL5WWbcVj9nkJ
Ze0AoKZ6UFx1TovagOD687Nfm3k7gP6s
=YRm3
-----END PGP SIGNATURE-----

--aXno4A6gOD2Ev9Cl0VEoQeJrLXiuTAA8M--
