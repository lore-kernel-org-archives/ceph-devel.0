From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 2/3] .gitignore: cleanup and sort entries
Date: Mon,  4 Feb 2013 18:22:43 +0100
Message-ID: <1359998564-27004-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1359998564-27004-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:60031 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753734Ab3BDRWv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 12:22:51 -0500
In-Reply-To: <1359998564-27004-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Cleanup old entries and sort the existing entries. Remove no longer
existing entries/files. Move src/* entries from top level .gitignore
to the correct subdir .gitignore file.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 .gitignore           |  78 ++++++++++-------------
 doc/.gitignore       |   3 +-
 src/.gitignore       | 173 +++++++++++++--------------------------------------
 src/.gitignore.orig  | 142 ++++++++++++++++++++++++++++++++++++++++++
 src/gtest/.gitignore |   2 +
 5 files changed, 221 insertions(+), 177 deletions(-)
 create mode 100644 src/.gitignore.orig
 create mode 100644 src/gtest/.gitignore

diff --git a/.gitignore b/.gitignore
index b6c6eb0..8de8590 100644
--- a/.gitignore
+++ b/.gitignore
@@ -8,65 +8,51 @@
 *.tar.bz2
 *.dsc
 *.changes
-./config.*
 *.gcda
 *.gcov
 *.gcno
+*.generated.dot
+*.la
+*.so
+*.swp
+*.swo
+*.pyc
+*.pyo
+.cproject
 .deps
-web/*.html
-gmon.out
-core.*
-vgcore.*
-src/Makefile
-Makefile.in
-/Makefile
-/man/Makefile
+.dirstamp
+.metadata
+.project
+.settings
 aclocal.m4
+ar-lib
 autom4te.cache
-config.log
-config.status
+build-*
+ceph.spec
+compile
+config.*
 configure
-stamp-h1
+configure-stamp
+core*
+cscope.*
 depcomp
+gmon.out
 install-sh
-missing
-src/ceph_ver.h
-release
-*.la
-ceph.spec
-compile
-config.guess
-config.sub
 libtool
 ltmain.sh
-cscope.files
-cscope.out
-*.swp
-*.swo
-.metadata/
-/py-compile
-*.pyc
-*.pyo
-core
-/build-stamp
-/configure-stamp
-.settings
-.project
-.cproject
-/build-doc
-/doc/object_store.png
-/src/test_*
-*.generated.dot
-src/ocf/ceph
-src/ocf/rbd
-src/ceph_omapbench
-src/ceph_kvstorebench
-ar-lib
-.dirstamp
+Makefile
+Makefile.in
+missing
+py-compile
+release
+stamp-h1
+vgcore.*
 
 # temporary directory used by e.g. "make distcheck", e.g. ceph-0.42
 /ceph-[0-9]*/
 
 # M4 Macro directory
-m4/
-src/gtest/m4/
+m4
+
+# where is this from?
+web/*.html
diff --git a/doc/.gitignore b/doc/.gitignore
index 295eda7..456e390 100644
--- a/doc/.gitignore
+++ b/doc/.gitignore
@@ -1,2 +1,3 @@
 *.tmp
-/overview.png
+overview.png
+object_store.png
diff --git a/src/.gitignore b/src/.gitignore
index 3a5ab91..9c97131 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -1,142 +1,55 @@
-/ceph-fuse
-/ceph-mds
-/ceph-mon
-/ceph
-/ceph-osd
-/ceph-syn
-/ceph-dencoder
-/ceph_dupstore
-/fakefuse
-/fakesyn
-/mkmonmap
-/monmaptool
-/newsyn
-/authtool
-/ceph-authtool
-/crushtool
-/mkcephfs
-/mount.ceph
-/osdmaptool
-/rados
-/rados_sync
-/radosgw
-/radosgw-admin
-/rbdtool
-/ceph_bench_log
-/testceph
-ceph_test_msgr
-/testradospp
-/testdout_streambuf
-/testsignal_handlers
-/testtimers
-/test_addrs
-/test_libceph_build
-/test_librados_build
-/test_librgw_build
-/testrados
-/test_str_list
-/ceph_multi_stress_watch
-/test_store
-/test_libcommon_build
-/test_mutate
-/fsconverter
-/xattr_bench
-/rest-bench
-/rbd-fuse
-dev
-mondata
-mnt
-TAGS
-tags
-out
-acconfig.h.in
+.git_version
+.libs
 acconfig.h
-/.libs
-
-*.so
-/crush/*.fpicco
-/CrushWrapper.pm
-/crush/CrushWrapper_wrap.cxx
-
-/.git_version
-/ceph-conf
-/ceph-debugpack
-/cephfs
-/ceph-coverage
-/dumpjournal
-/init-ceph
-/librados-config
-/rbd
-/sample.fetch_config
-
-Makefile
-
-/gtest/build-aux/config.h
-/gtest/build-aux/config.h.in
-/gtest/lib/
-/gtest/scripts/gtest-config
-/gtest/src/.dirstamp
-/gtest/Makefile.in
-/gtest/aclocal.m4
-/gtest/configure
-/gtest/fused-src/
-/unittest_*
-/ceph.conf
-/keyring
-/massif.out.*
+acconfig.h.in
+ceph
+cephfs
+crushtool
+ceph-authtool
+ceph-conf
+ceph-coverage
+ceph-debugpack
+ceph-dencoder
+ceph-fuse
+ceph-mds
+ceph-mon
+ceph-osd
+ceph-syn
+ceph_bench_log
+ceph_dupstore
+ceph_filestore_dump
+ceph_multi_stress_watch
 ceph_psim
 ceph_radosacl
 ceph_rgw_jsonparser
 ceph_rgw_multiparser
+ceph_scratchtool
+ceph_scratchtoolpp
 ceph_streamtest
-ceph_test_ioctls
-ceph_test_cfuse_cache_invalidate
-ceph_test_cls_lock
-ceph_test_cls_rbd
-ceph_test_cls_refcount
-ceph_test_cls_rgw
-ceph_test_crypto
-ceph_test_filejournal
-ceph_test_filestore
-ceph_test_filestore_idempotent
-ceph_test_filestore_idempotent_sequence
-ceph_test_filestore_workloadgen
-ceph_test_keys
-ceph_test_keyvaluedb_atomicity
-ceph_test_keyvaluedb_iterators
-ceph_test_libcephfs
-ceph_test_libhadoopcephfs_build
-ceph_test_librbd
-ceph_test_librbd_fsx
-ceph_test_mon_workloadgen
-ceph_test_mutate
-ceph_test_object_map
-ceph_test_objectcacher_stress
-ceph_test_rados
-ceph_test_rados_api_aio
-ceph_test_rados_api_cls
-ceph_test_rados_api_io
-ceph_test_rados_api_list
-ceph_test_rados_api_misc
-ceph_test_rados_api_pool
-ceph_test_rados_api_snapshots
-ceph_test_rados_api_stat
-ceph_test_rados_api_watch_notify
-ceph_test_rados_delete_pools_parallel
-ceph_test_rados_list_parallel
-ceph_test_rados_open_pools_parallel
-ceph_test_rados_watch_notify
-ceph_test_rewrite_latency
-ceph_test_signal_handlers
-ceph_test_stress_watch
-ceph_test_timers
-ceph_test_trans
+ceph_test_*
 ceph_tpbench
 ceph_xattr_bench
-ceph_scratchtool
-ceph_scratchtoolpp
-ceph_filestore_dump
+ceph_kvstorebench
+ceph_omapbench
 ceph_smalliobench
 ceph_smalliobenchdumb
 ceph_smalliobenchfs
 ceph_smalliobenchrbd
+ceph_ver.h
+init-ceph
+librados-config
+massif.out.*
+mkcephfs
+monmaptool
+mount.ceph
+osdmaptool
+rados
+radosgw
+radosgw-admin
+rbd
+rbd-fuse
+rest-bench
+sample.fetch_config
+testmsgr
+test_*
+unittest_*
diff --git a/src/.gitignore.orig b/src/.gitignore.orig
new file mode 100644
index 0000000..3a5ab91
--- /dev/null
+++ b/src/.gitignore.orig
@@ -0,0 +1,142 @@
+/ceph-fuse
+/ceph-mds
+/ceph-mon
+/ceph
+/ceph-osd
+/ceph-syn
+/ceph-dencoder
+/ceph_dupstore
+/fakefuse
+/fakesyn
+/mkmonmap
+/monmaptool
+/newsyn
+/authtool
+/ceph-authtool
+/crushtool
+/mkcephfs
+/mount.ceph
+/osdmaptool
+/rados
+/rados_sync
+/radosgw
+/radosgw-admin
+/rbdtool
+/ceph_bench_log
+/testceph
+ceph_test_msgr
+/testradospp
+/testdout_streambuf
+/testsignal_handlers
+/testtimers
+/test_addrs
+/test_libceph_build
+/test_librados_build
+/test_librgw_build
+/testrados
+/test_str_list
+/ceph_multi_stress_watch
+/test_store
+/test_libcommon_build
+/test_mutate
+/fsconverter
+/xattr_bench
+/rest-bench
+/rbd-fuse
+dev
+mondata
+mnt
+TAGS
+tags
+out
+acconfig.h.in
+acconfig.h
+/.libs
+
+*.so
+/crush/*.fpicco
+/CrushWrapper.pm
+/crush/CrushWrapper_wrap.cxx
+
+/.git_version
+/ceph-conf
+/ceph-debugpack
+/cephfs
+/ceph-coverage
+/dumpjournal
+/init-ceph
+/librados-config
+/rbd
+/sample.fetch_config
+
+Makefile
+
+/gtest/build-aux/config.h
+/gtest/build-aux/config.h.in
+/gtest/lib/
+/gtest/scripts/gtest-config
+/gtest/src/.dirstamp
+/gtest/Makefile.in
+/gtest/aclocal.m4
+/gtest/configure
+/gtest/fused-src/
+/unittest_*
+/ceph.conf
+/keyring
+/massif.out.*
+ceph_psim
+ceph_radosacl
+ceph_rgw_jsonparser
+ceph_rgw_multiparser
+ceph_streamtest
+ceph_test_ioctls
+ceph_test_cfuse_cache_invalidate
+ceph_test_cls_lock
+ceph_test_cls_rbd
+ceph_test_cls_refcount
+ceph_test_cls_rgw
+ceph_test_crypto
+ceph_test_filejournal
+ceph_test_filestore
+ceph_test_filestore_idempotent
+ceph_test_filestore_idempotent_sequence
+ceph_test_filestore_workloadgen
+ceph_test_keys
+ceph_test_keyvaluedb_atomicity
+ceph_test_keyvaluedb_iterators
+ceph_test_libcephfs
+ceph_test_libhadoopcephfs_build
+ceph_test_librbd
+ceph_test_librbd_fsx
+ceph_test_mon_workloadgen
+ceph_test_mutate
+ceph_test_object_map
+ceph_test_objectcacher_stress
+ceph_test_rados
+ceph_test_rados_api_aio
+ceph_test_rados_api_cls
+ceph_test_rados_api_io
+ceph_test_rados_api_list
+ceph_test_rados_api_misc
+ceph_test_rados_api_pool
+ceph_test_rados_api_snapshots
+ceph_test_rados_api_stat
+ceph_test_rados_api_watch_notify
+ceph_test_rados_delete_pools_parallel
+ceph_test_rados_list_parallel
+ceph_test_rados_open_pools_parallel
+ceph_test_rados_watch_notify
+ceph_test_rewrite_latency
+ceph_test_signal_handlers
+ceph_test_stress_watch
+ceph_test_timers
+ceph_test_trans
+ceph_tpbench
+ceph_xattr_bench
+ceph_scratchtool
+ceph_scratchtoolpp
+ceph_filestore_dump
+ceph_smalliobench
+ceph_smalliobenchdumb
+ceph_smalliobenchfs
+ceph_smalliobenchrbd
diff --git a/src/gtest/.gitignore b/src/gtest/.gitignore
new file mode 100644
index 0000000..8b163f6
--- /dev/null
+++ b/src/gtest/.gitignore
@@ -0,0 +1,2 @@
+fused-src
+scripts/gtest-config
-- 
1.8.1.2

