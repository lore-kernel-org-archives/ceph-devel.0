From: Sage Weil <sage@newdream.net>
Subject: Re: wip-librbd-caching
Date: Thu, 12 Apr 2012 12:45:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204121240310.21220@cobra.newdream.net>
References: <4F872D48.6070801@tuxadero.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44689 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020Ab2DLTqB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Apr 2012 15:46:01 -0400
In-Reply-To: <4F872D48.6070801@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org, Josh Durgin <josh.durgin@dreamhost.com>

On Thu, 12 Apr 2012, Martin Mailand wrote:
> Hi,
> 
> today I tried the wip-librbd-caching branch. The performance improvement is
> very good particular for small writes.
> I tested from within a vm with fio:
> 
> rbd_cache_enabled=1
> 
> fio -name iops -rw=write -size=10G -iodepth 1 -filename /tmp/bigfile -ioengine
> libaio -direct 1 -bs 4k
> 
> I get over 10k iops
> 
> With an iodepth 4 I get over 30k iops
> 
> In comparison with the rbd_writebackwindow I get around 5k iops with an
> iodepth of 1.
> 
> So far the whole cluster is running stable for over 12 hours.

Great to hear!
 
> But there is also a downside.
> My typical vm are 1Gb in size, the default cache size is 200Mb, which is 20%
> more memory usage. Maybe 50Mb or less will be enough?
> I am going to test that.

The config options you'll want to look at are client_oc_* (in case you 
didn't see that already :).  "oc" is short for objectcacher, and it isn't 
only used for client (libcephfs), so it might be worth renaming these 
options before people start using them.

> The other point is, that the cache is not KSM enabled, therefore identical
> pages will not be merged, could that be changed, what would be the downside?
> 
> So maybe we could reduce the memory footprint of the cache, but keep it's
> performance.

I'm not familiar with the performance implications of KSM, but the 
objectcacher doesn't modify existing buffers in place, so I suspect it's a 
good candidate.  And it looks like there's minimal effort in enabling 
it...

sage
