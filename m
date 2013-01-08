From: Sage Weil <sage@inktank.com>
Subject: Re: librados/librbd compatibility issue with v0.56
Date: Mon, 7 Jan 2013 21:33:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301072132050.29855@cobra.newdream.net>
References: <alpine.DEB.2.00.1301042056030.15430@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46002 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740Ab3AHFdx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 00:33:53 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4B0018044E
	for <ceph-devel@vger.kernel.org>; Mon,  7 Jan 2013 21:33:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 24BE98044E
	for <ceph-devel@vger.kernel.org>; Mon,  7 Jan 2013 21:33:53 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301042056030.15430@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Quick update/reminder:

If you are running v0.56, please upgrade to v0.56.1.  Make sure you 
upgrade both the daemons and the client-side libraries.  v0.56 is protocol 
incompatible with both older and newer versions and should be avoided.

Also, we fixed a potentially data-loss causing bug in v0.56.1 (triggered 
by power loss or kernel panic).  The same fix is going into argonaut as 
well; v0.48.3 should be out tomorrow.

Thanks!
sage


On Fri, 4 Jan 2013, Sage Weil wrote:

> We identified a problem with the version of librbd/librados in v0.56.  
> There will be a v0.56.1 update in a few days that fixes it.  In the 
> meantime, be aware that v0.56 ceph-osds may not interact properly with 
> non-v0.56 radosgw or librbd clients, and v0.56 radosgw and librbd clients 
> will not interact properly with non-v0.56 OSDs.
> 
> If you are using v0.56, we recommend moving to the current testing branch, 
> which includes fixes queued up for v0.56.1.  You can get debs from e.g.
> 
>   http://gitbuilder.ceph.com/ceph-deb-precise-x86_64-basic/ref/testing/
> 
> or for other many other distros; see 
> 
>   http://ceph.com/docs/master/install/debian/#add-development-testing-packages
> 
> The fix is commit d3abd0fe0bb402ff403259d4b1a718a56331fc39 
> (921e06decebccc913c0e4f61916d00e62e7e1635 in testing branch).
> 
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
