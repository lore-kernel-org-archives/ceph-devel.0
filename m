From: Loic Dachary <loic@dachary.org>
Subject: Re: firefly timing
Date: Mon, 03 Feb 2014 18:29:20 +0100
Message-ID: <52EFD1F0.1050808@dachary.org>
References: <alpine.DEB.2.00.1402030819030.6345@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="1cC6LqqsM7Pc8p5g9vcCUj3vmIKNRe9Q9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:60159 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886AbaBCR3W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2014 12:29:22 -0500
In-Reply-To: <alpine.DEB.2.00.1402030819030.6345@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1cC6LqqsM7Pc8p5g9vcCUj3vmIKNRe9Q9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

I'm both happy and stressed out to have more time to work on erasure code=
 :-) If I'm not mistaken, the Firefly freeze is now set to Friday 14th, 2=
014. During this time I plan to focus on implementing whatever is require=
d for Erasure Code to work with the default jerasure plugin ( I'm thinkin=
g https://github.com/ceph/ceph/pull/1144 , https://github.com/ceph/ceph/p=
ull/1177 etc. ). If there is enough time, it would also be nice to have t=
he pyramid plugin https://github.com/ceph/ceph/pull/1142 merged in, but t=
his is not mandatory.

Is there a better use of my time during this sprint ?

Cheers

On 03/02/2014 17:21, Sage Weil wrote:
> The original firefly freeze date was Jan 17, but I added another sprint=
=20
> because there were several things that weren't quite ready yet (the cac=
he=20
> tier code and erasure coding).  Two weeks later we are much closer, but=
=20
> the EC functionality still needs a bit more time.  I would like to push=
=20
> out the freeze by one more sprint so that all of the code can land.  In=
=20
> particular, I would rather use the next sprint to get EC ready and shif=
t=20
> other development focus to stability early, instead of pulling last-min=
ute=20
> stuff in after the freeze date.
>=20
> This bends/breaks the 'train model' schedule we are aiming for, but my =

> assumption is that people are more interested in seeing the new=20
> functionality in place than in the exact timing.
>=20
> The only time dependency that I am aware of is the looming 14.04 freeze=
=20
> date.  I'm hoping that we can (worst case) put an -rc release in place =
and=20
> update as the code stabilizes over the next several weeks.  James, will=
=20
> this be problematic?
>=20
> Does anybody else have questions or concerns about adding in another=20
> sprint before we freeze for firefly?
>=20
> Thanks-=20
> sage
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--1cC6LqqsM7Pc8p5g9vcCUj3vmIKNRe9Q9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLv0fAACgkQ8dLMyEl6F22mYQCgxiypWLNFhjVJSrTBAN+Ssnuz
SP8Amwd2j2H9JXExgmSPlSa6CeCdRQNX
=tE61
-----END PGP SIGNATURE-----

--1cC6LqqsM7Pc8p5g9vcCUj3vmIKNRe9Q9--
