From: Alex Elder <elder@inktank.com>
Subject: [PATCH 2/4] ceph: kill ceph_osdc_writepages() "dosync" parameter
Date: Sat, 16 Feb 2013 10:31:20 -0600
Message-ID: <511FB458.2050303@inktank.com>
References: <511FB409.8080007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f43.google.com ([209.85.128.43]:64911 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab3BPQbW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:31:22 -0500
Received: by mail-qe0-f43.google.com with SMTP id 3so1858870qeb.2
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:31:22 -0800 (PST)
In-Reply-To: <511FB409.8080007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is only one caller of ceph_osdc_writepages(), and it always
passes 0 as its "dosync" argument.  Get rid of that argument and
replace its use in ceph_osdc_writepages() with 0.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c                  |    2 +-
 include/linux/ceph/osd_client.h |    2 +-
 net/ceph/osd_client.c           |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c7e401c..bef5528 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -493,7 +493,7 @@ static int writepage_nounlock(struct page *page,
struct writeback_control *wbc)
 				   page_off, len,
 				   ci->i_truncate_seq, ci->i_truncate_size,
 				   &inode->i_mtime,
-				   &page, 1, 0, 0);
+				   &page, 1, 0);
 	if (err < 0) {
 		dout("writepage setting page/mapping error %d %p\n", err, page);
 		SetPageError(page);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index afcb255..7a63100 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -275,7 +275,7 @@ extern int ceph_osdc_writepages(struct
ceph_osd_client *osdc,
 				u32 truncate_seq, u64 truncate_size,
 				struct timespec *mtime,
 				struct page **pages, int nr_pages,
-				int flags, int do_sync);
+				int flags);

 /* watch/notify events */
 extern int ceph_osdc_create_event(struct ceph_osd_client *osdc,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index dd01b13..ac186b7 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1867,7 +1867,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 			 u32 truncate_seq, u64 truncate_size,
 			 struct timespec *mtime,
 			 struct page **pages, int num_pages,
-			 int flags, int do_sync)
+			 int flags)
 {
 	struct ceph_osd_request *req;
 	int rc = 0;
@@ -1878,7 +1878,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 				    CEPH_OSD_OP_WRITE,
 				    flags | CEPH_OSD_FLAG_ONDISK |
 					    CEPH_OSD_FLAG_WRITE,
-				    snapc, do_sync,
+				    snapc, 0,
 				    truncate_seq, truncate_size, mtime,
 				    true, 1, page_align);
 	if (IS_ERR(req))
-- 
1.7.9.5

