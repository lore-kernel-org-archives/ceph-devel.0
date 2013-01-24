From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/3] rbd: check for overflow in rbd_get_num_segments()
Date: Thu, 24 Jan 2013 15:03:29 -0800
Message-ID: <5101BDC1.9060907@inktank.com>
References: <50FF0B22.5060201@inktank.com> <50FF0B76.5040402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:52052 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114Ab3AXXDf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 18:03:35 -0500
Received: by mail-pa0-f52.google.com with SMTP id fb1so5775904pad.25
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jan 2013 15:03:35 -0800 (PST)
In-Reply-To: <50FF0B76.5040402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 01/22/2013 01:58 PM, Alex Elder wrote:
> The return type of rbd_get_num_segments() is int, but the values it
> operates on are u64.  Although it's not likely, there's no guarantee
> the result won't exceed what can be respresented in an int.  The
> function is already designed to return -ERANGE on error, so just add
> this possible overflow as another reason to return that.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4ed0741..58d01e3 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -820,6 +820,7 @@ static int rbd_get_num_segments(struct
> rbd_image_header *header,
>   {
>   	u64 start_seg;
>   	u64 end_seg;
> +	u64 result;
>
>   	if (!len)
>   		return 0;
> @@ -829,7 +830,11 @@ static int rbd_get_num_segments(struct
> rbd_image_header *header,
>   	start_seg = ofs >> header->obj_order;
>   	end_seg = (ofs + len - 1) >> header->obj_order;
>
> -	return end_seg - start_seg + 1;
> +	result = end_seg - start_seg + 1;
> +	if (result > (u64) INT_MAX)
> +		return -ERANGE;
> +
> +	return (int) result;
>   }
>
>   /*
>

