From: Kuan Kai Chiu <big.chiu@bigtera.com>
Subject: [PATCH 2/2] mds: journal the projected root xattrs in add_root()
Date: Thu, 18 Apr 2013 14:43:26 +0800
Message-ID: <1366267406-1449-3-git-send-email-big.chiu@bigtera.com>
References: <y>
 <1366267406-1449-1-git-send-email-big.chiu@bigtera.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:44649 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965286Ab3DRGol (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 02:44:41 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so1181157daj.36
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 23:44:40 -0700 (PDT)
In-Reply-To: <1366267406-1449-1-git-send-email-big.chiu@bigtera.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Kuan Kai Chiu <big.chiu@bigtera.com>

In EMetaBlob::add_root(), we should log the projected root xattrs
instead of original ones to reflect xattr changes.

Signed-off-by: Kuan Kai Chiu <big.chiu@bigtera.com>
---
 src/mds/events/EMetaBlob.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mds/events/EMetaBlob.h b/src/mds/events/EMetaBlob.h
index 7065460..439bd78 100644
--- a/src/mds/events/EMetaBlob.h
+++ b/src/mds/events/EMetaBlob.h
@@ -468,7 +468,7 @@ private:
 
     if (!pi) pi = in->get_projected_inode();
     if (!pdft) pdft = &in->dirfragtree;
-    if (!px) px = &in->xattrs;
+    if (!px) px = in->get_projected_xattrs();
 
     bufferlist snapbl;
     if (psnapbl)
-- 
1.7.9.5

