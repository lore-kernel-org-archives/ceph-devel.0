From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: revalidate_disk upon rbd resize
Date: Mon, 15 Apr 2013 12:24:37 -0500
Message-ID: <516C37D5.1090804@inktank.com>
References: <1365774766-29899-1-git-send-email-laurent@ksperis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:49418 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933629Ab3DORYk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Apr 2013 13:24:40 -0400
Received: by mail-ie0-f169.google.com with SMTP id ar20so5798651iec.0
        for <ceph-devel@vger.kernel.org>; Mon, 15 Apr 2013 10:24:38 -0700 (PDT)
In-Reply-To: <1365774766-29899-1-git-send-email-laurent@ksperis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laurent Barbe <laurent@ksperis.com>
Cc: ceph-devel@vger.kernel.org

On 04/12/2013 08:52 AM, Laurent Barbe wrote:
> If rbd disk is open and rbd resize is done, new size is not visible by
> filesystem.
> Like is done in virtio-blk and dm driver, revalidate_disk() permits to
> update the bd_inode size.
> 
> Signed-off-by: Laurent Barbe <laurent@ksperis.com>

This one looks good (too).  And this time I've tested
it just to be sure I get no lockdep warnings.  Unless
I see any strangeness in my sanity testing (which I
don't expect) I'll commit this to the testing branch
later today.  Thanks a lot.

Reviewed-by: Alex Elder <elder@inktank.com>


> ---
>  drivers/block/rbd.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4daa400..5f88de9 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1883,6 +1883,7 @@ static int rbd_dev_refresh(struct rbd_device *rbd_dev, u64 *hver)
>  	else
>  		ret = rbd_dev_v2_refresh(rbd_dev, hver);
>  	mutex_unlock(&ctl_mutex);
> +	revalidate_disk(rbd_dev->disk);
>  
>  	return ret;
>  }
> 

