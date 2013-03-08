From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/2] fs: fix dentry_lru_prune()
Date: Fri, 8 Mar 2013 13:04:45 +1100
Message-ID: <20130308020445.GB23616@dastard>
References: <1362656256-4397-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:42862 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760163Ab3CHCFp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 21:05:45 -0500
Content-Disposition: inline
In-Reply-To: <1362656256-4397-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, sage@inktank.com, viro@zeniv.linux.org.uk

On Thu, Mar 07, 2013 at 07:37:36PM +0800, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> dentry_lru_prune() should always call file system's d_prune callback.

Why? What bug does this fix?

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
