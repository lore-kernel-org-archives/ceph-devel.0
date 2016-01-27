From: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 6/6] net: ceph: messenger: add braces to all arms of conditional statement
Date: Wed, 27 Jan 2016 02:43:39 +0200
Message-ID: <d725aa09232a92e16e86cf6c320a602adfaef87c.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35208 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbcAZWnz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 17:43:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so9548wmz.2
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jan 2016 14:43:55 -0800 (PST)
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org, Ioana Ciornei <ciorneiioana@gmail.com>

This patch adds curly braces to all arms of the conditional statement in
order to follow the linux kernel coding style. Warnings found using
checkpatch.pl.

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---
 net/ceph/messenger.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 8f1582e..eb71add 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1313,8 +1313,10 @@ static void prepare_write_message(struct ceph_connection *con)
 			     m->middle->vec.iov_base,
 			     m->middle->vec.iov_len);
 		con->out_msg->footer.middle_crc = cpu_to_le32(crc);
-	} else
+	} else {
 		con->out_msg->footer.middle_crc = 0;
+	}
+
 	dout("%s front_crc %u middle_crc %u\n", __func__,
 	     le32_to_cpu(con->out_msg->footer.front_crc),
 	     le32_to_cpu(con->out_msg->footer.middle_crc));
@@ -1854,11 +1856,11 @@ static int ceph_dns_resolve_name(const char *name, size_t namelen,
 	delim_p = memchr(name, delim, namelen);
 	colon_p = memchr(name, ':', namelen);
 
-	if (delim_p && colon_p)
+	if (delim_p && colon_p) {
 		end = delim_p < colon_p ? delim_p : colon_p;
-	else if (!delim_p && colon_p)
+	} else if (!delim_p && colon_p) {
 		end = colon_p;
-	else {
+	} else {
 		end = delim_p;
 		if (!end) /* case: hostname:/ */
 			end = name + namelen;
-- 
2.6.4

