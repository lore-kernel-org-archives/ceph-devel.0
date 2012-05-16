From: Christian Brunner <chb@muc.de>
Subject: [PATCH 1/2] rbd: allow importing from stdin
Date: Wed, 16 May 2012 16:27:50 +0200
Message-ID: <20120516142750.GA8485@sir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63082 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab2EPOaK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 May 2012 10:30:10 -0400
Received: by bkcji2 with SMTP id ji2so673609bkc.19
        for <ceph-devel@vger.kernel.org>; Wed, 16 May 2012 07:30:09 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch allows importing images from stdin with the following command:

   rbd import --size=<size in MB> - [dest-image]

Signed-off-by: Christian Brunner <chb@muc.de>
---
 src/rbd.cc |   37 +++++++++++++++++++++++++------------
 1 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/src/rbd.cc b/src/rbd.cc
index 655d9a2..0476cc5 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -402,29 +402,37 @@ done_img:
 }
 
 static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
-		     const char *imgname, int *order, const char *path)
+		     const char *imgname, int *order, const char *path,
+		     int64_t size)
 {
-  int fd = open(path, O_RDONLY);
-  int r;
-  int64_t size = 0;
+  int fd, r;
   struct stat stat_buf;
   string md_oid;
   struct fiemap *fiemap;
   MyProgressContext pc("Importing image");
 
+  if (! strcmp(path, "-")) {
+    fd = 0;
+  } else {
+    fd = open(path, O_RDONLY);
+  }
+
   if (fd < 0) {
     r = -errno;
     cerr << "error opening " << path << std::endl;
     return r;
   }
 
-  r = fstat(fd, &stat_buf);
-  if (r < 0) {
-    r = -errno;
-    cerr << "stat error " << path << std::endl;
-    return r;
+  if (fd > 0) {
+    r = fstat(fd, &stat_buf);
+    if (r < 0) {
+      r = -errno;
+      cerr << "stat error " << path << std::endl;
+      return r;
+    }
+    size = (uint64_t)stat_buf.st_size;
   }
-  size = (uint64_t)stat_buf.st_size;
+
   if (!size) {
     r = get_block_device_size(fd, &size);
     if (r < 0) {
@@ -505,7 +513,12 @@ static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
       while (cur_seg) {
         bufferptr p(cur_seg);
         //cerr << "reading " << cur_seg << " bytes at offset " << file_pos << std::endl;
-        ssize_t rval = TEMP_FAILURE_RETRY(::pread(fd, p.c_str(), cur_seg, file_pos));
+	ssize_t rval;
+	if(extent == 0 && fiemap->fm_extents[extent].fe_logical == 0) {
+	  rval = TEMP_FAILURE_RETRY(::read(fd, p.c_str(), cur_seg));
+	} else {
+	  rval = TEMP_FAILURE_RETRY(::pread(fd, p.c_str(), cur_seg, file_pos));
+	}
         if (rval < 0) {
           r = -errno;
           cerr << "error reading file: " << cpp_strerror(r) << std::endl;
@@ -1303,7 +1316,7 @@ int main(int argc, const char **argv)
       cerr << "pathname should be specified" << std::endl;
       exit(1);
     }
-    r = do_import(rbd, dest_io_ctx, destname, &order, path);
+    r = do_import(rbd, dest_io_ctx, destname, &order, path, size);
     if (r < 0) {
       cerr << "import failed: " << cpp_strerror(-r) << std::endl;
       exit(1);
-- 
1.7.1


