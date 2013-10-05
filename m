From: Dave Chinner <david@fromorbit.com>
Subject: Re: RESEND: xattr issue with 3.11 kernel
Date: Sat, 5 Oct 2013 13:21:12 +1000
Message-ID: <20131005032112.GM4446@dastard>
References: <ED5C1C84-614E-4EBB-A966-BBCD9CE89373@inktank.com>
 <20131004210411.GJ4446@dastard>
 <6ECC8063-935A-4DD6-A460-4B7D8AE24271@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:8237 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751307Ab3JEDWE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Oct 2013 23:22:04 -0400
Content-Disposition: inline
In-Reply-To: <6ECC8063-935A-4DD6-A460-4B7D8AE24271@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: xfs@oss.sgi.com, ceph-devel@vger.kernel.org

On Fri, Oct 04, 2013 at 03:16:05PM -0700, David Zafman wrote:
> 
> Dave,
> 
> The 3.12-rc3 kernel passed my test.  Thanks for the quick response.

Good to hear.

....

> > You are probably hitting the problem fixed in commit 997def2 ("xfs:
> > fix node forward in xfs_node_toosmall") which went into 3.12-rc3.
> > Can you test that this fixes your problem, ad if so, we'll need to
> > push it back to -stable kernels..

Ben, can you push this fix back to the -stable kernels
that require it?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
