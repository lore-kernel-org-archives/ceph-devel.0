From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH v4] radosgw: receiving unexpected error code while accessing an  non-existing object by authorized not-owner user
Date: Thu, 25 Apr 2013 23:36:56 +0800
Message-ID: <1366904216-7097-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:54355 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758286Ab3DYPiZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 11:38:25 -0400
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

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
Reviewed-by: Yehuda Sadeh <yehuda@inktank.com>
---
 src/rgw/rgw_acl.cc    |    4 ++--
 src/rgw/rgw_common.cc |    8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/src/rgw/rgw_acl.cc b/src/rgw/rgw_acl.cc
index 1a90649..6357d4b 100644
--- a/src/rgw/rgw_acl.cc
+++ b/src/rgw/rgw_acl.cc
@@ -92,7 +92,7 @@ int RGWAccessControlPolicy::get_perm(string& id, int perm_mask) {
 
 bool RGWAccessControlPolicy::verify_permission(string& uid, int user_perm_mask, int perm)
 {
-  int test_perm = perm;
+  int test_perm = perm | RGW_PERM_READ_OBJS | RGW_PERM_WRITE_OBJS;
 
   int policy_perm = get_perm(uid, test_perm);
 
@@ -107,7 +107,7 @@ bool RGWAccessControlPolicy::verify_permission(string& uid, int user_perm_mask,
     policy_perm |= (RGW_PERM_READ | RGW_PERM_READ_ACP);
   }
    
-  int acl_perm = policy_perm & user_perm_mask;
+  int acl_perm = policy_perm & perm & user_perm_mask;
 
   ldout(cct, 10) << " uid=" << uid << " requested perm (type)=" << perm << ", policy perm=" << policy_perm << ", user_perm_mask=" << user_perm_mask << ", acl perm=" << acl_perm << dendl;
 
diff --git a/src/rgw/rgw_common.cc b/src/rgw/rgw_common.cc
index d9c0a80..2cd4e6f 100644
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
 
-- 
1.7.9.5


