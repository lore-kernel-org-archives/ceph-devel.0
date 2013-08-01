From: Loic Dachary <loic@dachary.org>
Subject: PG Backend Proposal
Date: Thu, 01 Aug 2013 18:42:31 +0200
Message-ID: <51FA8FF7.7090004@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF69D4DBE1BC3FAA9A1AE0A82"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:48065 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab3HAQmf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 12:42:35 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF69D4DBE1BC3FAA9A1AE0A82
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

When the acting set changes order two chunks for the same object may co-e=
xist in the same placement group. The key should therefore also contain t=
he chunk number.=20

That's probably the most sensible comment I have so far. This document is=
 immensely useful (even in its current state) because it shows me your pe=
rspective on the implementation.=20

I'm puzzled by:

CEPH_OSD_OP_DELETE: The possibility of rolling back a delete requires tha=
t we retain the deleted object until all replicas have persisted the dele=
tion event. ErasureCoded backend will therefore need to store objects wit=
h the version at which they were created included in the key provided to =
the filestore. Old versions of an object can be pruned when all replicas =
have committed up to the log event deleting the object.

because I don't understand why the version would be necessary. I thought =
that deleting an erasure coded object could be even easier than erasing a=
 replicated object because it cannot be resurrected if enough chunks are =
lots, therefore you don't need to wait for ack from all OSDs in the up se=
t. I'm obviously missing something.

I failed to understand how important the pg logs were to maintaining the =
consistency of the PG. For some reason I thought about them only in terms=
 of being a light weight version of the operation logs. Adding a payload =
to the pg_log_entry ( i.e. APPEND size or attribute ) is a new idea for m=
e and I would have never thought or dared think the logs could be extende=
d in such a way. Given the recent problems with logs writes having a high=
 impact on performances ( I'm referring to what forced you to introduce c=
ode to reduce the amount of logs being written to only those that have be=
en changed instead of the complete logs ) I thought about the pg logs as =
something immutable.

I'm still trying to figure out how PGBackend::perform_write / read / try_=
rollback would fit in the current backfilling / write / read / scrubbing =
=2E.. code path.=20

https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb226fe=
d8d9b7/doc/dev/osd_internals/erasure_coding.rst
https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb226fe=
d8d9b7/src/osd/PGBackend.h

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigF69D4DBE1BC3FAA9A1AE0A82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH6j/cACgkQ8dLMyEl6F21hsgCcD+ceSQloXpTyyrNLroP30Tnm
c4YAnjHAwRWRv8XaHZLxJ10fFa1d4W8x
=jFdp
-----END PGP SIGNATURE-----

--------------enigF69D4DBE1BC3FAA9A1AE0A82--
