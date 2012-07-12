From: Alex Elder <elder@inktank.com>
Subject: [PATCH v4 04/16] libceph: define ceph_extract_encoded_string()
Date: Thu, 12 Jul 2012 17:47:36 -0500
Message-ID: <4FFF5408.5010607@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8727.7050106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gg0-f174.google.com ([209.85.161.174]:49685 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162395Ab2GLWri (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 18:47:38 -0400
Received: by mail-gg0-f174.google.com with SMTP id u4so3017125ggl.19
        for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 15:47:38 -0700 (PDT)
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
v4: Last final version.  Caller can now distinguish between the two
    error conditions.
v3: Final version.  Sage convinced me that there was no need for
    ceph_decode_string() other than its use in this function, so
    now this implements what that function had been doing directly.
v2: Made the function safe from overrunning the source memory, and
    and added a gfp argument to pass to kmalloc().

 include/linux/ceph/decode.h |   47
+++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index bcbd66c..4bbf2db 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -1,6 +1,7 @@
 #ifndef __CEPH_DECODE_H
 #define __CEPH_DECODE_H

+#include <linux/err.h>
 #include <linux/bug.h>
 #include <linux/time.h>
 #include <asm/unaligned.h>
@@ -85,6 +86,52 @@ static inline int ceph_has_room(void **p, void *end,
size_t n)
 	} while (0)

 /*
+ * Allocate a buffer big enough to hold the wire-encoded string, and
+ * decode the string into it.  The resulting string will always be
+ * terminated with '\0'.  If successful, *p will be advanced
+ * past the decoded data.  Also, if lenp is not a null pointer, the
+ * length (not including the terminating '\0') will be recorded in
+ * *lenp.  Note that a zero-length string is a valid return value.
+ *
+ * Returns a pointer to the newly-allocated string buffer, or a
+ * pointer-coded errno if an error occurs.  Neither *p nor *lenp
+ * will have been updated if an error is returned.
+ *
+ * There are two possible failures:
+ *   - converting the string would require accessing memory at or
+ *     beyond the "end" pointer provided (-E
+ *   - memory could not be allocated for the result
+ */
+static inline char *ceph_extract_encoded_string(void **p, void *end,
+						size_t *lenp, gfp_t gfp)
+{
+	u32 len;
+	void *sp = *p;
+	char *buf;
+
+	ceph_decode_32_safe(&sp, end, len, bad);
+	if (!ceph_has_room(&sp, end, len))
+		goto bad;
+
+	buf = kmalloc(len + 1, gfp);
+	if (!buf)
+		return ERR_PTR(-ENOMEM);
+
+	if (len)
+		memcpy(buf, sp, len);
+	buf[len] = '\0';
+
+	*p = (char *) *p + sizeof (u32) + len;
+	if (lenp)
+		*lenp = (size_t) len;
+
+	return buf;
+
+bad:
+	return ERR_PTR(-ERANGE);
+}
+
+/*
  * struct ceph_timespec <-> struct timespec
  */
 static inline void ceph_decode_timespec(struct timespec *ts,
-- 
1.7.5.4

