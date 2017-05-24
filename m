From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: cleanup old messages according to reconnect seq
Date: Wed, 24 May 2017 17:26:35 +0200
Message-ID: <CAOi1vP_a_tFOWp=nReXXp-veeb=m4B9TpPwcvdtt88JN2GTm6w@mail.gmail.com>
References: <20170505110818.28010-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33073 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937215AbdEXP0h (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 May 2017 11:26:37 -0400
Received: by mail-vk0-f66.google.com with SMTP id h16so9520078vkd.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 May 2017 08:26:36 -0700 (PDT)
In-Reply-To: <20170505110818.28010-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jeff Layton <jlayton@redhat.com>, idryomov@redhat.com

On Fri, May 5, 2017 at 1:08 PM, Yan, Zheng <zyan@redhat.com> wrote:
> when reopen a connection, use 'reconnect seq' to clean up
> messages that have already been received by peer.
>
> Fixes: http://tracker.ceph.com/issues/18690
> Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
> ---
>  net/ceph/messenger.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index f76bb33..af9c5a1 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2230,10 +2230,17 @@ static void process_ack(struct ceph_connection *con)
>         struct ceph_msg *m;
>         u64 ack = le64_to_cpu(con->in_temp_ack);
>         u64 seq;
> -
> -       while (!list_empty(&con->out_sent)) {
> -               m = list_first_entry(&con->out_sent, struct ceph_msg,
> -                                    list_head);
> +       bool reconnect = (con->in_tag == CEPH_MSGR_TAG_SEQ);
> +       struct list_head *list = reconnect ? &con->out_queue : &con->out_sent;
> +       /*
> +        * In the reconnect case, con_fault() has requeued messages
> +        * in out_sent. We should cleanup old messages according to
> +        * the reconnect seq.
> +        */
> +       while (!list_empty(list)) {
> +               m = list_first_entry(list, struct ceph_msg, list_head);
> +               if (reconnect && m->needs_out_seq)
> +                       break;
>                 seq = le64_to_cpu(m->hdr.seq);
>                 if (seq > ack)
>                         break;
> @@ -2242,6 +2249,7 @@ static void process_ack(struct ceph_connection *con)
>                 m->ack_stamp = jiffies;
>                 ceph_msg_remove(m);
>         }
> +
>         prepare_read_tag(con);
>  }
>

Reviewed-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
