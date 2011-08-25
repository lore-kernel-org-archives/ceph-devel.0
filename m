From: Christian Brunner <chb@muc.de>
Subject: [PATCH 2/2] rbd: add an option for md5 checksumming (v2)
Date: Thu, 25 Aug 2011 13:03:16 +0200
Message-ID: <20110825110316.GB6517@sir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32942 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab1HYLEo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2011 07:04:44 -0400
Received: by bke11 with SMTP id 11so1624759bke.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 04:04:43 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We needed to get an md5 checksum of an rbd image. Since librbd is using a
lot of sparse operations, this was not possible without writing an image
to a local disk.

With this patch exporting the image is no longer needed. You can do
"rbd md5 image" and you will get the same output as you would call "md5sum".

V1 -> V2:
- use ceph::crypto classes
- support for sha1
- skip holes
---
 src/rbd.cc |  139 ++++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 117 insertions(+), 22 deletions(-)

diff --git a/src/rbd.cc b/src/rbd.cc
index a18c029..a947309 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -38,6 +38,8 @@
 #include <time.h>
 #include <sys/ioctl.h>
 
+#include "common/ceph_crypto.h"
+
 #include "include/rbd_types.h"
 
 #include <linux/fs.h>
@@ -49,6 +51,30 @@
 
 static string dir_oid = RBD_DIRECTORY;
 static string dir_info_oid = RBD_INFO;
+static size_t lastofs;
+
+enum {
+  OPT_NO_CMD = 0,
+  OPT_LIST,
+  OPT_INFO,
+  OPT_CREATE,
+  OPT_RESIZE,
+  OPT_RM,
+  OPT_EXPORT,
+  OPT_IMPORT,
+  OPT_COPY,
+  OPT_RENAME,
+  OPT_SNAP_CREATE,
+  OPT_SNAP_ROLLBACK,
+  OPT_SNAP_REMOVE,
+  OPT_SNAP_LIST,
+  OPT_WATCH,
+  OPT_MAP,
+  OPT_UNMAP,
+  OPT_SHOWMAPPED,
+  OPT_MD5,
+  OPT_SHA1,
+};
 
 void usage()
 {
@@ -65,6 +91,8 @@ void usage()
        << "  export [image-name] [dest-path]           export image to file\n"
        << "  import [path] [dst-image]                 import image from file (dest defaults\n"
        << "                                            as the filename part of file)\n"
+       << "  md5 [image-name]                          print md5 checksum for image\n"
+       << "  sha1 [image-name]                         print sha1 checksum for image\n"
        << "  <cp | copy> [src-image] [dest-image]      copy image to dest\n"
        << "  <mv | rename> [src-image] [dest-image]    copy image to dest\n"
        << "  snap ls [image-name]                      dump list of image snapshots\n"
@@ -262,6 +290,77 @@ static int do_export(librbd::Image& image, const char *path)
   return 0;
 }
 
+static int hash_read_cb(uint64_t ofs, size_t len, const char *buf, void *arg)
+{
+  ssize_t dif;
+  ceph::crypto::Digest *Hash = (ceph::crypto::Digest *)arg;
+
+  if (buf) {
+    dif = ofs-lastofs;
+    if (dif > 0) {
+      byte *tempbuf = (byte *) malloc(dif);
+      memset(tempbuf, 0, dif);
+      Hash->Update((const byte *) tempbuf, dif);
+      free(tempbuf);
+    }
+
+    Hash->Update((const byte *) buf, len);
+    lastofs = ofs + len;
+  }
+
+  return 0;
+}
+
+static int do_hash(librbd::Image& image, const char *imgname, int opt_cmd)
+{
+  int64_t r, i, digest_size;
+  byte *digest;
+  char hexval[] = "0123456789abcdef";
+  char *hexdigest;
+  librbd::image_info_t info;
+  ceph::crypto::Digest *Hash;
+
+  lastofs = 0;
+
+  if (opt_cmd == OPT_MD5) {
+    Hash = (ceph::crypto::Digest *) new ceph::crypto::MD5;
+  } else if (opt_cmd == OPT_SHA1) {
+    Hash = (ceph::crypto::Digest *) new ceph::crypto::SHA1;
+  } else {
+    return -1;
+  }
+
+  r = image.stat(info, sizeof(info));
+  if (r < 0)
+    return r;
+
+  r = image.read_iterate(0, info.size, hash_read_cb, (void *)Hash);
+  if (r < 0)
+    return r;
+
+  if (lastofs < info.size) {
+      hash_read_cb(info.size, 0, NULL, (void *)Hash);
+  }
+
+  digest_size = Hash->DigestSize();
+  digest = (byte *) malloc(digest_size);
+  hexdigest = (char *) malloc((digest_size * 2 + 1) * sizeof(char));
+  Hash->Final(digest);
+
+  for(i = 0; i < digest_size; i++){
+    hexdigest[i*2] = hexval[((digest[i] >> 4) & 0xF)];
+    hexdigest[(i*2) + 1] = hexval[(digest[i]) & 0x0F];
+  }
+  hexdigest[(digest_size*2)] = '\0';
+
+  cout << hexdigest << "  " << imgname << std::endl;
+
+  free(hexdigest);
+  free(digest);
+
+  return 0;
+}
+
 static const char *imgname_from_path(const char *path)
 {
   const char *imgname;
@@ -720,27 +819,6 @@ static int do_kernel_rm(const char *dev)
   return r;
 }
 
-enum {
-  OPT_NO_CMD = 0,
-  OPT_LIST,
-  OPT_INFO,
-  OPT_CREATE,
-  OPT_RESIZE,
-  OPT_RM,
-  OPT_EXPORT,
-  OPT_IMPORT,
-  OPT_COPY,
-  OPT_RENAME,
-  OPT_SNAP_CREATE,
-  OPT_SNAP_ROLLBACK,
-  OPT_SNAP_REMOVE,
-  OPT_SNAP_LIST,
-  OPT_WATCH,
-  OPT_MAP,
-  OPT_UNMAP,
-  OPT_SHOWMAPPED,
-};
-
 static int get_cmd(const char *cmd, bool *snapcmd)
 {
   if (strcmp(cmd, "snap") == 0) {
@@ -766,6 +844,10 @@ static int get_cmd(const char *cmd, bool *snapcmd)
       return OPT_EXPORT;
     if (strcmp(cmd, "import") == 0)
       return OPT_IMPORT;
+    if (strcmp(cmd, "md5") == 0)
+      return OPT_MD5;
+    if (strcmp(cmd, "sha1") == 0)
+      return OPT_SHA1;
     if (strcmp(cmd, "copy") == 0 ||
         strcmp(cmd, "cp") == 0)
       return OPT_COPY;
@@ -888,6 +970,10 @@ int main(int argc, const char **argv)
           case OPT_IMPORT:
             set_conf_param(CEPH_ARGPARSE_VAL, &path, &destname);
             break;
+          case OPT_MD5:
+          case OPT_SHA1:
+            set_conf_param(CEPH_ARGPARSE_VAL, &imgname, NULL);
+            break;
           case OPT_COPY:
           case OPT_RENAME:
             set_conf_param(CEPH_ARGPARSE_VAL, &imgname, &destname);
@@ -966,7 +1052,7 @@ int main(int argc, const char **argv)
       (opt_cmd == OPT_RESIZE || opt_cmd == OPT_INFO || opt_cmd == OPT_SNAP_LIST ||
        opt_cmd == OPT_SNAP_CREATE || opt_cmd == OPT_SNAP_ROLLBACK ||
        opt_cmd == OPT_SNAP_REMOVE || opt_cmd == OPT_EXPORT || opt_cmd == OPT_WATCH ||
-       opt_cmd == OPT_COPY)) {
+       opt_cmd == OPT_COPY || opt_cmd == OPT_MD5 || opt_cmd == OPT_SHA1 )) {
     r = rbd.open(io_ctx, image, imgname);
     if (r < 0) {
       cerr << "error opening image " << imgname << ": " << strerror(r) << std::endl;
@@ -1127,6 +1213,15 @@ int main(int argc, const char **argv)
     }
     break;
 
+  case OPT_MD5:
+  case OPT_SHA1:
+    r = do_hash(image, imgname, opt_cmd);
+    if (r < 0) {
+      cerr << "md5 hashing failed: " << strerror(-r) << std::endl;
+      exit(1);
+    }
+    break;
+
   case OPT_COPY:
     r = do_copy(image, dest_io_ctx, destname);
     if (r < 0) {
-- 
1.7.1


