From: Loic Dachary <loic@dachary.org>
Subject: Re: arm7 gitbuilder ?
Date: Fri, 10 Oct 2014 19:11:42 +0200
Message-ID: <5438134E.7050009@dachary.org>
References: <5437A6C0.3000005@dachary.org> <alpine.DEB.2.00.1410100809370.28531@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7mvxKmXjdiQRo0R54F57NMT1oQWDmq32B"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42093 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751928AbaJJRLt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 13:11:49 -0400
In-Reply-To: <alpine.DEB.2.00.1410100809370.28531@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Sandon Van Ness <sandon@inktank.com>, Janne Grunau <j@jannau.net>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7mvxKmXjdiQRo0R54F57NMT1oQWDmq32B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 10/10/2014 17:11, Sage Weil wrote:
> On Fri, 10 Oct 2014, Loic Dachary wrote:
>> Hi Sandon,
>>
>> Would it be possible to resurect / create an arm7 gitbuilder for=20
>> whatever distribution is more convenient ? Janne made a great=20
>> contribution to erasure code optimization on NEON (=20
>> https://bitbucket.org/jannau/gf-complete/branch/neon ) and it would ma=
ke=20
>> it easier to have a gitbuilder to run it throught teuthology and tortu=
re=20
>> it ;-) If that's complicated or there is another way to run teuthology=
=20
>> jobs for this purpose, I'm open to suggestions.
>=20
> We have a bunch of armv7l nodes that used to run distcc and a gitbuilde=
r. =20
> It's a bit of a time suck to maintain, though.  Is there an interested =

> party we can set up with lab access that can help administer these on a=
n=20
> ongoing basis?  Sandon is a highly contended resource.  :)

Long term I'm not sure. I'll try to setup something temporary and see whe=
re it goes. Is there a risk that these machines go away in the next 6 mon=
ths ? 3 months ?

Cheers

>=20
> Thanks!
> sage
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--7mvxKmXjdiQRo0R54F57NMT1oQWDmq32B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ4E04ACgkQ8dLMyEl6F21itwCeJyrG5Wi5aqlQjhJjQsUT3MCM
t5IAn1e1I6kTE0N6KySTQcWX02YONTRb
=C+QI
-----END PGP SIGNATURE-----

--7mvxKmXjdiQRo0R54F57NMT1oQWDmq32B--
