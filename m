Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CA137C11C;
	Sat, 29 Aug 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788003307; cv=none; b=PMkPoC47iUfAEpS1D5knPncLi18Pr4XmzOIjXNbhJD9xgyv4lJSWBgjQ8hhkuOx8mj/0IsLVRNX7bGu1Ictzlef/Eyc3RMrOYCyvnPcA0VYi8sKuHLdlV/gaVlbP9r+ZCMIVhalx3JtMMg4YzpK7EIOmRVwWV5VFg1asUXMUmX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788003307; c=relaxed/simple;
	bh=ReSU1PA4YpUFweZ1hhi1BF7SlkAYjDQIgzPWmrvFytM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o9DN4hzozfo9cyxgEbjHtOzdmv8Dav674xpERMcIyw5HEWSH4YA4VgQB3zEgfo4fWVio8MCIRk6xy1XEVcru8AMf62ibocZxsVecWGibjn9+rgc0M3s53NWyx2LOJ12o69eB1Ca6OcVBV6aCe3UObLN5ALjHzw6SQ0t4Sr3cxwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XAeesi7K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XAeesi7K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BE62C2BCFA;
	Sat, 29 Aug 2026 11:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788003307;
	bh=ReSU1PA4YpUFweZ1hhi1BF7SlkAYjDQIgzPWmrvFytM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XAeesi7Kngn84i+kyu2IUhPjX8uZjPIcSIfCQUtUWi/F/o7m8wfRe2WaI/eoeH8JK
	 oesm47cwpfUO5EKy391DE/UiCLBPBla121jj8WsJt/vbKTTQo56zvwlmiucOvz+7XO
	 gC2Dl61BOSrUH1VyXfgaGIcy9kC5VUJJXI26megaoH+UtlyozaWwPRTPn5i+HW7Jo0
	 Lwx7+u13cieZ6dX/cOxnnmaEs/ZBwEbyUNiNp6fi1JLKacqSvI8GUhcN+0HE0SdwKI
	 NP7KXepPYGHJOiNtH9I6snCJh2nKlr4oJpLg8D4hCN/g/mpNd22bM2UMlkS7OnQhr4
	 iyopQPq/2kH1A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F50C61DDE;
	Sat, 29 Aug 2026 11:35:07 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Sat, 29 Aug 2026 04:35:03 -0700
Subject: [PATCH v6 3/5] ceph: add wait_list_lock for wait-list
 serialization
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-ceph-mdsc-mutex-optimization-v6-3-466936ccbd9d@clyso.com>
References: <20260829-ceph-mdsc-mutex-optimization-v6-0-466936ccbd9d@clyso.com>
In-Reply-To: <20260829-ceph-mdsc-mutex-optimization-v6-0-466936ccbd9d@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788003303; l=4398;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=iD8fn2jHJiggYB291Y2t7iJ47QONEWyxmBRxD4/dJ2c=;
 b=ZsxzaqHenLV0qCgGa6XbN8QG1xTemPT20CW48ZzMgMLWlKWGJjmN+96I3fjcF5bS/9jy/Lzs2
 CzaQj+xy0YcCqnLU5idsfocPaEUKmgpBl7EIWBTn4uZv/rT4KR5dpVE
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

The per-MDS session wait list and the global waiting-for-map list
are currently serialized by mdsc->mutex, even though the list
operations themselves don't need the mutex's broader protection.
Introduce a dedicated spinlock to guard these lists so that
waking and kicking waiters can run outside the mutex.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/mds_client.c | 18 +++++++++++++++++-
 fs/ceph/mds_client.h |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index fdaf6f56ecd3..5983ae6e3085 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3689,7 +3689,9 @@ static void __do_request(struct ceph_mds_client *mdsc,
 			doutc(cl, "no mdsmap, waiting for map\n");
 			trace_ceph_mdsc_suspend_request(mdsc, session, req,
 							ceph_mdsc_suspend_reason_no_mdsmap);
+			spin_lock(&mdsc->wait_list_lock);
 			list_add(&req->r_wait, &mdsc->waiting_for_map);
+			spin_unlock(&mdsc->wait_list_lock);
 			return;
 		}
 		if (!(mdsc->fsc->mount_options->flags &
@@ -3712,7 +3714,9 @@ static void __do_request(struct ceph_mds_client *mdsc,
 		doutc(cl, "no mds or not active, waiting for map\n");
 		trace_ceph_mdsc_suspend_request(mdsc, session, req,
 						ceph_mdsc_suspend_reason_no_active_mds);
+		spin_lock(&mdsc->wait_list_lock);
 		list_add(&req->r_wait, &mdsc->waiting_for_map);
+		spin_unlock(&mdsc->wait_list_lock);
 		return;
 	}
 
@@ -3760,9 +3764,12 @@ static void __do_request(struct ceph_mds_client *mdsc,
 			if (ceph_test_mount_opt(mdsc->fsc, CLEANRECOVER)) {
 				trace_ceph_mdsc_suspend_request(mdsc, session, req,
 								ceph_mdsc_suspend_reason_rejected);
+				spin_lock(&mdsc->wait_list_lock);
 				list_add(&req->r_wait, &mdsc->waiting_for_map);
-			} else
+				spin_unlock(&mdsc->wait_list_lock);
+			} else {
 				err = -EACCES;
+			}
 			goto out_session;
 		}
 
@@ -3777,7 +3784,9 @@ static void __do_request(struct ceph_mds_client *mdsc,
 		}
 		trace_ceph_mdsc_suspend_request(mdsc, session, req,
 						ceph_mdsc_suspend_reason_session);
+		spin_lock(&mdsc->wait_list_lock);
 		list_add(&req->r_wait, &session->s_waiting);
+		spin_unlock(&mdsc->wait_list_lock);
 		goto out_session;
 	}
 
@@ -3870,7 +3879,9 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
 	struct ceph_mds_request *req;
 	LIST_HEAD(tmp_list);
 
+	spin_lock(&mdsc->wait_list_lock);
 	list_splice_init(head, &tmp_list);
+	spin_unlock(&mdsc->wait_list_lock);
 
 	while (!list_empty(&tmp_list)) {
 		req = list_entry(tmp_list.next,
@@ -3903,7 +3914,9 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 		if (req->r_session &&
 		    req->r_session->s_mds == mds) {
 			doutc(cl, " kicking tid %llu\n", req->r_tid);
+			spin_lock(&mdsc->wait_list_lock);
 			list_del_init(&req->r_wait);
+			spin_unlock(&mdsc->wait_list_lock);
 			trace_ceph_mdsc_resume_request(mdsc, req);
 			__do_request(mdsc, req);
 		}
@@ -6365,6 +6378,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	mdsc->snap_realms = RB_ROOT;
 	INIT_LIST_HEAD(&mdsc->snap_empty);
 	spin_lock_init(&mdsc->snap_empty_lock);
+	spin_lock_init(&mdsc->wait_list_lock);
 	xa_init(&mdsc->request_tree);
 	INIT_DELAYED_WORK(&mdsc->delayed_work, delayed_work);
 	mdsc->last_renew_caps = jiffies;
@@ -6447,7 +6461,9 @@ static void wait_requests(struct ceph_mds_client *mdsc)
 		mutex_lock(&mdsc->mutex);
 		while ((req = __get_oldest_req(mdsc))) {
 			doutc(cl, "timed out on tid %llu\n", req->r_tid);
+			spin_lock(&mdsc->wait_list_lock);
 			list_del_init(&req->r_wait);
+			spin_unlock(&mdsc->wait_list_lock);
 			__unregister_request(mdsc, req);
 		}
 	}
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index baba5dcf0def..0ea144ba4c7d 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -531,6 +531,9 @@ struct ceph_mds_client {
 	struct list_head        snap_empty;
 	int			num_snap_realms;
 	spinlock_t              snap_empty_lock;  /* protect snap_empty */
+	spinlock_t              wait_list_lock;   /* protect waiting_for_map
+						   * and s_waiting lists
+						   */
 
 	u64                    last_tid;      /* most recent mds request */
 	u64                    oldest_tid;    /* oldest incomplete mds request,

-- 
2.53.0


