From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 1/2] ceph: have ceph_mdsc_free_path ignore ERR_PTR values
Date: Mon, 13 Apr 2020 17:48:13 +0200
Message-ID: <CAOi1vP_xUUUPQd=x9rg9KgEz85SHy-9Yurcmvt2iehfhi5ztNQ@mail.gmail.com>
References: <20200408142125.52908-1-jlayton@kernel.org> <20200408142125.52908-2-jlayton@kernel.org>
 <CAOi1vP99BbHFrrg+0HAbZrZV7DQ7EG7euTY6cbtdWajsdyN3jQ@mail.gmail.com>
 <ded1b71dcda70e3a249df21c294607dac6545694.camel@kernel.org>
 <CAOi1vP9mZTShECrVVohuj4p=Yr+rWvWnXNY03c85CuO4fGNSyQ@mail.gmail.com> <55c47d66b579fcf5749376c73d681d0273095f6d.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbgDMPsV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Apr 2020 11:48:21 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A64C0A3BDC
        for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2020 08:48:21 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t11so8903466ils.1
        for <ceph-devel@vger.kernel.org>; Mon, 13 Apr 2020 08:48:20 -0700 (PDT)
In-Reply-To: <55c47d66b579fcf5749376c73d681d0273095f6d.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Sage Weil <sage@redhat.com>

On Mon, Apr 13, 2020 at 3:23 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Mon, 2020-04-13 at 14:35 +0200, Ilya Dryomov wrote:
> > On Mon, Apr 13, 2020 at 1:15 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > On Mon, 2020-04-13 at 10:09 +0200, Ilya Dryomov wrote:
> > > > On Wed, Apr 8, 2020 at 4:21 PM Jeff Layton <jlayton@kernel.org> wrote:
> > > > > This makes the error handling simpler in some callers, and fixes a
> > > > > couple of bugs in the new async dirops callback code.
> > > > >
> > > > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  fs/ceph/debugfs.c    | 4 ----
> > > > >  fs/ceph/mds_client.c | 6 ++----
> > > > >  fs/ceph/mds_client.h | 2 +-
> > > > >  3 files changed, 3 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> > > > > index eebbce7c3b0c..3a198e40f100 100644
> > > > > --- a/fs/ceph/debugfs.c
> > > > > +++ b/fs/ceph/debugfs.c
> > > > > @@ -83,8 +83,6 @@ static int mdsc_show(struct seq_file *s, void *p)
> > > > >                 } else if (req->r_dentry) {
> > > > >                         path = ceph_mdsc_build_path(req->r_dentry, &pathlen,
> > > > >                                                     &pathbase, 0);
> > > > > -                       if (IS_ERR(path))
> > > > > -                               path = NULL;
> > > > >                         spin_lock(&req->r_dentry->d_lock);
> > > > >                         seq_printf(s, " #%llx/%pd (%s)",
> > > >
> > > > Hi Jeff,
> > > >
> > > > This ends up attempting to print an IS_ERR pointer as %s.
> > > >
> > > > >                                    ceph_ino(d_inode(req->r_dentry->d_parent)),
> > > > > @@ -102,8 +100,6 @@ static int mdsc_show(struct seq_file *s, void *p)
> > > > >                 if (req->r_old_dentry) {
> > > > >                         path = ceph_mdsc_build_path(req->r_old_dentry, &pathlen,
> > > > >                                                     &pathbase, 0);
> > > > > -                       if (IS_ERR(path))
> > > > > -                               path = NULL;
> > > > >                         spin_lock(&req->r_old_dentry->d_lock);
> > > > >                         seq_printf(s, " #%llx/%pd (%s)",
> > > >
> > > > Ditto.
> > > >
> > > > It looks like in newer kernels printf copes with this and outputs
> > > > "(efault)".  But anything older than 5.2 will crash.
> > > >
> > > > Further, the code looks weird because ceph_mdsc_build_path() doesn't
> > > > return NULL, but path is tested for NULL in the call to seq_printf().
> > > >
> > > > Why not just follow the same approach as existing mdsc_show()?  It
> > > > makes it clear that the error is handled and where the NULL pointer
> > > > comes from.  This kind of "don't handle errors and rely on everything
> > > > else being able to bail" approach is very fragile and hard to audit.
> > > >
> > >
> > > I don't see a problem with having a "free" routine ignore IS_ERR values
> > > just like it does NULL values. How about I just trim off the other
> > > deltas in this patch? Something like this?
> >
> > I think it encourages fragile code.  Less so than functions that
> > return pointer, NULL or IS_ERR pointer, but still.  You yourself
> > almost fell into one of these traps while editing debugfs.c ;)
> >
>
> We'll have to agree to disagree here. Having a free routine ignore
> ERR_PTR values seems perfectly reasonable to me.
>
> > That said, I won't stand in the way here.  If you trim off everything
> > else, merge it together with the other patch so that it is introduced
> > along with the two users.
> >
>
> Do you mean that I should merge it with this?
>
>     ceph: initialize base and pathlen variables in async dirops cb's
>
> I'm not sure I see the point in that.

Yes, because ultimately this is all about those two pr_warn messages.
path is built just to be printed, base and pathlen are a part of that.
ceph_mdsc_free_path() didn't need to handle IS_ERR pointers before so
it should be a single patch.

Thanks,

                Ilya
