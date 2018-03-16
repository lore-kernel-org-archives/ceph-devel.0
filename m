From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: only dirty ITER_IOVEC pages for direct read
Date: Fri, 16 Mar 2018 11:32:12 +0800
Message-ID: <20180316033212.30543-1-zyan@redhat.com>
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Resent-Message-ID: <jn7eyY2RKoP.A.-tE.s_zqaB@bendel>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/20180316033212.30543-1-zyan@redhat.com
To: ceph-devel@vger.kernel.org
Cc: debian-kernel@lists.debian.org, kaipeng94@gmail.com, syzkaller@googlegroups.com, "Yan, Zheng" <zyan@redhat.com>
List-Id: ceph-devel.vger.kernel.org

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/file.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 1e9dbe77a880..fef8968011ee 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -614,7 +614,8 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 struct ceph_aio_request {
 	struct kiocb *iocb;
 	size_t total_len;
-	int write;
+	bool write;
+	bool should_dirty;
 	int error;
 	struct list_head osd_reqs;
 	unsigned int num_reqs;
@@ -724,7 +725,7 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 		}
 	}
 
-	ceph_put_page_vector(osd_data->pages, num_pages, !aio_req->write);
+	ceph_put_page_vector(osd_data->pages, num_pages, aio_req->should_dirty);
 	ceph_osdc_put_request(req);
 
 	if (rc < 0)
@@ -821,6 +822,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos;
 	bool write = iov_iter_rw(iter) == WRITE;
+	bool should_dirty = !write && iter_is_iovec(iter);
 
 	if (write && ceph_snap(file_inode(file)) != CEPH_NOSNAP)
 		return -EROFS;
@@ -888,6 +890,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 			if (aio_req) {
 				aio_req->iocb = iocb;
 				aio_req->write = write;
+				aio_req->should_dirty = should_dirty;
 				INIT_LIST_HEAD(&aio_req->osd_reqs);
 				if (write) {
 					aio_req->mtime = mtime;
@@ -945,7 +948,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 				len = ret;
 		}
 
-		ceph_put_page_vector(pages, num_pages, !write);
+		ceph_put_page_vector(pages, num_pages, should_dirty);
 
 		ceph_osdc_put_request(req);
 		if (ret < 0)
