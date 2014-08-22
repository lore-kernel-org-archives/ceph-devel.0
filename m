From: Gregory Farnum <greg@inktank.com>
Subject: Re: watch/notify changes
Date: Fri, 22 Aug 2014 15:44:04 -0700
Message-ID: <CAPYLRzj6NiL9DrN9kq6emczQetiAJmAgsMPS-g-0qFtH2OfitA@mail.gmail.com>
References: <alpine.DEB.2.00.1408211517320.31172@cobra.newdream.net>
	<CAPYLRziFYx7bW5T3mnrSpGuAjxQ2oxqMomp0ffL1UyqBLDD_7g@mail.gmail.com>
	<alpine.DEB.2.00.1408221118290.31169@cobra.newdream.net>
	<CAPYLRzitTEEA3gyfDO-ac12KdRjf+f1bc9_aPEc-5yNg2e3Dgw@mail.gmail.com>
	<alpine.DEB.2.00.1408221410330.31169@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:45592 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbaHVWoG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 18:44:06 -0400
Received: by mail-qc0-f181.google.com with SMTP id x13so11518768qcv.40
        for <ceph-devel@vger.kernel.org>; Fri, 22 Aug 2014 15:44:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408221410330.31169@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Aug 22, 2014 at 2:30 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 22 Aug 2014, Gregory Farnum wrote:
>> Whereas if the notify timeout is the same time length as a watch
>> timeout, we can affirmatively know on a notify reply (with or without
>> error return codes) that every client has either:
>> 1) seen the notify, or
>> 2) seen the watch connection's timeout period elapse on their side.
>> So no matter what happens in the network, after a notify cycle has
>> elapsed, every client has either seen the new data or knows that they
>> have failed and needs to re-read everything.
>
> Okay, this makes some sense.  I think we still have several problems,
> though, if we want this sort of guarantee.
>
> 1) Notify delivery is distinct from notify ack, even more so with the
> changes I made.  Before we acked when we returned from the callback, which
> could take who knows how long.  Now, the client explicitly acks and need
> not block in the callback doing whatever work they need to do.

I think I'm missing something here; can you elaborate?

>
> 2) The watch timeout generally means we give the client *at least* this
> much time to reconnect, but frequently more.
>
> I think what we probably need to do is mark the Session on the OSD if a
> notify times out so that the guarantee is actually that either
>
> 1) The client acked the notify, or
> 2) The client's watch disconnected (and they will be able to tell that
> they may have missed notifies), or
> 3) The client's Session was marked (and they will be notified that they
> missed notifies)
>
> 2 and 3 will boil down to the same thing as far as the librados API goes.
> We were thinking a combination of a callback (where there is no timeliness
> guarantee for message delivery) and a synchronous call like watch_check()
> where you, say, pass a timestamp and it tells you whether, as of that
> timestamp, you may have missed any events.  Implementing that reliably is
> going to need to involve some sort of ping with the OSD to ensure we've
> seen any events, and/or know that we are still connected as of some time.
>
> Anyway, given those 3 options, I don't think we need notify timeout ==
> watch timeout.  We could do a notify timeout of 1s and any slowish client
> will get their session marked and eventually either find out they missed
> something or find out they've been disconnected.
>
> It seems like anything stronger than 'eventually' has to be handled a bit
> above this interface.  As in, the clients agree that they won't take any
> action unless they know they haven't missed events as of 5 seconds ago.
> (This will allow the watch_check(now - 5s) to not block in the general
> case, as 5s is a wide enough window for the pings.)  If a peer gets a
> notify timeout, they wait 5 more seconds to ensure that time elapses.

Can you give some examples of situations in which an eventual delivery
is a useful building block for something other than "I know this was
delivered"? I'm having trouble coming up with any; in particular both
of our existing use cases (RBD header sync, RGW cache invalidations)
want guaranteed delivery. Otherwise we're stuck delaying every
metadata change on RGW buckets for the timeout period to ensure we're
following ACL policies! And users who are quiescing IO on RBD in order
to take snapshots could get them dirtied if they resume writing on a
node before it's actually processed the header updates.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
