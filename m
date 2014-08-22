From: Gregory Farnum <greg@inktank.com>
Subject: Re: watch/notify changes
Date: Fri, 22 Aug 2014 11:13:53 -0700
Message-ID: <CAPYLRziFYx7bW5T3mnrSpGuAjxQ2oxqMomp0ffL1UyqBLDD_7g@mail.gmail.com>
References: <alpine.DEB.2.00.1408211517320.31172@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:55828 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932410AbaHVSNy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Aug 2014 14:13:54 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so9880457qaq.24
        for <ceph-devel@vger.kernel.org>; Fri, 22 Aug 2014 11:13:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408211517320.31172@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Aug 21, 2014 at 3:34 PM, Sage Weil <sweil@redhat.com> wrote:
> Sam and Josh and I discussed the state of watch/notify a couple weeks
> back.  Here are our notes:
>
>         http://pad.ceph.com/p/watch-notify
>
> I've mapped most of these to tickets or bugs and noted them in the pad.
>
> Ignore the fact that these are in the v0.86 sprint currently; it's just
> easier to enter them that way.
>
> If there are other issues we're missing here, let's address them now.  The
> API changes so far can be seen at
>
>         https://github.com/ceph/ceph/commit/7ba30230505c6eede06cb2e2cb64210fdd4025a8
>         https://github.com/ceph/ceph/commit/d179dd970e52db8b0c07b20f69c9e3be6bc43f09

I'm not entirely up on how watch-notify is implemented right now
because it's been a bit of a mess, but this set of patches is a lot
smaller than I was expecting when I started hearing about reworking
it. The specific problem I remember remaining is:
1) Notifiers can specify a timeout after which point the notify gets
completed regardless of the status of the watchers
2) Watchers have a separate timeout (which is often larger)
3) There's no notification to either the watchers or the notifier if
the notify timeout is hit.

So it looks like this patch set addresses point 3 by telling the
*notifier* that the notification didn't actually happen; correct? Are
there plans to change this so that either we don't have the
overlapping timeouts, or a timeout triggers a watch failure for the
timed-out watcher (and a callback to them, if possible), or the
notifier has some recourse under this failure scenario?
This might be #9195, but there's not enough detail in that series of
tickets for me to be certain.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
