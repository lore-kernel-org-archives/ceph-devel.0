From: Loic Dachary <loic@dachary.org>
Subject: PGLog API : missing
Date: Thu, 20 Jun 2013 16:38:29 +0200
Message-ID: <51C313E5.8020408@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9A8D4804735AABA96F232BE5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:45375 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984Ab3FTOic (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jun 2013 10:38:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9A8D4804735AABA96F232BE5
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I tried to consider the part of the API of PGLog related to pg_missing_t,=
 looking at what it currently is and what it should be. At the moment it =
is ( not considering the methods that have a side effect on both missing =
and log ):

Accessor:

  const pg_missing_t& get_missing() const { return missing; }

Actors:

  void missing_add(const hobject_t& oid, eversion_t need, eversion_t have=
)
  void revise_need(hobject_t oid, eversion_t need)   void revise_have(hob=
ject_t oid, eversion_t have)

  void missing_got(map<hobject_t, pg_missing_t::item>::const_iterator m)
  void missing_rm(map<hobject_t, pg_missing_t::item>::const_iterator m)

The get_missing read only accessor is used in PG.{cc,h}, OSD.{cc,h}, Repl=
icated.{cc,h} It is used in dozen of different ways and I'm not sure if i=
t would make sense to define an API to replace them. I fail to see a patt=
ern that would be useful.

The missing_add method is used by ReplicatedPG::recover_object_replicas a=
nd  PG::repair_object The revise_have method is used by ReplicatedPG::sub=
mit_push_data
The revise_need method is used by ReplicatedPG::mark_all_unfound_lost whe=
n handling pg_log_entry_t::LOST_REVERT
The missing_got method is used by ReplicatedPG::mark_all_unfound_lost whe=
n handling pg_log_entry_t::LOST_MARK
The missing_rm method is used by ReplicatedPG::mark_all_unfound_lost when=
 handling pg_log_entry_t::LOST_DELETE

All these make sense to me. But I'm looking at what is currently in place=
 rather than thinking about what it should become to accomodate for erasu=
re coding.

With erasure_coding one OSD contains a chunk. If it is lost, it will not =
be copied from another OSD, it will be repaired by using the content of o=
ther OSDs. For instance; if the chunk object 4 version 1,2 is not in OSD =
3 the other chunks objects will be fetched from the remaining OSDs, the r=
epair function will then be called using their content to create the chun=
k object 4 version 1,2. Instead of fetching a copy of the missing object =
from one OSD, the code would fetch chunk objects from multiple OSDs to be=
 able to repair.
Because pg_missing_t is dealing with the missing objects for a single OSD=
, it may not need to be modified when used in the context of erasure codi=
ng.

Am I making any sense ? I'm not sure ;-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.




--------------enig9A8D4804735AABA96F232BE5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHDE+UACgkQ8dLMyEl6F23hEwCgoOkQhZNjeLXgXbb4iXhxfvR+
lUUAnRCn60Jh0uc4grZswZosSA38rd4D
=rY5/
-----END PGP SIGNATURE-----

--------------enig9A8D4804735AABA96F232BE5--
