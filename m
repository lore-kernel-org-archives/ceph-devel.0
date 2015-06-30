From: Douglas Fuller <dfuller@redhat.com>
Subject: [PATCH RFC 5/6] cls_lock: add rados locking
Date: Tue, 30 Jun 2015 13:28:00 -0700
Message-ID: <d3d4e1af951e668b3a88619f5c92d94ee190657e.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46080 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbbF3U35 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Jun 2015 16:29:57 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 635C08E7A1
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 20:29:57 +0000 (UTC)
Received: from rex001.front.sepia.ceph.com ([10.17.112.1])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t5UKTrtm018417
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2015 16:29:57 -0400
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
In-Reply-To: <cover.1435695881.git.dfuller@redhat.com>
References: <cover.1435695881.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch adds support for rados lock, unlock and break lock.
This will be used to sync up scsi pr info manipulation and
TMF execution.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
[djf: broke out lock functions and moved to new source file]
[djf: changed interface to make use of osd_client utility functions]
[djf: snipped paragraph from commit message related to rbd code not moved]
Signed-off-by: Douglas Fuller <dfuller@redhat.com>
---
 include/linux/ceph/cls_lock.h |  12 +++
 net/ceph/Makefile             |   1 +
 net/ceph/cls_lock.c           | 173 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 include/linux/ceph/cls_lock.h
 create mode 100644 net/ceph/cls_lock.c

diff --git a/include/linux/ceph/cls_lock.h b/include/linux/ceph/cls_lock.h
new file mode 100644
index 0000000..2c24eb2
--- /dev/null
+++ b/include/linux/ceph/cls_lock.h
@@ -0,0 +1,12 @@
+#ifndef _NET_CEPH_RADOS_LOCK_H
+#define _NET_CEPH_RADOS_LOCK_H
+
+int ceph_cls_lock(struct ceph_osd_client *osdc, int poolid, char *obj_name,
+		  char *lock_name, u8 type, char *cookie, char *tag, char *desc,
+		  u8 flags);
+int ceph_cls_unlock(struct ceph_osd_client *osdc, int poolid, char *obj_name,
+		    char *lock_name, char *cookie);
+int ceph_cls_break_lock(struct ceph_osd_client *osdc, int poolid,
+			char *obj_name, char *lock_name, u8 entity_type,
+			u64 num, char *cookie);
+#endif
diff --git a/net/ceph/Makefile b/net/ceph/Makefile
index 958d9856..f76ee18 100644
--- a/net/ceph/Makefile
+++ b/net/ceph/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_CEPH_LIB) += libceph.o
 
 libceph-y := ceph_common.o messenger.o msgpool.o buffer.o pagelist.o \
 	mon_client.o \
+	cls_lock.o \
 	osd_client.o osdmap.o crush/crush.o crush/mapper.o crush/hash.o \
 	debugfs.o \
 	auth.o auth_none.o \
diff --git a/net/ceph/cls_lock.c b/net/ceph/cls_lock.c
new file mode 100644
index 0000000..4eff868
--- /dev/null
+++ b/net/ceph/cls_lock.c
@@ -0,0 +1,173 @@
+#include <linux/ceph/ceph_debug.h>
+
+#include <linux/types.h>
+#include <linux/slab.h>
+
+#include <linux/ceph/decode.h>
+#include <linux/ceph/messenger.h>
+#include <linux/ceph/msgpool.h>
+#include <linux/ceph/osd_client.h>
+
+/**
+ * ceph_cls_lock - grab rados lock for object
+ *  @osdc, @poolid, @obj_name: object to lock
+ *  @lock_name: the name of the lock
+ *  @type: lock type (RADOS_LOCK_EXCLUSIVE or RADOS_LOCK_SHARED)
+ *  @cookie: user-defined identifier for this instance of the lock
+ *  @tag: if RADOS_LOCK_SHARED, tag of the lock. NULL if non shared.
+ *  @desc: user-defined lock description
+ *  @flags: lock flags
+ */
+int ceph_cls_lock(struct ceph_osd_client *osdc, int poolid, char *obj_name,
+		  char *lock_name, u8 type, char *cookie, char *tag, char *desc,
+		  u8 flags)
+{
+	int lock_op_buf_size;
+	int name_len = strlen(lock_name);
+	int cookie_len = strlen(cookie);
+	int tag_len = strlen(tag);
+	int desc_len = strlen(desc);
+	void *p, *end;
+	struct page *lock_op_page;
+	struct timespec mtime;
+	int ret;
+
+	lock_op_buf_size = name_len + sizeof(__le32) +
+				cookie_len + sizeof(__le32) +
+				tag_len + sizeof(__le32) +
+				desc_len + sizeof(__le32) +
+				sizeof(mtime) +
+				/* flag and type */
+				sizeof(u8) + sizeof(u8) +
+				CEPH_ENCODING_START_BLK_LEN;
+	BUG_ON(lock_op_buf_size > PAGE_SIZE);
+	lock_op_page = alloc_page(GFP_NOIO);
+	if (!lock_op_page)
+		return -ENOMEM;
+
+	p = page_address(lock_op_page);
+	end = p + lock_op_buf_size;
+
+	ceph_start_encoding(&p, 1, 1,
+			    lock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
+	/* encode cls_lock_lock_op struct */
+	ceph_encode_string(&p, end, lock_name, name_len);
+	ceph_encode_8(&p, type);
+	ceph_encode_string(&p, end, cookie, cookie_len);
+	ceph_encode_string(&p, end, tag, tag_len);
+	ceph_encode_string(&p, end, desc, desc_len);
+	/* only support infinite duration */
+	memset(&mtime, 0, sizeof(mtime));
+	ceph_encode_timespec(p, &mtime);
+	p += sizeof(struct ceph_timespec);
+	ceph_encode_8(&p, flags);
+
+	dout("%s: %s %d %s %s %s %d\n", __func__,
+	     lock_name, type, cookie, tag, desc, flags);
+
+	ret = ceph_osd_op_cls_call(osdc, poolid, obj_name, "lock", "lock",
+				   CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
+				   &lock_op_page, lock_op_buf_size,
+				   NULL, 0);
+	dout("%s: status %d\n", __func__, ret);
+	__free_page(lock_op_page);
+	return ret;
+}
+EXPORT_SYMBOL(ceph_cls_lock);
+
+/**
+ * ceph_cls_unlock - release rados lock for object
+ *  @osdc, @poolid, @obj_name: object to lock
+ *  @lock_name: the name of the lock
+ *  @cookie: user-defined identifier for this instance of the lock
+ */
+int ceph_cls_unlock(struct ceph_osd_client *osdc, int poolid, char *obj_name,
+		    char *lock_name, char *cookie)
+{
+	int unlock_op_buf_size;
+	int name_len = strlen(lock_name);
+	int cookie_len = strlen(cookie);
+	void *p, *end;
+	struct page *unlock_op_page;
+	int ret;
+
+	unlock_op_buf_size = name_len + sizeof(__le32) +
+			     cookie_len + sizeof(__le32) +
+			     CEPH_ENCODING_START_BLK_LEN;
+	BUG_ON(unlock_op_buf_size > PAGE_SIZE);
+	unlock_op_page = alloc_page(GFP_NOIO);
+	if (!unlock_op_page)
+		return -ENOMEM;
+
+	p = page_address(unlock_op_page);
+	end = p + unlock_op_buf_size;
+
+	ceph_start_encoding(&p, 1, 1,
+			    unlock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
+	/* encode cls_lock_unlock_op struct */
+	ceph_encode_string(&p, end, lock_name, name_len);
+	ceph_encode_string(&p, end, cookie, cookie_len);
+
+	dout("%s: %s %s\n", __func__, lock_name, cookie);
+	ret = ceph_osd_op_cls_call(osdc, poolid, obj_name, "lock", "unlock",
+				   CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
+				   &unlock_op_page, unlock_op_buf_size,
+				   NULL, 0);
+
+	dout("%s: status %d\n", __func__, ret);
+	__free_page(unlock_op_page);
+	return ret;
+}
+EXPORT_SYMBOL(ceph_cls_unlock);
+
+/**
+ * ceph_cls_break_lock - release rados lock for object for specified client
+ *  @osdc, @poolid, @obj_name: object to lock
+ *  @lock_name: the name of the lock
+ *  @entity_type: ceph entity type (CEPH_ENTITY_TYPE_*)
+ *  @num: ceph entity id
+ *  @cookie: user-defined identifier for this instance of the lock
+ */
+int ceph_cls_break_lock(struct ceph_osd_client *osdc, int poolid,
+			char *obj_name, char *lock_name, u8 entity_type,
+			u64 num, char *cookie)
+{
+	int break_lock_op_buf_size;
+	int name_len = strlen(lock_name);
+	int cookie_len = strlen(cookie);
+	struct page *break_lock_op_page;
+	void *p, *end;
+	int ret;
+
+	break_lock_op_buf_size = name_len + sizeof(__le32) +
+				 cookie_len + sizeof(__le32) +
+				 sizeof(u8) + sizeof(__le64) +
+				 CEPH_ENCODING_START_BLK_LEN;
+	BUG_ON(break_lock_op_buf_size > PAGE_SIZE);
+	break_lock_op_page = alloc_page(GFP_NOIO);
+	if (!break_lock_op_page)
+		return -ENOMEM;
+
+	p = page_address(break_lock_op_page);
+	end = p + break_lock_op_buf_size;
+
+	ceph_start_encoding(&p, 1, 1,
+			break_lock_op_buf_size - CEPH_ENCODING_START_BLK_LEN);
+	/* encode cls_lock_break_op struct */
+	ceph_encode_string(&p, end, lock_name, name_len);
+	ceph_encode_8(&p, entity_type);
+	ceph_encode_64(&p, num);
+	ceph_encode_string(&p, end, cookie, cookie_len);
+
+	dout("%s: lock %s entity_type %hu id %llu cookie %s\n",
+	     __func__, lock_name, entity_type, num, cookie);
+
+	ret = ceph_osd_op_cls_call(osdc, poolid, obj_name, "lock", "break_lock",
+				   CEPH_OSD_FLAG_WRITE | CEPH_OSD_FLAG_ONDISK,
+				   &break_lock_op_page, break_lock_op_buf_size,
+				   NULL, 0);
+	dout("%s: status %d\n", __func__, ret);
+	__free_page(break_lock_op_page);
+	return ret;
+}
+EXPORT_SYMBOL(ceph_cls_break_lock);
-- 
1.9.3

