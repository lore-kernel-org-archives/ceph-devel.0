From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH 1/2] ceph: Clean up if error occurred in finish_read()
Date: Wed, 27 Nov 2013 22:28:13 +0800
Message-ID: <1947b705cc4c308f96591b19bbe0065d13a1058e.1385561919.git.liwang@ubuntukylin.com>
References: <cover.1385561919.git.liwang@ubuntukylin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1385561919.git.liwang@ubuntukylin.com>
In-Reply-To: <cover.1385561919.git.liwang@ubuntukylin.com>
References: <cover.1385561919.git.liwang@ubuntukylin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>
List-Id: ceph-devel.vger.kernel.org

Clean up if error occurred rather than going through normal process

Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
---
 fs/ceph/addr.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1e561c0..97845b4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -252,6 +252,8 @@ static void finish_read(struct ceph_osd_request *req, struct ceph_msg *msg)
 	for (i = 0; i < num_pages; i++) {
 		struct page *page = osd_data->pages[i];
 
+		if (rc < 0)
+			goto unlock;
 		if (bytes < (int)PAGE_CACHE_SIZE) {
 			/* zero (remainder of) page */
 			int s = bytes < 0 ? 0 : bytes;
@@ -262,6 +264,7 @@ static void finish_read(struct ceph_osd_request *req, struct ceph_msg *msg)
 		flush_dcache_page(page);
 		SetPageUptodate(page);
 		ceph_readpage_to_fscache(inode, page);
+unlock:
 		unlock_page(page);
 		page_cache_release(page);
 		bytes -= PAGE_CACHE_SIZE;
-- 
1.7.9.5
