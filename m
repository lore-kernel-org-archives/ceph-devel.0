From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RESEND][PATCH] fs: remove dentry_lru_prune()
Date: Mon, 22 Apr 2013 17:56:23 +1000
Message-ID: <20130422075623.GI13938@destitution>
References: <1366006401-3933-1-git-send-email-zheng.z.yan@intel.com>
 <alpine.DEB.2.00.1304160755100.23181@cobra.newdream.net>
 <alpine.DEB.2.00.1304191343110.13036@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:5778 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754714Ab3DVHzt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Apr 2013 03:55:49 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1304191343110.13036@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: viro@zeniv.linux.org.uk, "Yan, Zheng" <zheng.z.yan@intel.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, greg@inktank.com

On Sun, Apr 21, 2013 at 01:34:02PM -0700, Sage Weil wrote:
> Al-
> 
> As I mentioned LSF, since there are no other users except for ceph, it's 
> probably easiest if this goes through my tree.  Unless you expect 
> conflicts with other vfs bits or want this to go through the vfs tree... 
> Either way!

Sage, it'll probably conflict with the generic LRU rework, so there
might be some co-ordination needed there...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
