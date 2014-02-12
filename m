From: Alexandre Oliva <oliva@gnu.org>
Subject: packaging: do not package libdir/ceph recursively
Date: Wed, 12 Feb 2014 15:46:50 -0200
Message-ID: <ork3d0z0j9.fsf@livre.home>
References: <ord2is1oqw.fsf@livre.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:48609 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbaBLRrK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Feb 2014 12:47:10 -0500
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id s1CHl8Se014258
	for <ceph-devel@vger.kernel.org>; Wed, 12 Feb 2014 17:47:08 GMT
In-Reply-To: <ord2is1oqw.fsf@livre.home> (Alexandre Oliva's message of "Wed,
	12 Feb 2014 10:47:51 -0200")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

My earlier patch was partially redundant with commit e60dcfa80dec, that
didn't make 0.76, so here's the non-redundant change, as a separate
patch.

---

Package libdir/ceph non-recursively, to avoid duplicates, and
package libdir/ceph/ceph_common.sh explicitly.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 ceph.spec.in |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index 76c8344..82eb102 100644
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


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist     Red Hat Brazil Toolchain Engineer
