From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/4] rbd: verify rbd image order value
Date: Wed, 24 Oct 2012 11:02:13 -0700
Message-ID: <50882D25.8010706@inktank.com>
References: <5085791C.9010205@inktank.com> <5085798C.8010605@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56219 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab2JXSCQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Oct 2012 14:02:16 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so531847pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 24 Oct 2012 11:02:16 -0700 (PDT)
In-Reply-To: <5085798C.8010605@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Might want to add some output so we can tell which error
is being hit.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 10/22/2012 09:51 AM, Alex Elder wrote:
> This adds a verification that an rbd image's object order is
> within the upper and lower bounds supported by this implementation.
>
> It must be at least 9 (SECTOR_SHIFT), because the Linux bio system
> assumes that minimum granularity.
>
> It also must be less than 32 (at the moment anyway) because there
> exist spots in the code that store the size of a "segment" (object
> backing an rbd image) in a signed int variable, which can be 32 bits
> including the sign.  We should be able to relax this limit once
> we've verified the code uses 64-bit types where needed.
>
> Note that the CLI tool already limits the order to the range 12-25.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index d032883..4734446 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -533,6 +533,16 @@ static bool rbd_dev_ondisk_valid(struct
> rbd_image_header_ondisk *ondisk)
>   	if (memcmp(&ondisk->text, RBD_HEADER_TEXT, sizeof (RBD_HEADER_TEXT)))
>   		return false;
>
> +	/* The bio layer requires at least sector-sized I/O */
> +
> +	if (ondisk->options.order < SECTOR_SHIFT)
> +		return false;
> +
> +	/* If we use u64 in a few spots we may be able to loosen this */
> +
> +	if (ondisk->options.order > 8 * sizeof (int) - 1)
> +		return false;
> +
>   	/*
>   	 * The size of a snapshot header has to fit in a size_t, and
>   	 * that limits the number of snapshots.
>

