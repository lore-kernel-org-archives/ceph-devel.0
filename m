From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/3 v2] rbd: extend the operation type
Date: Wed, 12 Mar 2014 23:47:36 -0500
Message-ID: <53213868.1010808@ieee.org>
References: <1394680896-8554-1-git-send-email-lucienchao@gmail.com> <1394680896-8554-2-git-send-email-lucienchao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:59553 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbaCMErd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Mar 2014 00:47:33 -0400
Received: by mail-ie0-f169.google.com with SMTP id to1so472020ieb.14
        for <ceph-devel@vger.kernel.org>; Wed, 12 Mar 2014 21:47:33 -0700 (PDT)
In-Reply-To: <1394680896-8554-2-git-send-email-lucienchao@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guangliang Zhao <lucienchao@gmail.com>, ceph-devel@vger.kernel.org

On 03/12/2014 10:21 PM, Guangliang Zhao wrote:
> It could only handle the read and write operations now,
> extend it for the coming discard support.

Wow, it looks like you took all of my suggestions.

This looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Guangliang Zhao <lucienchao@gmail.com>
> ---
>  drivers/block/rbd.c |   96 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 63 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 2d48858..fc5bf37 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -209,6 +209,11 @@ enum obj_request_type {
>  	OBJ_REQUEST_NODATA, OBJ_REQUEST_BIO, OBJ_REQUEST_PAGES
>  };
>  

. . .

