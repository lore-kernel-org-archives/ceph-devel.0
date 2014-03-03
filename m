From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure Code user guide
Date: Mon, 03 Mar 2014 23:58:39 +0100
Message-ID: <5315091F.4050204@dachary.org>
References: <53148187.2040408@dachary.org>	<531495F2.5040008@42on.com>	<5314A150.6050102@dachary.org> <CANygib86bmr_Bh=95XZ9M7a5V8PTN7inByhWLQ4vOzqctv1dmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8aqmnR6XBFCAjtQxm5dEV6sDq3b2lf5kB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:59545 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755005AbaCCW6l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Mar 2014 17:58:41 -0500
In-Reply-To: <CANygib86bmr_Bh=95XZ9M7a5V8PTN7inByhWLQ4vOzqctv1dmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neil Levine <neil.levine@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8aqmnR6XBFCAjtQxm5dEV6sDq3b2lf5kB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I should have checked the tracker. Thanks Neil :-) http://tracker.ceph.co=
m/issues/7548#note-1

On 03/03/2014 23:32, Neil Levine wrote:
> Loic, feel free to grab http://tracker.ceph.com/issues/7548
>=20
> The wiki is probably better for "opinionated" guides (preferred archite=
ctures, tuning tweaks etc) with the rst docs for man page style informati=
on.
>=20
> Neil
>=20
>=20
>=20
>=20
> On Mon, Mar 3, 2014 at 7:35 AM, Loic Dachary <loic@dachary.org <mailto:=
loic@dachary.org>> wrote:
>=20
>=20
>=20
>     On 03/03/2014 15:47, Wido den Hollander wrote:
>     > On 03/03/2014 02:20 PM, Loic Dachary wrote:
>     >> Hi John,
>     >>
>     >> I'd like to draft a user guide for erasure coded pools, oriented=
 toward system administrators. Where do you advise me to insert this ? Sh=
ould I get inspiration from an example ?
>     >>
>     >
>     > the docs dir isn't good for that? If not, might be that the Wiki =
is a proper location?
>=20
>     Are you suggesting something like doc/dev/erasure-coded-pool.rst ne=
xt to doc/dev/cache-pool.rst ? I'm not sure about the wiki.
>=20
>     Cheers
>=20
>     >
>     >> Thanks in advance for any pointers or advice :-)
>     >>
>     >
>     >
>=20
>     --
>     Lo=EFc Dachary, Artisan Logiciel Libre
>=20
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--8aqmnR6XBFCAjtQxm5dEV6sDq3b2lf5kB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMVCR8ACgkQ8dLMyEl6F22gAgCeLws7KyU7QpRaHA9QcuRFplzD
SL0AoJuu6AGMvtOw4V0GYuMDOyKb2lqQ
=uJem
-----END PGP SIGNATURE-----

--8aqmnR6XBFCAjtQxm5dEV6sDq3b2lf5kB--
