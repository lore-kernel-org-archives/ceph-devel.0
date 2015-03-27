From: Sage Weil <sage@newdream.net>
Subject: Re: RBD Discard issue for Cache_tier
Date: Fri, 27 Mar 2015 06:50:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503270643520.18934@cobra.newdream.net>
References: <CALZt5jwGf2BADGSRYJY-9MB5pWHSKFOpWdjXZAZroWbwAuO+Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39968 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753064AbbC0Nuj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Mar 2015 09:50:39 -0400
In-Reply-To: <CALZt5jwGf2BADGSRYJY-9MB5pWHSKFOpWdjXZAZroWbwAuO+Fg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 27 Mar 2015, Ning Yao wrote:
> Hi all,
> 
> I use the kernel rbd with kernel 3.18 and open the discard option.
> When I use the cache tier mode, the performance is ruined by
> CEPH_OSD_OP_DELETE.
> 
> Since some one may delete a large file which is rarely used, the file
> is always not in the Cache pool. So it will promote the object first
> from the cold pool and then replace the object with an empty object.
> After the empty object is flushed and evicted, the content is
> eventually deleted.
> 
> But a large file causes lots of object promotion so that the Cache
> pool's bandwidth is saturated. We might not need to promote a delete
> the object when Calling can_skip_promote() and send a
> CEPH_OSD_OP_DELETE op to cold pool from the Objecter interface, which
> would be much better when deleting file occurs. Is that possible?

Yes.  The trick right now is that the DELETE op is defined to return 
ENOENT if the object doesn't exist, and the code isn't smart enough to 
skip the promotion.  I think there are two options:

1) Special case deletion code in the promotion code that skips most 
of the work.  Unfortunately I think this will be fragile and annoying 
to maintain.

2) Set a flag on the client op indicating that it can ignore the delete 
'failure' and skip promotion. There is already a hook for this 
(can_skip_promote) in ReplicatedPG, although it's not quite right: the 
'FAILOK' flag means that we should proceed with the operation, but the 
per-op return code is still supposed to be -EINVAL to the client and we 
don't do that.  I think we actually want an 'idempotent' flag/arg for 
delete itself.  There's plenty of room in the ceph_osd_op args to add this 
and it should be easy to do in a backwards compatible way..

sage

