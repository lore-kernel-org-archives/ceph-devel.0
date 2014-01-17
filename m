From: Loic Dachary <loic@dachary.org>
Subject: Re: Pyramid Erasure Code plugin (draft)
Date: Fri, 17 Jan 2014 12:00:32 +0100
Message-ID: <52D90D50.8080501@dachary.org>
References: <52D8FC5A.5090905@dachary.org> <CAGhffvwLtm1rJ68ORiASxDzfsOuo0y2YQvU3uLMUvxQOAA_d7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FoXb4WHFe2aMQ4JJslf42r0nvwtljhtpv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:46258 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974AbaAQLAe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 06:00:34 -0500
In-Reply-To: <CAGhffvwLtm1rJ68ORiASxDzfsOuo0y2YQvU3uLMUvxQOAA_d7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FoXb4WHFe2aMQ4JJslf42r0nvwtljhtpv
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 17/01/2014 11:34, Andreas-Joachim Peters wrote:
> Hi Loic,
>=20
> i think I don't understand if this works really for all cases and proba=
bly sysadmins will be lost without ready to use templates.

I agree, providing a sensible default is important. I'll draft something.=


> Can you write down with this syntax a rule like this:
>=20
> =3D> build 12 data chunks (d1...d12)
> =3D> build 6 RS chunks, distribute  (p1..p6)
> =3D> arrange them as : lp1=3D(d1,d2,d3,d4,p1,p2) lp2=3D(d5,d6,d7,d8,p3,=
p4) lp3=3D(d9,d10,d11,d12,p5,p6)
> =3D> map 21 stripes to 3 data center as: D1=3D(d1,d2,d3,d4,p1,p2,lp1) D=
2=3D(d5,d6,d7,d8,p3,p4,lp2) D3=3D(d9,d10,d11,d12,p5,p6,lp3)
> e.g. chunk(0...21) =3D (d1,d2,d3...lp1,d5,d6,d7...lp2,d9,d10,d11...lp3)=


Here is how it translates : http://tracker.ceph.com/issues/7146#note-2 ( =
replacing | with - ... maybe more readable ).

Does that make sense ?
>=20
> Thanks, Andreas.
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> On Fri, Jan 17, 2014 at 10:48 AM, Loic Dachary <loic@dachary.org <mailt=
o:loic@dachary.org>> wrote:
>=20
>     Hi Andreas,
>=20
>     I spent some time this week trying to figure out something that wou=
ld be reasonably generic, readable from the sysadmin point of view and si=
mple to implement. The input of the plugin is here:
>=20
>     http://tracker.ceph.com/issues/7146#note-1
>=20
>     The json structure describes the pyramid and associates an erasure =
code method with each layer, including parameters. The mapping describes =
how chunks relate to the list of OSDs obtained from crush. For instance i=
n |^000111^| the | are ignored ( whitespace is confusing because it's not=
 easy to figure out visually how many of them there are ), ^ marks a codi=
ng chunk, any other character is a data chunk. The pyramid encoding funct=
ion reads this and encode the first three data chunks with one coding chu=
nk. The re-ordering of the chunks is done by the pyramid code and the und=
erlying erasure code method does not need to know anything about it. Ther=
e is no copy involved, it re-orders pointers ( bufferptr ).
>=20
>     Here is a draft (not compiling not working but the logic looks righ=
t to me) implementation:
>=20
>     encode :
>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCod=
ePluginPyramid/ErasureCodePyramid.cc#L250
>=20
>     decode :
>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCod=
ePluginPyramid/ErasureCodePyramid.cc#L367
>=20
>     The plugins for each layer would be loaded at init time :
>=20
>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCod=
ePluginPyramid/ErasureCodePyramid.cc#L83
>=20
>     with as much consistency checks as possible, for instance:
>=20
>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCod=
ePluginPyramid/ErasureCodePyramid.cc#L102
>=20
>     so that runtime can assume constraints are enforced. Please let me =
know if you see something that does not look right, this is a draft, it c=
an be reworked 100% ;-)
>=20
>     Cheers
>=20
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--FoXb4WHFe2aMQ4JJslf42r0nvwtljhtpv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLZDVAACgkQ8dLMyEl6F22wvACeMG1nfBuftRuxIlfO6f96jvuu
GMIAoMFdaRIJPx1aqygZTE7HyW0fvUkZ
=odY5
-----END PGP SIGNATURE-----

--FoXb4WHFe2aMQ4JJslf42r0nvwtljhtpv--
