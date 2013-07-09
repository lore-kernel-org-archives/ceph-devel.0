From: Johannes Erdfelt <johannes@erdfelt.com>
Subject: [PATCH] Python Ioctx.get_xattrs does not take xattr_name
Date: Tue, 9 Jul 2013 08:15:33 -0700
Message-ID: <20130709151533.GN2650@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from murphy.sventech.com ([208.68.36.220]:42902 "EHLO
	murphy.sventech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab3GIPYQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jul 2013 11:24:16 -0400
Received: from mail.sventech.com (mail.sventech.com [199.168.103.203])
	by murphy.sventech.com (Postfix) with ESMTP id 9462A2600A3
	for <ceph-devel@vger.kernel.org>; Tue,  9 Jul 2013 15:15:34 +0000 (UTC)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Fixes bug 5528

Since it returns all xattrs, it does not take an xattr_name. Also,
add unit tests for the Object xattrs methods.

Signed-off-by: Johannes Erdfelt <johannes@erdfelt.com>
---
 src/pybind/rados.py           |  4 ++--
 src/test/pybind/test_rados.py | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/pybind/rados.py b/src/pybind/rados.py
index 13badc9..0ba8184 100644
--- a/src/pybind/rados.py
+++ b/src/pybind/rados.py
@@ -1566,9 +1566,9 @@ class Object(object):
         return self.ioctx.get_xattr(self.key, xattr_name)
 
     @set_object_locator
-    def get_xattrs(self, xattr_name):
+    def get_xattrs(self):
         self.require_object_exists()
-        return self.ioctx.get_xattrs(self.key, xattr_name)
+        return self.ioctx.get_xattrs(self.key)
 
     @set_object_locator
     def set_xattr(self, xattr_name, xattr_value):
diff --git a/src/test/pybind/test_rados.py b/src/test/pybind/test_rados.py
index f182524..01b6a21 100644
--- a/src/test/pybind/test_rados.py
+++ b/src/test/pybind/test_rados.py
@@ -117,6 +117,18 @@ class TestIoctx(object):
             stored_xattrs[key] = value
         eq(stored_xattrs, xattrs)
 
+    def test_obj_xattrs(self):
+        xattrs = dict(a='1', b='2', c='3', d='a\0b', e='\0')
+        self.ioctx.write('abc', '')
+        obj = list(self.ioctx.list_objects())[0]
+        for key, value in xattrs.iteritems():
+            obj.set_xattr(key, value)
+            eq(obj.get_xattr(key), value)
+        stored_xattrs = {}
+        for key, value in obj.get_xattrs():
+            stored_xattrs[key] = value
+        eq(stored_xattrs, xattrs)
+
     def test_create_snap(self):
         assert_raises(ObjectNotFound, self.ioctx.remove_snap, 'foo')
         self.ioctx.create_snap('foo')
-- 
1.8.3.1

