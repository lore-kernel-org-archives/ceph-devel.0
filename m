From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] ceph: eliminate unused "total" variable in ceph_mdsc_send_metrics
Date: Fri, 24 Jul 2020 15:45:34 -0400
Message-ID: <20200724194534.61016-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgGXTpg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:45:36 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>, idryomov@gmail.com

Cc: Xiubo Li <xiubli@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/metric.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index 252d6a3f75d2..2466b261fba2 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -20,7 +20,7 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 	u64 nr_caps = atomic64_read(&m->total_caps);
 	struct ceph_msg *msg;
 	struct timespec64 ts;
-	s64 sum, total;
+	s64 sum;
 	s32 items = 0;
 	s32 len;
 
@@ -53,7 +53,6 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 	read->ver = 1;
 	read->compat = 1;
 	read->data_len = cpu_to_le32(sizeof(*read) - 10);
-	total = m->total_reads;
 	sum = m->read_latency_sum;
 	jiffies_to_timespec64(sum, &ts);
 	read->sec = cpu_to_le32(ts.tv_sec);
@@ -66,7 +65,6 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 	write->ver = 1;
 	write->compat = 1;
 	write->data_len = cpu_to_le32(sizeof(*write) - 10);
-	total = m->total_writes;
 	sum = m->write_latency_sum;
 	jiffies_to_timespec64(sum, &ts);
 	write->sec = cpu_to_le32(ts.tv_sec);
@@ -79,7 +77,6 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 	meta->ver = 1;
 	meta->compat = 1;
 	meta->data_len = cpu_to_le32(sizeof(*meta) - 10);
-	total = m->total_metadatas;
 	sum = m->metadata_latency_sum;
 	jiffies_to_timespec64(sum, &ts);
 	meta->sec = cpu_to_le32(ts.tv_sec);
-- 
2.26.2
