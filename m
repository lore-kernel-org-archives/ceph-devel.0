From: John Spray <john.spray@redhat.com>
Subject: [PATCH 2/7] ceph: remove unused `map_waiters` from osdc client
Date: Tue,  4 Nov 2014 14:34:24 +0000
Message-ID: <1415111669-26246-3-git-send-email-john.spray@redhat.com>
References: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:55550 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbaKDOfN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 09:35:13 -0500
Received: by mail-wi0-f173.google.com with SMTP id n3so9580565wiv.6
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 06:35:11 -0800 (PST)
In-Reply-To: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Spray <john.spray@redhat.com>

This is initialized but never used.

Signed-off-by: John Spray <john.spray@redhat.com>
---
 include/linux/ceph/osd_client.h | 1 -
 net/ceph/osd_client.c           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 03aeb27..7cb5cea 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -197,7 +197,6 @@ struct ceph_osd_client {
 
 	struct ceph_osdmap     *osdmap;       /* current map */
 	struct rw_semaphore    map_sem;
-	struct completion      map_waiters;
 	u64                    last_requested_map;
 
 	struct mutex           request_mutex;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 5a75395..75ab07c 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2537,7 +2537,6 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 	osdc->client = client;
 	osdc->osdmap = NULL;
 	init_rwsem(&osdc->map_sem);
-	init_completion(&osdc->map_waiters);
 	osdc->last_requested_map = 0;
 	mutex_init(&osdc->request_mutex);
 	osdc->last_tid = 0;
-- 
1.9.3

