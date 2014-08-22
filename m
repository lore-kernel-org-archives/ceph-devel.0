From: Sage Weil <sweil@redhat.com>
Subject: Re: watch/notify changes
Date: Fri, 22 Aug 2014 14:30:25 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408221410330.31169@cobra.newdream.net>
References: <alpine.DEB.2.00.1408211517320.31172@cobra.newdream.net> <CAPYLRziFYx7bW5T3mnrSpGuAjxQ2oxqMomp0ffL1UyqBLDD_7g@mail.gmail.com> <alpine.DEB.2.00.1408221118290.31169@cobra.newdream.net>
 <CAPYLRzitTEEA3gyfDO-ac12KdRjf+f1bc9_aPEc-5yNg2e3Dgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55292 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbaHVVaZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 17:30:25 -0400
In-Reply-To: <CAPYLRzitTEEA3gyfDO-ac12KdRjf+f1bc9_aPEc-5yNg2e3Dgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 22 Aug 2014, Gregory Farnum wrote:
> Whereas if the notify timeout is the same time length as a watch
> timeout, we can affirmatively know on a notify reply (with or without
> error return codes) that every client has either:
> 1) seen the notify, or
> 2) seen the watch connection's timeout period elapse on their side.
> So no matter what happens in the network, after a notify cycle has
> elapsed, every client has either seen the new data or knows that they
> have failed and needs to re-read everything. 

Okay, this makes some sense.  I think we still have several problems, 
though, if we want this sort of guarantee.

1) Notify delivery is distinct from notify ack, even more so with the 
changes I made.  Before we acked when we returned from the callback, which 
could take who knows how long.  Now, the client explicitly acks and need 
not block in the callback doing whatever work they need to do.

2) The watch timeout generally means we give the client *at least* this 
much time to reconnect, but frequently more.  

I think what we probably need to do is mark the Session on the OSD if a 
notify times out so that the guarantee is actually that either

1) The client acked the notify, or
2) The client's watch disconnected (and they will be able to tell that 
they may have missed notifies), or
3) The client's Session was marked (and they will be notified that they 
missed notifies)

2 and 3 will boil down to the same thing as far as the librados API goes.  
We were thinking a combination of a callback (where there is no timeliness 
guarantee for message delivery) and a synchronous call like watch_check() 
where you, say, pass a timestamp and it tells you whether, as of that 
timestamp, you may have missed any events.  Implementing that reliably is 
going to need to involve some sort of ping with the OSD to ensure we've 
seen any events, and/or know that we are still connected as of some time.  

Anyway, given those 3 options, I don't think we need notify timeout == 
watch timeout.  We could do a notify timeout of 1s and any slowish client 
will get their session marked and eventually either find out they missed 
something or find out they've been disconnected.

It seems like anything stronger than 'eventually' has to be handled a bit 
above this interface.  As in, the clients agree that they won't take any 
action unless they know they haven't missed events as of 5 seconds ago.  
(This will allow the watch_check(now - 5s) to not block in the general 
case, as 5s is a wide enough window for the pings.)  If a peer gets a 
notify timeout, they wait 5 more seconds to ensure that time elapses.

> My recollection is that
> this sequence of timeouts and notification events (or one very much
> like it) is the theoretical lower bound if you're going to do reliable
> information delivery, but I can't find the proof at the moment (it's
> associated in my head with ZooKeeper's watch mechanism, but neither of
> the papers I have on hand discuss it in any detail). If you don't have
> reliable information delivery, what good does watch-notify do?

I'm not familiar with any of this, but it would be useful to validate 
whatever approach we take against that to ensure we don't botch things 
again!

sage
