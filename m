From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 5/6] ceph.spec.in: extend fix for libedit-devel on special SUSE versions
Date: Wed, 30 Jan 2013 19:00:44 +0100
Message-ID: <1359568845-7634-6-git-send-email-danny.al-gaaf@bisect.de>
References: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51052 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756616Ab3A3SAs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Jan 2013 13:00:48 -0500
In-Reply-To: <1359568845-7634-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Extend fix for libedit-devel on special SUSE versions, use ncurses
also on src/ocf/Makefile and src/java/Makefile

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 ceph.spec.in | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ceph.spec.in b/ceph.spec.in
index f6a9006..0db7792 100644
--- a/ceph.spec.in
+++ b/ceph.spec.in
@@ -259,6 +259,8 @@ export RPM_OPT_FLAGS=`echo $RPM_OPT_FLAGS | sed -e 's/i386/i486/'`
 sed -i -e "s/-lcurses/-lncurses/g" Makefile
 sed -i -e "s/-lcurses/-lncurses/g" src/Makefile
 sed -i -e "s/-lcurses/-lncurses/g" man/Makefile
+sed -i -e "s/-lcurses/-lncurses/g" src/ocf/Makefile
+sed -i -e "s/-lcurses/-lncurses/g" src/java/Makefile
 %endif
 
 make -j$(getconf _NPROCESSORS_ONLN)
-- 
1.8.1.1

