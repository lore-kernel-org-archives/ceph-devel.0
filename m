From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: fix double free on rbd_dev->header_name
Date: Tue, 1 Sep 2015 07:26:56 -0500
Message-ID: <55E59990.5010902@ieee.org>
References: <1441025248-50599-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33415 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbbIAM06 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Sep 2015 08:26:58 -0400
Received: by iods203 with SMTP id s203so193227044iod.0
        for <ceph-devel@vger.kernel.org>; Tue, 01 Sep 2015 05:26:58 -0700 (PDT)
In-Reply-To: <1441025248-50599-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 08/31/2015 07:47 AM, Ilya Dryomov wrote:
> If rbd_dev_image_probe() in rbd_dev_probe_parent() fails, header_name
> is freed twice: once in rbd_dev_probe_parent() and then in its caller
> rbd_dev_image_probe() (rbd_dev_image_probe() is called recursively to
> handle parent images).
> 
> rbd_dev_probe_parent() is responsible for probing the parent, so it
> shoudn't mock with clone's fields.

Agreed.  (But I think you mean "muck with.")  The other
argument is that the caller is who allocated it (via
rbd_dev_header_name()), so it should be responsible for
freeing it.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  drivers/block/rbd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index bc67a93aa4f4..324bf35ec4dd 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -5201,7 +5201,6 @@ static int rbd_dev_probe_parent(struct rbd_device *rbd_dev)
>  out_err:
>  	if (parent) {
>  		rbd_dev_unparent(rbd_dev);
> -		kfree(rbd_dev->header_name);
>  		rbd_dev_destroy(parent);
>  	} else {
>  		rbd_put_client(rbdc);
> 

