Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B14415B67;
	Tue, 13 Oct 2026 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791933646; cv=none; b=TDYuzKt3v/QFrSyDuCmDIaZ2W4BY5sI8EkCgmx3QGp1AbH1fPUFeQ0GP5AZyAz60wJAUCnpJFnLN+U6u5TX5oOS2Szb8b53F14k1XhxVhL5HvQQmn+4ylShn5WKnNrf1ROFRHbjHJ8rFaK4JJoS9QTipabSyelu8wNDMolwdxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791933646; c=relaxed/simple;
	bh=PWdfE6SVl2ssZtNqAh81cIp0TUfIxVyyK6UDd8dy6Bg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lM9PHZbVjQvSlhFGuizafVKpus74rtnZnR3SqKTAWSc163wY7ju1OllwwbLPXz9nEpjnKT85dVDrXNjl7OlPkSJR3r8wiA9ZsG1uzS4VK21AnMgZWpUrtk6ZNS9SL0+/3pNozcOz/BXngLLWG7kbSq4vHj+UoLEtFqxFxaOAvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpMbmleE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpMbmleE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FC5AC2BCFB;
	Tue, 13 Oct 2026 23:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791933645;
	bh=PWdfE6SVl2ssZtNqAh81cIp0TUfIxVyyK6UDd8dy6Bg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BpMbmleE+NQ7wFfD6hGgXDzVPWpSEC6Ntwz8+MXAwcg3cP35uwHFOUrFcHZABl7Hg
	 8Javh6pehFnAMP/NhzObCCAD46EpdS7aaGP4d46Cux3sU05LqYIRoG+jCFHkzLCDKJ
	 ZCW6sOas2+PdVjnz6iTpEdb+PJFE1ghNBZMoMbyqzPR3Se/0MQ0/Tz/Lq9iOgbSLue
	 f76GuhddJnT4cVCulE0/bRxR92BzteKs3kRKzdTRAPbYZxkaC8TRGlqv6ziF0QGAX4
	 BZ/JbcpL0UZUPpNy1CUWcVF1IXHMV+dPXGc3qeWqOzFhmn50o1sbrUa/LdU+QODisX
	 sTzpAkiuXBG1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847C3CC6B1F;
	Tue, 13 Oct 2026 23:20:45 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 14 Oct 2026 01:20:41 +0200
Subject: [PATCH 2/3] ceph: drop the unused subvolume metrics debug counters
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-ceph-metrics-percpu-v1-2-38c5a24fec6e@clyso.com>
References: <20261014-ceph-metrics-percpu-v1-0-38c5a24fec6e@clyso.com>
In-Reply-To: <20261014-ceph-metrics-percpu-v1-0-38c5a24fec6e@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, 
 Milind Changire <mchangir@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan van der Ster <dan.vanderster@clyso.com>, Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791933643; l=5945;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=gaWMTABAxeJ++HgckwUw1lcVL3j/VBtD0PVyKfJakCQ=;
 b=t2M4+uRX+BgCcEiEriaqNgEt1mO3M5k3eh6N++TKKZeOwGqLMFxJTbM3aIaLXBYMRA5faZq9R
 7Dfi1GGDRGRAzucSrA5MmZ+rJwI/N/Udg2ROIqUrBY2a96ftY8fL83H
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

ceph_subvolume_metrics_record_io() bumps tracker->record_calls on
every OSD read and write completion, plus record_disabled or
record_no_subvol when it bails out, and ceph_subvolume_metrics_record()
adds to the total_read/write_ops/bytes counters on top of its own
per-subvolume ones.  All of them are atomic64_t shared by every CPU
of the mount, so even with subvolume metrics disabled each I/O
completion dirties a cache line that every other completion on the
client also writes.

Nothing ever reads these counters, nor the snapshot_* ones: debugfs
prints the per-subvolume entries and the totals kept under
subvol_metrics_last_mutex.  Remove them.

Fixes: b1137e0b3d4b ("ceph: add subvolume metrics collection and reporting")
Reported-by: Dan van der Ster <dan.vanderster@clyso.com>
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/subvolume_metrics.c | 34 ++++------------------------------
 fs/ceph/subvolume_metrics.h | 21 ---------------------
 2 files changed, 4 insertions(+), 51 deletions(-)

diff --git a/fs/ceph/subvolume_metrics.c b/fs/ceph/subvolume_metrics.c
index 03fda1f9257b..895878a49ea7 100644
--- a/fs/ceph/subvolume_metrics.c
+++ b/fs/ceph/subvolume_metrics.c
@@ -39,16 +39,6 @@ void ceph_subvolume_metrics_init(struct ceph_subvolume_metrics_tracker *tracker)
 	tracker->tree = RB_ROOT_CACHED;
 	tracker->nr_entries = 0;
 	tracker->enabled = false;
-	atomic64_set(&tracker->snapshot_attempts, 0);
-	atomic64_set(&tracker->snapshot_empty, 0);
-	atomic64_set(&tracker->snapshot_failures, 0);
-	atomic64_set(&tracker->record_calls, 0);
-	atomic64_set(&tracker->record_disabled, 0);
-	atomic64_set(&tracker->record_no_subvol, 0);
-	atomic64_set(&tracker->total_read_ops, 0);
-	atomic64_set(&tracker->total_read_bytes, 0);
-	atomic64_set(&tracker->total_write_ops, 0);
-	atomic64_set(&tracker->total_write_bytes, 0);
 }
 
 static struct ceph_subvol_metric_rb_entry *
@@ -196,14 +186,10 @@ void ceph_subvolume_metrics_record(struct ceph_subvolume_metrics_tracker *tracke
 			entry->write_ops++;
 			entry->write_bytes += size;
 			entry->write_latency_us += latency_us;
-			atomic64_inc(&tracker->total_write_ops);
-			atomic64_add(size, &tracker->total_write_bytes);
 		} else {
 			entry->read_ops++;
 			entry->read_bytes += size;
 			entry->read_latency_us += latency_us;
-			atomic64_inc(&tracker->total_read_ops);
-			atomic64_add(size, &tracker->total_read_bytes);
 		}
 		spin_unlock(&tracker->lock);
 		if (new_entry)
@@ -227,8 +213,6 @@ int ceph_subvolume_metrics_snapshot(struct ceph_subvolume_metrics_tracker *track
 	if (!READ_ONCE(tracker->enabled))
 		return 0;
 
-	atomic64_inc(&tracker->snapshot_attempts);
-
 	spin_lock(&tracker->lock);
 	for (node = rb_first_cached(&tracker->tree); node; node = rb_next(node)) {
 		struct ceph_subvol_metric_rb_entry *entry =
@@ -240,16 +224,12 @@ int ceph_subvolume_metrics_snapshot(struct ceph_subvolume_metrics_tracker *track
 	}
 	spin_unlock(&tracker->lock);
 
-	if (!count) {
-		atomic64_inc(&tracker->snapshot_empty);
+	if (!count)
 		return 0;
-	}
 
 	snap = kcalloc(count, sizeof(*snap), GFP_NOFS);
-	if (!snap) {
-		atomic64_inc(&tracker->snapshot_failures);
+	if (!snap)
 		return -ENOMEM;
-	}
 
 	spin_lock(&tracker->lock);
 	node = rb_first_cached(&tracker->tree);
@@ -380,18 +360,12 @@ void ceph_subvolume_metrics_record_io(struct ceph_mds_client *mdsc,
 		return;
 
 	tracker = &mdsc->subvol_metrics;
-	atomic64_inc(&tracker->record_calls);
-
-	if (!ceph_subvolume_metrics_enabled(tracker)) {
-		atomic64_inc(&tracker->record_disabled);
+	if (!ceph_subvolume_metrics_enabled(tracker))
 		return;
-	}
 
 	subvol_id = READ_ONCE(ci->i_subvolume_id);
-	if (subvol_id == CEPH_SUBVOLUME_ID_NONE) {
-		atomic64_inc(&tracker->record_no_subvol);
+	if (subvol_id == CEPH_SUBVOLUME_ID_NONE)
 		return;
-	}
 
 	delta_us = ktime_to_us(ktime_sub(end, start));
 	if (delta_us <= 0)
diff --git a/fs/ceph/subvolume_metrics.h b/fs/ceph/subvolume_metrics.h
index 6f53ff726c75..8b901ae05e00 100644
--- a/fs/ceph/subvolume_metrics.h
+++ b/fs/ceph/subvolume_metrics.h
@@ -6,7 +6,6 @@
 #include <linux/rbtree.h>
 #include <linux/spinlock.h>
 #include <linux/ktime.h>
-#include <linux/atomic.h>
 
 struct seq_file;
 struct ceph_mds_client;
@@ -38,32 +37,12 @@ struct ceph_subvol_metric_snapshot {
  * @tree: Red-black tree of per-subvolume entries, keyed by subvolume_id
  * @nr_entries: Number of entries currently in @tree
  * @enabled: Whether collection is enabled (requires MDS feature support)
- * @snapshot_attempts: Debug counter: total ceph_subvolume_metrics_snapshot() calls
- * @snapshot_empty: Debug counter: snapshots that found no data to report
- * @snapshot_failures: Debug counter: snapshots that failed to allocate memory
- * @record_calls: Debug counter: total ceph_subvolume_metrics_record() calls
- * @record_disabled: Debug counter: record calls skipped because disabled
- * @record_no_subvol: Debug counter: record calls skipped (no subvolume_id)
- * @total_read_ops: Cumulative read ops across all snapshots (never reset)
- * @total_read_bytes: Cumulative bytes read across all snapshots (never reset)
- * @total_write_ops: Cumulative write ops across all snapshots (never reset)
- * @total_write_bytes: Cumulative bytes written across all snapshots (never reset)
  */
 struct ceph_subvolume_metrics_tracker {
 	spinlock_t lock;
 	struct rb_root_cached tree;
 	u32 nr_entries;
 	bool enabled;
-	atomic64_t snapshot_attempts;
-	atomic64_t snapshot_empty;
-	atomic64_t snapshot_failures;
-	atomic64_t record_calls;
-	atomic64_t record_disabled;
-	atomic64_t record_no_subvol;
-	atomic64_t total_read_ops;
-	atomic64_t total_read_bytes;
-	atomic64_t total_write_ops;
-	atomic64_t total_write_bytes;
 };
 
 void ceph_subvolume_metrics_init(struct ceph_subvolume_metrics_tracker *tracker);

-- 
2.53.0


