From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: MOSDOpReply v7 encoding
Date: Thu, 4 Feb 2016 08:19:30 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602040819120.28396@cpach.fuggernut.com>
References: <1454587937-27996-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37705 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbcBDNTO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2016 08:19:14 -0500
In-Reply-To: <1454587937-27996-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 4 Feb 2016, Ilya Dryomov wrote:
> Empty request_redirect_t (struct ceph_request_redirect in the kernel
> client) is now encoded with a bool.  NEW_OSDOPREPLY_ENCODING feature
> bit overlaps with already supported CRUSH_TUNABLES5.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Reviewed-by: Sage Weil <sage@redhat.com>

> ---
>  include/linux/ceph/ceph_features.h |  5 ++++-
>  net/ceph/osd_client.c              | 10 ++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
> index 6b4b059c158f..d2d78861c30a 100644
> --- a/include/linux/ceph/ceph_features.h
> +++ b/include/linux/ceph/ceph_features.h
> @@ -73,6 +73,8 @@
>  #define CEPH_FEATURE_MON_STATEFUL_SUB (1ULL<<57) /* stateful mon subscription */
>  #define CEPH_FEATURE_MON_ROUTE_OSDMAP (1ULL<<57) /* peon sends osdmaps */
>  #define CEPH_FEATURE_CRUSH_TUNABLES5	(1ULL<<58) /* chooseleaf stable mode */
> +// duplicated since it was introduced at the same time as CEPH_FEATURE_CRUSH_TUNABLES5
> +#define CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING   (1ULL<<58) /* New, v7 encoding */
>  
>  /*
>   * The introduction of CEPH_FEATURE_OSD_SNAPMAPPER caused the feature
> @@ -120,7 +122,8 @@ static inline u64 ceph_sanitize_features(u64 features)
>  	 CEPH_FEATURE_OSD_PRIMARY_AFFINITY |	\
>  	 CEPH_FEATURE_MSGR_KEEPALIVE2 |		\
>  	 CEPH_FEATURE_CRUSH_V4 |		\
> -	 CEPH_FEATURE_CRUSH_TUNABLES5)
> +	 CEPH_FEATURE_CRUSH_TUNABLES5 |		\
> +	 CEPH_FEATURE_NEW_OSDOPREPLY_ENCODING)
>  
>  #define CEPH_FEATURES_REQUIRED_DEFAULT   \
>  	(CEPH_FEATURE_NOSRCADDR |	 \
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 95d7443943fc..fb9da42eae98 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1814,6 +1814,7 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
>  	u32 osdmap_epoch;
>  	int already_completed;
>  	u32 bytes;
> +	u8 decode_redir;
>  	unsigned int i;
>  
>  	tid = le64_to_cpu(msg->hdr.tid);
> @@ -1885,6 +1886,15 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
>  		p += 8 + 4; /* skip replay_version */
>  		p += 8; /* skip user_version */
>  
> +		if (le16_to_cpu(msg->hdr.version) >= 7)
> +			ceph_decode_8_safe(&p, end, decode_redir, bad_put);
> +		else
> +			decode_redir = 1;
> +	} else {
> +		decode_redir = 0;
> +	}
> +
> +	if (decode_redir) {
>  		err = ceph_redirect_decode(&p, end, &redir);
>  		if (err)
>  			goto bad_put;
> -- 
> 2.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
