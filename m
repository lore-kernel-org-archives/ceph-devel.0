From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 3/3] rbd-fuse: fix printf format for off_t and size_t
Date: Mon, 28 Jan 2013 16:33:44 +0100
Message-ID: <1359387224-6769-4-git-send-email-danny.al-gaaf@bisect.de>
References: <1359387224-6769-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:38894 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751872Ab3A1Pdt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 28 Jan 2013 10:33:49 -0500
In-Reply-To: <1359387224-6769-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>, Dan Mick <dan.mick@inktank.com>

Fix printf format for off_t and size_t to print the same on 32 and 64bit
systems. Use PRI* macros from inttypes.h.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/rbd_fuse/rbd-fuse.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/rbd_fuse/rbd-fuse.c b/src/rbd_fuse/rbd-fuse.c
index c204463..748976a 100644
--- a/src/rbd_fuse/rbd-fuse.c
+++ b/src/rbd_fuse/rbd-fuse.c
@@ -15,6 +15,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include <getopt.h>
+#include <inttypes.h>
 
 #include "include/rbd/librbd.h"
 
@@ -321,7 +322,7 @@ static int rbdfs_write(const char *path, const char *buf, size_t size,
 
 		if (offset + size > rbdsize(fi->fh)) {
 			int r;
-			fprintf(stderr, "rbdfs_write resizing %s to 0x%lx\n",
+			fprintf(stderr, "rbdfs_write resizing %s to 0x%"PRIxMAX"\n",
 				path, offset+size);
 			r = rbd_resize(rbd->image, offset+size);
 			if (r < 0)
@@ -516,7 +517,7 @@ rbdfs_truncate(const char *path, off_t size)
 		return -ENOENT;
 
 	rbd = &opentbl[fd];
-	fprintf(stderr, "truncate %s to %ld (0x%lx)\n", path, size, size);
+	fprintf(stderr, "truncate %s to %"PRIdMAX" (0x%"PRIxMAX")\n", path, size, size);
 	r = rbd_resize(rbd->image, size);
 	if (r < 0)
 		return r;
@@ -559,7 +560,7 @@ rbdfs_setxattr(const char *path, const char *name, const char *value,
 	for (ap = attrs; ap->attrname != NULL; ap++) {
 		if (strcmp(name, ap->attrname) == 0) {
 			*ap->attrvalp = strtoull(value, NULL, 0);
-			fprintf(stderr, "rbd-fuse: %s set to 0x%lx\n",
+			fprintf(stderr, "rbd-fuse: %s set to 0x%"PRIx64"\n",
 				ap->attrname, *ap->attrvalp);
 			return 0;
 		}
@@ -578,7 +579,7 @@ rbdfs_getxattr(const char *path, const char *name, char *value,
 
 	for (ap = attrs; ap->attrname != NULL; ap++) {
 		if (strcmp(name, ap->attrname) == 0) {
-			sprintf(buf, "%lu", *ap->attrvalp);
+			sprintf(buf, "%"PRIu64, *ap->attrvalp);
 			if (value != NULL && size >= strlen(buf))
 				strcpy(value, buf);
 			fprintf(stderr, "rbd-fuse: get %s\n", ap->attrname);
-- 
1.8.1.1

