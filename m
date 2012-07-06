From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: unpackaged files in rpmbuild of 0.48
Date: Fri, 6 Jul 2012 15:44:02 +0100
Message-ID: <1E7E28F9-6612-4488-B7C2-0B2E48281765@tchpc.tcd.ie>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:39592 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab2GFOwQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 10:52:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id 3F9F18326E
	for <ceph-devel@vger.kernel.org>; Fri,  6 Jul 2012 15:44:03 +0100 (IST)
Received: from tabaet.tchpc.tcd.ie ([127.0.0.1])
	by localhost (tabaet.tchpc.tcd.ie [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HG6y9rh1IWvI for <ceph-devel@vger.kernel.org>;
	Fri,  6 Jul 2012 15:44:02 +0100 (IST)
Received: from x00.tchpc.tcd.ie (x00.tchpc.tcd.ie [134.226.112.149])
	by tabaet.tchpc.tcd.ie (Postfix) with ESMTP id 79E6D82DD7
	for <ceph-devel@vger.kernel.org>; Fri,  6 Jul 2012 15:44:02 +0100 (IST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi All,

I'm not sure if this is intentional or not, but during a rpm build of 0.48 gives the following

error: Installed (but unpackaged) file(s) found:
   /sbin/ceph-disk-activate
   /sbin/ceph-disk-prepare


RPM build errors:
    Installed (but unpackaged) file(s) found:
   /sbin/ceph-disk-activate
   /sbin/ceph-disk-prepare

The following will fix the spec file

diff -u ceph.spec.in.orig ceph.spec.in
--- ceph.spec.in.orig	2012-07-06 15:38:59.298497719 +0100
+++ ceph.spec.in	2012-07-06 15:39:45.423560177 +0100
@@ -326,6 +326,8 @@
 /usr/sbin/rcceph
 %{_libdir}/rados-classes/libcls_rbd.so*
 %{_libdir}/rados-classes/libcls_rgw.so*
+/sbin/ceph-disk-activate
+/sbin/ceph-disk-prepare
 
 #################################################################################
 %files fuse

I could of course ignore

Regards,
Jimmy Tang

--
Senior Software Engineer, Digital Repository of Ireland (DRI)
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/

