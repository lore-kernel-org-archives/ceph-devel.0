From: Dimitris Bliablias <bl.dimitris@gmail.com>
Subject: [PATCH master] rbd.cc: add --force option at 'rbd import'
Date: Wed, 18 Jun 2014 14:42:41 +0300
Message-ID: <1403091761-26148-1-git-send-email-bl.dimitris@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:44718 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965572AbaFRLm4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jun 2014 07:42:56 -0400
Received: by mail-we0-f182.google.com with SMTP id q59so724294wes.13
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jun 2014 04:42:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: synnefo-devel@googlegroups.com

Extend the rbd utility with a new option named '--force'. This option
will be used by the 'rbd import' command to allow overwriting an
existing rbd image, something which is currently forbidden. If the image
has snapshots, the command returns an error and nothing is imported. The
force option will first remove the existing rbd image and then recreate
it before importing the new data.

This patch also updates the tests affected by the modified functions, to
reflect the latest changes. In addition, updates the rbd man page
accordingly to record the new '--force' option.

Signed-off-by: Dimitris Bliablias <bl.dimitris@gmail.com>
---
 doc/man/8/rbd.rst                    |  12 +++-
 qa/workunits/rbd/import_export.sh    |   6 ++
 src/include/rbd/librbd.h             |   9 ++-
 src/include/rbd/librbd.hpp           |   7 +-
 src/librbd/internal.cc               |  61 +++++++++++++---
 src/librbd/internal.h                |   4 +-
 src/librbd/librbd.cc                 |  29 ++++----
 src/pybind/rbd.py                    |  11 +--
 src/rbd.cc                           |  27 +++++---
 src/rbd_fuse/rbd-fuse.c              |   2 +-
 src/test/bench/small_io_bench_rbd.cc |   2 +-
 src/test/cli/rbd/help.t              |   3 +-
 src/test/librbd/fsx.c                |   5 +-
 src/test/librbd/test_librbd.cc       | 131 +++++++++++++++++++++++++----------
 14 files changed, 227 insertions(+), 82 deletions(-)

diff --git a/doc/man/8/rbd.rst b/doc/man/8/rbd.rst
index 215aa92..95cd7d3 100644
--- a/doc/man/8/rbd.rst
+++ b/doc/man/8/rbd.rst
@@ -123,6 +123,11 @@ Parameters
 
    Map the image read-only.  Equivalent to -o ro.
 
+.. option:: --f, --force
+
+   Overwrite an existing rbd image. This option is only used by the rbd import
+   command. See import section (below) for more details.
+
 
 Commands
 ========
@@ -176,11 +181,16 @@ Commands
 :command:`export` [*image-name*] [*dest-path*]
   Exports image to dest path (use - for stdout).
 
-:command:`import` [*path*] [*dest-image*]
+:command:`import` [*path*] [*dest-image*] [--force]
   Creates a new image and imports its data from path (use - for
   stdin).  The import operation will try to create sparse rbd images 
   if possible.  For import from stdin, the sparsification unit is
   the data block size of the destination image (1 << order).
+  Using the --force option will overwrite the destination image if it exists.
+  Overwriting images using a different format is not supported. If the image
+  has snapshots, import fails and nothing is imported. (Note: using --force
+  will first remove the original rbd image, and then re-create it to import
+  the data from path.
 
 :command:`export-diff` [*image-name*] [*dest-path*] [--from-snap *snapname*]
   Exports an incremental diff for an image to dest path (use - for stdout).  If
diff --git a/qa/workunits/rbd/import_export.sh b/qa/workunits/rbd/import_export.sh
index 29fcb6c..1b1b291 100755
--- a/qa/workunits/rbd/import_export.sh
+++ b/qa/workunits/rbd/import_export.sh
@@ -54,6 +54,12 @@ rbd rm testimg
 cmp /tmp/img /tmp/img2
 cmp /tmp/img /tmp/img3
 
+# import using --force option
+rbd create testimg $RBD_CREATE_ARGS --size 10
+rbd import $RBD_CREATE_ARGS /tmp/img testimg && exit 1 || true   # should fail
+rbd import $RBD_CREATE_ARGS /tmp/img testimg --force
+rbd rm testimg
+
 rm /tmp/img /tmp/img2 /tmp/img3
 
 
diff --git a/src/include/rbd/librbd.h b/src/include/rbd/librbd.h
index a9a3318..9da6f5d 100644
--- a/src/include/rbd/librbd.h
+++ b/src/include/rbd/librbd.h
@@ -25,6 +25,7 @@ extern "C" {
 #elif defined(__FreeBSD__)
 #include <sys/types.h>
 #endif
+#include <stdbool.h>
 #include <string.h>
 #include "../rados/librados.h"
 #include "features.h"
@@ -69,9 +70,10 @@ void rbd_version(int *major, int *minor, int *extra);
 
 /* images */
 int rbd_list(rados_ioctx_t io, char *names, size_t *size);
-int rbd_create(rados_ioctx_t io, const char *name, uint64_t size, int *order);
+int rbd_create(rados_ioctx_t io, const char *name, uint64_t size, int *order,
+	       bool force);
 int rbd_create2(rados_ioctx_t io, const char *name, uint64_t size,
-		uint64_t features, int *order);
+		uint64_t features, int *order, bool force);
 /**
  * create new rbd image
  *
@@ -87,11 +89,12 @@ int rbd_create2(rados_ioctx_t io, const char *name, uint64_t size,
  * @param order object/block size, as a power of two (object size == 1 << order)
  * @param stripe_unit stripe unit size, in bytes.
  * @param stripe_count number of objects to stripe over before looping
+ * @param force boolean, on true overwrite existing image
  * @return 0 on success, or negative error code
  */
 int rbd_create3(rados_ioctx_t io, const char *name, uint64_t size,
 		uint64_t features, int *order,
-		uint64_t stripe_unit, uint64_t stripe_count);
+		uint64_t stripe_unit, uint64_t stripe_count, bool force);
 int rbd_clone(rados_ioctx_t p_ioctx, const char *p_name,
 	      const char *p_snapname, rados_ioctx_t c_ioctx,
 	      const char *c_name, uint64_t features, int *c_order);
diff --git a/src/include/rbd/librbd.hpp b/src/include/rbd/librbd.hpp
index 7107f58..a17afc0 100644
--- a/src/include/rbd/librbd.hpp
+++ b/src/include/rbd/librbd.hpp
@@ -77,12 +77,13 @@ public:
   int open_read_only(IoCtx& io_ctx, Image& image, const char *name,
 		     const char *snapname);
   int list(IoCtx& io_ctx, std::vector<std::string>& names);
-  int create(IoCtx& io_ctx, const char *name, uint64_t size, int *order);
+  int create(IoCtx& io_ctx, const char *name, uint64_t size, int *order,
+	     bool force);
   int create2(IoCtx& io_ctx, const char *name, uint64_t size,
-	      uint64_t features, int *order);
+	      uint64_t features, int *order, bool force);
   int create3(IoCtx& io_ctx, const char *name, uint64_t size,
 	      uint64_t features, int *order,
-	      uint64_t stripe_unit, uint64_t stripe_count);
+	      uint64_t stripe_unit, uint64_t stripe_count, bool force);
   int clone(IoCtx& p_ioctx, const char *p_name, const char *p_snapname,
 	       IoCtx& c_ioctx, const char *c_name, uint64_t features,
 	       int *c_order);
diff --git a/src/librbd/internal.cc b/src/librbd/internal.cc
index 2f4a88e..91892db 100644
--- a/src/librbd/internal.cc
+++ b/src/librbd/internal.cc
@@ -825,17 +825,18 @@ reprotect_and_return_err:
   }
 
   int create(librados::IoCtx& io_ctx, const char *imgname, uint64_t size,
-	     int *order)
+	     int *order, bool force)
   {
     CephContext *cct = (CephContext *)io_ctx.cct();
     bool old_format = cct->_conf->rbd_default_format == 1;
     uint64_t features = old_format ? 0 : cct->_conf->rbd_default_features;
-    return create(io_ctx, imgname, size, old_format, features, order, 0, 0);
+    return create(io_ctx, imgname, size, old_format, features, order, 0, 0,
+	          force);
   }
 
   int create(IoCtx& io_ctx, const char *imgname, uint64_t size,
 	     bool old_format, uint64_t features, int *order,
-	     uint64_t stripe_unit, uint64_t stripe_count)
+	     uint64_t stripe_unit, uint64_t stripe_count, bool force)
   {
     if (!order)
       return -EINVAL;
@@ -846,6 +847,7 @@ reprotect_and_return_err:
 		   << " features = " << features << " order = " << *order
 		   << " stripe_unit = " << stripe_unit
 		   << " stripe_count = " << stripe_count
+		   << " force = " << force
 		   << dendl;
 
 
@@ -854,15 +856,57 @@ reprotect_and_return_err:
       return -ENOSYS;
     }
 
-    // make sure it doesn't already exist, in either format
+    // make sure it doesn't already exists, in either format, unless we make
+    // use of the '--force' option. In that case we should also check whether
+    // the image exists in the other format than the requested one.
     int r = detect_format(io_ctx, imgname, NULL, NULL);
     if (r != -ENOENT) {
       if (r) {
 	lderr(cct) << "Could not tell if " << imgname << " already exists" << dendl;
 	return r;
       }
-      lderr(cct) << "rbd image " << imgname << " already exists" << dendl;
-      return -EEXIST;
+      if (force) {
+        string obj_id =
+          !old_format ? old_header_name(imgname) : id_obj_name(imgname);
+
+        if (old_format) {
+          // check if the image exists in new format when using the '--force'
+	  // option on an image of old format. New format images are accessed
+	  // by class methods.
+          string id;
+          r = cls_client::get_id(&io_ctx, obj_id, &id);
+          if (r >= 0) {
+	    lderr(cct) << "rbd image " << imgname << " already exists in new"
+		       << " format.\nOption '--force' is only valid for images"
+		       << " of the same format." << dendl;
+	    return -EEXIST;
+          }
+        } else {
+          // check if the image exists in old format when using the '--force'
+	  // option on an image of new format. Old format images are in a tmap.
+          bufferlist bl;
+          r = io_ctx.read(obj_id, bl, 0, 0);
+          if (r >= 0) {
+	    lderr(cct) << "rbd image " << imgname << " already exists in old"
+		       << " format.\nOption '--force' is only valid for images"
+		       << " of the same format." << dendl;
+	    return -EEXIST;
+          }
+        }
+	// Remove the original image
+	NoOpProgressContext no_op;
+	r = remove(io_ctx, imgname, no_op);
+	if (r < 0) {
+	  lderr(cct) << "Error removing original image: "
+		     << cpp_strerror(r) << dendl;
+	  return r;
+	}
+      } else {
+	lderr(cct) << "rbd image " << imgname << " already exists.\nIf"
+		   << " you really know what you are doing, supply the"
+		   << " --force option to overwrite this image." << dendl;
+	return -EEXIST;
+      }
     }
 
     if (!*order)
@@ -996,7 +1040,7 @@ reprotect_and_return_err:
       order = p_imctx->order;
 
     r = create(c_ioctx, c_name, size, false, features, &order,
-	       stripe_unit, stripe_count);
+	       stripe_unit, stripe_count, false);
     if (r < 0) {
       lderr(cct) << "error creating child: " << cpp_strerror(r) << dendl;
       goto err_close_parent;
@@ -1916,7 +1960,8 @@ reprotect_and_return_err:
     src->md_lock.put_read();
 
     int r = create(dest_md_ctx, destname, src_size, src->old_format,
-		   src->features, &order, src->stripe_unit, src->stripe_count);
+		   src->features, &order, src->stripe_unit, src->stripe_count,
+		   false);
     if (r < 0) {
       lderr(cct) << "header creation failed" << dendl;
       return r;
diff --git a/src/librbd/internal.h b/src/librbd/internal.h
index 6fb1af4..e79b90b 100644
--- a/src/librbd/internal.h
+++ b/src/librbd/internal.h
@@ -81,10 +81,10 @@ namespace librbd {
   int list_children(ImageCtx *ictx,
 		    std::set<pair<std::string, std::string> > & names);
   int create(librados::IoCtx& io_ctx, const char *imgname, uint64_t size,
-	     int *order);
+	     int *order, bool force);
   int create(librados::IoCtx& io_ctx, const char *imgname, uint64_t size,
 	     bool old_format, uint64_t features, int *order,
-	     uint64_t stripe_unit, uint64_t stripe_count);
+	     uint64_t stripe_unit, uint64_t stripe_count, bool force);
   int clone(IoCtx& p_ioctx, const char *p_name, const char *p_snap_name,
 	    IoCtx& c_ioctx, const char *c_name,
 	    uint64_t features, int *c_order,
diff --git a/src/librbd/librbd.cc b/src/librbd/librbd.cc
index b265343..7d2feda 100644
--- a/src/librbd/librbd.cc
+++ b/src/librbd/librbd.cc
@@ -113,23 +113,25 @@ namespace librbd {
     return 0;
   }
 
-  int RBD::create(IoCtx& io_ctx, const char *name, uint64_t size, int *order)
+  int RBD::create(IoCtx& io_ctx, const char *name, uint64_t size, int *order,
+		  bool force)
   {
-    return librbd::create(io_ctx, name, size, order);
+    return librbd::create(io_ctx, name, size, order, force);
   }
 
   int RBD::create2(IoCtx& io_ctx, const char *name, uint64_t size,
-		   uint64_t features, int *order)
+		   uint64_t features, int *order, bool force)
   {
-    return librbd::create(io_ctx, name, size, false, features, order, 0, 0);
+    return librbd::create(io_ctx, name, size, false, features, order, 0, 0,
+			  force);
   }
 
   int RBD::create3(IoCtx& io_ctx, const char *name, uint64_t size,
 		   uint64_t features, int *order, uint64_t stripe_unit,
-		   uint64_t stripe_count)
+		   uint64_t stripe_count, bool force)
   {
     return librbd::create(io_ctx, name, size, false, features, order,
-			  stripe_unit, stripe_count);
+			  stripe_unit, stripe_count, force);
   }
 
   int RBD::clone(IoCtx& p_ioctx, const char *p_name, const char *p_snap_name,
@@ -562,31 +564,34 @@ extern "C" int rbd_list(rados_ioctx_t p, char *names, size_t *size)
   return (int)expected_size;
 }
 
-extern "C" int rbd_create(rados_ioctx_t p, const char *name, uint64_t size, int *order)
+extern "C" int rbd_create(rados_ioctx_t p, const char *name, uint64_t size,
+			  int *order, bool force)
 {
   librados::IoCtx io_ctx;
   librados::IoCtx::from_rados_ioctx_t(p, io_ctx);
-  return librbd::create(io_ctx, name, size, order);
+  return librbd::create(io_ctx, name, size, order, force);
 }
 
 extern "C" int rbd_create2(rados_ioctx_t p, const char *name,
 			   uint64_t size, uint64_t features,
-			   int *order)
+			   int *order, bool force)
 {
   librados::IoCtx io_ctx;
   librados::IoCtx::from_rados_ioctx_t(p, io_ctx);
-  return librbd::create(io_ctx, name, size, false, features, order, 0, 0);
+  return librbd::create(io_ctx, name, size, false, features, order, 0, 0,
+			force);
 }
 
 extern "C" int rbd_create3(rados_ioctx_t p, const char *name,
 			   uint64_t size, uint64_t features,
 			   int *order,
-			   uint64_t stripe_unit, uint64_t stripe_count)
+			   uint64_t stripe_unit, uint64_t stripe_count,
+			   bool force)
 {
   librados::IoCtx io_ctx;
   librados::IoCtx::from_rados_ioctx_t(p, io_ctx);
   return librbd::create(io_ctx, name, size, false, features, order,
-			stripe_unit, stripe_count);
+			stripe_unit, stripe_count, force);
 }
 
 extern "C" int rbd_clone(rados_ioctx_t p_ioctx, const char *p_name,
diff --git a/src/pybind/rbd.py b/src/pybind/rbd.py
index a3512ad..be88e47 100644
--- a/src/pybind/rbd.py
+++ b/src/pybind/rbd.py
@@ -157,7 +157,7 @@ class RBD(object):
         return (major.value, minor.value, extra.value)
 
     def create(self, ioctx, name, size, order=None, old_format=True,
-               features=0, stripe_unit=0, stripe_count=0):
+               features=0, stripe_unit=0, stripe_count=0, force=False):
         """
         Create an rbd image.
 
@@ -179,6 +179,9 @@ class RBD(object):
         :type stripe_unit: int
         :param stripe_count: objects to stripe over before looping
         :type stripe_count: int
+        :param force: when True overwrite an existing image; currently this
+                      option is only available when importing an rbd image
+        :type force: bool
         :raises: :class:`ImageExists`
         :raises: :class:`TypeError`
         :raises: :class:`InvalidArgument`
@@ -194,7 +197,7 @@ class RBD(object):
                                       ' masks or non-default striping')
             ret = self.librbd.rbd_create(ioctx.io, c_char_p(name),
                                          c_uint64(size),
-                                         byref(c_int(order)))
+                                         byref(c_int(order)), force)
         else:
             if not hasattr(self.librbd, 'rbd_create2'):
                 raise FunctionNotSupported('installed version of librbd does'
@@ -209,12 +212,12 @@ class RBD(object):
                                               c_uint64(features),
                                               byref(c_int(order)),
                                               c_uint64(stripe_unit),
-                                              c_uint64(stripe_count))
+                                              c_uint64(stripe_count), force)
             else:
                 ret = self.librbd.rbd_create2(ioctx.io, c_char_p(name),
                                               c_uint64(size),
                                               c_uint64(features),
-                                              byref(c_int(order)))
+                                              byref(c_int(order)), force)
         if ret < 0:
             raise make_ex(ret, 'error creating image')
 
diff --git a/src/rbd.cc b/src/rbd.cc
index d6658e3..df46c19 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -89,7 +89,7 @@ void usage()
 "  rm <image-name>                             delete an image\n"
 "  export <image-name> <path>                  export image to file\n"
 "                                              \"-\" for stdout\n"
-"  import <path> <image-name>                  import image from file\n"
+"  import <path> <image-name> [--force]        import image from file\n"
 "                                              (dest defaults\n"
 "                                               as the filename part of file)\n"
 "                                              \"-\" for stdin\n"
@@ -150,6 +150,7 @@ void usage()
 "  --no-progress                      do not show progress for long-running commands\n"
 "  -o, --options <map-options>        options to use when mapping an image\n"
 "  --read-only                        set device readonly when mapping image\n"
+"  -f, --force                        overwrite an existing image when importing\n"
 "  --allow-shrink                     allow shrinking of an image when resizing\n";
 }
 
@@ -408,7 +409,7 @@ static int do_list(librbd::RBD &rbd, librados::IoCtx& io_ctx, bool lflag,
 static int do_create(librbd::RBD &rbd, librados::IoCtx& io_ctx,
 		     const char *imgname, uint64_t size, int *order,
 		     int format, uint64_t features,
-		     uint64_t stripe_unit, uint64_t stripe_count)
+		     uint64_t stripe_unit, uint64_t stripe_count, bool force)
 {
   int r;
 
@@ -420,7 +421,7 @@ static int do_create(librbd::RBD &rbd, librados::IoCtx& io_ctx,
 	   << std::endl;
       return -EINVAL;
     }
-    r = rbd.create(io_ctx, imgname, size, order);
+    r = rbd.create(io_ctx, imgname, size, order, force);
   } else {
     if (features == 0) {
       features = RBD_FEATURE_LAYERING;
@@ -430,7 +431,7 @@ static int do_create(librbd::RBD &rbd, librados::IoCtx& io_ctx,
       features |= RBD_FEATURE_STRIPINGV2;
     }
     r = rbd.create3(io_ctx, imgname, size, features, order,
-		    stripe_unit, stripe_count);
+		    stripe_unit, stripe_count, force);
   }
   if (r < 0)
     return r;
@@ -1290,7 +1291,7 @@ done_img:
 
 static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
 		     const char *imgname, int *order, const char *path,
-		     int format, uint64_t features, uint64_t size)
+		     int format, uint64_t features, uint64_t size, bool force)
 {
   int fd, r;
   struct stat stat_buf;
@@ -1346,7 +1347,8 @@ static int do_import(librbd::RBD &rbd, librados::IoCtx& io_ctx,
       size = (uint64_t) bdev_size;
     }
   }
-  r = do_create(rbd, io_ctx, imgname, size, order, format, features, 0, 0);
+  r = do_create(rbd, io_ctx, imgname, size, order, format, features, 0, 0,
+		force);
   if (r < 0) {
     cerr << "rbd: image creation failed" << std::endl;
     goto done;
@@ -1972,6 +1974,7 @@ int main(int argc, const char **argv)
   int order = 0;
   bool format_specified = false, output_format_specified = false;
   int format = 1;
+  bool force = false;
   uint64_t features = RBD_FEATURE_LAYERING;
   const char *imgname = NULL, *snapname = NULL, *destname = NULL,
     *dest_poolname = NULL, *dest_snapname = NULL, *path = NULL,
@@ -2065,6 +2068,8 @@ int main(int argc, const char **argv)
       progress = false;
     } else if (ceph_argparse_flag(args, i , "--allow-shrink", (char *)NULL)) {
       resize_allow_shrink = true;
+    } else if (ceph_argparse_flag(args, i, "-f", "--force", (char *)NULL)) {
+      force = true;
     } else if (ceph_argparse_witharg(args, i, &val, "--format", (char *) NULL)) {
       std::string err;
       long long ret = strict_strtoll(val.c_str(), 10, &err);
@@ -2182,6 +2187,12 @@ if (!set_conf_param(v, p1, p2, p3)) { \
     }
   }
 
+  if (force && opt_cmd != OPT_IMPORT) {
+    cerr << "rbd: --force can only be used when"
+	 << " importing an image" << std::endl;
+    return EXIT_FAILURE;
+  }
+
   if (format_specified && opt_cmd != OPT_IMPORT && opt_cmd != OPT_CREATE) {
     cerr << "rbd: image format can only be set when "
 	 << "creating or importing an image" << std::endl;
@@ -2429,7 +2440,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
       return EINVAL;
     }
     r = do_create(rbd, io_ctx, imgname, size, &order, format, features,
-		  stripe_unit, stripe_count);
+		  stripe_unit, stripe_count, force);
     if (r < 0) {
       cerr << "rbd: create error: " << cpp_strerror(-r) << std::endl;
       return -r;
@@ -2655,7 +2666,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
       return EINVAL;
     }
     r = do_import(rbd, dest_io_ctx, destname, &order, path,
-		  format, features, size);
+		  format, features, size, force);
     if (r < 0) {
       cerr << "rbd: import failed: " << cpp_strerror(-r) << std::endl;
       return -r;
diff --git a/src/rbd_fuse/rbd-fuse.c b/src/rbd_fuse/rbd-fuse.c
index 6fc84f2..3499977 100644
--- a/src/rbd_fuse/rbd-fuse.c
+++ b/src/rbd_fuse/rbd-fuse.c
@@ -499,7 +499,7 @@ rbdfs_create(const char *path, mode_t mode, struct fuse_file_info *fi)
 	int r;
 	int order = imageorder;
 
-	r = rbd_create2(ioctx, path+1, imagesize, imagefeatures, &order);
+	r = rbd_create2(ioctx, path+1, imagesize, imagefeatures, &order, false);
 	return r;
 }
 
diff --git a/src/test/bench/small_io_bench_rbd.cc b/src/test/bench/small_io_bench_rbd.cc
index ba7071e..a94d14b 100644
--- a/src/test/bench/small_io_bench_rbd.cc
+++ b/src/test/bench/small_io_bench_rbd.cc
@@ -137,7 +137,7 @@ int main(int argc, char **argv)
     uint64_t image_size = ((uint64_t)vm["image-size"].as<unsigned>()) << 20;
     for (set<string>::const_iterator i = image_names.begin();
 	 i != image_names.end(); ++i) {
-      r = rbd.create(ioctx, i->c_str(), image_size, &order);
+      r = rbd.create(ioctx, i->c_str(), image_size, &order, false);
       if (r < 0) {
 	cerr << "error creating image " << *i << " r=" << r << std::endl;
 	return -r;
diff --git a/src/test/cli/rbd/help.t b/src/test/cli/rbd/help.t
index 3818ee3..38f1f1b 100644
--- a/src/test/cli/rbd/help.t
+++ b/src/test/cli/rbd/help.t
@@ -16,7 +16,7 @@
     rm <image-name>                             delete an image
     export <image-name> <path>                  export image to file
                                                 "-" for stdout
-    import <path> <image-name>                  import image from file
+    import <path> <image-name> [--force]        import image from file
                                                 (dest defaults
                                                  as the filename part of file)
                                                 "-" for stdin
@@ -77,4 +77,5 @@
     --no-progress                      do not show progress for long-running commands
     -o, --options <map-options>        options to use when mapping an image
     --read-only                        set device readonly when mapping image
+    -f, --force                        overwrite an existing image when importing
     --allow-shrink                     allow shrinking of an image when resizing
diff --git a/src/test/librbd/fsx.c b/src/test/librbd/fsx.c
index a811a12..e1a823f 100644
--- a/src/test/librbd/fsx.c
+++ b/src/test/librbd/fsx.c
@@ -1010,9 +1010,10 @@ create_image()
 		goto failed_krbd;
 	}
 	if (clone_calls) {
-		r = rbd_create2(ioctx, iname, 0, RBD_FEATURE_LAYERING, &order);
+		r = rbd_create2(ioctx, iname, 0, RBD_FEATURE_LAYERING, &order,
+				false);
 	} else {
-		r = rbd_create(ioctx, iname, 0, &order);
+		r = rbd_create(ioctx, iname, 0, &order, false);
 	}
 	if (r < 0) {
 		simple_err("Error creating image", r);
diff --git a/src/test/librbd/test_librbd.cc b/src/test/librbd/test_librbd.cc
index fdc33d3..9c502c2 100644
--- a/src/test/librbd/test_librbd.cc
+++ b/src/test/librbd/test_librbd.cc
@@ -63,17 +63,17 @@ static int get_features(bool *old_format, uint64_t *features)
 
 static int create_image_full(rados_ioctx_t ioctx, const char *name,
 			      uint64_t size, int *order, int old_format,
-			      uint64_t features)
+			      uint64_t features, bool force)
 {
   if (old_format) {
-    return rbd_create(ioctx, name, size, order);
+    return rbd_create(ioctx, name, size, order, force);
   } else {
-    return rbd_create2(ioctx, name, size, features, order);
+    return rbd_create2(ioctx, name, size, features, order, force);
   }
 }
 
 static int create_image(rados_ioctx_t ioctx, const char *name,
-			uint64_t size, int *order)
+			uint64_t size, int *order, bool force)
 {
   bool old_format;
   uint64_t features;
@@ -81,22 +81,24 @@ static int create_image(rados_ioctx_t ioctx, const char *name,
   int r = get_features(&old_format, &features);
   if (r < 0)
     return r;
-  return create_image_full(ioctx, name, size, order, old_format, features);
+  return create_image_full(ioctx, name, size, order, old_format, features,
+			   force);
 }
 
 static int create_image_pp(librbd::RBD &rbd,
 			   librados::IoCtx &ioctx,
 			   const char *name,
-			   uint64_t size, int *order) {
+			   uint64_t size, int *order,
+			   bool force) {
   bool old_format;
   uint64_t features;
   int r = get_features(&old_format, &features);
   if (r < 0)
     return r;
   if (old_format) {
-    return rbd.create(ioctx, name, size, order);
+    return rbd.create(ioctx, name, size, order, force);
   } else {
-    return rbd.create2(ioctx, name, size, features, order);
+    return rbd.create2(ioctx, name, size, features, order, force);
   }
 }
 
@@ -114,7 +116,7 @@ TEST(LibRBD, CreateAndStat)
   const char *name = "testimg";
   uint64_t size = 2 << 20;
   
-  ASSERT_EQ(0, create_image(ioctx, name, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
   ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
   ASSERT_EQ(0, rbd_stat(image, &info, sizeof(info)));
   printf("image has size %llu and order %d\n", (unsigned long long) info.size, info.order);
@@ -143,7 +145,7 @@ TEST(LibRBD, CreateAndStatPP)
     const char *name = "testimg";
     uint64_t size = 2 << 20;
     
-    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order));
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
     ASSERT_EQ(0, rbd.open(ioctx, image, name, NULL));
     ASSERT_EQ(0, image.stat(info, sizeof(info)));
     ASSERT_EQ(info.size, size);
@@ -168,7 +170,7 @@ TEST(LibRBD, ResizeAndStat)
   const char *name = "testimg";
   uint64_t size = 2 << 20;
   
-  ASSERT_EQ(0, create_image(ioctx, name, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
   ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
 
   ASSERT_EQ(0, rbd_resize(image, size * 4));
@@ -202,7 +204,7 @@ TEST(LibRBD, ResizeAndStatPP)
     const char *name = "testimg";
     uint64_t size = 2 << 20;
     
-    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order));
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
     ASSERT_EQ(0, rbd.open(ioctx, image, name, NULL));
     
     ASSERT_EQ(0, image.resize(size * 4));
@@ -218,6 +220,61 @@ TEST(LibRBD, ResizeAndStatPP)
   ASSERT_EQ(0, destroy_one_pool_pp(pool_name, rados));
 }
 
+TEST(LibRBD, OverwriteImage)
+{
+  rados_t cluster;
+  rados_ioctx_t ioctx;
+  string pool_name = get_temp_pool_name();
+  ASSERT_EQ("", create_one_pool(pool_name, &cluster));
+  rados_ioctx_create(cluster, pool_name.c_str(), &ioctx);
+
+  rbd_image_info_t info;
+  rbd_image_t image;
+  int order = 0;
+  const char *name = "testimg";
+  uint64_t size = 2 << 20;
+  
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
+  ASSERT_LT(create_image(ioctx, name, size * 2, &order, false), 0);
+  ASSERT_EQ(0, create_image(ioctx, name, size * 2, &order, true));
+  ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
+  ASSERT_EQ(0, rbd_stat(image, &info, sizeof(info)));
+  ASSERT_EQ(info.size, size * 2);
+  ASSERT_EQ(0, rbd_close(image));
+
+  rados_ioctx_destroy(ioctx);
+  ASSERT_EQ(0, destroy_one_pool(pool_name, &cluster));
+}
+
+TEST(LibRBD, OverwriteImagePP)
+{
+  librados::Rados rados;
+  librados::IoCtx ioctx;
+  string pool_name = get_temp_pool_name();
+
+  ASSERT_EQ("", create_one_pool_pp(pool_name, rados));
+  ASSERT_EQ(0, rados.ioctx_create(pool_name.c_str(), ioctx));
+
+  {
+    librbd::RBD rbd;
+    librbd::image_info_t info;
+    librbd::Image image;
+    int order = 0;
+    const char *name = "testimg";
+    uint64_t size = 2 << 20;
+    
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
+    ASSERT_LT(create_image_pp(rbd, ioctx, name, size * 2, &order, false), 0);
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size * 2, &order, true));
+    ASSERT_EQ(0, rbd.open(ioctx, image, name, NULL));
+    ASSERT_EQ(0, image.stat(info, sizeof(info)));
+    ASSERT_EQ(info.size, size * 2);
+  }
+
+  ioctx.close();
+  ASSERT_EQ(0, destroy_one_pool_pp(pool_name, rados));
+}
+
 int test_ls(rados_ioctx_t io_ctx, size_t num_expected, ...)
 {
   int num_images, i, j;
@@ -277,9 +334,9 @@ TEST(LibRBD, TestCreateLsDelete)
   const char *name2 = "testimg2";
   uint64_t size = 2 << 20;
   
-  ASSERT_EQ(0, create_image(ioctx, name, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
   ASSERT_EQ(1, test_ls(ioctx, 1, name));
-  ASSERT_EQ(0, create_image(ioctx, name2, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name2, size, &order, false));
   ASSERT_EQ(2, test_ls(ioctx, 2, name, name2));
   ASSERT_EQ(0, rbd_remove(ioctx, name));
   ASSERT_EQ(1, test_ls(ioctx, 1, name2));
@@ -338,9 +395,9 @@ TEST(LibRBD, TestCreateLsDeletePP)
     const char *name2 = "testimg2";
     uint64_t size = 2 << 20;  
     
-    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order));
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
     ASSERT_EQ(1, test_ls_pp(rbd, ioctx, 1, name));
-    ASSERT_EQ(0, rbd.create(ioctx, name2, size, &order));
+    ASSERT_EQ(0, rbd.create(ioctx, name2, size, &order, false));
     ASSERT_EQ(2, test_ls_pp(rbd, ioctx, 2, name, name2));
     ASSERT_EQ(0, rbd.remove(ioctx, name));
     ASSERT_EQ(1, test_ls_pp(rbd, ioctx, 1, name2));
@@ -375,7 +432,7 @@ TEST(LibRBD, TestCopy)
 
   uint64_t size = 2 << 20;
   
-  ASSERT_EQ(0, create_image(ioctx, name, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
   ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
   ASSERT_EQ(1, test_ls(ioctx, 1, name));
   ASSERT_EQ(0, rbd_copy(image, ioctx, name2));
@@ -419,7 +476,7 @@ TEST(LibRBD, TestCopyPP)
     uint64_t size = 2 << 20;
     PrintProgress pp;
 
-    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order));
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
     ASSERT_EQ(0, rbd.open(ioctx, image, name, NULL));
     ASSERT_EQ(1, test_ls_pp(rbd, ioctx, 1, name));
     ASSERT_EQ(0, image.copy(ioctx, name2));
@@ -486,7 +543,7 @@ TEST(LibRBD, TestCreateLsDeleteSnap)
   uint64_t size = 2 << 20;
   uint64_t size2 = 4 << 20;
   
-  ASSERT_EQ(0, create_image(ioctx, name, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
   ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
 
   ASSERT_EQ(0, rbd_snap_create(image, "snap1"));
@@ -564,7 +621,7 @@ TEST(LibRBD, TestCreateLsDeleteSnapPP)
     uint64_t size = 2 << 20;
     uint64_t size2 = 4 << 20;
     
-    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order));
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
     ASSERT_EQ(0, rbd.open(ioctx, image, name, NULL));
 
     ASSERT_FALSE(image.snap_exists("snap1"));
@@ -698,7 +755,7 @@ TEST(LibRBD, TestIO)
   const char *name = "testimg";
   uint64_t size = 2 << 20;
   
-  ASSERT_EQ(0, create_image(ioctx, name, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
   ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
 
   char test_data[TEST_IO_SIZE + 1];
@@ -767,7 +824,7 @@ TEST(LibRBD, TestEmptyDiscard)
   const char *name = "testimg";
   uint64_t size = 20 << 20;
   
-  ASSERT_EQ(0, create_image(ioctx, name, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
   ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
 
   aio_discard_test_data(image, 0, 1*1024*1024);
@@ -879,7 +936,7 @@ TEST(LibRBD, TestIOPP)
     const char *name = "testimg";
     uint64_t size = 2 << 20;
     
-    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order));
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
     ASSERT_EQ(0, rbd.open(ioctx, image, name, NULL));
 
     char test_data[TEST_IO_SIZE + 1];
@@ -934,7 +991,7 @@ TEST(LibRBD, TestIOToSnapshot)
   const char *name = "testimg";
   uint64_t isize = 2 << 20;
   
-  ASSERT_EQ(0, create_image(ioctx, name, isize, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, isize, &order, false));
   ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
 
   int i, r;
@@ -1026,7 +1083,8 @@ TEST(LibRBD, TestClone)
   int order = 0;
 
   // make a parent to clone from
-  ASSERT_EQ(0, create_image_full(ioctx, "parent", 4<<20, &order, false, features));
+  ASSERT_EQ(0, create_image_full(ioctx, "parent", 4<<20, &order, false,
+				 features, false));
   ASSERT_EQ(0, rbd_open(ioctx, "parent", &parent, NULL));
   printf("made parent image \"parent\"\n");
 
@@ -1140,7 +1198,8 @@ TEST(LibRBD, TestClone2)
   int order = 0;
 
   // make a parent to clone from
-  ASSERT_EQ(0, create_image_full(ioctx, "parent", 4<<20, &order, false, features));
+  ASSERT_EQ(0, create_image_full(ioctx, "parent", 4<<20, &order, false,
+				 features, false));
   ASSERT_EQ(0, rbd_open(ioctx, "parent", &parent, NULL));
   printf("made parent image \"parent\"\n");
 
@@ -1273,7 +1332,7 @@ TEST(LibRBD, ListChildren)
 
   // make a parent to clone from
   ASSERT_EQ(0, create_image_full(ioctx1, "parent", 4<<20, &order,
-				 false, features));
+				 false, features, false));
   ASSERT_EQ(0, rbd_open(ioctx1, "parent", &parent, NULL));
   // create a snapshot, reopen as the parent we're interested in
   ASSERT_EQ(0, rbd_snap_create(parent, "parent_snap"));
@@ -1352,7 +1411,7 @@ TEST(LibRBD, LockingPP)
     std::string cookie1 = "foo";
     std::string cookie2 = "bar";
 
-    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order));
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
     ASSERT_EQ(0, rbd.open(ioctx, image, name, NULL));
 
     // no lockers initially
@@ -1419,7 +1478,7 @@ TEST(LibRBD, FlushAio)
   uint64_t size = 2 << 20;
   size_t num_aios = 256;
 
-  ASSERT_EQ(0, create_image(ioctx, name, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
   ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
 
   char test_data[TEST_IO_SIZE + 1];
@@ -1471,7 +1530,7 @@ TEST(LibRBD, FlushAioPP)
     uint64_t size = 2 << 20;
     size_t num_aios = 256;
 
-    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order));
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
     ASSERT_EQ(0, rbd.open(ioctx, image, name, NULL));
 
     char test_data[TEST_IO_SIZE + 1];
@@ -1578,7 +1637,7 @@ TEST(LibRBD, DiffIterate)
     const char *name = "testimg";
     uint64_t size = 20 << 20;
 
-    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order));
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
     ASSERT_EQ(0, rbd.open(ioctx, image, name, NULL));
 
     interval_set<uint64_t> exists;
@@ -1648,7 +1707,7 @@ TEST(LibRBD, DiffIterateDiscard)
     const char *name = "testimg";
     uint64_t size = 20 << 20;
 
-    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order));
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
     ASSERT_EQ(0, rbd.open(ioctx, image, name, NULL));
 
     vector<diff_extent> extents;
@@ -1727,7 +1786,7 @@ TEST(LibRBD, DiffIterateStress)
     const char *name = "testimg";
     uint64_t size = 400 << 20;
 
-    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order));
+    ASSERT_EQ(0, create_image_pp(rbd, ioctx, name, size, &order, false));
     ASSERT_EQ(0, rbd.open(ioctx, image, name, NULL));
 
     interval_set<uint64_t> curexists;
@@ -1790,7 +1849,7 @@ TEST(LibRBD, ZeroLengthWrite)
   const char *name = "testimg";
   uint64_t size = 2 << 20;
 
-  ASSERT_EQ(0, create_image(ioctx, name, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
   ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
 
   char read_data[1];
@@ -1818,7 +1877,7 @@ TEST(LibRBD, ZeroLengthDiscard)
   const char *name = "testimg";
   uint64_t size = 2 << 20;
 
-  ASSERT_EQ(0, create_image(ioctx, name, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
   ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
 
   const char *data = "blah";
@@ -1847,7 +1906,7 @@ TEST(LibRBD, ZeroLengthRead)
   const char *name = "testimg";
   uint64_t size = 2 << 20;
 
-  ASSERT_EQ(0, create_image(ioctx, name, size, &order));
+  ASSERT_EQ(0, create_image(ioctx, name, size, &order, false));
   ASSERT_EQ(0, rbd_open(ioctx, name, &image, NULL));
 
   char read_data[1];
-- 
1.9.1

