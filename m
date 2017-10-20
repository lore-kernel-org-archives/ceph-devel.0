From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: unlock dangling spinlock in try_flush_caps
Date: Fri, 20 Oct 2017 11:25:37 +0200
Message-ID: <CAOi1vP9SQ+Yk1au2ySFUvL+n1KYnquOE2DqVN4PjoesH=1Ghug@mail.gmail.com>
References: <20171019125258.19821-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:52479 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdJTJZi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Oct 2017 05:25:38 -0400
Received: by mail-it0-f67.google.com with SMTP id j140so12774063itj.1
        for <ceph-devel@vger.kernel.org>; Fri, 20 Oct 2017 02:25:38 -0700 (PDT)
In-Reply-To: <20171019125258.19821-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Oct 19, 2017 at 2:52 PM, Jeff Layton <jlayton@kernel.org> wrote:
> From: Jeff Layton <jlayton@redhat.com>
>
> sparose warns:
>     fs/ceph/caps.c:2042:9: warning: context imbalance in 'try_flush_caps' - wrong count at exit
>
> We need to exit this function with the lock unlocked, but a couple of
> cases leave it locked.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> ---
>  fs/ceph/caps.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 157fe59fbabe..1978a8cb1cb1 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1991,6 +1991,7 @@ static int try_flush_caps(struct inode *inode, u64 *ptid)
>  retry:
>         spin_lock(&ci->i_ceph_lock);
>         if (ci->i_ceph_flags & CEPH_I_NOFLUSH) {
> +               spin_unlock(&ci->i_ceph_lock);
>                 dout("try_flush_caps skipping %p I_NOFLUSH set\n", inode);
>                 goto out;
>         }
> @@ -2008,8 +2009,10 @@ static int try_flush_caps(struct inode *inode, u64 *ptid)
>                         mutex_lock(&session->s_mutex);
>                         goto retry;
>                 }
> -               if (cap->session->s_state < CEPH_MDS_SESSION_OPEN)
> +               if (cap->session->s_state < CEPH_MDS_SESSION_OPEN) {
> +                       spin_unlock(&ci->i_ceph_lock);
>                         goto out;
> +               }
>
>                 flushing = __mark_caps_flushing(inode, session, true,
>                                                 &flush_tid, &oldest_flush_tid);

Applied.

Thanks,

                Ilya
