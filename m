From: Loic Dachary <loic@dachary.org>
Subject: Re: PG Backend Proposal
Date: Fri, 02 Aug 2013 09:39:55 +0200
Message-ID: <51FB624B.7000108@dachary.org>
References: <51FA8FF7.7090004@dachary.org> <51FA9783.4000206@dachary.org> <51FAF538.1020609@dachary.org> <CA+4uBUa5RL9op66R_bxhcyJ8vjYXy_Ndvym+5M3JKnrGCbfNTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA18F33CFD4897C046CA493D0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:43886 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757609Ab3HBHj7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Aug 2013 03:39:59 -0400
In-Reply-To: <CA+4uBUa5RL9op66R_bxhcyJ8vjYXy_Ndvym+5M3JKnrGCbfNTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA18F33CFD4897C046CA493D0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

I think I understand and paraphrasing you to make sure I do. We may save =
bandwidth because chunks are not moved as much if their position is not t=
ied to the position of the OSD containing them in the acting set. But thi=
s is mitigated by the use of the indep crush mode. And it may require to =
handle tricky edge cases. In addition, you think that being able to know =
which OSD contains which chunk by using only the OSDMap and the (v)hobjec=
t_t is going to simplify the design.

For the record:

Back in April Sage suggested that

"- those PGs use the parity ('INDEP') crush mode so that placement is int=
elligent"

http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/14579

"The indep placement avoids moving around a shard between ranks, because =
a mapping of [0,1,2,3,4] will change to [0,6,2,3,4] (or something) if osd=
=2E1 fails and the shards on 2,3,4 won't need to be copied around."

http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/14582

and I assume that's what you refer to when you write "CRUSH has a mode wh=
ich will cause replacement to behave well for erasure codes:

 initial: [0,1,2]
 0 fails: [3,1,2]
 2 fails: [3,1,4]
 0 recovers: [0,1,4]

I understand this is implemented here:

https://github.com/ceph/ceph/blob/e7d47827f0333c96ad43d257607fb92ed417655=
0/src/crush/mapper.c#L523

and will determine to order of the acting set=20

https://github.com/ceph/ceph/blob/e7d47827f0333c96ad43d257607fb92ed417655=
0/src/osd/OSDMap.cc#L998

when called by the monitor when creating or updating a PG

https://github.com/ceph/ceph/blob/e7d47827f0333c96ad43d257607fb92ed417655=
0/src/mon/PGMonitor.cc#L814

Cheers

On 02/08/2013 03:34, Samuel Just wrote:
> I think there are some tricky edge cases with the above approach.  You
> might end up with two pg replicas in the same acting set which happen
> for reasons of history to have the same chunk for one or more objects.
>  That would have to be detected and repaired even though the object
> would be missing from neither replica (and might not even be in the pg
> log).  The erasure_code_rank would have to be somehow maintained
> through recovery (do we remember the original holder of a particular
> chunk in case it ever comes back?).
>=20
> The chunk rank doesn't *need* to match the acting set position, but
> there are some good reasons to arrange for that to be the case:
> 1) Otherwise, we need something else to assign the chunk ranks
> 2) This way, a new primary can determine which osds hold which
> replicas of which chunk rank by looking at past osd maps.
>=20
> It seems to me that given an OSDMap and an object, we should know
> immediately where all chunks should be stored since a future primary
> may need to do that without access to the objects themselves.
>=20
> Importantly, while it may be possible for an acting set transition
> like [0,1,2]->[2,1,0] to occur in some pathological case, CRUSH has a
> mode which will cause replacement to behave well for erasure codes:
>=20
> initial: [0,1,2]
> 0 fails: [3,1,2]
> 2 fails: [3,1,4]
> 0 recovers: [0,1,4]
>=20
> We do, however, need to decouple primariness from position in the
> acting set so that backfill can work well.
> -Sam
>=20
> On Thu, Aug 1, 2013 at 4:54 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Sam,
>>
>> I'm under the impression that
>> https://github.com/athanatos/ceph/blob/wip-erasure-coding-doc/doc/dev/=
osd_internals/erasure_coding.rst#distinguished-acting-set-positions
>> assumes acting[0] stores all chunk[0], acting[1] stores all chunk[1] e=
tc.
>>
>> The chunk rank does not need to match the OSD position in the acting s=
et. As long as each object chunk is stored with its rank in an attribute,=
 changing the order of the acting set does not require to move the chunks=
 around.
>>
>> With M=3D2+K=3D1 and the acting set is [0,1,2] chunks M0,M1,K0 are wri=
tten on [0,1,2] respectively, each of them have the 'erasure_code_rank' a=
ttribute set to their rank.
>>
>> If the acting set changes to [2,1,0] the read would reorder the chunk =
based on their 'erasure_code_rank' attribute instead of the rank of the O=
SD they originate from in the current acting set. And then be able to dec=
ode them with the erasure code library, which requires that the chunks ar=
e provided in a specific order.
>>
>> When doing a full write, the chunks are written in the same order as t=
he acting set. This implies that the order of the chunks of the previous =
version of the object may be different but I don't see a problem with tha=
t.
>>
>> When doing an append, the primary must first retrieve the order in whi=
ch the objects are stored by retrieving their 'erasure_code_rank' attribu=
te, because the order of the acting set is not the same as the order of t=
he chunks. It then maps the chunks to the OSDs matching their rank and pu=
shes them to the OSDs.
>>
>> The only downside is that it may make things more complicated to imple=
ment optimizations based on the fact that, sometimes, chunks can just be =
concatenated to recover the content of the object and don't need to be de=
coded ( when using systematic codes and the M data chunks are available )=
=2E
>>
>> Cheers
>>
>> On 01/08/2013 19:14, Loic Dachary wrote:
>>>
>>>
>>> On 01/08/2013 18:42, Loic Dachary wrote:
>>>> Hi Sam,
>>>>
>>>> When the acting set changes order two chunks for the same object may=
 co-exist in the same placement group. The key should therefore also cont=
ain the chunk number.
>>>>
>>>> That's probably the most sensible comment I have so far. This docume=
nt is immensely useful (even in its current state) because it shows me yo=
ur perspective on the implementation.
>>>>
>>>> I'm puzzled by:
>>>
>>> I get it ( thanks to yanzheng ). Object is deleted, then created agai=
n ... spurious non version chunks would get in the way.
>>>
>>> :-)
>>>
>>>>
>>>> CEPH_OSD_OP_DELETE: The possibility of rolling back a delete require=
s that we retain the deleted object until all replicas have persisted the=
 deletion event. ErasureCoded backend will therefore need to store object=
s with the version at which they were created included in the key provide=
d to the filestore. Old versions of an object can be pruned when all repl=
icas have committed up to the log event deleting the object.
>>>>
>>>> because I don't understand why the version would be necessary. I tho=
ught that deleting an erasure coded object could be even easier than eras=
ing a replicated object because it cannot be resurrected if enough chunks=
 are lots, therefore you don't need to wait for ack from all OSDs in the =
up set. I'm obviously missing something.
>>>>
>>>> I failed to understand how important the pg logs were to maintaining=
 the consistency of the PG. For some reason I thought about them only in =
terms of being a light weight version of the operation logs. Adding a pay=
load to the pg_log_entry ( i.e. APPEND size or attribute ) is a new idea =
for me and I would have never thought or dared think the logs could be ex=
tended in such a way. Given the recent problems with logs writes having a=
 high impact on performances ( I'm referring to what forced you to introd=
uce code to reduce the amount of logs being written to only those that ha=
ve been changed instead of the complete logs ) I thought about the pg log=
s as something immutable.
>>>>
>>>> I'm still trying to figure out how PGBackend::perform_write / read /=
 try_rollback would fit in the current backfilling / write / read / scrub=
bing ... code path.
>>>>
>>>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb=
226fed8d9b7/doc/dev/osd_internals/erasure_coding.rst
>>>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb=
226fed8d9b7/src/osd/PGBackend.h
>>>>
>>>> Cheers
>>>>
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigA18F33CFD4897C046CA493D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlH7YkwACgkQ8dLMyEl6F22NoQCgnRQd3ig8PdAdn5+cZ8NUnYMQ
H1sAoKGj4NxzqXgE5RKPwhUwSvnvDBww
=gJ1Q
-----END PGP SIGNATURE-----

--------------enigA18F33CFD4897C046CA493D0--
