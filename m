From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 05/16] libceph: support for lock.lock_info
Date: Wed, 24 Aug 2016 15:18:29 +0200
Message-ID: <1472044720-29116-6-git-send-email-idryomov@gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34965 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754902AbcHXNew (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:34:52 -0400
Received: by mail-yw0-f196.google.com with SMTP id r9so807890ywg.2
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:34:23 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.18.56
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:18:56 -0700 (PDT)
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Douglas Fuller <dfuller@redhat.com>

Add an interface for the Ceph OSD lock.lock_info method and associated
data structures.

Based heavily on code by Mike Christie <michaelc@cs.wisc.edu>.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
[idryomov@gmail.com: refactor, misc fixes throughout]
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/cls_lock_client.h |  22 ++++++
 net/ceph/cls_lock_client.c           | 145 +++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+)

diff --git a/include/linux/ceph/cls_lock_client.h b/include/linux/ceph/cls_lock_client.h
index 4e4dffef22bb..84884d8d4710 100644
--- a/include/linux/ceph/cls_lock_client.h
+++ b/include/linux/ceph/cls_lock_client.h
@@ -9,6 +9,20 @@ enum ceph_cls_lock_type {
 	CEPH_CLS_LOCK_SHARED = 2,
 };
 
+struct ceph_locker_id {
+	struct ceph_entity_name name;	/* locker's client name */
+	char *cookie;			/* locker's cookie */
+};
+
+struct ceph_locker_info {
+	struct ceph_entity_addr addr;	/* locker's address */
+};
+
+struct ceph_locker {
+	struct ceph_locker_id id;
+	struct ceph_locker_info info;
+};
+
 int ceph_cls_lock(struct ceph_osd_client *osdc,
 		  struct ceph_object_id *oid,
 		  struct ceph_object_locator *oloc,
@@ -24,4 +38,12 @@ int ceph_cls_break_lock(struct ceph_osd_client *osdc,
 			char *lock_name, char *cookie,
 			struct ceph_entity_name *locker);
 
+void ceph_free_lockers(struct ceph_locker *lockers, u32 num_lockers);
+
+int ceph_cls_lock_info(struct ceph_osd_client *osdc,
+		       struct ceph_object_id *oid,
+		       struct ceph_object_locator *oloc,
+		       char *lock_name, u8 *type, char **tag,
+		       struct ceph_locker **lockers, u32 *num_lockers);
+
 #endif
diff --git a/net/ceph/cls_lock_client.c b/net/ceph/cls_lock_client.c
index 2a314537f958..50f040fdb2a9 100644
--- a/net/ceph/cls_lock_client.c
+++ b/net/ceph/cls_lock_client.c
@@ -178,3 +178,148 @@ int ceph_cls_break_lock(struct ceph_osd_client *osdc,
 	return ret;
 }
 EXPORT_SYMBOL(ceph_cls_break_lock);
+
+void ceph_free_lockers(struct ceph_locker *lockers, u32 num_lockers)
+{
+	int i;
+
+	for (i = 0; i < num_lockers; i++)
+		kfree(lockers[i].id.cookie);
+	kfree(lockers);
+}
+EXPORT_SYMBOL(ceph_free_lockers);
+
+static int decode_locker(void **p, void *end, struct ceph_locker *locker)
+{
+	u8 struct_v;
+	u32 len;
+	char *s;
+	int ret;
+
+	ret = ceph_start_decoding(p, end, 1, "locker_id_t", &struct_v, &len);
+	if (ret)
+		return ret;
+
+	ceph_decode_copy(p, &locker->id.name, sizeof(locker->id.name));
+	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
+	if (IS_ERR(s))
+		return PTR_ERR(s);
+
+	locker->id.cookie = s;
+
+	ret = ceph_start_decoding(p, end, 1, "locker_info_t", &struct_v, &len);
+	if (ret)
+		return ret;
+
+	*p += sizeof(struct ceph_timespec); /* skip expiration */
+	ceph_decode_copy(p, &locker->info.addr, sizeof(locker->info.addr));
+	ceph_decode_addr(&locker->info.addr);
+	len = ceph_decode_32(p);
+	*p += len; /* skip description */
+
+	dout("%s %s%llu cookie %s addr %s\n", __func__,
+	     ENTITY_NAME(locker->id.name), locker->id.cookie,
+	     ceph_pr_addr(&locker->info.addr.in_addr));
+	return 0;
+}
+
+static int decode_lockers(void **p, void *end, u8 *type, char **tag,
+			  struct ceph_locker **lockers, u32 *num_lockers)
+{
+	u8 struct_v;
+	u32 struct_len;
+	char *s;
+	int i;
+	int ret;
+
+	ret = ceph_start_decoding(p, end, 1, "cls_lock_get_info_reply",
+				  &struct_v, &struct_len);
+	if (ret)
+		return ret;
+
+	*num_lockers = ceph_decode_32(p);
+	*lockers = kcalloc(*num_lockers, sizeof(**lockers), GFP_NOIO);
+	if (!*lockers)
+		return -ENOMEM;
+
+	for (i = 0; i < *num_lockers; i++) {
+		ret = decode_locker(p, end, *lockers + i);
+		if (ret)
+			goto err_free_lockers;
+	}
+
+	*type = ceph_decode_8(p);
+	s = ceph_extract_encoded_string(p, end, NULL, GFP_NOIO);
+	if (IS_ERR(s)) {
+		ret = PTR_ERR(s);
+		goto err_free_lockers;
+	}
+
+	*tag = s;
+	return 0;
+
+err_free_lockers:
+	ceph_free_lockers(*lockers, *num_lockers);
+	return ret;
+}
+
+/*
+ * On success, the caller is responsible for:
+ *
+ *     kfree(tag);
+ *     ceph_free_lockers(lockers, num_lockers);
+ */
+int ceph_cls_lock_info(struct ceph_osd_client *osdc,
+		       struct ceph_object_id *oid,
+		       struct ceph_object_locator *oloc,
+		       char *lock_name, u8 *type, char **tag,
+		       struct ceph_locker **lockers, u32 *num_lockers)
+{
+	int get_info_op_buf_size;
+	int name_len = strlen(lock_name);
+	struct page *get_info_op_page, *reply_page;
+	size_t reply_len;
+	void *p, *end;
+	int ret;
+
+	get_info_op_buf_size = name_len + sizeof(__le32) +
+			       CEPH_ENCODING_START_BLK_LEN;
+	if (get_info_op_buf_size > PAGE_SIZE)
+		return -E2BIG;
+
+	get_info_op_page = alloc_page(GFP_NOIO);
+	if (!get_info_op_page)
+		return -ENOMEM;
+
+	reply_page = alloc_page(GFP_NOIO);
+	if (!reply_page) {
+		__free_page(get_info_op_page);
+		return -ENOMEM;
+	}
+
+	p = page_address(get_info_op_page);
+	end = p + get_info_op_buf_size;
+
+	/* encode cls_lock_get_info_op struct */
+	ceph_start_encoding(&p, 1, 1,
+			    get_info_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
+	ceph_encode_string(&p, end, lock_name, name_len);
+
+	dout("%s lock_name %s\n", __func__, lock_name);
+	ret = ceph_osdc_call(osdc, oid, oloc, "lock", "get_info",
+			     CEPH_OSD_FLAG_READ, get_info_op_page,
+			     get_info_op_buf_size, reply_page, &reply_len);
+
+	dout("%s: status %d\n", __func__, ret);
+	if (ret >= 0) {
+		p = page_address(reply_page);
+		end = p + reply_len;
+
+		ret = decode_lockers(&p, end, type, tag, lockers, num_lockers);
+	}
+
+	__free_page(get_info_op_page);
+	__free_page(reply_page);
+	return ret;
+}
+EXPORT_SYMBOL(ceph_cls_lock_info);
-- 
2.4.3

