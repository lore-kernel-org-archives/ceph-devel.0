From: Sage Weil <sage@inktank.com>
Subject: Re: librados: failed to decode message of type 59 v1:
 buffer::end_of_buffer
Date: Mon, 24 Sep 2012 18:37:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209241836210.2213@cobra.newdream.net>
References: <5060CD3F.7060101@brightbox.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44103 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747Ab2IYBh6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Sep 2012 21:37:58 -0400
In-Reply-To: <5060CD3F.7060101@brightbox.co.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Leach <john@brightbox.co.uk>
Cc: ceph-devel@vger.kernel.org

Hi John,

It looks like we aren't encoding the old format for the pool_stat_t 
structure (which changed in v0.42).  Can you try with the patch from 
wip-3212 applied?  You can get debs from the gitbuilders, see

	http://ceph.com/docs/master/install/debian/

under development testing packages.

Thanks!
sage

http://tracker.newdream.net/issues/3212

On Mon, 24 Sep 2012, John Leach wrote:

> Hi,
> 
> I'm calling rados_ioctx_pool_stat and it's hanging.
> 
> logs show:
> 
> > 2012-09-24 21:30:08.411947 7f0041251700 failed to decode message of type 59 v1: buffer::end_of_buffer
> > 2012-09-24 21:30:08.412286 7f0043255700 monclient: hunting for new mon
> 
> my local client is the Ubuntu Precise provided librados2 package
> (0.41-1ubuntu2.1)
> 
> my cluster is running the unstable packages provided by Ceph
> (0.51-1precise).
> 
> If I upgrade my client just up to the stable 0.48.1argonaut-1precise
> package, it fixes the problem.
> 
> If the protocol changed, then I'd expect librados would let me know. Is
> there some way to check this? rados_version returns the version of the
> library, but I can't see how to get the version of the cluster (or quite
> how I'd compare them in a meaningful way).
> 
> Thanks,
> 
> John.
> --
> UK multi-zone cloud: http://brightbox.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
