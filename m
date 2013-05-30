From: Loic Dachary <loic@dachary.org>
Subject: Re: Mojette Transform implementation
Date: Thu, 30 May 2013 17:49:42 +0200
Message-ID: <51A77516.2040306@dachary.org>
References: <51A5E408.6070104@dachary.org> <CAD8-Aea7Z0Y40d6hTti_r+MXh0ECWazp1y0m9iYvP30qpX+LbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2B3FC01A8493451904D659E9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:54936 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756144Ab3E3Pto (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 11:49:44 -0400
In-Reply-To: <CAD8-Aea7Z0Y40d6hTti_r+MXh0ECWazp1y0m9iYvP30qpX+LbQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pierre Evenou <pierre.evenou@rozofs.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B3FC01A8493451904D659E9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Pierre,

I took a look at https://github.com/rozofs/rozofs/blob/master/src/rozofsm=
ount/rozofsmount.c#L1557
and it gave me a high level view of the fuse bindings of rozofs, thanks f=
or this :-)

I'm now looking into the functions that could be wrapped into a library i=
mplementing Mojette Transform so that it could be used by rozofs and ceph=
=2E Which file would you recommend I study for bootstraping this effort ?=


Cheers


On 05/29/2013 05:23 PM, Pierre Evenou wrote:
> 2013/5/29 Loic Dachary <loic@dachary.org <mailto:loic@dachary.org>>
>=20
>     Hi Pierre,
>=20
>     As discussed today over the phone, I'm very much interested in tryi=
ng to reuse the Mojette Transform implementation in the context of the wo=
rk related to the implementation of an erasure coded backend in Ceph. The=
 progress can be tracked from http://tracker.ceph.com/issues/5046 and the=
 sub-tickets and the original discussion from the last Ceph summit is at =
http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding_as=
_a_storage_backend
>=20
>=20
> Thanks for the links.
> =20
>=20
>     I was reading the code of rbs_restore_one_rb_entry at
>     https://github.com/rozofs/rozofs/blob/master/src/storaged/rbs.c#L10=
4
>     and assumed the implementation is in
>     https://github.com/rozofs/rozofs/blob/master/src/storaged/rbs_trans=
form.h
>     https://github.com/rozofs/rozofs/blob/master/src/storaged/rbs_trans=
form.cc
>=20
>     And also tried to understand http://en.wikipedia.org/wiki/Mojette_T=
ransform and bought "The Mojette Transform: Theory and Applications" http=
://eu.wiley.com/WileyCDA/WileyTitle/productCd-1848210809.html in the hope=
 to get more sense out of it ;-)
>=20
>     Is there a part of the rozofs code you would advise me to read firs=
t in order to understand how it works ?
>=20
>=20
> I would recommend to have a look to rozofsmount.c witch is a key part i=
n RozoFS.
> =20
>=20
>     Cheers
>=20
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>     All that is necessary for the triumph of evil is that good people d=
o nothing.
>=20
>=20
>=20
>=20
> --=20
> Pierre Evenou=E2=94=82+33.7.60.09.08.80=E2=94=82pierre.evenou@rozofs.co=
m <mailto:pierre.evenou@rozofs.com>=E2=94=82www.rozofs.com <http://www.ro=
zofs.com/>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.




--------------enig2B3FC01A8493451904D659E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGndRYACgkQ8dLMyEl6F22KrwCgw0cFaDf3mUR3zRM6sPlgOdPT
GSEAmgNoyT/Cwj2KD/pzOI/XwYkFksfl
=rN4n
-----END PGP SIGNATURE-----

--------------enig2B3FC01A8493451904D659E9--
