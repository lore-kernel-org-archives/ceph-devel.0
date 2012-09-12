From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] osd/ReplicatedPG: set truncate_seq when handling
 CEPH_OSD_OP_APPEND
Date: Wed, 12 Sep 2012 14:12:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209121411530.19850@cobra.newdream.net>
References: <1347333326-6392-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51137 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753141Ab2ILVMs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Sep 2012 17:12:48 -0400
In-Reply-To: <1347333326-6392-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On Tue, 11 Sep 2012, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> We need set truncate_seq when redirect the newop to CEPH_OSD_OP_WRITE,
> otherwise the code handles CEPH_OSD_OP_WRITE may quietly drop the data.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>

Applying.

This is correct, but I don't think there are any APPEND users currently in 
the tree.  Did you run across this via inspection, or were you using this 
code in some other way?

Thanks!
sage


> ---
>  src/osd/ReplicatedPG.cc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
> index f353090..fcd8be7 100644
> --- a/src/osd/ReplicatedPG.cc
> +++ b/src/osd/ReplicatedPG.cc
> @@ -2310,6 +2310,7 @@ int ReplicatedPG::do_osd_ops(OpContext *ctx, vector<OSDOp>& ops)
>  	newop.op.op = CEPH_OSD_OP_WRITE;
>  	newop.op.extent.offset = oi.size;
>  	newop.op.extent.length = op.extent.length;
> +	newop.op.extent.truncate_seq = oi.truncate_seq;
>          newop.indata = osd_op.indata;
>  	do_osd_ops(ctx, nops);
>  	osd_op.outdata.claim(newop.outdata);
> -- 
> 1.7.11.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
