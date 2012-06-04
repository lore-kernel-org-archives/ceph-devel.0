From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH] rbd: Fix ceph_snap_context size calculation
Date: Mon, 04 Jun 2012 15:08:12 -0500
Message-ID: <4FCD15AC.5080606@dreamhost.com>
References: <1338797469-23314-1-git-send-email-zheng.z.yan@intel.com>
Reply-To: elder@inktank.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35531 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab2FDUIJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jun 2012 16:08:09 -0400
In-Reply-To: <1338797469-23314-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On 06/04/2012 03:11 AM, Yan, Zheng wrote:
> From: "Yan, Zheng"<zheng.z.yan@intel.com>
>
> ceph_snap_context->snaps is an u64 array


You are correct.  We'll get this in soon.  Thanks.

Reviewed-by: Alex Elder <elder@inktank.com>

> Signed-off-by: Zheng Yan<zheng.z.yan@intel.com>
> ---
>   drivers/block/rbd.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 65665c9..8b9c173 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -499,7 +499,7 @@ static int rbd_header_from_disk(struct rbd_image_header *header,
>   			 / sizeof (*ondisk))
>   		return -EINVAL;
>   	header->snapc = kmalloc(sizeof(struct ceph_snap_context) +
> -				snap_count * sizeof (*ondisk),
> +				snap_count * sizeof(u64),
>   				gfp_flags);
>   	if (!header->snapc)
>   		return -ENOMEM;

