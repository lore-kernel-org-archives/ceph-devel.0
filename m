From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH 2/2] rbd: use the correct length for format 2 object names
Date: Sat, 15 Jun 2013 12:05:20 -0500
Message-ID: <51BC9ED0.3000503@linaro.org>
References: <1371093046-5814-1-git-send-email-josh.durgin@inktank.com> <1371093046-5814-2-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:44466 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753741Ab3FORFR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Jun 2013 13:05:17 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so3924429iet.9
        for <ceph-devel@vger.kernel.org>; Sat, 15 Jun 2013 10:05:17 -0700 (PDT)
In-Reply-To: <1371093046-5814-2-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 06/12/2013 10:10 PM, Josh Durgin wrote:
> Format 2 objects use 16 characters for the object name suffix to be
> able to express the full 64-bit range of object numbers. Format 1
> images only use 12 characters for this. Using 12-character names for
> format 2 caused userspace and kernel rbd clients to read differently
> named objects, which made an image written by one client look empty to
> the other client.
> 
> Reported-by: Chris Dunlop <chris@onthe.net.au>
> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

>  drivers/block/rbd.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 9f72125..39ee017 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1028,12 +1028,16 @@ static const char *rbd_segment_name(struct rbd_device *rbd_dev, u64 offset)
>  	char *name;
>  	u64 segment;
>  	int ret;
> +	char *name_format;
>  
>  	name = kmem_cache_alloc(rbd_segment_name_cache, GFP_NOIO);
>  	if (!name)
>  		return NULL;
>  	segment = offset >> rbd_dev->header.obj_order;
> -	ret = snprintf(name, MAX_OBJ_NAME_SIZE + 1, "%s.%012llx",
> +	name_format = "%s.%012llx";
> +	if (rbd_dev->image_format == 2)
> +		name_format = "%s.%016llx";
> +	ret = snprintf(name, MAX_OBJ_NAME_SIZE + 1, name_format,
>  			rbd_dev->header.object_prefix, segment);
>  	if (ret < 0 || ret > MAX_OBJ_NAME_SIZE) {
>  		pr_err("error formatting segment name for #%llu (%d)\n",
> 

