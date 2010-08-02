From: Christian Brunner <chb@muc.de>
Subject: [PATCH] rbd: use async write for copy and import
Date: Mon, 2 Aug 2010 22:12:35 +0200
Message-ID: <20100802201235.GD4923@chb-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62366 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492Ab0HBUMj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 16:12:39 -0400
Received: by bwz1 with SMTP id 1so1621689bwz.19
        for <ceph-devel@vger.kernel.org>; Mon, 02 Aug 2010 13:12:37 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Yehuda,

copying images whith "rbd cp" can be quite slow. I did the
following change to speed up copy and import. Please decide
if you want to include it.

Christian

---
 src/rbd.cc |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/src/rbd.cc b/src/rbd.cc
index 07849ed..7c71b7d 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -37,6 +37,8 @@ struct pools {
 
 typedef struct pools pools_t;
 
+int64_t aiocnt = 0;
+
 static Rados rados;
 static string dir_oid = RBD_DIRECTORY;
 static string dir_info_oid = RBD_INFO;
@@ -722,6 +724,12 @@ done_img:
   update_snap_name(*new_img, snap);
 }
 
+static void aio_write_cb(Rados::AioCompletion comp, void *c) 
+{
+  comp.release();
+  aiocnt--;
+}
+
 static int do_import(pool_t pool, const char *imgname, int order, const char *path)
 {
   int fd = open(path, O_RDONLY);
@@ -730,6 +738,7 @@ static int do_import(pool_t pool, const char *imgname, int order, const char *pa
   uint64_t block_size;
   struct stat stat_buf;
   string md_oid;
+  Rados::AioCompletion *comp;
 
   if (fd < 0) {
     r = -errno;
@@ -784,7 +793,9 @@ static int do_import(pool_t pool, const char *imgname, int order, const char *pa
       bufferlist bl;
       bl.append(p);
       string oid = get_block_oid(&header, i);
-      r = rados.write(pool, oid, 0, bl, len);
+      comp = rados.aio_create_completion(NULL, NULL, (callback_t) aio_write_cb);
+      r = rados.aio_write(pool, oid, 0, bl, len, comp);
+      aiocnt++;
       if (r < 0) {
         cerr << "error writing to image block" << std::endl;
         return r;
@@ -796,6 +807,11 @@ static int do_import(pool_t pool, const char *imgname, int order, const char *pa
     seg_pos += seg_size;
   }
 
+  while(aiocnt > 0) {
+    cerr << "waiting for " << aiocnt << " async writes" << std::endl;
+    usleep(100000);
+  }
+
   return 0;
 }
 
@@ -805,6 +821,7 @@ static int do_copy(pools_t& pp, const char *imgname, const char *destname)
   int64_t ret;
   int r;
   string md_oid, dest_md_oid;
+  Rados::AioCompletion *comp;
 
   md_oid = imgname;
   md_oid += RBD_SUFFIX;
@@ -843,7 +860,9 @@ static int do_copy(pools_t& pp, const char *imgname, const char *destname)
 
     if (bl.length()) {
       string dest_oid = get_block_oid(&dest_header, i);
-      r = rados.write(pp.dest, dest_oid, 0, bl, bl.length());
+      comp = rados.aio_create_completion(NULL, NULL, (callback_t) aio_write_cb);
+      r = rados.aio_write(pp.dest, dest_oid, 0, bl, bl.length(), comp);
+      aiocnt++;
       if (r < 0) {
         cerr << "failed to write block " << dest_oid << std::endl;
         return r;
@@ -851,6 +870,11 @@ static int do_copy(pools_t& pp, const char *imgname, const char *destname)
     }
   }
 
+  while(aiocnt > 0) {
+    cerr << "waiting for " << aiocnt << " async writes" << std::endl;
+    usleep(100000);
+  }
+
   return 0;
 }
 
-- 
1.7.0.4

