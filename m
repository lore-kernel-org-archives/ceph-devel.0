From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH] automake: enable 'make V=0'
Date: Tue,  8 Nov 2011 18:39:17 -0800
Message-ID: <1320806361-1801-1-git-send-email-jayhawk@cs.ucsc.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:44375 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab1KIDBB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2011 22:01:01 -0500
Received: from piha.cse.ucsc.edu (piha.soe.ucsc.edu [128.114.52.38])
	by mail-01.cse.ucsc.edu (Postfix) with ESMTPSA id 9571E774C004
	for <ceph-devel@vger.kernel.org>; Tue,  8 Nov 2011 18:51:59 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

From: Noah Watkins <noahwatkins@gmail.com>

Enables silent mode for automake generated Makefiles,
and silent mode is _off_ by default. Using V=0 the output
is much easier to read when trying to find warnings:

nwatkins@piha:~/Projects/ceph/ceph$ make -j8 V=0
make[3]: Entering directory `/users/nwatkins/Projects/ceph/ceph/src'
  CC     locks.o
  CXX    journal.o
  CXX    Server.o
  CXX    Mutation.o
  CXX    MDCache.o
  CXX    Locker.o
  CXX    Migrator.o
  CXX    MDBalancer.o
  CXX    CDentry.o
  CXX    CDir.o
  CXX    CInode.o
  CXX    LogEvent.o
  CXX    MDSTable.o

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 configure.ac |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 54582e9..1700daa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -20,6 +20,9 @@ AM_INIT_AUTOMAKE
 AM_PROG_CC_C_O
 AM_PROG_LIBTOOL
 
+# Enable make V=0
+AM_SILENT_RULES([yes])
+
 # Platform
 case "${target_os}" in
 darwin*)
-- 
1.7.1

