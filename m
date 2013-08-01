From: Loic Dachary <loic@dachary.org>
Subject: Re: PG Backend Proposal
Date: Thu, 01 Aug 2013 19:14:43 +0200
Message-ID: <51FA9783.4000206@dachary.org>
References: <51FA8FF7.7090004@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEB218ED32BF7338550CAFB5F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:43840 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737Ab3HAROp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 13:14:45 -0400
In-Reply-To: <51FA8FF7.7090004@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEB218ED32BF7338550CAFB5F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 01/08/2013 18:42, Loic Dachary wrote:
> Hi Sam,
>=20
> When the acting set changes order two chunks for the same object may co=
-exist in the same placement group. The key should therefore also contain=
 the chunk number.=20
>=20
> That's probably the most sensible comment I have so far. This document =
is immensely useful (even in its current state) because it shows me your =
perspective on the implementation.=20
>=20
> I'm puzzled by:

I get it ( thanks to yanzheng ). Object is deleted, then created again ..=
=2E spurious non version chunks would get in the way.

:-)

>=20
> CEPH_OSD_OP_DELETE: The possibility of rolling back a delete requires t=
hat we retain the deleted object until all replicas have persisted the de=
letion event. ErasureCoded backend will therefore need to store objects w=
ith the version at which they were created included in the key provided t=
o the filestore. Old versions of an object can be pruned when all replica=
s have committed up to the log event deleting the object.
>=20
> because I don't understand why the version would be necessary. I though=
t that deleting an erasure coded object could be even easier than erasing=
 a replicated object because it cannot be resurrected if enough chunks ar=
e lots, therefore you don't need to wait for ack from all OSDs in the up =
set. I'm obviously missing something.
>=20
> I failed to understand how important the pg logs were to maintaining th=
e consistency of the PG. For some reason I thought about them only in ter=
ms of being a light weight version of the operation logs. Adding a payloa=
d to the pg_log_entry ( i.e. APPEND size or attribute ) is a new idea for=
 me and I would have never thought or dared think the logs could be exten=
ded in such a way. Given the recent problems with logs writes having a hi=
gh impact on performances ( I'm referring to what forced you to introduce=
 code to reduce the amount of logs being written to only those that have =
been changed instead of the complete logs ) I thought about the pg logs a=
s something immutable.
>=20
> I'm still trying to figure out how PGBackend::perform_write / read / tr=
y_rollback would fit in the current backfilling / write / read / scrubbin=
g ... code path.=20
>=20
> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb226=
fed8d9b7/doc/dev/osd_internals/erasure_coding.rst
> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb226=
fed8d9b7/src/osd/PGBackend.h
>=20
> Cheers
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigEB218ED32BF7338550CAFB5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH6l4MACgkQ8dLMyEl6F20m4wCdH3m6XSZvm/AL/G7/j5mRXnNE
ChoAniMA3JDe3RO8CiV49JW0lTVgKZkW
=1XcP
-----END PGP SIGNATURE-----

--------------enigEB218ED32BF7338550CAFB5F--
