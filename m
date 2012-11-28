From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 10/30] common/pipe.c: remove twice included unistd.h
Date: Wed, 28 Nov 2012 13:57:18 +0100
Message-ID: <1354107458-30941-11-git-send-email-danny.al-gaaf@bisect.de>
References: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:34818 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755091Ab2K1NEQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 08:04:16 -0500
In-Reply-To: <1354107458-30941-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Danny Al-Gaaf <dalgaaf@suse.de>

Fix includes: remove twice included unistd.h

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/common/pipe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/common/pipe.c b/src/common/pipe.c
index e35b6fe..9c01b32 100644
--- a/src/common/pipe.c
+++ b/src/common/pipe.c
@@ -17,7 +17,6 @@
 #include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <unistd.h>
 
 int pipe_cloexec(int pipefd[2])
 {
-- 
1.8.0

