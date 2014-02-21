From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 3/6] libceph: bump CEPH_OSD_MAX_OP to 3
Date: Fri, 21 Feb 2014 20:55:43 +0200
Message-ID: <1393008946-7931-4-git-send-email-ilya.dryomov@inktank.com>
References: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64736 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848AbaBUS4B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2014 13:56:01 -0500
Received: by mail-ee0-f46.google.com with SMTP id c13so1750294eek.5
        for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2014 10:56:00 -0800 (PST)
Received: from localhost ([109.110.66.27])
        by mx.google.com with ESMTPSA id j41sm29560052eeg.10.2014.02.21.10.55.58
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Feb 2014 10:55:59 -0800 (PST)
In-Reply-To: <1393008946-7931-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Our longest osd request now contains 3 ops: copyup+hint+write.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osd_client.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 6bfcb0eca8ab..bc874b2398d7 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -43,7 +43,7 @@ struct ceph_osd {
 };
 
 
-#define CEPH_OSD_MAX_OP	2
+#define CEPH_OSD_MAX_OP	3
 
 enum ceph_osd_data_type {
 	CEPH_OSD_DATA_TYPE_NONE = 0,
-- 
1.7.10.4

