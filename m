From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/2] rbd: clear EXISTS flag if mapped snapshot disappears
Date: Thu, 02 May 2013 09:41:55 -0700
Message-ID: <51829753.9070808@inktank.com>
References: <51818945.1040002@inktank.com> <518189F9.3070603@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:44719 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759615Ab3EBQlg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 May 2013 12:41:36 -0400
Received: by mail-da0-f43.google.com with SMTP id u7so393687dae.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 May 2013 09:41:35 -0700 (PDT)
In-Reply-To: <518189F9.3070603@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 05/01/2013 02:32 PM, Alex Elder wrote:
> This functionality inadvertently disappeared in the last patch.
>
> Image snapshots can get removed at just about any time.  In
> particular it can disappear even if it is in use by an rbd
> client as a mapped image.
>
> The rbd client deals with such a disappearance by responding to new
> requests with ENXIO.  This is implemented by each rbd device
> maintaining an EXISTS flag, which is normally set but cleared if a
> snapshot disappears.
>
> This patch (re-)implements the clearing of that flag.
>
> Whenever mapped image header information is refreshed, if the
> mapping is for a snapshot, verify the mapped snapshot is still
> present in the updated snapshot context.  If it is not, clear the
> flag.
>
> It is not necessary to check this in the initial probe, because the
> probe will not succeed if the snapshot doesn't exist.
>
> This resolves:
>      http://tracker.ceph.com/issues/4880
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 0ca959f..3f58aba 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3114,6 +3114,25 @@ static int rbd_dev_v1_refresh(struct rbd_device
> *rbd_dev)
>   	return ret;
>   }
>
> +/*
> + * Clear the rbd device's EXISTS flag if the snapshot it's mapped to
> + * has disappeared from the (just updated) snapshot context.
> + */
> +static void rbd_exists_validate(struct rbd_device *rbd_dev)
> +{
> +	u64 snap_id;
> +
> +	if (!test_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags))
> +		return;
> +
> +	snap_id = rbd_dev->spec->snap_id;
> +	if (snap_id == CEPH_NOSNAP)
> +		return;
> +
> +	if (rbd_dev_snap_index(rbd_dev, snap_id) == BAD_SNAP_INDEX)
> +		clear_bit(RBD_DEV_FLAG_EXISTS, &rbd_dev->flags);
> +}
> +
>   static int rbd_dev_refresh(struct rbd_device *rbd_dev)
>   {
>   	u64 image_size;
> @@ -3126,6 +3145,10 @@ static int rbd_dev_refresh(struct rbd_device
> *rbd_dev)
>   		ret = rbd_dev_v1_refresh(rbd_dev);
>   	else
>   		ret = rbd_dev_v2_refresh(rbd_dev);
> +
> +	/* If it's a mapped snapshot, validate its EXISTS flag */
> +
> +	rbd_exists_validate(rbd_dev);
>   	mutex_unlock(&ctl_mutex);
>   	if (ret)
>   		rbd_warn(rbd_dev, "got notification but failed to "
>

