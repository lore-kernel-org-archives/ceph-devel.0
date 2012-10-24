From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: fix bug in rbd_dev_id_put()
Date: Wed, 24 Oct 2012 09:43:10 -0700
Message-ID: <50881A9E.8070407@inktank.com>
References: <5076E6FE.9070400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:49838 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757131Ab2JXQnN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 12:43:13 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so328247dak.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 09:43:13 -0700 (PDT)
In-Reply-To: <5076E6FE.9070400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/11/2012 08:34 AM, Alex Elder wrote:
> In rbd_dev_id_put(), there's a loop that's intended to determine
> the maximum device id in use.  But it isn't doing that at all,
> the effect of how it's written is to simply use the just-put id
> number, which ignores whole purpose of this function.
>
> Fix the bug.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index ca28036..cf5d109 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2642,8 +2642,8 @@ static void rbd_dev_id_put(struct rbd_device
> *rbd_dev)
>           struct rbd_device *rbd_dev;
>
>           rbd_dev = list_entry(tmp, struct rbd_device, node);
> -        if (rbd_id > max_id)
> -            max_id = rbd_id;
> +        if (rbd_dev->dev_id > max_id)
> +            max_id = rbd_dev->dev_id;
>       }
>       spin_unlock(&rbd_dev_list_lock);
>

