From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: fix messenger CONFIG_BLOCK dependencies
Date: Fri, 01 Feb 2013 09:20:29 -0800
Message-ID: <510BF95D.9000306@inktank.com>
References: <510B5321.9020000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:43312 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871Ab3BARUc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 12:20:32 -0500
Received: by mail-pb0-f45.google.com with SMTP id rq13so2230474pbb.4
        for <ceph-devel@vger.kernel.org>; Fri, 01 Feb 2013 09:20:31 -0800 (PST)
In-Reply-To: <510B5321.9020000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 01/31/2013 09:31 PM, Alex Elder wrote:
> The ceph messenger has a few spots that are only used when
> bio messages are supported, and that's only when CONFIG_BLOCK
> is defined.  This surrounds a couple of spots with #ifdef's
> that would cause a problem if CONFIG_BLOCK were not present
> in the kernel configuration.
>
> This resolves:
>      http://tracker.ceph.com/issues/3976
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   include/linux/ceph/messenger.h |    2 ++
>   net/ceph/messenger.c           |    5 ++++-
>   2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index 14ba5ee..60903e0 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -83,9 +83,11 @@ struct ceph_msg {
>   	struct list_head list_head;
>
>   	struct kref kref;
> +#ifdef CONFIG_BLOCK
>   	struct bio  *bio;		/* instead of pages/pagelist */
>   	struct bio  *bio_iter;		/* bio iterator */
>   	int bio_seg;			/* current bio segment */
> +#endif /* CONFIG_BLOCK */
>   	struct ceph_pagelist *trail;	/* the trailing part of the data */
>   	bool front_is_vmalloc;
>   	bool more_to_follow;
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 5ccf87e..8a62a55 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -9,8 +9,9 @@
>   #include <linux/slab.h>
>   #include <linux/socket.h>
>   #include <linux/string.h>
> +#ifdef	CONFIG_BLOCK
>   #include <linux/bio.h>
> -#include <linux/blkdev.h>
> +#endif	/* CONFIG_BLOCK */
>   #include <linux/dns_resolver.h>
>   #include <net/tcp.h>
>
> @@ -2651,9 +2652,11 @@ struct ceph_msg *ceph_msg_new(int type, int
> front_len, gfp_t flags,
>   	m->page_alignment = 0;
>   	m->pages = NULL;
>   	m->pagelist = NULL;
> +#ifdef	CONFIG_BLOCK
>   	m->bio = NULL;
>   	m->bio_iter = NULL;
>   	m->bio_seg = 0;
> +#endif	/* CONFIG_BLOCK */
>   	m->trail = NULL;
>
>   	/* front */
>

