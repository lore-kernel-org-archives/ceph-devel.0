From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 3/6] rgw/rgw_xml.cc: fix realloc memory leak in error case
Date: Fri,  8 Feb 2013 17:25:00 +0100
Message-ID: <1360340703-7170-4-git-send-email-danny.al-gaaf@bisect.de>
References: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:39602 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946758Ab3BHQZL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:25:11 -0500
In-Reply-To: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix error from cppcheck:

[src/rgw/rgw_xml.cc:212]: (error) Common realloc mistake: 'buf'
  nulled but not freed upon failure

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/rgw/rgw_xml.cc | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/rgw/rgw_xml.cc b/src/rgw/rgw_xml.cc
index 4347b06..eee69d0 100644
--- a/src/rgw/rgw_xml.cc
+++ b/src/rgw/rgw_xml.cc
@@ -209,9 +209,16 @@ bool RGWXMLParser::init()
 bool RGWXMLParser::parse(const char *_buf, int len, int done)
 {
   int pos = buf_len;
-  buf = (char *)realloc(buf, buf_len + len);
-  if (!buf)
+  char *tmp_buf;
+  tmp_buf = (char *)realloc(buf, buf_len + len);
+  if (tmp_buf == NULL){
+    free(buf);
+    buf = NULL;
     return false;
+  } else {
+    buf = tmp_buf;
+  }
+
   memcpy(&buf[buf_len], _buf, len);
   buf_len += len;
 
-- 
1.8.1.2

