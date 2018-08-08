From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] crush: fix using plain integer as NULL warning
Date: Wed, 8 Aug 2018 19:52:57 +0800
Message-ID: <20180808115257.6088-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, idryomov@gmail.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, zyan@redhat.com, sage@redhat.com, ceph-devel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: ceph-devel.vger.kernel.org

Fixes the following sparse warning:
net/ceph/crush/mapper.c:517:76: warning: Using plain integer as NULL pointer
net/ceph/crush/mapper.c:728:68: warning: Using plain integer as NULL pointer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/ceph/crush/mapper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 417df67..3f323ed 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -514,7 +514,7 @@ static int crush_choose_firstn(const struct crush_map *map,
 						in, work->work[-1-in->id],
 						x, r,
 						(choose_args ?
-						 &choose_args[-1-in->id] : 0),
+						 &choose_args[-1-in->id] : NULL),
 						outpos);
 				if (item >= map->max_devices) {
 					dprintk("   bad item %d\n", item);
@@ -725,7 +725,7 @@ static void crush_choose_indep(const struct crush_map *map,
 					in, work->work[-1-in->id],
 					x, r,
 					(choose_args ?
-					 &choose_args[-1-in->id] : 0),
+					 &choose_args[-1-in->id] : NULL),
 					outpos);
 				if (item >= map->max_devices) {
 					dprintk("   bad item %d\n", item);
-- 
2.7.0
