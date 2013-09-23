From: Loic Dachary <loic@dachary.org>
Subject: Re: CEPH Erasure Encoding + OSD Scalability
Date: Mon, 23 Sep 2013 09:27:16 +0200
Message-ID: <523FED54.8040208@dachary.org>
References: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1388C4619227C3F9493A6140"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:42372 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288Ab3IWH1T (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Sep 2013 03:27:19 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4A527352B@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1388C4619227C3F9493A6140
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

Very inefficient implementation indeed :-) I've integrated your change in=


https://github.com/ceph/ceph/pull/619

Cheers

On 23/09/2013 01:00, Andreas Joachim Peters wrote:
>   alignment =3D k*w*packetsize*sizeof(int);
>   in_length +=3D (alignment - (in_length%alignment);

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig1388C4619227C3F9493A6140
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlI/7VQACgkQ8dLMyEl6F21PPgCeISHHv1Eih0QIP0ARaJ6T60jF
unkAn2qjGWM9eJxkA43gNiPYNPJxoZPP
=dCHB
-----END PGP SIGNATURE-----

--------------enig1388C4619227C3F9493A6140--
