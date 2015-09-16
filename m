From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] libceph: advertise support for keepalive2
Date: Wed, 16 Sep 2015 14:28:46 +0800
Message-ID: <CAAM7YAkDeRXOjtX4KGJzcftadZ0tRvhzfLL3rbqfLSGv6_qQMw@mail.gmail.com>
References: <1442238695-13809-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:33464 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbbIPG2s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Sep 2015 02:28:48 -0400
Received: by lbbvu2 with SMTP id vu2so25423713lbb.0
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 23:28:46 -0700 (PDT)
In-Reply-To: <1442238695-13809-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Sep 14, 2015 at 9:51 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> We are the client, but advertise keepalive2 anyway - for consistency,
> if nothing else.  In the future the server might want to know whether
> its clients support keepalive2.

the kernel code still does fully support KEEPALIVE2 (it does not
recognize CEPH_MSGR_TAG_KEEPALIVE2 tag). I think it's better to not
advertise support for keepalive2.

Regards
Yan, Zheng

>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  include/linux/ceph/ceph_features.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
> index 4763ad64e832..f89b31d45cc8 100644
> --- a/include/linux/ceph/ceph_features.h
> +++ b/include/linux/ceph/ceph_features.h
> @@ -107,6 +107,7 @@ static inline u64 ceph_sanitize_features(u64 features)
>          CEPH_FEATURE_OSDMAP_ENC |              \
>          CEPH_FEATURE_CRUSH_TUNABLES3 |         \
>          CEPH_FEATURE_OSD_PRIMARY_AFFINITY |    \
> +        CEPH_FEATURE_MSGR_KEEPALIVE2 |         \
>          CEPH_FEATURE_CRUSH_V4)
>
>  #define CEPH_FEATURES_REQUIRED_DEFAULT   \
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
