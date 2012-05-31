From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [PATCH 02/13] libceph: kill bad_proto ceph connection op
Date: Thu, 31 May 2012 09:30:40 -0700
Message-ID: <CAC-hyiH_WDF8PYUYtBsotDrsei25Cqj7dzu1kR4Ba1HXNkVYLQ@mail.gmail.com>
References: <4FC673FC.3060004@inktank.com>
	<4FC6763F.90203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61265 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab2EaQam convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 May 2012 12:30:42 -0400
Received: by bkcji2 with SMTP id ji2so1030274bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 31 May 2012 09:30:40 -0700 (PDT)
In-Reply-To: <4FC6763F.90203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>

On Wed, May 30, 2012 at 12:34 PM, Alex Elder <elder@inktank.com> wrote:
> No code sets a bad_proto method in its ceph connection operations
> vector, so just get rid of it.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
> =A0include/linux/ceph/messenger.h | =A0 =A03 ---
> =A0net/ceph/messenger.c =A0 =A0 =A0 =A0 =A0 | =A0 =A05 -----
> =A02 files changed, 0 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/mess=
enger.h
> index aa506ca..74f6c9b 100644
> --- a/include/linux/ceph/messenger.h
> +++ b/include/linux/ceph/messenger.h
> @@ -31,9 +31,6 @@ struct ceph_connection_operations {
> =A0 =A0 =A0 =A0int (*verify_authorizer_reply) (struct ceph_connection=
 *con, int
> len);
> =A0 =A0 =A0 =A0int (*invalidate_authorizer)(struct ceph_connection *c=
on);
>
> - =A0 =A0 =A0 /* protocol version mismatch */
> - =A0 =A0 =A0 void (*bad_proto) (struct ceph_connection *con);
> -
> =A0 =A0 =A0 =A0/* there was some error on the socket (disconnect, wha=
tever) */
> =A0 =A0 =A0 =A0void (*fault) (struct ceph_connection *con);
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 42ca8aa..07af994 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1356,11 +1356,6 @@ static void fail_protocol(struct ceph_connecti=
on
> *con)
> =A0{
> =A0 =A0 =A0 =A0reset_connection(con);
> =A0 =A0 =A0 =A0set_bit(CLOSED, &con->state); =A0/* in case there's qu=
eued work */
> -
> - =A0 =A0 =A0 mutex_unlock(&con->mutex);
> - =A0 =A0 =A0 if (con->ops->bad_proto)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 con->ops->bad_proto(con);
> - =A0 =A0 =A0 mutex_lock(&con->mutex);
> =A0}
>
> =A0static int process_connect(struct ceph_connection *con)
> --
> 1.7.5.4
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
