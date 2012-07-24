From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 6/9] libceph: (re)initialize bio_iter on start of message receive
Date: Tue, 24 Jul 2012 15:55:06 -0700
Message-ID: <CAC-hyiG3Sj03gBVRCQiS_Px6yRVrCcCPuyeiKkSw=21j17tScA@mail.gmail.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
	<1342831308-18815-7-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62841 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748Ab2GXWzH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jul 2012 18:55:07 -0400
Received: by bkwj10 with SMTP id j10so65127bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jul 2012 15:55:06 -0700 (PDT)
In-Reply-To: <1342831308-18815-7-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Jul 20, 2012 at 5:41 PM, Sage Weil <sage@inktank.com> wrote:
> Previously, we were opportunistically initializing the bio_iter if it
> appeared to be uninitialized in the middle of the read path.  The problem
> is that a sequence like:
>
>  - start reading message
>  - initialize bio_iter
>  - read half a message
>  - messenger fault, reconnect
>  - restart reading message
>  - ** bio_iter now non-NULL, not reinitialized **
>  - read past end of bio, crash
>
> Instead, initialize the bio_iter unconditionally when we allocate/claim
> the message for read.
>
> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  net/ceph/messenger.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index e24310e..efa369f 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1876,6 +1876,11 @@ static int read_partial_message(struct ceph_connection *con)
>                 else
>                         con->in_msg_pos.page_pos = 0;
>                 con->in_msg_pos.data_pos = 0;
> +
> +#ifdef CONFIG_BLOCK
> +               if (m->bio)
> +                       init_bio_iter(m->bio, &m->bio_iter, &m->bio_seg);
> +#endif
>         }
>
>         /* front */
> @@ -1892,10 +1897,6 @@ static int read_partial_message(struct ceph_connection *con)
>                 if (ret <= 0)
>                         return ret;
>         }
> -#ifdef CONFIG_BLOCK
> -       if (m->bio && !m->bio_iter)
> -               init_bio_iter(m->bio, &m->bio_iter, &m->bio_seg);
> -#endif
>
>         /* (page) data */
>         while (con->in_msg_pos.data_pos < data_len) {
> @@ -1906,7 +1907,7 @@ static int read_partial_message(struct ceph_connection *con)
>                                 return ret;
>  #ifdef CONFIG_BLOCK
>                 } else if (m->bio) {
> -
> +                       BUG_ON(!m->bio_iter);
>                         ret = read_partial_message_bio(con,
>                                                  &m->bio_iter, &m->bio_seg,
>                                                  data_len, do_datacrc);
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
