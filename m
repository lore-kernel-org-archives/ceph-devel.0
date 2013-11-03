From: Xing Lin <xinglin@cs.utah.edu>
Subject: [PATCH] osd/erasurecode: correct one variable name in jerasure_matrix_to_bitmatrix()
Date: Sat,  2 Nov 2013 19:24:22 -0600
Message-ID: <1383441862-3623-1-git-send-email-xinglin@cs.utah.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:49890 "EHLO
	mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751225Ab3KCBY0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Nov 2013 21:24:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: xinglin@cs.utah.edu, sage@inktank.com

When bitmatrix is NULL, this function returns NULL.

Signed-off-by: Xing Lin <xinglin@cs.utah.edu>
---
 src/osd/ErasureCodePluginJerasure/jerasure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/osd/ErasureCodePluginJerasure/jerasure.c b/src/osd/ErasureCodePluginJerasure/jerasure.c
index 9efae02..d5752a8 100755
--- a/src/osd/ErasureCodePluginJerasure/jerasure.c
+++ b/src/osd/ErasureCodePluginJerasure/jerasure.c
@@ -276,7 +276,7 @@ int *jerasure_matrix_to_bitmatrix(int k, int m, int w, int *matrix)
   int rowelts, rowindex, colindex, elt, i, j, l, x;
 
   bitmatrix = talloc(int, k*m*w*w);
-  if (matrix == NULL) { return NULL; }
+  if (bitmatrix == NULL) { return NULL; }
 
   rowelts = k * w;
   rowindex = 0;
-- 
1.8.3.4 (Apple Git-47)

