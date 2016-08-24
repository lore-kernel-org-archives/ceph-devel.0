From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 02/16] libceph: support for CEPH_OSD_OP_LIST_WATCHERS
Date: Wed, 24 Aug 2016 15:18:26 +0200
Message-ID: <1472044720-29116-3-git-send-email-idryomov@gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33431 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754342AbcHXNg7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:36:59 -0400
Received: by mail-yb0-f194.google.com with SMTP id e31so460387ybi.0
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:36:59 -0700 (PDT)
Received: from dhcp-1-219.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e197sm5371294ywa.16.2016.08.24.06.18.53
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Aug 2016 06:18:54 -0700 (PDT)
In-Reply-To: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

From: Douglas Fuller <dfuller@redhat.com>

Add support for this Ceph OSD op, needed to support the RBD exclusive
lock feature.

Signed-off-by: Douglas Fuller <dfuller@redhat.com>
[idryomov@gmail.com: refactor, misc fixes throughout]
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/osd_client.h |  15 +++++-
 net/ceph/osd_client.c           | 117 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 858932304260..19821a191732 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -121,6 +121,9 @@ struct ceph_osd_req_op {
 			struct ceph_osd_data response_data;
 		} notify;
 		struct {
+			struct ceph_osd_data response_data;
+		} list_watchers;
+		struct {
 			u64 expected_object_size;
 			u64 expected_write_size;
 		} alloc_hint;
@@ -249,6 +252,12 @@ struct ceph_osd_linger_request {
 	size_t *preply_len;
 };
 
+struct ceph_watch_item {
+	struct ceph_entity_name name;
+	u64 cookie;
+	struct ceph_entity_addr addr;
+};
+
 struct ceph_osd_client {
 	struct ceph_client     *client;
 
@@ -346,7 +355,6 @@ extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
 					struct page **pages, u64 length,
 					u32 alignment, bool pages_from_pool,
 					bool own_pages);
-
 extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
 					unsigned int which, u16 opcode,
 					const char *class, const char *method);
@@ -434,5 +442,10 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 		     size_t *preply_len);
 int ceph_osdc_watch_check(struct ceph_osd_client *osdc,
 			  struct ceph_osd_linger_request *lreq);
+int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
+			    struct ceph_object_id *oid,
+			    struct ceph_object_locator *oloc,
+			    struct ceph_watch_item **watchers,
+			    u32 *num_watchers);
 #endif
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a97e7b506612..dd51ec8ce97f 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -338,6 +338,9 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
 		ceph_osd_data_release(&op->notify.request_data);
 		ceph_osd_data_release(&op->notify.response_data);
 		break;
+	case CEPH_OSD_OP_LIST_WATCHERS:
+		ceph_osd_data_release(&op->list_watchers.response_data);
+		break;
 	default:
 		break;
 	}
@@ -863,6 +866,8 @@ static u32 osd_req_encode_op(struct ceph_osd_op *dst,
 	case CEPH_OSD_OP_NOTIFY:
 		dst->notify.cookie = cpu_to_le64(src->notify.cookie);
 		break;
+	case CEPH_OSD_OP_LIST_WATCHERS:
+		break;
 	case CEPH_OSD_OP_SETALLOCHINT:
 		dst->alloc_hint.expected_object_size =
 		    cpu_to_le64(src->alloc_hint.expected_object_size);
@@ -1445,6 +1450,10 @@ static void setup_request_data(struct ceph_osd_request *req,
 			ceph_osdc_msg_data_add(req->r_reply,
 					       &op->extent.osd_data);
 			break;
+		case CEPH_OSD_OP_LIST_WATCHERS:
+			ceph_osdc_msg_data_add(req->r_reply,
+					       &op->list_watchers.response_data);
+			break;
 
 		/* both */
 		case CEPH_OSD_OP_CALL:
@@ -3891,6 +3900,114 @@ int ceph_osdc_watch_check(struct ceph_osd_client *osdc,
 	return ret;
 }
 
+static int decode_watcher(void **p, void *end, struct ceph_watch_item *item)
+{
+	u8 struct_v;
+	u32 struct_len;
+	int ret;
+
+	ret = ceph_start_decoding(p, end, 2, "watch_item_t",
+				  &struct_v, &struct_len);
+	if (ret)
+		return ret;
+
+	ceph_decode_copy(p, &item->name, sizeof(item->name));
+	item->cookie = ceph_decode_64(p);
+	*p += 4; /* skip timeout_seconds */
+	if (struct_v >= 2) {
+		ceph_decode_copy(p, &item->addr, sizeof(item->addr));
+		ceph_decode_addr(&item->addr);
+	}
+
+	dout("%s %s%llu cookie %llu addr %s\n", __func__,
+	     ENTITY_NAME(item->name), item->cookie,
+	     ceph_pr_addr(&item->addr.in_addr));
+	return 0;
+}
+
+static int decode_watchers(void **p, void *end,
+			   struct ceph_watch_item **watchers,
+			   u32 *num_watchers)
+{
+	u8 struct_v;
+	u32 struct_len;
+	int i;
+	int ret;
+
+	ret = ceph_start_decoding(p, end, 1, "obj_list_watch_response_t",
+				  &struct_v, &struct_len);
+	if (ret)
+		return ret;
+
+	*num_watchers = ceph_decode_32(p);
+	*watchers = kcalloc(*num_watchers, sizeof(**watchers), GFP_NOIO);
+	if (!*watchers)
+		return -ENOMEM;
+
+	for (i = 0; i < *num_watchers; i++) {
+		ret = decode_watcher(p, end, *watchers + i);
+		if (ret) {
+			kfree(*watchers);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * On success, the caller is responsible for:
+ *
+ *     kfree(watchers);
+ */
+int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
+			    struct ceph_object_id *oid,
+			    struct ceph_object_locator *oloc,
+			    struct ceph_watch_item **watchers,
+			    u32 *num_watchers)
+{
+	struct ceph_osd_request *req;
+	struct page **pages;
+	int ret;
+
+	req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
+	if (!req)
+		return -ENOMEM;
+
+	ceph_oid_copy(&req->r_base_oid, oid);
+	ceph_oloc_copy(&req->r_base_oloc, oloc);
+	req->r_flags = CEPH_OSD_FLAG_READ;
+
+	ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
+	if (ret)
+		goto out_put_req;
+
+	pages = ceph_alloc_page_vector(1, GFP_NOIO);
+	if (IS_ERR(pages)) {
+		ret = PTR_ERR(pages);
+		goto out_put_req;
+	}
+
+	osd_req_op_init(req, 0, CEPH_OSD_OP_LIST_WATCHERS, 0);
+	ceph_osd_data_pages_init(osd_req_op_data(req, 0, list_watchers,
+						 response_data),
+				 pages, PAGE_SIZE, 0, false, true);
+
+	ceph_osdc_start_request(osdc, req, false);
+	ret = ceph_osdc_wait_request(osdc, req);
+	if (ret >= 0) {
+		void *p = page_address(pages[0]);
+		void *const end = p + req->r_ops[0].outdata_len;
+
+		ret = decode_watchers(&p, end, watchers, num_watchers);
+	}
+
+out_put_req:
+	ceph_osdc_put_request(req);
+	return ret;
+}
+EXPORT_SYMBOL(ceph_osdc_list_watchers);
+
 /*
  * Call all pending notify callbacks - for use after a watch is
  * unregistered, to make sure no more callbacks for it will be invoked
-- 
2.4.3

