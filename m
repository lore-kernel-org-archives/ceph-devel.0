From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/3] libceph: ceph-msgr workqueue needs a resque worker
Date: Tue, 14 Oct 2014 08:56:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410140856120.10462@cobra.newdream.net>
References: <1412965626-11165-1-git-send-email-idryomov@redhat.com> <1412965626-11165-2-git-send-email-idryomov@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36076 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932229AbaJNP4U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 11:56:20 -0400
In-Reply-To: <1412965626-11165-2-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org, Micha Krause <micha@krausam.de>

Reviewed-by: Sage Weil <sage@redhat.com>

On Fri, 10 Oct 2014, Ilya Dryomov wrote:

> Commit f363e45fd118 ("net/ceph: make ceph_msgr_wq non-reentrant")
> effectively removed WQ_MEM_RECLAIM flag from ceph_msgr_wq.  This is
> wrong - libceph is very much a memory reclaim path, so restore it.
> 
> Cc: stable@vger.kernel.org # needs backporting for < 3.12
> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
> Tested-by: Micha Krause <micha@krausam.de>
> ---
>  net/ceph/messenger.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 9764c771cfb1..559c9f619c20 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -292,7 +292,11 @@ int ceph_msgr_init(void)
>  	if (ceph_msgr_slab_init())
>  		return -ENOMEM;
>  
> -	ceph_msgr_wq = alloc_workqueue("ceph-msgr", 0, 0);
> +	/*
> +	 * The number of active work items is limited by the number of
> +	 * connections, so leave @max_active at default.
> +	 */
> +	ceph_msgr_wq = alloc_workqueue("ceph-msgr", WQ_MEM_RECLAIM, 0);
>  	if (ceph_msgr_wq)
>  		return 0;
>  
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
