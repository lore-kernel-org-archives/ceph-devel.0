From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/6] ceph: re-calculate truncate_size for strip object
Date: Sat, 5 Jan 2013 22:04:21 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301052204150.15430@cobra.newdream.net>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com> <1357299261-20591-2-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50591 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab3AFGEV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Jan 2013 01:04:21 -0500
In-Reply-To: <1357299261-20591-2-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Fri, 4 Jan 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> Otherwise osd may truncate the object to larger size.
> 
> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> ---
>  net/ceph/osd_client.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index eb9a444..267f183 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -76,8 +76,16 @@ int ceph_calc_raw_layout(struct ceph_osd_client *osdc,
>  		     orig_len - *plen, off, *plen);
>  
>  	if (op_has_extent(op->op)) {
> +		u32 osize = le32_to_cpu(layout->fl_object_size);
>  		op->extent.offset = objoff;
>  		op->extent.length = objlen;
> +		if (op->extent.truncate_size <= off - objoff) {
> +			op->extent.truncate_size = 0;
> +		} else {
> +			op->extent.truncate_size -= off - objoff;
> +			if (op->extent.truncate_size > osize)
> +				op->extent.truncate_size = osize;
> +		}
>  	}
>  	req->r_num_pages = calc_pages_for(off, *plen);
>  	req->r_page_alignment = off & ~PAGE_MASK;
> -- 
> 1.7.11.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
