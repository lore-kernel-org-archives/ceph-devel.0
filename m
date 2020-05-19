From: Jerry Lee <leisurelysw24@gmail.com>
Subject: Re: [PATCH] libceph: add ignore cache/overlay flag if got redirect reply
Date: Tue, 19 May 2020 18:30:08 +0800
Message-ID: <CAKQB+ftbtXv0ET6OmUMsqKUoz5sRHQA35EprTY82_GC34b10XA@mail.gmail.com>
References: <CAKQB+fug_Y4y8wYe-vG=itf+0BmYFPfDm-ch7DTobtkipQz-yw@mail.gmail.com>
 <CAOi1vP-uF1_0R=5LApR=rdTXSzDWJq3LzuOYPrPmC_TPL909qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgESKaZ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 19 May 2020 06:30:25 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BCCC061A0C
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2020 03:30:21 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j145so11861247oib.5
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2020 03:30:21 -0700 (PDT)
In-Reply-To: <CAOi1vP-uF1_0R=5LApR=rdTXSzDWJq3LzuOYPrPmC_TPL909qA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>

On Tue, 19 May 2020 at 17:14, Ilya Dryomov <idryomov@gmail.com> wrote:
>
> On Mon, May 18, 2020 at 10:03 AM Jerry Lee <leisurelysw24@gmail.com> wrote:
> >
> > osd client should ignore cache/overlay flag if got redirect reply.
> > Otherwise, the client hangs when the cache tier is in forward mode.
> >
> > Similar issues:
> >    https://tracker.ceph.com/issues/23296
> >    https://tracker.ceph.com/issues/36406
> >
> > Signed-off-by: Jerry Lee <leisurelysw24@gmail.com>
> > ---
> >  net/ceph/osd_client.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index 998e26b..1d4973f 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -3649,7 +3649,9 @@ static void handle_reply(struct ceph_osd *osd,
> > struct ceph_msg *msg)
> >                  * supported.
> >                  */
> >                 req->r_t.target_oloc.pool = m.redirect.oloc.pool;
> > -               req->r_flags |= CEPH_OSD_FLAG_REDIRECTED;
> > +               req->r_flags |= CEPH_OSD_FLAG_REDIRECTED |
> > +                               CEPH_OSD_FLAG_IGNORE_OVERLAY |
> > +                               CEPH_OSD_FLAG_IGNORE_CACHE;
> >                 req->r_tid = 0;
> >                 __submit_request(req, false);
> >                 goto out_unlock_osdc;
>
> Hi Jerry,
>
> Looks good (although the patch was whitespace damaged).  I've fixed
> it up, but check out Documentation/process/email-clients.rst.
Thanks for sharing the doc!
>
> Also, out of curiosity, are you actually using the forward cache mode?
No, we accidentally found the issue when removing a writeback cache.
The kernel client got blocked when the cache mode switched from
writeback to forward and waited for the cache pool to be flushed.

BTW, a warning (Error EPERM: 'forward' is not a well-supported cache
mode and may corrupt your data.) is shown when the cache mode is
changed to forward mode.  Does it mean that the data integrity and IO
ordering cannot be ensured in this mode?

Thanks!

- Jerry
>
> Thanks,
>
>                 Ilya
