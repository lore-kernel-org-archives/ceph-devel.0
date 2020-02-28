From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: clean up kick_flushing_inode_caps
Date: Fri, 28 Feb 2020 10:25:47 -0500
Message-ID: <ad6cfb041532b91e85fb3a32650f2b2c25780a3c.camel@kernel.org>
References: <20200228141519.23406-1-jlayton@kernel.org>
         <CAOi1vP9tOKPFag9yYi65Lg-cni-QO=kixSBBFzQQ-DA64+zG=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgB1PZt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:25:49 -0500
In-Reply-To: <CAOi1vP9tOKPFag9yYi65Lg-cni-QO=kixSBBFzQQ-DA64+zG=w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>

On Fri, 2020-02-28 at 15:27 +0100, Ilya Dryomov wrote:
> On Fri, Feb 28, 2020 at 3:15 PM Jeff Layton <jlayton@kernel.org> wrote:
> > The last thing that this function does is release i_ceph_lock, so
> > have the caller do that instead. Add a lockdep assertion to
> > ensure that the function is always called with i_ceph_lock held.
> > Change the prototype to take a ceph_inode_info pointer and drop
> > the separate mdsc argument as we can get that from the session.
> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/ceph/caps.c | 23 +++++++++--------------
> >  1 file changed, 9 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index 9b3d5816c109..c02b63070e0a 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -2424,16 +2424,15 @@ void ceph_kick_flushing_caps(struct ceph_mds_client *mdsc,
> >         }
> >  }
> > 
> > -static void kick_flushing_inode_caps(struct ceph_mds_client *mdsc,
> > -                                    struct ceph_mds_session *session,
> > -                                    struct inode *inode)
> > -       __releases(ci->i_ceph_lock)
> > +static void kick_flushing_inode_caps(struct ceph_mds_session *session,
> > +                                    struct ceph_inode_info *ci)
> >  {
> > -       struct ceph_inode_info *ci = ceph_inode(inode);
> > -       struct ceph_cap *cap;
> > +       struct ceph_mds_client *mdsc = session->s_mdsc;
> > +       struct ceph_cap *cap = ci->i_auth_cap;
> > +
> > +       lockdep_assert_held(&ci->i_ceph_lock);
> > 
> > -       cap = ci->i_auth_cap;
> > -       dout("kick_flushing_inode_caps %p flushing %s\n", inode,
> > +       dout("%s %p flushing %s\n", __func__, &ci->vfs_inode,
> >              ceph_cap_string(ci->i_flushing_caps));
> > 
> >         if (!list_empty(&ci->i_cap_flush_list)) {
> > @@ -2445,9 +2444,6 @@ static void kick_flushing_inode_caps(struct ceph_mds_client *mdsc,
> >                 spin_unlock(&mdsc->cap_dirty_lock);
> > 
> >                 __kick_flushing_caps(mdsc, session, ci, oldest_flush_tid);
> > -               spin_unlock(&ci->i_ceph_lock);
> > -       } else {
> > -               spin_unlock(&ci->i_ceph_lock);
> >         }
> >  }
> > 
> > @@ -3326,11 +3322,10 @@ static void handle_cap_grant(struct inode *inode,
> >         if (le32_to_cpu(grant->op) == CEPH_CAP_OP_IMPORT) {
> >                 if (newcaps & ~extra_info->issued)
> >                         wake = true;
> > -               kick_flushing_inode_caps(session->s_mdsc, session, inode);
> > +               kick_flushing_inode_caps(session, ci);
> >                 up_read(&session->s_mdsc->snap_rwsem);
> > -       } else {
> > -               spin_unlock(&ci->i_ceph_lock);
> >         }
> > +       spin_unlock(&ci->i_ceph_lock);
> 
> Hi Jeff,
> 
> I would keep the else clause here and release i_ceph_lock before
> snap_rwsem for proper nesting.  Otherwise kudos on getting rid of
> another locking quirk!
> 
> Thanks,
> 
>                 Ilya

Meh, ok. I don't think the unlock order really matters much here, but
I'll make that change and push to testing.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
