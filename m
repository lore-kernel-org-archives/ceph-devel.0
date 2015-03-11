From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] ceph: match wait_for_completion_timeout return type
Date: Wed, 11 Mar 2015 12:04:10 +0100
Message-ID: <20150311110410.GA21968@opentech.at>
References: <1426000695-348-1-git-send-email-hofrat@osadl.org> <CAAM7YAkBFn06EziJcwf-Fg4K7PNK1KdVdE5p_4r4ToBfvtwBug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAM7YAkBFn06EziJcwf-Fg4K7PNK1KdVdE5p_4r4ToBfvtwBug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Wed, 11 Mar 2015, Yan, Zheng wrote:

> On Tue, Mar 10, 2015 at 11:18 PM, Nicholas Mc Guire <hofrat@osadl.org> wrote:
> > return type of wait_for_completion_timeout is unsigned long not int. An
> > appropriately named unsigned long is added and the assignment fixed up.
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> >
> > This was only compile tested for x86_64_defconfig + CONFIG_CEPH_FS=m
> >
> > Patch is against 4.0-rc2 linux-next (localversion-next is -next-20150306)
> >
> >  fs/ceph/dir.c |    7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> > index 83e9976..4bee6b7 100644
> > --- a/fs/ceph/dir.c
> > +++ b/fs/ceph/dir.c
> > @@ -1218,6 +1218,7 @@ static int ceph_dir_fsync(struct file *file, loff_t start, loff_t end,
> >         struct ceph_mds_request *req;
> >         u64 last_tid;
> >         int ret = 0;
> > +       unsigned long time_left;
> >
> >         dout("dir_fsync %p\n", inode);
> >         ret = filemap_write_and_wait_range(inode->i_mapping, start, end);
> > @@ -1240,11 +1241,11 @@ static int ceph_dir_fsync(struct file *file, loff_t start, loff_t end,
> >                 dout("dir_fsync %p wait on tid %llu (until %llu)\n",
> >                      inode, req->r_tid, last_tid);
> >                 if (req->r_timeout) {
> > -                       ret = wait_for_completion_timeout(
> > +                       time_left = wait_for_completion_timeout(
> >                                 &req->r_safe_completion, req->r_timeout);
> > -                       if (ret > 0)
> > +                       if (time_left > 0)
> >                                 ret = 0;
> > -                       else if (ret == 0)
> > +                       else if (!time_left)
> >                                 ret = -EIO;  /* timed out */
> >                 } else {
> >                         wait_for_completion(&req->r_safe_completion);
> 
> There are lots of similar codes in kernel. I don't think this code
> causes problem in reality
>
true - there are 38 (of the initial 81 files) left for which no patch has been 
submitted yet - its cleanup in progress.

type correctness I do believe is an issue and code readability as well
so both fixing the type and that name is relevant.

As Wolfram Sang <wsa@the-dreams.de> put it:
<snip>
 'ret' being an int is kind of an idiom, so I'd rather see the variable
 renamed, too, like the other patches do.
<snip>
[http://lkml.iu.edu/hypermail/linux/kernel/1502.1/00084.html]

regarding causing problems - it is hard to say - type missmatch
may go without problems for a long time and then pop up in strange
corner cases. But you are right that it is not fixing any currently
inown incorrect behavior.

The motivation for cleaning this up is also to make static code checkers
happy which eases scanning for incorrect API usage and general bug-hunting,

thx!
hofrat
