Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BC3A9619;
	Wed, 15 Jul 2026 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784087942; cv=none; b=Oj+xDNy1ngYkvQNJ9PO4ZfYJWFzUZoPgJZphks3+rOe02U5CBwMONkt8qiZvcK5pyT29alNMzNZqNp0Sv6Fl5u8S/a0GjGzkq+dUJknTrbXP1dkB9qvbHdVvVuHLQhGdG8AZdJkDuro5E3b0S4l+wald4+upX4wA0qZRPKStIaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784087942; c=relaxed/simple;
	bh=9ZVzrx+cAqVCn/tO58rBI8AofKnKMlLa6UyXiCkHSyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bImgHmfBY2Ft1zDWdriodRyqUm1kmU7p+yZC2rRTA+SK/qCZ+1M9eP82+Qp9KmJaiGuuk4LSILwBelumBpk0GoQtXydcMFRGr0RkjqC+Fpzf/MGDCya7D2FcqKfx1qUgs2y2LPMNW7cNlbp3p5GM4BV0WwCusgDOEVSoCttGOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKLg6DGu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKLg6DGu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74F5DC2BCF6;
	Wed, 15 Jul 2026 03:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784087942;
	bh=9ZVzrx+cAqVCn/tO58rBI8AofKnKMlLa6UyXiCkHSyM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=aKLg6DGuuUFLUYj4kVohcE8W3Eu79f+h9pAgAV+aDnVFiWI7AX6KMuqTYNaloAunL
	 CbzYqX8d7DoUUD3P/1hL82az/qzoOe32dcDGSaW4nYZpV1Z/+940kfyzMe3J6JJ8HX
	 BcXQxxZr2y+16/8KNfTghkM6C/7BuzkrrI7gjxykS6BwN6c29ktlYlhG/WvLI775pU
	 +uHrlzMOjEKzfC/lQeQQPeSe6Q//NP8w1TsBihS4bxUejpfQzbsuDSBLm+N4ur9GF/
	 SUUqTdV/QdhiFYwwrnU4wX2XwJY3IoKutJTS8B4pqLLlGzNOerpEf1Pi3rNdhfpphs
	 qf7XqvrjiiLoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E6DC4450D;
	Wed, 15 Jul 2026 03:59:02 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 15 Jul 2026 11:58:43 +0800
Subject: [PATCH v2 3/5] ceph: add wait_list_lock for wait-list
 serialization
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-ceph-mdsc-mutex-optimization-v2-3-90e81b726724@clyso.com>
References: <20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
In-Reply-To: <20260715-ceph-mdsc-mutex-optimization-v2-0-90e81b726724@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784087938; l=4321;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=ZM5+rqFiltYRAU5IPZZD6s0Tq42PaxLa1hlAMloRIAw=;
 b=LMmXuh/AuXGC5uVA1bUJB0tXaWuHoaf4eKvfIQIwZouT1Kl7uT+CKq8wEeWYF+u5hJ+EAxSJ6
 eooP2nu8Eg4BSoO+zFav9I+S237NCubV+2PPtaW9xIMX7Q2vgidl/uX
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

Add a dedicated spinlock to protect the waiting_for_map and
s_waiting lists, which are currently serialized by mdsc->mutex.
This is a preparatory step for removing mdsc->mutex from the
kick_requests() path: xa_for_each() is internally locked and the
per-request filter checks are lockless, so only list_del_init()
needs external protection.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/mds_client.c | 18 +++++++++++++++++-
 fs/ceph/mds_client.h |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 239ed34886f9..a250938f32d3 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -3669,7 +3669,9 @@ static void __do_request(struct ceph_mds_client *mdsc,
 			doutc(cl, "no mdsmap, waiting for map\n");
 			trace_ceph_mdsc_suspend_request(mdsc, session, req,
 							ceph_mdsc_suspend_reason_no_mdsmap);
+			spin_lock(&mdsc->wait_list_lock);
 			list_add(&req->r_wait, &mdsc->waiting_for_map);
+			spin_unlock(&mdsc->wait_list_lock);
 			return;
 		}
 		if (!(mdsc->fsc->mount_options->flags &
@@ -3692,7 +3694,9 @@ static void __do_request(struct ceph_mds_client *mdsc,
 		doutc(cl, "no mds or not active, waiting for map\n");
 		trace_ceph_mdsc_suspend_request(mdsc, session, req,
 						ceph_mdsc_suspend_reason_no_active_mds);
+		spin_lock(&mdsc->wait_list_lock);
 		list_add(&req->r_wait, &mdsc->waiting_for_map);
+		spin_unlock(&mdsc->wait_list_lock);
 		return;
 	}
 
@@ -3740,9 +3744,12 @@ static void __do_request(struct ceph_mds_client *mdsc,
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
 
@@ -3757,7 +3764,9 @@ static void __do_request(struct ceph_mds_client *mdsc,
 		}
 		trace_ceph_mdsc_suspend_request(mdsc, session, req,
 						ceph_mdsc_suspend_reason_session);
+		spin_lock(&mdsc->wait_list_lock);
 		list_add(&req->r_wait, &session->s_waiting);
+		spin_unlock(&mdsc->wait_list_lock);
 		goto out_session;
 	}
 
@@ -3850,7 +3859,9 @@ static void __wake_requests(struct ceph_mds_client *mdsc,
 	struct ceph_mds_request *req;
 	LIST_HEAD(tmp_list);
 
+	spin_lock(&mdsc->wait_list_lock);
 	list_splice_init(head, &tmp_list);
+	spin_unlock(&mdsc->wait_list_lock);
 
 	while (!list_empty(&tmp_list)) {
 		req = list_entry(tmp_list.next,
@@ -3892,7 +3903,9 @@ static void kick_requests(struct ceph_mds_client *mdsc, int mds)
 		if (req->r_session &&
 		    req->r_session->s_mds == mds) {
 			doutc(cl, " kicking tid %llu\n", req->r_tid);
+			spin_lock(&mdsc->wait_list_lock);
 			list_del_init(&req->r_wait);
+			spin_unlock(&mdsc->wait_list_lock);
 			trace_ceph_mdsc_resume_request(mdsc, req);
 			__do_request(mdsc, req);
 		}
@@ -6359,6 +6372,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	mdsc->snap_realms = RB_ROOT;
 	INIT_LIST_HEAD(&mdsc->snap_empty);
 	spin_lock_init(&mdsc->snap_empty_lock);
+	spin_lock_init(&mdsc->wait_list_lock);
 #if BITS_PER_LONG == 64
 	xa_init(&mdsc->request_tree);
 #else
@@ -6445,7 +6459,9 @@ static void wait_requests(struct ceph_mds_client *mdsc)
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
index c2de551607e3..0a9f89498604 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -534,6 +534,9 @@ struct ceph_mds_client {
 	struct list_head        snap_empty;
 	int			num_snap_realms;
 	spinlock_t              snap_empty_lock;  /* protect snap_empty */
+	spinlock_t              wait_list_lock;   /* protect waiting_for_map
+						   * and s_waiting lists
+						   */
 
 	u64                    last_tid;      /* most recent mds request */
 	atomic64_t             oldest_tid;    /* oldest incomplete mds request,

-- 
2.53.0


