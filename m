From: john.hubbard@gmail.com
Subject: [PATCH 10/12] fs/ceph: convert put_page() to put_user_page*()
Date: Tue, 23 Jul 2019 21:25:16 -0700
Message-ID: <20190724042518.14363-11-jhubbard@nvidia.com>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724042518.14363-1-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
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
Cc: ceph-devel@vger.kernel.org
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
Cc: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
---
 fs/ceph/file.c | 62 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 685a03cc4b77..c628a1f96978 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -158,18 +158,26 @@ static ssize_t iter_get_bvecs_alloc(struct iov_iter *iter, size_t maxsize,
 	return bytes;
 }
 
-static void put_bvecs(struct bio_vec *bvecs, int num_bvecs, bool should_dirty)
+static void put_bvecs(struct bio_vec *bv, int num_bvecs, bool should_dirty,
+		      bool from_gup)
 {
 	int i;
 
+
 	for (i = 0; i < num_bvecs; i++) {
-		if (bvecs[i].bv_page) {
+		if (!bv[i].bv_page)
+			continue;
+
+		if (from_gup) {
+			put_user_pages_dirty_lock(&bv[i].bv_page, 1,
+						  should_dirty);
+		} else {
 			if (should_dirty)
-				set_page_dirty_lock(bvecs[i].bv_page);
-			put_page(bvecs[i].bv_page);
+				set_page_dirty_lock(bv[i].bv_page);
+			put_page(bv[i].bv_page);
 		}
 	}
-	kvfree(bvecs);
+	kvfree(bv);
 }
 
 /*
@@ -730,6 +738,7 @@ struct ceph_aio_work {
 };
 
 static void ceph_aio_retry_work(struct work_struct *work);
+static void ceph_aio_from_gup_retry_work(struct work_struct *work);
 
 static void ceph_aio_complete(struct inode *inode,
 			      struct ceph_aio_request *aio_req)
@@ -774,7 +783,7 @@ static void ceph_aio_complete(struct inode *inode,
 	kfree(aio_req);
 }
 
-static void ceph_aio_complete_req(struct ceph_osd_request *req)
+static void _ceph_aio_complete_req(struct ceph_osd_request *req, bool from_gup)
 {
 	int rc = req->r_result;
 	struct inode *inode = req->r_inode;
@@ -793,7 +802,9 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 
 		aio_work = kmalloc(sizeof(*aio_work), GFP_NOFS);
 		if (aio_work) {
-			INIT_WORK(&aio_work->work, ceph_aio_retry_work);
+			INIT_WORK(&aio_work->work, from_gup ?
+				  ceph_aio_from_gup_retry_work :
+				  ceph_aio_retry_work);
 			aio_work->req = req;
 			queue_work(ceph_inode_to_client(inode)->inode_wq,
 				   &aio_work->work);
@@ -830,7 +841,7 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 	}
 
 	put_bvecs(osd_data->bvec_pos.bvecs, osd_data->num_bvecs,
-		  aio_req->should_dirty);
+		  aio_req->should_dirty, from_gup);
 	ceph_osdc_put_request(req);
 
 	if (rc < 0)
@@ -840,7 +851,17 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 	return;
 }
 
-static void ceph_aio_retry_work(struct work_struct *work)
+static void ceph_aio_complete_req(struct ceph_osd_request *req)
+{
+	_ceph_aio_complete_req(req, false);
+}
+
+static void ceph_aio_from_gup_complete_req(struct ceph_osd_request *req)
+{
+	_ceph_aio_complete_req(req, true);
+}
+
+static void _ceph_aio_retry_work(struct work_struct *work, bool from_gup)
 {
 	struct ceph_aio_work *aio_work =
 		container_of(work, struct ceph_aio_work, work);
@@ -891,7 +912,8 @@ static void ceph_aio_retry_work(struct work_struct *work)
 
 	ceph_osdc_put_request(orig_req);
 
-	req->r_callback = ceph_aio_complete_req;
+	req->r_callback = from_gup ? ceph_aio_from_gup_complete_req :
+			  ceph_aio_complete_req;
 	req->r_inode = inode;
 	req->r_priv = aio_req;
 
@@ -899,13 +921,23 @@ static void ceph_aio_retry_work(struct work_struct *work)
 out:
 	if (ret < 0) {
 		req->r_result = ret;
-		ceph_aio_complete_req(req);
+		_ceph_aio_complete_req(req, from_gup);
 	}
 
 	ceph_put_snap_context(snapc);
 	kfree(aio_work);
 }
 
+static void ceph_aio_retry_work(struct work_struct *work)
+{
+	_ceph_aio_retry_work(work, false);
+}
+
+static void ceph_aio_from_gup_retry_work(struct work_struct *work)
+{
+	_ceph_aio_retry_work(work, true);
+}
+
 static ssize_t
 ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 		       struct ceph_snap_context *snapc,
@@ -927,6 +959,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	loff_t pos = iocb->ki_pos;
 	bool write = iov_iter_rw(iter) == WRITE;
 	bool should_dirty = !write && iter_is_iovec(iter);
+	bool from_gup = iov_iter_get_pages_use_gup(iter);
 
 	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
 		return -EROFS;
@@ -1023,7 +1056,8 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 			aio_req->num_reqs++;
 			atomic_inc(&aio_req->pending_reqs);
 
-			req->r_callback = ceph_aio_complete_req;
+			req->r_callback = !from_gup ? ceph_aio_complete_req :
+					  ceph_aio_from_gup_complete_req;
 			req->r_inode = inode;
 			req->r_priv = aio_req;
 			list_add_tail(&req->r_private_item, &aio_req->osd_reqs);
@@ -1054,7 +1088,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 				len = ret;
 		}
 
-		put_bvecs(bvecs, num_pages, should_dirty);
+		put_bvecs(bvecs, num_pages, should_dirty, from_gup);
 		ceph_osdc_put_request(req);
 		if (ret < 0)
 			break;
@@ -1093,7 +1127,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 							      req, false);
 			if (ret < 0) {
 				req->r_result = ret;
-				ceph_aio_complete_req(req);
+				_ceph_aio_complete_req(req, from_gup);
 			}
 		}
 		return -EIOCBQUEUED;
-- 
2.22.0
