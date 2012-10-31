From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 2/6] rbd: allow null image name
Date: Wed, 31 Oct 2012 14:07:05 -0700
Message-ID: <509192F9.2070703@inktank.com>
References: <509081C4.3050402@inktank.com> <5090839A.9060401@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:36608 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760746Ab2JaVHR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 17:07:17 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so821618dak.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 14:07:16 -0700 (PDT)
In-Reply-To: <5090839A.9060401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/30/2012 06:49 PM, Alex Elder wrote:
> Format 2 parent images are partially identified by their image id,
> but it may not be possible to determine their image name.  The name
> is not strictly needed for correct operation, so we won't be
> treating it as an error if we don't know it.  Handle this case
> gracefully in rbd_name_show().
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index a852133..28052ff 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1982,7 +1982,10 @@ static ssize_t rbd_name_show(struct device *dev,
>   {
>   	struct rbd_device *rbd_dev = dev_to_rbd_dev(dev);
>
> -	return sprintf(buf, "%s\n", rbd_dev->spec->image_name);
> +	if (rbd_dev->spec->image_name)
> +		return sprintf(buf, "%s\n", rbd_dev->spec->image_name);
> +
> +	return sprintf(buf, "(unknown)\n");
>   }
>
>   static ssize_t rbd_image_id_show(struct device *dev,
>

