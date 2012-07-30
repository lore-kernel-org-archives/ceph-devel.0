From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: kill rbd_init_watch_dev()
Date: Mon, 30 Jul 2012 14:46:25 -0700
Message-ID: <501700B1.8030002@inktank.com>
References: <50119656.9080709@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61542 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab2G3Vq2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 17:46:28 -0400
Received: by yhmm54 with SMTP id m54so5400173yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 14:46:27 -0700 (PDT)
In-Reply-To: <50119656.9080709@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/26/2012 12:11 PM, Alex Elder wrote:
> When an rbd image is mapped, a watch request is issued so that the
> client will get notified in the event the image header object
> changes.  This is done using rbd_init_watch_dev(), which calls
> rbd_req_sync_watch().
>
> rbd_init_watch_dev() is organized as a loop, arranging to re-issue
> the request after refreshing the header if -ERANGE ever gets
> returned.  But the only way rbd_req_sync_watch() will return -ERANGE
> is if the CEPH_OSD_OP_WATCH operation returns that, which it will
> not.
>
> As a result, the whole looping structure and in fact the whole
> function becomes excessive.  So get rid of rbd_init_watch_dev(),
> and call rbd_req_sync_watch() directly in the one place it's used.

Instead of getting rid of this loop, we should make it
send a compound operation consisting of (CEPH_OSD_OP_ASSERT_VER,
CEPH_OSD_OP_WATCH). Then we will get -ERANGE if our version
of the header is out of data, so we don't lose header updates
before the watch is established.

Josh

> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   18 +-----------------
>   1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 94d0745..71e3f3b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2191,22 +2191,6 @@ static void rbd_bus_del_dev(struct rbd_device
> *rbd_dev)
>   	device_unregister(&rbd_dev->dev);
>   }
>
> -static int rbd_init_watch_dev(struct rbd_device *rbd_dev)
> -{
> -	int ret, rc;
> -
> -	do {
> -		ret = rbd_req_sync_watch(rbd_dev);
> -		if (ret == -ERANGE) {
> -			rc = rbd_refresh_header(rbd_dev, NULL);
> -			if (rc < 0)
> -				return rc;
> -		}
> -	} while (ret == -ERANGE);
> -
> -	return ret;
> -}
> -
>   static atomic64_t rbd_id_max = ATOMIC64_INIT(0);
>
>   /*
> @@ -2510,7 +2494,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>   	if (rc)
>   		goto err_out_bus;
>
> -	rc = rbd_init_watch_dev(rbd_dev);
> +	rc = rbd_req_sync_watch(rbd_dev);
>   	if (rc)
>   		goto err_out_bus;
>

