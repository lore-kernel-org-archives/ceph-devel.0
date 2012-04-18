From: Alex Elder <elder@dreamhost.com>
Subject: Re: [patch] rbd: use gfp_flags parameter in rbd_header_from_disk()
Date: Wed, 18 Apr 2012 09:17:25 -0500
Message-ID: <4F8ECCF5.5000501@dreamhost.com>
References: <20120322063309.GC7369@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48105 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab2DRORc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Apr 2012 10:17:32 -0400
In-Reply-To: <20120322063309.GC7369@elgon.mountain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Yehuda Sadeh <yehuda@hq.newdream.net>, Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

On 03/22/2012 01:33 AM, Dan Carpenter wrote:
> We should use the gfp_flags that the caller specified instead of
> GFP_KERNEL here.
>
> There is only one caller and it uses GFP_KERNEL, so this change is just
> a cleanup and doesn't change how the code works.
>
> Signed-off-by: Dan Carpenter<dan.carpenter@oracle.com>

This looks good.  Sorry it didn't get committed earlier.

Reviewed-by: Alex Elder <elder@dreamhost.com>

> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index a6278e7..fc9341f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -474,11 +474,11 @@ static int rbd_header_from_disk(struct rbd_image_header *header,
>   		return -ENOMEM;
>   	if (snap_count) {
>   		header->snap_names = kmalloc(header->snap_names_len,
> -					     GFP_KERNEL);
> +					     gfp_flags);
>   		if (!header->snap_names)
>   			goto err_snapc;
>   		header->snap_sizes = kmalloc(snap_count * sizeof(u64),
> -					     GFP_KERNEL);
> +					     gfp_flags);
>   		if (!header->snap_sizes)
>   			goto err_names;
>   	} else {
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

