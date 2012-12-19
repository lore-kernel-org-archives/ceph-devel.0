From: Stratos Psomadakis <psomas@grnet.gr>
Subject: [PATCH v2] rbd: Support plain/json/xml output formatting
Date: Wed, 19 Dec 2012 14:17:20 +0200
Message-ID: <1355919440-24357-1-git-send-email-psomas@grnet.gr>
References: <50CF559E.9040504@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from worf.dev.grnet.gr ([62.217.125.132]:44108 "EHLO
	worf.dev.grnet.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938Ab2LSMRl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Dec 2012 07:17:41 -0500
In-Reply-To: <50CF559E.9040504@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Yehuda Sadeh <yehuda@inktank.com>, ceph-devel@vger.kernel.org, synnefo-devel@googlegroups.com, Stratos Psomadakis <psomas@grnet.gr>

This patch renames the --format option to --image-format, for specyfing the RBD
image format, and uses --format to specify the output formating (to be
consistent with the other ceph tools). To avoid breaking backwards compatibility
with existing scripts, rbd will still accept --format [1|2] for the image
format, but will print a warning message, noting its use is deprecated.

The rbd subcommands that support the new --format option are : ls, info, snap
list, children, showmapped, lock list.

Signed-off-by: Stratos Psomadakis <psomas@grnet.gr>
---
Hi,

this is the updated version of the patch. I renamed --format option to
 --image-format, and used --format to specify the output formatting, as you
suggested.

I also implemented some basic error checking on the --format input, and modified
the rbd subcommands you mentioned, to support plain/json/xml output formatting.
Although, I'm not sure if the json and xml output of those commands is what
you'd want.

The style issues should also be resolved now.

Let me know what you think.

Thanks,
Stratos

 doc/man/8/rbd.rst |    6 +-
 src/rbd.cc        |  424 ++++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 325 insertions(+), 105 deletions(-)

diff --git a/doc/man/8/rbd.rst b/doc/man/8/rbd.rst
index e6a02b0..3446364 100644
--- a/doc/man/8/rbd.rst
+++ b/doc/man/8/rbd.rst
@@ -41,7 +41,7 @@ Options
 Parameters
 ==========
 
-.. option:: --format format
+.. option:: --image-format format
 
    Specifies which object layout to use. The default is 1.
 
@@ -100,6 +100,10 @@ Parameters
    live migration of a virtual machine, or for use underneath
    a clustered filesystem.
 
+.. option:: --format format
+
+   Specifies output formatting (default: plain, json, xml)
+
 
 Commands
 ========
diff --git a/src/rbd.cc b/src/rbd.cc
index 3920d4b..f0487bc 100644
--- a/src/rbd.cc
+++ b/src/rbd.cc
@@ -19,6 +19,7 @@
 #include "auth/KeyRing.h"
 #include "common/errno.h"
 #include "common/ceph_argparse.h"
+#include "common/strtol.h"
 #include "global/global_init.h"
 #include "common/safe_io.h"
 #include "common/secret.h"
@@ -47,6 +48,8 @@
 #include "include/rbd_types.h"
 #include "common/TextTable.h"
 
+#include "common/Formatter.h"
+
 #if defined(__linux__)
 #include <linux/fs.h>
 #endif
@@ -112,21 +115,22 @@ void usage()
 "individual pieces of names with -p/--pool, --image, and/or --snap.\n"
 "\n"
 "Other input options:\n"
-"  -p, --pool <pool>            source pool name\n"
-"  --image <image-name>         image name\n"
-"  --dest <image-name>          destination [pool and] image name\n"
-"  --snap <snap-name>           snapshot name\n"
-"  --dest-pool <name>           destination pool name\n"
-"  --path <path-name>           path name for import/export\n"
-"  --size <size in MB>          size of image for create and resize\n"
-"  --order <bits>               the object size in bits; object size will be\n"
-"                               (1 << order) bytes. Default is 22 (4 MB).\n"
-"  --format <format-number>     format to use when creating an image\n"
-"                               format 1 is the original format (default)\n"
-"                               format 2 supports cloning\n"
-"  --id <username>              rados user (without 'client.' prefix) to authenticate as\n"
-"  --keyfile <path>             file containing secret key for use with cephx\n"
-"  --shared <tag>               take a shared (rather than exclusive) lock\n";
+"  -p, --pool <pool>                  source pool name\n"
+"  --image <image-name>               image name\n"
+"  --dest <image-name>                destination [pool and] image name\n"
+"  --snap <snap-name>                 snapshot name\n"
+"  --dest-pool <name>                 destination pool name\n"
+"  --path <path-name>                 path name for import/export\n"
+"  --size <size in MB>                size of image for create and resize\n"
+"  --order <bits>                     the object size in bits; object size will be\n"
+"                                     (1 << order) bytes. Default is 22 (4 MB).\n"
+"  --image-format <format-number>     format to use when creating an image\n"
+"                                     format 1 is the original format (default)\n"
+"                                     format 2 supports cloning\n"
+"  --id <username>                    rados user (without 'client.' prefix) to authenticate as\n"
+"  --keyfile <path>                   file containing secret key for use with cephx\n"
+"  --shared <tag>                     take a shared (rather than exclusive) lock\n"
+"  --format <output-format>           output format (default: plain, json, xml)\n";
 }
 
 static string feature_str(uint64_t features)
@@ -169,28 +173,62 @@ struct MyProgressContext : public librbd::ProgressContext {
   }
 };
 
-static int do_list(librbd::RBD &rbd, librados::IoCtx& io_ctx, bool lflag)
+static int get_outfmt(const char *output_format, Formatter **f)
+{
+  if (!strcmp(output_format, "json"))
+    *f = new JSONFormatter(false);
+  else if (!strcmp(output_format, "xml"))
+    *f = new XMLFormatter(false);
+  else if (strcmp(output_format, "plain")) {
+    cerr << "rbd unknown format '" << output_format << "'" << std::endl;
+    return -EINVAL;
+  }
+
+  return 0;
+}
+
+static int do_list(librbd::RBD &rbd, librados::IoCtx& io_ctx, bool lflag, const char *output_format)
 {
   std::vector<string> names;
   int r = rbd.list(io_ctx, names);
   if (r < 0 || (names.size() == 0))
     return r;
 
+  Formatter *f = 0;
+
+  r = get_outfmt(output_format, &f);
+  if (r < 0)
+    return r;
+
   if (!lflag) {
+    if (f)
+      f->open_array_section("images");
     for (std::vector<string>::const_iterator i = names.begin();
        i != names.end(); ++i) {
-      cout << *i << std::endl;
+       if (f)
+         f->dump_string("name", string(*i).c_str());
+       else
+         cout << *i << std::endl;
+    }
+    if (f) {
+      f->close_section();
+      f->flush(cout);
     }
     return 0;
   }
 
   TextTable tbl;
-  tbl.define_column("NAME", TextTable::LEFT, TextTable::LEFT);
-  tbl.define_column("SIZE", TextTable::RIGHT, TextTable::RIGHT);
-  tbl.define_column("PARENT", TextTable::LEFT, TextTable::LEFT);
-  tbl.define_column("FMT", TextTable::RIGHT, TextTable::RIGHT);
-  tbl.define_column("PROT", TextTable::LEFT, TextTable::LEFT);
-  tbl.define_column("LOCK", TextTable::LEFT, TextTable::LEFT);
+
+  if (f)
+    f->open_object_section("images");
+  else {
+    tbl.define_column("NAME", TextTable::LEFT, TextTable::LEFT);
+    tbl.define_column("SIZE", TextTable::RIGHT, TextTable::RIGHT);
+    tbl.define_column("PARENT", TextTable::LEFT, TextTable::LEFT);
+    tbl.define_column("FMT", TextTable::RIGHT, TextTable::RIGHT);
+    tbl.define_column("PROT", TextTable::LEFT, TextTable::LEFT);
+    tbl.define_column("LOCK", TextTable::LEFT, TextTable::LEFT);
+  }
 
   string pool, image, snap, parent;
 
@@ -238,13 +276,23 @@ static int do_list(librbd::RBD &rbd, librados::IoCtx& io_ctx, bool lflag)
       lockstr = (exclusive) ? "excl" : "shr";
     }
 
-    tbl << *i
-	<< stringify(si_t(info.size))
-	<< parent
-	<< ((old_format) ? '1' : '2')
-	<< ""				// protect doesn't apply to images
-	<< lockstr
-	<< TextTable::endrow;
+    if (f) {
+      f->open_object_section(string(*i).c_str());
+      f->dump_string("size", stringify(si_t(info.size)));
+      f->dump_string("parent", parent);
+      f->dump_string("fmt", (old_format) ? "1" : "2");
+      f->dump_string("prot", "");  // protect doesn't apply to images
+      f->dump_string("lock", lockstr);
+      f->close_section();
+    } else {
+      tbl << *i
+	  << stringify(si_t(info.size))
+	  << parent
+	  << ((old_format) ? '1' : '2')
+	  << ""				// protect doesn't apply to images
+	  << lockstr
+	  << TextTable::endrow;
+    }
 
     vector<librbd::snap_info_t> snaplist;
     if (im.snap_list(snaplist) >= 0 && !snaplist.empty()) {
@@ -259,17 +307,32 @@ static int do_list(librbd::RBD &rbd, librados::IoCtx& io_ctx, bool lflag)
 	if (im.parent_info(&pool, &image, &snap) >= 0) {
 	  parent = pool + "/" + image + "@" + snap;
 	}
-        tbl << *i + "@" + s->name
-	    << stringify(si_t(s->size))
-	    << parent
-	    << ((old_format) ? '1' : '2')
-	    << (is_protected ? "yes" : "")
-	    << "" 			// locks don't apply to snaps
-	    << TextTable::endrow;
+        if (f) {
+          f->open_object_section((*i + "@" + s->name).c_str());
+          f->dump_string("size", stringify(si_t(s->size)));
+          f->dump_string("parent", parent);
+          f->dump_string("fmt", (old_format) ? "1" : "2");
+          f->dump_string("prot", is_protected ? "yes" : "");
+          f->dump_string("lock", "");  // locks don't apply to snaps
+          f->close_section();
+        } else {
+          tbl << *i + "@" + s->name
+	      << stringify(si_t(s->size))
+	      << parent
+	      << ((old_format) ? '1' : '2')
+	      << (is_protected ? "yes" : "")
+	      << "" 			// locks don't apply to snaps
+	      << TextTable::endrow;
+        }
       }
     }
   }
-  cout << tbl;
+  if (f) {
+    f->close_section();
+    f->flush(cout);
+  } else
+    cout << tbl;
+
   return 0;
 }
 
@@ -337,15 +400,21 @@ static int do_rename(librbd::RBD &rbd, librados::IoCtx& io_ctx,
 }
 
 static int do_show_info(const char *imgname, librbd::Image& image,
-			const char *snapname)
+			const char *snapname, const char *output_format)
 {
   librbd::image_info_t info;
   string parent_pool, parent_name, parent_snapname;
   uint8_t old_format;
   uint64_t overlap, features;
   bool snap_protected;
+  Formatter *f = 0;
+  int r;
+
+  r = get_outfmt(output_format, &f);
+  if (r < 0)
+    return r;
 
-  int r = image.stat(info, sizeof(info));
+  r = image.stat(info, sizeof(info));
   if (r < 0)
     return r;
 
@@ -367,41 +436,73 @@ static int do_show_info(const char *imgname, librbd::Image& image,
       return r;
   }
 
-  cout << "rbd image '" << imgname << "':\n"
-       << "\tsize " << prettybyte_t(info.size) << " in "
-       << info.num_objs << " objects"
-       << std::endl
-       << "\torder " << info.order
-       << " (" << prettybyte_t(info.obj_size) << " objects)"
-       << std::endl
-       << "\tblock_name_prefix: " << info.block_name_prefix
-       << std::endl
-       << "\tformat: " << (old_format ? "1" : "2")
-       << std::endl;
+  if (f) {
+    f->open_object_section("image");
+    f->dump_string("name", imgname);
+    f->dump_string("size", stringify(prettybyte_t(info.size)));
+    f->dump_int("objects", info.num_objs);
+    f->dump_int("order", info.order);
+    f->dump_string("obj_size", stringify(prettybyte_t(info.obj_size)));
+    f->dump_string("block_name_prefix", info.block_name_prefix);
+    f->dump_string("format", (old_format ? "1" : "2"));
+  } else {
+    cout << "rbd image '" << imgname << "':\n"
+         << "\tsize " << prettybyte_t(info.size) << " in "
+         << info.num_objs << " objects"
+         << std::endl
+         << "\torder " << info.order
+         << " (" << prettybyte_t(info.obj_size) << " objects)"
+         << std::endl
+         << "\tblock_name_prefix: " << info.block_name_prefix
+         << std::endl
+         << "\tformat: " << (old_format ? "1" : "2")
+         << std::endl;
+  }
+
   if (!old_format) {
-    cout << "\tfeatures: " << feature_str(features) << std::endl;
+    if (f)
+      f->dump_string("features", feature_str(features));
+    else
+      cout << "\tfeatures: " << feature_str(features) << std::endl;
   }
 
   // snapshot info, if present
   if (snapname) {
-    cout << "\tprotected: " << (snap_protected ? "True" : "False")
-	 << std::endl;
+    if (f)
+      f->dump_string("protected", stringify(snap_protected));
+    else
+      cout << "\tprotected: " << (snap_protected ? "True" : "False")
+	   << std::endl;
   }
 
   // parent info, if present
   if ((image.parent_info(&parent_pool, &parent_name, &parent_snapname) == 0) &&
       parent_name.length() > 0) {
-
-    cout << "\tparent: " << parent_pool << "/" << parent_name
-	 << "@" << parent_snapname << std::endl;
-    cout << "\toverlap: " << prettybyte_t(overlap) << std::endl;
+    if (f) {
+      f->dump_string("parnet", parent_pool + "/" + parent_name);
+      f->dump_string("overlap", stringify(prettybyte_t(overlap)));
+    } else {
+      cout << "\tparent: " << parent_pool << "/" << parent_name
+	   << "@" << parent_snapname << std::endl;
+      cout << "\toverlap: " << prettybyte_t(overlap) << std::endl;
+    }
   }
 
   // striping info, if feature is set
   if (features & RBD_FEATURE_STRIPINGV2) {
-    cout << "\tstripe unit: " << prettybyte_t(image.get_stripe_unit()) << std::endl
-	 << "\tstripe count: " << image.get_stripe_count() << std::endl;
+    if (f) {
+      f->dump_string("stripe_unit", stringify(prettybyte_t(image.get_stripe_unit())));
+      f->dump_string("stripe_count", stringify(image.get_stripe_count()));
+    } else
+      cout << "\tstripe unit: " << prettybyte_t(image.get_stripe_unit()) << std::endl
+	   << "\tstripe count: " << image.get_stripe_count() << std::endl;
   }
+
+  if (f) {
+    f->close_section();
+    f->flush(cout);
+  }
+
   return 0;
 }
 
@@ -429,24 +530,49 @@ static int do_resize(librbd::Image& image, uint64_t size)
   return 0;
 }
 
-static int do_list_snaps(librbd::Image& image)
+static int do_list_snaps(librbd::Image& image, const char *output_format)
 {
   std::vector<librbd::snap_info_t> snaps;
-  int r = image.snap_list(snaps);
+  Formatter *f = 0;
+  TextTable t;
+  int r;
+
+  r = get_outfmt(output_format, &f);
+  if (r < 0)
+    return r;
+
+  r  = image.snap_list(snaps);
   if (r < 0 || snaps.empty())
     return r;
 
-  TextTable t;
-  t.define_column("SNAPID", TextTable::RIGHT, TextTable::RIGHT);
-  t.define_column("NAME", TextTable::LEFT, TextTable::LEFT);
-  t.define_column("SIZE", TextTable::RIGHT, TextTable::RIGHT);
+  if (f)
+    f->open_object_section("snaps");
+  else {
+    t.define_column("SNAPID", TextTable::RIGHT, TextTable::RIGHT);
+    t.define_column("NAME", TextTable::LEFT, TextTable::LEFT);
+    t.define_column("SIZE", TextTable::RIGHT, TextTable::RIGHT);
+  }
 
   for (std::vector<librbd::snap_info_t>::iterator s = snaps.begin();
        s != snaps.end(); ++s) {
-    t << s->id << s->name << stringify(prettybyte_t(s->size))
-      << TextTable::endrow;
+    if (f) {
+      f->open_object_section(stringify(s->id).c_str());
+      f->dump_string("name", s->name);
+      f->dump_string("size", stringify(prettybyte_t(s->size)));
+      f->close_section();
+    } else {
+      t << s->id << s->name << stringify(prettybyte_t(s->size))
+        << TextTable::endrow;
+    }
+  }
+
+  if (f) {
+    f->close_section();
+    f->flush(cout);
   }
-  cout << t;
+  else
+    cout << t;
+
   return 0;
 }
 
@@ -521,47 +647,91 @@ static int do_unprotect_snap(librbd::Image& image, const char *snapname)
   return 0;
 }
 
-static int do_list_children(librbd::Image &image)
+static int do_list_children(librbd::Image &image, const char *output_format)
 {
   set<pair<string, string> > children;
-  int r = image.list_children(&children);
+  Formatter *f = 0;
+  int r;
+
+  r = get_outfmt(output_format, &f);
+  if (r < 0)
+    return r;
+
+  r = image.list_children(&children);
   if (r < 0)
     return r;
 
+  if (f)
+    f->open_array_section("children");
+
   for (set<pair<string, string> >::const_iterator child_it = children.begin();
        child_it != children.end(); child_it++) {
-    cout << child_it->first << "/" << child_it->second << std::endl;
+    if (f)
+      f->dump_string("child", child_it->first + "/" + child_it->second);
+    else
+      cout << child_it->first << "/" << child_it->second << std::endl;
   }
+
+  if (f) {
+    f->close_section();
+    f->flush(cout);
+  }
+
   return 0;
 }
 
-static int do_lock_list(librbd::Image& image)
+static int do_lock_list(librbd::Image& image, const char *output_format)
 {
   list<librbd::locker_t> lockers;
   bool exclusive;
   string tag;
-  int r = image.list_lockers(&lockers, &exclusive, &tag);
+  Formatter *f = 0;
+  TextTable tbl;
+  int r;
+
+  r = get_outfmt(output_format, &f);
+  if (r < 0)
+    return r;
+
+  r = image.list_lockers(&lockers, &exclusive, &tag);
   if (r < 0)
     return r;
 
   if (lockers.size()) {
     bool one = (lockers.size() == 1);
-    cout << "There " << (one ? "is " : "are ") << lockers.size()
-	 << (exclusive ? " exclusive" : " shared")
-	 << " lock" << (one ? "" : "s") << " on this image.\n";
-    if (!exclusive)
-      cout << "Lock tag: " << tag << "\n";
 
-    TextTable tbl;
-    tbl.define_column("Locker", TextTable::LEFT, TextTable::LEFT);
-    tbl.define_column("ID", TextTable::LEFT, TextTable::LEFT);
-    tbl.define_column("Address", TextTable::LEFT, TextTable::LEFT);
+    if (!f) {
+      cout << "There " << (one ? "is " : "are ") << lockers.size()
+	   << (exclusive ? " exclusive" : " shared")
+	   << " lock" << (one ? "" : "s") << " on this image.\n";
+      if (!exclusive)
+        cout << "Lock tag: " << tag << "\n";
+    }
+
+    if (f)
+      f->open_object_section("locks");
+    else {
+      tbl.define_column("Locker", TextTable::LEFT, TextTable::LEFT);
+      tbl.define_column("ID", TextTable::LEFT, TextTable::LEFT);
+      tbl.define_column("Address", TextTable::LEFT, TextTable::LEFT);
+    }
 
     for (list<librbd::locker_t>::const_iterator it = lockers.begin();
 	 it != lockers.end(); ++it) {
+      if (f) {
+        f->open_object_section(it->cookie.c_str());
+        f->dump_string("locker", it->client);
+        f->dump_string("address", it->address);
+        f->close_section();
+      } else
       tbl << it->client << it->cookie << it->address << TextTable::endrow;
     }
-    cout << tbl;
+
+    if (f) {
+      f->close_section();
+      f->flush(cout);
+    } else
+      cout << tbl;
   }
   return 0;
 }
@@ -1210,10 +1380,17 @@ void do_closedir(DIR *dp)
     closedir(dp);
 }
 
-static int do_kernel_showmapped()
+static int do_kernel_showmapped(const char *output_format)
 {
   int r;
   bool have_output = false;
+  Formatter *f = 0;
+  TextTable tbl;
+
+  r = get_outfmt(output_format, &f);
+  if (r < 0)
+    return r;
+
   const char *devices_path = "/sys/bus/rbd/devices";
   std::tr1::shared_ptr<DIR> device_dir(opendir(devices_path), do_closedir);
   if (!device_dir.get()) {
@@ -1232,12 +1409,15 @@ static int do_kernel_showmapped()
     return r;
   }
 
-  TextTable tbl;
-  tbl.define_column("id", TextTable::LEFT, TextTable::LEFT);
-  tbl.define_column("pool", TextTable::LEFT, TextTable::LEFT);
-  tbl.define_column("image", TextTable::LEFT, TextTable::LEFT);
-  tbl.define_column("snap", TextTable::LEFT, TextTable::LEFT);
-  tbl.define_column("device", TextTable::LEFT, TextTable::LEFT);
+  if (f)
+    f->open_object_section("devices");
+  else {
+    tbl.define_column("id", TextTable::LEFT, TextTable::LEFT);
+    tbl.define_column("pool", TextTable::LEFT, TextTable::LEFT);
+    tbl.define_column("image", TextTable::LEFT, TextTable::LEFT);
+    tbl.define_column("snap", TextTable::LEFT, TextTable::LEFT);
+    tbl.define_column("device", TextTable::LEFT, TextTable::LEFT);
+  }
 
   do {
     if (strcmp(dent->d_name, ".") == 0 || strcmp(dent->d_name, "..") == 0)
@@ -1275,12 +1455,27 @@ static int do_kernel_showmapped()
       continue;
     }
 
-    tbl << dent->d_name << pool << name << snap << dev << TextTable::endrow;
+    if (f) {
+      f->open_object_section(dent->d_name);
+      f->dump_string("pool", pool);
+      f->dump_string("name", name);
+      f->dump_string("snap", snap);
+      f->dump_string("device", dev);
+      f->close_section();
+    } else {
+      tbl << dent->d_name << pool << name << snap << dev << TextTable::endrow;
+    }
     have_output = true;
 
   } while ((dent = readdir(device_dir.get())));
-  if (have_output)
-    cout << tbl;
+
+  if (f) {
+    f->close_section();
+    f->flush(cout);
+  } else {
+    if (have_output)
+      cout << tbl;
+  }
 
   return 0;
 }
@@ -1517,13 +1712,13 @@ int main(int argc, const char **argv)
   const char *poolname = NULL;
   uint64_t size = 0;  // in bytes
   int order = 0;
-  bool format_specified = false;
+  bool format_specified = false, output_format_specified = false;
   int format = 1;
   uint64_t features = RBD_FEATURE_LAYERING;
   const char *imgname = NULL, *snapname = NULL, *destname = NULL,
     *dest_poolname = NULL, *dest_snapname = NULL, *path = NULL,
     *devpath = NULL, *lock_cookie = NULL, *lock_client = NULL,
-    *lock_tag = NULL;
+    *lock_tag = NULL, *output_format = "plain";
   bool lflag = false;
   long long stripe_unit = 0, stripe_count = 0;
   long long bench_io_size = 4096, bench_io_threads = 16, bench_bytes = 1 << 30;
@@ -1544,7 +1739,7 @@ int main(int argc, const char **argv)
     } else if (ceph_argparse_flag(args, i, "--new-format", (char*)NULL)) {
       format = 2;
       format_specified = true;
-    } else if (ceph_argparse_withint(args, i, &format, &err, "--format",
+    } else if (ceph_argparse_withint(args, i, &format, &err, "--image-format",
 				     (char*)NULL)) {
       if (!err.str().empty()) {
 	cerr << "rbd: " << err.str() << std::endl;
@@ -1591,6 +1786,19 @@ int main(int argc, const char **argv)
       imgname = strdup(val.c_str());
     } else if (ceph_argparse_witharg(args, i, &val, "--shared", (char *)NULL)) {
       lock_tag = strdup(val.c_str());
+    } else if (ceph_argparse_witharg(args, i, &val, "--format", (char *) NULL)) {
+      std::string err;
+      long long ret = strict_strtoll(val.c_str(), 10, &err);
+      if (err.empty()) {
+        format = ret;
+        format_specified = true;
+        cerr << "rbd: using --format for specifying the rbd image format is deprecated,"
+             << " use --image-format instead"
+             << std::endl;
+      } else {
+        output_format = strdup(val.c_str());
+        output_format_specified = true;
+      }
     } else {
       ++i;
     }
@@ -1692,11 +1900,19 @@ if (!set_conf_param(v, p1, p2, p3)) { \
   }
 
   if (format_specified && opt_cmd != OPT_IMPORT && opt_cmd != OPT_CREATE) {
-    cerr << "rbd: format can only be set when "
+    cerr << "rbd: image format can only be set when "
 	 << "creating or importing an image" << std::endl;
     return EXIT_FAILURE;
   }
 
+  if (output_format_specified && opt_cmd != OPT_SHOWMAPPED && opt_cmd != OPT_INFO &&
+      opt_cmd != OPT_LIST && opt_cmd != OPT_SNAP_LIST && opt_cmd != OPT_LOCK_LIST &&
+      opt_cmd != OPT_CHILDREN) {
+    cerr << "rbd: command doesn't use output formatting"
+         << std::endl;
+    return EXIT_FAILURE;
+  }
+
   if (format_specified) {
     if (format < 1 || format > 2) {
       cerr << "rbd: format must be 1 or 2" << std::endl;
@@ -1883,7 +2099,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
 
   switch (opt_cmd) {
   case OPT_LIST:
-    r = do_list(rbd, io_ctx, lflag);
+    r = do_list(rbd, io_ctx, lflag, output_format);
     if (r < 0) {
       switch (r) {
       case -ENOENT:
@@ -1947,7 +2163,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
     break;
 
   case OPT_INFO:
-    r = do_show_info(imgname, image, snapname);
+    r = do_show_info(imgname, image, snapname, output_format);
     if (r < 0) {
       cerr << "rbd: info: " << cpp_strerror(-r) << std::endl;
       return EXIT_FAILURE;
@@ -1988,7 +2204,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
       cerr << "rbd: snap list requires an image parameter" << std::endl;
       return EXIT_FAILURE;
     }
-    r = do_list_snaps(image);
+    r = do_list_snaps(image, output_format);
     if (r < 0) {
       cerr << "rbd: failed to list snapshots: " << cpp_strerror(-r)
 	   << std::endl;
@@ -2077,7 +2293,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
     break;
 
   case OPT_CHILDREN:
-    r = do_list_children(image);
+    r = do_list_children(image, output_format);
     if (r < 0) {
       cerr << "rbd: listing children failed: " << cpp_strerror(-r) << std::endl;
       return EXIT_FAILURE;
@@ -2142,7 +2358,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
     break;
 
   case OPT_SHOWMAPPED:
-    r = do_kernel_showmapped();
+    r = do_kernel_showmapped(output_format);
     if (r < 0) {
       cerr << "rbd: showmapped failed: " << cpp_strerror(-r) << std::endl;
       return EXIT_FAILURE;
@@ -2150,7 +2366,7 @@ if (!set_conf_param(v, p1, p2, p3)) { \
     break;
 
   case OPT_LOCK_LIST:
-    r = do_lock_list(image);
+    r = do_lock_list(image, output_format);
     if (r < 0) {
       cerr << "rbd: listing locks failed: " << cpp_strerror(r) << std::endl;
       return EXIT_FAILURE;
-- 
1.7.10.4

