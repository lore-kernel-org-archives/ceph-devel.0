From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH 3/3] ceph: fix vmtruncate deadlock
Date: Fri, 22 Feb 2013 10:54:17 -0800
Message-ID: <CAPYLRziAgfT0F2cdNe+sMbiphBMz20Sm3oSgqkdwNcJL-K--DQ@mail.gmail.com>
References: <1361498899-15831-1-git-send-email-zheng.z.yan@intel.com>
	<1361498899-15831-4-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:61730 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758338Ab3BVSyS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 13:54:18 -0500
Received: by mail-qa0-f43.google.com with SMTP id dx4so572732qab.2
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 10:54:17 -0800 (PST)
In-Reply-To: <1361498899-15831-4-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

I haven't spent that much time in the kernel client, but this patch
isn't working out for me. In particular, I'm pretty sure we need to
preserve this:

> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 5d5c32b..b9d8417 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2067,12 +2067,6 @@ static int try_get_cap_refs(struct ceph_inode_info *ci, int need, int want,
>         }
>         have = __ceph_caps_issued(ci, &implemented);
>
> -       /*
> -        * disallow writes while a truncate is pending
> -        */
> -       if (ci->i_truncate_pending)
> -               have &= ~CEPH_CAP_FILE_WR;
> -
>         if ((have & need) == need) {
>                 /*
>                  * Look at (implemented & ~have & not) so that we keep waiting

Because if there's a pending truncate, we really can't write. You do
handle it in the particular case of doing buffered file writes, but
these caps are a marker of permission, and the client shouldn't have
write permission to a file until it's up to date on the truncates. Or
am I misunderstanding something?


> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index a1e5b81..bf7849a 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -653,7 +653,6 @@ static ssize_t ceph_aio_read(struct kiocb *iocb, const struct iovec *iov,
>         dout("aio_read %p %llx.%llx %llu~%u trying to get caps on %p\n",
>              inode, ceph_vinop(inode), pos, (unsigned)len, inode);
>  again:
> -       __ceph_do_pending_vmtruncate(inode);

There doesn't seem to be any kind of replacement for this? We need to
do any pending truncates before reading or we might get stale data
back.

The first two in the series look good to me, but I'll wait and pull
them in as a unit with this one once we're done discussing. :)
-Greg
