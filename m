From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] libceph: trivial fix for the incorrect debug output
Date: Mon, 16 Jul 2012 07:55:16 -0500
Message-ID: <50040F34.3080909@inktank.com>
References: <1342334726-28541-1-git-send-email-jjzhang@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46792 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab2GPMzS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Jul 2012 08:55:18 -0400
Received: by yenl2 with SMTP id l2so4915408yen.19
        for <ceph-devel@vger.kernel.org>; Mon, 16 Jul 2012 05:55:17 -0700 (PDT)
In-Reply-To: <1342334726-28541-1-git-send-email-jjzhang@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jiaju Zhang <jjzhang@suse.de>
Cc: ceph-devel@vger.kernel.org

On 07/15/2012 01:45 AM, Jiaju Zhang wrote:
> This is a trivial fix for the debug output, as it is inconsistent
> with the function name so may confuse people when debugging.
> 
> Signed-off-by: Jiaju Zhang <jjzhang@suse.de>

I have been converting these to use __func__ whenever I touch
code nearby.  Mind if I do that here as well?

Reviewed-by: Alex Elder <elder@inktank.com>

> ---
>  net/ceph/osd_client.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 1ffebed..ad6d745 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -688,7 +688,7 @@ static void __remove_osd(struct ceph_osd_client *osdc, struct ceph_osd *osd)
>  
>  static void remove_all_osds(struct ceph_osd_client *osdc)
>  {
> -	dout("__remove_old_osds %p\n", osdc);
> +	dout("__remove_all_osds %p\n", osdc);

        dout("%s %p\n", __func__, osdc);

>  	mutex_lock(&osdc->request_mutex);
>  	while (!RB_EMPTY_ROOT(&osdc->osds)) {
>  		struct ceph_osd *osd = rb_entry(rb_first(&osdc->osds),
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


