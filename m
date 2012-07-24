From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 9/9] libceph: reset connection retry on successfully negotiation
Date: Tue, 24 Jul 2012 16:00:23 -0700
Message-ID: <CAC-hyiF5_vQKk-PEYKjNkoNuDmYiXVXsVwVS71C0y6tmR1_ZAg@mail.gmail.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
	<1342831308-18815-10-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35321 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882Ab2GXXAY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jul 2012 19:00:24 -0400
Received: by bkwj10 with SMTP id j10so67346bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jul 2012 16:00:23 -0700 (PDT)
In-Reply-To: <1342831308-18815-10-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Jul 20, 2012 at 5:41 PM, Sage Weil <sage@inktank.com> wrote:
> We exponentially back off when we encounter connection errors.  If several
> errors accumulate, we will eventually wait ages before even trying to
> reconnect.
>
> Fix this by resetting the backoff counter after a successful negotiation/
> connection with the remote node.  Fixes ceph issue #2802.
>
> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  net/ceph/messenger.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 65964c2..28896eb 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1633,6 +1633,8 @@ static int process_connect(struct ceph_connection *con)
>                 if (con->in_reply.flags & CEPH_MSG_CONNECT_LOSSY)
>                         set_bit(LOSSYTX, &con->flags);
>
> +               con->delay = 0;      /* reset backoff memory */
> +
>                 prepare_read_tag(con);
>                 break;
>
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
