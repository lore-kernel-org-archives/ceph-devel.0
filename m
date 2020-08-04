From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: set sec_context xattr on symlink creation
Date: Tue, 4 Aug 2020 15:51:36 +0200
Message-ID: <CAOi1vP8TVSevrxroboVwjfaVP+KUZSOiVAHcMDZ_6C=zVHy6iw@mail.gmail.com>
References: <20200728191838.315530-1-jlayton@kernel.org> <CAOi1vP8PKN2ojoEkrmB4+rDoO0WKoo07oB_wRRBK8h6RE=p=bg@mail.gmail.com>
 <8e1ca822212f35c3db669d84afb4bd3debe1d7a1.camel@kernel.org> <32c196a970c4ec6d0ddf2609c4280db403d6fefa.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDNvg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2020 09:51:36 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D5DC06174A
        for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2020 06:51:36 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g19so30180017ioh.8
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2020 06:51:36 -0700 (PDT)
In-Reply-To: <32c196a970c4ec6d0ddf2609c4280db403d6fefa.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 4, 2020 at 2:29 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Mon, 2020-08-03 at 06:41 -0400, Jeff Layton wrote:
> > On Mon, 2020-08-03 at 11:33 +0200, Ilya Dryomov wrote:
> > > On Tue, Jul 28, 2020 at 10:04 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > Symlink inodes should have the security context set in their xattrs on
> > > > creation. We already set the context on creation, but we don't attach
> > > > the pagelist. Make it do so.
> > > >
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > >  fs/ceph/dir.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > > > index 39f5311404b0..060bdcc5ce32 100644
> > > > --- a/fs/ceph/dir.c
> > > > +++ b/fs/ceph/dir.c
> > > > @@ -930,6 +930,10 @@ static int ceph_symlink(struct inode *dir, struct dentry *dentry,
> > > >         req->r_num_caps = 2;
> > > >         req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL;
> > > >         req->r_dentry_unless = CEPH_CAP_FILE_EXCL;
> > > > +       if (as_ctx.pagelist) {
> > > > +               req->r_pagelist = as_ctx.pagelist;
> > > > +               as_ctx.pagelist = NULL;
> > > > +       }
> > > >         err = ceph_mdsc_do_request(mdsc, dir, req);
> > > >         if (!err && !req->r_reply_info.head->is_dentry)
> > > >                 err = ceph_handle_notrace_create(dir, dentry);
> > >
> > > What is the side effect?  Should this go to stable?
> > >
> >
> > The effect is that symlink inodes don't get an SELinux context set on
> > them at creation, so they end up unlabeled instead of inheriting the
> > proper context. As to the severity, it really depends on what ends up
> > being unlabeled.
> >
> > It's probably harmless enough to put this into stable, but I only
> > noticed it by inspection, so I'm not sure it meets the "it must fix a
> > real bug that bothers people" criterion.
>
> After thinking about it some more, let's do go ahead and mark this for
> stable. While no one has complained about it, it's a subtle bug that
> could be problematic once people start populating cephfs trees with
> unlabeled symlinks. Better that we fix it early before SELinux support
> becomes even more widespread.
>
> Ilya, can you add the Cc: stable tag before you send a PR to Linus?

Sure, will do.

Thanks,

                Ilya
