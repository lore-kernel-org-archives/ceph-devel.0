From: mchristi@redhat.com
Subject: [PATCH 4/5] target: add helper to go from iblock to request queue
Date: Tue,  5 May 2015 04:56:17 -0500
Message-ID: <1430819778-24483-5-git-send-email-mchristi@redhat.com>
References: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Mike Christie <michaelc@cs.wisc.edu>

rbd works with block_devices/request_queues. This patch
adds a helper so we can easily go from the iblock device
to the request queue in the rbd_tcm module.

Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>
---
 drivers/target/target_core_iblock.c  | 6 ++++++
 include/target/target_core_backend.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index d4a4b0f..ab84153 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -53,6 +53,12 @@ static inline struct iblock_dev *IBLOCK_DEV(struct se_device *dev)
 	return container_of(dev, struct iblock_dev, dev);
 }
 
+struct request_queue *ibock_se_device_to_q(struct se_device *dev)
+{
+	struct iblock_dev *ib_dev = IBLOCK_DEV(dev);
+	return bdev_get_queue(ib_dev->ibd_bd);
+}
+EXPORT_SYMBOL(ibock_se_device_to_q);
 
 static struct se_subsystem_api iblock_template;
 
diff --git a/include/target/target_core_backend.h b/include/target/target_core_backend.h
index d61be72..1571e68 100644
--- a/include/target/target_core_backend.h
+++ b/include/target/target_core_backend.h
@@ -139,4 +139,8 @@ int	se_dev_set_max_sectors(struct se_device *, u32);
 int	se_dev_set_optimal_sectors(struct se_device *, u32);
 int	se_dev_set_block_size(struct se_device *, u32);
 
+/* backend helper to map from se_device to its queue */
+struct request_queue;
+struct	request_queue *ibock_se_device_to_q(struct se_device *dev);
+
 #endif /* TARGET_CORE_BACKEND_H */
-- 
1.8.3.1
