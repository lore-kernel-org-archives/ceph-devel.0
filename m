From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: add ignore cache/overlay flag if got redirect reply
Date: Tue, 19 May 2020 11:14:17 +0200
Message-ID: <CAOi1vP-uF1_0R=5LApR=rdTXSzDWJq3LzuOYPrPmC_TPL909qA@mail.gmail.com>
References: <CAKQB+fug_Y4y8wYe-vG=itf+0BmYFPfDm-ch7DTobtkipQz-yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgESJON (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2020 05:14:13 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6D9C061A0C
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2020 02:14:13 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id 18so3784085iln.9
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2020 02:14:13 -0700 (PDT)
In-Reply-To: <CAKQB+fug_Y4y8wYe-vG=itf+0BmYFPfDm-ch7DTobtkipQz-yw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jerry Lee <leisurelysw24@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>

On Mon, May 18, 2020 at 10:03 AM Jerry Lee <leisurelysw24@gmail.com> wrote:
>
> osd client should ignore cache/overlay flag if got redirect reply.
> Otherwise, the client hangs when the cache tier is in forward mode.
>
> Similar issues:
>    https://tracker.ceph.com/issues/23296
>    https://tracker.ceph.com/issues/36406
>
> Signed-off-by: Jerry Lee <leisurelysw24@gmail.com>
> ---
>  net/ceph/osd_client.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 998e26b..1d4973f 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -3649,7 +3649,9 @@ static void handle_reply(struct ceph_osd *osd,
> struct ceph_msg *msg)
>                  * supported.
>                  */
>                 req->r_t.target_oloc.pool = m.redirect.oloc.pool;
> -               req->r_flags |= CEPH_OSD_FLAG_REDIRECTED;
> +               req->r_flags |= CEPH_OSD_FLAG_REDIRECTED |
> +                               CEPH_OSD_FLAG_IGNORE_OVERLAY |
> +                               CEPH_OSD_FLAG_IGNORE_CACHE;
>                 req->r_tid = 0;
>                 __submit_request(req, false);
>                 goto out_unlock_osdc;

Hi Jerry,

Looks good (although the patch was whitespace damaged).  I've fixed
it up, but check out Documentation/process/email-clients.rst.

Also, out of curiosity, are you actually using the forward cache mode?

Thanks,

                Ilya
