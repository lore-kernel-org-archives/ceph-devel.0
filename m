From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v2] Net: ceph: messenger: Use local variable cursor in read_partial_msg_data()
Date: Mon, 19 Oct 2015 11:43:59 +0200
Message-ID: <CAOi1vP_7J6tbwyXz-1wOj7EvyQ-0=2Zb9_KfVi+-vMj5dQ1exA@mail.gmail.com>
References: <1445222975-16086-1-git-send-email-shraddha.6596@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32810 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbbJSJoA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 05:44:00 -0400
Received: by lffv3 with SMTP id v3so106103713lff.0
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 02:43:59 -0700 (PDT)
In-Reply-To: <1445222975-16086-1-git-send-email-shraddha.6596@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shraddha Barke <shraddha.6596@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@ieee.org>

On Mon, Oct 19, 2015 at 4:49 AM, Shraddha Barke <shraddha.6596@gmail.com> wrote:
> Use local variable cursor in place of &msg->cursor in
>  read_partial_msg_data()
>
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
> ---
> Changes in v2-
>  Drop incorrect use of cursor
>
>  net/ceph/messenger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index b9b0e3b..b087edd 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2246,7 +2246,7 @@ static int read_partial_msg_data(struct ceph_connection *con)
>         if (do_datacrc)
>                 crc = con->in_data_crc;
>         while (cursor->resid) {
> -               page = ceph_msg_data_next(&msg->cursor, &page_offset, &length,
> +               page = ceph_msg_data_next(cursor, &page_offset, &length,
>                                                         NULL);
>                 ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
>                 if (ret <= 0) {
> @@ -2258,7 +2258,7 @@ static int read_partial_msg_data(struct ceph_connection *con)
>
>                 if (do_datacrc)
>                         crc = ceph_crc32c_page(crc, page, page_offset, ret);
> -               (void) ceph_msg_data_advance(&msg->cursor, (size_t)ret);
> +               (void) ceph_msg_data_advance(cursor, (size_t)ret);
>         }
>         if (do_datacrc)
>                 con->in_data_crc = crc;

This looks good.  I'd like you to update this patch to do the same for
write_partial_message_data().

Thanks,

                Ilya
