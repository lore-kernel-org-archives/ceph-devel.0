From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] mkcephfs: Do not pipe echo output into --allhosts
Date: Fri, 27 Aug 2010 16:20:06 -0600
Message-ID: <1282947606-23020-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:46163 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab0H0WUc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Aug 2010 18:20:32 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: sage@newdream.net, Jim Schutt <jaschut@sandia.gov>


Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/mkcephfs.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/mkcephfs.in b/src/mkcephfs.in
index 288cbd4..fa35382 100644
--- a/src/mkcephfs.in
+++ b/src/mkcephfs.in
@@ -86,7 +86,7 @@ done
 [ -z "$conf" ] && usage_exit
 
 if [ $allhosts -eq 0 ]; then
-    echo mkcephfs currently requires -a|--allhosts to initialize the whole fs at once.
+    echo mkcephfs currently requires "-a|--allhosts" to initialize the whole fs at once.
     usage_exit
 fi
 
-- 
1.6.6.1


