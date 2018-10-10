From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: only allow punch hole mode in fallocate
Date: Wed, 10 Oct 2018 12:43:40 +0200
Message-ID: <CAOi1vP_HmqS3xgAdYSpQYhRg-2q6mhHEaRpQW2+-UyJs9K1UsQ@mail.gmail.com>
References: <20181009175428.18543-1-lhenriques@suse.com> <CAAM7YAno0s5Z21jagvnFbQdkkwMOYadZG9trPvs4WKZLRLkLxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAM7YAno0s5Z21jagvnFbQdkkwMOYadZG9trPvs4WKZLRLkLxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Luis Henriques <lhenriques@suse.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, Oct 10, 2018 at 6:21 AM Yan, Zheng <ukernel@gmail.com> wrote:
>
> On Wed, Oct 10, 2018 at 1:54 AM Luis Henriques <lhenriques@suse.com> wrote:
> >
> > Current implementation of cephfs fallocate isn't correct as it doesn't
> > really reserve the space in the cluster, which means that a subsequent
> > call to a write may actually fail due to lack of space.  In fact, it is
> > currently possible to fallocate an amount space that is larger than the
> > free space in the cluster.
> >
> > Since there's no easy solution to fix this at the moment, this patch
> > simply removes support for all fallocate operations but
> > FALLOC_FL_PUNCH_HOLE (which implies FALLOC_FL_KEEP_SIZE).
> >
> > Link: https://tracker.ceph.com/issues/36317
> > Cc: stable@vger.kernel.org
> > Fixes: ad7a60de882a ("ceph: punch hole support")
> > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > ---
> >  fs/ceph/file.c | 45 +++++++++------------------------------------
> >  1 file changed, 9 insertions(+), 36 deletions(-)
> >
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 92ab20433682..91a7ad259bcf 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -1735,7 +1735,6 @@ static long ceph_fallocate(struct file *file, int mode,
> >         struct ceph_file_info *fi = file->private_data;
> >         struct inode *inode = file_inode(file);
> >         struct ceph_inode_info *ci = ceph_inode(inode);
> > -       struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
> >         struct ceph_cap_flush *prealloc_cf;
> >         int want, got = 0;
> >         int dirty;
> > @@ -1743,10 +1742,7 @@ static long ceph_fallocate(struct file *file, int mode,
> >         loff_t endoff = 0;
> >         loff_t size;
> >
> > -       if ((offset + length) > max(i_size_read(inode), fsc->max_file_size))
> > -               return -EFBIG;
> > -
> > -       if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> > +       if (mode != (FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
> >                 return -EOPNOTSUPP;
> >
> >         if (!S_ISREG(inode->i_mode))
> > @@ -1763,18 +1759,6 @@ static long ceph_fallocate(struct file *file, int mode,
> >                 goto unlock;
> >         }
> >
> > -       if (!(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)) &&
> > -           ceph_quota_is_max_bytes_exceeded(inode, offset + length)) {
> > -               ret = -EDQUOT;
> > -               goto unlock;
> > -       }
> > -
> > -       if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_FULL) &&
> > -           !(mode & FALLOC_FL_PUNCH_HOLE)) {
> > -               ret = -ENOSPC;
> > -               goto unlock;
> > -       }
> > -
> >         if (ci->i_inline_version != CEPH_INLINE_NONE) {
> >                 ret = ceph_uninline_data(file, NULL);
> >                 if (ret < 0)
> > @@ -1782,12 +1766,12 @@ static long ceph_fallocate(struct file *file, int mode,
> >         }
> >
> >         size = i_size_read(inode);
> > -       if (!(mode & FALLOC_FL_KEEP_SIZE)) {
> > -               endoff = offset + length;
> > -               ret = inode_newsize_ok(inode, endoff);
> > -               if (ret)
> > -                       goto unlock;
> > -       }
> > +
> > +       /* Are we punching a hole beyond EOF? */
> > +       if (offset >= size)
> > +               goto unlock;
> > +       if ((offset + length) > size)
> > +               length = size - offset;
> >
> >         if (fi->fmode & CEPH_FILE_MODE_LAZY)
> >                 want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
> > @@ -1798,16 +1782,8 @@ static long ceph_fallocate(struct file *file, int mode,
> >         if (ret < 0)
> >                 goto unlock;
> >
> > -       if (mode & FALLOC_FL_PUNCH_HOLE) {
> > -               if (offset < size)
> > -                       ceph_zero_pagecache_range(inode, offset, length);
> > -               ret = ceph_zero_objects(inode, offset, length);
> > -       } else if (endoff > size) {
> > -               truncate_pagecache_range(inode, size, -1);
> > -               if (ceph_inode_set_size(inode, endoff))
> > -                       ceph_check_caps(ceph_inode(inode),
> > -                               CHECK_CAPS_AUTHONLY, NULL);
> > -       }
> > +       ceph_zero_pagecache_range(inode, offset, length);
> > +       ret = ceph_zero_objects(inode, offset, length);
> >
> >         if (!ret) {
> >                 spin_lock(&ci->i_ceph_lock);
> > @@ -1817,9 +1793,6 @@ static long ceph_fallocate(struct file *file, int mode,
> >                 spin_unlock(&ci->i_ceph_lock);
> >                 if (dirty)
> >                         __mark_inode_dirty(inode, dirty);
> > -               if ((endoff > size) &&
> > -                   ceph_quota_is_max_bytes_approaching(inode, endoff))
> > -                       ceph_check_caps(ci, CHECK_CAPS_NODELAY, NULL);
> >         }
> >
> >         ceph_put_cap_refs(ci, got);
>
> Applied, thanks

I don't think it should go to stable kernels.  Strictly speaking it's
a behaviour change -- it's been this way for many years and, unless you
are close to ENOSPC, it's sort of appears to work.  I'll take off the
stable tag unless I hear objections.

Thanks,

                Ilya
