Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792460339;
	b=bxp3OJpadOuP07Cd6Kv8UoWCMCmYSrm6ON9RzShabTgBkFuAjggeMdNjB5mWURpbuNeQ
	 KLTK1ILLmSL4Lsp2fPIhhvSnlisGOmRuBhcmoQi/xN38fqUxD9YAvVcJIOpvXPOOZ5kDV
	 N54Ba15LzLeDJOqvuvyxxVW3NYZXLCD2DT1Bjxiu7dj7oguUAoAtlErvFhjOEzKHhYQ2a
	 zyr1dKMhPIYdi7DzRJB7P1brJyAxlq189JdAenYJ7jzZ/ujlVYacvODhyg2w+XQmB/F8d
	 p6eYtI82LUFnxHdOrq01HM1n6+YMPk/K0rP5pqPOFfytntXrQMNmektw+lnQUlvp3PA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460339;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sNWwUsywpL+pBa6H0rTJC4wyMSR1/LvckuLkunVrfsE=;
	b=EtPE+LRn9EInx07VfpqSfFm12yI7mKnJrusiCHLha173p3WGCdn1wQZ+sVGutBrV90U4
	 vMvSVpe6qzCXvCmb3YbrFd7Jt7MYLwIzZZqrQ5REfOxqgrVFWDPx9xdY5z8DdnXVPDkKl
	 K4CFz9ktf9sDm6gsgxTddLLyNIo0iXkD6nkpr+iblR6tZPWFfqIYP04fFNlLQ8cBvnox6
	 +nqU4982e2CQoStCgJ5OYZY9ZcsiZ+rgqUERmAZYrJx6W94wZ7ylpUQJ9M16JcU0etY2t
	 LAcnqBJ4bfnvGY02R2SbosYngPFexAp47B+oGJcKxxZEIAVwKOh79YgzpY3JQ0ZIXgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAyDq1S+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA0606A31A;
	Tue, 20 Oct 2026 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JAyDq1S+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792460339;
	b=yGzFGwecgORjdeVtTNbwZTRZ0teLMkL9nUR2Yl5FDVlchCP2hBS3d6Za9apgHT7Ph1dx
	 ffD0LN+Cz0g4KTHBpRO/EVyx6nR8bgISAS3XbjIYNlblTtqiNYpuvY9QuSWo/3/21PEyR
	 6YgLTKiXRD2yDVMuSLrbsBt7EMz4XRExVm3yZnJa9cf8o3Hhl4gEEPZKQYVo+7vyc/I7+
	 BkhvGVQxmcCvXUWeHej//+/7Kql2+oy9q8+pmz5NPIcknWsZFNdaF9dCS+aBnOgS9OuXl
	 lhO2zM9rUYEkmduLds1Gp6PL4n9l1XW0A2YVoYE7iqMVuYCezECc24C6k4RbDozQUwg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792460339;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sNWwUsywpL+pBa6H0rTJC4wyMSR1/LvckuLkunVrfsE=;
	b=cgaV4G4IuQu5RMcQ6PfIGhQ21kRQvU7xZdSu+xexZjWqTIocPHPVuNyDMbWuYPKUur22
	 wwUYdY2gyLGtYr7UxuW2bnXm9PxxYoy6CFIHmnYJRwivM9ZZ5oo3k4FwcA7e/Un/Av1xo
	 LRnjFHzHj6lTZeoMEqsByTk5CqSs9+81EY2oumPHg8B2lyvqIQp6fGbAkfaTf56v0/cqN
	 0CiPBgCjzByjpKWR2Mlh/wF5+BfEO2e8E6SjIXaw2JwvjvSqiKw2N9zOZPtb6dtpiUDWD
	 pYYq5drChQiVGq1+mbGXveM0qI512scqAhTKNWbwqgRXJ89ULr5WAbtmTgOh0wxeEzA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5791F1F000C5;
	Tue, 20 Oct 2026 01:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460339;
	bh=sNWwUsywpL+pBa6H0rTJC4wyMSR1/LvckuLkunVrfsE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=JAyDq1S+Ay1ViAT9FFbOHV9n5SQlkOJ+fpHSfUfyjRcjpDSvCJjMVYlUvZCwxGjD8
	 6CTx6ZN9Z1KYYiDl0UOa9g2/t0QVoiIt7l5cOX1K3e/kMQwzRF+EkNFlA0Indgr6h0
	 Mr+8phw9hzBEhoCVnaxjXA31qHL3afqO5Wnl9BNqBeQT6KI0/m+pKQu3087E/QFstF
	 4/vKq1voSth/wOmdOq3jGfOco/ftvncetN94EXmGe4Dyd5a/hwzqajld7LaMn/Hz8i
	 rrPsxIdpJslzigIENR4qzSI5ZyrHGbKRBBcGyxp/7VRdhoYOZU/thnUyx2WUlSMt+i
	 RF915N2xfQ4MQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id ACC65406DA;
	Tue, 20 Oct 2026 01:38:57 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 20 Oct 2026 03:38:41 +0200
Subject: [PATCH] ceph: read ahead along the stride of strided record reads
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261020-b4-wip-ceph-ra-stride-v1-1-6314b013d3b8@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw6CQBBF0a2QGltJf9CoWzEOmuYh5QA7VfhJC
 Hu30eEZ3LuQQQVG52YhxUtMHlOF3zWUxzTdwNJXU3Dh4F1w3LX8lsIZZWRNbLNKD95HN5w8jhE
 pUm2LYpDP73u5/m3P7o48bzNa1y+xfdYVeQAAAA==
X-Change-ID: 20261020-b4-wip-ceph-ra-stride-530f91e83ea3
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792460336; l=9737;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=6bQgoYjGpIWD5NadHM+Vv5XzETA6hE53g2TCAn0os7s=;
 b=SOO6JtIS+wjvgVhsuEhyw9Jw16boEwHiAalUkc6XyJ1KsgxXdPPEhrOWSg8dPS2LB9cGyrdwk
 CYRN8JlGyUIA52uSgzZQE8OLSI4tFcfb0PEDyPxKZ8F2fEFueM+gISk
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

ceph_netfs_expand_readahead() rounds every readahead request out to the
stripe unit, 4 MiB by default.  When several clients read interleaved
records of a shared file, a record that misses the page cache drags in
the whole object around it, and most of that are records the other
clients read.  IO500's ior-hard-read does exactly this: 16 reader
processes spread over 4 clients read 47008-byte records, each process
every 16th record.  Every client ends up reading the whole file: the
OSDs return 4x the data that is asked for and the read runs at a third
of what the disks can do.

Simply not expanding such a read is not enough.  The generic readahead
sees each record as a small random read and reads it as is, so every
record becomes a synchronous round trip; with one reader process per
client that is half as fast as the over-reading it replaces.

So detect the pattern and read ahead along it:

 - ceph_read_iter() notes, per open file, the position and length of
   every buffered read.  A read of the same length as the previous one,
   starting as far after it as that one did after its predecessor, with
   at least a page left out in between, for the second time in a row,
   marks the file as strided.  The detection looks at the read() calls
   and not at the page cache misses, because which reads miss depends on
   what readahead already brought in.  Sequential reads leave no gap and
   random reads have no fixed stride, so neither is affected.

 - While a file is strided, ceph_netfs_expand_readahead() leaves its
   requests alone, and ceph_stride_readahead() reads the next records of
   the stride ahead, about a readahead window of them (at most 64), each
   on its own with page_cache_ra_unbounded(), so that the records in
   between are never read.

Quick ior-hard runs, 28 GiB, 3 OSDs, ior-hard-read MiB/s.  Each client
is a separate kernel client mount (its own client instance):

  +--------------------------------+---------+--------+-------+
  | Readers                        | Mount   | Before | After |
  +--------------------------------+---------+--------+-------+
  | 16 processes on 4 clients      | default |    487 |  2364 |
  | 16 processes on 4 clients      | lazyio  |    468 |  2388 |
  | 1 process on each of 4 clients | lazyio  |    732 |  1354 |
  +--------------------------------+---------+--------+-------+

The OSDs now read about the data that is asked for instead of 3.6-4x.
ior-easy-read (sequential) and ior-rnd4K-easy-read (random 4 KiB) are
unchanged, and no read of either was taken as strided.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/addr.c  | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/file.c  | 29 +++++++++++++++++++++++++++++
 fs/ceph/super.h | 15 +++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index dd2bd8ed2424..737f9a5025f8 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -196,6 +196,15 @@ static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
 		else
 			max_pages = priv->file_ra_pages;
 
+		/*
+		 * A file read in records at a fixed stride: the records in
+		 * between are typically read by other clients, so rounding
+		 * the request out to the stripe unit would mostly read data
+		 * this client never uses.  ceph_stride_readahead() reads the
+		 * next records of the stride ahead instead.
+		 */
+		if (priv->file_ra_strided)
+			return;
 	}
 
 	/* Readahead is disabled */
@@ -221,6 +230,48 @@ static void ceph_netfs_expand_readahead(struct netfs_io_request *rreq)
 	}
 }
 
+/*
+ * Read ahead for a file that is read in records at a fixed stride, as
+ * several clients reading interleaved records of a shared file do.  The
+ * generic readahead sees each record as a small random read and reads it
+ * as is, and ceph_netfs_expand_readahead() leaves strided files alone, so
+ * without this each record would be a synchronous round trip to the OSDs.
+ * Read the next records of the stride ahead instead, about a readahead
+ * window of them, each on its own so that the records in between are not
+ * read.  page_cache_ra_unbounded() skips the pages that are already cached.
+ *
+ * The caller holds the read caps and has registered its rw context.
+ */
+void ceph_stride_readahead(struct file *filp, struct ceph_file_info *fi,
+			   loff_t pos, size_t len)
+{
+	struct address_space *mapping = filp->f_mapping;
+	loff_t isize = i_size_read(mapping->host);
+	unsigned long window = (unsigned long)filp->f_ra.ra_pages << PAGE_SHIFT;
+	loff_t stride = fi->ra_stride, next, end;
+	unsigned int nr;
+
+	if (!fi->ra_strided || !window || (filp->f_mode & FMODE_RANDOM))
+		return;
+	nr = clamp_t(unsigned long, window / len, 1, CEPH_STRIDE_RA_MAX);
+	end = pos + stride * nr;
+	/* continue after the records already read ahead */
+	next = fi->ra_stride_next;
+	if (next <= pos || next > end)
+		next = pos + stride;
+
+	filemap_invalidate_lock_shared(mapping);
+	for (; next <= end && next < isize; next += stride) {
+		pgoff_t first = next >> PAGE_SHIFT;
+		pgoff_t last = (min(next + (loff_t)len, isize) - 1) >> PAGE_SHIFT;
+		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, first);
+
+		page_cache_ra_unbounded(&ractl, last - first + 1, 0);
+	}
+	filemap_invalidate_unlock_shared(mapping);
+	fi->ra_stride_next = next;
+}
+
 static void finish_netfs_read(struct ceph_osd_request *req)
 {
 	struct inode *inode = req->r_inode;
@@ -525,6 +576,7 @@ static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
 	if (fi) {
 		priv->file_ra_pages = file->f_ra.ra_pages;
 		priv->file_ra_disabled = file->f_mode & FMODE_RANDOM;
+		priv->file_ra_strided = READ_ONCE(fi->ra_strided);
 
 		/*
 		 * ceph_read_iter() and ceph_filemap_fault() hold caps and
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 856710c63765..8b8f0a458993 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2203,6 +2203,33 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
  *
  * Hmm, the sync read case isn't actually async... should it be?
  */
+/*
+ * Is this file read in records at a fixed stride?  Look at the read()
+ * calls themselves, not at the page cache misses: those depend on what
+ * readahead has already brought in.  A read of the same length as the
+ * previous one, starting as far after it as that one did after its
+ * predecessor, with at least a page left out in between, for the second
+ * time in a row.  Sequential reads leave no gap and random reads have no
+ * fixed stride, so neither matches.
+ */
+static void ceph_note_read_stride(struct ceph_file_info *fi, loff_t pos,
+				  size_t len)
+{
+	loff_t stride = pos - fi->ra_prev_pos;
+
+	if (fi->ra_prev_len && len == fi->ra_prev_len &&
+	    stride >= (loff_t)len + PAGE_SIZE && stride == fi->ra_stride) {
+		if (fi->ra_stride_hits < 2)
+			fi->ra_stride_hits++;
+	} else {
+		fi->ra_stride_hits = 0;
+	}
+	fi->ra_stride = stride;
+	fi->ra_prev_pos = pos;
+	fi->ra_prev_len = len;
+	WRITE_ONCE(fi->ra_strided, fi->ra_stride_hits >= 2);
+}
+
 static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct file *filp = iocb->ki_filp;
@@ -2278,7 +2305,9 @@ static ssize_t ceph_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		boutc(cl, "async %p %llx.%llx %llu~%u got cap refs on %s\n",
 		      inode, ceph_vinop(inode), iocb->ki_pos, (unsigned)len,
 		      ceph_cap_string(got));
+		ceph_note_read_stride(fi, iocb->ki_pos, len);
 		ceph_add_rw_context(fi, &rw_ctx);
+		ceph_stride_readahead(filp, fi, iocb->ki_pos, len);
 		ret = generic_file_read_iter(iocb, to);
 		ceph_del_rw_context(fi, &rw_ctx);
 	}
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 458fd63dd79f..f10520a3422a 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -69,6 +69,7 @@
  * CEPH_MSG_MAX_DATA_LEN should be small enough. */
 #define CEPH_MAX_WRITE_SIZE		CEPH_MSG_MAX_DATA_LEN
 #define CEPH_RASIZE_DEFAULT             (8192*1024)    /* max readahead */
+#define CEPH_STRIDE_RA_MAX              64             /* records read ahead on a stride */
 #define CEPH_MAX_READDIR_DEFAULT        1024
 #define CEPH_MAX_READDIR_BYTES_DEFAULT  (512*1024)
 #define CEPH_SNAPDIRNAME_DEFAULT        ".snap"
@@ -567,6 +568,9 @@ struct ceph_netfs_request_data {
 
 	/* Set it if fadvise disables file readahead entirely */
 	bool file_ra_disabled;
+
+	/* Set it if the file is read in records at a fixed stride */
+	bool file_ra_strided;
 };
 
 static inline struct ceph_inode_info *
@@ -893,6 +897,9 @@ static inline bool __ceph_is_any_real_caps(const struct ceph_inode_info *ci)
 }
 
 extern int __ceph_caps_issued(struct ceph_inode_info *ci, int *implemented);
+struct ceph_file_info;
+extern void ceph_stride_readahead(struct file *filp, struct ceph_file_info *fi,
+				  loff_t pos, size_t len);
 extern int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int t);
 extern int __ceph_caps_issued_mask_metric(struct ceph_inode_info *ci, int mask,
 					  int t);
@@ -987,6 +994,14 @@ struct ceph_file_info {
 	struct list_head rw_contexts;
 
 	u32 filp_gen;
+
+	/* stride detection of buffered reads, see ceph_note_read_stride() */
+	loff_t ra_prev_pos;
+	loff_t ra_stride;
+	size_t ra_prev_len;
+	unsigned int ra_stride_hits;
+	bool ra_strided;
+	loff_t ra_stride_next;	/* next record to read ahead */
 };
 
 struct ceph_dir_file_info {

---
base-commit: ed0502cb11f84fff29f374238e526ae94d9bdfde
change-id: 20261020-b4-wip-ceph-ra-stride-530f91e83ea3

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


