From: Erik Logtenberg <erik@logtenberg.eu>
Subject: [PATCH] Add missing buildrequires for Fedora
Date: Tue, 30 Jul 2013 09:53:13 +0200
Message-ID: <51F770E9.6060004@logtenberg.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050904060008060908050503"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx.logtenberg.eu ([77.94.249.229]:53679 "EHLO mx.logtenberg.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754020Ab3G3HxP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jul 2013 03:53:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>
Cc: ceph-users@lists.ceph.com

This is a multi-part message in MIME format.
--------------050904060008060908050503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

This patch adds two buildrequires to the ceph.spec file, that are needed
to build the rpms under Fedora. Danny Al-Gaaf commented that the
snappy-devel dependency should actually be added to the leveldb-devel
package. I will try to get that fixed too, in the mean time, this patch
does make sure Ceph builds on Fedora.

Signed-off-by: Erik Logtenberg <erik@logtenberg.eu>
---

--------------050904060008060908050503
Content-Type: text/x-patch;
 name="add-missing-buildrequires-for-fedora.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="add-missing-buildrequires-for-fedora.patch"

--- ceph.spec-orig	2013-07-30 00:24:54.705000000 +0200
+++ ceph.spec	2013-07-30 01:20:23.593000000 +0200
@@ -42,6 +42,8 @@
 BuildRequires:  libxml2-devel
 BuildRequires:  libuuid-devel
 BuildRequires:  leveldb-devel > 1.2
+BuildRequires:  snappy-devel
+BuildRequires:  junit
 
 #################################################################################
 # specific

--------------050904060008060908050503--
