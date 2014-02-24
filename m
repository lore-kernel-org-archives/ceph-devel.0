From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 4/6] rbd: do not hard-code CEPH_OSD_MAX_OP in rbd_osd_req_callback()
Date: Mon, 24 Feb 2014 08:59:10 -0600
Message-ID: <530B5E3E.7010101@ieee.org>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com> <1393008946-7931-5-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:54339 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbaBXO7J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 09:59:09 -0500
Received: by mail-ie0-f175.google.com with SMTP id at1so3505570iec.20
        for <ceph-devel@vger.kernel.org>; Mon, 24 Feb 2014 06:59:08 -0800 (PST)
In-Reply-To: <1393008946-7931-5-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 02/21/2014 12:55 PM, Ilya Dryomov wrote:
> CEPH_OSD_MAX_OP value in rbd_osd_req_callback() is hard-coded to 2.
> Fix it.

Please squash this in with the previous patch (at least).
Change the BUG_ON() to rbd_assert() while you're at it
(and invert the logic).

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  drivers/block/rbd.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index b365e0dfccb6..48a889866824 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -1654,7 +1654,7 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req,
>  	if (osd_req->r_result < 0)
>  		obj_request->result = osd_req->r_result;
>  
> -	BUG_ON(osd_req->r_num_ops > 2);
> +	BUG_ON(osd_req->r_num_ops > CEPH_OSD_MAX_OP);
>  
>  	/*
>  	 * We support a 64-bit length, but ultimately it has to be
> 

