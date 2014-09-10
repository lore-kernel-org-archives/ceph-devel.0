From: Sage Weil <sweil@redhat.com>
Subject: Re: [PATCH 1/3] libceph: gracefully handle large reply messages from
 the mon
Date: Wed, 10 Sep 2014 05:48:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409100548040.17200@cobra.newdream.net>
References: <1410335671-4581-1-git-send-email-ilya.dryomov@inktank.com> <1410335671-4581-2-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46548 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbaIJMsI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Sep 2014 08:48:08 -0400
In-Reply-To: <1410335671-4581-2-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by:

On Wed, 10 Sep 2014, Ilya Dryomov wrote:

> From: Sage Weil <sage@redhat.com>
> 
> We preallocate a few of the message types we get back from the mon.  If we
> get a larger message than we are expecting, fall back to trying to allocate
> a new one instead of blindly using the one we have.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Sage Weil <sage@redhat.com>
> ---
>  net/ceph/mon_client.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 067d3af2eaf6..61fcfc304f68 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -1181,7 +1181,15 @@ static struct ceph_msg *mon_alloc_msg(struct ceph_connection *con,
>  	if (!m) {
>  		pr_info("alloc_msg unknown type %d\n", type);
>  		*skip = 1;
> +	} else if (front_len > m->front_alloc_len) {
> +		pr_warning("mon_alloc_msg front %d > prealloc %d (%u#%llu)\n",
> +			   front_len, m->front_alloc_len,
> +			   (unsigned int)con->peer_name.type,
> +			   le64_to_cpu(con->peer_name.num));
> +		ceph_msg_put(m);
> +		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
>  	}
> +
>  	return m;
>  }
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
