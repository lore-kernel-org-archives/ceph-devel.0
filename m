From: john.hubbard@gmail.com
Subject: [PATCH 09/12] fs/fuse: convert put_page() to put_user_page*()
Date: Tue, 23 Jul 2019 21:25:15 -0700
Message-ID: <20190724042518.14363-10-jhubbard@nvidia.com>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190724042518.14363-1-jhubbard@nvidia.com>
Sender: netdev-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Anna Schumaker <anna.schumaker@netapp.com>, "David S . Miller" <davem@davemloft.net>, Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, Latchesar Ionkov <lucho@ionkov.net>, "Michael S . Tsirkin" <mst@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trond.myklebust@hammerspace.com>, Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, kvm@vger.kernel.org, linux-block@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.orglinu
List-Id: ceph-devel.vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Changes from Jérôme's original patch:

* Use the enhanced put_user_pages_dirty_lock().

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Boaz Harrosh <boaz@plexistor.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
---
 fs/fuse/dev.c  | 22 +++++++++++++++++----
 fs/fuse/file.c | 53 +++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index ea8237513dfa..8ef65c9cd3f6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -780,6 +780,7 @@ struct fuse_copy_state {
 	unsigned len;
 	unsigned offset;
 	unsigned move_pages:1;
+	bool from_gup;
 };
 
 static void fuse_copy_init(struct fuse_copy_state *cs, int write,
@@ -800,13 +801,22 @@ static void fuse_copy_finish(struct fuse_copy_state *cs)
 			buf->len = PAGE_SIZE - cs->len;
 		cs->currbuf = NULL;
 	} else if (cs->pg) {
-		if (cs->write) {
-			flush_dcache_page(cs->pg);
-			set_page_dirty_lock(cs->pg);
+		if (cs->from_gup) {
+			if (cs->write) {
+				flush_dcache_page(cs->pg);
+				put_user_pages_dirty_lock(&cs->pg, 1, true);
+			} else
+				put_user_page(cs->pg);
+		} else {
+			if (cs->write) {
+				flush_dcache_page(cs->pg);
+				set_page_dirty_lock(cs->pg);
+			}
+			put_page(cs->pg);
 		}
-		put_page(cs->pg);
 	}
 	cs->pg = NULL;
+	cs->from_gup = false;
 }
 
 /*
@@ -834,6 +844,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			BUG_ON(!cs->nr_segs);
 			cs->currbuf = buf;
 			cs->pg = buf->page;
+			cs->from_gup = false;
 			cs->offset = buf->offset;
 			cs->len = buf->len;
 			cs->pipebufs++;
@@ -851,6 +862,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			buf->len = 0;
 
 			cs->currbuf = buf;
+			cs->from_gup = false;
 			cs->pg = page;
 			cs->offset = 0;
 			cs->len = PAGE_SIZE;
@@ -866,6 +878,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 		cs->len = err;
 		cs->offset = off;
 		cs->pg = page;
+		cs->from_gup = iov_iter_get_pages_use_gup(cs->iter);
 		iov_iter_advance(cs->iter, err);
 	}
 
@@ -1000,6 +1013,7 @@ static int fuse_try_move_page(struct fuse_copy_state *cs, struct page **pagep)
 	unlock_page(newpage);
 out_fallback:
 	cs->pg = buf->page;
+	cs->from_gup = false;
 	cs->offset = buf->offset;
 
 	err = lock_request(cs->req);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5ae2828beb00..c34c22ac5b22 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -543,12 +543,20 @@ void fuse_read_fill(struct fuse_req *req, struct file *file, loff_t pos,
 	req->out.args[0].size = count;
 }
 
-static void fuse_release_user_pages(struct fuse_req *req, bool should_dirty)
+static void fuse_release_user_pages(struct fuse_req *req, bool should_dirty,
+				    bool from_gup)
 {
 	unsigned i;
 
+	if (from_gup) {
+		put_user_pages_dirty_lock(req->pages, req->num_pages,
+					  should_dirty);
+		return;
+	}
+
 	for (i = 0; i < req->num_pages; i++) {
 		struct page *page = req->pages[i];
+
 		if (should_dirty)
 			set_page_dirty_lock(page);
 		put_page(page);
@@ -621,12 +629,13 @@ static void fuse_aio_complete(struct fuse_io_priv *io, int err, ssize_t pos)
 	kref_put(&io->refcnt, fuse_io_release);
 }
 
-static void fuse_aio_complete_req(struct fuse_conn *fc, struct fuse_req *req)
+static void _fuse_aio_complete_req(struct fuse_conn *fc, struct fuse_req *req,
+				   bool from_gup)
 {
 	struct fuse_io_priv *io = req->io;
 	ssize_t pos = -1;
 
-	fuse_release_user_pages(req, io->should_dirty);
+	fuse_release_user_pages(req, io->should_dirty, from_gup);
 
 	if (io->write) {
 		if (req->misc.write.in.size != req->misc.write.out.size)
@@ -641,8 +650,18 @@ static void fuse_aio_complete_req(struct fuse_conn *fc, struct fuse_req *req)
 	fuse_aio_complete(io, req->out.h.error, pos);
 }
 
+static void fuse_aio_from_gup_complete_req(struct fuse_conn *fc, struct fuse_req *req)
+{
+	_fuse_aio_complete_req(fc, req, true);
+}
+
+static void fuse_aio_complete_req(struct fuse_conn *fc, struct fuse_req *req)
+{
+	_fuse_aio_complete_req(fc, req, false);
+}
+
 static size_t fuse_async_req_send(struct fuse_conn *fc, struct fuse_req *req,
-		size_t num_bytes, struct fuse_io_priv *io)
+		size_t num_bytes, struct fuse_io_priv *io, bool from_gup)
 {
 	spin_lock(&io->lock);
 	kref_get(&io->refcnt);
@@ -651,7 +670,8 @@ static size_t fuse_async_req_send(struct fuse_conn *fc, struct fuse_req *req,
 	spin_unlock(&io->lock);
 
 	req->io = io;
-	req->end = fuse_aio_complete_req;
+	req->end = from_gup ? fuse_aio_from_gup_complete_req :
+		   fuse_aio_complete_req;
 
 	__fuse_get_request(req);
 	fuse_request_send_background(fc, req);
@@ -660,7 +680,8 @@ static size_t fuse_async_req_send(struct fuse_conn *fc, struct fuse_req *req,
 }
 
 static size_t fuse_send_read(struct fuse_req *req, struct fuse_io_priv *io,
-			     loff_t pos, size_t count, fl_owner_t owner)
+			     loff_t pos, size_t count, fl_owner_t owner,
+			     bool from_gup)
 {
 	struct file *file = io->iocb->ki_filp;
 	struct fuse_file *ff = file->private_data;
@@ -675,7 +696,7 @@ static size_t fuse_send_read(struct fuse_req *req, struct fuse_io_priv *io,
 	}
 
 	if (io->async)
-		return fuse_async_req_send(fc, req, count, io);
+		return fuse_async_req_send(fc, req, count, io, from_gup);
 
 	fuse_request_send(fc, req);
 	return req->out.args[0].size;
@@ -755,7 +776,7 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 	req->page_descs[0].length = count;
 	init_sync_kiocb(&iocb, file);
 	io = (struct fuse_io_priv) FUSE_IO_PRIV_SYNC(&iocb);
-	num_read = fuse_send_read(req, &io, pos, count, NULL);
+	num_read = fuse_send_read(req, &io, pos, count, NULL, false);
 	err = req->out.h.error;
 
 	if (!err) {
@@ -976,7 +997,8 @@ static void fuse_write_fill(struct fuse_req *req, struct fuse_file *ff,
 }
 
 static size_t fuse_send_write(struct fuse_req *req, struct fuse_io_priv *io,
-			      loff_t pos, size_t count, fl_owner_t owner)
+			      loff_t pos, size_t count, fl_owner_t owner,
+			      bool from_gup)
 {
 	struct kiocb *iocb = io->iocb;
 	struct file *file = iocb->ki_filp;
@@ -996,7 +1018,7 @@ static size_t fuse_send_write(struct fuse_req *req, struct fuse_io_priv *io,
 	}
 
 	if (io->async)
-		return fuse_async_req_send(fc, req, count, io);
+		return fuse_async_req_send(fc, req, count, io, from_gup);
 
 	fuse_request_send(fc, req);
 	return req->misc.write.out.size;
@@ -1031,7 +1053,7 @@ static size_t fuse_send_write_pages(struct fuse_req *req, struct kiocb *iocb,
 	for (i = 0; i < req->num_pages; i++)
 		fuse_wait_on_page_writeback(inode, req->pages[i]->index);
 
-	res = fuse_send_write(req, &io, pos, count, NULL);
+	res = fuse_send_write(req, &io, pos, count, NULL, false);
 
 	offset = req->page_descs[0].offset;
 	count = res;
@@ -1351,6 +1373,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	ssize_t res = 0;
 	struct fuse_req *req;
 	int err = 0;
+	bool from_gup = iov_iter_get_pages_use_gup(iter);
 
 	if (io->async)
 		req = fuse_get_req_for_background(fc, iov_iter_npages(iter,
@@ -1384,13 +1407,15 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 				inarg = &req->misc.write.in;
 				inarg->write_flags |= FUSE_WRITE_KILL_PRIV;
 			}
-			nres = fuse_send_write(req, io, pos, nbytes, owner);
+			nres = fuse_send_write(req, io, pos, nbytes, owner,
+					       from_gup);
 		} else {
-			nres = fuse_send_read(req, io, pos, nbytes, owner);
+			nres = fuse_send_read(req, io, pos, nbytes, owner,
+					      from_gup);
 		}
 
 		if (!io->async)
-			fuse_release_user_pages(req, io->should_dirty);
+			fuse_release_user_pages(req, io->should_dirty, from_gup);
 		if (req->out.h.error) {
 			err = req->out.h.error;
 			break;
-- 
2.22.0
