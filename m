From: Alex Elder <elder@inktank.com>
Subject: [PATCH 05/16] rbd: define dup_token()
Date: Wed, 11 Jul 2012 09:01:23 -0500
Message-ID: <4FFD8733.9090305@inktank.com>
References: <4FFD847C.7070205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63502 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757702Ab2GKOB1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 10:01:27 -0400
Received: by mail-yx0-f174.google.com with SMTP id l2so1225622yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 07:01:27 -0700 (PDT)
In-Reply-To: <4FFD847C.7070205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define a new function dup_token(), to be used during argument
parsing for making dynamically-allocated copies of tokens being
parsed.

For now, no gfp_flags parameter is defined (GFP_KERNEL is used) but
it could be easily be added if needed.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 2ae3bb0..63c132f 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2281,6 +2281,42 @@ static inline size_t copy_token(const char **buf,
 }

 /*
+ * Finds the next token in *buf, dynamically allocates a buffer big
+ * enough to hold a copy of it, and copies the token into the new
+ * buffer.  The copy is guaranteed to be terminated with '\0'.  Note
+ * that a duplicate buffer is created even for a zero-length token.
+ *
+ * Returns a pointer to the newly-allocated duplicate, or a null
+ * pointer if memory for the duplicate was not available.  If
+ * the lenp argument is a non-null pointer, the length of the token
+ * (not including the '\0') is returned in *lenp.
+ *
+ * If successful, the *buf pointer will be updated to point beyond
+ * the end of the found token.
+ *
+ * Note:  For now, the memory is allocated using GFP_KERNEL.
+ */
+static inline char *dup_token(const char **buf, size_t *lenp)
+{
+	char *dup;
+	size_t len;
+
+	len = next_token(buf);
+	dup = kmalloc(len + 1, GFP_KERNEL);
+	if (!dup)
+		return NULL;
+
+	memcpy(dup, *buf, len);
+	*(dup + len) = '\0';
+	*buf += len;
+
+	if (lenp)
+		*lenp = len;
+
+	return dup;
+}
+
+/*
  * This fills in the pool_name, obj, obj_len, snap_name, obj_len,
  * rbd_dev, rbd_md_name, and name fields of the given rbd_dev, based
  * on the list of monitor addresses and other options provided via
-- 
1.7.5.4

