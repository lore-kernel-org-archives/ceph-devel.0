From: Holger Macht <hmacht@suse.de>
Subject: [PATCH] ceph.spec.in: Change license of base package to GPL and use
 SPDX format
Date: Mon, 02 Jul 2012 21:07:47 +0200
Message-ID: <4FF1F183.60507@suse.de>
Reply-To: hmacht@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56477 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab2GBTHw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Jul 2012 15:07:52 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5DBD0912E4
	for <ceph-devel@vger.kernel.org>; Mon,  2 Jul 2012 21:07:51 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

LGPLv2 in spec file is not correct, because some of the included
packages/binaries are GPLv2. For example:

 src/mount/mtab.c     -> package ceph, binary mount.ceph
 src/common/fiemap.cc -> package ceph, binary rbd

Also use SPDX format (http://www.spdx.org/licenses) for the sub-package
licenses.

Signed-off-by: Holger Macht <hmacht@suse.de>
---
 ceph.spec.in |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/ceph.spec.in b/ceph.spec.in
index 461bd1f..d80cb46 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -17,7 +17,7 @@ Name:		ceph
 Version:	@VERSION@
 Release:	6%{?dist}
 Summary:	User space components of the Ceph file system
-License:	LGPLv2
+License:	GPL-2.0
 Group:		System Environment/Base
 URL:		http://ceph.com/
 Source0:	http://ceph.com/download/%{name}-%{version}.tar.bz2
@@ -73,6 +73,7 @@ performance, reliability, and scalability.
 %package fuse
 Summary:	Ceph fuse-based client
 Group:		System Environment/Base
+License:	LGPL-2.0
 Requires:	%{name} = %{version}-%{release}
 BuildRequires:	fuse-devel
 %description fuse
@@ -81,7 +82,7 @@ FUSE based client for Ceph distributed network file system
 %package devel
 Summary:	Ceph headers
 Group:		Development/Libraries
-License:	LGPLv2
+License:	LGPL-2.0
 Requires:	%{name} = %{version}-%{release}
 Requires:	librados2 = %{version}
 Requires:	librbd1 = %{version}
@@ -93,6 +94,7 @@ that use Ceph.
 %package radosgw
 Summary:	Rados REST gateway
 Group:		Development/Libraries
+License:	LGPL-2.0
 Requires:	librados2 = %{version}-%{release}
 %if 0%{defined suse_version}
 BuildRequires:	libexpat-devel
@@ -111,7 +113,7 @@ conjunction with any FastCGI capable web server.
 %package obsync
 Summary:	synchronize data between cloud object storage providers or a local directory
 Group:		Productivity/Networking/Other
-License:	LGPLv2
+License:	LGPL-2.0
 Requires:	python, python-boto
 %description obsync
 obsync is a tool to synchronize objects between cloud object
@@ -122,7 +124,7 @@ Ceph RADOS cluster, or a local directory.
 %package resource-agents
 Summary:	OCF-compliant resource agents for Ceph daemons
 Group:		System Environment/Base
-License:	LGPLv2
+License:	LGPL-2.0
 Requires:	%{name} = %{version}
 Requires:	resource-agents
 %description resource-agents
@@ -134,7 +136,7 @@ managers such as Pacemaker.
 %package -n librados2
 Summary:	RADOS distributed object store client library
 Group:		System Environment/Libraries
-License:	LGPLv2
+License:	LGPL-2.0
 %description -n librados2
 RADOS is a reliable, autonomic distributed object storage cluster
 developed as part of the Ceph distributed storage system. This is a
@@ -144,7 +146,7 @@ store using a simple file-like interface.
 %package -n librbd1
 Summary:	RADOS block device client library
 Group:		System Environment/Libraries
-License:	LGPLv2
+License:	LGPL-2.0
 Requires:	librados2 = %{version}-%{release}
 %description -n librbd1
 RBD is a block device striped across multiple distributed objects in
@@ -155,7 +157,7 @@ shared library allowing applications to manage these block devices.
 %package -n libcephfs1
 Summary:	Ceph distributed file system client library
 Group:		System Environment/Libraries
-License:	LGPLv2
+License:	LGPL-2.0
 %description -n libcephfs1
 Ceph is a distributed network file system designed to provide excellent
 performance, reliability, and scalability. This is a shared library
@@ -165,7 +167,7 @@ POSIX-like interface.
 %package -n python-ceph
 Summary:	Python libraries for the Ceph distributed filesystem
 Group:		System Environment/Libraries
-License:	LGPLv2
+License:	LGPL-2.0
 Requires:	librados2 = %{version}-%{release}
 Requires:	librbd1 = %{version}-%{release}
 Requires:	libcephfs1 = %{version}-%{release}
-- 
1.7.9.5

