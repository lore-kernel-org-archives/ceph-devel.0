From: Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] ceph: don't return -ESTALE if there's still an open file
Date: Fri, 15 May 2020 09:42:24 +0300
Message-ID: <CAOQ4uxhireZBRvcPQzTS8yOoO4gQt78M0ktZo-9yQ-zcaLZbow@mail.gmail.com>
References: <20200514111453.GA99187@suse.com> <8497fe9a11ac1837813ee5f14b6ebae8fa6bf707.camel@kernel.org>
 <20200514124845.GA12559@suse.com> <4e5bf0e3bf055e53a342b19d168f6cf441781973.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4e5bf0e3bf055e53a342b19d168f6cf441781973.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis Henriques <lhenriques@suse.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Dave Chinner <dchinner@redhat.com>, Christoph Hellwig <hch@lst.de>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: ceph-devel.vger.kernel.org

+CC: fstests

On Thu, May 14, 2020 at 4:15 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2020-05-14 at 13:48 +0100, Luis Henriques wrote:
> > On Thu, May 14, 2020 at 08:10:09AM -0400, Jeff Layton wrote:
> > > On Thu, 2020-05-14 at 12:14 +0100, Luis Henriques wrote:
> > > > Similarly to commit 03f219041fdb ("ceph: check i_nlink while converting
> > > > a file handle to dentry"), this fixes another corner case with
> > > > name_to_handle_at/open_by_handle_at.  The issue has been detected by
> > > > xfstest generic/467, when doing:
> > > >
> > > >  - name_to_handle_at("/cephfs/myfile")
> > > >  - open("/cephfs/myfile")
> > > >  - unlink("/cephfs/myfile")
> > > >  - open_by_handle_at()
> > > >
> > > > The call to open_by_handle_at should not fail because the file still
> > > > exists and we do have a valid handle to it.
> > > >
> > > > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > > > ---
> > > >  fs/ceph/export.c | 13 +++++++++++--
> > > >  1 file changed, 11 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/ceph/export.c b/fs/ceph/export.c
> > > > index 79dc06881e78..8556df9d94d0 100644
> > > > --- a/fs/ceph/export.c
> > > > +++ b/fs/ceph/export.c
> > > > @@ -171,12 +171,21 @@ struct inode *ceph_lookup_inode(struct super_block *sb, u64 ino)
> > > >
> > > >  static struct dentry *__fh_to_dentry(struct super_block *sb, u64 ino)
> > > >  {
> > > > + struct ceph_inode_info *ci;
> > > >   struct inode *inode = __lookup_inode(sb, ino);
> > > > +
> > > >   if (IS_ERR(inode))
> > > >           return ERR_CAST(inode);
> > > >   if (inode->i_nlink == 0) {
> > > > -         iput(inode);
> > > > -         return ERR_PTR(-ESTALE);
> > > > +         bool is_open;
> > > > +         ci = ceph_inode(inode);
> > > > +         spin_lock(&ci->i_ceph_lock);
> > > > +         is_open = __ceph_is_file_opened(ci);
> > > > +         spin_unlock(&ci->i_ceph_lock);
> > > > +         if (!is_open) {
> > > > +                 iput(inode);
> > > > +                 return ERR_PTR(-ESTALE);
> > > > +         }
> > > >   }
> > > >   return d_obtain_alias(inode);
> > > >  }
> > >
> > > Thanks Luis. Out of curiousity, is there any reason we shouldn't ignore
> > > the i_nlink value here? Does anything obviously break if we do?
> >
> > Yes, the scenario described in commit 03f219041fdb is still valid, which
> > is basically the same but without the extra open(2):
> >
> >   - name_to_handle_at("/cephfs/myfile")
> >   - unlink("/cephfs/myfile")
> >   - open_by_handle_at()
> >
>
> Ok, I guess we end up doing some delayed cleanup, and that allows the
> inode to be found in that situation.
>
> > The open_by_handle_at man page isn't really clear about these 2 scenarios,
> > but generic/426 will fail if -ESTALE isn't returned.  Want me to add a
> > comment to the code, describing these 2 scenarios?
> >
>
> (cc'ing Amir since he added this test)
>
> I don't think there is any hard requirement that open_by_handle_at
> should fail in that situation. It generally does for most filesystems
> due to the way they handle cl794798fa xfsqa: test open_by_handle() on unlinked and freed inode clusters
eaning up unlinked inodes, but I don't
> think it's technically illegal to allow the inode to still be found. If
> the caller cares about whether it has been unlinked it can always test
> i_nlink itself.
>
> Amir, is this required for some reason that I'm not aware of?

Hi Jeff,

The origin of this test is in fstests commit:
794798fa xfsqa: test open_by_handle() on unlinked and freed inode clusters

It was introduced to catch an xfs bug, so this behavior is the expectation
of xfs filesystem, but note that it is not a general expectation to fail
open_by_handle() after unlink(), it is an expectation to fail open_by_handle()
after unlink() + sync() + drop_caches.

I have later converted the test to generic, because I needed to check the
same expectation for overlayfs use case, which is:
The original inode is always there (in lower layer), unlink creates a whiteout
mark and open_by_handle should treat that as ESTALE, otherwise the
unlinked files would be accessible to nfs clients forever.

In overlayfs, we handle the open file case by returning a dentry only
in case the inode with deletion mark in question is already in inode cache,
but we take care not to populate inode cache with the check.
It is easier, because we do not need to get inode into cache for checking
the delete marker.

Maybe you could instead check in __fh_to_dentry():

    if (inode->i_nlink == 0 && atomic_read(&inode->i_count) == 1)) {
        iput(inode);
        return ERR_PTR(-ESTALE);
    }

The above is untested, so I don't know if it's enough to pass generic/426.
Note that generic/467 also checks the same behavior for rmdir().

If you decide that ceph does not need to comply to this behavior,
then we probably need to whitelist/blocklist the filesystems that
want to test this behavior, which will be a shame.

Thanks,
Amir.
