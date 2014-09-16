From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 1/3] libceph: reference counting pagelist
Date: Tue, 16 Sep 2014 21:39:17 +0800
Message-ID: <1410874759-11562-1-git-send-email-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10651 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753259AbaIPNjb (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Sep 2014 09:39:31 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8GDdV0l005774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Tue, 16 Sep 2014 09:39:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: "Yan, Zheng" <zyan@redhat.com>

this allow pagelist to present data that may be sent multiple times.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/mds_client.c          | 1 -
 include/linux/ceph/pagelist.h | 5 ++++-
 net/ceph/messenger.c          | 4 +---
 net/ceph/pagelist.c           | 8 ++++++--
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a17fc49..30d7338 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2796,7 +2796,6 @@ fail:
 	mutex_unlock(&session->s_mutex);
 fail_nomsg:
 	ceph_pagelist_release(pagelist);
-	kfree(pagelist);
 fail_nopagelist:
 	pr_err("error %d preparing reconnect for mds%d\n", err, mds);
 	return;
diff --git a/include/linux/ceph/pagelist.h b/include/linux/ceph/pagelist.h
index 9660d6b..5f871d8 100644
--- a/include/linux/ceph/pagelist.h
+++ b/include/linux/ceph/pagelist.h
@@ -2,6 +2,7 @@
 #define __FS_CEPH_PAGELIST_H
 
 #include <linux/list.h>
+#include <linux/atomic.h>
 
 struct ceph_pagelist {
 	struct list_head head;
@@ -10,6 +11,7 @@ struct ceph_pagelist {
 	size_t room;
 	struct list_head free_list;
 	size_t num_pages_free;
+	atomic_t refcnt;
 };
 
 struct ceph_pagelist_cursor {
@@ -26,9 +28,10 @@ static inline void ceph_pagelist_init(struct ceph_pagelist *pl)
 	pl->room = 0;
 	INIT_LIST_HEAD(&pl->free_list);
 	pl->num_pages_free = 0;
+	atomic_set(&pl->refcnt, 1);
 }
 
-extern int ceph_pagelist_release(struct ceph_pagelist *pl);
+extern void ceph_pagelist_release(struct ceph_pagelist *pl);
 
 extern int ceph_pagelist_append(struct ceph_pagelist *pl, const void *d, size_t l);
 
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index e7d9411..9764c77 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3071,10 +3071,8 @@ static void ceph_msg_data_destroy(struct ceph_msg_data *data)
 		return;
 
 	WARN_ON(!list_empty(&data->links));
-	if (data->type == CEPH_MSG_DATA_PAGELIST) {
+	if (data->type == CEPH_MSG_DATA_PAGELIST)
 		ceph_pagelist_release(data->pagelist);
-		kfree(data->pagelist);
-	}
 	kmem_cache_free(ceph_msg_data_cache, data);
 }
 
diff --git a/net/ceph/pagelist.c b/net/ceph/pagelist.c
index 92866be..f70b651 100644
--- a/net/ceph/pagelist.c
+++ b/net/ceph/pagelist.c
@@ -1,5 +1,6 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
+#include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/ceph/pagelist.h>
@@ -13,8 +14,10 @@ static void ceph_pagelist_unmap_tail(struct ceph_pagelist *pl)
 	}
 }
 
-int ceph_pagelist_release(struct ceph_pagelist *pl)
+void ceph_pagelist_release(struct ceph_pagelist *pl)
 {
+	if (!atomic_dec_and_test(&pl->refcnt))
+		return;
 	ceph_pagelist_unmap_tail(pl);
 	while (!list_empty(&pl->head)) {
 		struct page *page = list_first_entry(&pl->head, struct page,
@@ -23,7 +26,8 @@ int ceph_pagelist_release(struct ceph_pagelist *pl)
 		__free_page(page);
 	}
 	ceph_pagelist_free_reserve(pl);
-	return 0;
+	kfree(pl);
+	return;
 }
 EXPORT_SYMBOL(ceph_pagelist_release);
 
-- 
1.9.3

