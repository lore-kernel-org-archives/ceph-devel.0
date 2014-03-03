From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure Code user guide
Date: Mon, 03 Mar 2014 21:18:54 +0100
Message-ID: <5314E3AE.9000308@dachary.org>
References: <53148187.2040408@dachary.org>	<531495F2.5040008@42on.com>	<5314A150.6050102@dachary.org>	<5314A9B2.2040907@42on.com> <CAM2gkg49zGSwVV8a0ui+MyNbdy0fL_TEFYDtOkPteVbGioOZyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TOrPWJr27NPBtx0dCr7atfvOGDumloC0G"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:59436 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbaCCUS4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 15:18:56 -0500
In-Reply-To: <CAM2gkg49zGSwVV8a0ui+MyNbdy0fL_TEFYDtOkPteVbGioOZyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Wilkins <john.wilkins@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TOrPWJr27NPBtx0dCr7atfvOGDumloC0G
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi John,

Thanks for the guidance, I'll do as you suggest.

Cheers

On 03/03/2014 21:14, John Wilkins wrote:
> Sorry Loic. I didn't see this earlier.=20
>=20
> I recommend putting it here: http://ceph.com/docs/master/rados/operatio=
ns/=20
>=20
> We already have a guide for pools here: http://ceph.com/docs/master/rad=
os/operations/pools/
>=20
> You could either add it to the pools.rst document or create another one=
 for erasure coding and cache tiering.
>=20
> Regards,
>=20
>=20
> John
>=20
>=20
>=20
> On Mon, Mar 3, 2014 at 8:11 AM, Wido den Hollander <wido@42on.com <mail=
to:wido@42on.com>> wrote:
>=20
>     On 03/03/2014 04:35 PM, Loic Dachary wrote:
>=20
>=20
>=20
>         On 03/03/2014 15:47, Wido den Hollander wrote:
>=20
>             On 03/03/2014 02:20 PM, Loic Dachary wrote:
>=20
>                 Hi John,
>=20
>                 I'd like to draft a user guide for erasure coded pools,=
 oriented toward system administrators. Where do you advise me to insert =
this ? Should I get inspiration from an example ?
>=20
>=20
>             the docs dir isn't good for that? If not, might be that the=
 Wiki is a proper location?
>=20
>=20
>         Are you suggesting something like doc/dev/erasure-coded-pool.rs=
t next to doc/dev/cache-pool.rst ? I'm not sure about the wiki.
>=20
>=20
>     Yes, why not? That way all the docs are in a central place.
>=20
>=20
>         Cheers
>=20
>=20
>                 Thanks in advance for any pointers or advice :-)
>=20
>=20
>=20
>=20
>=20
>=20
>     --=20
>     Wido den Hollander
>     42on B.V.
>=20
>     Phone: +31 (0)20 700 9902 <tel:%2B31%20%280%2920%20700%209902>
>     Skype: contact42on
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>     the body of a message to majordomo@vger.kernel.org <mailto:majordom=
o@vger.kernel.org>
>     More majordomo info at  http://vger.kernel.org/__majordomo-info.htm=
l <http://vger.kernel.org/majordomo-info.html>
>=20
>=20
>=20
>=20
> --=20
> John Wilkins
> Senior Technical Writer
> Intank
> john.wilkins@inktank.com <mailto:john.wilkins@inktank.com>
> (415) 425-9599
> http://inktank.com

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--TOrPWJr27NPBtx0dCr7atfvOGDumloC0G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMU464ACgkQ8dLMyEl6F23b3gCfTXi9bJ70WtFqADNDnjfNNEMS
PpcAoIUjkqZayXWMKqyiJN06gp+aRWe4
=tbJo
-----END PGP SIGNATURE-----

--TOrPWJr27NPBtx0dCr7atfvOGDumloC0G--
