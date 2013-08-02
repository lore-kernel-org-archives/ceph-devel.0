From: Sage Weil <sage@inktank.com>
Subject: Re: PG Backend Proposal
Date: Thu, 1 Aug 2013 20:39:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308012036180.13710@cobra.newdream.net>
References: <51FA8FF7.7090004@dachary.org> <51FA9783.4000206@dachary.org> <51FAF538.1020609@dachary.org> <CA+4uBUa5RL9op66R_bxhcyJ8vjYXy_Ndvym+5M3JKnrGCbfNTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41029 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127Ab3HBDjO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Aug 2013 23:39:14 -0400
In-Reply-To: <CA+4uBUa5RL9op66R_bxhcyJ8vjYXy_Ndvym+5M3JKnrGCbfNTw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 1 Aug 2013, Samuel Just wrote:
> I think there are some tricky edge cases with the above approach.  You
> might end up with two pg replicas in the same acting set which happen
> for reasons of history to have the same chunk for one or more objects.
>  That would have to be detected and repaired even though the object
> would be missing from neither replica (and might not even be in the pg
> log).  The erasure_code_rank would have to be somehow maintained
> through recovery (do we remember the original holder of a particular
> chunk in case it ever comes back?).
> 
> The chunk rank doesn't *need* to match the acting set position, but
> there are some good reasons to arrange for that to be the case:
> 1) Otherwise, we need something else to assign the chunk ranks
> 2) This way, a new primary can determine which osds hold which
> replicas of which chunk rank by looking at past osd maps.
> 
> It seems to me that given an OSDMap and an object, we should know
> immediately where all chunks should be stored since a future primary
> may need to do that without access to the objects themselves.
> 
> Importantly, while it may be possible for an acting set transition
> like [0,1,2]->[2,1,0] to occur in some pathological case, CRUSH has a
> mode which will cause replacement to behave well for erasure codes:
> 
> initial: [0,1,2]
> 0 fails: [3,1,2]
> 2 fails: [3,1,4]
> 0 recovers: [0,1,4]
> 
> We do, however, need to decouple primariness from position in the
> acting set so that backfill can work well.

BTW, this reminds me: this might also be a good time to add the ability in 
the OSDMap to probabilistically reorder acting sets (and adjust 
primariness) for any mapping so that we can cheaply shift read traffic 
around (e.g., based on normal statistical skew, or temorary workload 
balance).  Currently the only way to do this also involves moving data.

s


> -Sam
> 
> On Thu, Aug 1, 2013 at 4:54 PM, Loic Dachary <loic@dachary.org> wrote:
> > Hi Sam,
> >
> > I'm under the impression that
> > https://github.com/athanatos/ceph/blob/wip-erasure-coding-doc/doc/dev/osd_internals/erasure_coding.rst#distinguished-acting-set-positions
> > assumes acting[0] stores all chunk[0], acting[1] stores all chunk[1] etc.
> >
> > The chunk rank does not need to match the OSD position in the acting set. As long as each object chunk is stored with its rank in an attribute, changing the order of the acting set does not require to move the chunks around.
> >
> > With M=2+K=1 and the acting set is [0,1,2] chunks M0,M1,K0 are written on [0,1,2] respectively, each of them have the 'erasure_code_rank' attribute set to their rank.
> >
> > If the acting set changes to [2,1,0] the read would reorder the chunk based on their 'erasure_code_rank' attribute instead of the rank of the OSD they originate from in the current acting set. And then be able to decode them with the erasure code library, which requires that the chunks are provided in a specific order.
> >
> > When doing a full write, the chunks are written in the same order as the acting set. This implies that the order of the chunks of the previous version of the object may be different but I don't see a problem with that.
> >
> > When doing an append, the primary must first retrieve the order in which the objects are stored by retrieving their 'erasure_code_rank' attribute, because the order of the acting set is not the same as the order of the chunks. It then maps the chunks to the OSDs matching their rank and pushes them to the OSDs.
> >
> > The only downside is that it may make things more complicated to implement optimizations based on the fact that, sometimes, chunks can just be concatenated to recover the content of the object and don't need to be decoded ( when using systematic codes and the M data chunks are available ).
> >
> > Cheers
> >
> > On 01/08/2013 19:14, Loic Dachary wrote:
> >>
> >>
> >> On 01/08/2013 18:42, Loic Dachary wrote:
> >>> Hi Sam,
> >>>
> >>> When the acting set changes order two chunks for the same object may co-exist in the same placement group. The key should therefore also contain the chunk number.
> >>>
> >>> That's probably the most sensible comment I have so far. This document is immensely useful (even in its current state) because it shows me your perspective on the implementation.
> >>>
> >>> I'm puzzled by:
> >>
> >> I get it ( thanks to yanzheng ). Object is deleted, then created again ... spurious non version chunks would get in the way.
> >>
> >> :-)
> >>
> >>>
> >>> CEPH_OSD_OP_DELETE: The possibility of rolling back a delete requires that we retain the deleted object until all replicas have persisted the deletion event. ErasureCoded backend will therefore need to store objects with the version at which they were created included in the key provided to the filestore. Old versions of an object can be pruned when all replicas have committed up to the log event deleting the object.
> >>>
> >>> because I don't understand why the version would be necessary. I thought that deleting an erasure coded object could be even easier than erasing a replicated object because it cannot be resurrected if enough chunks are lots, therefore you don't need to wait for ack from all OSDs in the up set. I'm obviously missing something.
> >>>
> >>> I failed to understand how important the pg logs were to maintaining the consistency of the PG. For some reason I thought about them only in terms of being a light weight version of the operation logs. Adding a payload to the pg_log_entry ( i.e. APPEND size or attribute ) is a new idea for me and I would have never thought or dared think the logs could be extended in such a way. Given the recent problems with logs writes having a high impact on performances ( I'm referring to what forced you to introduce code to reduce the amount of logs being written to only those that have been changed instead of the complete logs ) I thought about the pg logs as something immutable.
> >>>
> >>> I'm still trying to figure out how PGBackend::perform_write / read / try_rollback would fit in the current backfilling / write / read / scrubbing ... code path.
> >>>
> >>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb226fed8d9b7/doc/dev/osd_internals/erasure_coding.rst
> >>> https://github.com/athanatos/ceph/blob/ba5c97eda4fe72a25831031a2cffb226fed8d9b7/src/osd/PGBackend.h
> >>>
> >>> Cheers
> >>>
> >>
> >
> > --
> > Lo?c Dachary, Artisan Logiciel Libre
> > All that is necessary for the triumph of evil is that good people do nothing.
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
