From: huang jun <hjwsm1989@gmail.com>
Subject: Fixes for missing and replicated files in ceph.spec.in
Date: Fri, 21 Feb 2014 19:27:42 +0800
Message-ID: <CABAwU-ZCSVbkLUOvZBd8=+uHD1L6tVS5iAkpDNUS0_myP5Xndw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:57755 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755184AbaBUL1n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2014 06:27:43 -0500
Received: by mail-yk0-f173.google.com with SMTP id 10so5441067ykt.4
        for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2014 03:27:43 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Signed-off-by: hjwsm1989<hjwsm1989@gmail.com>

-- 
diff --git a/ceph.spec.in b/ceph.spec.in
index 3caa849..facba6c 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -429,6 +429,7 @@ fi
@@ -429,6 +429,7 @@ fi
 %{_libdir}/rados-classes/libcls_log.so*
diff --git a/ceph.spec.in b/ceph.spec.in
index 3caa849..facba6c 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -429,6 +429,7 @@ fi
 %{_libdir}/rados-classes/libcls_replica_log.so*
 %{_libdir}/rados-classes/libcls_statelog.so*
+%{_libdir}/rados-classes/libcls_user.so*
 %{_libdir}/rados-classes/libcls_version.so*
 %dir %{_libdir}/ceph/erasure-code
 %{_libdir}/ceph/erasure-code/libec_example.so*
@@ -634,7 +635,6 @@ fi
 %{_bindir}/ceph_filestore_dump
 %{_bindir}/ceph_filestore_tool
 %{_bindir}/ceph_streamtest
-%{_bindir}/ceph_test_c_headers
 %{_bindir}/ceph_test_cfuse_cache_invalidate
 %{_bindir}/ceph_test_cls_hello
 %{_bindir}/ceph_test_cls_lock
@@ -654,7 +654,6 @@ fi
 %{_bindir}/ceph_test_filestore_idempotent
 %{_bindir}/ceph_test_filestore_idempotent_sequence
 %{_bindir}/ceph_test_objectstore_workloadgen
-%{_bindir}/ceph_test_get_blkdev_size
 %{_bindir}/ceph_test_ioctls
 %{_bindir}/ceph_test_keyvaluedb_atomicity
 %{_bindir}/ceph_test_keyvaluedb_iterators
@@ -690,6 +689,7 @@ fi
 %{_bindir}/ceph_test_rados_list_parallel
 %{_bindir}/ceph_test_rados_open_pools_parallel
 %{_bindir}/ceph_test_rados_watch_notify
+%{_bindir}/ceph_test_rgw_manifest
 %{_bindir}/ceph_test_signal_handlers
 %{_bindir}/ceph_test_snap_mapper
