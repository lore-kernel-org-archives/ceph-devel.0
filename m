From: xiubli@redhat.com
Subject: [PATCH v4 1/4] ceph: switch to DIV64_U64_ROUND_CLOSEST to support 32-bit arches
Date: Wed, 18 Mar 2020 01:45:52 -0400
Message-ID: <1584510355-6936-2-git-send-email-xiubli@redhat.com>
References: <1584510355-6936-1-git-send-email-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49835 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgCRFqM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:46:12 -0400
In-Reply-To: <1584510355-6936-1-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, gfarnum@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

fs/ceph/debugfs.c:140: undefined reference to `__divdi3'
Use math64 helpers to avoid 64-bit div on 32-bit arches.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 60f3e307..95e8693 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -137,19 +137,19 @@ static int metric_show(struct seq_file *s, void *p)
 	total = percpu_counter_sum(&mdsc->metric.total_reads);
 	sum = percpu_counter_sum(&mdsc->metric.read_latency_sum);
 	sum = jiffies_to_usecs(sum);
-	avg = total ? sum / total : 0;
+	avg = total ? DIV64_U64_ROUND_CLOSEST(sum, total) : 0;
 	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "read", total, sum, avg);
 
 	total = percpu_counter_sum(&mdsc->metric.total_writes);
 	sum = percpu_counter_sum(&mdsc->metric.write_latency_sum);
 	sum = jiffies_to_usecs(sum);
-	avg = total ? sum / total : 0;
+	avg = total ? DIV64_U64_ROUND_CLOSEST(sum, total) : 0;
 	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "write", total, sum, avg);
 
 	total = percpu_counter_sum(&mdsc->metric.total_metadatas);
 	sum = percpu_counter_sum(&mdsc->metric.metadata_latency_sum);
 	sum = jiffies_to_usecs(sum);
-	avg = total ? sum / total : 0;
+	avg = total ? DIV64_U64_ROUND_CLOSEST(sum, total) : 0;
 	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "metadata", total, sum, avg);
 
 	seq_printf(s, "\n");
-- 
1.8.3.1
