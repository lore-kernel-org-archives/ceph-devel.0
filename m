From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: question about snapset
Date: Fri, 3 Feb 2017 18:07:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702031803520.3654@piezo.novalocal>
References: <CAB7xdi=b=HxAepvKna-Rfi9z9Wd+SAxADsbZUkYk-TuEkYJnjA@mail.gmail.com> <alpine.DEB.2.11.1702031359260.3660@piezo.novalocal> <CAB7xdi=NFjC4W3XYSLPYFrs_vN18+TY-5F_UGzCe_TCweYHxdg@mail.gmail.com>
 <CAB7xdikDAtXL6UGzRjKVa6Vzv9QE6if3ixteYu-UApRfMYVOXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34276 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdBCSH0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2017 13:07:26 -0500
In-Reply-To: <CAB7xdikDAtXL6UGzRjKVa6Vzv9QE6if3ixteYu-UApRfMYVOXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 3 Feb 2017, sheng qiu wrote:
> ---------- Forwarded message ----------
> From: sheng qiu <herbert1984106@gmail.com>
> Date: Fri, Feb 3, 2017 at 7:45 AM
> Subject: Re: question about snapset
> To: Sage Weil <sage@newdream.net>
> Cc: ceph-devel <ceph-devel@vger.kernel.org>
> 
> 
> Hi Sage,
> 
> Thanks a lot for your reply. It's very helpful.
> We are trying to avoid the query for snapset object for new object
> write, we think it may save some latency. Currently when we measure
> the op prepare latency, it's around 300 us, which is quite high. Is
> this normal? In our test, we configure 64 pgs per osd and use five
> shards with two workers per shard. The test machine is a four socket
> with 40 cores and plenty of memory.
> We are thinking how to reduce this latency, do you have any suggestions?

There are several sources, and this is an active area of 
investigation and optimization.  I'm not sure that the snapset 
specifically is probably a big part of the problem.. it's like the overall 
work involved with get_object_context(), which will fetch the 
attributes from the object.  The snapset will be a small part of this.

I suggest joining the weekly performance call if you can.  Or we can 
discuss some of the specific efforts on the list.  The main efforts here 
are

- simplifying ms_fast_dispatch so that incoming messages get queued more 
quickly
- making the new BlueStore (ObjectStore implementation) faster
- a big planned refactor for most of the do_op work that happens in 
between.

That's pretty vague but it's going to be a big project.  Right now we're 
trying to remove as much legacy complexity first to make our lives a 
bit easier...

sage


 > 
> Thanks
> Sheng
> 
> 
> On Feb 3, 2017 6:05 AM, "Sage Weil" <sage@newdream.net> wrote:
> >
> > On Thu, 2 Feb 2017, sheng qiu wrote:
> > > Hi cephers,
> > >
> > > We are reading the codes of Ceph I/O path. We found within the
> > > do_op(), it tries to get the object context each time as well as the
> > > snapset context.
> > >
> > > may i ask what's the usage of the snapset context and what's the
> > > relationship between snapset context and the individual object? Does
> > > each object has a snapset context ? Does it stores as attribute within
> > > the onode that associated with the object?
> > > i read some articles said only head object has snapset context, may i
> > > ask what's the head object and what's the relationship between a head
> > > object and other non-head objects?
> >
> > A given logical object may be contained by several snapshots, and we'll
> > have a separate clone for each unique version of the object. The
> > head (snapid == CEPH_NOSNAP) is the latest read/write version of the
> > object.  A clone (snapid < CEPH_NOSNAP) is the version for some number of
> > snapshots.  For example, if you wrote X, took snapshot 1, write X', wrote
> > X'', took snap 2, took snap 3, then wrote X''', you'd have 3 clones with
> > something like
> >
> > X    (snapid 1) snaps=[1]
> > X''  (snapid 3) snaps=[2,3]
> > X''' (head) clones=[1,2]
> >
> > The SnapSet is attached to the head and tells us we have 2 clones (1 and
> > 3).  Each clone has a snaps vector that tells us which snaps it exists in.
> > There's some other bookkeeping in SnapSet as well that tells us what data
> > extents are identical across adjacent clones (so that they can share
> > blocks on disk efficiently).
> >
> > There's one annoying oddity that if the head doesn't logically exist we
> > create an object with snapid CEPH_SNAPDIR and attach the SnapSet to
> > that.  We hope to remove this soon (by storing SnapSet on head and marking
> > head as a whiteout) as it complicates the code.
> >
> > Hope that helps!
> > sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
