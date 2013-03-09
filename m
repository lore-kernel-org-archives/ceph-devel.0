From: Alex Elder <elder@inktank.com>
Subject: [PATCH 7/8] libceph: simplify new message initialization
Date: Sat, 09 Mar 2013 09:15:18 -0600
Message-ID: <513B5206.4080704@inktank.com>
References: <513B5116.2020305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:64927 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758645Ab3CIPPV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 10:15:21 -0500
Received: by mail-ie0-f176.google.com with SMTP id k13so3175873iea.35
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 07:15:20 -0800 (PST)
In-Reply-To: <513B5116.2020305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Rather than explicitly initializing many fields to 0, NULL, or false
in a newly-allocated message, just use kzalloc() for allocating new
messages.  This will become a much more convenient way of doing
things anyway for upcoming patches that abstract the data field.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   38 ++++----------------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 2734d03..ce1669f 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2699,49 +2699,19 @@ struct ceph_msg *ceph_msg_new(int type, int
front_len, gfp_t flags,
 {
 	struct ceph_msg *m;

-	m = kmalloc(sizeof(*m), flags);
+	m = kzalloc(sizeof(*m), flags);
 	if (m == NULL)
 		goto out;
-	kref_init(&m->kref);
-
-	m->con = NULL;
-	INIT_LIST_HEAD(&m->list_head);

-	m->hdr.tid = 0;
 	m->hdr.type = cpu_to_le16(type);
 	m->hdr.priority = cpu_to_le16(CEPH_MSG_PRIO_DEFAULT);
-	m->hdr.version = 0;
 	m->hdr.front_len = cpu_to_le32(front_len);
-	m->hdr.middle_len = 0;
-	m->hdr.data_len = 0;
-	m->hdr.data_off = 0;
-	m->hdr.reserved = 0;
-	m->footer.front_crc = 0;
-	m->footer.middle_crc = 0;
-	m->footer.data_crc = 0;
-	m->footer.flags = 0;
-	m->front_max = front_len;
-	m->front_is_vmalloc = false;
-	m->more_to_follow = false;
-	m->ack_stamp = 0;
-	m->pool = NULL;

-	/* middle */
-	m->middle = NULL;
-
-	/* data */
-	m->page_count = 0;
-	m->page_alignment = 0;
-	m->pages = NULL;
-	m->pagelist = NULL;
-#ifdef	CONFIG_BLOCK
-	m->bio = NULL;
-	m->bio_iter = NULL;
-	m->bio_seg = 0;
-#endif	/* CONFIG_BLOCK */
-	m->trail = NULL;
+	INIT_LIST_HEAD(&m->list_head);
+	kref_init(&m->kref);

 	/* front */
+	m->front_max = front_len;
 	if (front_len) {
 		if (front_len > PAGE_CACHE_SIZE) {
 			m->front.iov_base = __vmalloc(front_len, flags,
-- 
1.7.9.5

