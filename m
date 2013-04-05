From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/6] libceph: record bio length
Date: Fri, 05 Apr 2013 17:25:26 -0500
Message-ID: <515F4F56.3000905@inktank.com>
References: <515F4F01.2000704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44602 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162881Ab3DEWZ3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Apr 2013 18:25:29 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so4969058ieb.15
        for <ceph-devel@vger.kernel.org>; Fri, 05 Apr 2013 15:25:28 -0700 (PDT)
In-Reply-To: <515F4F01.2000704@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

The bio is the only data item type that doesn't record its full
length.  Fix that.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/messenger.h |    5 ++++-
 net/ceph/messenger.c           |    1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index cdeebae..4fb870a 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -116,7 +116,10 @@ struct ceph_msg_data {
 	enum ceph_msg_data_type		type;
 	union {
 #ifdef CONFIG_BLOCK
-		struct bio		*bio;
+		struct {
+			struct bio	*bio;
+			size_t		bio_length;
+		};
 #endif /* CONFIG_BLOCK */
 		struct {
 			struct page	**pages;	/* NOT OWNER. */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index ae825e44..9571d03 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3030,6 +3030,7 @@ void ceph_msg_data_set_bio(struct ceph_msg *msg,
struct bio *bio,
 	data = ceph_msg_data_create(CEPH_MSG_DATA_BIO);
 	BUG_ON(!data);
 	data->bio = bio;
+	data->bio_length = length;

 	msg->data = data;
 	msg->data_length = length;
-- 
1.7.9.5

