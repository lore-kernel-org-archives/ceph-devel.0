From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 2/2] configure: remove -m4_include(m4/acx_pthread.m4)
Date: Wed, 23 Jan 2013 18:57:47 +0100
Message-ID: <1358963867-30235-3-git-send-email-danny.al-gaaf@bisect.de>
References: <1358963867-30235-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:45256 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755384Ab3AWR5v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 Jan 2013 12:57:51 -0500
In-Reply-To: <1358963867-30235-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Since we use already AC_CONFIG_MACRO_DIR, no need to include m4/acx_pthread.m4
extra.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 configure.ac | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index f87140f..ffbd150 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,6 +1,5 @@
 #                                               -*- Autoconf -*-
 # Process this file with autoconf to produce a configure script.
-m4_include(m4/acx_pthread.m4)
 
 # Autoconf
 AC_PREREQ(2.59)
-- 
1.8.1.1

