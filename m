From: Loic Dachary <loic@dachary.org>
Subject: Re: Company affiliation transition
Date: Thu, 19 Jun 2014 17:50:02 +0200
Message-ID: <53A306AA.9090602@dachary.org>
References: <53A20ABB.4090406@dachary.org> <alpine.DEB.2.00.1406190837100.3251@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5ektaiHmfLH4IVFlXJNL5hXhVr2L2Br8N"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:49709 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757301AbaFSPuF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jun 2014 11:50:05 -0400
In-Reply-To: <alpine.DEB.2.00.1406190837100.3251@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5ektaiHmfLH4IVFlXJNL5hXhVr2L2Br8N
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 19/06/2014 17:39, Sage Weil wrote:
> On Wed, 18 Jun 2014, Loic Dachary wrote:
>> Hi,
>>
>> The simplest solution to keep the .organizationmap[1] file up to date =

>> regarding the Red Hat / InkTank acquisition would be to just wait for =

>> developers with an @inktank.com email to move to a @redhat.com email. =
I=20
>> guess the same could be applied to other company affiliation change, a=
s=20
>> long as all the company is absorbed. It does not work well when a sing=
le=20
>> individual moves from one company to another and keeps using her/his=20
>> personal email.
>=20
> I think it would be ideal if the same individual's contributions can be=
=20
> attributed to multiple organizations depending on which email they=20
> used, for exactly this reason.  The way that .organizationmap and .mail=
map=20
> are chained together makes this impossible, as far as I can tell?
> =20
>> Does anyone see a problem with this approach ?
>=20
> I'm not sure exactly what you're proposing...

Hi,

Sorry for being unclear, a commit will hopefully be better:

https://github.com/dachary/ceph/commit/de09adad2f9ede76727a87030c14123679=
3d997f

This associates all @inktank.com to Intkank and all @redhat.com to Red Ha=
t. If you use your @redhat.com email a commit will count as Red Hat. Othe=
rwise it counts as Inktank.

The .mailmap normalizes names to cope with mistakes but does not force a =
given individual to show under a single email.

Cheers

>=20
> sage
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--5ektaiHmfLH4IVFlXJNL5hXhVr2L2Br8N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOjBqoACgkQ8dLMyEl6F23aDwCgvFALI4VyPIgAG1/i7v29cA53
eDsAnRMY24NjwzFCZfC0hDzcMBv9bUAz
=hH95
-----END PGP SIGNATURE-----

--5ektaiHmfLH4IVFlXJNL5hXhVr2L2Br8N--
