From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH v2 2/3] rbd: complete notifies before cleaning up osd_client
 and rbd_dev
Date: Tue, 03 Sep 2013 07:45:16 -0500
Message-ID: <5225D9DC.9000006@linaro.org>
References: <1377824228-14632-1-git-send-email-josh.durgin@inktank.com> <1377824228-14632-2-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:37404 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932834Ab3ICMpK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Sep 2013 08:45:10 -0400
Received: by mail-ie0-f182.google.com with SMTP id aq17so10373876iec.27
        for <ceph-devel@vger.kernel.org>; Tue, 03 Sep 2013 05:45:10 -0700 (PDT)
In-Reply-To: <1377824228-14632-2-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 08/29/2013 07:57 PM, Josh Durgin wrote:
> To ensure rbd_dev is not used after it's released, flush all pending
> notify callbacks before calling rbd_dev_image_release(). No new
> notifies can be added to the queue at this point because the watch has
> already be unregistered with the osd_client.
> 
> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  drivers/block/rbd.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8ab3362b..2223617 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5190,6 +5190,13 @@ static ssize_t rbd_remove(struct bus_type *bus,
>  	ret = rbd_dev_header_watch_sync(rbd_dev, false);
>  	if (ret)
>  		rbd_warn(rbd_dev, "failed to cancel watch event (%d)\n", ret);
> +
> +	/*
> +	 * flush remaining watch callbacks - these must be complete
> +	 * before the osd_client is shutdown
> +	 */
> +	dout("%s: flushing notifies", __func__);
> +	ceph_osdc_flush_notifies(&rbd_dev->rbd_client->client->osdc);
>  	rbd_dev_image_release(rbd_dev);
>  	module_put(THIS_MODULE);
>  
> 

