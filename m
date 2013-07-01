From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure coding implementation : high level description
Date: Mon, 01 Jul 2013 23:45:25 +0200
Message-ID: <51D1F875.3080002@dachary.org>
References: <51C9D65F.8000507@dachary.org> <51CF11A8.2070208@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4364B818BF8F230BDD3542D5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:37468 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828Ab3GAVp3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jul 2013 17:45:29 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 4676526394
	for <ceph-devel@vger.kernel.org>; Mon,  1 Jul 2013 23:45:27 +0200 (CEST)
In-Reply-To: <51CF11A8.2070208@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4364B818BF8F230BDD3542D5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

For the record,

Sam suggested today that the chunks of a stripe ( an object if we limit o=
urselves to full writes ) are written without deleting the chunks from a =
previous version of the object. i.e. for instance

object A1 contains "ABCDEFGHI" =3D> version 1 of the object is written as=
 chunks "ABC" "DEF" "GHI" and "XYZ" parity on OSD1, OSD2, OSD3, OSD4 resp=
ectively.
object A1 is updated to "ABCDEF123" =3D> version 2 of the object is writt=
en as chunks "ABC" "DEF" "123" and "KLM" parity on OSD1, OSD2, OSD3, OSD4=
 respectively.

At some point OSD3 contains both "GHI" ( chunk 3 object A1 version 1 ) an=
d "123" ( chunk 3 object A1 version 2 ).

When the PG receives an update of last_complete ( which should happen whe=
n the PG becomes active ) it knows that all objects with a version lower =
than last_complete can be discarded. It can then trim the objects stored =
on the OSD that have a version older than last_complete. With ReplicatedP=
G this does not need to be done because the new version of the object ove=
rrides the previous one. It could be done together with pg_log trimming b=
ut it would waste more disk space because the default log size it by defa=
ult 3000 meaning a chunk would only be deleted from disk after 3000 pg_lo=
g_entry were added to pg_log.=20

The object name does not currently contain the version number and this wo=
uld need to be changed to avoid name clashes.

Cheers

On 29/06/2013 18:56, Loic Dachary wrote:
> Hi Sage,
>=20
> The level of understanding of ReplicatedPG/PG/OSD required to sketch th=
e path for implementing the erasure coding is beyond me at the moment. A =
few hours of browsing demonstrated that a number of important areas are s=
till unknown to me. A meaningfull example is probably the logic associate=
d with=20
>=20
> struct AccessMode {
>=20
> https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f=
582/src/osd/ReplicatedPG.h#L114
>=20
> I suspect there are a number of similarities with the erasure code that=
 would be relevant to ensure that a stripe is fully written to disk ( i.e=
=2E in relation with the "ondisk" acknowledgment probably ) before removi=
ng the previous version of the same stripe from all OSDs supporting it.
>=20
> The time spent during this exploration was not wasted, I learnt a few t=
hings that will be useful :-) But I think it would be more useful for me =
to work on a more modest task to move in the direction of the erasure cod=
ing implementation.
>=20
> Cheers
>=20
> On 06/25/2013 07:41 PM, Loic Dachary wrote:
>> Hi Sage,
>>
>> Paraphrasing what you suggested today :=20
>>
>> The logic for writing a stripe ( i.e. all the chunks created by the er=
asure encoding function for a given object or part of a given object if i=
t exceeds the maximum size of a stripe ) for a single object is going to =
be done in a way that is not the same as what we currently have for repli=
cated objects. The object is consistent when all chunks ( or at least K i=
f K+M ) are committed to disk. It may make sense to start writing all the=
 chunks in parallel and when they are acknowledged, send a pg_log event t=
hat says : now switch to this new version of the object. To avoid ending =
up with chunks that are partially for one version of the object and other=
 chunks partially for another version of the object and we can't repair a=
ny of them.=20
>>
>> I will try to sketch the path for implementing the erasure coding ( in=
cluding the above ) by adding to https://github.com/dachary/ceph/blob/wip=
-4929/doc/dev/osd_internals/erasure-code.rst
>>
>> Cheers
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig4364B818BF8F230BDD3542D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHR+HUACgkQ8dLMyEl6F23xPgCeJ1rbE18PuJQ/5RoVZ85ltoRn
7v8An0QxctiENkDGs0jo7GXaq1yxs+3+
=y7oY
-----END PGP SIGNATURE-----

--------------enig4364B818BF8F230BDD3542D5--
