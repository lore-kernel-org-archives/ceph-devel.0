From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 4/9] libceph: fix mutex coverage for ceph_con_close
Date: Tue, 24 Jul 2012 15:29:04 -0700
Message-ID: <CAC-hyiFhy4W5H6PBiB54eKBmsj3pNLaGXsoWc9oOfFeD+WACbQ@mail.gmail.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
	<1342831308-18815-5-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59543 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754903Ab2GXW3F (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jul 2012 18:29:05 -0400
Received: by bkwj10 with SMTP id j10so53377bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jul 2012 15:29:04 -0700 (PDT)
In-Reply-To: <1342831308-18815-5-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Jul 20, 2012 at 5:41 PM, Sage Weil <sage@inktank.com> wrote:
> Hold the mutex while twiddling all of the state bits to avoid possible
> races.  While we're here, make not of why we cannot close the socket
> directly.
>
> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  net/ceph/messenger.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 7105908..e24310e 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -503,6 +503,7 @@ static void reset_connection(struct ceph_connection *con)
>   */
>  void ceph_con_close(struct ceph_connection *con)
>  {
> +       mutex_lock(&con->mutex);
>         dout("con_close %p peer %s\n", con,
>              ceph_pr_addr(&con->peer_addr.in_addr));
>         clear_bit(NEGOTIATING, &con->state);
> @@ -515,11 +516,16 @@ void ceph_con_close(struct ceph_connection *con)
>         clear_bit(KEEPALIVE_PENDING, &con->flags);
>         clear_bit(WRITE_PENDING, &con->flags);
>
> -       mutex_lock(&con->mutex);
>         reset_connection(con);
>         con->peer_global_seq = 0;
>         cancel_delayed_work(&con->work);
>         mutex_unlock(&con->mutex);
> +
> +       /*
> +        * We cannot close the socket directly from here because the
> +        * work threads use it without holding the mutex.  Instead, let
> +        * con_work() do it.
> +        */
>         queue_con(con);
>  }
>  EXPORT_SYMBOL(ceph_con_close);
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
