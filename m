From: Robert Sander <r.sander@heinlein-support.de>
Subject: Re: ceph-standalone
Date: Tue, 25 Feb 2014 09:46:49 +0100
Message-ID: <530C5879.5050800@heinlein-support.de>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>	<22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com>	<F33D6641-B3D1-4F25-9B7C-2269F2906908@enovance.com>	<187667BD-58E9-4E75-8A71-872C3EB88095@inktank.com>	<CAFMfnwqB6CTEtZibW_uww=k+jxFZxmsix-d5sxR115ZOGR+qpw@mail.gmail.com>	<CAGRK8cxE10daLT8EwWr-_s_NjaWj-D_COPKy3HvwVgO=4qWj9w@mail.gmail.com> <CA+xPSVC63jiZe5RY+Sq_HE4=vBCNR0Hn09ZXwz6_1GW3FBZsNQ@mail.gmail.com> <530C555F.1030902@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="X4375tn4bu2qkI0OOaMKovTelFAmD9jqv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3.heinlein-support.de ([91.198.250.30]:45082 "EHLO
	mx3.heinlein-support.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbaBYIxN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 03:53:13 -0500
In-Reply-To: <530C555F.1030902@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Ricardo Rocha <rocha.porto@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Stephan Seitz <s.seitz@heinlein-support.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--X4375tn4bu2qkI0OOaMKovTelFAmD9jqv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25.02.2014 09:33, Loic Dachary wrote:
>=20
>=20
> On 25/02/2014 04:34, Ricardo Rocha wrote:
>> I did it mostly to learn about docker (and because i wanted a 'cluster=

>> in the office' like Loic had :-)). Not incredibly pretty though.
>=20
> :-) Robert and Stephan created this nice office cluster and it would be=
 nice to know how it evolved.

The office cluster was a proof of concept. It worked and showed the
stability of Ceph as we never lost the whole cluster or any data.

It did not show any performance however as the machines and the network
were not up to the task. When rebalancing data it was nearly impossible
to use desktop applications in parallel so we had to decide to deinstall
Ceph from our workstations.

Evolution sometimes runs into a dead end. ;)

Regards
--=20
Robert Sander
Heinlein Support GmbH
Schwedter Str. 8/9b, 10119 Berlin

http://www.heinlein-support.de

Tel: 030 / 405051-43
Fax: 030 / 405051-19

Zwangsangaben lt. =C2=A735a GmbHG:
HRB 93818 B / Amtsgericht Berlin-Charlottenburg,
Gesch=C3=A4ftsf=C3=BChrer: Peer Heinlein -- Sitz: Berlin


--X4375tn4bu2qkI0OOaMKovTelFAmD9jqv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTDFh5AAoJEPC7kVgj3lsocjwP/iQPPIlVHwwevRAZzA/kAlT4
nd+bEQ6MgOi1rGbZhkZ8LKm3/vlErUFBV3SNizvzALFwPJFHjh5Cks2DeAs7TWmB
c5S4GjljSUDMH2GAWh6V6J3tPFrM1xrONRylyfy6YRF/aDXE91Jdbi3UnpOVSyYN
tV5nfJmI4uMsvtFwYr88qQL/J9xHmxBbH3efKtbiKn9Fn4vQBYoTRcoO4ERpaBRq
7eQo/PSu9YsEWI/lMnyUepSzPJZhalqG45neUwsEQGKSynoVqZzLvJNPP9V6S1ha
mH1n69JH10Db9U6ydLVWw3Ge867WjpOnZvugtcxk1foGfr182fawltg50hkgt0Lf
KIY7giQ/NzoXnKyt0tFv0oQa3/3YVgcb/hRNvCfV6OhoXtHJNaPzsrWBXtKKhhdE
bYsTruqgI8YVhqOJoMcqr4zxJAvWsUMP3Yy8yKZiSHWkVzRHfUvGKQZHWJIAD0u1
whsNoLX7NgIpiAlCYEtst1KDRRpLCRmL85kqj4lmQo7RQMi/n/IqJC4i9+RtQzJo
emp78IbMisr5S0DIWOsJz9xiIHmxdUb0xPYyESSHkDSeJtGTCmotEgPDB1CFUxN/
Pr3K1DoDt5AlyuB8/Lsq4Fr5HD5xR58ALFoNV5PWZ5OW9qE2IKFt9qX2T43UtSdd
Gdy/p/5GSxIKRP3gx1cP
=byM8
-----END PGP SIGNATURE-----

--X4375tn4bu2qkI0OOaMKovTelFAmD9jqv--
