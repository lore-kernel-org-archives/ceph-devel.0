From: Loic Dachary <loic@dachary.org>
Subject: Re: PGLog API : missing
Date: Sat, 06 Jul 2013 01:33:50 +0200
Message-ID: <51D757DE.4010304@dachary.org>
References: <51C313E5.8020408@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6FFBBD4434DEE547908A96BA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:40046 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab3GEXdx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jul 2013 19:33:53 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 53F5026394
	for <ceph-devel@vger.kernel.org>; Sat,  6 Jul 2013 01:33:51 +0200 (CEST)
In-Reply-To: <51C313E5.8020408@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6FFBBD4434DEE547908A96BA
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

For the record:

On 06/21/2013 06:42 PM, Samuel Just wrote:
> That seems like a reasonable break down for the missing set.  Rather
> than representing a full object, the missing set could be understood
> to represent whether an OSD has or is missing it's own piece of an
> object, whether that is a full copy or an erasure coded chunk.  The
> primary would use the missing sets to determine which osds are missing
> which chunks.


On 20/06/2013 16:38, Loic Dachary wrote:
> Hi Sam,
>=20
> I tried to consider the part of the API of PGLog related to pg_missing_=
t, looking at what it currently is and what it should be. At the moment i=
t is ( not considering the methods that have a side effect on both missin=
g and log ):
>=20
> Accessor:
>=20
>   const pg_missing_t& get_missing() const { return missing; }
>=20
> Actors:
>=20
>   void missing_add(const hobject_t& oid, eversion_t need, eversion_t ha=
ve)
>   void revise_need(hobject_t oid, eversion_t need)   void revise_have(h=
object_t oid, eversion_t have)
>=20
>   void missing_got(map<hobject_t, pg_missing_t::item>::const_iterator m=
)
>   void missing_rm(map<hobject_t, pg_missing_t::item>::const_iterator m)=

>=20
> The get_missing read only accessor is used in PG.{cc,h}, OSD.{cc,h}, Re=
plicated.{cc,h} It is used in dozen of different ways and I'm not sure if=
 it would make sense to define an API to replace them. I fail to see a pa=
ttern that would be useful.
>=20
> The missing_add method is used by ReplicatedPG::recover_object_replicas=
 and  PG::repair_object The revise_have method is used by ReplicatedPG::s=
ubmit_push_data
> The revise_need method is used by ReplicatedPG::mark_all_unfound_lost w=
hen handling pg_log_entry_t::LOST_REVERT
> The missing_got method is used by ReplicatedPG::mark_all_unfound_lost w=
hen handling pg_log_entry_t::LOST_MARK
> The missing_rm method is used by ReplicatedPG::mark_all_unfound_lost wh=
en handling pg_log_entry_t::LOST_DELETE
>=20
> All these make sense to me. But I'm looking at what is currently in pla=
ce rather than thinking about what it should become to accomodate for era=
sure coding.
>=20
> With erasure_coding one OSD contains a chunk. If it is lost, it will no=
t be copied from another OSD, it will be repaired by using the content of=
 other OSDs. For instance; if the chunk object 4 version 1,2 is not in OS=
D 3 the other chunks objects will be fetched from the remaining OSDs, the=
 repair function will then be called using their content to create the ch=
unk object 4 version 1,2. Instead of fetching a copy of the missing objec=
t from one OSD, the code would fetch chunk objects from multiple OSDs to =
be able to repair.
> Because pg_missing_t is dealing with the missing objects for a single O=
SD, it may not need to be modified when used in the context of erasure co=
ding.
>=20
> Am I making any sense ? I'm not sure ;-)
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig6FFBBD4434DEE547908A96BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlHXV94ACgkQ8dLMyEl6F23MlACghiFVUlJXETAwVOIWNFefeoRW
GCwAoKXmBAI4JktDqwMJvLbwJMb/FB5m
=E2xH
-----END PGP SIGNATURE-----

--------------enig6FFBBD4434DEE547908A96BA--
