From: Aditya Pakki <pakki001@umn.edu>
Subject: [PATCH] libceph: Avoid a NULL pointer dereference
Date: Thu, 14 Mar 2019 16:17:24 -0500
Message-ID: <20190314211724.21306-1-pakki001@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pakki001@umn.edu
Cc: kjlu@umn.edu, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, ceph-devel@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

kmalloc allocates memory for dest->name and attempts to call
memcpy without a check for failure. This patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 net/ceph/osdmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 48a31dc9161c..c76a7c7e6a77 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1901,6 +1901,8 @@ void ceph_oid_copy(struct ceph_object_id *dest,
 	} else {
 		dest->name = dest->inline_name;
 	}
+	if (!dest->name)
+		return;
 	memcpy(dest->name, src->name, src->name_len + 1);
 	dest->name_len = src->name_len;
 }
-- 
2.17.1
