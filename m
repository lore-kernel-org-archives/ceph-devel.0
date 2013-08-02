From: Samuel Just <sam.just@inktank.com>
Subject: Re: PG Backend Proposal
Date: Thu, 1 Aug 2013 18:34:33 -0700
Message-ID: <CA+4uBUa5RL9op66R_bxhcyJ8vjYXy_Ndvym+5M3JKnrGCbfNTw@mail.gmail.com>
References: <51FA8FF7.7090004@dachary.org>
	<51FA9783.4000206@dachary.org>
	<51FAF538.1020609@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50]:61850 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab3HBBee convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 21:34:34 -0400
Received: by mail-vb0-f50.google.com with SMTP id x14so73767vbb.9
        for <ceph-devel@vger.kernel.org>; Thu, 01 Aug 2013 18:34:33 -0700 (PDT)
In-Reply-To: <51FAF538.1020609@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I think there are some tricky edge cases with the above approach.  You
might end up with two pg replicas in the same acting set which happen
for reasons of history to have the same chunk for one or more objects.
 That would have to be detected and repaired even though the object
would be missing from neither replica (and might not even be in the pg
log).  The erasure_code_rank would have to be somehow maintained
through recovery (do we remember the original holder of a particular
chunk in case it ever comes back?).

The chunk rank doesn't *need* to match the acting set position, but
there are some good reasons to arrange for that to be the case:
1) Otherwise, we need something else to assign the chunk ranks
2) This way, a new primary can determine which osds hold which
replicas of which chunk rank by looking at past osd maps.

It seems to me that given an OSDMap and an object, we should know
immediately where all chunks should be stored since a future primary
may need to do that without access to the objects themselves.

Importantly, while it may be possible for an acting set transition
like [0,1,2]->[2,1,0] to occur in some pathological case, CRUSH has a
mode which will cause replacement to behave well for erasure codes:

initial: [0,1,2]
0 fails: [3,1,2]
2 fails: [3,1,4]
0 recovers: [0,1,4]

We do, however, need to decouple primariness from position in the
acting set so that backfill can work well.
-Sam

On Thu, Aug 1, 2013 at 4:54 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sam,
>
> I'm under the impression that
> https://github.com/athanatos/ceph/blob/wip-erasure-coding-doc/doc/dev=
/osd_internals/erasure_coding.rst#distinguished-acting-set-positions
> assumes acting[0] stores all chunk[0], acting[1] stores all chunk[1] =
etc.
>
> The chunk rank does not need to match the OSD position in the acting =
set. As long as each object chunk is stored with its rank in an attribu=
te, changing the order of the acting set does not require to move the c=
hunks around.
>
> With M=3D2+K=3D1 and the acting set is [0,1,2] chunks M0,M1,K0 are wr=
itten on [0,1,2] respectively, each of them have the 'erasure_code_rank=
' attribute set to their rank.
>
> If the acting set changes to [2,1,0] the read would reorder the chunk=
 based on their 'erasure_code_rank' attribute instead of the rank of th=
e OSD they originate from in the current acting set. And then be able t=
o decode them with the erasure code library, which requires that the ch=
unks are provided in a specific order.
>
> When doing a full write, the chunks are written in the same order as =
the acting set. This implies that the order of the chunks of the previo=
us version of the object may be different but I don't see a problem wit=
h that.
>
> When doing an append, the primary must first retrieve the order in wh=
ich the objects are stored by retrieving their 'erasure_code_rank' attr=
ibute, because the order of the acting set is not the same as the order=
 of the chunks. It then maps the chunks to the OSDs matching their rank=
 and pushes them to the OSDs.
>
> The only downside is that it may make things more complicated to impl=
ement optimizations based on the fact that, sometimes, chunks can just =
be concatenated to recover the content of the object and don't need to =
be decoded ( when using systematic codes and the M data chunks are avai=
lable ).
>
> Cheers
>
> On 01/08/2013 19:14, Loic Dachary wrote:
>>
>>
>> On 01/08/2013 18:42, Loic Dachary wrote:
>>> Hi Sam,
>>>
>>> When the acting set changes order two chunks for the same object ma=
y co-exist in the same placement group. The key should therefore also c=
ontain the chunk number.
>>>
>>> That's probably the most sensible comment I have so far. This docum=
ent is immensely useful (even in its current state) because it shows me=
 your perspective on the implementation.
>>>
>>> I'm puzzled by:
>>
>> I get it ( thanks to yanzheng ). Object is deleted, then created aga=
in ... spurious non version chunks would get in the way.
>>
>> :-)
>>
>>>
>>> CEPH_OSD_OP_DELETE: The possibility of rolling back a delete requir=
es that we retain the deleted object until all replicas have persisted =
the deletion event. ErasureCoded backend will therefore need to store o=
bjects with the version at which they were created included in the key =
provided to the filestore. Old versions of an object can be pruned when=
 all replicas have committed up to the log event deleting the object.
>>>
>>> because I don't understand why the version would be necessary. I th=
ought that deleting an erasure coded object could be even easier than e=
rasing a replicated object because it cannot be resurrected if enough c=
hunks are lots, therefore you don't need to wait for ack from all OSDs =
in the up set. I'm obviously missing something.
>>>
>>> I failed to understand how important the pg logs were to maintainin=
g the consistency of the PG. For some reason I thought about them only =
in terms of being a light weight version of the operation logs. Adding =
a payload to the pg_log_entry ( i.e. APPEND size or attribute ) is a ne=
w idea for me and I would have never thought or dared think the logs co=
uld be extended in such a way. Given the recent problems with logs writ=
es having a high impact on performances ( I'm referring to what forced =
you to introduce code to reduce the amount of logs being written to onl=
y those that have been changed instead of the complete logs ) I thought=
 about the pg logs as something immutable.
>>>
>>> I'm still trying to figure out how PGBackend::perform_write / read =
/ try_rollback would fit in the current backfilling / write / read / sc=
rubbing ... code path.
>>>
>>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cff=
b226fed8d9b7/doc/dev/osd_internals/erasure_coding.rst
>>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cff=
b226fed8d9b7/src/osd/PGBackend.h
>>>
>>> Cheers
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
