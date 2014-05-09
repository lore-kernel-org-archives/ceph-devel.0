From: Loic Dachary <loic@dachary.org>
Subject: Implied parity and erasure code
Date: Fri, 09 May 2014 17:35:22 +0200
Message-ID: <536CF5BA.8040300@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="33S3GcCRHJgmOqnWXVbiMX7AGMatUPoIW"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:60893 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755881AbaEIXHU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 May 2014 19:07:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--33S3GcCRHJgmOqnWXVbiMX7AGMatUPoIW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

The "implied parity bloc" mentionned page 4 of http://anrg.usc.edu/~mahes=
waran/Xorbas.pdf is something we've not discussed in the context of the i=
mplementation of the pyramid erasure code plugin. I'm not sure if it woul=
d be useful to have. Do you have an opinion ?=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--33S3GcCRHJgmOqnWXVbiMX7AGMatUPoIW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNs9boACgkQ8dLMyEl6F22kJQCfUIC5h36gDQvHoGWSbNijAhQz
gjkAnjvSS1hvWXsWXicM0atoopMhccwO
=tO4r
-----END PGP SIGNATURE-----

--33S3GcCRHJgmOqnWXVbiMX7AGMatUPoIW--
