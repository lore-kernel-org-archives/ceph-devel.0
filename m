From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 3/7] rbd: pass null version pointer in add_snap()
Date: Mon, 30 Jul 2012 13:48:38 -0700
Message-ID: <5016F326.8050107@inktank.com>
References: <50119421.1090702@inktank.com> <501195BB.8030401@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:55603 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754897Ab2G3Usk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 16:48:40 -0400
Received: by yhmm54 with SMTP id m54so5335790yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 13:48:40 -0700 (PDT)
In-Reply-To: <501195BB.8030401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/26/2012 12:08 PM, Alex Elder wrote:
> rbd_header_add_snap() passes the address of a version variable to
> rbd_req_sync_exec(), but it ignores the result.  Just pass a null
> pointer instead.
>
> Signed-off-by: Alex Elder <elder@inktank.com>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> ---
>   drivers/block/rbd.c |    3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4d8b52c..eacf255 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1664,7 +1664,6 @@ static int rbd_header_add_snap(struct rbd_device
> *rbd_dev,
>   	u64 new_snapid;
>   	int ret;
>   	void *data, *p, *e;
> -	u64 ver;
>   	struct ceph_mon_client *monc;
>
>   	/* we should create a snapshot only if we're pointing at the head */
> @@ -1689,7 +1688,7 @@ static int rbd_header_add_snap(struct rbd_device
> *rbd_dev,
>
>   	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
>   				"rbd", "snap_add",
> -				data, p - data, &ver);
> +				data, p - data, NULL);
>
>   	kfree(data);
>

