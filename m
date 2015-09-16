From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH] libceph: don't access invalid memory in keepalive2 path
Date: Wed, 16 Sep 2015 14:33:27 +0800
Message-ID: <CAAM7YA=81JqaU_0EE85wRLv+ZGK-bS0Yeue7RnHvvuteZqdmgw@mail.gmail.com>
References: <1442238626-13714-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34109 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbbIPGd3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Sep 2015 02:33:29 -0400
Received: by lbbmp1 with SMTP id mp1so97676719lbb.1
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2015 23:33:28 -0700 (PDT)
In-Reply-To: <1442238626-13714-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Sep 14, 2015 at 9:50 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> This
>
>     struct ceph_timespec ceph_ts;
>     ...
>     con_out_kvec_add(con, sizeof(ceph_ts), &ceph_ts);
>
> wraps ceph_ts into a kvec and adds it to con->out_kvec array, yet
> ceph_ts becomes invalid on return from prepare_write_keepalive().  As
> a result, we send out bogus keepalive2 stamps.  Fix this by encoding
> into a ceph_timespec member, similar to how acks are read and written.
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  include/linux/ceph/messenger.h | 4 +++-
>  net/ceph/messenger.c           | 9 +++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
> index 7e1252e97a30..b2371d9b51fa 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -238,6 +238,8 @@ struct ceph_connection {
>         bool out_kvec_is_msg; /* kvec refers to out_msg */
>         int out_more;        /* there is more data after the kvecs */
>         __le64 out_temp_ack; /* for writing an ack */
> +       struct ceph_timespec out_temp_keepalive2; /* for writing keepalive2
> +                                                    stamp */
>
>         /* message in temps */
>         struct ceph_msg_header in_hdr;
> @@ -248,7 +250,7 @@ struct ceph_connection {
>         int in_base_pos;     /* bytes read */
>         __le64 in_temp_ack;  /* for reading an ack */
>
> -       struct timespec last_keepalive_ack;
> +       struct timespec last_keepalive_ack; /* keepalive2 ack stamp */
>
>         struct delayed_work work;           /* send|recv work */
>         unsigned long       delay;          /* current delay interval */
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 525f454f7531..b9b0e3b5da49 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1353,11 +1353,12 @@ static void prepare_write_keepalive(struct ceph_connection *con)
>         dout("prepare_write_keepalive %p\n", con);
>         con_out_kvec_reset(con);
>         if (con->peer_features & CEPH_FEATURE_MSGR_KEEPALIVE2) {
> -               struct timespec ts = CURRENT_TIME;
> -               struct ceph_timespec ceph_ts;
> -               ceph_encode_timespec(&ceph_ts, &ts);
> +               struct timespec now = CURRENT_TIME;
> +
>                 con_out_kvec_add(con, sizeof(tag_keepalive2), &tag_keepalive2);
> -               con_out_kvec_add(con, sizeof(ceph_ts), &ceph_ts);
> +               ceph_encode_timespec(&con->out_temp_keepalive2, &now);
> +               con_out_kvec_add(con, sizeof(con->out_temp_keepalive2),
> +                                &con->out_temp_keepalive2);
>         } else {
>                 con_out_kvec_add(con, sizeof(tag_keepalive), &tag_keepalive);
>         }
> --
Sorry for introducing this bug


Reviewed-by: Yan, Zheng <zyan@redhat.com>

> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
