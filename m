From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH v2 07/10] ceph: add infrastructure for waiting for
 async create to complete
Date: Fri, 17 Jan 2020 11:49:03 -0500
Message-ID: <590764dd204371067d245a4260531c623bdaff84.camel@kernel.org>
References: <20200115205912.38688-1-jlayton@kernel.org>
         <20200115205912.38688-8-jlayton@kernel.org>
         <CAOi1vP9BgADrLJtsJj-MvxUexSeexfUVXtm3S2xL5nfvBkAs7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgAQQtG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:49:06 -0500
In-Reply-To: <CAOi1vP9BgADrLJtsJj-MvxUexSeexfUVXtm3S2xL5nfvBkAs7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Xiubo Li <xiubli@redhat.com>

On Fri, 2020-01-17 at 16:00 +0100, Ilya Dryomov wrote:
> On Wed, Jan 15, 2020 at 9:59 PM Jeff Layton <jlayton@kernel.org> wrote:
> > When we issue an async create, we must ensure that any later on-the-wire
> > requests involving it wait for the create reply.
> > 
> > Expand i_ceph_flags to be an unsigned long, and add a new bit that
> > MDS requests can wait on. If the bit is set in the inode when sending
> > caps, then don't send it and just return that it has been delayed.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/caps.c       |  9 ++++++++-
> >  fs/ceph/dir.c        |  2 +-
> >  fs/ceph/mds_client.c | 12 +++++++++++-
> >  fs/ceph/super.h      |  4 +++-
> >  4 files changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index c983990acb75..9d1a3d6831f7 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -511,7 +511,7 @@ static void __cap_delay_requeue(struct ceph_mds_client *mdsc,
> >                                 struct ceph_inode_info *ci,
> >                                 bool set_timeout)
> >  {
> > -       dout("__cap_delay_requeue %p flags %d at %lu\n", &ci->vfs_inode,
> > +       dout("__cap_delay_requeue %p flags 0x%lx at %lu\n", &ci->vfs_inode,
> >              ci->i_ceph_flags, ci->i_hold_caps_max);
> >         if (!mdsc->stopping) {
> >                 spin_lock(&mdsc->cap_delay_lock);
> > @@ -1298,6 +1298,13 @@ static int __send_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
> >         int delayed = 0;
> >         int ret;
> > 
> > +       /* Don't send anything if it's still being created. Return delayed */
> > +       if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
> > +               spin_unlock(&ci->i_ceph_lock);
> > +               dout("%s async create in flight for %p\n", __func__, inode);
> > +               return 1;
> > +       }
> > +
> >         held = cap->issued | cap->implemented;
> >         revoking = cap->implemented & ~cap->issued;
> >         retain &= ~revoking;
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index 0d97c2962314..b2bcd01ab4e9 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -752,7 +752,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
> >                 struct ceph_dentry_info *di = ceph_dentry(dentry);
> > 
> >                 spin_lock(&ci->i_ceph_lock);
> > -               dout(" dir %p flags are %d\n", dir, ci->i_ceph_flags);
> > +               dout(" dir %p flags are 0x%lx\n", dir, ci->i_ceph_flags);
> >                 if (strncmp(dentry->d_name.name,
> >                             fsc->mount_options->snapdir_name,
> >                             dentry->d_name.len) &&
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index f06496bb5705..e49ca0533df1 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2806,14 +2806,24 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
> >         }
> >  }
> > 
> > +static int ceph_wait_on_async_create(struct inode *inode)
> > +{
> > +       struct ceph_inode_info *ci = ceph_inode(inode);
> > +
> > +       return wait_on_bit(&ci->i_ceph_flags, CEPH_ASYNC_CREATE_BIT,
> > +                          TASK_INTERRUPTIBLE);
> > +}
> > +
> >  int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
> >                               struct ceph_mds_request *req)
> >  {
> >         int err;
> > 
> >         /* take CAP_PIN refs for r_inode, r_parent, r_old_dentry */
> > -       if (req->r_inode)
> > +       if (req->r_inode) {
> > +               ceph_wait_on_async_create(req->r_inode);
> 
> This is waiting interruptibly, but ignoring the distinction between
> CEPH_ASYNC_CREATE_BIT getting cleared and a signal.  Do we care?  If
> not, it deserves a comment (or should ceph_wait_on_async_create() be
> void?).
> 

You're absolutely right -- we do need to catch and handle signals here,
I think. I'll fix that for the next version.

-- 
Jeff Layton <jlayton@kernel.org>
