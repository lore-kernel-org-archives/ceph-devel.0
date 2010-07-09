From: Christian Brunner <chb@muc.de>
Subject: [PATCH 4/4] ceph.spec.in: add a build option for radosgw (--with
 radosgw)
Date: Fri, 9 Jul 2010 11:13:04 +0200
Message-ID: <20100709091304.GF29300@bambus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49318 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635Ab0GIJND (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jul 2010 05:13:03 -0400
Received: by bwz1 with SMTP id 1so929723bwz.19
        for <ceph-devel@vger.kernel.org>; Fri, 09 Jul 2010 02:13:02 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

---
 ceph.spec.in |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index de35c24..dd6bb8a 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -1,3 +1,5 @@
+%define with_radosgw %{?_with_radosgw: 1} %{!?_with_radosgw: 0}
+
 Name:          ceph
 Version:       @VERSION@
 Release:       4%{?dist}
@@ -35,12 +37,30 @@ Requires:    %{name} = %{version}-%{release}
 %description devel
 This package contains the headers needed to develop programs that use Ceph.
 
+%if %{with_radosgw}
+%package radosgw
+Summary:        rados REST gateway
+Group:          Development/Libraries
+Requires:       mod_fcgid
+BuildRequires:  fcgi-devel
+BuildRequires:  expat-devel
+
+%description radosgw
+radosgw is an S3 HTTP REST gateway for the RADOS object store. It is
+implemented as a FastCGI module using libfcgi, and can be used in
+conjunction with any FastCGI capable web server.
+%endif
+
 %prep
 %setup -q
 
 %build
 ./autogen.sh
+%if %{with_radosgw}
+%{configure} --without-hadoop --with-radosgw
+%else
 %{configure} --without-hadoop 
+%endif
 make -j$(getconf _NPROCESSORS_ONLN) CFLAGS="$RPM_OPT_FLAGS" CXXFLAGS="$RPM_OPT_FLAGS"
 
 %install
@@ -151,6 +171,12 @@ fi
 %{_libdir}/librados.so
 %{_libdir}/rados-classes/libcls_rbd.so
 
+%if %{with_radosgw}
+%files radosgw
+%{_bindir}/radosgw
+%{_bindir}/radosgw_admin
+%endif
+
 %changelog
 * Fri Apr 30 2010 Sage Weil <sage@newdream.net> 0.19.1-5
 - Remove java deps (no need to build hadoop by default)
-- 
1.6.5.2

