From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 23/33] libceph: enable OSDMAP_ENC feature bit
Date: Thu, 27 Mar 2014 15:32:35 -0500
Message-ID: <53348AE3.2030700@ieee.org>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com> <1395944299-21970-24-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:40555 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbaC0UcO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 16:32:14 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so4023127iec.16
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 13:32:14 -0700 (PDT)
In-Reply-To: <1395944299-21970-24-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
> Announce our support for "new" osdmap enconding.

Looks OK to me.  Isn't there a version of this OSD
map encoding?  Maybe there'll be a "newer" one someday?

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  include/linux/ceph/ceph_features.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
> index 77c097fe9ea9..7a4cab50b2cd 100644
> --- a/include/linux/ceph/ceph_features.h
> +++ b/include/linux/ceph/ceph_features.h
> @@ -90,6 +90,7 @@ static inline u64 ceph_sanitize_features(u64 features)
>  	 CEPH_FEATURE_OSD_CACHEPOOL |		\
>  	 CEPH_FEATURE_CRUSH_V2 |		\
>  	 CEPH_FEATURE_EXPORT_PEER |		\
> +	 CEPH_FEATURE_OSDMAP_ENC |		\
>  	 CEPH_FEATURE_CRUSH_TUNABLES3)
>  
>  #define CEPH_FEATURES_REQUIRED_DEFAULT   \
> 

