From: David Howells <dhowells@redhat.com>
Subject: [PATCH 22/32] cachefiles: Implement read and write
 parts of new I/O API
Date: Mon, 13 Jul 2020 17:34:45 +0100
Message-ID: <159465808553.1376674.11788737980809596736.stgit@warthog.procyon.org.uk>
References: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-cachefs-bounces@redhat.com>
In-Reply-To: <159465784033.1376674.18106463693989811037.stgit@warthog.procyon.org.uk>
List-Unsubscribe: <https://www.redhat.com/mailman/options/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/linux-cachefs>
List-Post: <mailto:linux-cachefs@redhat.com>
List-Help: <mailto:linux-cachefs-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/linux-cachefs>,
	<mailto:linux-cachefs-request@redhat.com?subject=subscribe>
Sender: linux-cachefs-bounces@redhat.com
Errors-To: linux-cachefs-bounces@redhat.com
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker <anna.schumaker@netapp.com>, Steve French <sfrench@samba.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org
List-Id: ceph-devel.vger.kernel.org

Implement writing into the cache and reading back from the cache inside
cachefiles using asynchronous direct I/O from the specified iterator.  The
size and position of the request should be aligned to the reported
dio_block_size.

Errors and completion are reported by callback.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/io.c |  208 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 6 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index ddb44ec5a199..42e0d620d778 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -12,30 +12,226 @@
 #include <linux/xattr.h>
 #include "internal.h"
 
+struct cachefiles_kiocb {
+	struct kiocb			iocb;
+	struct fscache_io_request	*req;
+	refcount_t			ki_refcnt;
+};
+
+static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
+{
+	if (refcount_dec_and_test(&ki->ki_refcnt)) {
+		fscache_put_io_request(ki->req);
+		fput(ki->iocb.ki_filp);
+		kfree(ki);
+	}
+}
+
+/*
+ * Handle completion of a read from the cache.
+ */
+static void cachefiles_read_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+	struct fscache_io_request *req = ki->req;
+
+	_enter("%llx,%ld,%ld", req->len, ret, ret2);
+
+	fscache_end_io_operation(req->cookie);
+
+	if (ret < 0) {
+		req->error = ret;
+	} else if (ret != req->len) {
+		req->error = -ENODATA;
+	} else {
+		req->transferred = ret;
+		set_bit(FSCACHE_IO_DATA_FROM_CACHE, &req->flags);
+	}
+	if (req->io_done)
+		req->io_done(req);
+	cachefiles_put_kiocb(ki);
+}
+
 /*
  * Initiate a read from the cache.
  */
-int cachefiles_read(struct fscache_object *object,
+int cachefiles_read(struct fscache_object *obj,
 		    struct fscache_io_request *req,
 		    struct iov_iter *iter)
 {
-	req->error = -ENODATA;
+	struct cachefiles_object *object =
+		container_of(obj, struct cachefiles_object, fscache);
+	struct cachefiles_kiocb *ki;
+	struct file *file = object->backing_file;
+	ssize_t ret = -ENOBUFS;
+
+	_enter("%pD,%li,%llx,%llx/%llx",
+	       file, file_inode(file)->i_ino, req->pos, req->len, i_size_read(file->f_inode));
+
+	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
+	if (!ki)
+		goto presubmission_error;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	ki->iocb.ki_filp	= get_file(file);
+	ki->iocb.ki_pos		= req->pos;
+	ki->iocb.ki_flags	= IOCB_DIRECT;
+	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
+	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->req			= req;
+
+	if (req->io_done)
+		ki->iocb.ki_complete = cachefiles_read_complete;
+
+	ret = rw_verify_area(READ, file, &ki->iocb.ki_pos, iov_iter_count(iter));
+	if (ret < 0)
+		goto presubmission_error_free;
+
+	fscache_get_io_request(req);
+	ret = call_read_iter(file, &ki->iocb, iter);
+	switch (ret) {
+	case -EIOCBQUEUED:
+		goto in_progress;
+
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/* There's no easy way to restart the syscall since other AIO's
+		 * may be already running. Just fail this IO with EINTR.
+		 */
+		ret = -EINTR;
+		/* Fall through */
+	default:
+		cachefiles_read_complete(&ki->iocb, ret, 0);
+		if (ret > 0)
+			ret = 0;
+		break;
+	}
+
+in_progress:
+	cachefiles_put_kiocb(ki);
+	_leave(" = %zd", ret);
+	return ret;
+
+presubmission_error_free:
+	fput(file);
+	kfree(ki);
+presubmission_error:
+	req->error = -ENOMEM;
+	if (req->io_done)
+		req->io_done(req);
+	return -ENOMEM;
+}
+
+/*
+ * Handle completion of a write to the cache.
+ */
+static void cachefiles_write_complete(struct kiocb *iocb, long ret, long ret2)
+{
+	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
+	struct fscache_io_request *req = ki->req;
+	struct inode *inode = file_inode(ki->iocb.ki_filp);
+
+	_enter("%llx,%ld,%ld", req->len, ret, ret2);
+
+	/* Tell lockdep we inherited freeze protection from submission thread */
+	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
+	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
+
+	fscache_end_io_operation(req->cookie);
+
+	if (ret < 0)
+		req->error = ret;
+	else if (ret != req->len)
+		req->error = -ENOBUFS;
+	else
+		cachefiles_mark_content_map(req);
 	if (req->io_done)
 		req->io_done(req);
-	return -ENODATA;
+	cachefiles_put_kiocb(ki);
 }
 
 /*
  * Initiate a write to the cache.
  */
-int cachefiles_write(struct fscache_object *object,
+int cachefiles_write(struct fscache_object *obj,
 		     struct fscache_io_request *req,
 		     struct iov_iter *iter)
 {
-	req->error = -ENOBUFS;
+	struct cachefiles_object *object =
+		container_of(obj, struct cachefiles_object, fscache);
+	struct cachefiles_kiocb *ki;
+	struct inode *inode;
+	struct file *file = object->backing_file;
+	ssize_t ret = -ENOBUFS;
+
+	_enter("%pD,%li,%llx,%llx/%llx",
+	       file, file_inode(file)->i_ino, req->pos, req->len, i_size_read(file->f_inode));
+
+	ki = kzalloc(sizeof(struct cachefiles_kiocb), GFP_KERNEL);
+	if (!ki)
+		goto presubmission_error;
+
+	refcount_set(&ki->ki_refcnt, 2);
+	ki->iocb.ki_filp	= get_file(file);
+	ki->iocb.ki_pos		= req->pos;
+	ki->iocb.ki_flags	= IOCB_DIRECT | IOCB_WRITE;
+	ki->iocb.ki_hint	= ki_hint_validate(file_write_hint(file));
+	ki->iocb.ki_ioprio	= get_current_ioprio();
+	ki->req			= req;
+
+	if (req->io_done)
+		ki->iocb.ki_complete = cachefiles_write_complete;
+
+	ret = rw_verify_area(WRITE, file, &ki->iocb.ki_pos, iov_iter_count(iter));
+	if (ret < 0)
+		goto presubmission_error_free;
+
+	/* Open-code file_start_write here to grab freeze protection, which
+	 * will be released by another thread in aio_complete_rw().  Fool
+	 * lockdep by telling it the lock got released so that it doesn't
+	 * complain about the held lock when we return to userspace.
+	 */
+	inode = file_inode(file);
+	__sb_start_write(inode->i_sb, SB_FREEZE_WRITE, true);
+	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+
+	fscache_get_io_request(req);
+	ret = call_write_iter(file, &ki->iocb, iter);
+	switch (ret) {
+	case -EIOCBQUEUED:
+		goto in_progress;
+
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/* There's no easy way to restart the syscall since other AIO's
+		 * may be already running. Just fail this IO with EINTR.
+		 */
+		ret = -EINTR;
+		/* Fall through */
+	default:
+		cachefiles_write_complete(&ki->iocb, ret, 0);
+		if (ret > 0)
+			ret = 0;
+		break;
+	}
+
+in_progress:
+	cachefiles_put_kiocb(ki);
+	_leave(" = %zd", ret);
+	return ret;
+
+presubmission_error_free:
+	fput(file);
+	kfree(ki);
+presubmission_error:
+	req->error = -ENOMEM;
 	if (req->io_done)
 		req->io_done(req);
-	return -ENOBUFS;
+	return -ENOMEM;
 }
 
 /*
