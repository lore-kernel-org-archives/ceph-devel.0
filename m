From: Christian Brunner <chb@muc.de>
Subject: [PATCH 2/2] rbd: skip empty blocks during import
Date: Wed, 16 May 2012 16:28:51 +0200
Message-ID: <20120516142851.GB8485@sir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59434 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab2EPObL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 May 2012 10:31:11 -0400
Received: by bkcji2 with SMTP id ji2so674737bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 May 2012 07:31:10 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Check for empty blocks while importing an image.

When a read block only consists of zeroes, the import is simply
skipping the write. This way you non-sparse images will become sparse
rbd images.

Signed-off-by: Christian Brunner <chb@muc.de>
---
 src/rbd.cc |   44 ++++++++++++++++++++++++++------------------
 1 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/src/rbd.cc b/src/rbd.cc
index 0476cc5..d2b5b5a 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -513,7 +513,7 @@ static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
       while (cur_seg) {
         bufferptr p(cur_seg);
         //cerr << "reading " << cur_seg << " bytes at offset " << file_pos << std::endl;
-	ssize_t rval;
+	ssize_t rval, i;
 	if(extent == 0 && fiemap->fm_extents[extent].fe_logical == 0) {
 	  rval = TEMP_FAILURE_RETRY(::read(fd, p.c_str(), cur_seg));
 	} else {
@@ -529,23 +529,31 @@ static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
           r = 0;
           goto done;
         }
-        bufferlist bl;
-        bl.append(p);
-        librbd::RBD::AioCompletion *completion = new librbd::RBD::AioCompletion(NULL, NULL);
-        if (!completion) {
-          r = -ENOMEM;
-          goto done;
-        }
-        r = image.aio_write(file_pos, len, bl, completion);
-        if (r < 0)
-          goto done;
-	completion->wait_for_complete();
-	r = completion->get_return_value();
-	completion->release();
-        if (r < 0) {
-          cerr << "error writing to image block" << std::endl;
-          goto done;
-        }
+
+	/* Skip empty blocks */
+	char *pcstr = p.c_str();
+        for (i=0 ; i < len; i++) {
+	  if (pcstr[i] != 0) {
+            bufferlist bl;
+            bl.append(p);
+	    librbd::RBD::AioCompletion *completion = new librbd::RBD::AioCompletion(NULL, NULL);
+	    if (!completion) {
+	      r = -ENOMEM;
+              goto done;
+	    }
+	    r = image.aio_write(file_pos, len, bl, completion);
+	    if (r < 0)
+	      goto done;
+	    completion->wait_for_complete();
+	    r = completion->get_return_value();
+	    completion->release();
+	    if (r < 0) {
+	      cerr << "error writing to image block" << std::endl;
+	      goto done;
+	    }
+	    break;
+	  }
+	}
 
         file_pos += len;
         cur_seg -= len;
-- 
1.7.1


