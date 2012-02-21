From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: [PATCH] Package ceph-dencoder
Date: Tue, 21 Feb 2012 07:09:39 -0200
Message-ID: <orpqd81rjg.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:40546 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755468Ab2BVWHX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 22 Feb 2012 17:07:23 -0500
Received: from freie.oliva.athome.lsd.ic.unicamp.br (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q1MM7Hr0002460
	for <ceph-devel@vger.kernel.org>; Wed, 22 Feb 2012 20:07:18 -0200
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q1L99fjo017912
	for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 07:09:41 -0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 ceph.spec.in |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index 58c3af7d..f62f95a 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -313,6 +313,7 @@ fi
 %{_bindir}/boto_tool
 %{_bindir}/ceph-coverage
 %{_bindir}/obsync
+%{_bindir}/ceph-dencoder
 %{_initrddir}/ceph
 %dir %{_libdir}/rados-classes
 /sbin/mkcephfs
-- 
1.7.7.6

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
