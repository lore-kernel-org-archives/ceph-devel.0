From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/4] rbd: allocate name separate from obj_request
Date: Thu, 02 May 2013 09:20:19 -0700
Message-ID: <51829243.3050701@inktank.com>
References: <51818A5C.1080903@inktank.com> <51818AB2.1060909@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:37565 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757568Ab3EBQTx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 May 2013 12:19:53 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa7so430015pbc.39
        for <ceph-devel@vger.kernel.org>; Thu, 02 May 2013 09:19:53 -0700 (PDT)
In-Reply-To: <51818AB2.1060909@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 05/01/2013 02:35 PM, Alex Elder wrote:
> The next patch will define a slab allocator for a object requests.
> To use that we'll need to allocate the name of an object separate
> from the request structure itself.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 005c397..da9f41d 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1758,11 +1758,16 @@ static struct rbd_obj_request
> *rbd_obj_request_create(const char *object_name,
>   	rbd_assert(obj_request_type_valid(type));
>
>   	size = strlen(object_name) + 1;
> -	obj_request = kzalloc(sizeof (*obj_request) + size, GFP_KERNEL);
> -	if (!obj_request)
> +	name = kmalloc(size, GFP_KERNEL);
> +	if (!name)
> +		return NULL;
> +
> +	obj_request = kzalloc(sizeof (*obj_request), GFP_KERNEL);
> +	if (!obj_request) {
> +		kfree(name);
>   		return NULL;
> +	}
>
> -	name = (char *)(obj_request + 1);
>   	obj_request->object_name = memcpy(name, object_name, size);
>   	obj_request->offset = offset;
>   	obj_request->length = length;
> @@ -1808,6 +1813,7 @@ static void rbd_obj_request_destroy(struct kref *kref)
>   		break;
>   	}
>
> +	kfree(obj_request->object_name);
>   	kfree(obj_request);
>   }
>

