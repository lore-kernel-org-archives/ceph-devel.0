From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH V2] radosgw: receiving unexpected error code while accessing an non-existing object by authorized not-owner user
Date: Thu, 18 Apr 2013 21:20:44 +0800
Message-ID: <1366291244-5869-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:32854 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479Ab3DRNXB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 09:23:01 -0400
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
 src/rgw/rgw_op.cc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rgw/rgw_op.cc b/src/rgw/rgw_op.cc
index d2fbeeb..ef6448c 100644
--- a/src/rgw/rgw_op.cc
+++ b/src/rgw/rgw_op.cc
@@ -268,7 +268,7 @@ static int read_policy(RGWRados *store, struct req_state *s, RGWBucketInfo& buck
       return ret;
     string& owner = bucket_policy.get_owner().get_id();
     if (owner.compare(s->user.user_id) != 0 &&
-        !bucket_policy.verify_permission(s->user.user_id, s->perm_mask, RGW_PERM_READ))
+        !bucket_policy.verify_permission(s->user.user_id, s->perm_mask, RGW_PERM_READ) && !bucket_policy.verify_permission(s->user.user_id, RGW_PERM_READ_OBJS, RGW_PERM_READ_OBJS))
       ret = -EACCES;
     else
       ret = -ENOENT;
-- 
1.7.9.5


