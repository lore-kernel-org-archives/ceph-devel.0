From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/8] libceph: define CEPH_MSG_MAX_MIDDLE_LEN
Date: Sat, 09 Mar 2013 09:13:28 -0600
Message-ID: <513B5198.7020101@inktank.com>
References: <513B5116.2020305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f176.google.com ([209.85.210.176]:33413 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757915Ab3CIPNb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 10:13:31 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so2343843iac.35
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 07:13:31 -0800 (PST)
In-Reply-To: <513B5116.2020305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is probably unnecessary but the code read as if it were wrong
in read_partial_message().

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/libceph.h |    1 +
 net/ceph/messenger.c         |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 29818fc..5493d7b 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -66,6 +66,7 @@ struct ceph_options {
 #define CEPH_OSD_IDLE_TTL_DEFAULT    60

 #define CEPH_MSG_MAX_FRONT_LEN	(16*1024*1024)
+#define CEPH_MSG_MAX_MIDDLE_LEN	(16*1024*1024)
 #define CEPH_MSG_MAX_DATA_LEN	(16*1024*1024)

 #define CEPH_AUTH_NAME_DEFAULT   "guest"
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index af0c35d..b8d0da5 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -1887,7 +1887,7 @@ static int read_partial_message(struct
ceph_connection *con)
 	if (front_len > CEPH_MSG_MAX_FRONT_LEN)
 		return -EIO;
 	middle_len = le32_to_cpu(con->in_hdr.middle_len);
-	if (middle_len > CEPH_MSG_MAX_DATA_LEN)
+	if (middle_len > CEPH_MSG_MAX_MIDDLE_LEN)
 		return -EIO;
 	data_len = le32_to_cpu(con->in_hdr.data_len);
 	if (data_len > CEPH_MSG_MAX_DATA_LEN)
-- 
1.7.9.5

