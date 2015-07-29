From: mchristi@redhat.com
Subject: [PATCH 01/18] libceph: add scatterlist messenger data type
Date: Wed, 29 Jul 2015 04:23:38 -0500
Message-ID: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58004 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751643AbbG2JX5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 05:23:57 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

LIO uses scatterlist for its page/data management. This patch
adds a scatterlist messenger data type, so LIO can pass its sg
down directly to rbd.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 include/linux/ceph/messenger.h  | 13 ++++++
 include/linux/ceph/osd_client.h | 12 +++++-
 net/ceph/messenger.c            | 96 +++++++++++++++++++++++++++++++++++++++++
 net/ceph/osd_client.c           | 26 +++++++++++
 4 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 3775327..bc1bde8 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -79,6 +79,7 @@ enum ceph_msg_data_type {
 #ifdef CONFIG_BLOCK
 	CEPH_MSG_DATA_BIO,	/* data source/destination is a bio list */
 #endif /* CONFIG_BLOCK */
+	CEPH_MSG_DATA_SG,	/* data source/destination is a scatterlist */
 };
 
 static __inline__ bool ceph_msg_data_type_valid(enum ceph_msg_data_type type)
@@ -90,6 +91,7 @@ static __inline__ bool ceph_msg_data_type_valid(enum ceph_msg_data_type type)
 #ifdef CONFIG_BLOCK
 	case CEPH_MSG_DATA_BIO:
 #endif /* CONFIG_BLOCK */
+	case CEPH_MSG_DATA_SG:
 		return true;
 	default:
 		return false;
@@ -112,6 +114,11 @@ struct ceph_msg_data {
 			unsigned int	alignment;	/* first page */
 		};
 		struct ceph_pagelist	*pagelist;
+		struct {
+			struct scatterlist *sgl;
+			unsigned int	sgl_init_offset;
+			u64		sgl_length;
+		};
 	};
 };
 
@@ -139,6 +146,10 @@ struct ceph_msg_data_cursor {
 			struct page	*page;		/* page from list */
 			size_t		offset;		/* bytes from list */
 		};
+		struct {
+			struct scatterlist	*sg;		/* curr sg */
+			unsigned int		sg_consumed;
+		};
 	};
 };
 
@@ -294,6 +305,8 @@ extern void ceph_msg_data_add_pagelist(struct ceph_msg *msg,
 extern void ceph_msg_data_add_bio(struct ceph_msg *msg, struct bio *bio,
 				size_t length);
 #endif /* CONFIG_BLOCK */
+extern void ceph_msg_data_add_sg(struct ceph_msg *msg, struct scatterlist *sgl,
+				 unsigned int sgl_init_offset, u64 length);
 
 extern struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 				     bool can_fail);
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 0890167..2152f06 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -52,6 +52,7 @@ enum ceph_osd_data_type {
 #ifdef CONFIG_BLOCK
 	CEPH_OSD_DATA_TYPE_BIO,
 #endif /* CONFIG_BLOCK */
+	CEPH_OSD_DATA_TYPE_SG,
 };
 
 struct ceph_osd_data {
@@ -70,6 +71,11 @@ struct ceph_osd_data {
 			struct bio	*bio;		/* list of bios */
 			size_t		bio_length;	/* total in list */
 		};
+		struct {
+			struct scatterlist *sgl;
+			size_t		sgl_length;
+			unsigned int	sgl_init_offset;
+		};
 #endif /* CONFIG_BLOCK */
 	};
 };
@@ -313,7 +319,11 @@ extern void osd_req_op_extent_osd_data_bio(struct ceph_osd_request *,
 					unsigned int which,
 					struct bio *bio, size_t bio_length);
 #endif /* CONFIG_BLOCK */
-
+extern void osd_req_op_extent_osd_data_sg(struct ceph_osd_request *,
+					unsigned int which,
+					struct scatterlist *sgl,
+					unsigned int init_sg_offset,
+					u64 length);
 extern void osd_req_op_cls_request_data_pagelist(struct ceph_osd_request *,
 					unsigned int which,
 					struct ceph_pagelist *pagelist);
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index e3be1d2..08d39fb 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -893,6 +893,75 @@ static bool ceph_msg_data_bio_advance(struct ceph_msg_data_cursor *cursor,
 #endif /* CONFIG_BLOCK */
 
 /*
+ * For a sg data item, a piece is whatever remains of the next
+ * entry in the current sg entry, or the first entry in the next
+ * sg in the list.
+ */
+static void ceph_msg_data_sg_cursor_init(struct ceph_msg_data_cursor *cursor,
+					 size_t length)
+{
+	struct ceph_msg_data *data = cursor->data;
+	struct scatterlist *sg;
+
+	BUG_ON(data->type != CEPH_MSG_DATA_SG);
+
+	sg = data->sgl;
+	BUG_ON(!sg);
+
+	cursor->resid = min_t(u64, length, data->sgl_length);
+	cursor->sg = sg;
+	cursor->sg_consumed = data->sgl_init_offset;
+	cursor->last_piece = cursor->resid <= sg->length;
+}
+
+static struct page *ceph_msg_data_sg_next(struct ceph_msg_data_cursor *cursor,
+					  size_t *page_offset, size_t *length)
+{
+	struct ceph_msg_data *data = cursor->data;
+	struct scatterlist *sg;
+
+	BUG_ON(data->type != CEPH_MSG_DATA_SG);
+
+	sg = cursor->sg;
+	BUG_ON(!sg);
+
+	*page_offset = sg->offset + cursor->sg_consumed;
+
+	if (cursor->last_piece)
+		*length = cursor->resid;
+	else
+		*length = sg->length - cursor->sg_consumed;
+
+	/* currently support non clustered sg pages */
+	return sg_page(sg);
+}
+
+static bool ceph_msg_data_sg_advance(struct ceph_msg_data_cursor *cursor,
+				     size_t bytes)
+{
+	BUG_ON(cursor->data->type != CEPH_MSG_DATA_SG);
+
+	/* Advance the cursor offset */
+	BUG_ON(cursor->resid < bytes);
+	cursor->resid -= bytes;
+	cursor->sg_consumed += bytes;
+
+	if (!bytes || cursor->sg_consumed < cursor->sg->length)
+		return false;	/* more bytes to process in the current page */
+
+	if (!cursor->resid)
+		return false;	/* no more data */
+
+	/* For WRITE_SAME we have a single sg that is written over and over */
+	if (sg_next(cursor->sg))
+		cursor->sg = sg_next(cursor->sg);
+	cursor->sg_consumed = 0;
+
+	cursor->last_piece = cursor->resid <= cursor->sg->length;
+	return true;
+}
+
+/*
  * For a page array, a piece comes from the first page in the array
  * that has not already been fully consumed.
  */
@@ -1075,6 +1144,9 @@ static void __ceph_msg_data_cursor_init(struct ceph_msg_data_cursor *cursor)
 		ceph_msg_data_bio_cursor_init(cursor, length);
 		break;
 #endif /* CONFIG_BLOCK */
+	case CEPH_MSG_DATA_SG:
+		ceph_msg_data_sg_cursor_init(cursor, length);
+		break;
 	case CEPH_MSG_DATA_NONE:
 	default:
 		/* BUG(); */
@@ -1123,6 +1195,9 @@ static struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
 		page = ceph_msg_data_bio_next(cursor, page_offset, length);
 		break;
 #endif /* CONFIG_BLOCK */
+	case CEPH_MSG_DATA_SG:
+		page = ceph_msg_data_sg_next(cursor, page_offset, length);
+		break;
 	case CEPH_MSG_DATA_NONE:
 	default:
 		page = NULL;
@@ -1159,6 +1234,9 @@ static bool ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor,
 		new_piece = ceph_msg_data_bio_advance(cursor, bytes);
 		break;
 #endif /* CONFIG_BLOCK */
+	case CEPH_MSG_DATA_SG:
+		new_piece = ceph_msg_data_sg_advance(cursor, bytes);
+		break;
 	case CEPH_MSG_DATA_NONE:
 	default:
 		BUG();
@@ -3182,6 +3260,24 @@ void ceph_msg_data_add_bio(struct ceph_msg *msg, struct bio *bio,
 EXPORT_SYMBOL(ceph_msg_data_add_bio);
 #endif	/* CONFIG_BLOCK */
 
+void ceph_msg_data_add_sg(struct ceph_msg *msg, struct scatterlist *sgl,
+			  unsigned int sgl_init_offset, u64 length)
+{
+	struct ceph_msg_data *data;
+
+	BUG_ON(!sgl);
+
+	data = ceph_msg_data_create(CEPH_MSG_DATA_SG);
+	BUG_ON(!data);
+	data->sgl = sgl;
+	data->sgl_length = length;
+	data->sgl_init_offset = sgl_init_offset;
+
+	list_add_tail(&data->links, &msg->data);
+	msg->data_length += length;
+}
+EXPORT_SYMBOL(ceph_msg_data_add_sg);
+
 /*
  * construct a new message with given type, size
  * the new msg has a ref count of 1.
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index f8178b7..fd0a52e 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -128,6 +128,16 @@ static void ceph_osd_data_bio_init(struct ceph_osd_data *osd_data,
 }
 #endif /* CONFIG_BLOCK */
 
+static void ceph_osd_data_sg_init(struct ceph_osd_data *osd_data,
+				  struct scatterlist *sgl,
+				  unsigned int init_sg_offset, u64 length)
+{
+	osd_data->type = CEPH_OSD_DATA_TYPE_SG;
+	osd_data->sgl = sgl;
+	osd_data->sgl_length = length;
+	osd_data->sgl_init_offset = init_sg_offset;
+}
+
 #define osd_req_op_data(oreq, whch, typ, fld)	\
 	({						\
 		BUG_ON(whch >= (oreq)->r_num_ops);	\
@@ -206,6 +216,17 @@ void osd_req_op_extent_osd_data_bio(struct ceph_osd_request *osd_req,
 EXPORT_SYMBOL(osd_req_op_extent_osd_data_bio);
 #endif /* CONFIG_BLOCK */
 
+void osd_req_op_extent_osd_data_sg(struct ceph_osd_request *osd_req,
+			unsigned int which, struct scatterlist *sgl,
+			unsigned int init_sg_offset, u64 length)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_data(osd_req, which, extent, osd_data);
+	ceph_osd_data_sg_init(osd_data, sgl, init_sg_offset, length);
+}
+EXPORT_SYMBOL(osd_req_op_extent_osd_data_sg);
+
 static void osd_req_op_cls_request_info_pagelist(
 			struct ceph_osd_request *osd_req,
 			unsigned int which, struct ceph_pagelist *pagelist)
@@ -317,6 +338,8 @@ static u64 ceph_osd_data_length(struct ceph_osd_data *osd_data)
 	case CEPH_OSD_DATA_TYPE_BIO:
 		return (u64)osd_data->bio_length;
 #endif /* CONFIG_BLOCK */
+	case CEPH_OSD_DATA_TYPE_SG:
+		return osd_data->sgl_length;
 	default:
 		WARN(true, "unrecognized data type %d\n", (int)osd_data->type);
 		return 0;
@@ -727,6 +750,9 @@ static void ceph_osdc_msg_data_add(struct ceph_msg *msg,
 	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_BIO) {
 		ceph_msg_data_add_bio(msg, osd_data->bio, length);
 #endif
+	} else if (osd_data->type == CEPH_OSD_DATA_TYPE_SG) {
+		ceph_msg_data_add_sg(msg, osd_data->sgl,
+				     osd_data->sgl_init_offset, length);
 	} else {
 		BUG_ON(osd_data->type != CEPH_OSD_DATA_TYPE_NONE);
 	}
-- 
1.8.3.1

