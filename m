From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: fix type of snap_id in rbd_dev_v2_snap_info()
Date: Thu, 17 Jan 2013 09:41:36 -0800
Message-ID: <50F837D0.1020800@inktank.com>
References: <50F0D5B2.2090904@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:41211 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab3AQRlj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 12:41:39 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so1219066dak.28
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 09:41:39 -0800 (PST)
In-Reply-To: <50F0D5B2.2090904@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 01/11/2013 07:17 PM, Alex Elder wrote:
> The type of the snap_id local variable is defined with the
> wrong byte order.  Fix that.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---

Oops, I missed that too.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>   drivers/block/rbd.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 02002b1..47443eb 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2800,7 +2800,7 @@ out:
>   static char *rbd_dev_v2_snap_info(struct rbd_device *rbd_dev, u32 which,
>   		u64 *snap_size, u64 *snap_features)
>   {
> -	__le64 snap_id;
> +	u64 snap_id;
>   	u8 order;
>   	int ret;
>

