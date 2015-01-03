From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] ceph: use %zu for size_t display
Date: Sat,  3 Jan 2015 18:02:11 +0100
Message-ID: <1420304531-15176-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Fixes the following 32-bit compilation warning:
fs/ceph/addr.c:1419:2: warning: format '%lu' expects argument of type
'long unsigned int', but argument 5 has type 'size_t' [-Wformat=]

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/ceph/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index f5013d9..c81c0e0 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1416,7 +1416,7 @@ void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
 		}
 	}
 
-	dout("fill_inline_data %p %llx.%llx len %lu locked_page %p\n",
+	dout("fill_inline_data %p %llx.%llx len %zu locked_page %p\n",
 	     inode, ceph_vinop(inode), len, locked_page);
 
 	if (len > 0) {
-- 
2.1.0
