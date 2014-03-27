From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 33/33] libceph: enable PRIMARY_AFFINITY feature bit
Date: Thu, 27 Mar 2014 20:18:19 +0200
Message-ID: <1395944299-21970-34-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:49509 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161AbaC0STl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:41 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so3225877eek.4
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:40 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id t50sm5962930eev.28.2014.03.27.11.19.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:39 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Announce our support for osdmaps with non-default primary affinity
values.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/ceph_features.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index 7a4cab50b2cd..d12659ce550d 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -91,7 +91,8 @@ static inline u64 ceph_sanitize_features(u64 features)
 	 CEPH_FEATURE_CRUSH_V2 |		\
 	 CEPH_FEATURE_EXPORT_PEER |		\
 	 CEPH_FEATURE_OSDMAP_ENC |		\
-	 CEPH_FEATURE_CRUSH_TUNABLES3)
+	 CEPH_FEATURE_CRUSH_TUNABLES3 |		\
+	 CEPH_FEATURE_OSD_PRIMARY_AFFINITY)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
 	(CEPH_FEATURE_NOSRCADDR |	 \
-- 
1.7.10.4

