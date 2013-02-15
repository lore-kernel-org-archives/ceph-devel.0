From: Sage Weil <sage@inktank.com>
Subject: Re: Mon losing touch with OSDs
Date: Thu, 14 Feb 2013 20:57:11 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302142051250.19927@cobra.newdream.net>
References: <20130215032939.GA25578@onthe.net.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46880 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932650Ab3BOE5L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 23:57:11 -0500
In-Reply-To: <20130215032939.GA25578@onthe.net.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Dunlop <chris@onthe.net.au>
Cc: ceph-devel@vger.kernel.org

Hi Chris,

On Fri, 15 Feb 2013, Chris Dunlop wrote:
> G'day,
> 
> In an otherwise seemingly healthy cluster (ceph 0.56.2), what might cause the
> mons to lose touch with the osds?
> 
> I imagine a network glitch could cause it, but I can't see any issues in any
> other system logs on any of the machines on the network.
> 
> Having (mostly?) resolved my previous "slow requests" issue
> (http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/13076) at around
> 13:45, there were no problems until the mon lost osd.0 at 20:26 and lost osd.1
> 5 seconds later:
> 
> ceph-mon.b2.log:
> 2013-02-14 20:11:19.892060 7fa48d4f8700  0 log [INF] : pgmap v2822096: 576 pgs: 576 active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail
> 2013-02-14 20:11:21.719513 7fa48d4f8700  0 log [INF] : pgmap v2822097: 576 pgs: 576 active+clean; 407 GB data, 835 GB used, 2889 GB / 3724 GB avail
> 2013-02-14 20:26:20.656162 7fa48dcf9700 -1 mon.b2@0(leader).osd e768 no osd or pg stats from osd.0 since 2013-02-14 20:11:19.720812, 900.935345 seconds ago.  marking down

There is a safety check that if the osd doesn't check in for a long period 
of time we assume it is dead.  But it seems as though that shouldn't 
happen, since osd.0 has some PGs assigned and is scrubbing away.

Can you enable 'debug ms = 1' on the mons and leave them that way, in the 
hopes that this happens again?  It will give us more information to go on.

> ...although osd.1 started seeing problems around this time:
> 
> ceph-osd.1.log:
> 2013-02-14 20:03:11.413352 7fd1d8f0a700  0 log [INF] : 2.23 scrub ok
> 2013-02-14 20:26:51.601425 7fd1e6f26700  0 log [WRN] : 6 slow requests, 6 included below; oldest blocked for > 30.750063 secs
> 2013-02-14 20:26:51.601432 7fd1e6f26700  0 log [WRN] : slow request 30.750063 seconds old, received at 2013-02-14 20:26:20.851304: osd_op(client.9983.0:28173 xxx.rbd [watch 1~0] 2.10089424) v4 currently wait for new map
> 2013-02-14 20:26:51.601437 7fd1e6f26700  0 log [WRN] : slow request 30.749947 seconds old, received at 2013-02-14 20:26:20.851420: osd_op(client.10001.0:618473 yyyyyy.rbd [watch 1~0] 2.3854277a) v4 currently wait for new map
> 2013-02-14 20:26:51.601440 7fd1e6f26700  0 log [WRN] : slow request 30.749938 seconds old, received at 2013-02-14 20:26:20.851429: osd_op(client.9998.0:39716 zzzzzz.rbd [watch 1~0] 2.71731007) v4 currently wait for new map
> 2013-02-14 20:26:51.601442 7fd1e6f26700  0 log [WRN] : slow request 30.749907 seconds old, received at 2013-02-14 20:26:20.851460: osd_op(client.10007.0:59572 aaaaaa.rbd [watch 1~0] 2.320eebb8) v4 currently wait for new map
> 2013-02-14 20:26:51.601445 7fd1e6f26700  0 log [WRN] : slow request 30.749630 seconds old, received at 2013-02-14 20:26:20.851737: osd_op(client.9980.0:86883 bbbbbb.rbd [watch 1~0] 2.ab9b579f) v4 currently wait for new map
> 
> Perhaps the mon lost osd.1 because it was too slow, but that hadn't happened in
> any of the many previous "slow requests" intances, and the timing doesn't look
> quite right: the mon complains it hasn't heard from osd.0 since 20:11:19, but
> the osd.0 log shows nothing problems at all, then the mon complains about not
> having heard from osd.1 since 20:11:21, whereas the first indication of trouble
> on osd.1 was the request from 20:26:20 not being processed in a timely fashion.

My guess is the above was a side-effect of osd.0 being marked out.   On 
0.56.2 there is some strange peering workqueue laggyness that could 
potentially contribute as well.  I recommend moving to 0.56.3.

> No knowing enough about how the various pieces of ceph talk to each other
> makes it difficult to distinguish cause and effect!
> 
> Trying to manually set the osds in (e.g. ceph osd in 0) didn't help, nor did
> restarting the osds ('service ceph restart osd' on each osd host).
> 
> The immediate issue was resolved by restarting ceph completely on one of the
> mon/osd hosts (service ceph restart). Possibly a restart of just the mon would
> have been sufficient.

Did you notice that the osds you restarted didn't immediately mark 
themselves in?  Again, it could be explained by the peering wq issue, 
especially if there are pools in your cluster that are not getting any IO.

sage
