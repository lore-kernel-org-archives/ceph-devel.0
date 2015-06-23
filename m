From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure pool with isa plugin
Date: Tue, 23 Jun 2015 06:15:03 -0400
Message-ID: <558931A7.9040501@dachary.org>
References: <BC97738F8E7C8742BABED7F06FB9DF91669A9C09@SATLEXDAG01.amd.com>	<55887F63.1000404@dachary.org> <CAC6JEv-qmFCwf1rdE6KnzcE=qQNgZr3AYpHwZ0OBNj2wcteSog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WSTkoOO1Puo1opX5Nn1SA7jF0tFso7McN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38668 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751055AbbFWKPG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 06:15:06 -0400
In-Reply-To: <CAC6JEv-qmFCwf1rdE6KnzcE=qQNgZr3AYpHwZ0OBNj2wcteSog@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "Deneau, Tom" <tom.deneau@amd.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WSTkoOO1Puo1opX5Nn1SA7jF0tFso7McN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 23/06/2015 06:06, Gregory Farnum wrote:
> On Mon, Jun 22, 2015 at 10:34 PM, Loic Dachary <loic@dachary.org> wrote=
:
>> Hi Tom,
>>
>> On 22/06/2015 17:10, Deneau, Tom wrote:
>>> If one has a cluster with some nodes that can run with the ISA plugin=

>>> and some that cannot, is there a way to define a pool such that the
>>> ISA-capable nodes can use the ISA plugin and the others can use say
>>> the jerasure plugin?
>>
>> There is no way to do that, because there is no guarantee that an obje=
ct encoded by jerasure can be decoded by isa and vice versa.
>=20
> Shouldn't we be able to set up something that *does* guarantee that,
> though? Either by combining them into a single plugin which
> dynamically configures to the fastest possible for that machine, or by
> running them against the same object corpus and requiring that they
> produce the same output?

I don't know enough about the maths involved to evaluate how difficult it=
 is. Although both implement Reed Solomon using Vandermonde or Cauchy mat=
rices, I think there are details that makes the output different.=20

Cheers

> -Greg
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--WSTkoOO1Puo1opX5Nn1SA7jF0tFso7McN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWJMacACgkQ8dLMyEl6F2252ACfWBaGtMlC1Fam+I73ouVZHCCw
qZIAoKOBA+f/PKFP29EfSlKQnCr/hraQ
=pyKS
-----END PGP SIGNATURE-----

--WSTkoOO1Puo1opX5Nn1SA7jF0tFso7McN--
