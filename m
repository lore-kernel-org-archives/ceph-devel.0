From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 5/6] rbd: get additional info in parent spec
Date: Wed, 31 Oct 2012 09:11:47 -0500
Message-ID: <509131A3.5090902@inktank.com>
References: <509081C4.3050402@inktank.com> <509083C4.409@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55746 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935517Ab2JaOLu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 31 Oct 2012 10:11:50 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2082137iea.19
        for <ceph-devel@vger.kernel.org>; Wed, 31 Oct 2012 07:11:49 -0700 (PDT)
In-Reply-To: <509083C4.409@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

On 10/30/2012 08:49 PM, Alex Elder wrote:
> When a layered rbd image has a parent, that parent is identified
> only by its pool id, image id, and snapshot id.  Images that have
> been mapped also record *names* for those three id's.
> 
> Add code to look up these names for parent images so they match
> mapped images more closely.  Skip doing this for an image if it
> already has its pool name defined (this will be the case for images
> mapped by the user).
> 
> It is possible that an the name of a parent image can't be
> determined, even if the image id is valid.  If this occurs it
> does not preclude correct operation, so don't treat this as
> an error.
> 
> On the other hand, defined pools will always have both an id and a
> name.   And any snapshot of an image identified as a parent for a
> clone image will exist, and will have a name (if not it indicates
> some other internal error).  So treat failure to get these bits
> of information as errors.
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  drivers/block/rbd.c |  131
> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 131 insertions(+)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index bce1fcf..04062c1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c

. . .

> @@ -2514,6 +2532,115 @@ out_err:
>  	return ret;
>  }
> 
> +static char *rbd_dev_image_name(struct rbd_device *rbd_dev)
> +{
> +	size_t image_id_size;
> +	char *image_id;
> +	void *p;
> +	void *end;
> +	size_t size;
> +	void *reply_buf = NULL;
> +	size_t len = 0;
> +	char *image_name = NULL;
> +	int ret;
> +
> +	rbd_assert(!rbd_dev->spec->image_name);
> +
> +	image_id_size = sizeof (__le32) + rbd_dev->spec->image_id_len;
> +	image_id = kmalloc(image_id_size, GFP_KERNEL);
> +	if (!image_id)
> +		return NULL;
> +
> +	p = image_id;
> +	end = (char *) image_id + image_id_size;
> +	ceph_encode_string(&p, end, rbd_dev->spec->image_id,
> +				(u32) rbd_dev->spec->image_id_len);
> +
> +	size = sizeof (__le32) + RBD_IMAGE_NAME_LEN_MAX;
> +	reply_buf = kmalloc(size, GFP_KERNEL);
> +	if (!reply_buf)
> +		goto out;
> +
> +	ret = rbd_req_sync_exec(rbd_dev, RBD_DIRECTORY,
> +				"rbd", "dir_get_name",
> +				image_id, image_id_size,
> +				(char *) reply_buf, size,
> +				CEPH_OSD_FLAG_READ, NULL);
> +	if (ret < 0)
> +		goto out;
> +	p = reply_buf;
> +	end = (char *) reply_buf + size;
> +	image_name = ceph_extract_encoded_string(&p, end, &len, GFP_KERNEL);

The next line will need to be changed to:

	if (IS_ERR(image_name))
		image_name = NULL;
	else

> +	if (image_name)
> +		dout("%s: name is %s len is %zd\n", __func__, image_name, len);
> +out:
> +	kfree(reply_buf);
> +	kfree(image_id);
> +
> +	return image_name;
> +}
> +

. . .

