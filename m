Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795399966;
	b=rXc/7yk7NFxQMK9QKfl2v7Gxs0OW+mjQz0tOfM0loQkcreOa2kIfoE3QDNZrv0UgS81b
	 f+6lezsp2mrIqdnB30AHbc/jXJnRA/+ObwWgMdoUL/vQtxBOp97HIXjVwB5pvcZ4Bkgex
	 ZJvmJAltc/Kg9lrj8xFm/k/zhgAL3AmPUfvPprBwKDu/SwkcZ6KciwjKBQVm3LpP5fEQR
	 MoArVVAgrXHwZE0qsMYfMrU8fW1VH2buPuFHFSi+wUXMi6daTpv25XfcGbXCOZa5Ojvsc
	 pBBJvg89m8R0hnbPnbnL5lXYitBOsF7X1fEmoiTUc8Y5OLXUS7UcDNS/n3D+cHv2NBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795399966;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-FangMail-Miltered:X-FangMail-Envelope:X-FangMail-Bounce-Flag:
	 X-FangMail-Outinfo:X-CLEAN:Message-Id:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=nSc9TTba62DX6YsMsddUwwRihYANY4v0PIpNQc2e4Sc=;
	b=MuR51+0E5pxiNxw4NSuYJnKpRkSDnCZBt9KDX4sp1kPYM1Ag7Cq2D07yyNmkfCWV1+yR
	 q0MUG8w1mzP7908O2wFZTDQhDXZz0UYyxSZMrh1ffhLTs48tFYQPNMfiSjXEzmOCaStWa
	 LKdbmYCCFPc8Q7pEJNSxKzLggFSoKahjHKZS0guznF5c50PQYk0tMLCwquJulsUj/vD+E
	 OBuOIlQRM71Bwuo1bXf1coMlJxKNquVxV3tyiOYVMGeW8Wvbzv/5v9Bo6pVrXjQzMK1r4
	 0c/A97+58ASU9l/EvR3DA3ZKCPWYbZa1ObUhYpIxfHeyb/YfvL+gguF+0noWwjaVWYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBEE606A689;
	Mon, 23 Nov 2026 02:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADBEE606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jXqGK1FBjz36gl;
	Mon, 23 Nov 2026 10:12:41 +0800 (CST)
From: Daolong Zhang <dlzhangak@isoftstone.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daolong Zhang <dlzhangak@isoftstone.com>
Subject: [PATCH v2] ceph: add compression_hint mount option
Date: Mon, 23 Nov 2026 10:12:40 +0800
X-Mailer: git-send-email 2.48.1
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Mon, 23 Nov 2026 10:12:41 +0800
X-FangMail-Miltered: at fangwg01 with ID 6B03A118.004 by FangMail milter!
X-FangMail-Envelope: 1795399961/4jXqGK1FBjz36gl/6B03A118.004/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1795399961.6B03A118.004
X-FangMail-Outinfo: 1795399961/6B03A118.004/4jXqGK1FBjz36gl/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1795399963.6B03A118.004.4jXqGK1FBjz36gl@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B03A118.004/4jXqGK1FBjz36gl

Add support for the compression_hint=<none|compressible|incompressible>
mount option to the CephFS kernel client, matching the existing RBD
compression_hint option.

When set to 'compressible' or 'incompressible', CephFS prepends a
CEPH_OSD_OP_SETALLOCHINT operation with
CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE or
CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE (and zero expected object/write
sizes) before data writes across page writeback, uninline, direct I/O
(including AIO retries), and sync writes. For compound writes with
leading guard operations (ASSERT_VER/CREATE in fscrypt RMW sync writes
and CMPXATTR in uninline writes), the alloc hint is placed after the
guard operation and before the WRITE operation so that the guard executes
before SETALLOCHINT can create the object.

When set to 'none' (the default), no CEPH_OSD_OP_SETALLOCHINT operation
is sent. The option is also displayed in /proc/mounts and can be updated
on remount while preserving the existing hint when omitted.

Link: https://tracker.ceph.com/issues/81140
Signed-off-by: Daolong Zhang <dlzhangak@isoftstone.com>
---
v2:
- Track whether compression_hint was explicitly passed in
  struct ceph_parse_opts_ctx so ceph_reconfigure_fc() preserves the
  existing alloc_hint_flags when omitted while still allowing
  compression_hint=none to clear it explicitly (Alex Markuze).
- Rebase onto the latest ceph-client testing branch.

 Documentation/filesystems/ceph.rst | 13 +++++
 fs/ceph/addr.c                     | 82 ++++++++++++++++++++++--------
 fs/ceph/file.c                     | 58 +++++++++++++++------
 fs/ceph/super.c                    | 51 +++++++++++++++++++
 fs/ceph/super.h                    |  1 +
 5 files changed, 167 insertions(+), 38 deletions(-)

diff --git a/Documentation/filesystems/ceph.rst b/Documentation/filesystems/ceph.rst
index ee2ca0c0c654..0cfedc8645ee 100644
--- a/Documentation/filesystems/ceph.rst
+++ b/Documentation/filesystems/ceph.rst
@@ -214,6 +214,19 @@ Mount Options
 	  of them. If an inode contains any stale file locks, read/write on the
 	  inode is not allowed until applications release all stale file locks.
 
+  compression_hint=<none|compressible|incompressible>
+	Hint to the underlying OSD object store backend (e.g. BlueStore)
+	whether written data is compressible or incompressible. The default
+	is "none".
+
+	* none: do not send compression hints.
+
+	* compressible: hint that the data is compressible, enabling
+	  compression when the OSD compression mode is set to passive.
+
+	* incompressible: hint that the data is incompressible, disabling
+	  compression when the OSD compression mode is set to aggressive.
+
 More Information
 ================
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 49b58f85dc17..d1df051ce875 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1068,6 +1068,8 @@ static int write_folio_nounlock(struct folio *folio,
 	struct ceph_osd_request *req;
 	bool caching = ceph_is_cache_enabled(inode);
 	struct page *bounce_page = NULL;
+	u32 alloc_hint_flags = READ_ONCE(fsc->mount_options->alloc_hint_flags);
+	unsigned int op_idx = alloc_hint_flags ? 1 : 0;
 
 	boutc(cl, "%llx.%llx folio %p idx %lu\n", ceph_vinop(inode), folio,
 	      folio->index);
@@ -1129,7 +1131,8 @@ static int write_folio_nounlock(struct folio *folio,
 		fsc->write_congested = true;
 
 	req = ceph_osdc_new_request(osdc, &ci->i_layout, ceph_vino(inode),
-				    page_off, &wlen, 0, 1, CEPH_OSD_OP_WRITE,
+				    page_off, &wlen, op_idx, op_idx + 1,
+				    CEPH_OSD_OP_WRITE,
 				    CEPH_OSD_FLAG_WRITE, snapc,
 				    ceph_wbc.truncate_seq,
 				    ceph_wbc.truncate_size, true);
@@ -1141,6 +1144,9 @@ static int write_folio_nounlock(struct folio *folio,
 		return PTR_ERR(req);
 	}
 
+	if (alloc_hint_flags)
+		osd_req_op_alloc_hint_init(req, 0, 0, 0, alloc_hint_flags);
+
 	if (wlen < len)
 		len = wlen;
 
@@ -1167,7 +1173,7 @@ static int write_folio_nounlock(struct folio *folio,
 	/* it may be a short write due to an object boundary */
 	WARN_ON_ONCE(start + len > folio_size(folio));
 	page = bounce_page ? bounce_page : &folio->page;
-	osd_req_op_extent_osd_data_pages(req, 0, &page, wlen, start, false,
+	osd_req_op_extent_osd_data_pages(req, op_idx, &page, wlen, start, false,
 					 false);
 	boutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
 	      ceph_vinop(inode), page_off, len, wlen,
@@ -1252,6 +1258,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
 	unsigned int len = 0;
+	unsigned int first_write_op = 0;
 	bool remove_page;
 	struct ceph_journal_info __ji;
 
@@ -1277,8 +1284,12 @@ static void writepages_finish(struct ceph_osd_request *req)
 	remove_page = !(ceph_caps_issued(ci) &
 			(CEPH_CAP_FILE_CACHE|CEPH_CAP_FILE_LAZYIO));
 
+	if (req->r_num_ops > 1 &&
+	    req->r_ops[0].op == CEPH_OSD_OP_SETALLOCHINT)
+		first_write_op = 1;
+
 	/* clean all pages */
-	for (i = 0; i < req->r_num_ops; i++) {
+	for (i = first_write_op; i < req->r_num_ops; i++) {
 		if (req->r_ops[i].op != CEPH_OSD_OP_WRITE) {
 			pr_warn_client(cl,
 				"%llx.%llx incorrect op %d req %p index %d tid %llu\n",
@@ -1342,7 +1353,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 
 	ceph_put_wrbuffer_cap_refs(ci, total_pages, snapc);
 
-	osd_data = osd_req_op_extent_osd_data(req, 0);
+	osd_data = osd_req_op_extent_osd_data(req, first_write_op);
 	if (osd_data->pages_from_pool)
 		mempool_free(osd_data->pages, ceph_wb_pagevec_pool);
 	else
@@ -1645,10 +1656,14 @@ bool is_folio_index_contiguous(const struct ceph_writeback_ctl *ceph_wbc,
 }
 
 static inline
-bool is_num_ops_too_big(struct ceph_writeback_ctl *ceph_wbc)
+bool is_num_ops_too_big(struct ceph_fs_client *fsc,
+			struct ceph_writeback_ctl *ceph_wbc)
 {
-	return ceph_wbc->num_ops >=
-		(ceph_wbc->from_pool ?  CEPH_OSD_SLAB_OPS : CEPH_OSD_MAX_OPS);
+	unsigned int extra_ops =
+		READ_ONCE(fsc->mount_options->alloc_hint_flags) ? 1 : 0;
+
+	return ceph_wbc->num_ops + extra_ops >=
+		(ceph_wbc->from_pool ? CEPH_OSD_SLAB_OPS : CEPH_OSD_MAX_OPS);
 }
 
 static inline
@@ -1754,7 +1769,7 @@ void ceph_process_folio_batch(struct address_space *mapping,
 		 */
 		if (ceph_wbc->locked_pages &&
 		    !is_folio_index_contiguous(ceph_wbc, folio) &&
-		    is_num_ops_too_big(ceph_wbc)) {
+		    is_num_ops_too_big(fsc, ceph_wbc)) {
 			folio_unlock(folio);
 			break;
 		}
@@ -1854,6 +1869,8 @@ int ceph_submit_write(struct address_space *mapping,
 	struct ceph_osd_request *req = NULL;
 	struct folio *folio = NULL;
 	bool caching = ceph_is_cache_enabled(inode);
+	u32 alloc_hint_flags;
+	unsigned int first_op, write_ops, submitted_ops;
 	u64 offset, start, end, last_len = 0;
 	u64 len;
 	unsigned int i, align;
@@ -1862,19 +1879,25 @@ int ceph_submit_write(struct address_space *mapping,
 	folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[0]));
 	ceph_folio_write_range(folio, &offset, &end);
 	len = ceph_wbc->wsize;
+	alloc_hint_flags = READ_ONCE(fsc->mount_options->alloc_hint_flags);
+	first_op = alloc_hint_flags ? 1 : 0;
+	write_ops = min_t(unsigned int, ceph_wbc->num_ops,
+			  CEPH_OSD_MAX_OPS - first_op);
 
 	req = ceph_osdc_new_request(&fsc->client->osdc,
 				    &ci->i_layout, vino,
-				    offset, &len, 0, ceph_wbc->num_ops,
+				    offset, &len, first_op,
+				    write_ops + first_op,
 				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE,
 				    ceph_wbc->snapc, ceph_wbc->truncate_seq,
 				    ceph_wbc->truncate_size, false);
 	if (IS_ERR(req)) {
+		write_ops = min_t(unsigned int, ceph_wbc->num_ops,
+				  CEPH_OSD_SLAB_OPS - first_op);
 		req = ceph_osdc_new_request(&fsc->client->osdc,
 					    &ci->i_layout, vino,
-					    offset, &len, 0,
-					    min(ceph_wbc->num_ops,
-						CEPH_OSD_SLAB_OPS),
+					    offset, &len, first_op,
+					    write_ops + first_op,
 					    CEPH_OSD_OP_WRITE,
 					    CEPH_OSD_FLAG_WRITE,
 					    ceph_wbc->snapc,
@@ -1884,6 +1907,9 @@ int ceph_submit_write(struct address_space *mapping,
 		BUG_ON(IS_ERR(req));
 	}
 
+	if (alloc_hint_flags)
+		osd_req_op_alloc_hint_init(req, 0, 0, 0, alloc_hint_flags);
+
 	folio = ceph_fscrypt_pagecache_folio(
 			page_folio(ceph_wbc->pages[ceph_wbc->locked_pages - 1]));
 	ceph_folio_write_range(folio, &start, &end);
@@ -1926,7 +1952,7 @@ int ceph_submit_write(struct address_space *mapping,
 	/* Format the osd request message and submit the write */
 	len = 0;
 	ceph_wbc->data_pages = ceph_wbc->pages;
-	ceph_wbc->op_idx = 0;
+	ceph_wbc->op_idx = first_op;
 	align = offset_in_page(offset);
 	for (i = 0; i < ceph_wbc->locked_pages; i++) {
 		u64 cur_offset;
@@ -2010,10 +2036,11 @@ int ceph_submit_write(struct address_space *mapping,
 
 	BUG_ON(ceph_wbc->op_idx + 1 != req->r_num_ops);
 
+	submitted_ops = req->r_num_ops - first_op;
 	ceph_wbc->from_pool = false;
 	if (i < ceph_wbc->locked_pages) {
-		BUG_ON(ceph_wbc->num_ops <= req->r_num_ops);
-		ceph_wbc->num_ops -= req->r_num_ops;
+		BUG_ON(ceph_wbc->num_ops <= submitted_ops);
+		ceph_wbc->num_ops -= submitted_ops;
 		ceph_wbc->locked_pages -= i;
 
 		/* allocate new pages array for next request */
@@ -2024,7 +2051,7 @@ int ceph_submit_write(struct address_space *mapping,
 		memset(ceph_wbc->data_pages + i, 0,
 			ceph_wbc->locked_pages * sizeof(*ceph_wbc->pages));
 	} else {
-		BUG_ON(ceph_wbc->num_ops != req->r_num_ops);
+		BUG_ON(ceph_wbc->num_ops != submitted_ops);
 		/* request message now owns the pages array */
 		ceph_wbc->pages = NULL;
 	}
@@ -3081,6 +3108,8 @@ int ceph_uninline_data(struct file *file)
 	struct ceph_snap_context *snapc = NULL;
 	u64 inline_version = CEPH_INLINE_NONE;
 	struct page *pages[1];
+	u32 alloc_hint_flags;
+	unsigned int write_op;
 	int err = 0;
 	u64 len;
 
@@ -3152,18 +3181,23 @@ int ceph_uninline_data(struct file *file)
 	if (err < 0)
 		goto out_unlock;
 
+	alloc_hint_flags = READ_ONCE(fsc->mount_options->alloc_hint_flags);
+	write_op = alloc_hint_flags ? 2 : 1;
+
 	req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
-				    ceph_vino(inode), 0, &len, 1, 3,
-				    CEPH_OSD_OP_WRITE, CEPH_OSD_FLAG_WRITE,
-				    snapc, ci->i_truncate_seq,
-				    ci->i_truncate_size, false);
+				    ceph_vino(inode), 0, &len, write_op,
+				    write_op + 2, CEPH_OSD_OP_WRITE,
+				    CEPH_OSD_FLAG_WRITE, snapc,
+				    ci->i_truncate_seq, ci->i_truncate_size,
+				    false);
 	if (IS_ERR(req)) {
 		err = PTR_ERR(req);
 		goto out_unlock;
 	}
 
 	pages[0] = folio_page(folio, 0);
-	osd_req_op_extent_osd_data_pages(req, 1, pages, len, 0, false, false);
+	osd_req_op_extent_osd_data_pages(req, write_op, pages, len, 0,
+					 false, false);
 
 	{
 		__le64 xattr_buf = cpu_to_le64(inline_version);
@@ -3176,11 +3210,15 @@ int ceph_uninline_data(struct file *file)
 			goto out_put_req;
 	}
 
+	if (alloc_hint_flags)
+		osd_req_op_alloc_hint_init(req, 1, 0, 0, alloc_hint_flags);
+
 	{
 		char xattr_buf[32];
 		int xattr_len = snprintf(xattr_buf, sizeof(xattr_buf),
 					 "%llu", inline_version);
-		err = osd_req_op_xattr_init(req, 2, CEPH_OSD_OP_SETXATTR,
+		err = osd_req_op_xattr_init(req, write_op + 1,
+					    CEPH_OSD_OP_SETXATTR,
 					    "inline_version",
 					    xattr_buf, xattr_len, 0, 0);
 		if (err)
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 75fb12be209b..1b9481171fe0 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1399,8 +1399,11 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 	int rc = req->r_result;
 	struct inode *inode = req->r_inode;
 	struct ceph_aio_request *aio_req = req->r_priv;
-	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
-	struct ceph_osd_req_op *op = &req->r_ops[0];
+	unsigned int op_idx = (req->r_num_ops > 1 &&
+			       req->r_ops[0].op == CEPH_OSD_OP_SETALLOCHINT) ?
+			      1 : 0;
+	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, op_idx);
+	struct ceph_osd_req_op *op = &req->r_ops[op_idx];
 	struct ceph_client_metric *metric = &ceph_sb_to_mdsc(inode->i_sb)->metric;
 	unsigned int len = osd_data->bvec_pos.iter.bi_size;
 	bool sparse = (op->op == CEPH_OSD_OP_SPARSE_READ);
@@ -1497,6 +1500,7 @@ static void ceph_aio_retry_work(struct work_struct *work)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
 	struct ceph_osd_request *req;
+	unsigned int i, op_idx;
 	int ret;
 
 	spin_lock(&ci->i_ceph_lock);
@@ -1512,8 +1516,8 @@ static void ceph_aio_retry_work(struct work_struct *work)
 	}
 	spin_unlock(&ci->i_ceph_lock);
 
-	req = ceph_osdc_alloc_request(orig_req->r_osdc, snapc, 1,
-			false, GFP_NOFS);
+	req = ceph_osdc_alloc_request(orig_req->r_osdc, snapc,
+				      orig_req->r_num_ops, false, GFP_NOFS);
 	if (!req) {
 		ret = -ENOMEM;
 		req = orig_req;
@@ -1524,10 +1528,13 @@ static void ceph_aio_retry_work(struct work_struct *work)
 	ceph_oloc_copy(&req->r_base_oloc, &orig_req->r_base_oloc);
 	ceph_oid_copy(&req->r_base_oid, &orig_req->r_base_oid);
 
-	req->r_ops[0] = orig_req->r_ops[0];
+	for (i = 0; i < orig_req->r_num_ops; i++)
+		req->r_ops[i] = orig_req->r_ops[i];
 
+	op_idx = (orig_req->r_num_ops > 1 &&
+		  orig_req->r_ops[0].op == CEPH_OSD_OP_SETALLOCHINT) ? 1 : 0;
 	req->r_mtime = aio_req->mtime;
-	req->r_data_offset = req->r_ops[0].extent.offset;
+	req->r_data_offset = req->r_ops[op_idx].extent.offset;
 
 	ret = ceph_osdc_alloc_messages(req, GFP_NOFS);
 	if (ret) {
@@ -1609,6 +1616,9 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 		struct ceph_osd_req_op *op;
 		int readop = sparse ? CEPH_OSD_OP_SPARSE_READ : CEPH_OSD_OP_READ;
 		int extent_cnt;
+		u32 alloc_hint_flags = write ?
+			READ_ONCE(fsc->mount_options->alloc_hint_flags) : 0;
+		unsigned int op_idx = alloc_hint_flags ? 1 : 0;
 
 		if (write)
 			size = min_t(u64, size, fsc->mount_options->wsize);
@@ -1617,8 +1627,8 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 
 		vino = ceph_vino(inode);
 		req = ceph_osdc_new_request(&fsc->client->osdc, &ci->i_layout,
-					    vino, pos, &size, 0,
-					    1,
+					    vino, pos, &size, op_idx,
+					    op_idx + 1,
 					    write ? CEPH_OSD_OP_WRITE : readop,
 					    flags, snapc,
 					    ci->i_truncate_seq,
@@ -1629,7 +1639,11 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 			break;
 		}
 
-		op = &req->r_ops[0];
+		if (alloc_hint_flags)
+			osd_req_op_alloc_hint_init(req, 0, 0, 0,
+						   alloc_hint_flags);
+
+		op = &req->r_ops[op_idx];
 		if (!write && sparse) {
 			extent_cnt = __ceph_sparse_read_ext_count(inode, size);
 			ret = ceph_alloc_sparse_ext_map(op, extent_cnt);
@@ -1646,9 +1660,10 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 			break;
 		}
 		if (len != size)
-			osd_req_op_extent_update(req, 0, len);
+			osd_req_op_extent_update(req, op_idx, len);
 
-		osd_req_op_extent_osd_data_bvecs(req, 0, bvecs, num_bvecs, len);
+		osd_req_op_extent_osd_data_bvecs(req, op_idx, bvecs, num_bvecs,
+						 len);
 
 		/*
 		 * To simplify error handling, allow AIO when IO within i_size
@@ -1841,6 +1856,8 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		bool first, last;
 		struct iov_iter saved_iter = *from;
 		size_t off;
+		u32 alloc_hint_flags;
+		unsigned int write_op;
 
 		ceph_fscrypt_adjust_off_and_len(inode, &write_pos, &write_len);
 
@@ -2095,9 +2112,13 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			}
 		}
 
+		alloc_hint_flags =
+			READ_ONCE(fsc->mount_options->alloc_hint_flags);
+		write_op = (rmw ? 1 : 0) + (alloc_hint_flags ? 1 : 0);
+
 		req = ceph_osdc_new_request(osdc, &ci->i_layout,
-					    ceph_vino(inode), write_pos, &write_len,
-					    rmw ? 1 : 0, rmw ? 2 : 1,
+					    ceph_vino(inode), write_pos,
+					    &write_len, write_op, write_op + 1,
 					    CEPH_OSD_OP_WRITE,
 					    CEPH_OSD_FLAG_WRITE,
 					    snapc, ci->i_truncate_seq,
@@ -2109,9 +2130,10 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		}
 
 		boutc(cl, "write op %lld~%llu\n", write_pos, write_len);
-		osd_req_op_extent_osd_data_pages(req, rmw ? 1 : 0, pages, write_len,
-						 offset_in_page(write_pos), false,
-						 true);
+		osd_req_op_extent_osd_data_pages(req, write_op, pages,
+						 write_len,
+						 offset_in_page(write_pos),
+						 false, true);
 		req->r_inode = inode;
 		req->r_mtime = mtime;
 
@@ -2132,6 +2154,10 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 			}
 		}
 
+		if (alloc_hint_flags)
+			osd_req_op_alloc_hint_init(req, rmw ? 1 : 0, 0, 0,
+						   alloc_hint_flags);
+
 		ceph_osdc_start_request(osdc, req);
 		ret = ceph_osdc_wait_request(osdc, req);
 
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index bb5591c1e154..1c2f192ee7d2 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -177,6 +177,7 @@ enum {
 	Opt_snapdirname,
 	Opt_mds_namespace,
 	Opt_recover_session,
+	Opt_compression_hint,
 	Opt_source,
 	Opt_mon_addr,
 	Opt_test_dummy_encryption,
@@ -210,12 +211,27 @@ static const struct constant_table ceph_param_recover[] = {
 	{}
 };
 
+enum ceph_compression_hint {
+	Opt_compression_hint_none,
+	Opt_compression_hint_compressible,
+	Opt_compression_hint_incompressible,
+};
+
+static const struct constant_table ceph_param_compression_hint[] = {
+	{ "none",		Opt_compression_hint_none },
+	{ "compressible",	Opt_compression_hint_compressible },
+	{ "incompressible",	Opt_compression_hint_incompressible },
+	{}
+};
+
 static const struct fs_parameter_spec ceph_mount_parameters[] = {
 	fsparam_flag_no ("acl",				Opt_acl),
 	fsparam_flag_no ("asyncreaddir",		Opt_asyncreaddir),
 	fsparam_s32	("caps_max",			Opt_caps_max),
 	fsparam_u32	("caps_wanted_delay_max",	Opt_caps_wanted_delay_max),
 	fsparam_u32	("caps_wanted_delay_min",	Opt_caps_wanted_delay_min),
+	fsparam_enum	("compression_hint",		Opt_compression_hint,
+			 ceph_param_compression_hint),
 	fsparam_u32	("write_congestion_kb",		Opt_congestion_kb),
 	fsparam_flag_no ("copyfrom",			Opt_copyfrom),
 	fsparam_flag_no ("dcache",			Opt_dcache),
@@ -250,6 +266,7 @@ static const struct fs_parameter_spec ceph_mount_parameters[] = {
 struct ceph_parse_opts_ctx {
 	struct ceph_options		*copts;
 	struct ceph_mount_options	*opts;
+	bool				compression_hint_set;
 };
 
 /*
@@ -470,6 +487,30 @@ static int ceph_parse_mount_param(struct fs_context *fc,
 		else
 			BUG();
 		break;
+	case Opt_compression_hint:
+		switch (result.uint_32) {
+		case Opt_compression_hint_none:
+			fsopt->alloc_hint_flags &=
+				~(CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE |
+				  CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE);
+			break;
+		case Opt_compression_hint_compressible:
+			fsopt->alloc_hint_flags |=
+				CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE;
+			fsopt->alloc_hint_flags &=
+				~CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE;
+			break;
+		case Opt_compression_hint_incompressible:
+			fsopt->alloc_hint_flags |=
+				CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE;
+			fsopt->alloc_hint_flags &=
+				~CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE;
+			break;
+		default:
+			BUG();
+		}
+		pctx->compression_hint_set = true;
+		break;
 	case Opt_source:
 		if (fc->source)
 			return invalfc(fc, "Multiple sources specified");
@@ -729,6 +770,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(root->d_sb);
 	struct ceph_mount_options *fsopt = fsc->mount_options;
+	u32 alloc_hint_flags = READ_ONCE(fsopt->alloc_hint_flags);
 	size_t pos;
 	int ret;
 
@@ -782,6 +824,11 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 	if (fsopt->flags & CEPH_MOUNT_OPT_CLEANRECOVER)
 		seq_show_option(m, "recover_session", "clean");
 
+	if (alloc_hint_flags & CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE)
+		seq_show_option(m, "compression_hint", "compressible");
+	else if (alloc_hint_flags & CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE)
+		seq_show_option(m, "compression_hint", "incompressible");
+
 	if (!(fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS))
 		seq_puts(m, ",wsync");
 	if (fsopt->flags & CEPH_MOUNT_OPT_NOPAGECACHE)
@@ -1484,6 +1531,10 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
 	else
 		ceph_clear_mount_opt(fsc, LAZYIO);
 
+	if (pctx->compression_hint_set)
+		WRITE_ONCE(fsc->mount_options->alloc_hint_flags,
+			   fsopt->alloc_hint_flags);
+
 	if (strcmp_null(fsc->mount_options->mon_addr, fsopt->mon_addr)) {
 		kfree(fsc->mount_options->mon_addr);
 		fsc->mount_options->mon_addr = fsopt->mon_addr;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 0e6c8968b80d..7955e5e1e755 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -94,6 +94,7 @@ struct ceph_mount_options {
 	int caps_max;
 	unsigned int max_readdir;       /* max readdir result (entries) */
 	unsigned int max_readdir_bytes; /* max readdir result (bytes) */
+	u32 alloc_hint_flags;           /* CEPH_OSD_ALLOC_HINT_FLAG_* */
 
 	bool new_dev_syntax;
 
-- 
2.48.1

