From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: set sec_context xattr on symlink creation
Date: Mon, 3 Aug 2020 11:33:21 +0200
Message-ID: <CAOi1vP8PKN2ojoEkrmB4+rDoO0WKoo07oB_wRRBK8h6RE=p=bg@mail.gmail.com>
References: <20200728191838.315530-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHCJdV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2020 05:33:21 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A83C06174A
        for <ceph-devel@vger.kernel.org>; Mon,  3 Aug 2020 02:33:21 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id g19so25765531ioh.8
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2020 02:33:21 -0700 (PDT)
In-Reply-To: <20200728191838.315530-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Jul 28, 2020 at 10:04 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> Symlink inodes should have the security context set in their xattrs on
> creation. We already set the context on creation, but we don't attach
> the pagelist. Make it do so.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/dir.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 39f5311404b0..060bdcc5ce32 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -930,6 +930,10 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
>         req->r_num_caps = 2;
>         req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
>         req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
> +       if (as_ctx.pagelist) {
> +               req->r_pagelist = as_ctx.pagelist;
> +               as_ctx.pagelist = NULL;
> +       }
>         err = ceph_mdsc_do_request(mdsc, dir, req);
>         if (!err && !req->r_reply_info.head->is_dentry)
>                 err = ceph_handle_notrace_create(dir, dentry);

What is the side effect?  Should this go to stable?

Thanks,

                Ilya
