From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH v2 5/6] SyntheticClient.cc: fix some memory leaks in the error handling
Date: Fri,  8 Feb 2013 18:52:20 +0100
Message-ID: <1360345940-8481-1-git-send-email-danny.al-gaaf@bisect.de>
References: <51153A4F.8030107@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:44655 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1946881Ab3BHRw1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 12:52:27 -0500
In-Reply-To: <51153A4F.8030107@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

Fix some memory leaks in case of error handling due to failed
client->open() calls.

Error from cppcheck was:
[src/client/SyntheticClient.cc:1980]: (error) Memory leak: buf
[src/client/SyntheticClient.cc:2040]: (error) Memory leak: buf
[src/client/SyntheticClient.cc:2090]: (error) Memory leak: buf

---
v2: - fix order in two cases 

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/client/SyntheticClient.cc | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/client/SyntheticClient.cc b/src/client/SyntheticClient.cc
index b2a936f..0da8bed 100644
--- a/src/client/SyntheticClient.cc
+++ b/src/client/SyntheticClient.cc
@@ -1977,7 +1977,10 @@ int SyntheticClient::write_file(string& fn, int size, loff_t wrsize)   // size i
 
   int fd = client->open(fn.c_str(), O_RDWR|O_CREAT);
   dout(5) << "writing to " << fn << " fd " << fd << dendl;
-  if (fd < 0) return fd;
+  if (fd < 0) {
+    delete[] buf;
+    return fd;
+  }
   
   utime_t from = ceph_clock_now(g_ceph_context);
   utime_t start = from;
@@ -2037,7 +2040,10 @@ int SyntheticClient::write_fd(int fd, int size, int wrsize)   // size is in MB,
   uint64_t chunks = (uint64_t)size * (uint64_t)(1024*1024) / (uint64_t)wrsize;
 
   //dout(5) << "SyntheticClient::write_fd: writing to fd " << fd << dendl;
-  if (fd < 0) return fd;
+  if (fd < 0) {
+    delete[] buf;
+    return fd;
+  }
 
   for (unsigned i=0; i<chunks; i++) {
     if (time_to_stop()) {
@@ -2087,7 +2093,10 @@ int SyntheticClient::read_file(const std::string& fn, int size,
 
   int fd = client->open(fn.c_str(), O_RDONLY);
   dout(5) << "reading from " << fn << " fd " << fd << dendl;
-  if (fd < 0) return fd;
+  if (fd < 0) {
+    delete[] buf;
+    return fd;
+  }
 
   utime_t from = ceph_clock_now(g_ceph_context);
   utime_t start = from;
-- 
1.8.1.2

