From: David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 1/5] SQUASH rbd/locking: remove rbd_warn() carriage returns
Date: Wed, 29 Jul 2015 03:15:48 +0200
Message-ID: <1438132552-14673-2-git-send-email-ddiss@suse.de>
References: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35659 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbbG2BQA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jul 2015 21:16:00 -0400
In-Reply-To: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org, David Disseldorp <ddiss@suse.de>

rbd_warn() already appends '\n'.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 drivers/block/rbd_main.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/rbd_main.c b/drivers/block/rbd_main.c
index 774a03a..57e76ed 100644
--- a/drivers/block/rbd_main.c
+++ b/drivers/block/rbd_main.c
@@ -4369,13 +4369,13 @@ static int rbd_dev_print_lock_info(struct rbd_device *rbd_dev, char *name,
 	switch (addr->in_addr.ss_family) {
 	case AF_INET:
 		sin = (struct sockaddr_in *)&addr->in_addr;
-		rbd_warn(rbd_dev, "%s %s %s.%llu %s %pI4\n",
+		rbd_warn(rbd_dev, "%s %s %s.%llu %s %pI4",
 			 name, cookie, ceph_entity_type_name(type), num, desc,
 			 &sin->sin_addr.s_addr);
 		break;
 	case AF_INET6:
 		sin6 = (struct sockaddr_in6 *)&addr->in_addr;
-		rbd_warn(rbd_dev, "%s %s %s.%llu %s %pI6\n",
+		rbd_warn(rbd_dev, "%s %s %s.%llu %s %pI6",
 			 name, cookie, ceph_entity_type_name(type), num, desc,
 			 &sin6->sin6_addr);
 		break;
@@ -4423,7 +4423,7 @@ static size_t rbd_dev_print_locks(struct rbd_device *rbd_dev)
 						   GFP_KERNEL);
 		if (IS_ERR(lock)) {
 			rbd_warn(rbd_dev,
-				 "Could not print info for all locks\n");
+				 "Could not print info for all locks");
 			ret = PTR_ERR(lock);
 			goto free_list_locks_pg;
 		}
@@ -4580,10 +4580,10 @@ static ssize_t rbd_lock_set(struct device *dev, struct device_attribute *attr,
 
 	ret = sscanf(buf, "%15s %15s %15s\n", name, cookie, desc);
 	if (ret != 3) {
-		rbd_warn(rbd_dev, "Invalid number of params. Got %d\n", ret);
+		rbd_warn(rbd_dev, "Invalid number of params. Got %d", ret);
 		return -EINVAL;
 	} else if (!strlen(name) || !strlen(cookie) || !strlen(desc)) {
-		rbd_warn(rbd_dev, "missing param\n");
+		rbd_warn(rbd_dev, "missing param");
 		return -EINVAL;
 	}
 
@@ -4604,10 +4604,10 @@ static ssize_t rbd_unlock_set(struct device *dev, struct device_attribute *attr,
 
 	ret = sscanf(buf, "%15s %15s\n", name, cookie);
 	if (ret != 2) {
-		rbd_warn(rbd_dev, "Invalid number of params. Got %d\n", ret);
+		rbd_warn(rbd_dev, "Invalid number of params. Got %d", ret);
 		return -EINVAL;
 	} else if (!strlen(name) || !strlen(cookie)) {
-		rbd_warn(rbd_dev, "missing param\n");
+		rbd_warn(rbd_dev, "missing param");
 		return -EINVAL;
 	}
 
@@ -4628,10 +4628,10 @@ static ssize_t rbd_break_locks_set(struct device *dev,
 
 	ret = sscanf(buf, "%15s\n", name);
 	if (ret != 1) {
-		rbd_warn(rbd_dev, "Invalid number of params. Got %d\n", ret);
+		rbd_warn(rbd_dev, "Invalid number of params. Got %d", ret);
 		return -EINVAL;
 	} else if (!strlen(name)) {
-		rbd_warn(rbd_dev, "missing param\n");
+		rbd_warn(rbd_dev, "missing param");
 		return -EINVAL;
 	}
 
-- 
2.1.4

