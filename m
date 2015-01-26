From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: idempotent op (esp delete)
Date: Mon, 26 Jan 2015 05:51:49 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C5348979991@SHSMSX101.ccr.corp.intel.com>
References: <alpine.DEB.2.00.1501231327570.10173@cobra.newdream.net>
 <CAC6JEv8iKG=uBcojtZ-KwWVGjd75SdYm05YOwdtm_H2TZi1-2g@mail.gmail.com>
 <alpine.DEB.2.00.1501231415040.19192@cobra.newdream.net>
 <06E7D85B3BA36C4DB207FEDE871C5348979944@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39656 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751827AbbAZFv4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jan 2015 00:51:56 -0500
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C5348979944@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Gregory Farnum <greg@gregs42.com>

The downside of this approach is that we may need to search the pg_log for a specific object in every write io? Maybe we can combine this approach and the changes in PR 3447. For the flush case when the object is deleted in the base, we search the pg_log for dup op. This should be rare cases. Otherwise the object exists, we check the reqid list in the object_info_t for dup op.

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Wang, Zhiqiang
Sent: Monday, January 26, 2015 10:35 AM
To: Sage Weil; Gregory Farnum
Cc: ceph-devel@vger.kernel.org
Subject: RE: idempotent op (esp delete)

This method puts the reqid list in the pg_log instead of the object_info_t, so that it's preserved even in the delete case, which sounds more reasonable.

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Saturday, January 24, 2015 6:19 AM
To: Gregory Farnum
Cc: ceph-devel@vger.kernel.org
Subject: Re: idempotent op (esp delete)

On Fri, 23 Jan 2015, Gregory Farnum wrote:
> On Fri, Jan 23, 2015 at 1:43 PM, Sage Weil <sweil@redhat.com> wrote:
> > Background:
> >
> > 1) Way back when we made a task that would thrash the cache modes by 
> > adding and removing the cache tier while ceph_test_rados was running.
> > This mostly worked, but would occasionally fail because we would
> >
> >  - delete an object from the cache tier
> >  - a network failure injection would lose the reply
> >  - we'd disable the cache
> >  - the delete would resend to the base tier, not get recognized as a 
> > dup (different pool, different pg log)
> >    -> -ENOENT instead of 0
> >
> > 2) The proxy write code hits a similar problem:
> >
> >  - delete gets proxied
> >  - we initiate async promote
> >  - a network failure injection loses the delete reply
> >  - delete resends and blocks on promote (or arrives after it
> > finishes)
> >  - promote finishes
> >  - delete is handled
> >   -> -ENOENT instead of 0
> >
> > The ticket is http://tracker.ceph.com/issues/8935
> >
> > The problem is partially addressed by
> >
> >         https://github.com/ceph/ceph/pull/3447
> >
> > by logging a few request ids on every object_info_t and preserving 
> > that on promote and flush.
> >
> > However, it doesn't solve the problem for delete because we throw 
> > out object_info_t so that reqid_t is lost.
> >
> > I think we have two options, not necessarily mutually exclusive:
> >
> > 1) When promoting an object that doesn't exist (to create a 
> > whiteout), pull reqids out of the base tier's pg log so that the 
> > whiteout is primed with request ids.
> >
> > 1.5) When flushing... well, that is harder because we have nowhere 
> > to put the reqids.  Unless we make a way to cram a list of reqid's 
> > into a single PG log entry...?  In that case, we wouldn't strictly 
> > need the per-object list since we could pile the base tier's reqids 
> > into the promote log entry in the cache tier.
> >
> > 2) Make delete idempotent (0 instead of ENOENT if the object doesn't 
> > exist).  This will require a delicate compat transition (let's 
> > ignore that a moment) but you can preserve the old behavior for 
> > callers that care by preceding the delete with an assert_exists op.
> > Most callers don't care, but a handful do.  This simplifies the 
> > semantics we need to support going forward.
> >
> > Of course, it's all a bit delicate.  The idempotent op semantics 
> > have a time horizon so it's all a bit wishy-washy... :/
> >
> > Thoughts?
> 
> Do we have other cases that we're worried about which would be 
> improved by maintaining reqids across pool cache transitions? I'm not 
> a big fan of maintaining those per-op lists (they sound really 
> expensive?), but if we need them for something else that's a point in 
> their favor.

I don't think they're *too* expensive (say, vector of 20 per object_info_t?).  But the only thing I can think of beyond the cache tiering stuff would be cases where the pg log isnt long enough for a very laggy client.  In general ops will be distributed across ops so it will be catch the dup from another angle.

However.. I just hacked up a patch that lets us cram lots of reqids into a single pg_log_entry_t and I think that may be a simpler solution.  We can cram all reqids (for the last N of them) for promote and flush into the single log entry and the delete is no longer special.. it'd work equally well for other dups and for class methods that do who knows what.  The patch is here:

	https://github.com/liewegas/ceph/commit/wip-pg-reqids

What do you think?

> We could make delete idempotent instead and that's what I initially 
> favor, but it also seems a bit scary (it's not like our operations can 
> be made idempotent; lots of them invoke classes that will differ or
> whatever!) and I can't think of which callers might care so I'm having 
> trouble formulating the bounds of this solution.

Yeah, it seems like an easier endpoint but a dangerous path to get there...

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
