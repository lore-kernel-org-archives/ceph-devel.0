From: Sage Weil <sage@newdream.net>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Wed, 30 Mar 2011 14:55:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103301449400.18670@cobra.newdream.net>
References: <4D939FF7.1070104@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46487 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab1C3Vwf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2011 17:52:35 -0400
In-Reply-To: <4D939FF7.1070104@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 30 Mar 2011, Jim Schutt wrote:
> > Hmm!  That does seem to point at the allocator, doesn't it.
> > 
> > Other threads are doing work during this long interval?  Including freeing
> > memory, presumably, since basically everything uses the heap one way or
> > another.  If it's the allocator, it's somehow affecting one thread only,
> > which is pretty crazy.
> > 
> > Is it difficult for you to try this with tcmalloc?  That'll tell us
> > something.
> 
> I finally had a chance to rerun this testing, using
> tcmalloc (from google-perftools v1.7) and libatomic_ops (v1.2-2)
> against current next branch (commit a2ec936a7cd1c).
> 
> I still get lots of slow RefCountedObject::put calls.

Argh...

We've verified there's no swapping going on, right?  The allocator isn't 
touching cold pages and waiting for them to be swapped in or something?

> > One other possibility would be to try to catch this "in the act" and send it
> > a SIGABRT to get a core dump.  Then we can look in more detail at what this
> > (and other) threads are up to.  I'm not sure how easy this is to catch on a
> > particular node...
> 
> I'll try this next, assuming that using an assert
> in RefCountedObject::put that() "delete this" takes
> less than, say, 1 second will catch the state of
> the other threads at an interesting place.
> 
> Does that sound OK?

I was actually suggesting we try to make it core dump inside the "delete 
this" and watching for a stall in progress and then sending SIGABRT to 
dump core in the act.  That way we verify it really is in the allocator 
(and maybe even see where).  That's a bit harder to set up, though!  

Dumping right after may still yield some useful info, but I'm less 
hopeful...

sage
