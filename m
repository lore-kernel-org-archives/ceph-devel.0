From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: use GFP_NOIO in rbd_obj_request_create()
Date: Tue, 30 Jun 2015 15:13:07 -0500
Message-ID: <5592F853.3000403@ieee.org>
References: <1435691942-41015-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37187 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbbF3UNI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Jun 2015 16:13:08 -0400
Received: by igblr2 with SMTP id lr2so20662939igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 13:13:07 -0700 (PDT)
In-Reply-To: <1435691942-41015-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 06/30/2015 02:19 PM, Ilya Dryomov wrote:
> rbd_obj_request_create() is called on the main I/O path, so we need to
> use GFP_NOIO to make sure allocation doesn't blow back on us.  Not all
> callers need this, but I'm still hardcoding the flag inside rather than
> making it a parameter because a) this is going to stable, and b) those
> callers shouldn't really use rbd_obj_request_create() and will be fixed
> in the future.
> 
> More memory allocation fixes will follow.

This looks OK to me.  It's conservative; you can add a GFP parameter
in the future.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Cc: stable@vger.kernel.org # 3.10+
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b316ee48a30b..d94529d5c8e9 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2022,11 +2022,11 @@ static struct rbd_obj_request *rbd_obj_request_create(const char *object_name,
>  	rbd_assert(obj_request_type_valid(type));
>  
>  	size = strlen(object_name) + 1;
> -	name = kmalloc(size, GFP_KERNEL);
> +	name = kmalloc(size, GFP_NOIO);
>  	if (!name)
>  		return NULL;
>  
> -	obj_request = kmem_cache_zalloc(rbd_obj_request_cache, GFP_KERNEL);
> +	obj_request = kmem_cache_zalloc(rbd_obj_request_cache, GFP_NOIO);
>  	if (!obj_request) {
>  		kfree(name);
>  		return NULL;
> 

