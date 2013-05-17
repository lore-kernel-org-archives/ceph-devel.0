From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH, v2] rbd: fix cleanup in rbd_add()
Date: Thu, 16 May 2013 18:36:09 -0700
Message-ID: <51958989.3000003@inktank.com>
References: <519195B4.1080802@inktank.com> <51954FAD.2090206@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:38853 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab3EQBh0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 May 2013 21:37:26 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so2869841pdj.36
        for <ceph-devel@vger.kernel.org>; Thu, 16 May 2013 18:37:26 -0700 (PDT)
In-Reply-To: <51954FAD.2090206@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/16/2013 02:29 PM, Alex Elder wrote:
> Bjorn Helgaas pointed out that a recent commit introduced a
> use-after-free condition in an error path for rbd_add().
> He correctly stated:
>
>      I think b536f69a3a5 "rbd: set up devices only for mapped images"
>      introduced a use-after-free error in rbd_add():
> 	...
>      If rbd_dev_device_setup() returns an error, we call
>      rbd_dev_image_release(), which ultimately kfrees rbd_dev.
>      Then we call rbd_dev_destroy(), which references fields in
>      the already-freed rbd_dev struct before kfreeing it again.
>
> The simple fix is to return the error code after the call to
> rbd_dev_image_release().
>
> Closer examination revealed that there's no need to clean up
> rbd_opts in that function, so fix that too.
>
> Update some other comments that have also become out of date.
>
> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> v2: call to ceph_destroy_options() moved to its own patch
>
>   drivers/block/rbd.c |   17 +++++++++++------
>   1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index ade30dd..fdbcf04 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4700,8 +4700,10 @@ out:
>   	return ret;
>   }
>
> -/* Undo whatever state changes are made by v1 or v2 image probe */
> -
> +/*
> + * Undo whatever state changes are made by v1 or v2 header info
> + * call.
> + */
>   static void rbd_dev_unprobe(struct rbd_device *rbd_dev)
>   {
>   	struct rbd_image_header	*header;
> @@ -4905,9 +4907,10 @@ static int rbd_dev_image_probe(struct rbd_device
> *rbd_dev, bool mapping)
>   	int tmp;
>
>   	/*
> -	 * Get the id from the image id object.  If it's not a
> -	 * format 2 image, we'll get ENOENT back, and we'll assume
> -	 * it's a format 1 image.
> +	 * Get the id from the image id object.  Unless there's an
> +	 * error, rbd_dev->spec->image_id will be filled in with
> +	 * a dynamically-allocated string, and rbd_dev->image_format
> +	 * will be set to either 1 or 2.
>   	 */
>   	ret = rbd_dev_image_id(rbd_dev);
>   	if (ret)
> @@ -5033,12 +5036,14 @@ static ssize_t rbd_add(struct bus_type *bus,
>   		return count;
>
>   	rbd_dev_image_release(rbd_dev);

It looks like rbd_dev_image_release() does all the needed cleanup
except the module_put(). Just adding a module_put() here would do the
trick I think, since rbd_dev_image_release() is also used for parent
images that don't call module_get() and module_put().

With that change:

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

> +
> +	return rc;
> +
>   err_out_rbd_dev:
>   	rbd_dev_destroy(rbd_dev);
>   err_out_client:
>   	rbd_put_client(rbdc);
>   err_out_args:
> -	kfree(rbd_opts);
>   	rbd_spec_put(spec);
>   err_out_module:
>   	module_put(THIS_MODULE);

