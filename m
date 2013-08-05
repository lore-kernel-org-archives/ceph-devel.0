From: Loic Dachary <loic@dachary.org>
Subject: Re: PG Backend Proposal
Date: Mon, 05 Aug 2013 12:29:02 +0200
Message-ID: <51FF7E6E.1030908@dachary.org>
References: <51FA8FF7.7090004@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigACE1980EBECA6C9EC1FE830C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:39660 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab3HEK3G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 06:29:06 -0400
In-Reply-To: <51FA8FF7.7090004@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigACE1980EBECA6C9EC1FE830C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

* snapshots/clones:

I assume we don't want to support snapshots/clones for erasure coded PG. =


If automatic tiering is implemented, snaphoting an object would be possib=
le when a replicated PG is tiered with an erasure coded PG. The erasure c=
oded PG would be used only for demoted objects coming from the replicated=
 PG (if they are not read for given period of time, for instance).=20

But what happens with objects that have snapshots ? The tiering policy co=
uld be to never demote an object with snapshots/clones. And to automatica=
lly promote an object when a snapshot/clone is created.=20

* watchers

The on disk info about watchers is included in object_info_t and will be =
persisted on each chunk in the OI_ATTR. Since there will be more chunks (=
 typically from 5 to 15 ) than replicas ( typically from 2 to 3 ) it mean=
s it will use more disk space but I'm under the impression that the avera=
ge number of watchers per object is big enough for this to be a concern. =
The in core structure and the associated logic does seem dependent on the=
 resilience policy. It could be moved entirely to the PGBackend implement=
ation if it's common to both.

* PGBackend + PGBackendInterface

It would probably help testing if the proposed PGBackend interface=20

https://github.com/ceph/ceph/blob/wip-erasure-coding-doc/src/osd/PGBacken=
d.h

was isolated in an abstract PGBackendInterface. ReplicatedPGBackend could=
 inherit from PGBackendInterface and PGBackend ( which would contain the =
common watcher related code, PGRegistry etc. ). That would allow unit tes=
t code to synthetize behavior by provding PGBackendInterface to PG.=20

https://github.com/ceph/ceph/blob/wip-erasure-coding-doc/doc/dev/osd_inte=
rnals/erasure_coding.rst

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigACE1980EBECA6C9EC1FE830C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH/fm8ACgkQ8dLMyEl6F201FQCfb2wYjKbrsqz8kmWA/SiTuRc5
2VMAnRa8PFOuKTkyAo3UeDwNTb/+gf5R
=UQLj
-----END PGP SIGNATURE-----

--------------enigACE1980EBECA6C9EC1FE830C--
