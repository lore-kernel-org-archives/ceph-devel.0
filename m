From: Loic Dachary <loic@dachary.org>
Subject: Re: Reliability models
Date: Wed, 15 Jan 2014 00:44:13 +0100
Message-ID: <52D5CBCD.5000608@dachary.org>
References: <52D3A85E.4050301@dachary.org> <CAHxYaFP2Au1A61B=v3BZLhjdYEXDuO5C_0CLZy3O52TNy=asDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="F7X3Fn04ojo4nDWm5Ax57khrgvd5Oj43m"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:43552 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbaANXoQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jan 2014 18:44:16 -0500
In-Reply-To: <CAHxYaFP2Au1A61B=v3BZLhjdYEXDuO5C_0CLZy3O52TNy=asDg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F7X3Fn04ojo4nDWm5Ax57khrgvd5Oj43m
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Crystal clear, thanks !

On 13/01/2014 18:25, Kyle Bader wrote:
> Hi Loic,
>=20
>> IIRC you figured out how to use https://github.com/ceph/ceph-tools/tre=
e/master/models . Do you happen to have some kind of HOWTO or even the li=
st of commands you've used to get me started ?
>=20
> git clone ...ceph-tools
> cd ceph-tools/models/reliability
> ./main.py -g
>=20
> At this point a graphical form should pop up and most of it should be
> straight forward. NRE rate is non recoverable read errors, the NRE
> model determines how an array/disk responds to a non recoverable read
> error event. I tend to be on the conservative end having seen my share
> of RAID horror shows so I set the NRE model to "fail". The other
> gotcha is most disk manufacturers use MTBF or AFR while the
> reliability modeling tool requests FITS. The formula you will need is:
>=20
> MTBF =3D 1,000,000,000 x 1/FIT. [1]
>=20
> Stripe length is the number of RADOS objects that are require to store
> a blob of data, ie all RADOS objects that compose a RBD volume. Since
> this code was written a while ago there is no code to support modeling
> erasure coded objects. If you have any questions, let me know!
>=20
> [1] http://en.wikipedia.org/wiki/Failure_rate#Units
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--F7X3Fn04ojo4nDWm5Ax57khrgvd5Oj43m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLVy80ACgkQ8dLMyEl6F209WgCgikYfAoPw9f4AoutILZvIBJEf
oUUAniZUw6N2Tdr/hyeFx2d656z2cLl8
=rsK3
-----END PGP SIGNATURE-----

--F7X3Fn04ojo4nDWm5Ax57khrgvd5Oj43m--
