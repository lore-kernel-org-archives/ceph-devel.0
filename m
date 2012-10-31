From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/6] rbd: skip getting image id if known
Date: Wed, 31 Oct 2012 14:05:40 -0700
Message-ID: <509192A4.5080702@inktank.com>
References: <509081C4.3050402@inktank.com> <50908390.5020607@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60546 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760679Ab2JaVFx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 17:05:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so1250628pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 14:05:52 -0700 (PDT)
In-Reply-To: <50908390.5020607@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/30/2012 06:49 PM, Alex Elder wrote:
> We will know the image id for format 2 parent images, but won't
> initially know its image name.  Avoid making the query for an image
> id in rbd_dev_image_id() if it's already known.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8d26c0f..a852133 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3068,6 +3068,14 @@ static int rbd_dev_image_id(struct rbd_device
> *rbd_dev)
>   	void *p;
>
>   	/*
> +	 * When probing a parent image, the image id is already
> +	 * known (and the image name likely is not).  There's no
> +	 * need to fetch the image id again in this case.
> +	 */
> +	if (rbd_dev->spec->image_id)
> +		return 0;
> +
> +	/*
>   	 * First, see if the format 2 image id file exists, and if
>   	 * so, get the image's persistent id from it.
>   	 */
>

