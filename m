From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure encoding as a storage backend
Date: Sat, 04 May 2013 20:36:02 +0200
Message-ID: <51855512.20207@dachary.org>
References: <5185428B.6070109@dachary.org> <C93B376E-72EF-4822-9559-ECF6F2962AA7@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5F756A1CD855EE1B576C3916"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:52856 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab3EDSgF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 May 2013 14:36:05 -0400
In-Reply-To: <C93B376E-72EF-4822-9559-ECF6F2962AA7@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5F756A1CD855EE1B576C3916
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 05/04/2013 08:27 PM, Noah Watkins wrote:
>=20
> On May 4, 2013, at 10:16 AM, Loic Dachary <loic@dachary.org> wrote:
>=20
>> it would be great to get feedback before the ceph summit to address th=
e most prominent issues.
>=20
> One thing that has been in the back of my mind is how this proposal is =
influenced (if at all) by a future that includes declustered per-file rai=
d in CephFS. I realize that may be a distant future, but it seems as thou=
gh there could be a lot of overlap for the (non-client driven) rebuild/re=
covery component of such an architecture.

Hi Noah,

I'm not sure what declustered per-file raid is, which means it had no inf=
luence on this proposal ;-) Would you be so kind as to educate me ?

Cheers

> -Noah
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig5F756A1CD855EE1B576C3916
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGFVRIACgkQ8dLMyEl6F23F5wCcD+W6dwZMNurDnxjzOfTYWfOi
LPQAn1qSfXGZqVx6DQS/+fFpDRKVZkx6
=PXlL
-----END PGP SIGNATURE-----

--------------enig5F756A1CD855EE1B576C3916--
