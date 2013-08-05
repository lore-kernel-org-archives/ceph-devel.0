From: Loic Dachary <loic@dachary.org>
Subject: Re: PG Backend Proposal
Date: Mon, 05 Aug 2013 14:36:04 +0200
Message-ID: <51FF9C34.2000707@dachary.org>
References: <51FA8FF7.7090004@dachary.org> <51FA9783.4000206@dachary.org> <51FAF538.1020609@dachary.org> <CA+4uBUa5RL9op66R_bxhcyJ8vjYXy_Ndvym+5M3JKnrGCbfNTw@mail.gmail.com> <51FB624B.7000108@dachary.org> <51FBCBFA.6010703@dachary.org> <CA+4uBUYY8mpOGA5tgCmz2Mdo6h7tQJW92Jxs=6X0dLnjrkYDFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig72120157756CBB1F9910ED1F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:33046 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab3HEMgI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 5 Aug 2013 08:36:08 -0400
In-Reply-To: <CA+4uBUYY8mpOGA5tgCmz2Mdo6h7tQJW92Jxs=6X0dLnjrkYDFg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig72120157756CBB1F9910ED1F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

Now I understand the rationale :-) What I still don't understand is why i=
t should be in coll_t. It is the name of the directory

https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f58=
2/src/osd/osd_types.h#L394

which is listed when loading the pgs

https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f58=
2/src/osd/OSD.cc#L1908

and parsed=20

https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f58=
2/src/osd/osd_types.cc#L297

into pg_t

https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f58=
2/src/osd/osd_types.cc#L170

which contains the pool, the seed ( I think for pg splitting purposes ), =
and preferred ( it seems to be about localized PG but I don't know anythi=
ng about them and I assume it's not important at this moment ).=20

Do you mean adding chunk_id_t to pg_t instead of coll_t ? It would mean t=
hat the chunk_id would have to be encoded in the directory name in which =
the PG objects are stored. And therefore that the coll_t would have to be=
 renamed each time the PG changes position in the acting set.=20

When loading a pg,=20

https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f58=
2/src/osd/OSD.cc#L1954
https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f58=
2/src/osd/PG.cc#L2396

it gets pg_info_t from disk=20

https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f58=
2/src/osd/PG.cc#L2363

as well as the past intervals

https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f58=
2/src/osd/PG.cc#L2371

which includes the acting set

https://github.com/ceph/ceph/blob/962b64a83037ff79855c5261325de0cd1541f58=
2/src/osd/osd_types.h#L1180

for each epoch. Would it make sense to store the chunk_id in the pg_info_=
t or even compute it from the position of the OSD in the previous acting =
set ?

Cheers

On 02/08/2013 19:11, Samuel Just wrote:
> The reason for the chunk_id_t in the coll_t is to handle a tricky edge =
case:
> [0,1,2]
> [3,1,2]
> ..time passes..
> [3,0,2]
>=20
> This should be exceedingly rare, but a single osd might end up with
> copies of two different chunks of the same pg.
>=20
> When an osd joins an acting set with a preexisting copy of the pg and
> can be brought up to date with logs, we must know which chunk each
> object in the replica is without having to scan the PG (more to the
> point, we need to know that each chunk matches the chunk of the osd
> which it replaced).  If a pg replica can store any chunk, we need a
> mechanism to ensure that.  It seems simpler to force all objects
> within a replica to be the same chunk and furthermore to tie that
> chunk to the position in the acting set.
> -Sam
>=20
> On Fri, Aug 2, 2013 at 8:10 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Sam,
>>
>>> - coll_t needs to include a chunk_id_t.
>> https://github.com/athanatos/ceph/blob/2234bdf7fc30738363160d598ae8b4d=
6f75e1dd1/doc/dev/osd_internals/erasure_coding.rst#distinguished-acting-s=
et-positions
>>
>> That would be for sanity check ? Since the rank of the chunk ( chunk_i=
d_t ) matches the position in the acting set and a history of osdmaps is =
kept, would this be used when loading the pg from disk to make sure it ma=
tches the expected chunk_id_t ?
>>
>> Cheers
>>
>> On 02/08/2013 09:39, Loic Dachary wrote:
>>> Hi Sam,
>>>
>>> I think I understand and paraphrasing you to make sure I do. We may s=
ave bandwidth because chunks are not moved as much if their position is n=
ot tied to the position of the OSD containing them in the acting set. But=
 this is mitigated by the use of the indep crush mode. And it may require=
 to handle tricky edge cases. In addition, you think that being able to k=
now which OSD contains which chunk by using only the OSDMap and the (v)ho=
bject_t is going to simplify the design.
>>>
>>> For the record:
>>>
>>> Back in April Sage suggested that
>>>
>>> "- those PGs use the parity ('INDEP') crush mode so that placement is=
 intelligent"
>>>
>>> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/14579
>>>
>>> "The indep placement avoids moving around a shard between ranks, beca=
use a mapping of [0,1,2,3,4] will change to [0,6,2,3,4] (or something) if=
 osd.1 fails and the shards on 2,3,4 won't need to be copied around."
>>>
>>> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/14582
>>>
>>> and I assume that's what you refer to when you write "CRUSH has a mod=
e which will cause replacement to behave well for erasure codes:
>>>
>>>  initial: [0,1,2]
>>>  0 fails: [3,1,2]
>>>  2 fails: [3,1,4]
>>>  0 recovers: [0,1,4]
>>>
>>> I understand this is implemented here:
>>>
>>> https://github.com/ceph/ceph/blob/e7d47827f0333c96ad43d257607fb92ed41=
76550/src/crush/mapper.c#L523
>>>
>>> and will determine to order of the acting set
>>>
>>> https://github.com/ceph/ceph/blob/e7d47827f0333c96ad43d257607fb92ed41=
76550/src/osd/OSDMap.cc#L998
>>>
>>> when called by the monitor when creating or updating a PG
>>>
>>> https://github.com/ceph/ceph/blob/e7d47827f0333c96ad43d257607fb92ed41=
76550/src/mon/PGMonitor.cc#L814
>>>
>>> Cheers
>>>
>>> On 02/08/2013 03:34, Samuel Just wrote:
>>>> I think there are some tricky edge cases with the above approach.  Y=
ou
>>>> might end up with two pg replicas in the same acting set which happe=
n
>>>> for reasons of history to have the same chunk for one or more object=
s.
>>>>  That would have to be detected and repaired even though the object
>>>> would be missing from neither replica (and might not even be in the =
pg
>>>> log).  The erasure_code_rank would have to be somehow maintained
>>>> through recovery (do we remember the original holder of a particular=

>>>> chunk in case it ever comes back?).
>>>>
>>>> The chunk rank doesn't *need* to match the acting set position, but
>>>> there are some good reasons to arrange for that to be the case:
>>>> 1) Otherwise, we need something else to assign the chunk ranks
>>>> 2) This way, a new primary can determine which osds hold which
>>>> replicas of which chunk rank by looking at past osd maps.
>>>>
>>>> It seems to me that given an OSDMap and an object, we should know
>>>> immediately where all chunks should be stored since a future primary=

>>>> may need to do that without access to the objects themselves.
>>>>
>>>> Importantly, while it may be possible for an acting set transition
>>>> like [0,1,2]->[2,1,0] to occur in some pathological case, CRUSH has =
a
>>>> mode which will cause replacement to behave well for erasure codes:
>>>>
>>>> initial: [0,1,2]
>>>> 0 fails: [3,1,2]
>>>> 2 fails: [3,1,4]
>>>> 0 recovers: [0,1,4]
>>>>
>>>> We do, however, need to decouple primariness from position in the
>>>> acting set so that backfill can work well.
>>>> -Sam
>>>>
>>>> On Thu, Aug 1, 2013 at 4:54 PM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>>> Hi Sam,
>>>>>
>>>>> I'm under the impression that
>>>>> https://github.com/athanatos/ceph/blob/wip-erasure-coding-doc/doc/d=
ev/osd_internals/erasure_coding.rst#distinguished-acting-set-positions
>>>>> assumes acting[0] stores all chunk[0], acting[1] stores all chunk[1=
] etc.
>>>>>
>>>>> The chunk rank does not need to match the OSD position in the actin=
g set. As long as each object chunk is stored with its rank in an attribu=
te, changing the order of the acting set does not require to move the chu=
nks around.
>>>>>
>>>>> With M=3D2+K=3D1 and the acting set is [0,1,2] chunks M0,M1,K0 are =
written on [0,1,2] respectively, each of them have the 'erasure_code_rank=
' attribute set to their rank.
>>>>>
>>>>> If the acting set changes to [2,1,0] the read would reorder the chu=
nk based on their 'erasure_code_rank' attribute instead of the rank of th=
e OSD they originate from in the current acting set. And then be able to =
decode them with the erasure code library, which requires that the chunks=
 are provided in a specific order.
>>>>>
>>>>> When doing a full write, the chunks are written in the same order a=
s the acting set. This implies that the order of the chunks of the previo=
us version of the object may be different but I don't see a problem with =
that.
>>>>>
>>>>> When doing an append, the primary must first retrieve the order in =
which the objects are stored by retrieving their 'erasure_code_rank' attr=
ibute, because the order of the acting set is not the same as the order o=
f the chunks. It then maps the chunks to the OSDs matching their rank and=
 pushes them to the OSDs.
>>>>>
>>>>> The only downside is that it may make things more complicated to im=
plement optimizations based on the fact that, sometimes, chunks can just =
be concatenated to recover the content of the object and don't need to be=
 decoded ( when using systematic codes and the M data chunks are availabl=
e ).
>>>>>
>>>>> Cheers
>>>>>
>>>>> On 01/08/2013 19:14, Loic Dachary wrote:
>>>>>>
>>>>>>
>>>>>> On 01/08/2013 18:42, Loic Dachary wrote:
>>>>>>> Hi Sam,
>>>>>>>
>>>>>>> When the acting set changes order two chunks for the same object =
may co-exist in the same placement group. The key should therefore also c=
ontain the chunk number.
>>>>>>>
>>>>>>> That's probably the most sensible comment I have so far. This doc=
ument is immensely useful (even in its current state) because it shows me=
 your perspective on the implementation.
>>>>>>>
>>>>>>> I'm puzzled by:
>>>>>>
>>>>>> I get it ( thanks to yanzheng ). Object is deleted, then created a=
gain ... spurious non version chunks would get in the way.
>>>>>>
>>>>>> :-)
>>>>>>
>>>>>>>
>>>>>>> CEPH_OSD_OP_DELETE: The possibility of rolling back a delete requ=
ires that we retain the deleted object until all replicas have persisted =
the deletion event. ErasureCoded backend will therefore need to store obj=
ects with the version at which they were created included in the key prov=
ided to the filestore. Old versions of an object can be pruned when all r=
eplicas have committed up to the log event deleting the object.
>>>>>>>
>>>>>>> because I don't understand why the version would be necessary. I =
thought that deleting an erasure coded object could be even easier than e=
rasing a replicated object because it cannot be resurrected if enough chu=
nks are lots, therefore you don't need to wait for ack from all OSDs in t=
he up set. I'm obviously missing something.
>>>>>>>
>>>>>>> I failed to understand how important the pg logs were to maintain=
ing the consistency of the PG. For some reason I thought about them only =
in terms of being a light weight version of the operation logs. Adding a =
payload to the pg_log_entry ( i.e. APPEND size or attribute ) is a new id=
ea for me and I would have never thought or dared think the logs could be=
 extended in such a way. Given the recent problems with logs writes havin=
g a high impact on performances ( I'm referring to what forced you to int=
roduce code to reduce the amount of logs being written to only those that=
 have been changed instead of the complete logs ) I thought about the pg =
logs as something immutable.
>>>>>>>
>>>>>>> I'm still trying to figure out how PGBackend::perform_write / rea=
d / try_rollback would fit in the current backfilling / write / read / sc=
rubbing ... code path.
>>>>>>>
>>>>>>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2c=
ffb226fed8d9b7/doc/dev/osd_internals/erasure_coding.rst
>>>>>>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2c=
ffb226fed8d9b7/src/osd/PGBackend.h
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>
>>>>>
>>>>> --
>>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>> All that is necessary for the triumph of evil is that good people d=
o nothing.
>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig72120157756CBB1F9910ED1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH/nDUACgkQ8dLMyEl6F23iBACggfGkuPzJu1ZHFB0jUuCEIcwH
vY0AoI082pQxIuro0FLPJYo5HjphkW0z
=trd5
-----END PGP SIGNATURE-----

--------------enig72120157756CBB1F9910ED1F--
