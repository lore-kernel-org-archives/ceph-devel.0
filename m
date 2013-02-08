From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 1/6] common/fiemap.cc: fix realloc memory leak
Date: Fri,  8 Feb 2013 17:24:58 +0100
Message-ID: <1360340703-7170-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:39591 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946664Ab3BHQZH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:25:07 -0500
In-Reply-To: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix error from cppcheck:

[src/common/fiemap.cc:73]: (error) Common realloc mistake: 'fiemap'
  nulled but not freed upon failure

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/common/fiemap.cc | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/common/fiemap.cc b/src/common/fiemap.cc
index 0df12d6..a1d5fbe 100644
--- a/src/common/fiemap.cc
+++ b/src/common/fiemap.cc
@@ -40,6 +40,7 @@
 struct fiemap *read_fiemap(int fd)
 {
   struct fiemap *fiemap;
+  struct fiemap *_realloc_fiemap = NULL;
   int extents_size;
   int r;
 
@@ -62,18 +63,20 @@ struct fiemap *read_fiemap(int fd)
   }
 
   if (!fiemap->fm_mapped_extents) {
-    free(fiemap);
-    return NULL;
+    goto done_err;
   }
 
   /* Read in the extents */
   extents_size = sizeof(struct fiemap_extent) * (fiemap->fm_mapped_extents);
 
   /* Resize fiemap to allow us to read in the extents */
-  if ((fiemap = (struct fiemap*)realloc(fiemap,sizeof(struct fiemap) +
+
+  if ((_realloc_fiemap = (struct fiemap*)realloc(fiemap,sizeof(struct fiemap) +
                                         extents_size)) == NULL) {
     fprintf(stderr, "Out of memory allocating fiemap\n");
     goto done_err;
+  } else {
+    fiemap = _realloc_fiemap;
   }
 
   memset(fiemap->fm_extents, 0, extents_size);
-- 
1.8.1.2

