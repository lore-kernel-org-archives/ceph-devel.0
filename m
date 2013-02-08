From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 2/6] os/FileStore.cc: fix realloc memory leak in error case
Date: Fri,  8 Feb 2013 17:24:59 +0100
Message-ID: <1360340703-7170-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:39576 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946646Ab3BHQZG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:25:06 -0500
In-Reply-To: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix error from cppcheck:

[src/os/FileStore.cc:512]: (error) Common realloc mistake: 'fiemap'
  nulled but not freed upon failure

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/os/FileStore.cc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/os/FileStore.cc b/src/os/FileStore.cc
index 1bab9c3..44f3b57 100644
--- a/src/os/FileStore.cc
+++ b/src/os/FileStore.cc
@@ -490,6 +490,7 @@ bool parse_attrname(char **name)
 static int do_fiemap(int fd, off_t start, size_t len, struct fiemap **pfiemap)
 {
   struct fiemap *fiemap = NULL;
+  struct fiemap *_realloc_fiemap = NULL;
   int size;
   int ret;
 
@@ -509,11 +510,13 @@ static int do_fiemap(int fd, off_t start, size_t len, struct fiemap **pfiemap)
 
   size = sizeof(struct fiemap_extent) * (fiemap->fm_mapped_extents);
 
-  fiemap = (struct fiemap *)realloc(fiemap, sizeof(struct fiemap) +
+  _realloc_fiemap = (struct fiemap *)realloc(fiemap, sizeof(struct fiemap) +
                                     size);
-  if (!fiemap) {
+  if (!_realloc_fiemap) {
     ret = -ENOMEM;
     goto done_err;
+  } else {
+    fiemap = _realloc_fiemap;
   }
 
   memset(fiemap->fm_extents, 0, size);
-- 
1.8.1.2

