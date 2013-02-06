From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH] rbd-fuse: fix for loop in open_rbd_image()
Date: Wed,  6 Feb 2013 12:17:02 +0100
Message-ID: <1360149422-7224-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:33957 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757253Ab3BFLRH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 06:17:07 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Remove uninitialized usage of 'int i' as i++ from 'for' loop.
The variale 'i' is never used in this loop and initialized
before the next use with 0.

Related warning from clang++:

rbd_fuse/rbd-fuse.c:141:36: warning: variable 'i' is uninitialized
when used here [-Wuninitialized]
        for (im = rbd_images; im != NULL; i++, im = im->next) {

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/rbd_fuse/rbd-fuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rbd_fuse/rbd-fuse.c b/src/rbd_fuse/rbd-fuse.c
index 0b28f63..5bdaba3 100644
--- a/src/rbd_fuse/rbd-fuse.c
+++ b/src/rbd_fuse/rbd-fuse.c
@@ -138,7 +138,7 @@ open_rbd_image(const char *image_name)
 		return -1;
 
 	// relies on caller to keep rbd_images up to date
-	for (im = rbd_images; im != NULL; i++, im = im->next) {
+	for (im = rbd_images; im != NULL; im = im->next) {
 		if (strcmp(im->image_name, image_name) == 0) {
 			break;
 		}
-- 
1.8.1.2

