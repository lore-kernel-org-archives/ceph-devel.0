From: Loic Dachary <loic@dachary.org>
Subject: Docker containers & teuthology
Date: Thu, 30 Oct 2014 00:54:18 +0100
Message-ID: <54517E2A.8060602@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="J9dcLcbTIgXtEiR3EKsiVhOFgu0OocdUM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55935 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757482AbaJ2XyZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 19:54:25 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack.cerza@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--J9dcLcbTIgXtEiR3EKsiVhOFgu0OocdUM
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I documented a quick hack to provide docker targets to teuthology at http=
://dachary.org/?p=3D3330 . This is my way to figure out what's what and t=
here are so many problems in this hack that it's probably not even worth =
a review. A number of other topics require my attention and I don't expec=
t to return to this before a few weeks. I'm quite excited about this thou=
gh and it makes me dream of a full functional teuthology installation on =
my laptop. It would be  blessing when / if the lab is busy with more impo=
rtant things. I guess my 16GB RAM laptop can accommodate 4 to 6 container=
s and probably allow me to schedule a small suite ( https://github.com/ce=
ph/ceph-qa-suite/tree/master/suites/rados/thrash-erasure-code comes to mi=
nd ;-) while working on something else.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--J9dcLcbTIgXtEiR3EKsiVhOFgu0OocdUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRRfioACgkQ8dLMyEl6F206UACgwIv9bo8IRmLF5jRU6tpgkPVq
ONMAmwWv4AVp95c2mfmzVI+33rkgLBgl
=vHO0
-----END PGP SIGNATURE-----

--J9dcLcbTIgXtEiR3EKsiVhOFgu0OocdUM--
