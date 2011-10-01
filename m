From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: ceph.spec.in still packages libceph.so in 0.36
Date: Sat, 01 Oct 2011 18:14:04 -0300
Message-ID: <orhb3s9zz7.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:60209 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751211Ab1JAWBI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 1 Oct 2011 18:01:08 -0400
Received: from freie.oliva.athome.lsd.ic.unicamp.br (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id p91LE96i025822
	for <ceph-devel@vger.kernel.org>; Sat, 1 Oct 2011 18:14:10 -0300
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p91LE6Xd015451
	for <ceph-devel@vger.kernel.org>; Sat, 1 Oct 2011 18:14:06 -0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Package libcephfs.so instead of libceph.so.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>

diff --git a/ceph.spec.in b/ceph.spec.in
index b655a9f..f87278d 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -246,7 +246,7 @@ fi
 %{_includedir}/rados/crc32c.h
 %{_includedir}/rbd/librbd.h
 %{_includedir}/rbd/librbd.hpp
-%{_libdir}/libceph.so
+%{_libdir}/libcephfs.so
 %{_libdir}/librados.so
 %{_libdir}/librbd.so
 %{_libdir}/rados-classes/libcls_rbd.so


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
