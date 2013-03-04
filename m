From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 2/3] libceph: define mds_alloc_msg() method
Date: Mon, 4 Mar 2013 11:05:13 -0800
Message-ID: <CAPYLRziQhNS1GcXUyhyrY=4YC0A4xW9YhPYYAbQFQJk9JkTAww@mail.gmail.com>
References: <5134E25E.4030701@inktank.com>
	<5134E3AD.4080906@inktank.com>
	<5134E401.6070604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:63493 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079Ab3CDTFN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Mar 2013 14:05:13 -0500
Received: by mail-qa0-f46.google.com with SMTP id o13so1391714qaj.12
        for <ceph-devel@vger.kernel.org>; Mon, 04 Mar 2013 11:05:13 -0800 (PST)
In-Reply-To: <5134E401.6070604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This looks like a faithful reshuffling to me.

But...
On Mon, Mar 4, 2013 at 10:12 AM, Alex Elder <elder@inktank.com> wrote:
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 6ec6051..c7d4278 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2804,55 +2804,34 @@ static int ceph_alloc_middle(struct
> ceph_connection *con, struct ceph_msg *msg)
>  static int ceph_con_in_msg_alloc(struct ceph_connection *con, int *skip)
>  {
>         struct ceph_msg_header *hdr = &con->in_hdr;
> -       int type = le16_to_cpu(hdr->type);
> -       int front_len = le32_to_cpu(hdr->front_len);
>         int middle_len = le32_to_cpu(hdr->middle_len);
>         struct ceph_msg *msg;
>         int ret = 0;
>
>         BUG_ON(con->in_msg != NULL);
> +       BUG_ON(!con->ops->alloc_msg);
>
> -       if (con->ops->alloc_msg) {
> -               mutex_unlock(&con->mutex);
> -               msg = con->ops->alloc_msg(con, hdr, skip);
> -               mutex_lock(&con->mutex);
> -               if (con->state != CON_STATE_OPEN) {
> -                       if (msg)
> -                               ceph_msg_put(msg);
> -                       return -EAGAIN;
> -               }
> -               con->in_msg = msg;
> -               if (con->in_msg) {
> -                       con->in_msg->con = con->ops->get(con);
> -                       BUG_ON(con->in_msg->con == NULL);
> -               }
> -               if (*skip) {
> -                       con->in_msg = NULL;
> -                       return 0;
> -               }
> -               if (!con->in_msg) {
> -                       con->error_msg =
> -                               "error allocating memory for incoming message";
> -                       return -ENOMEM;
> -               }
> -       }
> -       if (!con->in_msg) {
> -               mutex_unlock(&con->mutex);
> -               msg = ceph_msg_new(type, front_len, GFP_NOFS, false);
> -               mutex_lock(&con->mutex);
> -               if (!msg) {
> -                       pr_err("unable to allocate msg type %d len %d\n",
> -                              type, front_len);
> -                       return -ENOMEM;
> -               }
> -               if (con->state != CON_STATE_OPEN) {
> +       mutex_unlock(&con->mutex);
> +       msg = con->ops->alloc_msg(con, hdr, skip);
> +       mutex_lock(&con->mutex);
> +       if (con->state != CON_STATE_OPEN) {
> +               if (msg)
>                         ceph_msg_put(msg);
> -                       return -EAGAIN;
> -               }
> -               con->in_msg = msg;
> +               return -EAGAIN;
> +       }
> +       con->in_msg = msg;
> +       if (con->in_msg) {
>                 con->in_msg->con = con->ops->get(con);
>                 BUG_ON(con->in_msg->con == NULL);
> -               con->in_msg->page_alignment = le16_to_cpu(hdr->data_off);
> +       }
> +       if (*skip) {
> +               con->in_msg = NULL;
> +               return 0;

This looks like a memory leak to me? I'm not familiar with the skip
infrastructure; is there something that cleans up those messages in
the background, or should this actually be a BUG_ON?
-Greg
