From: Loic Dachary <loic@dachary.org>
Subject: Re: PG Backend Proposal
Date: Fri, 02 Aug 2013 01:54:32 +0200
Message-ID: <51FAF538.1020609@dachary.org>
References: <51FA8FF7.7090004@dachary.org> <51FA9783.4000206@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig93B41F111036961E8260EB05"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:44483 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab3HAXyf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 19:54:35 -0400
In-Reply-To: <51FA9783.4000206@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig93B41F111036961E8260EB05
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I'm under the impression that
https://github.com/athanatos/ceph/blob/wip-erasure-coding-doc/doc/dev/osd=
_internals/erasure_coding.rst#distinguished-acting-set-positions
assumes acting[0] stores all chunk[0], acting[1] stores all chunk[1] etc.=


The chunk rank does not need to match the OSD position in the acting set.=
 As long as each object chunk is stored with its rank in an attribute, ch=
anging the order of the acting set does not require to move the chunks ar=
ound.

With M=3D2+K=3D1 and the acting set is [0,1,2] chunks M0,M1,K0 are writte=
n on [0,1,2] respectively, each of them have the 'erasure_code_rank' attr=
ibute set to their rank.

If the acting set changes to [2,1,0] the read would reorder the chunk bas=
ed on their 'erasure_code_rank' attribute instead of the rank of the OSD =
they originate from in the current acting set. And then be able to decode=
 them with the erasure code library, which requires that the chunks are p=
rovided in a specific order.

When doing a full write, the chunks are written in the same order as the =
acting set. This implies that the order of the chunks of the previous ver=
sion of the object may be different but I don't see a problem with that.

When doing an append, the primary must first retrieve the order in which =
the objects are stored by retrieving their 'erasure_code_rank' attribute,=
 because the order of the acting set is not the same as the order of the =
chunks. It then maps the chunks to the OSDs matching their rank and pushe=
s them to the OSDs.

The only downside is that it may make things more complicated to implemen=
t optimizations based on the fact that, sometimes, chunks can just be con=
catenated to recover the content of the object and don't need to be decod=
ed ( when using systematic codes and the M data chunks are available ).

Cheers

On 01/08/2013 19:14, Loic Dachary wrote:
>=20
>=20
> On 01/08/2013 18:42, Loic Dachary wrote:
>> Hi Sam,
>>
>> When the acting set changes order two chunks for the same object may c=
o-exist in the same placement group. The key should therefore also contai=
n the chunk number.=20
>>
>> That's probably the most sensible comment I have so far. This document=
 is immensely useful (even in its current state) because it shows me your=
 perspective on the implementation.=20
>>
>> I'm puzzled by:
>=20
> I get it ( thanks to yanzheng ). Object is deleted, then created again =
=2E.. spurious non version chunks would get in the way.
>=20
> :-)
>=20
>>
>> CEPH_OSD_OP_DELETE: The possibility of rolling back a delete requires =
that we retain the deleted object until all replicas have persisted the d=
eletion event. ErasureCoded backend will therefore need to store objects =
with the version at which they were created included in the key provided =
to the filestore. Old versions of an object can be pruned when all replic=
as have committed up to the log event deleting the object.
>>
>> because I don't understand why the version would be necessary. I thoug=
ht that deleting an erasure coded object could be even easier than erasin=
g a replicated object because it cannot be resurrected if enough chunks a=
re lots, therefore you don't need to wait for ack from all OSDs in the up=
 set. I'm obviously missing something.
>>
>> I failed to understand how important the pg logs were to maintaining t=
he consistency of the PG. For some reason I thought about them only in te=
rms of being a light weight version of the operation logs. Adding a paylo=
ad to the pg_log_entry ( i.e. APPEND size or attribute ) is a new idea fo=
r me and I would have never thought or dared think the logs could be exte=
nded in such a way. Given the recent problems with logs writes having a h=
igh impact on performances ( I'm referring to what forced you to introduc=
e code to reduce the amount of logs being written to only those that have=
 been changed instead of the complete logs ) I thought about the pg logs =
as something immutable.
>>
>> I'm still trying to figure out how PGBackend::perform_write / read / t=
ry_rollback would fit in the current backfilling / write / read / scrubbi=
ng ... code path.=20
>>
>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb22=
6fed8d9b7/doc/dev/osd_internals/erasure_coding.rst
>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb22=
6fed8d9b7/src/osd/PGBackend.h
>>
>> Cheers
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig93B41F111036961E8260EB05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH69TgACgkQ8dLMyEl6F20CtwCgsWZJytcj04KvPDSW8V+AaoMK
VnIAni1vfoRZYY16mEiRjts4cxg2vP+O
=P1iI
-----END PGP SIGNATURE-----

--------------enig93B41F111036961E8260EB05--
