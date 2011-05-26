From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v5 4/4] rbd: Add bdrv_truncate implementation
Date: Thu, 26 May 2011 10:05:40 +0200
Message-ID: <4DDE09D4.6020705@redhat.com>
References: <1306355687-4647-1-git-send-email-josh.durgin@dreamhost.com> <1306355687-4647-5-git-send-email-josh.durgin@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3730 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753770Ab1EZIC4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2011 04:02:56 -0400
In-Reply-To: <1306355687-4647-5-git-send-email-josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, Christian Brunner <chb@muc.de>

Am 25.05.2011 22:34, schrieb Josh Durgin:
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>
> ---
>  block/rbd.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/block/rbd.c b/block/rbd.c
> index a44d160..b95b1eb 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -688,6 +688,20 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
>      return info.size;
>  }
>  
> +static int qemu_rbd_truncate(BlockDriverState *bs, int64_t offset)
> +{
> +    BDRVRBDState *s = bs->opaque;
> +    int r;
> +
> +    r = rbd_resize(s->image, offset);
> +    if (r < 0) {
> +        error_report("failed to resize rbd image");
> +        return -EIO;
> +    }

Don't print an error message here. The caller will do it, too, so we end
up with two error messages saying the same.

What kind of error code does rbd_resize return? If it is a valid errno
value, you should return r instead of turning it into EIO.

Kevin
