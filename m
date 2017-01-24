From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v2] ceph/iov_iter: fix bad iov_iter handling in ceph
 splice codepaths
Date: Tue, 24 Jan 2017 10:00:30 -0500
Message-ID: <1485270030.3143.14.camel@redhat.com>
References: <1483727016-343-1-git-send-email-jlayton@redhat.com>
         <1484053051-23685-1-git-send-email-jlayton@redhat.com>
         <20170112075946.GU1555@ZenIV.linux.org.uk>
         <1484220421.2970.20.camel@redhat.com>
         <CAOi1vP8bqHAt_ZfTxTuqk7gxiia-Q=X+V4b409jCdW_y=kAJOg@mail.gmail.com>
         <1484741688.2669.3.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484741688.2669.3.camel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhu, Caifeng" <zhucaifeng@unissoft-nj.com>
List-Id: ceph-devel.vger.kernel.org

On Wed, 2017-01-18 at 07:14 -0500, Jeff Layton wrote:
> On Thu, 2017-01-12 at 12:37 +0100, Ilya Dryomov wrote:
> > On Thu, Jan 12, 2017 at 12:27 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > > On Thu, 2017-01-12 at 07:59 +0000, Al Viro wrote:
> > > > On Tue, Jan 10, 2017 at 07:57:31AM -0500, Jeff Layton wrote:
> > > > > 
> > > > > v2: fix bug in offset handling in iov_iter_pvec_size
> > > > > 
> > > > > xfstest generic/095 triggers soft lockups in kcephfs. Basically it uses
> > > > > fio to drive some I/O via vmsplice ane splice. Ceph then ends up trying
> > > > > to access an ITER_BVEC type iov_iter as a ITER_IOVEC one. That causes it
> > > > > to pick up a wrong offset and get stuck in an infinite loop while trying
> > > > > to populate the page array. dio_get_pagev_size has a similar problem.
> > > > > 
> > > > > To fix the first problem, add a new iov_iter helper to determine the
> > > > > offset into the page for the current segment and have ceph call that.
> > > > > I would just replace dio_get_pages_alloc with iov_iter_get_pages_alloc,
> > > > > but that will only return a single page at a time for ITER_BVEC and
> > > > > it's better to make larger requests when possible.
> > > > > 
> > > > > For the second problem, we simply replace it with a new helper that does
> > > > > what it does, but properly for all iov_iter types.
> > > > > 
> > > > > Since we're moving that into generic code, we can also utilize the
> > > > > iterate_all_kinds macro to simplify this. That means that we need to
> > > > > rework the logic a bit since we can't advance to the next vector while
> > > > > checking the current one.
> > > > 
> > > > Yecchhh...  That really looks like exposing way too low-level stuff instead
> > > > of coming up with saner primitive ;-/
> > > > 
> > > 
> > > Fair point. That said, I'm not terribly thrilled with how
> > > iov_iter_get_pages* works right now.
> > > 
> > > Note that it only ever touches the first vector. Would it not be better
> > > to keep getting page references if the bvec/iov elements are aligned
> > > properly? It seems quite plausible that they often would be, and being
> > > able to hand back a larger list of pages in most cases would be
> > > advantageous.
> > > 
> > > IOW, should we have iov_iter_get_pages basically do what
> > > dio_get_pages_alloc does -- try to build as long an array of pages as
> > > possible before returning, provided that the alignment works out?
> > > 
> > > The NFS DIO code, for instance, could also benefit there. I know we've
> > > had reports there in the past that sending down a bunch of small iovecs
> > > causes a lot of small-sized requests on the wire.
> > > 
> > > > Is page vector + offset in the first page + number of bytes really what
> > > > ceph wants?  Would e.g. an array of bio_vec be saner?  Because _that_
> > > > would make a lot more natural iov_iter_get_pages_alloc() analogue...
> > > > 
> > > > And yes, I realize that you have ->pages wired into the struct ceph_osd_request;
> > > > how painful would it be to have it switched to struct bio_vec array instead?
> > > 
> > > Actually...it looks like that might not be too hard. The low-level OSD
> > > handling code can already handle bio_vec arrays in order to service RBD.
> > > It looks like we could switch cephfs to use
> > > osd_req_op_extent_osd_data_bio instead of
> > > osd_req_op_extent_osd_data_pages. That would add a dependency in cephfs
> > > on CONFIG_BLOCK, but I think we could probably live with that.
> > 
> > Ah, just that part might be easy enough ;)
> > 
> > 
> 
> Yeah, that part doesn't look too bad. Regardless though, I think we need
> to get a fix in for this sooner rather than later as it's trivial to get
> the kernel stuck in this loop today, by any user with write access to a
> ceph mount.
> 
> Al, when you mentioned switching this over to a bio_vec based interface,
> were you planning to roll up the iov_iter->bio_vec array helper for
> this, or should I be looking into doing that?
> 

I take it back. It's trickier than it sounds. The libceph code is wired
to accept struct bio, not struct bio_vec.

That said, I think the right solution might be a patch like the one
below. This basically just changes iov_iter_get_pages_alloc to try to
return as large a page array as it can instead of bailing out on the
first entry.

With this, we can just drop dio_get_pages_alloc altogether and have ceph
just call iov_iter_get_pages_alloc.

I was also thinking this would help NFS DIO to do large I/Os as well,
but it doesn't. NFS DIO writes are still done a page at a time, even
when this function now hands back a large array of pages. It's probably
a bug in the NFS DIO code, but I haven't chased it down yet.

Still, this doesn't seem to make that any worse and we'd need this patch
or something like it to make NFS DTRT here anyway.

-------------------------8<---------------------------

iov_iter: allow iov_iter_get_pages_alloc to return more pages per call

Currently, iov_iter_get_pages_alloc will only ever operate on the first
vector that iterate_all_kinds hands back. Many of the callers however
would like to have as long a set of pages as possible, to allow for
fewer, but larger I/Os.

When the previous vector ends on a page boundary and the current one
begins on one, we can continue to add more pages.

Change the function to first scan the iov_iter to see how long an
array of pages we could create from the current position. Then,
allocate an array that large (or up to the maxsize), and fill that
many pages.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 lib/iov_iter.c | 140 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 111 insertions(+), 29 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index e68604ae3ced..956d17767a3e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -883,6 +883,58 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_gap_alignment);
 
+/**
+ * iov_iter_pvec_size - find length of page aligned iovecs in iov_iter
+ * @i: iov_iter to in which to find the size
+ *
+ * Some filesystems can stitch together multiple iovecs into a single
+ * page vector when both the previous tail and current base are page
+ * aligned. This function discovers the length that can fit in a single
+ * pagevec and returns it.
+ */
+static size_t iov_iter_pvec_size(const struct iov_iter *i)
+{
+	size_t size = i->count;
+	size_t pv_size = 0;
+	bool contig = false, first = true;
+
+	if (!size)
+		return 0;
+
+	/* Pipes are naturally aligned for this */
+	if (unlikely(i->type & ITER_PIPE))
+		return size;
+
+	/*
+	 * An iov can be page vectored when the current base and previous
+	 * tail are both page aligned. Note that we don't require that the
+	 * initial base in the first iovec also be page aligned.
+	 */
+	iterate_all_kinds(i, size, v,
+		({
+		 if (first || (contig && PAGE_ALIGNED(v.iov_base))) {
+			pv_size += v.iov_len;
+			first = false;
+			contig = PAGE_ALIGNED(v.iov_base + v.iov_len);
+		 }; 0;
+		 }),
+		({
+		 if (first || (contig && v.bv_offset == 0)) {
+			pv_size += v.bv_len;
+			first = false;
+			contig = PAGE_ALIGNED(v.bv_offset + v.bv_len);
+		 }
+		 }),
+		({
+		 if (first || (contig && PAGE_ALIGNED(v.iov_base))) {
+			pv_size += v.iov_len;
+			first = false;
+			contig = PAGE_ALIGNED(v.iov_base + v.iov_len);
+		 }
+		 }))
+	return pv_size;
+}
+
 static inline size_t __pipe_get_pages(struct iov_iter *i,
 				size_t maxsize,
 				struct page **pages,
@@ -1006,47 +1058,77 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 }
 
 ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
-		   struct page ***pages, size_t maxsize,
-		   size_t *start)
+		   struct page ***ppages, size_t maxsize,
+		   size_t *pstart)
 {
-	struct page **p;
-
-	if (maxsize > i->count)
-		maxsize = i->count;
+	struct page **p, **pc;
+	size_t start = 0;
+	ssize_t len = 0;
+	int npages, res = 0;
+	bool first = true;
 
 	if (unlikely(i->type & ITER_PIPE))
-		return pipe_get_pages_alloc(i, pages, maxsize, start);
+		return pipe_get_pages_alloc(i, ppages, maxsize, pstart);
+
+	maxsize = min(iov_iter_pvec_size(i), maxsize);
+	npages = DIV_ROUND_UP(maxsize, PAGE_SIZE);
+	p = get_pages_array(npages);
+	if (!p)
+		return -ENOMEM;
+
+	pc = p;
 	iterate_all_kinds(i, maxsize, v, ({
 		unsigned long addr = (unsigned long)v.iov_base;
-		size_t len = v.iov_len + (*start = addr & (PAGE_SIZE - 1));
+		size_t slen = v.iov_len;
 		int n;
-		int res;
 
-		addr &= ~(PAGE_SIZE - 1);
-		n = DIV_ROUND_UP(len, PAGE_SIZE);
-		p = get_pages_array(n);
-		if (!p)
-			return -ENOMEM;
-		res = get_user_pages_fast(addr, n, (i->type & WRITE) != WRITE, p);
-		if (unlikely(res < 0)) {
-			kvfree(p);
-			return res;
+		if (first) {
+			start = addr & (PAGE_SIZE - 1);
+			slen += start;
+			first = false;
 		}
-		*pages = p;
-		return (res == n ? len : res * PAGE_SIZE) - *start;
+
+		n = DIV_ROUND_UP(slen, PAGE_SIZE);
+		if ((pc + n) > (p + npages)) {
+			/* Did something change the iov array?!? */
+			res = -EFAULT;
+			goto out;
+		}
+		addr &= ~(PAGE_SIZE - 1);
+		res = get_user_pages_fast(addr, n, (i->type & WRITE) != WRITE, pc);
+		if (unlikely(res < 0))
+			goto out;
+		len += (res == n ? slen : res * PAGE_SIZE) - start;
+		pc += res;
 	0;}),({
-		/* can't be more than PAGE_SIZE */
-		*start = v.bv_offset;
-		*pages = p = get_pages_array(1);
-		if (!p)
-			return -ENOMEM;
-		get_page(*p = v.bv_page);
-		return v.bv_len;
+		/* bio_vecs are limited to a single page each */
+		if (first) {
+			start = v.bv_offset;
+			first = false;
+		}
+		get_page(*pc = v.bv_page);
+		len += v.bv_len;
+		++pc;
+		BUG_ON(pc > p + npages);
 	}),({
-		return -EFAULT;
+		/* FIXME: should we handle this case? */
+		res = -EFAULT;
+		goto out;
 	})
 	)
-	return 0;
+out:
+	if (unlikely(res < 0)) {
+		struct page **i;
+
+		for (i = p; i < pc; i++)
+			put_page(*i);
+		kvfree(p);
+		return res;
+	}
+
+	*ppages = p;
+	*pstart = start;
+	return len;
 }
 EXPORT_SYMBOL(iov_iter_get_pages_alloc);
 
-- 
2.9.3
