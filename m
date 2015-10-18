From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] Net: ceph: osd_client: Remove con argument in handle_reply
Date: Sun, 18 Oct 2015 11:22:19 +0200
Message-ID: <CAOi1vP-8QS-F1Rcn51=fGCaMg_9QFHP=_XzF-t8O7H1vXrVh4Q@mail.gmail.com>
References: <1445156738-3797-1-git-send-email-shraddha.6596@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37358 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbbJRJWU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Oct 2015 05:22:20 -0400
Received: by wicfv8 with SMTP id fv8so40548439wic.0
        for <ceph-devel@vger.kernel.org>; Sun, 18 Oct 2015 02:22:19 -0700 (PDT)
In-Reply-To: <1445156738-3797-1-git-send-email-shraddha.6596@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shraddha Barke <shraddha.6596@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Oct 18, 2015 at 10:25 AM, Shraddha Barke
<shraddha.6596@gmail.com> wrote:
> Since the function handle_reply does not use it's con argument,
> remove it.
>
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
> ---
>  net/ceph/osd_client.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 80b94e3..e281f60 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1745,8 +1745,7 @@ static void complete_request(struct ceph_osd_request *req)
>   * handle osd op reply.  either call the callback if it is specified,
>   * or do the completion to wake up the waiting thread.
>   */
> -static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
> -                        struct ceph_connection *con)
> +static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg)
>  {
>         void *p, *end;
>         struct ceph_osd_request *req;
> @@ -2802,7 +2801,7 @@ static void dispatch(struct ceph_connection *con, struct ceph_msg *msg)
>                 ceph_osdc_handle_map(osdc, msg);
>                 break;
>         case CEPH_MSG_OSD_OPREPLY:
> -               handle_reply(osdc, msg, con);
> +               handle_reply(osdc, msg);
>                 break;
>         case CEPH_MSG_WATCH_NOTIFY:
>                 handle_watch_notify(osdc, msg);

Applied, with a slightly tweaked change log - see
https://github.com/ceph/ceph-client/commit/81c842af2b39009ec1f8272a33b149ad0e845aaf.

Thanks,

                Ilya
