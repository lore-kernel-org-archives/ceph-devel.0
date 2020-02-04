From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v3 1/1] ceph: parallelize all copy-from requests in copy_file_range
Date: Tue, 4 Feb 2020 22:39:45 +0100
Message-ID: <CAOi1vP8bQ2tTkHw62FVyVXZ3H5iBhSuOv9CeMo_dYVmv0mqtSA@mail.gmail.com>
References: <20200203165117.5701-1-lhenriques@suse.com> <20200203165117.5701-2-lhenriques@suse.com>
 <0ab59ba87c07ffec6a05b2ed39bc0c112bcf5863.camel@kernel.org>
 <20200204153050.GA18215@suse.com> <0834b616a1c13570bffdf598034f09695362eb00.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0834b616a1c13570bffdf598034f09695362eb00.camel@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Luis Henriques <lhenriques@suse.com>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Feb 4, 2020 at 8:42 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Tue, 2020-02-04 at 15:30 +0000, Luis Henriques wrote:
> > On Tue, Feb 04, 2020 at 08:30:03AM -0500, Jeff Layton wrote:
> > > On Mon, 2020-02-03 at 16:51 +0000, Luis Henriques wrote:
> > > > Right now the copy_file_range syscall serializes all the OSDs 'copy-from'
> > > > operations, waiting for each request to complete before sending the next
> > > > one.  This patch modifies copy_file_range so that all the 'copy-from'
> > > > operations are sent in bulk and waits for its completion at the end.  This
> > > > will allow significant speed-ups, specially when sending requests for
> > > > different target OSDs.
> > > >
> > >
> > > Looks good overall. A few nits below:
> > >
> > > > Signed-off-by: Luis Henriques <lhenriques@suse.com>
> > > > ---
> > > >  fs/ceph/file.c                  | 45 +++++++++++++++++++++-----
> > > >  include/linux/ceph/osd_client.h |  6 +++-
> > > >  net/ceph/osd_client.c           | 56 +++++++++++++++++++++++++--------
> > > >  3 files changed, 85 insertions(+), 22 deletions(-)
> > > >
> > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > index 1e6cdf2dfe90..b9d8ffafb8c5 100644
> > > > --- a/fs/ceph/file.c
> > > > +++ b/fs/ceph/file.c
> > > > @@ -1943,12 +1943,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > > >   struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
> > > >   struct ceph_object_locator src_oloc, dst_oloc;
> > > >   struct ceph_object_id src_oid, dst_oid;
> > > > + struct ceph_osd_request *req;
> > > >   loff_t endoff = 0, size;
> > > >   ssize_t ret = -EIO;
> > > >   u64 src_objnum, dst_objnum, src_objoff, dst_objoff;
> > > >   u32 src_objlen, dst_objlen, object_size;
> > > >   int src_got = 0, dst_got = 0, err, dirty;
> > > > + unsigned int max_copies, copy_count, reqs_complete = 0;
> > > >   bool do_final_copy = false;
> > > > + LIST_HEAD(osd_reqs);
> > > >
> > > >   if (src_inode->i_sb != dst_inode->i_sb) {
> > > >           struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
> > > > @@ -2083,6 +2086,13 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
> > > >                   goto out_caps;
> > > >   }
> > > >   object_size = src_ci->i_layout.object_size;
> > > > +
> > > > + /*
> > > > +  * Throttle the object copies: max_copies holds the number of allowed
> > > > +  * in-flight 'copy-from' requests before waiting for their completion
> > > > +  */
> > > > + max_copies = (src_fsc->mount_options->wsize / object_size) * 4;
> > >
> > > A note about why you chose to multiply by a factor of 4 here would be
> > > good. In another year or two, we won't remember.
> >
> > Sure, but to be honest I just picked an early suggestion from Ilya :-)
> > In practice it means that, by default, 64 will be the maximum requests
> > in-flight.  I tested this value, and it looked OK although in the (very
> > humble) test cluster I've used a value of 16 (i.e. dropping the factor of
> > 4) wasn't much worst.
> >
>
> What happens if you ramp it up to be even more greedy? Does that speed
> things up? It might be worth doing some experimentation with a tunable
> too?
>
> In any case though, we need to consider what the ideal default would be.
> I'm now wondering whether the wsize is the right thing to base this on.
> If you have a 1000 OSD cluster, then even 64 actually sounds a bit weak.
>
> I wonder whether it should it be calculated on the fly from some
> function of the number OSDs or PGs in the data pool? Maybe even
> something like:
>
>     (number of PGs) / 2

That can easily generate thousands of in-flight requests...

The OSD cluster may serve more than one filesystem, each of which may
serve more than one user.  Zooming out, it's pretty common to have the
same cluster provide both block and file storage.  Allowing a single
process to overrun the entire cluster is a bad idea, especially when
it is something as routine as cp.

I suggested that factor be between 1 and 4.  My suggestion was based
on BLKDEV_MAX_RQ (128): anything above that is just unreasonable for
a single syscall and it needs to be cut by at least half because there
is no actual queue to limit the overall number of in-flight requests
for the filesystem.

Thanks,

                Ilya
