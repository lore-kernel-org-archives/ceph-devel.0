From: Alexandre Oliva <oliva@gnu.org>
Subject: Fixes for missing and doubly-packaged files in ceph.spec
Date: Wed, 12 Feb 2014 10:47:51 -0200
Message-ID: <ord2is1oqw.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:48139 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbaBLMsL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Feb 2014 07:48:11 -0500
Received: from freie (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id s1CCm62d010316
	for <ceph-devel@vger.kernel.org>; Wed, 12 Feb 2014 12:48:07 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In order to upgrade my servers to the Fedora-based Hatrack 20, I had to
roll out my own rpms, because there aren't Fedora 20 builds at ceph.com.
This revealed some errors in the ceph spec file, that caused errors
because some ceph_test files were not packaged at all, and warnings
because some fileswithin libdir/ceph were packaged twice.  I added the
ceph_test binaries and avoided the double packaging of
libdir/ceph/erasure stuff by marking libdir/ceph with %dir.  This in
turn left ceph_common.sh out, because it had only been covered by the
recursive packaging of libdir/ceph, so I put it in explicitly.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>

---
 ceph.spec.in |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index fb599fa..82eb102 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -416,7 +416,8 @@ fi
 %{_sbindir}/rcceph
 /sbin/mkcephfs
 /sbin/mount.ceph
-%{_libdir}/ceph
+%dir %{_libdir}/ceph
+%{_libdir}/ceph/ceph_common.sh
 %dir %{_libdir}/rados-classes
 %{_libdir}/rados-classes/libcls_rbd.so*
 %{_libdir}/rados-classes/libcls_hello.so*
@@ -630,6 +631,7 @@ fi
 %{_bindir}/ceph_filestore_dump
 %{_bindir}/ceph_filestore_tool
 %{_bindir}/ceph_streamtest
+%{_bindir}/ceph_test_c_headers
 %{_bindir}/ceph_test_cfuse_cache_invalidate
 %{_bindir}/ceph_test_cls_hello
 %{_bindir}/ceph_test_cls_lock
@@ -649,6 +651,7 @@ fi
 %{_bindir}/ceph_test_filestore_idempotent
 %{_bindir}/ceph_test_filestore_idempotent_sequence
 %{_bindir}/ceph_test_filestore_workloadgen
+%{_bindir}/ceph_test_get_blkdev_size
 %{_bindir}/ceph_test_ioctls
 %{_bindir}/ceph_test_keyvaluedb_atomicity
 %{_bindir}/ceph_test_keyvaluedb_iterators

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist     Red Hat Brazil Toolchain Engineer
