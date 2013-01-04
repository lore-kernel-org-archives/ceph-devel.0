From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 5/6] configure.ac: remove AC_PROG_RANLIB
Date: Fri,  4 Jan 2013 18:51:30 +0100
Message-ID: <1357321891-20202-6-git-send-email-danny.al-gaaf@bisect.de>
References: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:54162 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754436Ab3ADRve (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 12:51:34 -0500
In-Reply-To: <1357321891-20202-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Remove already comment out AC_PROG_RANLIB to get rid of warning:

libtoolize: `AC_PROG_RANLIB' is rendered obsolete by `LT_INIT'

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 configure.ac | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 07bfaa9..15430dd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -51,7 +51,6 @@ AM_CONDITIONAL(FREEBSD, test x"$freebsd" = x"yes")
 # Checks for programs.
 AC_PROG_CXX
 #AC_PROG_CC
-#AC_PROG_RANLIB
 AC_PROG_MAKE_SET
 AC_PROG_LIBTOOL
 
-- 
1.8.0.2

