From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: [PATCH 4/8] include/buffer.h: fix operator=
Date: Wed,  6 Feb 2013 12:02:47 +0100
Message-ID: <1360148571-6984-5-git-send-email-danny.al-gaaf@bisect.de>
References: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:32948 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757322Ab3BFLC4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 06:02:56 -0500
In-Reply-To: <1360148571-6984-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>, Gary Lowell <gary.lowell@inktank.com>

Fix operator=: return "iterator&" instead of 'iterator'. Check if 'this'
equals 'other' before set anything.

Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
---
 src/include/buffer.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/include/buffer.h b/src/include/buffer.h
index 9a635bd..4f87ed7 100644
--- a/src/include/buffer.h
+++ b/src/include/buffer.h
@@ -248,7 +248,7 @@ public:
 					p(other.p),
 					p_off(other.p_off) {}
 
-      iterator operator=(const iterator& other) {
+      iterator& operator=(const iterator& other) {
 	if (this != &other) {
 	  bl = other.bl;
 	  ls = other.ls;
@@ -305,8 +305,10 @@ public:
     
     list(const list& other) : _buffers(other._buffers), _len(other._len), last_p(this) { }
     list& operator= (const list& other) {
-      _buffers = other._buffers;
-      _len = other._len;
+      if (this != &other) {
+        _buffers = other._buffers;
+        _len = other._len;
+      }
       return *this;
     }
 
-- 
1.8.1.2

