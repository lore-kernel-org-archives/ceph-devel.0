From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] ceph: use 2 instead of 1 as fallback for 32-bit inode number
Date: Tue, 28 Feb 2012 19:06:13 -0800
Message-ID: <4F4D9625.6050708@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42676 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755406Ab2B2DGO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:06:14 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DE9B72431D
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:06:13 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id D73CA24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:06:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The root directory of the Ceph mount has inode number 1, so falling back
to 1 always creates a collision. 2 is unused on my test systems and seems
less likely to collide.

Signed-off-by: Amon Ott <ao@m-privacy.de>
Signed-off-by: Sage Weil <sage@newdream.net>
---
  fs/ceph/super.h |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index edcbf37..5f00e82 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -366,7 +366,7 @@ static inline u32 ceph_ino_to_ino32(__u64 vino)
  	u32 ino = vino & 0xffffffff;
  	ino ^= vino >> 32;
  	if (!ino)
-		ino = 1;
+		ino = 2;
  	return ino;
  }

-- 
1.7.5.4

