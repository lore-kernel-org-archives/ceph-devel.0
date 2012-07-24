From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 8/9] libceph: protect ceph_con_open() with mutex
Date: Tue, 24 Jul 2012 15:58:58 -0700
Message-ID: <CAC-hyiH8OSvXLdCmeC2mhchJ4h=J6HcNMgeQ++bvryo7Fsj+yg@mail.gmail.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
	<1342831308-18815-9-git-send-email-sage@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59031 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab2GXW67 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jul 2012 18:58:59 -0400
Received: by bkwj10 with SMTP id j10so66760bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jul 2012 15:58:58 -0700 (PDT)
In-Reply-To: <1342831308-18815-9-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Fri, Jul 20, 2012 at 5:41 PM, Sage Weil <sage@inktank.com> wrote:
> Take the con mutex while we are initiating a ceph open.  This is necessary
> because the may have previously been in use and then closed, which could
> result in a racing workqueue running con_work().
>
> Signed-off-by: Sage Weil <sage@inktank.com>
> ---
>  net/ceph/messenger.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index efa369f..65964c2 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -537,6 +537,7 @@ void ceph_con_open(struct ceph_connection *con,
>                    __u8 entity_type, __u64 entity_num,
>                    struct ceph_entity_addr *addr)
>  {
> +       mutex_lock(&con->mutex);
>         dout("con_open %p %s\n", con, ceph_pr_addr(&addr->in_addr));
>         set_bit(OPENING, &con->state);
>         WARN_ON(!test_and_clear_bit(CLOSED, &con->state));
> @@ -546,6 +547,7 @@ void ceph_con_open(struct ceph_connection *con,
>
>         memcpy(&con->peer_addr, addr, sizeof(*addr));
>         con->delay = 0;      /* reset backoff memory */
> +       mutex_unlock(&con->mutex);
>         queue_con(con);
>  }
>  EXPORT_SYMBOL(ceph_con_open);
> --
> 1.7.9
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
