From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH RFC 6/6] cls_lock: add support for lock_info
Date: Tue, 30 Jun 2015 13:28:01 -0700
Message-ID: <cd1180e893cd1a3bbebdf947b5dde39248128ac2.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60475 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbbF3U35 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jun 2015 16:29:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 7F3AF2CD80A
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 20:29:57 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5UKTrtn018417
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 16:29:57 -0400
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add an interface for the lock.lock_info method and associated data
structures.

Based heavily on Mike Christie's code originally authored for the previous
commit.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 include/linux/ceph/cls_lock.h |  27 ++++++++
 net/ceph/cls_lock.c           | 156 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+)

diff --git a/include/linux/ceph/cls_lock.h b/include/linux/ceph/cls_lock.h
index 2c24eb2..d6d3636 100644
--- a/include/linux/ceph/cls_lock.h
+++ b/include/linux/ceph/cls_lock.h
@@ -1,6 +1,33 @@
 #ifndef _NET_CEPH_RADOS_LOCK_H
 #define _NET_CEPH_RADOS_LOCK_H
 
+#include <linux/ceph/types.h>
+#include <linux/ceph/msgpool.h>
+#include <linux/ceph/messenger.h>
+#include <linux/ceph/osdmap.h>
+#include <linux/ceph/osd_client.h>
+
+struct ceph_locker_id {
+	struct ceph_entity_name name;
+	size_t cookie_len;
+	char *cookie;
+};
+
+struct ceph_locker_info {
+	struct timespec ts;
+	struct ceph_entity_addr addr;
+	size_t desc_len;
+	char *desc;
+};
+
+struct ceph_locker {
+	struct ceph_locker_id id;
+	struct ceph_locker_info info;
+};
+
+int ceph_cls_lock_info(struct ceph_osd_client *osdc, int poolid, char *obj_name,
+		       char * lock_name, int *num_lockers,
+		       struct ceph_locker **lockers, u8 *lock_type, char **tag);
 int ceph_cls_lock(struct ceph_osd_client *osdc, int poolid, char *obj_name,
 		  char *lock_name, u8 type, char *cookie, char *tag, char *desc,
 		  u8 flags);
diff --git a/net/ceph/cls_lock.c b/net/ceph/cls_lock.c
index 4eff868..415a41b 100644
--- a/net/ceph/cls_lock.c
+++ b/net/ceph/cls_lock.c
@@ -3,11 +3,167 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 
+#include <linux/ceph/cls_lock.h>
+#include <linux/ceph/auth.h>
 #include <linux/ceph/decode.h>
 #include <linux/ceph/messenger.h>
 #include <linux/ceph/msgpool.h>
 #include <linux/ceph/osd_client.h>
 
+static int __decode_locker(struct ceph_locker *locker, void **p, void *end)
+{
+	/*
+	 * struct cls_lock_get_info_reply {
+	 * 	map {
+	 * 		struct locker_id_t {
+	 * 			struct entity_name_t {
+	 * 				__u8 type;
+	 * 				int64_t num;
+	 * 			}
+	 * 			string cookie;
+	 * 		}
+	 * 		struct locker_info_t {
+	 * 			struct timespec ts;
+	 *			struct ceph_entity_addr addr;
+	 *			string description;
+	 *		}
+	 *	}
+	 *	uint8_t lock_type;
+	 *	string tag;
+	 * }
+	 */
+	int ret;
+	u32 len;
+
+	/* locker_id_t */
+	ret = ceph_start_decoding_compat(p, end, 1, 1, 1, &len);
+	if (ret)
+		return ret;
+
+	ret = ceph_entity_name_decode(&locker->id.name, p, end);
+	if (ret)
+		return ret;
+
+	locker->id.cookie = ceph_extract_encoded_string(p, end,
+						        &locker->id.cookie_len,
+						        GFP_NOIO);
+	if (IS_ERR(locker->id.cookie))
+		return PTR_ERR(locker->id.cookie);
+
+	/* locker_info_t */
+	ret = ceph_start_decoding_compat(p, end, 1, 1, 1, &len);
+	if (ret)
+		goto free_cookie;
+
+	ceph_decode_timespec(&locker->info.ts, *p);
+	*p += sizeof(struct ceph_timespec);
+
+	ret = -ERANGE;
+	ceph_decode_copy_safe(p, end, &locker->info.addr,
+			      sizeof(locker->info.addr), free_cookie);
+	ceph_decode_addr(&locker->info.addr);
+
+	locker->info.desc = ceph_extract_encoded_string(p, end,
+							&locker->info.desc_len,
+							GFP_NOIO);
+	if (IS_ERR(locker->info.desc)) {
+		ret = PTR_ERR(locker->info.desc);
+		goto free_cookie;
+	}
+
+	return 0;
+
+free_cookie:
+	kfree(locker->id.cookie);
+	return ret;
+}
+	
+int ceph_cls_lock_info(struct ceph_osd_client *osdc, int poolid, char *obj_name,
+		       char *lock_name, int *num_lockers,
+		       struct ceph_locker **lockers, u8 *lock_type, char **tag)
+{
+	int get_info_op_buf_size;
+	int name_len = strlen(lock_name);
+	struct page *get_info_page;
+	struct page *reply_page;
+	size_t reply_len;
+	int len;
+	u32 num;
+	void *p, *end;
+	int ret;
+	int i;
+
+	get_info_op_buf_size = name_len + sizeof(__le32) +
+			       CEPH_ENCODING_START_BLK_LEN;
+	BUG_ON(get_info_op_buf_size > PAGE_SIZE);
+
+	get_info_page = alloc_page(GFP_NOIO);
+	if (!get_info_page)
+		return -ENOMEM;
+
+	reply_page = alloc_page(GFP_NOIO);
+	if (!reply_page) {
+		__free_page(get_info_page);
+		return -ENOMEM;
+	}
+
+	p = page_address(get_info_page);
+	end = p + get_info_op_buf_size;
+
+	ceph_start_encoding(&p, 1, 1,
+			    get_info_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
+
+	ceph_encode_string(&p, end, lock_name, name_len);
+
+	dout("%s: lock info for %s on object %s\n",
+	     __func__, lock_name, obj_name);
+
+	ret = ceph_osd_op_cls_call(osdc, poolid, obj_name, "lock", "get_info",
+				   CEPH_OSD_FLAG_READ | CEPH_OSD_FLAG_ACK,
+				   &get_info_page, get_info_op_buf_size,
+				   &reply_page, &reply_len);
+
+	dout("%s: status %d\n", __func__, ret);
+	if (ret < 0)
+		goto err;
+
+	p = page_address(reply_page);
+	end = p + reply_len;
+
+	ret = ceph_start_decoding_compat(&p, end, 1, 1, 1, &len);
+	if (ret)
+		goto err;
+
+	ret = -ERANGE;
+	ceph_decode_32_safe(&p, end, num, err);
+	*num_lockers = (int)num;
+
+	*lockers = kzalloc(num * sizeof(**lockers), GFP_NOIO);
+	if (!*lockers) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	for (i = 0; i < num; i++) {
+		ret = __decode_locker(*lockers + i, &p, end);
+		if (ret)
+			goto free_lockers;
+	}
+
+	ceph_decode_8_safe(&p, end, *lock_type, free_lockers);
+	*tag = ceph_extract_encoded_string(&p, end, NULL, GFP_NOIO);
+
+	return 0;
+
+free_lockers:
+	kfree(*lockers);
+err:
+	__free_page(get_info_page);
+	__free_page(reply_page);
+	return ret;
+}
+EXPORT_SYMBOL(ceph_cls_lock_info);
+
 /**
  * ceph_cls_lock - grab rados lock for object
  *  @osdc, @poolid, @obj_name: object to lock
-- 
1.9.3

