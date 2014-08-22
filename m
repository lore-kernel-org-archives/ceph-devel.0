From: Gregory Farnum <greg@inktank.com>
Subject: Re: watch/notify changes
Date: Fri, 22 Aug 2014 16:29:43 -0700
Message-ID: <CAPYLRzgCS=mpC=zL+=eWJvgGUQWQF5HMbOaBYE86McRzG1W1aA@mail.gmail.com>
References: <alpine.DEB.2.00.1408211517320.31172@cobra.newdream.net>
	<CAPYLRziFYx7bW5T3mnrSpGuAjxQ2oxqMomp0ffL1UyqBLDD_7g@mail.gmail.com>
	<alpine.DEB.2.00.1408221118290.31169@cobra.newdream.net>
	<CAPYLRzitTEEA3gyfDO-ac12KdRjf+f1bc9_aPEc-5yNg2e3Dgw@mail.gmail.com>
	<alpine.DEB.2.00.1408221410330.31169@cobra.newdream.net>
	<CAPYLRzj6NiL9DrN9kq6emczQetiAJmAgsMPS-g-0qFtH2OfitA@mail.gmail.com>
	<alpine.DEB.2.00.1408221546150.31169@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60014 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbaHVX3o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 19:29:44 -0400
Received: by mail-qc0-f174.google.com with SMTP id l6so11592948qcy.33
        for <ceph-devel@vger.kernel.org>; Fri, 22 Aug 2014 16:29:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408221546150.31169@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 22, 2014 at 3:59 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 22 Aug 2014, Gregory Farnum wrote:
>> Can you give some examples of situations in which an eventual delivery
>> is a useful building block for something other than "I know this was
>> delivered"? I'm having trouble coming up with any; in particular both
>> of our existing use cases (RBD header sync, RGW cache invalidations)
>> want guaranteed delivery. Otherwise we're stuck delaying every
>> metadata change on RGW buckets for the timeout period to ensure we're
>> following ACL policies! And users who are quiescing IO on RBD in order
>> to take snapshots could get them dirtied if they resume writing on a
>> node before it's actually processed the header updates.
>
> Eventual delivery is necessary but not sufficient.  That's what
> watch_check() is for: it tells us whether, as of some timestamp, we have
> seen the notifies, or that we've possibly missed some.  A simple callback
> is never sufficient for any notification guarantee because schedulers and
> everything else can arbitrarily delay it.
>
> For the RGW cache use-case:
>
> Each client registers a watch.  Timeout is, say, 30s.
>
> On each cache use, client calls watch_check(now - 5s).  If that is true,
> we consider our cache valid.  Specifically, success means that sometime
> after (now - 5s) we sent a message to the OSD and got an ack that confirms
> the watch was intact and we had missed no notifies as of that time.  If it
> is false, we consider the cache state unknown and (presumably) fall back
> to rereading the bucket metadata.
>
> On notify callback, we invalidate an entry, and then ack.
>
> On modify, we make the update, and then:
>
>  - send notify, timeout = 5s
>  - on success, we are done (let's say this usually takes 30ms)
>  - on timeout (i.e., 5s), we now know that the other client will
> eventually discover they missed the timeout.  We wait a bit longer (I
> think < 5s?  I need to draw a picture) to ensure their watch_check() alls
> will fail, and then succeed (the original modify).

Actually, as long as the OSD is the one doing the 5s timeout (which I
believe it still is?) then we don't need to wait any more (assuming
same-rate clocks). The client's 5-second timeout (as described)
requires going through the OSD and then only extends from its
client-side send point, so the most recent one of those that succeeded
must have been sent prior to the transmission of the notify. Yay
ordering guarantees.

> I think this mainly boils down to making sure that the watch heartbeats
> are done properly (they need to check the session state to ensure there
> weren't notifies we missed, and also verify we are still talking to the
> correct OSD for the given object).

So yes, certainly we can build a guaranteed-delivery system out of
this, as you've illustrated. But it requires us to implement all of
that logic in the client application instead of having a single
implementation defined in the library and network interface; it
requires that each of the clients be using the same values for
timeouts; etc. It just seems easier to maintain if we do all of that
on the infrastructure end (timeouts can be specified by the OSDs when
the watch is created, or even configured via new ops on a per-object
basis, etc, without having to change existing clients); it
dramatically increases the odds that a developer uses the watch-notify
library incorrectly (witness: us, thinking we had these guarantees
previously). :)

Anyway, I'm happy to discuss this on irc or something: I feel like
you're trying to satisfy requirements that I'm just ignoring but I
don't know what they could be.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
