From: Loic Dachary <loic@dachary.org>
Subject: erasure code and coefficients
Date: Sun, 29 Jun 2014 11:30:01 +0200
Message-ID: <53AFDC99.9010009@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="72C5iC4igcdRd2tTqvKCXngPuAC31StRE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59825 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752383AbaF2JaI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Jun 2014 05:30:08 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--72C5iC4igcdRd2tTqvKCXngPuAC31StRE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

In http://anrg.usc.edu/~maheswaran/Xorbas.pdf I get the idea of computing=
 local coding chunks the way it is implemented in https://github.com/ceph=
/ceph/pull/1921 (i.e. delegating encoding / decoding to other plugins). H=
owever, there are theoretical aspects of the paper that I do not understa=
nd and I'm hoping you can shed some light on it. In particular, I don't k=
now what "coefficients" are about. For instance in the context of Figure =
2 caption : "The main theoretical challenge is to choose the coeffi=0Ecie=
nts c(i) to maximize the fault tolerance of the code."

Would you recommend a paper to read to better understand this ? Also I'd =
like to understand what "coefficients" mean in the context of jerasure or=
 if they do not apply.

Thanks for you help :-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--72C5iC4igcdRd2tTqvKCXngPuAC31StRE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOv3JkACgkQ8dLMyEl6F23VuACguhY2WUnUx7sdz3XO9Nas7CzW
f70Anjp4eOznFVVjbbKULYoWWCJehR1R
=vbh9
-----END PGP SIGNATURE-----

--72C5iC4igcdRd2tTqvKCXngPuAC31StRE--
