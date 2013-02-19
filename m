From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: add parentheses to object request iterator macros
Date: Tue, 19 Feb 2013 11:15:24 -0800
Message-ID: <5123CF4C.7090305@inktank.com>
References: <51152572.1060602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:59858 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933914Ab3BSTPi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 14:15:38 -0500
Received: by mail-pa0-f54.google.com with SMTP id fa10so3508501pad.13
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 11:15:37 -0800 (PST)
In-Reply-To: <51152572.1060602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 02/08/2013 08:18 AM, Alex Elder wrote:
> The for_each_obj_request*() macros should parenthesize their uses of
> the ireq parameter.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 982963e..6e9e2c2 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -226,11 +226,11 @@ struct rbd_img_request {
>   };
>
>   #define for_each_obj_request(ireq, oreq) \
> -	list_for_each_entry(oreq, &ireq->obj_requests, links)
> +	list_for_each_entry(oreq, &(ireq)->obj_requests, links)
>   #define for_each_obj_request_from(ireq, oreq) \
> -	list_for_each_entry_from(oreq, &ireq->obj_requests, links)
> +	list_for_each_entry_from(oreq, &(ireq)->obj_requests, links)
>   #define for_each_obj_request_safe(ireq, oreq, n) \
> -	list_for_each_entry_safe_reverse(oreq, n, &ireq->obj_requests, links)
> +	list_for_each_entry_safe_reverse(oreq, n, &(ireq)->obj_requests, links)
>
>   struct rbd_snap {
>   	struct	device		dev;
>

