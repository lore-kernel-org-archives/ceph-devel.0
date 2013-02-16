From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] ceph: kill ceph_osdc_writepages() "flags" parameter
Date: Sat, 16 Feb 2013 10:31:39 -0600
Message-ID: <511FB46B.40906@inktank.com>
References: <511FB409.8080007@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:64253 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753600Ab3BPQig (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 11:38:36 -0500
Received: by mail-qe0-f42.google.com with SMTP id 2so1914019qeb.1
        for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 08:38:35 -0800 (PST)
In-Reply-To: <511FB409.8080007@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is only one caller of ceph_osdc_writepages(), and it always
passes 0 as its "flags" argument.  Get rid of that argument and
replace its use in ceph_osdc_writepages() with 0.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/addr.c                  |    3 +--
 include/linux/ceph/osd_client.h |    3 +--
 net/ceph/osd_client.c           |    6 ++----
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index bef5528..8d3240d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -492,8 +492,7 @@ static int writepage_nounlock(struct page *page,
struct writeback_control *wbc)
 				   &ci->i_layout, snapc,
 				   page_off, len,
 				   ci->i_truncate_seq, ci->i_truncate_size,
-				   &inode->i_mtime,
-				   &page, 1, 0);
+				   &inode->i_mtime, &page, 1);
 	if (err < 0) {
 		dout("writepage setting page/mapping error %d %p\n", err, page);
 		SetPageError(page);
diff --git a/include/linux/ceph/osd_client.h
b/include/linux/ceph/osd_client.h
index 7a63100..6540e88 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -274,8 +274,7 @@ extern int ceph_osdc_writepages(struct
ceph_osd_client *osdc,
 				u64 off, u64 len,
 				u32 truncate_seq, u64 truncate_size,
 				struct timespec *mtime,
-				struct page **pages, int nr_pages,
-				int flags);
+				struct page **pages, int nr_pages);

 /* watch/notify events */
 extern int ceph_osdc_create_event(struct ceph_osd_client *osdc,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ac186b7..d4e3812 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1866,8 +1866,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 			 u64 off, u64 len,
 			 u32 truncate_seq, u64 truncate_size,
 			 struct timespec *mtime,
-			 struct page **pages, int num_pages,
-			 int flags)
+			 struct page **pages, int num_pages)
 {
 	struct ceph_osd_request *req;
 	int rc = 0;
@@ -1876,8 +1875,7 @@ int ceph_osdc_writepages(struct ceph_osd_client
*osdc, struct ceph_vino vino,
 	BUG_ON(vino.snap != CEPH_NOSNAP);
 	req = ceph_osdc_new_request(osdc, layout, vino, off, &len,
 				    CEPH_OSD_OP_WRITE,
-				    flags | CEPH_OSD_FLAG_ONDISK |
-					    CEPH_OSD_FLAG_WRITE,
+				    CEPH_OSD_FLAG_ONDISK | CEPH_OSD_FLAG_WRITE,
 				    snapc, 0,
 				    truncate_seq, truncate_size, mtime,
 				    true, 1, page_align);
-- 
1.7.9.5

