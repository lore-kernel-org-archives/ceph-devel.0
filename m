From: Alex Elder <elder@inktank.com>
Subject: [PATCH 04/16] libceph: define ceph_extract_encoded_string()
Date: Wed, 11 Jul 2012 09:01:11 -0500
Message-ID: <4FFD8727.7050106@inktank.com>
References: <4FFD847C.7070205@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:63502 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757819Ab2GKOBN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 10:01:13 -0400
Received: by yenl2 with SMTP id l2so1225622yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 07:01:13 -0700 (PDT)
In-Reply-To: <4FFD847C.7070205@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This adds a new utility routine which will return a dynamically-
allocated buffer containing a string that has been decoded from ceph
over-the-wire format.  It also returns the length of the string
if the address of a size variable is supplied to receive it.

For now, no gfp_flags parameter is defined (GFP_KERNEL is used) but
it could be easily be added if needed.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/decode.h |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index 7ead11fc..7759164 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -80,6 +80,35 @@ static inline size_t ceph_decode_string(void **p,
char *s, size_t size)
 }

 /*
+ * Allocate a buffer big enough to hold the wire-encoded string, and
+ * decode the string into it.  The resulting string will always be
+ * terminated with '\0'.  If successful, *p will be advanced
+ * past the decoded data.  Also, if lenp is not a null pointer, the
+ * length (not including the terminating '\0') will be recorded in
+ * it.  Note that a zero-length string is a valid return value.
+ *
+ * Returns a pointer to the newly-allocated string buffer, or a
+ * null pointer if memory could not be allocated for the result.
+ * Neither of the arguments is updated if NULL is returned.
+ */
+static inline char *ceph_extract_encoded_string(void **p, size_t *lenp)
+{
+	size_t len;
+	char *buf;
+
+	len = ceph_decode_string(p, NULL, 0);
+	buf = kmalloc(len + 1, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	(void) ceph_decode_string(p, buf, len + 1);
+	if (lenp)
+		*lenp = len;
+
+	return buf;
+}
+
+/*
  * bounds check input.
  */
 static inline int ceph_has_room(void **p, void *end, size_t n)
-- 
1.7.5.4

