From: Sage Weil <sweil@redhat.com>
Subject: Re: watch/notify changes
Date: Fri, 22 Aug 2014 11:22:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408221118290.31169@cobra.newdream.net>
References: <alpine.DEB.2.00.1408211517320.31172@cobra.newdream.net> <CAPYLRziFYx7bW5T3mnrSpGuAjxQ2oxqMomp0ffL1UyqBLDD_7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54313 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbaHVSWr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 14:22:47 -0400
In-Reply-To: <CAPYLRziFYx7bW5T3mnrSpGuAjxQ2oxqMomp0ffL1UyqBLDD_7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 22 Aug 2014, Gregory Farnum wrote:
> On Thu, Aug 21, 2014 at 3:34 PM, Sage Weil <sweil@redhat.com> wrote:
> > Sam and Josh and I discussed the state of watch/notify a couple weeks
> > back.  Here are our notes:
> >
> >         http://pad.ceph.com/p/watch-notify
> >
> > I've mapped most of these to tickets or bugs and noted them in the pad.
> >
> > Ignore the fact that these are in the v0.86 sprint currently; it's just
> > easier to enter them that way.
> >
> > If there are other issues we're missing here, let's address them now.  The
> > API changes so far can be seen at
> >
> >         https://github.com/ceph/ceph/commit/7ba30230505c6eede06cb2e2cb64210fdd4025a8
> >         https://github.com/ceph/ceph/commit/d179dd970e52db8b0c07b20f69c9e3be6bc43f09
> 
> I'm not entirely up on how watch-notify is implemented right now
> because it's been a bit of a mess, but this set of patches is a lot
> smaller than I was expecting when I started hearing about reworking
> it. The specific problem I remember remaining is:
> 1) Notifiers can specify a timeout after which point the notify gets
> completed regardless of the status of the watchers

This is the error code patches.  The notifier now gets -ETIMEDOUT.

> 2) Watchers have a separate timeout (which is often larger)

This is by design.  I remember there was some suggestion that this was a 
problem, but when we talked a couple weeks back we couldn't figure out 
what it might be.  The watch timeout is about client reconnects and 
failures.  The notify timeout could be message or application dependent... 
it's just how long the notifier is willing to wait.

> 3) There's no notification to either the watchers or the notifier if
> the notify timeout is hit.

The notifier gets the error.  I opened tickets for the watcher to tell 
whether it may have missed notifies.  The main change is that when a 
watch reconnects, it needs to be a different 'watch-reconnect' op so that 
the client (Objecter) gets an error code if the watch was disconnected 
(and therefore notifies may have been missed).

sage
