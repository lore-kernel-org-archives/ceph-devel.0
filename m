From: Sage Weil <sage@newdream.net>
Subject: [PATCH 04/11] crush: adjust local retry threshold
Date: Fri,  4 May 2012 15:54:01 -0700
Message-ID: <1336172048-6848-5-git-send-email-sage@newdream.net>
References: <1336172048-6848-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37644 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760565Ab2EDWyO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 May 2012 18:54:14 -0400
In-Reply-To: <1336172048-6848-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

This small adjustment reflects a change that was made in ceph.git commit
af6a9f30696c900a2a8bd7ae24e8ed15fb4964bb, about 6 months ago.  An N-1
search is not exhaustive.  Fixed ceph.git bug #1594.

Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/crush/mapper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 7aa79a4..4df0607 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -415,7 +415,7 @@ reject:
 					if (collide && flocal < 3)
 						/* retry locally a few times */
 						retry_bucket = 1;
-					else if (flocal < in->size + orig_tries)
+					else if (flocal <= in->size + orig_tries)
 						/* exhaustive bucket search */
 						retry_bucket = 1;
 					else if (ftotal < 20)
-- 
1.7.9

