From: Alex Elder <elder@inktank.com>
Subject: [PATCH 6/6] libceph: define and use ceph_crc32c_page()
Date: Sat, 09 Mar 2013 10:43:58 -0600
Message-ID: <513B66CE.2000609@inktank.com>
References: <513B661F.4050203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:42090 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932846Ab3CIQoB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:44:01 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so2384706iak.24
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:44:00 -0800 (PST)
In-Reply-To: <513B661F.4050203@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Factor out a common block of code that updates a CRC calculation
over a range of data in a page.

This and the preceding patches are related to:
    http://tracker.ceph.com/issues/4403

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |   47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 7df7941..e677fd3 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1085,6 +1085,19 @@ static void in_msg_pos_next(struct
ceph_connection *con, size_t len,
 #endif /* CONFIG_BLOCK */
 }

+static u32 ceph_crc32c_page(u32 crc, struct page *page,
+				unsigned int page_offset,
+				unsigned int length)
+{
+	char *kaddr;
+
+	kaddr = kmap(page);
+	BUG_ON(kaddr == NULL);
+	crc = crc32c(crc, kaddr + page_offset, length);
+	kunmap(page);
+
+	return crc;
+}
 /*
  * Write as much message data payload as we can.  If we finish, queue
  * up the footer.
@@ -1153,15 +1166,9 @@ static int write_partial_message_data(struct
ceph_connection *con)

 		page_offset = msg_pos->page_pos + bio_offset;
 		if (do_datacrc && !msg_pos->did_page_crc) {
-			void *base;
 			u32 crc = le32_to_cpu(msg->footer.data_crc);
-			char *kaddr;

-			kaddr = kmap(page);
-			BUG_ON(kaddr == NULL);
-			base = kaddr + page_offset;
-			crc = crc32c(crc, base, length);
-			kunmap(page);
+			crc = ceph_crc32c_page(crc, page, page_offset, length);
 			msg->footer.data_crc = cpu_to_le32(crc);
 			msg_pos->did_page_crc = true;
 		}
@@ -1843,16 +1850,9 @@ static int read_partial_message_pages(struct
ceph_connection *con,
 	if (ret <= 0)
 		return ret;

-	if (do_datacrc) {
-		void *kaddr;
-		void *base;
-
-		kaddr = kmap(page);
-		BUG_ON(!kaddr);
-		base = kaddr + page_offset;
-		con->in_data_crc = crc32c(con->in_data_crc, base, ret);
-		kunmap(page);
-	}
+	if (do_datacrc)
+		con->in_data_crc = ceph_crc32c_page(con->in_data_crc, page,
+							page_offset, ret);

 	in_msg_pos_next(con, length, ret);

@@ -1886,16 +1886,9 @@ static int read_partial_message_bio(struct
ceph_connection *con,
 	if (ret <= 0)
 		return ret;

-	if (do_datacrc) {
-		void *kaddr;
-		void *base;
-
-		kaddr = kmap(page);
-		BUG_ON(!kaddr);
-		base = kaddr + page_offset;
-		con->in_data_crc = crc32c(con->in_data_crc, base, ret);
-		kunmap(page);
-	}
+	if (do_datacrc)
+		con->in_data_crc = ceph_crc32c_page(con->in_data_crc, page,
+							page_offset, ret);

 	in_msg_pos_next(con, length, ret);

-- 
1.7.9.5

