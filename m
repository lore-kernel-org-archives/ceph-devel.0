From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH 2/2] ceph: pagecache writeback fault injection switch
Date: Mon, 31 Jul 2017 08:11:47 -0400
Message-ID: <1501503107.4663.8.camel@redhat.com>
References: <20170725145042.26219-1-jlayton@kernel.org>
         <20170725145042.26219-3-jlayton@kernel.org>
         <CAAM7YAmqkr5Ty-Nvzmtfz_D19iR-aHE-dEcUf5BNoBhBx6K4kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAmqkr5Ty-Nvzmtfz_D19iR-aHE-dEcUf5BNoBhBx6K4kg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>, Jeff Layton <jlayton@kernel.org>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, 2017-07-26 at 21:08 +0800, Yan, Zheng wrote:
> On Tue, Jul 25, 2017 at 10:50 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > From: Jeff Layton <jlayton@redhat.com>
> > 
> > Testing ceph for proper writeback error handling turns out to be quite
> > difficult. I tried using iptables to block traffic but that didn't
> > give reliable results.
> > 
> > I hacked in this wb_fault switch that makes the filesystem pretend that
> > writeback failed, even when it succeeds. With this, I could verify that
> > cephfs fsync error reporting does work properly.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> >  fs/ceph/addr.c    | 7 +++++++
> >  fs/ceph/debugfs.c | 8 +++++++-
> >  fs/ceph/super.h   | 2 ++
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 50836280a6f8..a3831d100e16 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -584,6 +584,10 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
> >                                    page_off, len,
> >                                    truncate_seq, truncate_size,
> >                                    &inode->i_mtime, &page, 1);
> > +
> > +       if (fsc->wb_fault && err >= 0)
> > +               err = -EIO;
> > +
> >         if (err < 0) {
> >                 struct writeback_control tmp_wbc;
> >                 if (!wbc)
> > @@ -666,6 +670,9 @@ static void writepages_finish(struct ceph_osd_request *req)
> >         struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
> >         bool remove_page;
> > 
> > +       if (fsc->wb_fault && rc >= 0)
> > +               rc = -EIO;
> > +
> >         dout("writepages_finish %p rc %d\n", inode, rc);
> >         if (rc < 0) {
> >                 mapping_set_error(mapping, rc);
> > diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
> > index 4e2d112c982f..e1e6eaa12031 100644
> > --- a/fs/ceph/debugfs.c
> > +++ b/fs/ceph/debugfs.c
> > @@ -197,7 +197,6 @@ CEPH_DEFINE_SHOW_FUNC(caps_show)
> >  CEPH_DEFINE_SHOW_FUNC(dentry_lru_show)
> >  CEPH_DEFINE_SHOW_FUNC(mds_sessions_show)
> > 
> > -
> >  /*
> >   * debugfs
> >   */
> > @@ -231,6 +230,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
> >         debugfs_remove(fsc->debugfs_caps);
> >         debugfs_remove(fsc->debugfs_mdsc);
> >         debugfs_remove(fsc->debugfs_dentry_lru);
> > +       debugfs_remove(fsc->debugfs_wb_fault);
> >  }
> > 
> >  int ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
> > @@ -298,6 +298,12 @@ int ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
> >         if (!fsc->debugfs_dentry_lru)
> >                 goto out;
> > 
> > +       fsc->debugfs_wb_fault = debugfs_create_bool("wb_fault",
> > +                                       0600, fsc->client->debugfs_dir,
> > +                                       &fsc->wb_fault);
> > +       if (!fsc->debugfs_wb_fault)
> > +               goto out;
> > +
> >         return 0;
> > 
> >  out:
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index f02a2225fe42..a38fd6203b77 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -84,6 +84,7 @@ struct ceph_fs_client {
> > 
> >         unsigned long mount_state;
> >         int min_caps;                  /* min caps i added */
> > +       bool wb_fault;
> > 
> >         struct ceph_mds_client *mdsc;
> > 
> > @@ -100,6 +101,7 @@ struct ceph_fs_client {
> >         struct dentry *debugfs_bdi;
> >         struct dentry *debugfs_mdsc, *debugfs_mdsmap;
> >         struct dentry *debugfs_mds_sessions;
> > +       struct dentry *debugfs_wb_fault;
> >  #endif
> > 
> 
> I think it's better not to enable this feature by default. Enabling it
> by compilation option or mount option?
> 
> Regards
> Yan, Zheng

Yes, it probably should be.

I really should have sent this as an RFC patch. I mostly did it to
document how patch 1/2 was tested. I'm not at all convinced this is a
great idea, though. I'm fine with just dropping this patch for now until
we have some time to consider it more. Maybe it would be better to hack
something into the OSDs for this?

I think if we did want to start adding fault injection knobs, then we'll
probably want to allow other tunables to be added simply. Maybe put them
in a "fault" subdir under the per-fsc debugfs dir?
-- 
Jeff Layton <jlayton@redhat.com>
