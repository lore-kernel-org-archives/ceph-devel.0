From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: removed_snaps
Date: Wed, 11 Oct 2017 14:25:15 -0700
Message-ID: <CAJ4mKGZbPjKNchv+cqcx_uRhb3GtX5D7ZNj-0UHTapbaHascrQ@mail.gmail.com>
References: <alpine.DEB.2.11.1710111556410.26702@piezo.us.to>
 <CAJ4mKGaw-6Yu5pK97r0GK5q2_Kt=O2d6SG9um+Xvr8JdAKX88A@mail.gmail.com> <alpine.DEB.2.11.1710111841060.26702@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:52695 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdJKVZR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Oct 2017 17:25:17 -0400
Received: by mail-io0-f179.google.com with SMTP id f20so3308843ioj.9
        for <ceph-devel@vger.kernel.org>; Wed, 11 Oct 2017 14:25:17 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1710111841060.26702@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "Mclean, Patrick" <Patrick.Mclean@sony.com>

On Wed, Oct 11, 2017 at 12:02 PM, Sage Weil <sweil@redhat.com> wrote:
> On Wed, 11 Oct 2017, Gregory Farnum wrote:
>> On Wed, Oct 11, 2017 at 9:13 AM, Sage Weil <sweil@redhat.com> wrote:
>> > I'm working on removing the removed_snaps field from pg_pool_t (and
>> > thus the OSDMap) as this can get very large for clusters that have aged
>> > and use snapshots.
>> >
>> >         https://github.com/ceph/ceph/blob/master/src/osd/osd_types.h#L1320
>> >
>> > The short version of the plan is only include recently removed snaps in
>> > the map.  Once all PGs in a pool have reported that the snap has been
>> > trimmed, we can safely retire the snapid from that set.
>> >
>> > There are a couple of possible problems related to the fact that the
>> > OSD currently santizes the SnapContext with every write by removing
>> > snapids that appear in removed_snaps.  This is meant to deal with race
>> > conditions where the IO was submitted before the snap was removed, but the
>> > OSD has already logically removed it (or scheduled it for removal).
>> >
>> > I see two categories of problems:
>> >
>> > 1. The IO was prepared at the librados client before the snap was removed,
>> > the IO is delayed (e.g., client can't connect, or PG is inactive, etc.)
>> > until after the snap is deleted and retired from removed_snaps, and then
>> > the IO is processed.  This could trigger a clone on the OSD that will
>> > then never get cleaned up.
>> >
>> > Specifically, a librbd example:
>> >
>> >  a. librbd prepares a IOContext that includes snap S
>> >  b. librbd initiates a librados IO with on that ioc.  That request is
>> >     delayed.
>> >  c. Snap S is removed (someone tells the mon to delete it)
>> >     - either our librbd client did it, or another one did and we get a
>> >       notify telling us to refresh our header; doesn't matter which.
>> >  d. S is included in OSDMap removed_snaps.
>> >  e. all OSDs prune S
>> >  f. S is removed from removed_snaps some time later
>> >  g. The request from (b) finally reaches the OSD and triggers a clone S
>> >     (which will never get cleaned up)
>> >
>> > I think we can fix this problem by making Objecter slightly smarter: it
>> > can watch OSDMaps it receives and prune snapc's for in-flight requests.
>> > In the above scenario, sometime between d and g, when it finally
>> > gets a recent OSDMap, it will have pruned S from the request's snapc.  If
>> > it didn't get the map, and the request is still tagged with an old
>> > OSDMap, the OSD can kill the OSD session to force a reconnect/resend. It
>> > can do this for any incoming client request tagged with an OSDMap prior to
>> > a low-water-mark epoch in the OSDMap for which older removed_snaps
>> > have been proved (e.g. removed_snaps_pruned_epoch, or some better name).
>> >
>> > In the extreme case where a client is disconnected for so long that they
>> > can't advance their map to the current one due to the mon having trimmed
>> > maps, and they have outstanding writes with snapcs, the client
>> > can choose to fail the requests with EIO or ESTALE or something, or crash
>> > itself, or otherwise behave as if it has been blacklisted/fenced (if it's
>> > RBD, it probably has anyway).
>>
>> This all sounds good, except...
>> How on earth do we process these snapc trims in a way that doesn't
>> bring us back down to effectively single-threaded transfer speeds?
>>
>> We might be able to do something with publishing a list of trimmed
>> snaps and having the dispatch threads check their op snapcs against
>> that shared data, but I'm not sure and we'd need to performance test
>> very carefully...
>
> The only Objecter change here is that when we get a new osdmap we would
> apply removed_snaps_this_epoch to the current in-flight requests.  We
> already walk all in-flight ops on map changes to recheck the CRUSH
> mapping, and the snapc lists are short, and we can construct the OSDMap so
> that it has the list of newly-deleted snaps for just that epoch in a new
> field, so I don't think this will have any measureable impact on
> performance.
>
> Is there a different effect I'm missing?

I was worried about the map walk. I hadn't thought about the CRUSH
mapping changes so I guess I don't know how that's implemented, but if
it works that's good!

>
>> > 2. There is a bug, and the librbd image is out of sync: it thinks that
>> > snap S still exists but in reality it has been pruned.  If this happens,
>> > then the librbd client may use S and it may trigger a clone.  However,
>> > that snap still is referenced from the image, so it will presumably
>> > eventually get deleted and cleaned up.
>> >
>> > Greg suggested the possibility of a similar CephFS bug, where for example
>> > a CephFS client gets confused and continues sending snapcs with removed
>> > snaps.  I think we can catch this category of bug (and probably #2 as
>> > well) if we make the OSD log an error/warning to the cluster log if it
>> > gets an incoming request including a deleted snapid when the request is
>> > marked with an epoch after when the snap was deleted.  This would
>> > would mean adding the deleted_epoch for each removed snapid to pg_pool_t
>> > to do properly; maybe worth it, maybe not?
>>
>> I don't quite understand; can you expand on this?
>
> The annoyingly confusing thing about this is that snapids are kind of like
> time points, but the set of existing snapids has nothing to do with what
> we've trimmed from removed_snaps... it's not like we can just drop low
> snapids out of the set, since the snapid is the snap creation "when" and
> not the deletion "when."
>
> So, if we want to catch buggy clients that try to use snapcontexts with
> deleted snapids, we need to know which epoch each snapid was deleted in so
> that we can compare that to the request epoch.
>
> I'm not so sure this will work out.  For one, there is a sort of race
> condition when librbd is setting up the snapc itself, since a
> concurrent client might delete the snap before it refreshes, so that it
> constructs a snapc with a bad snap after librados sees the osdmap deleting
> it.  :/  Maybe it's not worth worrying about this piece.

Oh, so instead of having just "interval_set<snapid> deleted_snaps",
we'd have to add "map<snapid, epoch_t> deleted_snap_epochs" (or
equivalent) and then compare those (plus a floor epoch for
oldest-known-deletion) to any incoming snapcontext?

And for the warning, we'd have some of the snapids that should have
been deleted still around for comparison. So we wouldn't have any way
of reliably identifying them all, but we'd expect to see some of them
turning up if it's an ongoing problem?

>
>
>> Let me also suggest one other idea that came up when I was discussing
>> snapshots with Patrick, by first laying out the problems we're aware
>> of:
>> 1) the OSDMap itself might grow too large
>> 2) comparing very large interval sets of snapIDs is computationally
>> expensive for the OSD. We do this
>>   a) when processing a new OSDMap against each PG's local list of deleted snaps
>>   b) when comparing the deleted snaps against incoming snapcontexts
>> (although this is usually not an issue because incoming snapcontexts
>> tend to be pretty small)
>>
>> So we want to limit the size of the OSDMap, and we also want to avoid
>> very large comparisons. Why don't we attack these problems
>> individually?
>>
>> 1) Switch from a deleted_snaps set to a deleting_snaps set in the
>> OSDMap, and trim it based on per-PG feedback to the manager.
>> 2) Maintain a *full* deleted_snaps set in the PG info on the OSDs.
>> 3) Only load into memory the deleted_snaps we reasonably expect to
>> see, *along* with a boundary snapid indicating what range the set is
>> valid for.
>> 4) If we get a snapid smaller than the range is valid for (in a
>> client's SnapContext, or I suppose in the deleting_snaps map), load
>> load more deleted snapids off disk to do the comparison.
>>
>> I haven't sketched out all the code paths but when I skimmed things
>> over I think that snapcontext check (and possible off-disk loading) is
>> actually in any easy-to-wait location. This avoids us needing to
>> change the client wire protocol or introduce more ordering
>> dependencies.
>>
>> The biggest downside I can see is that it adds a pretty obvious
>> DoS/resource consumption attack for malicious clients, but we're not
>> exactly immune to those in general. Thoughts?
>
> I think this would definitly work.  I'm still hoping that we can avoid
> having the full set of deleted snaps maintained on the OSD at all,
> though--that will cut out a lot of complexity (and memory (and storage)).
>
>
> FWIW what I'm currently trying is adding new fields to the map for snapids
> deleted *this* epoch.  That makes it easy for Objecter to adjust its
> requests accordingly.  On the OSD, it also makes the interval_set
> calculcations on map updates faster (we already know what hte new snapids
> are).
>
> And I think it will open up the possibility of removing removed_snaps
> entirely from pg_pool_t if the PGs track the same set locally.  In fact, I
> think in the limit we'll end up with each osdmap epoch just containing (1)
> newly deleted snapids this epoch, and (2) newly purged snapids this epoch.
> The PGs will maintain the set of deleting snapids (in pg_info_t or
> similar, sharing it during peering etc), and we'll keep that window
> short-ish to prevent it from getting too big.  I'm thinking a 1-5 day
> window... basically, whatever the window of laggy clients getting the boot
> is that you can tolerate.  The OSDs will only be pruning incoming snapcs
> against that deleting_snaps set (small!), OSDMaps themselves won't be big
> (each one will only include newly deleted or purged ids).  If a PG falls
> behind and jumps a map gap, it will backfill anyway and get mopped up that
> way...
>
> But... the cost of eliminating all of that crap is losing the client's
> ability to have an in-flight request that is days old reconnect and
> proceed.  Fair trade?

Well, thinking about it more I'm not sure how we could sensibly store
a good boundary for storing some of the deleted snaps out of memory
anyway. So I think we have to go this direction. But I want to think
about it a bit more because I'm still concerned about the buggy
resurrection of snapids.

Maybe we store the full set on disk, cache what we see in-memory, and
check validity against the disk on any snapid we don't have cached? :/
-Greg
