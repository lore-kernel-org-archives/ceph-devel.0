From: Loic Dachary <loic@dachary.org>
Subject: Re: mon_command
Date: Thu, 20 Mar 2014 08:08:29 +0100
Message-ID: <532A93ED.2010305@dachary.org>
References: <39217F03-EC3A-4542-B00B-F62251B8CC98@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VkerT9VskJPPpnGpkQ2ppISAPOdGfRDTo"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:49040 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbaCTHIb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Mar 2014 03:08:31 -0400
In-Reply-To: <39217F03-EC3A-4542-B00B-F62251B8CC98@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VkerT9VskJPPpnGpkQ2ppISAPOdGfRDTo
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi David,


On 20/03/2014 03:40, David Zafman wrote:>=20
> My understanding is that are going to be using rados_mon_command() to c=
reate pools according to Tracker #7586: deprecate rados_pool_create.  Wha=
t I found when building a test case for EC is that after using the mon_co=
mmand to create the pool I need to use wait_for_latest_osdmap() in order =
to wait for the change to propagate.  The replicated pool test case using=
 pool_create() doesn=92t need to wait_for_latest_osdmap().
>=20
> Should we be deprecating librados calls in favor of the very generic mo=
n_command() interface? =20

> I would suggest that we add the appropriate librados features to manipu=
late erasure coded pools.

What do you have in mind ? There are osd erasure-code-profile, osd crush =
rule create-erasure and the additional arguments to osd pool create can b=
e used with rados_mon_command (or mon_command with the suggested implicit=
 wait_for_latest_osdmap ). Anything else ?

https://github.com/ceph/ceph/blob/master/doc/dev/erasure-coded-pool.rst

Cheers

>=20
> David Zafman
> Senior Developer
> http://www.inktank.com
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--VkerT9VskJPPpnGpkQ2ppISAPOdGfRDTo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMqk+0ACgkQ8dLMyEl6F20zuwCgl1RydqqRESXUrOctOcGygDRT
dpAAnR52qv+QpNb0sziFH1z/1hrM5vIQ
=qW+n
-----END PGP SIGNATURE-----

--VkerT9VskJPPpnGpkQ2ppISAPOdGfRDTo--
