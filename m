From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: fix possible CONFIG_BLOCK build problem
Date: Mon, 08 Apr 2013 13:07:38 -0700
Message-ID: <5163238A.600@inktank.com>
References: <515F4D77.1080205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:54537 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935850Ab3DHUIN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Apr 2013 16:08:13 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so3452374pad.30
        for <ceph-devel@vger.kernel.org>; Mon, 08 Apr 2013 13:08:13 -0700 (PDT)
In-Reply-To: <515F4D77.1080205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 04/05/2013 03:17 PM, Alex Elder wrote:
> This patch:
>      15a0d7b libceph: record message data length
> did not enclose some bio-specific code inside CONFIG_BLOCK as
> it should have.  Fix that.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/messenger.h |    2 ++
>   net/ceph/messenger.c           |    4 +++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index b832c0c..cdeebae 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -271,8 +271,10 @@ extern void ceph_msg_data_set_pages(struct ceph_msg
> *msg, struct page **pages,
>   				size_t length, size_t alignment);
>   extern void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
>   				struct ceph_pagelist *pagelist);
> +#ifdef CONFIG_BLOCK
>   extern void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio,
>   				size_t length);
> +#endif /* CONFIG_BLOCK */
>
>   extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
>   				     bool can_fail);
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index a6fda95..994192b 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -817,7 +817,7 @@ static bool ceph_msg_data_bio_advance(struct
> ceph_msg_data *data, size_t bytes)
>
>   	return true;
>   }
> -#endif
> +#endif /* CONFIG_BLOCK */
>
>   /*
>    * For a page array, a piece comes from the first page in the array
> @@ -3011,6 +3011,7 @@ void ceph_msg_data_set_pagelist(struct ceph_msg *msg,
>   }
>   EXPORT_SYMBOL(ceph_msg_data_set_pagelist);
>
> +#ifdef	CONFIG_BLOCK
>   void ceph_msg_data_set_bio(struct ceph_msg *msg, struct bio *bio,
>   		size_t length)
>   {
> @@ -3028,6 +3029,7 @@ void ceph_msg_data_set_bio(struct ceph_msg *msg,
> struct bio *bio,
>   	msg->data_length = length;
>   }
>   EXPORT_SYMBOL(ceph_msg_data_set_bio);
> +#endif	/* CONFIG_BLOCK */
>
>   /*
>    * construct a new message with given type, size
>

