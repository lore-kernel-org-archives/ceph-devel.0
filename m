From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: RBD Discard issue for Cache_tier
Date: Mon, 30 Mar 2015 07:05:42 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C53489C45EC@SHSMSX101.ccr.corp.intel.com>
References: <CALZt5jwGf2BADGSRYJY-9MB5pWHSKFOpWdjXZAZroWbwAuO+Fg@mail.gmail.com>
 <alpine.DEB.2.00.1503270643520.18934@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45698 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753015AbbC3HIh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Mar 2015 03:08:37 -0400
In-Reply-To: <alpine.DEB.2.00.1503270643520.18934@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

How about handling the DELETE op in the cache tier like this:
1) If the object is in the cache tier, we delete it in cache tier, replace it with a whiteout, and later flush and evict it.
2) If the object is not in the cache tier, we always proxy the delete op. This can be done after the proxy write code is merged into master.

BTW, for the skipping promotion, I proposed a PR to add a 'SKIP_PROMOTE' flag in the OpRequest, like we did for the 'FORCE_PROMOTE'. This can avoid the extra checks when handling the op. The PR is at https://github.com/ceph/ceph/pull/3975

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Friday, March 27, 2015 9:51 PM
To: Ning Yao
Cc: ceph-devel
Subject: Re: RBD Discard issue for Cache_tier

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

Yes.  The trick right now is that the DELETE op is defined to return ENOENT if the object doesn't exist, and the code isn't smart enough to skip the promotion.  I think there are two options:

1) Special case deletion code in the promotion code that skips most of the work.  Unfortunately I think this will be fragile and annoying to maintain.

2) Set a flag on the client op indicating that it can ignore the delete 'failure' and skip promotion. There is already a hook for this
(can_skip_promote) in ReplicatedPG, although it's not quite right: the 'FAILOK' flag means that we should proceed with the operation, but the per-op return code is still supposed to be -EINVAL to the client and we don't do that.  I think we actually want an 'idempotent' flag/arg for delete itself.  There's plenty of room in the ceph_osd_op args to add this and it should be easy to do in a backwards compatible way..

sage

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
