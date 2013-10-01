From: Alex Elder <alex.elder@linaro.org>
Subject: Re: [PATCH 2/2] rbd: only set disk to read-only once
Date: Tue, 01 Oct 2013 16:21:27 -0500
Message-ID: <524B3CD7.4030807@linaro.org>
References: <1379993136-29246-1-git-send-email-guangliang@unitedstack.com> <1380604559-5331-3-git-send-email-josh.durgin@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42083 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab3JAVVN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Oct 2013 17:21:13 -0400
Received: by mail-ie0-f176.google.com with SMTP id as1so14986591iec.21
        for <ceph-devel@vger.kernel.org>; Tue, 01 Oct 2013 14:21:12 -0700 (PDT)
In-Reply-To: <1380604559-5331-3-git-send-email-josh.durgin@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>, ceph-devel@vger.kernel.org

On 10/01/2013 12:15 AM, Josh Durgin wrote:
> rbd_open(), called every time the device is opened, calls
> set_device_ro().  There's no reason to set the device read-only or
> read-write every time it is opened. Just do this once during device
> setup, using set_disk_ro() instead because the struct block_device
> isn't available to us there.

Looks good; set_disk_ro() sort of makes more sense anyway without
any partitions.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Josh Durgin <josh.durgin@inktank.com>
> ---
>  drivers/block/rbd.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b3b1b57..fc3ebd9 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -490,7 +490,6 @@ static int rbd_open(struct block_device *bdev, fmode_t mode)
>  		return -ENOENT;
>  
>  	(void) get_device(&rbd_dev->dev);
> -	set_device_ro(bdev, rbd_dev->mapping.read_only);
>  
>  	return 0;
>  }
> @@ -4949,6 +4948,7 @@ static int rbd_dev_device_setup(struct rbd_device *rbd_dev)
>  	if (ret)
>  		goto err_out_disk;
>  	set_capacity(rbd_dev->disk, rbd_dev->mapping.size / SECTOR_SIZE);
> +	set_disk_ro(rbd_dev->disk, rbd_dev->mapping.read_only);
>  
>  	ret = rbd_bus_add_dev(rbd_dev);
>  	if (ret)
> 

