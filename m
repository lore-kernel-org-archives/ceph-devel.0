From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: advertise support for keepalive2
Date: Mon, 14 Sep 2015 16:51:35 +0300
Message-ID: <1442238695-13809-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36000 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbbINNvq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Sep 2015 09:51:46 -0400
Received: by wicgb1 with SMTP id gb1so142882390wic.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2015 06:51:43 -0700 (PDT)
Received: from orange.local.localdomain ([109.110.66.71])
        by smtp.gmail.com with ESMTPSA id i7sm14480448wib.15.2015.09.14.06.51.43
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Sep 2015 06:51:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We are the client, but advertise keepalive2 anyway - for consistency,
if nothing else.  In the future the server might want to know whether
its clients support keepalive2.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/ceph_features.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index 4763ad64e832..f89b31d45cc8 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -107,6 +107,7 @@ static inline u64 ceph_sanitize_features(u64 features)
 	 CEPH_FEATURE_OSDMAP_ENC |		\
 	 CEPH_FEATURE_CRUSH_TUNABLES3 |		\
 	 CEPH_FEATURE_OSD_PRIMARY_AFFINITY |	\
+	 CEPH_FEATURE_MSGR_KEEPALIVE2 |		\
 	 CEPH_FEATURE_CRUSH_V4)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
-- 
1.9.3

