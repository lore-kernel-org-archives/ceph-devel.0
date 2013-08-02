From: Samuel Just <sam.just@inktank.com>
Subject: Re: PG Backend Proposal
Date: Fri, 2 Aug 2013 10:11:34 -0700
Message-ID: <CA+4uBUYY8mpOGA5tgCmz2Mdo6h7tQJW92Jxs=6X0dLnjrkYDFg@mail.gmail.com>
References: <51FA8FF7.7090004@dachary.org>
	<51FA9783.4000206@dachary.org>
	<51FAF538.1020609@dachary.org>
	<CA+4uBUa5RL9op66R_bxhcyJ8vjYXy_Ndvym+5M3JKnrGCbfNTw@mail.gmail.com>
	<51FB624B.7000108@dachary.org>
	<51FBCBFA.6010703@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:65042 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab3HBRLf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Aug 2013 13:11:35 -0400
Received: by mail-vb0-f44.google.com with SMTP id e13so868583vbg.31
        for <ceph-devel@vger.kernel.org>; Fri, 02 Aug 2013 10:11:34 -0700 (PDT)
In-Reply-To: <51FBCBFA.6010703@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

The reason for the chunk_id_t in the coll_t is to handle a tricky edge =
case:
[0,1,2]
[3,1,2]
=2E.time passes..
[3,0,2]

This should be exceedingly rare, but a single osd might end up with
copies of two different chunks of the same pg.

When an osd joins an acting set with a preexisting copy of the pg and
can be brought up to date with logs, we must know which chunk each
object in the replica is without having to scan the PG (more to the
point, we need to know that each chunk matches the chunk of the osd
which it replaced).  If a pg replica can store any chunk, we need a
mechanism to ensure that.  It seems simpler to force all objects
within a replica to be the same chunk and furthermore to tie that
chunk to the position in the acting set.
-Sam

On Fri, Aug 2, 2013 at 8:10 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
>> - coll_t needs to include a chunk_id_t.
> https://github.com/athanatos/ceph/blob/2234bdf7fc30738363160d598ae8b4=
d6f75e1dd1/doc/dev/osd_internals/erasure_coding.rst#distinguished-actin=
g-set-positions
>
> That would be for sanity check ? Since the rank of the chunk ( chunk_=
id_t ) matches the position in the acting set and a history of osdmaps =
is kept, would this be used when loading the pg from disk to make sure =
it matches the expected chunk_id_t ?
>
> Cheers
>
> On 02/08/2013 09:39, Loic Dachary wrote:
>> Hi Sam,
>>
>> I think I understand and paraphrasing you to make sure I do. We may =
save bandwidth because chunks are not moved as much if their position i=
s not tied to the position of the OSD containing them in the acting set=
=2E But this is mitigated by the use of the indep crush mode. And it ma=
y require to handle tricky edge cases. In addition, you think that bein=
g able to know which OSD contains which chunk by using only the OSDMap =
and the (v)hobject_t is going to simplify the design.
>>
>> For the record:
>>
>> Back in April Sage suggested that
>>
>> "- those PGs use the parity ('INDEP') crush mode so that placement i=
s intelligent"
>>
>> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/14579
>>
>> "The indep placement avoids moving around a shard between ranks, bec=
ause a mapping of [0,1,2,3,4] will change to [0,6,2,3,4] (or something)=
 if osd.1 fails and the shards on 2,3,4 won't need to be copied around.=
"
>>
>> http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/14582
>>
>> and I assume that's what you refer to when you write "CRUSH has a mo=
de which will cause replacement to behave well for erasure codes:
>>
>>  initial: [0,1,2]
>>  0 fails: [3,1,2]
>>  2 fails: [3,1,4]
>>  0 recovers: [0,1,4]
>>
>> I understand this is implemented here:
>>
>> https://github.com/ceph/ceph/blob/e7d47827f0333c96ad43d257607fb92ed4=
176550/src/crush/mapper.c#L523
>>
>> and will determine to order of the acting set
>>
>> https://github.com/ceph/ceph/blob/e7d47827f0333c96ad43d257607fb92ed4=
176550/src/osd/OSDMap.cc#L998
>>
>> when called by the monitor when creating or updating a PG
>>
>> https://github.com/ceph/ceph/blob/e7d47827f0333c96ad43d257607fb92ed4=
176550/src/mon/PGMonitor.cc#L814
>>
>> Cheers
>>
>> On 02/08/2013 03:34, Samuel Just wrote:
>>> I think there are some tricky edge cases with the above approach.  =
You
>>> might end up with two pg replicas in the same acting set which happ=
en
>>> for reasons of history to have the same chunk for one or more objec=
ts.
>>>  That would have to be detected and repaired even though the object
>>> would be missing from neither replica (and might not even be in the=
 pg
>>> log).  The erasure_code_rank would have to be somehow maintained
>>> through recovery (do we remember the original holder of a particula=
r
>>> chunk in case it ever comes back?).
>>>
>>> The chunk rank doesn't *need* to match the acting set position, but
>>> there are some good reasons to arrange for that to be the case:
>>> 1) Otherwise, we need something else to assign the chunk ranks
>>> 2) This way, a new primary can determine which osds hold which
>>> replicas of which chunk rank by looking at past osd maps.
>>>
>>> It seems to me that given an OSDMap and an object, we should know
>>> immediately where all chunks should be stored since a future primar=
y
>>> may need to do that without access to the objects themselves.
>>>
>>> Importantly, while it may be possible for an acting set transition
>>> like [0,1,2]->[2,1,0] to occur in some pathological case, CRUSH has=
 a
>>> mode which will cause replacement to behave well for erasure codes:
>>>
>>> initial: [0,1,2]
>>> 0 fails: [3,1,2]
>>> 2 fails: [3,1,4]
>>> 0 recovers: [0,1,4]
>>>
>>> We do, however, need to decouple primariness from position in the
>>> acting set so that backfill can work well.
>>> -Sam
>>>
>>> On Thu, Aug 1, 2013 at 4:54 PM, Loic Dachary <loic@dachary.org> wro=
te:
>>>> Hi Sam,
>>>>
>>>> I'm under the impression that
>>>> https://github.com/athanatos/ceph/blob/wip-erasure-coding-doc/doc/=
dev/osd_internals/erasure_coding.rst#distinguished-acting-set-positions
>>>> assumes acting[0] stores all chunk[0], acting[1] stores all chunk[=
1] etc.
>>>>
>>>> The chunk rank does not need to match the OSD position in the acti=
ng set. As long as each object chunk is stored with its rank in an attr=
ibute, changing the order of the acting set does not require to move th=
e chunks around.
>>>>
>>>> With M=3D2+K=3D1 and the acting set is [0,1,2] chunks M0,M1,K0 are=
 written on [0,1,2] respectively, each of them have the 'erasure_code_r=
ank' attribute set to their rank.
>>>>
>>>> If the acting set changes to [2,1,0] the read would reorder the ch=
unk based on their 'erasure_code_rank' attribute instead of the rank of=
 the OSD they originate from in the current acting set. And then be abl=
e to decode them with the erasure code library, which requires that the=
 chunks are provided in a specific order.
>>>>
>>>> When doing a full write, the chunks are written in the same order =
as the acting set. This implies that the order of the chunks of the pre=
vious version of the object may be different but I don't see a problem =
with that.
>>>>
>>>> When doing an append, the primary must first retrieve the order in=
 which the objects are stored by retrieving their 'erasure_code_rank' a=
ttribute, because the order of the acting set is not the same as the or=
der of the chunks. It then maps the chunks to the OSDs matching their r=
ank and pushes them to the OSDs.
>>>>
>>>> The only downside is that it may make things more complicated to i=
mplement optimizations based on the fact that, sometimes, chunks can ju=
st be concatenated to recover the content of the object and don't need =
to be decoded ( when using systematic codes and the M data chunks are a=
vailable ).
>>>>
>>>> Cheers
>>>>
>>>> On 01/08/2013 19:14, Loic Dachary wrote:
>>>>>
>>>>>
>>>>> On 01/08/2013 18:42, Loic Dachary wrote:
>>>>>> Hi Sam,
>>>>>>
>>>>>> When the acting set changes order two chunks for the same object=
 may co-exist in the same placement group. The key should therefore als=
o contain the chunk number.
>>>>>>
>>>>>> That's probably the most sensible comment I have so far. This do=
cument is immensely useful (even in its current state) because it shows=
 me your perspective on the implementation.
>>>>>>
>>>>>> I'm puzzled by:
>>>>>
>>>>> I get it ( thanks to yanzheng ). Object is deleted, then created =
again ... spurious non version chunks would get in the way.
>>>>>
>>>>> :-)
>>>>>
>>>>>>
>>>>>> CEPH_OSD_OP_DELETE: The possibility of rolling back a delete req=
uires that we retain the deleted object until all replicas have persist=
ed the deletion event. ErasureCoded backend will therefore need to stor=
e objects with the version at which they were created included in the k=
ey provided to the filestore. Old versions of an object can be pruned w=
hen all replicas have committed up to the log event deleting the object=
=2E
>>>>>>
>>>>>> because I don't understand why the version would be necessary. I=
 thought that deleting an erasure coded object could be even easier tha=
n erasing a replicated object because it cannot be resurrected if enoug=
h chunks are lots, therefore you don't need to wait for ack from all OS=
Ds in the up set. I'm obviously missing something.
>>>>>>
>>>>>> I failed to understand how important the pg logs were to maintai=
ning the consistency of the PG. For some reason I thought about them on=
ly in terms of being a light weight version of the operation logs. Addi=
ng a payload to the pg_log_entry ( i.e. APPEND size or attribute ) is a=
 new idea for me and I would have never thought or dared think the logs=
 could be extended in such a way. Given the recent problems with logs w=
rites having a high impact on performances ( I'm referring to what forc=
ed you to introduce code to reduce the amount of logs being written to =
only those that have been changed instead of the complete logs ) I thou=
ght about the pg logs as something immutable.
>>>>>>
>>>>>> I'm still trying to figure out how PGBackend::perform_write / re=
ad / try_rollback would fit in the current backfilling / write / read /=
 scrubbing ... code path.
>>>>>>
>>>>>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2=
cffb226fed8d9b7/doc/dev/osd_internals/erasure_coding.rst
>>>>>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2=
cffb226fed8d9b7/src/osd/PGBackend.h
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>
>>>>
>>>> --
>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>> All that is necessary for the triumph of evil is that good people =
do nothing.
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
