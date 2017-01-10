From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2] ceph/iov_iter: fix bad iov_iter handling in ceph splice codepaths
Date: Tue, 10 Jan 2017 07:57:31 -0500
Message-ID: <1484053051-23685-1-git-send-email-jlayton@redhat.com>
References: <1483727016-343-1-git-send-email-jlayton@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483727016-343-1-git-send-email-jlayton@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>, "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, "Zhu, Caifeng" <zhucaifeng@unissoft-nj.com>
List-Id: ceph-devel.vger.kernel.org

v2: fix bug in offset handling in iov_iter_pvec_size

xfstest generic/095 triggers soft lockups in kcephfs. Basically it uses
fio to drive some I/O via vmsplice ane splice. Ceph then ends up trying
to access an ITER_BVEC type iov_iter as a ITER_IOVEC one. That causes it
to pick up a wrong offset and get stuck in an infinite loop while trying
to populate the page array. dio_get_pagev_size has a similar problem.

To fix the first problem, add a new iov_iter helper to determine the
offset into the page for the current segment and have ceph call that.
I would just replace dio_get_pages_alloc with iov_iter_get_pages_alloc,
but that will only return a single page at a time for ITER_BVEC and
it's better to make larger requests when possible.

For the second problem, we simply replace it with a new helper that does
what it does, but properly for all iov_iter types.

Since we're moving that into generic code, we can also utilize the
iterate_all_kinds macro to simplify this. That means that we need to
rework the logic a bit since we can't advance to the next vector while
checking the current one.

Link: http://tracker.ceph.com/issues/18130
Cc: "Zhu, Caifeng" <zhucaifeng@unissoft-nj.com>
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/file.c      | 28 ++-------------------
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 26 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f633165f3fdc..0cd9fc68a04e 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -35,29 +35,6 @@
  */
 
 /*
- * Calculate the length sum of direct io vectors that can
- * be combined into one page vector.
- */
-static size_t dio_get_pagev_size(const struct iov_iter *it)
-{
-    const struct iovec *iov = it->iov;
-    const struct iovec *iovend = iov + it->nr_segs;
-    size_t size;
-
-    size = iov->iov_len - it->iov_offset;
-    /*
-     * An iov can be page vectored when both the current tail
-     * and the next base are page aligned.
-     */
-    while (PAGE_ALIGNED((iov->iov_base + iov->iov_len)) &&
-           (++iov < iovend && PAGE_ALIGNED((iov->iov_base)))) {
-        size += iov->iov_len;
-    }
-    dout("dio_get_pagevlen len = %zu\n", size);
-    return size;
-}
-
-/*
  * Allocate a page vector based on (@it, @nbytes).
  * The return value is the tuple describing a page vector,
  * that is (@pages, @page_align, @num_pages).
@@ -71,8 +48,7 @@ dio_get_pages_alloc(const struct iov_iter *it, size_t nbytes,
 	struct page **pages;
 	int ret = 0, idx, npages;
 
-	align = (unsigned long)(it->iov->iov_base + it->iov_offset) &
-		(PAGE_SIZE - 1);
+	align = iov_iter_single_seg_page_offset(it);
 	npages = calc_pages_for(align, nbytes);
 	pages = kmalloc(sizeof(*pages) * npages, GFP_KERNEL);
 	if (!pages) {
@@ -927,7 +903,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	}
 
 	while (iov_iter_count(iter) > 0) {
-		u64 size = dio_get_pagev_size(iter);
+		u64 size = iov_iter_pvec_size(iter);
 		size_t start = 0;
 		ssize_t len;
 
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 6e22b544d039..46fdfff3d7d6 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -83,6 +83,7 @@ size_t iov_iter_copy_from_user_atomic(struct page *page,
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 int iov_iter_fault_in_readable(struct iov_iter *i, size_t bytes);
 size_t iov_iter_single_seg_count(const struct iov_iter *i);
+size_t iov_iter_single_seg_page_offset(const struct iov_iter *i);
 size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
@@ -93,6 +94,7 @@ size_t copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
+size_t iov_iter_pvec_size(const struct iov_iter *i);
 void iov_iter_init(struct iov_iter *i, int direction, const struct iovec *iov,
 			unsigned long nr_segs, size_t count);
 void iov_iter_kvec(struct iov_iter *i, int direction, const struct kvec *kvec,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6b415b5a100d..b8fa377b0cef 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -745,6 +745,24 @@ size_t iov_iter_single_seg_count(const struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_single_seg_count);
 
+/* Return offset into page for current iov_iter segment */
+size_t iov_iter_single_seg_page_offset(const struct iov_iter *i)
+{
+	size_t	base;
+
+	if (i->type & ITER_PIPE)
+		base = i->pipe->bufs[i->idx].offset;
+	else if (i->type & ITER_BVEC)
+		base = i->bvec->bv_offset;
+	else if (i->type & ITER_KVEC)
+		base = (size_t)i->kvec->iov_base;
+	else
+		base = (size_t)i->iov->iov_base;
+
+	return (base + i->iov_offset) & (PAGE_SIZE - 1);
+}
+EXPORT_SYMBOL(iov_iter_single_seg_page_offset);
+
 void iov_iter_kvec(struct iov_iter *i, int direction,
 			const struct kvec *kvec, unsigned long nr_segs,
 			size_t count)
@@ -830,6 +848,59 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
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
+size_t iov_iter_pvec_size(const struct iov_iter *i)
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
+EXPORT_SYMBOL(iov_iter_pvec_size);
+
 static inline size_t __pipe_get_pages(struct iov_iter *i,
 				size_t maxsize,
 				struct page **pages,
-- 
2.7.4
