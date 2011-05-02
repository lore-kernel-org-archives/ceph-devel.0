From: Sage Weil <sage@newdream.net>
Subject: Re: rbd export from corrupted cluster
Date: Mon, 2 May 2011 14:49:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105021445460.14270@cobra.newdream.net>
References: <BANLkTi=nkcY5FYi2DGPP-aE3S8z457C8Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54794 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756698Ab1EBVs6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 May 2011 17:48:58 -0400
In-Reply-To: <BANLkTi=nkcY5FYi2DGPP-aE3S8z457C8Pw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Mon, 2 May 2011, Christian Brunner wrote:
> Hi,
> 
> after a series of hardware defects, I have a corrupted ceph cluster:
> 
> 2011-05-02 18:12:31.038446    pg v8171648: 3712 pgs: 26 active, 3663
> active+clean, 5 crashed+peering, 18 active+clean+inconsistent; 547 GB
> data, 388 GB used, 51922 GB / 78245 GB avail; 2410/284300 degraded
> (0.848%)
> 
> Now I wanted to export an rbd-image with "rbd export" and run a
> filesystem-check on the image. The only problem is, that the export is
> blocking on the first corrupted object. I think it would be better to
> detect the failure and return some blocks filled with zero.
> 
> Is there a way to accomplish this?

Not currently.  There are a couple ways to approach it.

One would be to a timeout (either in librados or in the rados tool) so 
that it can move past unresponsive blocks (or error out).  Maybe a 'skip 
this block range' option would be a piece of that.

The other is to give the client explicit feedback when the pg it is 
attempting to access is not available (in your case, it's the peering pgs 
that are blocking progress).  Currently those requests block at the OSD 
until peering completes, but a peering bug is preventing progress.

Of course, we also need to fix the peering issue itself (any logs you can 
provide showing it blocking would help).  If you ceph pg dump and look at 
which ones are in peering, and restart those osds with full logs, we can 
see where things are getting hung up. 

Probably, though, we still want a way to do useful work 
(partial/incomplete export) even when things are half-broken.

sage
