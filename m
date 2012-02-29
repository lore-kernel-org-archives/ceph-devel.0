From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] ceph: fix overflow check in build_snap_context()
Date: Tue, 28 Feb 2012 20:56:26 -0800
Message-ID: <4F4DAFFA.2000306@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:45708 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186Ab2B2E40 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:56:26 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id A9F0F24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:56:26 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 946BA24314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:56:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The overflow check for a + n * b should be (n > (ULONG_MAX - a) / b),
rather than (n > ULONG_MAX / b - a).

Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Sage Weil <sage@newdream.net>
---
  fs/ceph/snap.c |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index a559c80..f04c096 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -331,7 +331,7 @@ static int build_snap_context(struct ceph_snap_realm 
*realm)

  	/* alloc new snap context */
  	err = -ENOMEM;
-	if (num > ULONG_MAX / sizeof(u64) - sizeof(*snapc))
+	if (num > (ULONG_MAX - sizeof(*snapc)) / sizeof(u64))
  		goto fail;
  	snapc = kzalloc(sizeof(*snapc) + num*sizeof(u64), GFP_NOFS);
  	if (!snapc)
-- 
1.7.5.4

