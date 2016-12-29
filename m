From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ceph: fix spelling mistake: "enabing" -> "enabling"
Date: Thu, 29 Dec 2016 20:19:32 +0000
Message-ID: <20161229201932.27115-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56095 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbcL2UUT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2016 15:20:19 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in debug message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ceph/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 5bc5d37..4e7421c 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -234,7 +234,7 @@ void ceph_fscache_file_set_cookie(struct inode *inode, struct file *filp)
 		fscache_enable_cookie(ci->fscache, ceph_fscache_can_enable,
 				inode);
 		if (fscache_cookie_enabled(ci->fscache)) {
-			dout("fscache_file_set_cookie %p %p enabing cache\n",
+			dout("fscache_file_set_cookie %p %p enabling cache\n",
 			     inode, filp);
 		}
 	}
-- 
2.10.2

