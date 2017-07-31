From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH 2/6] libceph: don't call ->reencode_message() more than
 once per message
Date: Mon, 31 Jul 2017 09:55:36 +0800
Message-ID: <CAAM7YA=9gcYHG+RamzYUxw6ejo2rV_q_JGPMGgxa-YeD=ZS45Q@mail.gmail.com>
References: <1501245690-2362-1-git-send-email-idryomov@gmail.com> <1501245690-2362-3-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36545 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbdGaBzh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 30 Jul 2017 21:55:37 -0400
Received: by mail-ua0-f195.google.com with SMTP id w45so22692288uac.3
        for <ceph-devel@vger.kernel.org>; Sun, 30 Jul 2017 18:55:37 -0700 (PDT)
In-Reply-To: <1501245690-2362-3-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jul 28, 2017 at 8:41 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Reencoding an already reencoded message is a bad idea.  This could
> happen on Policy::stateful_server connections (!CEPH_MSG_CONNECT_LOSSY),
> such as MDS sessions.
>
> This didn't pop up in testing because currently only OSD requests are
> reencoded and OSD sessions are always lossy.
>
> Fixes: 98ad5ebd1505 ("libceph: ceph_connection_operations::reencode_message() method")
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  net/ceph/messenger.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index b7cc615d42ef..a67298c7e0cd 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1287,10 +1287,10 @@ static void prepare_write_message(struct ceph_connection *con)
>         if (m->needs_out_seq) {
>                 m->hdr.seq = cpu_to_le64(++con->out_seq);
>                 m->needs_out_seq = false;
> -       }
>
> -       if (con->ops->reencode_message)
> -               con->ops->reencode_message(m);
> +               if (con->ops->reencode_message)
> +                       con->ops->reencode_message(m);
> +       }
>
>         dout("prepare_write_message %p seq %lld type %d len %d+%d+%zd\n",
>              m, con->out_seq, le16_to_cpu(m->hdr.type),
> --
> 2.4.3
>
> --

Reviewed-by: "Yan, Zheng" <zyan@redhat.com>

> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
