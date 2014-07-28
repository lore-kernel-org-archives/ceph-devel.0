From: Sage Weil <sweil@redhat.com>
Subject: Re: wip-objecter
Date: Mon, 28 Jul 2014 15:17:04 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407281512440.4962@cobra.newdream.net>
References: <alpine.DEB.2.00.1407251727430.5027@cobra.newdream.net> <CAGd4Wr17ds-r8u4ZZfSwptsCV9LV43s206=c_uee5Lp4R7ex3A@mail.gmail.com> <alpine.DEB.2.00.1407281437030.4962@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45214 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbaG1WRF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jul 2014 18:17:05 -0400
In-Reply-To: <alpine.DEB.2.00.1407281437030.4962@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 28 Jul 2014, Sage Weil wrote:
> On Sun, 27 Jul 2014, John Spray wrote:
> > I think that for the calls where we check the epoch and then
> > conditionally call wait_for_map with the context, we have to change
> > them to do the wait_for_map call first and check the boolean response.
> > Otherwise, if the map we have is updated between the read of the epoch
> > and the call to wait_for_map, it could already be ready and never call
> > back our context.
> > 
> > My version is here (on top a rebase of wip-objecter to master on branch 
> > wip-objecter-rebase): 
> > https://github.com/ceph/ceph/commit/3cd82464ed6f13ec5b44da303849061648b9e3a1
> 
> Okay, I finally got around to looking at this again, and it looks like we 
> managed to collide on a few things.  The wip-objecter-rebase branch is 
> missing the change in my series, specifically the old commit
> 
>  fa8d2d581b3da0fc5176a674623738cd555a3766
> 
> is replaced with
> 
>  7cb3cf98b09685ebd48451878ded3cbc212e0a12
> 
> in the (rebased) wip-objecter.  Also, the missing } was squashed into
> 
>  e596ad8e67719f7fb8e96b579c34a438f51c319f
> 
> Anyway, I rebased and resolved conflicts and pushed a new 
> wip-objecter-rebased which looks like it has the right diff between the 
> old and new versions.
> 
> Take a look?  The main change is that the set data pool virtual xattrs do 
> objecter->wait_for_latest_osdmap() and the flawed MDS::request_osdmap() 
> helper is now gone.

...and I pushed a couple more patches.  One fixes the wait_for_map callers 
so that they don't leak the completion when we already have the map.  The 
second applies the _IO_ naming thing to completions that have to retake 
the mds_lock.

But that makes me realize that a handful of the MDLog::submit_entry()
callers are passing in completions that take the lock, but there are a 
zillion other callers that aren't.

I wonder if a safer approach is to make a subclass of Context called 
RelockingContext, which takes an mds_lock * in the ctor, and then make all 
of the other completions subclasses of that.  That way we can use type 
checking to ensure that all Context's passed to MDLog::submit_entry() (or 
other places that make sense) are of the right type.  Hopefully there 
aren't any classes that are used in both and locking and non-locking 
context...

Alternatively, we could make a LockingFinisher class that takes the 
specified lock (mds_lock) before calling each Context.  That might be 
simpler?

sage

