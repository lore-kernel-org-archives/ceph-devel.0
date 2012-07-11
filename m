From: Alex Elder <elder@inktank.com>
Subject: [PATCH v2 03/16] libceph: define ceph_decode_string()
Date: Wed, 11 Jul 2012 17:09:55 -0500
Message-ID: <4FFDF9B3.3080909@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD871B.6020704@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64713 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030301Ab2GKWJ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 18:09:57 -0400
Received: by yenl2 with SMTP id l2so1790353yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 15:09:56 -0700 (PDT)
In-Reply-To: <4FFD871B.6020704@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is no string decoding function defined in <decode.h>, so this
defines one.

This function is a little different from the others in that the
length of the encoded string is not known a priori.  So the
interface is defined a bit like snprintf(), where the value returned
indicates the space required--even if it's more than the space
allotted.

The function also avoids overrunning the end of the memory range
being converted.

Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: Made the function safe from overrunning the source memory

 include/linux/ceph/decode.h |   45
++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

Index: b/include/linux/ceph/decode.h
===================================================================
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -85,6 +85,51 @@ static inline int ceph_has_room(void **p
 	} while (0)

 /*
+ * Decode the wire-encoded string at *p into the buffer "s"
+ * provided, whose size is indicated by "size".  Note that "s" can
+ * be a null pointer if size is 0.  If it fits, the resulting string
+ * will always be terminated with '\0'; otherwise the buffer will
+ * be unchanged.
+ *
+ * Care is taken to ensure the result of decoding the string will
+ * not touch anything at or beyond the "end" address provided.  If
+ * it would, -ERANGE is returned.
+ *
+ * Otherwise, returns the length of the encoded string (which may be
+ * greater than or equal to the buffer size).  The return value does
+ * not include the terminating '\0'.
+ *
+ * If the the return value is not negative and is less than the size
+ * provided, *p will be advanced past the decoded data; otherwise it
+ * is unchanged.  This allows for a two call sequence to be used to
+ * allocate sufficient space for the string.
+ *
+ */
+static inline ssize_t ceph_decode_string(void **p, void *end,
+					char *s, size_t size)
+{
+	size_t len;
+	void *cp = *p;
+
+	ceph_decode_32_safe(&cp, end, len, bad);
+	if (!ceph_has_room(&cp, end, len))
+	    	goto bad;
+
+	if (size < len + 1)
+		return len;	/* Not enough room */
+
+	if (len)
+		memcpy(s, cp, len);
+	*(s + len) = '\0';
+
+	*p = (char *) *p + sizeof (u32) + len;
+
+    	return (ssize_t) len;
+bad:
+    	return (ssize_t) -ERANGE;
+}
+
+/*
  * struct ceph_timespec <-> struct timespec
  */
 static inline void ceph_decode_timespec(struct timespec *ts,

