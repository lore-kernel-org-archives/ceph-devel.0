From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] radosgw: receiving unexpected error code while accessing an non-existing object by authorized not-owner user
Date: Tue, 16 Apr 2013 16:55:15 +0800
Message-ID: <1366102515-10136-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:34119 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab3DPJEa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 05:04:30 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Yehuda Sadeh <yehuda@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

This patch fixes a bug in radosgw swift compatibility code,
that is, if a not-owner but authorized user access a non-existing
object in a container, he wiil receive unexpected error code,
to repeat this bug, do the following steps,

1 User1 creates a container, and grants the read/write permission to user2

curl -X PUT -i -k -H "X-Auth-Token: $user1_token" $url/$container
curl -X POST -i -k -H "X-Auth-Token: $user1_token" -H "X-Container-Read:
$user2" -H "X-Container-Write: $user2" $url/$container

2 User2 queries the object 'obj' in the newly created container
by using HEAD instruction, note the container currently is empty

curl -X HEAD -i -k -H "X-Auth-Token: $user2_token" $url/$container/obj

3 The response received by user2 is '401 Authorization Required',
rather than the expected '404 Not Found', the details are as follows,

HTTP/1.1 401 Authorization Required
Date: Tue, 16 Apr 2013 01:52:49 GMT
Server: Apache/2.2.22 (Ubuntu)
Accept-Ranges: bytes
Content-Length: 12
Vary: Accept-Encoding
Content-Type: text/plain; charset=utf-8

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/rgw/rgw_acl.cc    |   11 +++++++++--
 src/rgw/rgw_common.cc |   22 ++--------------------
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/src/rgw/rgw_acl.cc b/src/rgw/rgw_acl.cc
index 1a90649..a27feec 100644
--- a/src/rgw/rgw_acl.cc
+++ b/src/rgw/rgw_acl.cc
@@ -93,6 +93,13 @@ int RGWAccessControlPolicy::get_perm(string& id, int perm_mask) {
 bool RGWAccessControlPolicy::verify_permission(string& uid, int user_perm_mask, int perm)
 {
   int test_perm = perm;
+  
+  if (test_perm & (RGW_PERM_READ | RGW_PERM_READ_ACP)) {
+    test_perm |= RGW_PERM_READ_OBJS;
+  }
+  if (test_perm & (RGW_PERM_WRITE | RGW_PERM_WRITE_ACP)) {
+    test_perm |= RGW_PERM_WRITE_OBJS;
+  }
 
   int policy_perm = get_perm(uid, test_perm);
 
@@ -101,10 +108,10 @@ bool RGWAccessControlPolicy::verify_permission(string& uid, int user_perm_mask,
      buckets, so the swift READ permission on bucket will allow listing
      the bucket content */
   if (policy_perm & RGW_PERM_WRITE_OBJS) {
-    policy_perm |= (RGW_PERM_WRITE | RGW_PERM_WRITE_ACP);
+    policy_perm |= (RGW_PERM_WRITE | RGW_PERM_WRITE_ACP) & perm;
   }
   if (policy_perm & RGW_PERM_READ_OBJS) {
-    policy_perm |= (RGW_PERM_READ | RGW_PERM_READ_ACP);
+    policy_perm |= (RGW_PERM_READ | RGW_PERM_READ_ACP) & perm;
   }
    
   int acl_perm = policy_perm & user_perm_mask;
diff --git a/src/rgw/rgw_common.cc b/src/rgw/rgw_common.cc
index d9c0a80..7b5b6c0 100644
--- a/src/rgw/rgw_common.cc
+++ b/src/rgw/rgw_common.cc
@@ -515,14 +515,6 @@ bool verify_bucket_permission(struct req_state *s, int perm)
   if ((perm & (int)s->perm_mask) != perm)
     return false;
 
-  if (s->bucket_acl->verify_permission(s->user.user_id, perm, perm))
-    return true;
-
-  if (perm & (RGW_PERM_READ | RGW_PERM_READ_ACP))
-    perm |= RGW_PERM_READ_OBJS;
-  if (perm & RGW_PERM_WRITE)
-    perm |= RGW_PERM_WRITE_OBJS;
-
   return s->bucket_acl->verify_permission(s->user.user_id, perm, perm);
 }
 
@@ -540,18 +532,8 @@ bool verify_object_permission(struct req_state *s, RGWAccessControlPolicy *bucke
 
   if ((perm & (int)s->perm_mask) != perm)
     return false;
-
-  int swift_perm = 0;
-  if (perm & (RGW_PERM_READ | RGW_PERM_READ_ACP))
-    swift_perm |= RGW_PERM_READ_OBJS;
-  if (perm & RGW_PERM_WRITE)
-    swift_perm |= RGW_PERM_WRITE_OBJS;
-
-  if (!swift_perm)
-    return false;
-  /* we already verified the user mask above, so we pass swift_perm as the mask here,
-     otherwise the mask might not cover the swift permissions bits */
-  return bucket_acl->verify_permission(s->user.user_id, swift_perm, swift_perm);
+  
+  return bucket_acl->verify_permission(s->user.user_id, s->perm_mask, perm);
 }
 
 bool verify_object_permission(struct req_state *s, int perm)
-- 
1.7.9.5


