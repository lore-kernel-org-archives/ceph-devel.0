From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 1/2] ceph: fix parse options memory leak
Date: Mon, 12 Sep 2011 19:23:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109121923290.14165@cobra.newdream.net>
References: <CAB2gnbXKGD5fBykQdNhgTjS4GZDchzFGxXqRuuLEMqALLO4_7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37248 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231Ab1IMCRu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Sep 2011 22:17:50 -0400
In-Reply-To: <CAB2gnbXKGD5fBykQdNhgTjS4GZDchzFGxXqRuuLEMqALLO4_7w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: ceph-devel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Applied these both, thanks!

sage

On Mon, 12 Sep 2011, Noah Watkins wrote:

> ceph_destroy_options does not free opt->mon_addr that
> is allocated in ceph_parse_options.
> 
> Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
> ---
>  net/ceph/ceph_common.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> index d4038ca..97f70e5 100644
> --- a/net/ceph/ceph_common.c
> +++ b/net/ceph/ceph_common.c
> @@ -232,6 +232,7 @@ void ceph_destroy_options(struct ceph_options *opt)
>  		ceph_crypto_key_destroy(opt->key);
>  		kfree(opt->key);
>  	}
> +	kfree(opt->mon_addr);
>  	kfree(opt);
>  }
>  EXPORT_SYMBOL(ceph_destroy_options);
> -- 
> 1.7.6.1
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
