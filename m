From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: full cluster/pool handling
Date: Thu, 24 Sep 2015 08:32:56 -0700
Message-ID: <CADRKj5TN9qh+hKxTUOxRRbQq=nFz2vOON=qfn39b6AGbGFw5KA@mail.gmail.com>
References: <alpine.DEB.2.00.1509240523510.13834@cobra.newdream.net>
	<CADRKj5S0L-tH51nsjrChP16GCc8hJaMRBOp8nOZg9XRZzQFU1A@mail.gmail.com>
	<alpine.DEB.2.00.1509240744490.13265@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35395 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754122AbbIXPc5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Sep 2015 11:32:57 -0400
Received: by obbzf10 with SMTP id zf10so60749183obb.2
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2015 08:32:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1509240744490.13265@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Sep 24, 2015 at 7:50 AM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 24 Sep 2015, Yehuda Sadeh-Weinraub wrote:
>> On Thu, Sep 24, 2015 at 5:30 AM, Sage Weil <sweil@redhat.com> wrote:
>> > Xuan Liu recently pointed out that there is a problem with our handling
>> > for full clusters/pools: we don't allow any writes when full,
>> > including delete operations.
>> >
>> > While fixing a separate full issue I ended up making several fixes and
>> > cleanups in the full handling code in
>> >
>> >         https://github.com/ceph/ceph/pull/6052
>> >
>> > The interesting part of that is that we will allow a write as long as it
>> > doesn't increase the overall utilizate of bytes or objects (according to
>> > the pg stats we're maintaining).  That will include remove ops, of cours,
>> > but will also allow overwrites while full, which seems fair.
>> >
>> > However, that's not quite the full story: the client side currently
>> > does not send any requests while the full flag is set--it waits until the
>> > full flags are cleared before resending things.
>> >
>> > We can modify things on the client so that it allows ops it knows will
>> > succeed (e.g., a simple remove op).  However, if there is another op also
>> > queued on that object *before* it, we should either block the remove op
>> > (to preserve ordering) or discard it when the remove succeeds (on the
>> > assumption that any effect it had is now moot).
>>
>> What if it was a compound operation that truncates and writes?
>
> In this scenario the objecter is only doing this with pure deletes, so
> presumably all previous write operations irrelevant.  This only works if
> it results in a real delete, though, which is hard to tell from teh client
> side, and also becomes even more complex when we start considering what to
> do if the delete is in-flight and the full flag is cleared (do we send the
> earlier write now? never?).
>
>> > Is the latter option safe?
>> >
>> > Or, should we do something more clever?  Ideally it would be good if other
>> > allowed operations are let through, but unfortunately the client doesn't
>> > really know enough to tell whether it will/can succeed.  e.g., a class
>> > "refcount.put" call might result in a deletion (and in fact there is a
>> > class that does just that).  We could also send all such requests and, if
>>
>> rgw (tail) object removals are using this objclass.
>
> Yeah.  I don't see a way for objecter to know whether it's a safe op in
> this case.  I think that means eitehr
>
>  1- we do the crazy thing i just described where we try it all and requeue
> for retry later on ENOSPC, or
>  2- we make a librados flag like IGNORE_FULL so that rgw can explicitly
> indicate that the op is a safe one that should skip the client (and osd?)
> side checks for fullness.  Again, we need to block if there is a prior
> write to the same object queued..
>
> I think my vote is for the librados flag, and to simply block those
> requests if another op was already queued on the object.
>

Note that in order for rgw tail object to be removed, we first update
the bucket index (prepare), remove the head (another compound
operation with guards), update the bucket index (complete), and
eventually remove the object through the gc. So in order for users to
be able to clear some data we'll need to somehow allow all these
operations to go through. Specifically it will be easy to block on
bucket index updates (e.g., object creation to the same bucket that
sneaks in).


Yehuda
