From: Jan Engelhardt <jengelh@inai.de>
Subject: [PATCH 4/6] build: make use of aux dir to unclutter the root a bit
Date: Wed, 12 Sep 2012 04:22:05 +0200
Message-ID: <1347416527-19752-5-git-send-email-jengelh@inai.de>
References: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ares07.inai.de ([5.9.24.206]:48874 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758721Ab2ILCWQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Sep 2012 22:22:16 -0400
In-Reply-To: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 .gitignore   |    4 +---
 configure.ac |    1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/.gitignore b/.gitignore
index 6071e8c..bf40c93 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,11 +2,9 @@
 /Makefile.in
 /aclocal.m4
 /autom4te.cache/
+/build-aux/
 /config.h.in*
 /configure
-/depcomp
-/install-sh
-/missing
 
 # created by ./configure
 /.deps/
diff --git a/configure.ac b/configure.ac
index 667d81d..6a26ab9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,4 +1,5 @@
 AC_INIT([leveldb], [0.1], [leveldb@googlegroups.com])
+AC_CONFIG_AUX_DIR([build-aux])
 AM_INIT_AUTOMAKE([-Wall -Werror foreign])
 m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])
 AC_PROG_CC
-- 
1.7.10.4

