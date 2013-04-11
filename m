From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: do a safe list traversal in rbd_img_request_submit()
Date: Thu, 11 Apr 2013 13:03:33 -0700
Message-ID: <51671715.2060505@inktank.com>
References: <5165EC73.5000600@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:46153 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab3DKUEE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 16:04:04 -0400
Received: by mail-pa0-f54.google.com with SMTP id fa11so1078848pad.13
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 13:04:03 -0700 (PDT)
In-Reply-To: <5165EC73.5000600@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/10/2013 03:49 PM, Alex Elder wrote:
> It's possible that the reference to the object request dropped
> inside the loop in rbd_img_request_submit() will be the last
> one, in which case the content of the object pointer can't be
> trusted.
>
> Use a safe form of the object request list traversal to avoid
> problems.
>
> This resolves:
>      http://tracker.ceph.com/issues/4705
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 3c0abe6..7eb1032 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1652,9 +1652,10 @@ static int rbd_img_request_submit(struct
> rbd_img_request *img_request)
>   	struct rbd_device *rbd_dev = img_request->rbd_dev;
>   	struct ceph_osd_client *osdc = &rbd_dev->rbd_client->client->osdc;
>   	struct rbd_obj_request *obj_request;
> +	struct rbd_obj_request *next_obj_request;
>
>   	dout("%s: img %p\n", __func__, img_request);
> -	for_each_obj_request(img_request, obj_request) {
> +	for_each_obj_request_safe(img_request, obj_request, next_obj_request) {
>   		int ret;
>
>   		ret = rbd_obj_request_submit(osdc, obj_request);
>

