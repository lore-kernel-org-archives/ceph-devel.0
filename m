From: Sage Weil <sage@inktank.com>
Subject: Re: handling fs errors
Date: Tue, 22 Jan 2013 15:08:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301221507570.17154@cobra.newdream.net>
References: <alpine.DEB.2.00.1301212200031.29915@cobra.newdream.net> <CABYiri8U-pW4ekuJEy0xtvwFE6mzV1JnO=7n+BD7BTbH9nBOwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40058 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab3AVXIY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 18:08:24 -0500
In-Reply-To: <CABYiri8U-pW4ekuJEy0xtvwFE6mzV1JnO=7n+BD7BTbH9nBOwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

On Wed, 23 Jan 2013, Andrey Korolyov wrote:
> On Tue, Jan 22, 2013 at 10:05 AM, Sage Weil <sage@inktank.com> wrote:
> > We observed an interesting situation over the weekend.  The XFS volume
> > ceph-osd locked up (hung in xfs_ilock) for somewhere between 2 and 4
> > minutes.  After 3 minutes (180s), ceph-osd gave up waiting and committed
> > suicide.  XFS seemed to unwedge itself a bit after that, as the daemon was
> > able to restart and continue.
> >
> > The problem is that during that 180s the OSD was claiming to be alive but
> > not able to do any IO.  That heartbeat check is meant as a sanity check
> > against a wedged kernel, but waiting so long meant that the ceph-osd
> > wasn't failed by the cluster quickly enough and client IO stalled.
> >
> > We could simply change that timeout to something close to the heartbeat
> > interval (currently default is 20s).  That will make ceph-osd much more
> > sensitive to fs stalls that may be transient (high load, whatever).
> >
> > Another option would be to make the osd heartbeat replies conditional on
> > whether the internal heartbeat is healthy.  Then the heartbeat warnings
> > could start at 10-20s, ping replies would pause, but the suicide could
> > still be 180s out.  If the stall is short-lived, pings will continue, the
> > osd will mark itself back up (if it was marked down) and continue.
> >
> > Having written that out, the last option sounds like the obvious choice.
> > Any other thoughts?
> >
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> By the way, is there any worth of preventing situation below - one
> host buried down in the softlocks marking almost all neighbors down
> for a short time? That`s harmless, because all osds will rejoin
> cluster in couple of next heartbeats, but all I/O will stuck at this
> time, rather than only operations with pgs on failing osd, so may be
> it`ll be useful to introduce kind of down-mark-quorum for such cases.
> 
> 2013-01-22 14:40:31.481174 mon.0 [INF] osd.0 10.5.0.10:6800/6578
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.481085 >=
> grace 20
> .000000)

I believe there is already a tuanble to adjust this... 'min reporters' or 
something, check 'ceph --show-config | grep ^mon'.

sage


> 2013-01-22 14:40:31.481293 mon.0 [INF] osd.1 10.5.0.11:6800/6488
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.481228 >=
> grace 20
> .000000)
> 2013-01-22 14:40:31.481410 mon.0 [INF] osd.2 10.5.0.12:6803/7561
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.481355 >=
> grace 20
> .000000)
> 2013-01-22 14:40:31.481522 mon.0 [INF] osd.4 10.5.0.14:6803/5697
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.481467 >=
> grace 20
> .000000)
> 2013-01-22 14:40:31.481641 mon.0 [INF] osd.6 10.5.0.16:6803/5679
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.481586 >=
> grace 20.000000)
> 2013-01-22 14:40:31.481746 mon.0 [INF] osd.8 10.5.0.10:6803/6638
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.481700 >=
> grace 20.000000)
> 2013-01-22 14:40:31.481863 mon.0 [INF] osd.9 10.5.0.11:6803/6547
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.481811 >=
> grace 20.000000)
> 2013-01-22 14:40:31.481976 mon.0 [INF] osd.10 10.5.0.12:6800/7019
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.481916 >=
> grace 20.000000)
> 2013-01-22 14:40:31.482077 mon.0 [INF] osd.12 10.5.0.14:6800/5637
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.482022 >=
> grace 20.000000)
> 2013-01-22 14:40:31.482184 mon.0 [INF] osd.14 10.5.0.16:6800/5620
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.482130 >=
> grace 20.000000)
> 2013-01-22 14:40:31.482334 mon.0 [INF] osd.17 10.5.0.31:6800/5854
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.482275 >=
> grace 20.000000)
> 2013-01-22 14:40:31.482436 mon.0 [INF] osd.18 10.5.0.32:6800/5981
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.482389 >=
> grace 20.000000)
> 2013-01-22 14:40:31.482539 mon.0 [INF] osd.19 10.5.0.33:6800/5570
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.482489 >=
> grace 20.000000)
> 2013-01-22 14:40:31.482667 mon.0 [INF] osd.20 10.5.0.34:6800/5643
> failed (3 reports from 1 peers after 2013-01-22 14:40:54.482620 >=
> grace 20.000000)
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
