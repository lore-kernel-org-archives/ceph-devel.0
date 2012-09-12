From: Jan Engelhardt <jengelh@inai.de>
Subject: [PATCH 2/6] build: support for automake-1.12
Date: Wed, 12 Sep 2012 04:22:03 +0200
Message-ID: <1347416527-19752-3-git-send-email-jengelh@inai.de>
References: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ares07.inai.de ([5.9.24.206]:48867 "EHLO seven.medozas.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757410Ab2ILCWQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Sep 2012 22:22:16 -0400
In-Reply-To: <1347416527-19752-1-git-send-email-jengelh@inai.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: ceph-devel@vger.kernel.org

/usr/share/automake-1.12/am/library.am:
warning: 'libleveldb.a': linking libraries using a non-POSIX
archiver requires 'AM_PROG_AR' in 'configure.ac'

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 configure.ac |    1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index f3e7ce2..667d81d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -8,6 +8,7 @@ AC_CONFIG_HEADERS([config.h])
 AC_CONFIG_FILES([
   Makefile
 ])
+m4_ifdef([AM_PROG_AR], [AM_PROG_AR])
 AC_PROG_RANLIB
 
 AC_MSG_CHECKING(whether compiler supports C++11 cstdatomic)
-- 
1.7.10.4

