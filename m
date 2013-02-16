From: Alex Elder <elder@inktank.com>
Subject: [PATCH 4/4] ceph: kill ceph_osdc_new_request() "num_reply"
Date: Sat, 16 Feb 2013 10:32:09 -0600
Message-ID: <511FB489.6070203@inktank.com>
References: <511FB409.8080007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f49.google.com ([209.85.128.49]:36267 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab3BPQcM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:32:12 -0500
Received: by mail-qe0-f49.google.com with SMTP id 5so1861901qea.22
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:32:11 -0800 (PST)
In-Reply-To: <511FB409.8080007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The "num_reply" parameter to ceph_osdc_new_request() is never
used inside that function, so get rid of it.

Note that ceph_sync_write() passes 2 for that argument, while all
other callers pass 1.  It doesn't matter, but perhaps someone should
verify this doesn't indicate a problem.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c                  |    4 ++--
 fs/ceph/file.c                  |    2 +-
 include/linux/ceph/osd_client.h |    3 +--
 net/ceph/osd_client.c           |    6 +++---
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8d3240d..fc61371 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -315,7 +315,7 @@ static int start_read(struct inode *inode, struct
list_head *page_list, int max)
 				    CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
 				    NULL, 0,
 				    ci->i_truncate_seq, ci->i_truncate_size,
-				    NULL, false, 1, 0);
+				    NULL, false, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

@@ -837,7 +837,7 @@ get_more_pages:
 					    snapc, do_sync,
 					    ci->i_truncate_seq,
 					    ci->i_truncate_size,
-					    &inode->i_mtime, true, 1, 0);
+					    &inode->i_mtime, true, 0);

 				if (IS_ERR(req)) {
 					rc = PTR_ERR(req);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a1e5b81..9c4325e 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -541,7 +541,7 @@ more:
 				    ci->i_snap_realm->cached_context,
 				    do_sync,
 				    ci->i_truncate_seq, ci->i_truncate_size,
-				    &mtime, false, 2, page_align);
+				    &mtime, false, page_align);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 6540e88..5812802 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -234,8 +234,7 @@ extern struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *,
 				      int do_sync, u32 truncate_seq,
 				      u64 truncate_size,
 				      struct timespec *mtime,
-				      bool use_mempool, int num_reply,
-				      int page_align);
+				      bool use_mempool, int page_align);

 extern void ceph_osdc_set_request_linger(struct ceph_osd_client *osdc,
 					 struct ceph_osd_request *req);
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d4e3812..d3e7513 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -393,7 +393,7 @@ struct ceph_osd_request
*ceph_osdc_new_request(struct ceph_osd_client *osdc,
 					       u32 truncate_seq,
 					       u64 truncate_size,
 					       struct timespec *mtime,
-					       bool use_mempool, int num_reply,
+					       bool use_mempool,
 					       int page_align)
 {
 	struct ceph_osd_req_op ops[2];
@@ -1837,7 +1837,7 @@ int ceph_osdc_readpages(struct ceph_osd_client *osdc,
 	req = ceph_osdc_new_request(osdc, layout, vino, off, plen,
 				    CEPH_OSD_OP_READ, CEPH_OSD_FLAG_READ,
 				    NULL, 0, truncate_seq, truncate_size, NULL,
-				    false, 1, page_align);
+				    false, page_align);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

@@ -1878,7 +1878,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
 				    snapc, 0,
 				    truncate_seq, truncate_size, mtime,
-				    true, 1, page_align);
+				    true, page_align);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

-- 
1.7.9.5

