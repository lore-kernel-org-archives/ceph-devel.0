From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 6/6] rgw/rgw_rest.cc: fix 4K memory leak
Date: Fri,  8 Feb 2013 17:25:03 +0100
Message-ID: <1360340703-7170-7-git-send-email-danny.al-gaaf@bisect.de>
References: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:39583 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946750Ab3BHQZG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:25:06 -0500
In-Reply-To: <1360340703-7170-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix 4K memory leak in case RGWClientIO::read() fails in
read_all_chunked_input().

Error from cppcheck was:
Checking src/rgw/rgw_rest.cc...
[src/rgw/rgw_rest.cc:688]: (error) Memory leak: data

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/rgw/rgw_rest.cc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/rgw/rgw_rest.cc b/src/rgw/rgw_rest.cc
index 72aab14..ab3927e 100644
--- a/src/rgw/rgw_rest.cc
+++ b/src/rgw/rgw_rest.cc
@@ -684,8 +684,10 @@ static int read_all_chunked_input(req_state *s, char **pdata, int *plen)
   int read_len = 0, len = 0;
   do {
     int r = s->cio->read(data + len, need_to_read, &read_len);
-    if (r < 0)
+    if (r < 0) {
+      free(data);
       return r;
+    }
 
     len += read_len;
 
-- 
1.8.1.2

