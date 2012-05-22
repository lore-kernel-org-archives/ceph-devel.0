From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: [PATCH] Update ceph.spec for ceph-0.47
Date: Tue, 22 May 2012 05:17:47 -0300
Message-ID: <orfwasr5n8.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:38836 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756811Ab2EVJTZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 May 2012 05:19:25 -0400
Received: from freie.oliva.athome.lsd.ic.unicamp.br (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q4M8HopC005533
	for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 05:17:50 -0300
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q4M8HnJ3011754
	for <ceph-devel@vger.kernel.org>; Tue, 22 May 2012 05:17:49 -0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add BuildRequires: libxml2-devel.
Move BuildRequires: libcurl-devel to a more proper place.
Uninstall libs3, incorrectly installed in RPM_BUILD_ROOT.
Package %{_includedir}/rados/librgw.h.
---
 ceph.spec.in |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index b3dd3f0..1dbd645 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -37,6 +37,8 @@ BuildRequires:	gdbm
 BuildRequires:	pkgconfig
 BuildRequires:	python
 BuildRequires:  libaio-devel
+BuildRequires:  libcurl-devel
+BuildRequires:  libxml2-devel
 
 #################################################################################
 # specific
@@ -55,7 +57,6 @@ Requires(post):	chkconfig
 Requires(preun):chkconfig
 Requires(preun):initscripts
 %endif
-BuildRequires: libcurl-devel
 %if 0%{with tcmalloc}
 # use isa so this will not be satisfied by
 # google-perftools-devel.i686 on a x86_64 box
@@ -232,6 +233,10 @@ make -j$(getconf _NPROCESSORS_ONLN)
 
 %install
 make DESTDIR=$RPM_BUILD_ROOT install
+make DESTDIR=$RPM_BUILD_ROOT -C src/libs3 uninstall
+rmdir $RPM_BUILD_ROOT/bin
+rmdir $RPM_BUILD_ROOT/lib
+rmdir $RPM_BUILD_ROOT/include
 find $RPM_BUILD_ROOT -type f -name "*.la" -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name "*.a" -exec rm -f {} ';'
 install -D src/init-ceph $RPM_BUILD_ROOT%{_initrddir}/ceph
@@ -365,6 +370,7 @@ fi
 %dir %{_includedir}/rados
 %{_includedir}/rados/librados.h
 %{_includedir}/rados/librados.hpp
+%{_includedir}/rados/librgw.h
 %{_includedir}/rados/buffer.h
 %{_includedir}/rados/page.h
 %{_includedir}/rados/crc32c.h
-- 
1.7.7.6

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
