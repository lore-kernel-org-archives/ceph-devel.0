From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: add new snapshots at the tail
Date: Tue, 04 Sep 2012 15:43:59 -0700
Message-ID: <5046842F.7050804@inktank.com>
References: <50464390.3010107@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35063 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757824Ab2IDWoC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Sep 2012 18:44:02 -0400
Received: by pbbrr13 with SMTP id rr13so10189028pbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 04 Sep 2012 15:44:02 -0700 (PDT)
In-Reply-To: <50464390.3010107@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 09/04/2012 11:08 AM, Alex Elder wrote:
> This fixes a bug that went in with this commit:
>
>      commit f6e0c99092cca7be00fca4080cfc7081739ca544
>      Author: Alex Elder <elder@inktank.com>
>      Date:   Thu Aug 2 11:29:46 2012 -0500
>      rbd: simplify __rbd_init_snaps_header()
>
> The problem is that a new rbd snapshot needs to go either after an
> existing snapshot entry, or at the *end* of an rbd device's snapshot
> list.  As originally coded, it is placed at the beginning.  This was
> based on the assumption the list would be empty (so it wouldn't
> matter), but in fact if multiple new snapshots are added to an empty
> list in one shot the list will be non-empty after the first one is
> added.
>
> This addresses http://tracker.newdream.net/issues/3063
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 8e6e29e..fd51f9d 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2187,7 +2187,7 @@ static int __rbd_init_snaps_header(struct
> rbd_device *rbd_dev)
>   			if (snap)
>   				list_add_tail(&new_snap->node, &snap->node);
>   			else
> -				list_add(&new_snap->node, head);
> +				list_add_tail(&new_snap->node, head);
>   		} else {
>   			/* Already have this one */
>

