From: Alex Elder <elder@inktank.com>
Subject: [PATCH v2 04/16] libceph: define ceph_extract_encoded_string()
Date: Wed, 11 Jul 2012 17:10:00 -0500
Message-ID: <4FFDF9B8.5040401@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8727.7050106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:56851 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030301Ab2GKWKC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 18:10:02 -0400
Received: by gglu4 with SMTP id u4so1797248ggl.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 15:10:02 -0700 (PDT)
In-Reply-To: <4FFD8727.7050106@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This adds a new utility routine which will return a dynamically-
allocated buffer containing a string that has been decoded from ceph
over-the-wire format.  It also returns the length of the string
if the address of a size variable is supplied to receive it.

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: Made the function safe from overrunning the source memory, and
    and added a gfp argument to pass to kmalloc()

 include/linux/ceph/decode.h |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

Index: b/include/linux/ceph/decode.h
===================================================================
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -130,6 +130,44 @@ bad:
 }

 /*
+ * Allocate a buffer big enough to hold the wire-encoded string, and
+ * decode the string into it.  The resulting string will always be
+ * terminated with '\0'.  If successful, *p will be advanced
+ * past the decoded data.  Also, if lenp is not a null pointer, the
+ * length (not including the terminating '\0') will be recorded in
+ * it.  Note that a zero-length string is a valid return value.
+ *
+ * Returns a pointer to the newly-allocated string buffer, or a null
+ * pointer if an error occurs.  Neither "p" nor "end" will be updated
+ * if NULL is returned.
+ *
+ * There are two possible failures:
+ *   - memory could not be allocated for the result
+ *   - converting the string would require accessing memory at or
+ *     beyond the "end" pointer provided
+ */
+static inline char *ceph_extract_encoded_string(void **p, void *end,
+						size_t *lenp, gfp_t gfp)
+{
+	ssize_t len;
+	char *buf;
+
+	len = ceph_decode_string(p, end, NULL, 0);
+	if (len < 0)
+	    	return NULL;
+
+	buf = kmalloc(len + 1, gfp);
+	if (!buf)
+		return NULL;
+
+	(void) ceph_decode_string(p, end, buf, len + 1);
+	if (lenp)
+		*lenp = (size_t) len;
+
+	return buf;
+}
+
+/*
  * struct ceph_timespec <-> struct timespec
  */
 static inline void ceph_decode_timespec(struct timespec *ts,

