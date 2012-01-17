From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: [PATCH] [ceph spec] package *.py* files
Date: Tue, 17 Jan 2012 17:22:17 -0200
Message-ID: <orboq2w2vq.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:35550 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755557Ab2AQUNr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Jan 2012 15:13:47 -0500
Received: from freie (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q0HJMJ3K018684
	for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2012 17:22:19 -0200
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie (8.14.5/8.14.5) with ESMTP id q0HJMJkV016290
	for <ceph-devel@vger.kernel.org>; Tue, 17 Jan 2012 17:22:19 -0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Some post-install rpmbuild defaults byte-compile all packaged python
files, so don't bother removing the .pyc files, and package .py* to
get both .pyo and .pyc.  It wastes a tiny little bit of space, but it
makes the spec file portable across a wider range of rpm and python
configurations.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicam.br>
---
 ceph.spec.in |   19 +++----------------
 1 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index 3950fd1..d4994b5 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -255,10 +255,6 @@ mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/lib/ceph/tmp/
 mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/log/ceph/
 mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/run/ceph/
 mkdir -p $RPM_BUILD_ROOT%{_sysconfdir}/ceph/
-# remove *.pyc where *.pyo exists
-rm $RPM_BUILD_ROOT/%{python_sitelib}/rados.pyc
-rm $RPM_BUILD_ROOT/%{python_sitelib}/rbd.pyc
-rm $RPM_BUILD_ROOT/%{python_sitelib}/rgw.pyc
 
 %clean
 rm -rf $RPM_BUILD_ROOT
@@ -351,12 +347,6 @@ fi
 %ghost %dir %{_localstatedir}/run/ceph/
 %dir %{_sysconfdir}/ceph/
 /usr/sbin/rcceph
-# not sure why I need to list those for CentOS although they're removed in install
-%if 0%{defined centos_version}
-%{python_sitelib}/rados.pyc
-%{python_sitelib}/rbd.pyc
-%{python_sitelib}/rgw.pyc
-%endif
 %{_libdir}/rados-classes/libcls_rbd.so.*
 %{_libdir}/rados-classes/libcls_rgw.so.*
 
@@ -483,11 +473,8 @@ fi
 #################################################################################
 %files -n python-ceph
 %defattr(-,root,root,-)
-%{python_sitelib}/rados.py
-%{python_sitelib}/rados.pyo
-%{python_sitelib}/rbd.py
-%{python_sitelib}/rbd.pyo
-%{python_sitelib}/rgw.py
-%{python_sitelib}/rgw.pyo
+%{python_sitelib}/rados.py*
+%{python_sitelib}/rbd.py*
+%{python_sitelib}/rgw.py*
 
 %changelog
-- 
1.7.7.5

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
