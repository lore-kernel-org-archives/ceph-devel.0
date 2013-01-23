From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 1/2] configure: fix RPM_RELEASE
Date: Wed, 23 Jan 2013 18:57:46 +0100
Message-ID: <1358963867-30235-2-git-send-email-danny.al-gaaf@bisect.de>
References: <1358963867-30235-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:45259 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755822Ab3AWR5v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 Jan 2013 12:57:51 -0500
In-Reply-To: <1358963867-30235-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Use git to get RPM_RELEASE only if this is a git repo
clone and if the git command is available on the system.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 configure.ac | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index b67e5cd..f87140f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -12,8 +12,15 @@ AC_PREREQ(2.59)
 AC_INIT([ceph], [0.56], [ceph-devel@vger.kernel.org])
 
 # Create release string.  Used with VERSION for RPMs.
+RPM_RELEASE=0
 AC_SUBST(RPM_RELEASE)
-RPM_RELEASE=`if expr index $(git describe --always) '-' > /dev/null ; then git describe --always | cut -d- -f2- | tr '-' '.' ; else echo "0"; fi`
+if test -d ".git" ; then
+  AC_CHECK_PROG(GIT_CHECK, git, yes)
+  if test x"$GIT_CHECK" = x"yes"; then
+    RPM_RELEASE=`if expr index $(git describe --always) '-' > /dev/null ; then git describe --always | cut -d- -f2- | tr '-' '.' ; else echo "0"; fi`
+  fi
+fi
+AC_MSG_NOTICE([RPM_RELEASE='$RPM_RELEASE'])
 
 AC_CONFIG_MACRO_DIR([m4])
 
-- 
1.8.1.1

