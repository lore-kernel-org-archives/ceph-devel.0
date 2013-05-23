From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 18/30] mds: don't issue Fc cap from replica
Date: Thu, 23 May 2013 11:11:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305231108230.32642@cobra.newdream.net>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <1369296418-14871-19-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42229 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757048Ab3EWSLO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 May 2013 14:11:14 -0400
In-Reply-To: <1369296418-14871-19-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, sam.lang@inktank.com

On Thu, 23 May 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> For replica, filelock in LOCK_LOCK state doesn't allow Fc cap. So
> filelock in LOCK_SYNC_LOCK/LOCK_EXCL_LOCK state shouldn't allow Fc
> cap either.
> 
> Replica can issue Fc cap only when filelock is in LOCK_SYNC state.
> Every time filelock changes to other state, replica need revoke Fc
> cap. This is slow, so I think it's better to not issue Fc cap from
> replica.

Can you separate out that behavior change from the bug fix?

I think it'll be a good idea for some workloads, but not others (and 
possibly not most).  Most files don't change, and being able to read them 
via caps from a replica is important for making very hot shared 
directories perform well.

If we do make the change, I think it should be controlled by a tunable.  
Ideally, though, the MDS would infer some idea of whether this is a hot 
file or not and decide that way.  Like if the file was recently changed, 
don't allow Fc, but if it is old, do?

sage

> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  src/mds/locks.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/mds/locks.c b/src/mds/locks.c
> index c7dd5be..542595a 100644
> --- a/src/mds/locks.c
> +++ b/src/mds/locks.c
> @@ -88,7 +88,7 @@ const struct sm_t sm_scatterlock = {
>  
>  const struct sm_state_t filelock[LOCK_MAX] = {
>                        // stable     loner  rep state  r     rp   rd   wr   fwr  l    x    caps(any,loner,xlocker,replica)
> -    [LOCK_SYNC]      = { 0,         false, LOCK_SYNC, ANY,  0,   ANY, 0,   0,   ANY, 0,   CEPH_CAP_GSHARED|CEPH_CAP_GCACHE|CEPH_CAP_GRD,0,0,CEPH_CAP_GSHARED|CEPH_CAP_GCACHE|CEPH_CAP_GRD },
> +    [LOCK_SYNC]      = { 0,         false, LOCK_SYNC, ANY,  0,   ANY, 0,   0,   ANY, 0,   CEPH_CAP_GSHARED|CEPH_CAP_GCACHE|CEPH_CAP_GRD,0,0,CEPH_CAP_GSHARED|CEPH_CAP_GRD },
>      [LOCK_LOCK_SYNC] = { LOCK_SYNC, false, LOCK_LOCK, AUTH, 0,   0,   0,   0,   0,   0,   CEPH_CAP_GCACHE,0,0,0 },
>      [LOCK_EXCL_SYNC] = { LOCK_SYNC, true,  LOCK_LOCK, 0,    0,   0,   0,   XCL, 0,   0,   0,CEPH_CAP_GSHARED|CEPH_CAP_GCACHE|CEPH_CAP_GRD,0,0 },
>      [LOCK_MIX_SYNC]  = { LOCK_SYNC, false, LOCK_MIX_SYNC2,0,0,   0,   0,   0,   0,   0,   CEPH_CAP_GRD|CEPH_CAP_GLAZYIO,0,0,CEPH_CAP_GRD },
> @@ -97,8 +97,8 @@ const struct sm_state_t filelock[LOCK_MAX] = {
>      [LOCK_XSYN_SYNC] = { LOCK_SYNC, true,  LOCK_LOCK, AUTH, 0,   AUTH,0,   0,   0,   0,   0,CEPH_CAP_GCACHE,0,0 },
>    
>      [LOCK_LOCK]      = { 0,         false, LOCK_LOCK, AUTH, 0,   REQ, AUTH,0,   0,   0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,0 },
> -    [LOCK_SYNC_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   CEPH_CAP_GCACHE,0,0,CEPH_CAP_GCACHE },
> -    [LOCK_EXCL_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   XCL, 0,   0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,CEPH_CAP_GCACHE },
> +    [LOCK_SYNC_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   CEPH_CAP_GCACHE,0,0,0 },
> +    [LOCK_EXCL_LOCK] = { LOCK_LOCK, false, LOCK_LOCK, 0,    0,   0,   0,   XCL, 0,   0,   CEPH_CAP_GCACHE|CEPH_CAP_GBUFFER,0,0,0 },
>      [LOCK_MIX_LOCK]  = { LOCK_LOCK, false, LOCK_MIX,  AUTH, 0,   REQ, 0,   0,   0,   0,   0,0,0,0 },
>      [LOCK_MIX_LOCK2] = { LOCK_LOCK, false, LOCK_LOCK, AUTH, 0,   REQ, 0,   0,   0,   0,   0,0,0,0 },
>  
> -- 
> 1.8.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
