From: Xing Lin <xinglin@cs.utah.edu>
Subject: [PATCH] osd/erasurecode: Fix memory leak in jerasure_matrix_to_bitmatrix()
Date: Sat,  2 Nov 2013 00:58:13 -0600
Message-ID: <1383375493-2895-1-git-send-email-xinglin@cs.utah.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:40154 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab3KBG6Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Nov 2013 02:58:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@inktank.com, xinglin@cs.utah.edu

Free allocated memory before return because of NULL input

Signed-off-by: Xing Lin <xinglin@cs.utah.edu>
---
 src/osd/ErasureCodePluginJerasure/jerasure.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/osd/ErasureCodePluginJerasure/jerasure.c b/src/osd/ErasureCodePluginJerasure/jerasure.c
index 9efae02..1bb4b1d 100755
--- a/src/osd/ErasureCodePluginJerasure/jerasure.c
+++ b/src/osd/ErasureCodePluginJerasure/jerasure.c
@@ -276,7 +276,10 @@ int *jerasure_matrix_to_bitmatrix(int k, int m, int w, int *matrix)
   int rowelts, rowindex, colindex, elt, i, j, l, x;
 
   bitmatrix = talloc(int, k*m*w*w);
-  if (matrix == NULL) { return NULL; }
+  if (matrix == NULL) {
+    free(bitmatrix);
+    return NULL; 
+  }
 
   rowelts = k * w;
   rowindex = 0;
-- 
1.8.3.4 (Apple Git-47)

