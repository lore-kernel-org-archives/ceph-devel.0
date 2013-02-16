From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/4] ceph: kill ceph_osdc_writepages() "nofail" parameter
Date: Sat, 16 Feb 2013 10:31:04 -0600
Message-ID: <511FB448.5080405@inktank.com>
References: <511FB409.8080007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:53691 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551Ab3BPQbH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:31:07 -0500
Received: by mail-qe0-f48.google.com with SMTP id 3so1857859qea.7
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:31:06 -0800 (PST)
In-Reply-To: <511FB409.8080007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is only one caller of ceph_osdc_writepages(), and it always
passes the value true as its "nofail" argument.  Get rid of that
argument and replace its use in ceph_osdc_writepages() with the
constant value true.

This and a number of cleanup patches that follow resolve:
    http://tracker.ceph.com/issues/4126

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c                  |    2 +-
 include/linux/ceph/osd_client.h |    2 +-
 net/ceph/osd_client.c           |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 064d1a6..c7e401c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -493,7 +493,7 @@ static int writepage_nounlock(struct page *page,
struct writeback_control *wbc)
 				   page_off, len,
 				   ci->i_truncate_seq, ci->i_truncate_size,
 				   &inode->i_mtime,
-				   &page, 1, 0, 0, true);
+				   &page, 1, 0, 0);
 	if (err < 0) {
 		dout("writepage setting page/mapping error %d %p\n", err, page);
 		SetPageError(page);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 82bf633..afcb255 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -275,7 +275,7 @@ extern int ceph_osdc_writepages(struct
ceph_osd_client *osdc,
 				u32 truncate_seq, u64 truncate_size,
 				struct timespec *mtime,
 				struct page **pages, int nr_pages,
-				int flags, int do_sync, bool nofail);
+				int flags, int do_sync);

 /* watch/notify events */
 extern int ceph_osdc_create_event(struct ceph_osd_client *osdc,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index d9d58bb..dd01b13 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1867,7 +1867,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 			 u32 truncate_seq, u64 truncate_size,
 			 struct timespec *mtime,
 			 struct page **pages, int num_pages,
-			 int flags, int do_sync, bool nofail)
+			 int flags, int do_sync)
 {
 	struct ceph_osd_request *req;
 	int rc = 0;
@@ -1880,7 +1880,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 					    CEPH_OSD_FLAG_WRITE,
 				    snapc, do_sync,
 				    truncate_seq, truncate_size, mtime,
-				    nofail, 1, page_align);
+				    true, 1, page_align);
 	if (IS_ERR(req))
 		return PTR_ERR(req);

@@ -1889,7 +1889,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 	dout("writepages %llu~%llu (%d pages)\n", off, len,
 	     req->r_num_pages);

-	rc = ceph_osdc_start_request(osdc, req, nofail);
+	rc = ceph_osdc_start_request(osdc, req, true);
 	if (!rc)
 		rc = ceph_osdc_wait_request(osdc, req);

-- 
1.7.9.5

