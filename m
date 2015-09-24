From: Sage Weil <sweil@redhat.com>
Subject: Re: full cluster/pool handling
Date: Thu, 24 Sep 2015 07:50:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509240744490.13265@cobra.newdream.net>
References: <alpine.DEB.2.00.1509240523510.13834@cobra.newdream.net> <CADRKj5S0L-tH51nsjrChP16GCc8hJaMRBOp8nOZg9XRZzQFU1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49968 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837AbbIXOur (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 Sep 2015 10:50:47 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 5C722C0B91A9
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 14:50:47 +0000 (UTC)
In-Reply-To: <CADRKj5S0L-tH51nsjrChP16GCc8hJaMRBOp8nOZg9XRZzQFU1A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 24 Sep 2015, Yehuda Sadeh-Weinraub wrote:
> On Thu, Sep 24, 2015 at 5:30 AM, Sage Weil <sweil@redhat.com> wrote:
> > Xuan Liu recently pointed out that there is a problem with our handling
> > for full clusters/pools: we don't allow any writes when full,
> > including delete operations.
> >
> > While fixing a separate full issue I ended up making several fixes and
> > cleanups in the full handling code in
> >
> >         https://github.com/ceph/ceph/pull/6052
> >
> > The interesting part of that is that we will allow a write as long as it
> > doesn't increase the overall utilizate of bytes or objects (according to
> > the pg stats we're maintaining).  That will include remove ops, of cours,
> > but will also allow overwrites while full, which seems fair.
> >
> > However, that's not quite the full story: the client side currently
> > does not send any requests while the full flag is set--it waits until the
> > full flags are cleared before resending things.
> >
> > We can modify things on the client so that it allows ops it knows will
> > succeed (e.g., a simple remove op).  However, if there is another op also
> > queued on that object *before* it, we should either block the remove op
> > (to preserve ordering) or discard it when the remove succeeds (on the
> > assumption that any effect it had is now moot).
> 
> What if it was a compound operation that truncates and writes?

In this scenario the objecter is only doing this with pure deletes, so 
presumably all previous write operations irrelevant.  This only works if 
it results in a real delete, though, which is hard to tell from teh client 
side, and also becomes even more complex when we start considering what to 
do if the delete is in-flight and the full flag is cleared (do we send the 
earlier write now? never?).

> > Is the latter option safe?
> >
> > Or, should we do something more clever?  Ideally it would be good if other
> > allowed operations are let through, but unfortunately the client doesn't
> > really know enough to tell whether it will/can succeed.  e.g., a class
> > "refcount.put" call might result in a deletion (and in fact there is a
> > class that does just that).  We could also send all such requests and, if
> 
> rgw (tail) object removals are using this objclass.

Yeah.  I don't see a way for objecter to know whether it's a safe op in 
this case.  I think that means eitehr

 1- we do the crazy thing i just described where we try it all and requeue 
for retry later on ENOSPC, or
 2- we make a librados flag like IGNORE_FULL so that rgw can explicitly 
indicate that the op is a safe one that should skip the client (and osd?) 
side checks for fullness.  Again, we need to block if there is a prior 
write to the same object queued..

I think my vote is for the librados flag, and to simply block those 
requests if another op was already queued on the object.

?

sage
