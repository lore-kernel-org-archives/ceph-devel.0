From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Don't package no longer installed crush headers
Date: Tue, 14 Aug 2012 02:38:51 -0300
Message-ID: <or393qypje.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:36868 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751863Ab2HNGmD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Aug 2012 02:42:03 -0400
Received: from freie (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q7E67pdB017106
	for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 03:07:51 -0300
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie (8.14.5/8.14.5) with ESMTP id q7E67oYW014871
	for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 03:07:50 -0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The rules that install crush headers are commented out in
src/Makefile.am, so don't attempt to package them.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 ceph.spec.in |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index 70e9e08..af204e9 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -340,11 +340,11 @@ fi
 %defattr(-,root,root,-)
 %dir %{_includedir}/cephfs
 %{_includedir}/cephfs/libcephfs.h
-%dir %{_includedir}/crush
-%{_includedir}/crush/crush.h
-%{_includedir}/crush/hash.h
-%{_includedir}/crush/mapper.h
-%{_includedir}/crush/types.h
+# %dir %{_includedir}/crush
+# %{_includedir}/crush/crush.h
+# %{_includedir}/crush/hash.h
+# %{_includedir}/crush/mapper.h
+# %{_includedir}/crush/types.h
 %dir %{_includedir}/rados
 %{_includedir}/rados/librados.h
 %{_includedir}/rados/librados.hpp
-- 
1.7.7.6

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
