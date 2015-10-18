From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] Net: ceph: messenger: Use local variable cursor in read_partial_msg_data()
Date: Sun, 18 Oct 2015 12:42:29 +0200
Message-ID: <CAOi1vP8LsQqLSHM9mW0fCX3VzRbj8RkjmGY20_uyv1LHs1M0BA@mail.gmail.com>
References: <1445162403-7612-1-git-send-email-shraddha.6596@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38634 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbbJRKmb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Oct 2015 06:42:31 -0400
Received: by wicll6 with SMTP id ll6so62597797wic.1
        for <ceph-devel@vger.kernel.org>; Sun, 18 Oct 2015 03:42:30 -0700 (PDT)
In-Reply-To: <1445162403-7612-1-git-send-email-shraddha.6596@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shraddha Barke <shraddha.6596@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alex Elder <elder@ieee.org>

On Sun, Oct 18, 2015 at 12:00 PM, Shraddha Barke
<shraddha.6596@gmail.com> wrote:
> Use local variable cursor in place of &msg->cursor in
>  read_partial_msg_data()
>
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
> ---
>  net/ceph/messenger.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index b9b0e3b..b3d1973 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2231,7 +2231,7 @@ static int read_partial_message_section(struct ceph_connection *con,
>  static int read_partial_msg_data(struct ceph_connection *con)
>  {
>         struct ceph_msg *msg = con->in_msg;
> -       struct ceph_msg_data_cursor *cursor = &msg->cursor;
> +       struct ceph_msg_data_cursor *cursor = cursor;
                                      ^^^^^^^^^^^^^^^^
This is not going to work...

Thanks,

                Ilya
