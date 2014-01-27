From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 11/11] libceph: support CEPH_FEATURE_OSD_CACHEPOOL feature
Date: Mon, 27 Jan 2014 17:58:53 +0200
Message-ID: <1390838333-32266-12-git-send-email-ilya.dryomov@inktank.com>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:51937 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbaA0QAP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 11:00:15 -0500
Received: by mail-lb0-f169.google.com with SMTP id q8so4614342lbi.14
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 08:00:13 -0800 (PST)
In-Reply-To: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Announce our (limited, see previous commit) support for CACHEPOOL
feature.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/ceph_features.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index d21b34d94436..138448f766b4 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -80,6 +80,7 @@ static inline u64 ceph_sanitize_features(u64 features)
 	 CEPH_FEATURE_CRUSH_TUNABLES2 |		\
 	 CEPH_FEATURE_REPLY_CREATE_INODE |	\
 	 CEPH_FEATURE_OSDHASHPSPOOL |		\
+	 CEPH_FEATURE_OSD_CACHEPOOL |		\
 	 CEPH_FEATURE_CRUSH_V2 |		\
 	 CEPH_FEATURE_EXPORT_PEER)
 
-- 
1.7.10.4

