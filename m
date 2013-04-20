From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH v3] radosgw: receiving unexpected error code while accessing an non-existing object by authorized not-owner user
Date: Sat, 20 Apr 2013 20:14:20 +0800
Message-ID: <1366460060-3341-1-git-send-email-liwang@ubuntukylin.com>
References: <1366291244-5869-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m59-178.qiye.163.com ([123.58.178.59]:45870 "EHLO
	m59-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755146Ab3DTMZz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Apr 2013 08:25:55 -0400
In-Reply-To: <1366291244-5869-1-git-send-email-liwang@ubuntukylin.com>
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
Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>
---
Changes from v1:
Simplify the revision to RGWAccessControlPolicy::verify_permission()
according to Yehuda's suggestion
---
 src/rgw/rgw_acl.cc    |    5 ++---
 src/rgw/rgw_common.cc |   20 +-------------------
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/src/rgw/rgw_acl.cc b/src/rgw/rgw_acl.cc
index 1a90649..e3dcd9b 100644
--- a/src/rgw/rgw_acl.cc
+++ b/src/rgw/rgw_acl.cc
@@ -92,8 +92,7 @@ int RGWAccessControlPolicy::get_perm(string& id, int perm_mask) {
 
 bool RGWAccessControlPolicy::verify_permission(string& uid, int user_perm_mask, int perm)
 {
-  int test_perm = perm;
-
+  int test_perm = perm | RGW_PERM_WRITE_OBJS | RGW_PERM_READ_OBJS; 
   int policy_perm = get_perm(uid, test_perm);
 
   /* the swift WRITE_OBJS perm is equivalent to the WRITE obj, just
@@ -107,7 +106,7 @@ bool RGWAccessControlPolicy::verify_permission(string& uid, int user_perm_mask,
     policy_perm |= (RGW_PERM_READ | RGW_PERM_READ_ACP);
   }
    
-  int acl_perm = policy_perm & user_perm_mask;
+  int acl_perm = policy_perm & perm & user_perm_mask; 
 
   ldout(cct, 10) << " uid=" << uid << " requested perm (type)=" << perm << ", policy perm=" << policy_perm << ", user_perm_mask=" << user_perm_mask << ", acl perm=" << acl_perm << dendl;
 
diff --git a/src/rgw/rgw_common.cc b/src/rgw/rgw_common.cc
index d9c0a80..139a00e 100644
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
 
@@ -541,17 +533,7 @@ bool verify_object_permission(struct req_state *s, RGWAccessControlPolicy *bucke
   if ((perm & (int)s->perm_mask) != perm)
     return false;
 
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
+  return bucket_acl->verify_permission(s->user.user_id, s->perm_mask, swift_perm);
 }
 
 bool verify_object_permission(struct req_state *s, int perm)
-- 
1.7.9.5


