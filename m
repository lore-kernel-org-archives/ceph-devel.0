From: Henry C Chang <henry.cy.chang@gmail.com>
Subject: [PATCH] pybind: trivial fix of missing argument
Date: Thu,  8 Dec 2011 22:35:07 +0800
Message-ID: <1323354907-744-1-git-send-email-henry.cy.chang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42317 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab1LHOfa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2011 09:35:30 -0500
Received: by yenm11 with SMTP id m11so1146637yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Dec 2011 06:35:30 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Henry C Chang <henry.cy.chang@gmail.com>

Signed-off-by: Henry C Chang <henry.cy.chang@gmail.com>
---
 src/pybind/rados.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/pybind/rados.py b/src/pybind/rados.py
index 3d00938..e43cb04 100755
--- a/src/pybind/rados.py
+++ b/src/pybind/rados.py
@@ -450,7 +450,7 @@ written." % (self.name, ret, length))
         ret = self.librados.rados_read(self.io, c_char_p(key), ret_buf,
                 c_size_t(length), c_uint64(offset))
         if ret < 0:
-            raise make_ex("Ioctx.read(%s): failed to read %s" % (self.name, key))
+            raise make_ex(ret, "Ioctx.read(%s): failed to read %s" % (self.name, key))
         return ctypes.string_at(ret_buf, ret)
 
     def get_stats(self):
-- 
1.7.4.1

