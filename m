From: Florian Haas <florian@hastexo.com>
Subject: [PATCH 2/2] Spec: conditionally build ceph-resource-agents package
Date: Thu, 29 Dec 2011 20:58:02 +0100
Message-ID: <1325188682-9518-3-git-send-email-florian@hastexo.com>
References: <1325188682-9518-1-git-send-email-florian@hastexo.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52789 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356Ab1L2T7V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Dec 2011 14:59:21 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so13165980eek.19
        for <ceph-devel@vger.kernel.org>; Thu, 29 Dec 2011 11:59:20 -0800 (PST)
In-Reply-To: <1325188682-9518-1-git-send-email-florian@hastexo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Florian Haas <florian@hastexo.com>

Put OCF resource agents in a separate subpackage,
to be enabled with a separate build conditional
(--with ocf).

Make the subpackage depend on the resource-agents
package, which provides the ocf-shellfuncs library
that the Ceph RAs use.

Signed-off-by: Florian Haas <florian@hastexo.com>
---
 ceph.spec.in |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index b0f3c3a..3950fd1 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -1,5 +1,6 @@
 %define with_gtk2 %{?_with_gtk2: 1} %{!?_with_gtk2: 0}
 
+%bcond_with ocf
 # it seems there is no usable tcmalloc rpm for x86_64; parts of
 # google-perftools don't compile on x86_64, and apparently the
 # decision was to not build the package at all, even if tcmalloc
@@ -130,6 +131,19 @@ gcephtool is a graphical monitor for the clusters running the Ceph distributed
 file system.
 %endif
 
+%if %{with ocf}
+%package resource-agents
+Summary:	OCF-compliant resource agents for Ceph daemons
+Group:		System Environment/Base
+License:	LGPLv2
+Requires:	%{name} = %{version}
+Requires:	resource-agents
+%description resource-agents
+Resource agents for monitoring and managing Ceph daemons
+under Open Cluster Framework (OCF) compliant resource
+managers such as Pacemaker.
+%endif
+
 %package -n librados2
 Summary:	RADOS distributed object store client library
 Group:		System Environment/Libraries
@@ -211,6 +225,7 @@ MY_CONF_OPT="$MY_CONF_OPT --without-gtk2"
 		--docdir=%{_docdir}/ceph \
 		--without-hadoop \
 		$MY_CONF_OPT \
+		%{?_with_ocf} \
 		%{?with_tcmalloc:--with-tcmalloc} %{!?with_tcmalloc:--without-tcmalloc}
 
 # fix bug in specific version of libedit-devel
@@ -415,6 +430,13 @@ fi
 %endif
 
 #################################################################################
+%if %{with ocf}
+%files resource-agents
+%defattr(0755,root,root,-)
+/usr/lib/ocf/resource.d/%{name}/*
+%endif
+
+#################################################################################
 %files -n librados2
 %defattr(-,root,root,-)
 %{_libdir}/librados.so.*
-- 
1.7.5.4

