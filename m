From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure coding implementation : high level description
Date: Fri, 05 Jul 2013 13:56:11 +0200
Message-ID: <51D6B45B.4010908@dachary.org>
References: <51C9D65F.8000507@dachary.org> <51CF11A8.2070208@dachary.org> <51D1F875.3080002@dachary.org> <alpine.DEB.2.00.1307012044220.18469@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9AEF97048005231E8C7E65E6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:57395 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757265Ab3GEL4O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jul 2013 07:56:14 -0400
In-Reply-To: <alpine.DEB.2.00.1307012044220.18469@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9AEF97048005231E8C7E65E6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

I wrote down my understanding of what you suggest in the "Interrupted app=
end" part of

https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_internals/erasu=
re-code.rst

did I miss something ?

Cheers

On 02/07/2013 05:52, Sage Weil wrote:
> We had a chat about this this afternoon and another idea came up: suppo=
rt=20
> only object append in full-stripe writes.  The primary would log the wr=
ite=20
> (as per usual), along with the write offset and length.  Each shard=20
> processes its piece and extends the file. If there is a failure and the=
 pg=20
> log gets rolled back, we simply truncate off the incompletely=20
> written/committed stripe from each shard.
>=20
> This is more limited (no overwrites yet, append-only) but captures the =

> most important use-cases, it's super simple, and it's efficient.  It's =

> also simple enough that I don't think it commits us in any particular=20
> direction if/when we later want to do per-stripe overwrites.
>=20
> One thing it does bring up, though is how the stripe size is determined=
=2E =20
> I suggest that it is specified by the writer on object creation (since =
the=20
> writer is responsible for writing in stripe-aligned chunks) and is=20
> recorded as immutable per-object metadata.  Maybe there is a per-pool=20
> property to inform clients, but that is mostly just policy...
>=20
> sage
>=20
>=20
>=20
>=20
> On Mon, 1 Jul 2013, Loic Dachary wrote:
>=20
>> For the record,
>>
>> Sam suggested today that the chunks of a stripe ( an object if we limi=
t ourselves to full writes ) are written without deleting the chunks from=
 a previous version of the object. i.e. for instance
>>
>> object A1 contains "ABCDEFGHI" =3D> version 1 of the object is written=
 as chunks "ABC" "DEF" "GHI" and "XYZ" parity on OSD1, OSD2, OSD3, OSD4 r=
espectively.
>> object A1 is updated to "ABCDEF123" =3D> version 2 of the object is wr=
itten as chunks "ABC" "DEF" "123" and "KLM" parity on OSD1, OSD2, OSD3, O=
SD4 respectively.
>>
>> At some point OSD3 contains both "GHI" ( chunk 3 object A1 version 1 )=
 and "123" ( chunk 3 object A1 version 2 ).
>>
>> When the PG receives an update of last_complete ( which should happen =
when the PG becomes active ) it knows that all objects with a version low=
er than last_complete can be discarded. It can then trim the objects stor=
ed on the OSD that have a version older than last_complete. With Replicat=
edPG this does not need to be done because the new version of the object =
overrides the previous one. It could be done together with pg_log trimmin=
g but it would waste more disk space because the default log size it by d=
efault 3000 meaning a chunk would only be deleted from disk after 3000 pg=
_log_entry were added to pg_log.=20
>>
>> The object name does not currently contain the version number and this=
 would need to be changed to avoid name clashes.
>>
>> Cheers
>>
>> On 29/06/2013 18:56, Loic Dachary wrote:
>>> Hi Sage,
>>>
>>> The level of understanding of ReplicatedPG/PG/OSD required to sketch =
the path for implementing the erasure coding is beyond me at the moment. =
A few hours of browsing demonstrated that a number of important areas are=
 still unknown to me. A meaningfull example is probably the logic associa=
ted with=20
>>>
>>> struct AccessMode {
>>>
>>> https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd154=
1f582/src/osd/ReplicatedPG.h#L114
>>>
>>> I suspect there are a number of similarities with the erasure code th=
at would be relevant to ensure that a stripe is fully written to disk ( i=
=2Ee. in relation with the "ondisk" acknowledgment probably ) before remo=
ving the previous version of the same stripe from all OSDs supporting it.=

>>>
>>> The time spent during this exploration was not wasted, I learnt a few=
 things that will be useful :-) But I think it would be more useful for m=
e to work on a more modest task to move in the direction of the erasure c=
oding implementation.
>>>
>>> Cheers
>>>
>>> On 06/25/2013 07:41 PM, Loic Dachary wrote:
>>>> Hi Sage,
>>>>
>>>> Paraphrasing what you suggested today :=20
>>>>
>>>> The logic for writing a stripe ( i.e. all the chunks created by the =
erasure encoding function for a given object or part of a given object if=
 it exceeds the maximum size of a stripe ) for a single object is going t=
o be done in a way that is not the same as what we currently have for rep=
licated objects. The object is consistent when all chunks ( or at least K=
 if K+M ) are committed to disk. It may make sense to start writing all t=
he chunks in parallel and when they are acknowledged, send a pg_log event=
 that says : now switch to this new version of the object. To avoid endin=
g up with chunks that are partially for one version of the object and oth=
er chunks partially for another version of the object and we can't repair=
 any of them.=20
>>>>
>>>> I will try to sketch the path for implementing the erasure coding ( =
including the above ) by adding to https://github.com/dachary/ceph/blob/w=
ip-4929/doc/dev/osd_internals/erasure-code.rst
>>>>
>>>> Cheers
>>>>
>>>
>>
>> --=20
>> Lo?c Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig9AEF97048005231E8C7E65E6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHWtFsACgkQ8dLMyEl6F210XACfTiiTIF/vzhP62i4LkzORw/7Y
ASYAoKJCpYDZdCn+EyqqzDTgIQ0BwR/S
=qHpY
-----END PGP SIGNATURE-----

--------------enig9AEF97048005231E8C7E65E6--
