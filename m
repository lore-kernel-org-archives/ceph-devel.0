From: Sage Weil <sage@newdream.net>
Subject: [PATCH 4/5] buf: implement generic virBufferEscape
Date: Thu, 15 Sep 2011 13:52:23 -0700
Message-ID: <1316119944-25201-5-git-send-email-sage@newdream.net>
References: <1316119944-25201-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49131 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934898Ab1IOUw2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2011 16:52:28 -0400
In-Reply-To: <1316119944-25201-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: libvir-list@redhat.com
Cc: ceph-devel@vger.kernel.org, Sage Weil <sage@newdream.net>

Implement a generic helper to escape a given set of characters with a
leading '\'.  Generalizes virBufferEscapeSexpr().

Signed-off-by: Sage Weil <sage@newdream.net>
---
 src/libvirt_private.syms |    1 +
 src/util/buf.c           |   33 ++++++++++++++++++++++++++-------
 src/util/buf.h           |    1 +
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/src/libvirt_private.syms b/src/libvirt_private.syms
index 830222b..d230fab 100644
--- a/src/libvirt_private.syms
+++ b/src/libvirt_private.syms
@@ -25,6 +25,7 @@ virBufferAddChar;
 virBufferAsprintf;
 virBufferContentAndReset;
 virBufferError;
+virBufferEscape;
 virBufferEscapeSexpr;
 virBufferEscapeString;
 virBufferFreeAndReset;
diff --git a/src/util/buf.c b/src/util/buf.c
index 5002486..7d0d2d3 100644
--- a/src/util/buf.c
+++ b/src/util/buf.c
@@ -383,9 +383,29 @@ virBufferEscapeSexpr(const virBufferPtr buf,
                      const char *format,
                      const char *str)
 {
+    virBufferEscape(buf, "\\\'", format, str);
+}
+
+/**
+ * virBufferEscape:
+ * @buf:  the buffer to dump
+ * @toescape: NULL-terminated list of characters to escape
+ * @format: a printf like format string but with only one %s parameter
+ * @str:  the string argument which need to be escaped
+ *
+ * Do a formatted print with a single string to a buffer.  Any characters
+ * in the provided list are escaped with a preceeding \.
+ */
+void
+virBufferEscape(const virBufferPtr buf,
+                const char *toescape,
+                const char *format,
+                const char *str)
+{
     int len;
     char *escaped, *out;
     const char *cur;
+    const char *p;
 
     if ((format == NULL) || (buf == NULL) || (str == NULL))
         return;
@@ -408,14 +428,13 @@ virBufferEscapeSexpr(const virBufferPtr buf,
     cur = str;
     out = escaped;
     while (*cur != 0) {
-        switch (*cur) {
-        case '\\':
-        case '\'':
-            *out++ = '\\';
-            /* fallthrough */
-        default:
-            *out++ = *cur;
+        for (p = toescape; *p; ++p) {
+            if (*cur == *p) {
+                *out++ = '\\';
+                break;
+            }
         }
+        *out++ = *cur;
         cur++;
     }
     *out = 0;
diff --git a/src/util/buf.h b/src/util/buf.h
index 06d01ba..e545ed9 100644
--- a/src/util/buf.h
+++ b/src/util/buf.h
@@ -50,6 +50,7 @@ void virBufferStrcat(const virBufferPtr buf, ...)
   ATTRIBUTE_SENTINEL;
 void virBufferEscapeString(const virBufferPtr buf, const char *format, const char *str);
 void virBufferEscapeSexpr(const virBufferPtr buf, const char *format, const char *str);
+void virBufferEscape(const virBufferPtr buf, const char *toescape, const char *format, const char *str);
 void virBufferURIEncodeString (const virBufferPtr buf, const char *str);
 
 # define virBufferAddLit(buf_, literal_string_) \
-- 
1.7.4.1

