From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: revalidate_disk upon rbd resize
Date: Wed, 10 Apr 2013 14:30:41 -0500
Message-ID: <5165BDE1.7010908@inktank.com>
References: <1365609989-14493-1-git-send-email-laurent@ksperis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365609989-14493-1-git-send-email-laurent@ksperis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Barbe <laurent@ksperis.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 04/10/2013 11:06 AM, Laurent Barbe wrote:
> If rbd disk is open and rbd resize is done, new size is not visible by
> filesystem.
> Like is done in virtio-blk and dm driver, revalidate_disk() permits to
> update the bd_inode size.

Looks good to me.  I'll take this in via the ceph-client tree.
Thanks a lot.

Reviewed-by: Alex Elder <elder@inktank.com>

> Signed-off-by: Laurent Barbe <laurent@ksperis.com>
> ---
>  drivers/block/rbd.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f556f8a..1963025 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2293,6 +2293,7 @@ static void rbd_update_mapping_size(struct rbd_device *rbd_dev)
>  	dout("setting size to %llu sectors", (unsigned long long) size);
>  	rbd_dev->mapping.size = (u64) size;
>  	set_capacity(rbd_dev->disk, size);
> +	revalidate_disk(rbd_dev->disk);
>  }
>  
>  /*
> 
