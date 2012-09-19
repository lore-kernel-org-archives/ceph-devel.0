From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 6/9] rbd: get snapshot name for a v2 image
Date: Wed, 19 Sep 2012 12:31:18 -0700
Message-ID: <505A1D86.1060108@inktank.com>
References: <504A6273.7030807@inktank.com> <504A639E.7080503@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:44216 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab2ISTbV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 15:31:21 -0400
Received: by pbbrr13 with SMTP id rr13so3226714pbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 19 Sep 2012 12:31:20 -0700 (PDT)
In-Reply-To: <504A639E.7080503@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

A couple small things, otherwise:

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/07/2012 02:14 PM, Alex Elder wrote:
> Define rbd_dev_v2_snap_name() to fetch the name for a particular
> snapshot in a format 2 rbd image.
>
> Define rbd_dev_v2_snap_info() to to be a wrapper for getting the
> name, size, and features for a particular snapshot, using an
> interface that matches the equivalent function for version 1 images.
>
> Define rbd_dev_snap_info() wrapper function and use it to call the
> appropriate function for getting the snapshot name, size, and
> features, dependent on the rbd image format.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   78
> ++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 77 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8ff84fd..c6922a1 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2313,6 +2313,82 @@ out:
>   	return 0;
>   }
>
> +static char *rbd_dev_v2_snap_name(struct rbd_device *rbd_dev, u32 which)
> +{
> +	size_t size;
> +	void *reply_buf;
> +	__le64 snap_id;
> +	int ret;
> +	void *p;
> +	void *end;
> +	size_t snap_name_len;
> +	char *snap_name;
> +
> +	size = sizeof (__le32) + RBD_MAX_SNAP_NAME_LEN;
> +	reply_buf = kmalloc(size, GFP_KERNEL);
> +	if (!reply_buf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	snap_id = cpu_to_le64(rbd_dev->header.snapc->snaps[which]);
> +	ret = rbd_req_sync_exec(rbd_dev, rbd_dev->header_name,
> +				"rbd", "get_snapshot_name",
> +				(char *) &snap_id, sizeof (snap_id),
> +				reply_buf, size,
> +				CEPH_OSD_FLAG_READ, NULL);
> +	dout("%s: rbd_req_sync_exec returned %d\n", __func__, ret);
> +	if (ret < 0)
> +		goto out;
> +
> +	p = reply_buf;
> +	end = (char *) reply_buf + size;
> +	snap_name_len = 0;
> +	snap_name = ceph_extract_encoded_string(&p, end, &snap_name_len,
> +				GFP_KERNEL);
> +	if (IS_ERR(snap_name)) {
> +		ret = PTR_ERR(snap_name);
> +		goto out;
> +	} else
> +		dout("  snap_id 0x%016llx snap_name = %s\n",
> +			(unsigned long long) le64_to_cpu(snap_id), snap_name);

else block should have braces to match the if block.

> +	kfree(reply_buf);
> +
> +	return snap_name;
> +out:
> +	kfree(reply_buf);
> +
> +	return ERR_PTR(ret);
> +}
> +
> +static char *rbd_dev_v2_snap_info(struct rbd_device *rbd_dev, u32 which,
> +		u64 *snap_size, u64 *snap_features)
> +{
> +	__le64 snap_id;
> +	u8 order;
> +	int ret;
> +
> +	snap_id = rbd_dev->header.snapc->snaps[which];
> +	ret = _rbd_dev_v2_snap_size(rbd_dev, snap_id, &order, snap_size);
> +	if (ret)
> +		return ERR_PTR(ret);
> +	ret = _rbd_dev_v2_snap_features(rbd_dev, snap_id, snap_features);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return rbd_dev_v2_snap_name(rbd_dev, which);
> +}
> +
> +static char *rbd_dev_snap_info(struct rbd_device *rbd_dev, u32 which,
> +		u64 *snap_size, u64 *snap_features)
> +{
> +	if (rbd_dev->image_format == 1)
> +		return rbd_dev_v1_snap_info(rbd_dev, which,
> +					snap_size, snap_features);
> +	if (rbd_dev->image_format == 2)
> +		return rbd_dev_v2_snap_info(rbd_dev, which,
> +					snap_size, snap_features);
> +	return ERR_PTR(-EINVAL);
> +}
> +
>   /*
>    * Scan the rbd device's current snapshot list and compare it to the
>    * newly-received snapshot context.  Remove any existing snapshots
> @@ -2366,7 +2442,7 @@ static int rbd_dev_snaps_update(struct rbd_device
> *rbd_dev)
>   			continue;
>   		}
>
> -		snap_name = rbd_dev_v1_snap_info(rbd_dev, index,
> +		snap_name = rbd_dev_snap_info(rbd_dev, index,
>   						&snap_size, &snap_features);

This line's indentation is offset now.

>   		if (IS_ERR(snap_name))
>   			return PTR_ERR(snap_name);
>

