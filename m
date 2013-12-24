From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] crush: support new indep mode and SET_* steps (crush v2) by default
Date: Tue, 24 Dec 2013 22:10:43 +0200
Message-ID: <1387915843-18878-1-git-send-email-ilya.dryomov@inktank.com>
References: <alpine.DEB.2.00.1312230932230.4949@cobra.newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:64330 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3LXULf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Dec 2013 15:11:35 -0500
Received: by mail-ee0-f50.google.com with SMTP id c41so2994560eek.23
        for <ceph-devel@vger.kernel.org>; Tue, 24 Dec 2013 12:11:34 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1312230932230.4949@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Add CRUSH_V2 feature (new indep mode and SET_* steps) to a set of
features supported by default.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/ceph_features.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index 003ea719be65..5f42e4412909 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -79,7 +79,8 @@ static inline u64 ceph_sanitize_features(u64 features)
 	 CEPH_FEATURE_CRUSH_TUNABLES |		\
 	 CEPH_FEATURE_CRUSH_TUNABLES2 |		\
 	 CEPH_FEATURE_REPLY_CREATE_INODE |	\
-	 CEPH_FEATURE_OSDHASHPSPOOL)
+	 CEPH_FEATURE_OSDHASHPSPOOL |		\
+	 CEPH_FEATURE_CRUSH_V2)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
 	(CEPH_FEATURE_NOSRCADDR |	 \
-- 
1.7.10.4

