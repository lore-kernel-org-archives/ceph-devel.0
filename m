From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure coding implementation : high level description
Date: Sat, 29 Jun 2013 18:56:08 +0200
Message-ID: <51CF11A8.2070208@dachary.org>
References: <51C9D65F.8000507@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig94863B0F0F5CE4A6D4F72CB8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:47039 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab3F2Q4S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 29 Jun 2013 12:56:18 -0400
In-Reply-To: <51C9D65F.8000507@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig94863B0F0F5CE4A6D4F72CB8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

The level of understanding of ReplicatedPG/PG/OSD required to sketch the =
path for implementing the erasure coding is beyond me at the moment. A fe=
w hours of browsing demonstrated that a number of important areas are sti=
ll unknown to me. A meaningfull example is probably the logic associated =
with=20

struct AccessMode {

https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f58=
2/src/osd/ReplicatedPG.h#L114

I suspect there are a number of similarities with the erasure code that w=
ould be relevant to ensure that a stripe is fully written to disk ( i.e. =
in relation with the "ondisk" acknowledgment probably ) before removing t=
he previous version of the same stripe from all OSDs supporting it.

The time spent during this exploration was not wasted, I learnt a few thi=
ngs that will be useful :-) But I think it would be more useful for me to=
 work on a more modest task to move in the direction of the erasure codin=
g implementation.

Cheers

On 06/25/2013 07:41 PM, Loic Dachary wrote:
> Hi Sage,
>=20
> Paraphrasing what you suggested today :=20
>=20
> The logic for writing a stripe ( i.e. all the chunks created by the era=
sure encoding function for a given object or part of a given object if it=
 exceeds the maximum size of a stripe ) for a single object is going to b=
e done in a way that is not the same as what we currently have for replic=
ated objects. The object is consistent when all chunks ( or at least K if=
 K+M ) are committed to disk. It may make sense to start writing all the =
chunks in parallel and when they are acknowledged, send a pg_log event th=
at says : now switch to this new version of the object. To avoid ending u=
p with chunks that are partially for one version of the object and other =
chunks partially for another version of the object and we can't repair an=
y of them.=20
>=20
> I will try to sketch the path for implementing the erasure coding ( inc=
luding the above ) by adding to https://github.com/dachary/ceph/blob/wip-=
4929/doc/dev/osd_internals/erasure-code.rst
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig94863B0F0F5CE4A6D4F72CB8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHPEa4ACgkQ8dLMyEl6F23aVACePola5AQ2NIxQTk8+pI6sofax
io4AnRJfOkMd2LKlwQdoCnxvrfzx76nQ
=A72C
-----END PGP SIGNATURE-----

--------------enig94863B0F0F5CE4A6D4F72CB8--
