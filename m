From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH] ceph: Use pseudo-random numbers to choose mds
Date: Thu, 11 Apr 2013 10:25:18 -0700
Message-ID: <CAPYLRzgTm_mnJ4haq7y0pa--4Ag2U4Vu6wOvzTy_Sg1ofQTPrw@mail.gmail.com>
References: <1365606338-12278-1-git-send-email-sam.lang@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:64309 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933562Ab3DKRZT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Apr 2013 13:25:19 -0400
Received: by mail-qa0-f41.google.com with SMTP id bs12so413499qab.7
        for <ceph-devel@vger.kernel.org>; Thu, 11 Apr 2013 10:25:18 -0700 (PDT)
In-Reply-To: <1365606338-12278-1-git-send-email-sam.lang@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sam Lang <samlang@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sam Lang <sam.lang@inktank.com>

Yup, that is a change to not use entropy and to short-circuit if we
only have one choice. And this function has no side effects so it just
needs to return an int.

Reviewed-by: Greg Farnum <greg@inktank.com>
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Wed, Apr 10, 2013 at 8:05 AM, Sam Lang <samlang@gmail.com> wrote:
> We don't need to use up entropy to choose an mds,
> so use prandom_u32() to get a pseudo-random number.
>
> Also, we don't need to choose a random mds if only
> one mds is available, so add special casing for the
> common case.
>
> Fixes http://tracker.ceph.com/issues/3579
>
> Signed-off-by: Sam Lang <sam.lang@inktank.com>
> ---
>  fs/ceph/mdsmap.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index 0d3c924..9278dec 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -20,7 +20,10 @@ int ceph_mdsmap_get_random_mds(struct ceph_mdsmap *m)
>  {
>         int n = 0;
>         int i;
> -       char r;
> +
> +       /* special case for one mds */
> +       if (1 == m->m_max_mds && m->m_info[0].state > 0)
> +               return 0;
>
>         /* count */
>         for (i = 0; i < m->m_max_mds; i++)
> @@ -30,8 +33,7 @@ int ceph_mdsmap_get_random_mds(struct ceph_mdsmap *m)
>                 return -1;
>
>         /* pick */
> -       get_random_bytes(&r, 1);
> -       n = r % n;
> +       n = prandom_u32() % n;
>         i = 0;
>         for (i = 0; n > 0; i++, n--)
>                 while (m->m_info[i].state <= 0)
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
