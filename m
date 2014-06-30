From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 06/14] libceph: assert both regular and lingering lists
 in __remove_osd()
Date: Mon, 30 Jun 2014 07:37:13 -0500
Message-ID: <53B159F9.8040008@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-7-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:37135 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753441AbaF3MhH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 08:37:07 -0400
Received: by mail-ie0-f171.google.com with SMTP id x19so6785742ier.16
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 05:37:06 -0700 (PDT)
In-Reply-To: <1403716607-13535-7-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> It is important that both regular and lingering requests lists are
> empty when the OSD is removed.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/osd_client.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 052eb8bfcc74..a9b7ea7bfdc6 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1032,6 +1032,8 @@ static void __remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
>  {
>  	dout("__remove_osd %p\n", osd);
>  	BUG_ON(!list_empty(&osd->o_requests));
> +	BUG_ON(!list_empty(&osd->o_linger_requests));
> +
>  	rb_erase(&osd->o_node, &osdc->osds);
>  	list_del_init(&osd->o_osd_lru);
>  	ceph_con_close(&osd->o_con);
> 

