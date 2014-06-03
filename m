From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v3 1/4] libceph: recognize poolop requests in debugfs
Date: Tue, 3 Jun 2014 13:51:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1406031350570.26887@cobra.newdream.net>
References: <1400777408-7016-1-git-send-email-ilya.dryomov@inktank.com> <1400777408-7016-2-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50232 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170AbaFCUvB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jun 2014 16:51:01 -0400
In-Reply-To: <1400777408-7016-2-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by:

On Thu, 22 May 2014, Ilya Dryomov wrote:

> Recognize poolop requests in debugfs monc dump, fix prink format
> specifiers - tid is unsigned.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/debugfs.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> index 10421a4b76f8..8903dcee8d8e 100644
> --- a/net/ceph/debugfs.c
> +++ b/net/ceph/debugfs.c
> @@ -126,9 +126,11 @@ static int monc_show(struct seq_file *s, void *p)
>  		req = rb_entry(rp, struct ceph_mon_generic_request, node);
>  		op = le16_to_cpu(req->request->hdr.type);
>  		if (op == CEPH_MSG_STATFS)
> -			seq_printf(s, "%lld statfs\n", req->tid);
> +			seq_printf(s, "%llu statfs\n", req->tid);
> +		else if (op == CEPH_MSG_POOLOP)
> +			seq_printf(s, "%llu poolop\n", req->tid);
>  		else
> -			seq_printf(s, "%lld unknown\n", req->tid);
> +			seq_printf(s, "%llu unknown\n", req->tid);
>  	}
>  
>  	mutex_unlock(&monc->mutex);
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
