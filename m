From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH v3 03/10] ceph: make dentry_lease_is_valid non-static
Date: Wed, 22 Jan 2020 06:26:06 -0500
Message-ID: <798bc25f72341b77cda2c83690877e4ef4ad42fe.camel@kernel.org>
References: <20200121192928.469316-1-jlayton@kernel.org>
         <20200121192928.469316-4-jlayton@kernel.org>
         <CAAM7YAkL2fOgmxSatHreHjveZmzXd9o3ZsfhCW4C18x1He0eAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgAVL0J (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:26:09 -0500
In-Reply-To: <CAAM7YAkL2fOgmxSatHreHjveZmzXd9o3ZsfhCW4C18x1He0eAg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, idridryomov@gmail.com, Sage Weil <sage@redhat.com>, Zheng Yan <zyan@redhat.com>

On Wed, 2020-01-22 at 15:20 +0800, Yan, Zheng wrote:
> On Wed, Jan 22, 2020 at 3:31 AM Jeff Layton <jlayton@kernel.org> wrote:
> > ...and move a comment over the proper function.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/dir.c   | 10 +++++-----
> >  fs/ceph/super.h |  1 +
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index 10294f07f5f0..9d2eca67985a 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -1477,10 +1477,6 @@ void ceph_invalidate_dentry_lease(struct dentry *dentry)
> >         spin_unlock(&dentry->d_lock);
> >  }
> > 
> > -/*
> > - * Check if dentry lease is valid.  If not, delete the lease.  Try to
> > - * renew if the least is more than half up.
> > - */
> >  static bool __dentry_lease_is_valid(struct ceph_dentry_info *di)
> >  {
> >         struct ceph_mds_session *session;
> > @@ -1507,7 +1503,11 @@ static bool __dentry_lease_is_valid(struct ceph_dentry_info *di)
> >         return false;
> >  }
> > 
> > -static int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags)
> > +/*
> > + * Check if dentry lease is valid.  If not, delete the lease.  Try to
> > + * renew if the least is more than half up.
> > + */
> > +int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags)
> >  {
> >         struct ceph_dentry_info *di;
> >         struct ceph_mds_session *session = NULL;
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index ec4d66d7c261..f27b2bf9a3f5 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -1121,6 +1121,7 @@ extern int ceph_handle_snapdir(struct ceph_mds_request *req,
> >  extern struct dentry *ceph_finish_lookup(struct ceph_mds_request *req,
> >                                          struct dentry *dentry, int err);
> > 
> > +extern int dentry_lease_is_valid(struct dentry *dentry, unsigned int flags);
> >  extern void __ceph_dentry_lease_touch(struct ceph_dentry_info *di);
> >  extern void __ceph_dentry_dir_lease_touch(struct ceph_dentry_info *di);
> >  extern void ceph_invalidate_dentry_lease(struct dentry *dentry);
> > --
> > 2.24.1
> > 
> 
> This change is not needed

Quite right. I had done this for an earlier version of the series, but
I'll drop this now.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
