From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 23/33] libceph: enable OSDMAP_ENC feature bit
Date: Thu, 27 Mar 2014 20:18:09 +0200
Message-ID: <1395944299-21970-24-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:38595 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757144AbaC0STS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:18 -0400
Received: by mail-ee0-f44.google.com with SMTP id e49so3204912eek.17
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:17 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id t44sm5990142eeo.6.2014.03.27.11.19.15
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:16 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Announce our support for "new" osdmap enconding.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/ceph_features.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index 77c097fe9ea9..7a4cab50b2cd 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -90,6 +90,7 @@ static inline u64 ceph_sanitize_features(u64 features)
 	 CEPH_FEATURE_OSD_CACHEPOOL |		\
 	 CEPH_FEATURE_CRUSH_V2 |		\
 	 CEPH_FEATURE_EXPORT_PEER |		\
+	 CEPH_FEATURE_OSDMAP_ENC |		\
 	 CEPH_FEATURE_CRUSH_TUNABLES3)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
-- 
1.7.10.4

