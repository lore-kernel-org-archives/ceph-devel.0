From: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH] ceph: fix a wrong comparison
Date: Wed, 10 Feb 2016 12:38:03 -0500
Message-ID: <1455125883-27735-1-git-send-email-a.s.protopopov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Protopopov <a.s.protopopov@gmail.com>
List-Id: ceph-devel.vger.kernel.org

A negative value rc compared to the positive value ENOENT in the
finish_read() function.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 fs/ceph/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c222137..1b809c9 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -276,7 +276,7 @@ static void finish_read(struct ceph_osd_request *req, struct ceph_msg *msg)
 	for (i = 0; i < num_pages; i++) {
 		struct page *page = osd_data->pages[i];
 
-		if (rc < 0 && rc != ENOENT)
+		if (rc < 0 && rc != -ENOENT)
 			goto unlock;
 		if (bytes < (int)PAGE_CACHE_SIZE) {
 			/* zero (remainder of) page */
-- 
2.6.5
