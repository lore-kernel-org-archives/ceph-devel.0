From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 33/33] libceph: enable PRIMARY_AFFINITY feature bit
Date: Thu, 27 Mar 2014 16:04:40 -0500
Message-ID: <53349268.5050306@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-34-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:61587 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747AbaC0VES (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 17:04:18 -0400
Received: by mail-ie0-f177.google.com with SMTP id rl12so4037000iec.36
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 14:04:18 -0700 (PDT)
In-Reply-To: <1395944299-21970-34-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Announce our support for osdmaps with non-default primary affinity
> values.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/ceph_features.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
> index 7a4cab50b2cd..d12659ce550d 100644
> --- a/include/linux/ceph/ceph_features.h
> +++ b/include/linux/ceph/ceph_features.h
> @@ -91,7 +91,8 @@ static inline u64 ceph_sanitize_features(u64 features)
>  	 CEPH_FEATURE_CRUSH_V2 |		\
>  	 CEPH_FEATURE_EXPORT_PEER |		\
>  	 CEPH_FEATURE_OSDMAP_ENC |		\
> -	 CEPH_FEATURE_CRUSH_TUNABLES3)
> +	 CEPH_FEATURE_CRUSH_TUNABLES3 |		\
> +	 CEPH_FEATURE_OSD_PRIMARY_AFFINITY)
>  
>  #define CEPH_FEATURES_REQUIRED_DEFAULT   \
>  	(CEPH_FEATURE_NOSRCADDR |	 \
> 

