From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 01/13] libceph: eliminate connection state "DEAD"
Date: Thu, 31 May 2012 09:20:55 -0700
Message-ID: <CAC-hyiHVRgSvfnzA6mOWY+H+bx8SxrNGEh6dNYUwT5ywRhRUMQ@mail.gmail.com>
References: <4FC673FC.3060004@inktank.com>
	<4FC67638.9050104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60026 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745Ab2EaQU6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 12:20:58 -0400
Received: by bkcji2 with SMTP id ji2so1019933bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 09:20:56 -0700 (PDT)
In-Reply-To: <4FC67638.9050104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Wed, May 30, 2012 at 12:34 PM, Alex Elder <elder@inktank.com> wrote:
> The ceph connection state "DEAD" is never set and is therefore not
> needed. =A0Eliminate it.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> =A0include/linux/ceph/messenger.h | =A0 =A01 -
> =A0net/ceph/messenger.c =A0 =A0 =A0 =A0 =A0 | =A0 =A06 ------
> =A02 files changed, 0 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/mess=
enger.h
> index 2521a95..aa506ca 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -119,7 +119,6 @@ struct ceph_msg_pos {
> =A0#define CLOSED =A0 =A0 =A0 =A0 10 /* we've closed the connection *=
/
> =A0#define SOCK_CLOSED =A0 =A011 /* socket state changed to closed */
> =A0#define OPENING =A0 =A0 =A0 =A0 13 /* open connection w/ (possibly=
 new) peer */
> -#define DEAD =A0 =A0 =A0 =A0 =A0 =A014 /* dead, about to kfree */
> =A0#define BACKOFF =A0 =A0 =A0 =A0 15
>
> =A0/*
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 1a80907..42ca8aa 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2087,12 +2087,6 @@ bad_tag:
> =A0*/
> =A0static void queue_con(struct ceph_connection *con)
> =A0{
> - =A0 =A0 =A0 if (test_bit(DEAD, &con->state)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dout("queue_con %p ignoring: DEAD\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0con);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0if (!con->ops->get(con)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dout("queue_con %p ref count 0\n", con=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> --
> 1.7.5.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
