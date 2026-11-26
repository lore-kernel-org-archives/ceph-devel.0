Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795691228;
	b=XgOaCkcVeFiYm5ayjyqU16Cxbx6iMcHTCzLoZT2nYVPKl1ZhkAQ1iwxbcvS/286SxjFL
	 qGUWwGDitW1Jvy1b2Mqn+IQStMFGyv57LXAvoTeuJlWikKyXdG2taBLZXkLE0uaocPG5x
	 PvKZ3o99sYjbmzj2s5SRt7gHK9CHemtF1uOhRjhHMPOgtPYXWpf2Jik4U8jz3Jyte8wy/
	 LDkatzzGw+LO9wcH3XJ4oxT1p7kqFGwon0LUqzizLM5lOameTaC6yOaVg0X7KP83cm73s
	 moW/DfyUFOPM7TGnr7XJjc9EuWZt9cJM+nAdjBYh3xiILcjDPTS0fbZNnn/06zPZfSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795691228;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DdmgcgnyNK/CQ1FONRwFZ+hXePIalkwesXPAQLirVv4=;
	b=QandoKncebKLzk4LKlK5WMEMoRekhOBmH3ZQWBNsKqD9tGgHi04YsdkQWc4ScYS9QJZ6
	 aJZUwr2jGZ1Ul4RhOzZ/gJjpz+oWa4WZfbS2AbjyFT0ZJD3Iv+JDzP+8Jkq7vK6mTwI4v
	 OCHBHxcYuaLgu6kAbksv0BABxAOu/r4tkvBcTNNU+MmZxJagrVoFvKuJLC59ABEHYrbw+
	 34sROMSbfDr2TsMHRKImZzjISkCvhInvGZ8Y+qLthNyYiHUH/N/+3mZcFXBnN2hLkQq+L
	 Eafpn4L/2RJyexmX4nEePY+i0ne2tNmuCNj/9+isGQjJjTamdMNO2ZfLNmOd7ce4smA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMlCXdVW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DFA606A32E;
	Thu, 26 Nov 2026 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMlCXdVW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795691227;
	b=AfrQdliEfdzfKx9fThDGsI1bUVE/TWLURl3PZkdM8RT58+FTqp3Q5Onh0scp9g124EV7
	 azQgo/lPrwHQkM3x1/RFM5BR0CqzoMXFzv7ynye7ManVzIO2x+SnEHvs4zSgQxwdrqubk
	 p+7m4IB8Za5YrX3XwfTLVVhUf5bcPCNV6c3OZCjXwbzzkBxCNsMF4GmHM6we5sMvEUbee
	 0p2FGHoDsgvlGrz/Fkzr7EqdBcRQHAKILCNuygg/K1gD+LSDpDsVL14CLiUMKqk9PLb29
	 lMD4JwZmtHevHzLOTM1LtzCx5tEQccQ+1Nn2+gYhXKR/6DL/BwBZEI/T9rxh4byiCEQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795691227;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DdmgcgnyNK/CQ1FONRwFZ+hXePIalkwesXPAQLirVv4=;
	b=Gr/ewnsLTP3SgytCro3KXhMchraFcA2VXbuOYEEPRGvsQqtpr3vc5DJMXpEkYmF1DvFq
	 c/wA4HzyDwhvT47/ICmvaO0TIgENGpfx16c8rsyDT6q2ujFrSy1tY8dql1LEiJEoAa0yq
	 zn5Xj8oIxHyhpC4N/ZMAoVsn0OqvLx55eHiyX1zADA5weTmizqoxzOuwzxY1bnTLtB/9A
	 Z+5mJ8sBEhN2PdsVCaMf1DTPEgF+jMMTM7mMa/3LBOkokkNEY+uFkWTnlMZX9W/Zgim1o
	 /1A8tYJ6MMVAKePCFBKYVvbOzdimi6FZgVp0ZqY5u1kSggl1E7At+Es1kIe2vNAft2Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2D6AF1F000D0;
	Thu, 26 Nov 2026 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795691227;
	bh=DdmgcgnyNK/CQ1FONRwFZ+hXePIalkwesXPAQLirVv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PMlCXdVWQOUwdrVOxggA1nrSCvXlrwJ6hSOgX+2hD7E/1Wg6/TWZJqZtT5kcu3xrQ
	 tb413MZ+pgivDiGmorr//TGOSFzeH57NQMjPSVZY8hLGfMBzfdrbcoCT1Hh1O5DjjZ
	 csYUtqVE/JmJYPB/q4hpFZLEs5wi7ib+npi1jX07PWa0emXXmPLXXAwuFS00HfM+Gn
	 7QSyItmRFukfx/OfYcE6v1dCRRG2y++gsNTdvnAwbua6opKuCmUoeXOxLFOs0GN9tw
	 Wywg+PSBH/xvOX8+GF/TMoif7liKl1PuZ77rUUdmOBObWO9k3eNjIn22lH4toIpC7B
	 A/Vkjqmiso0tQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A98764D46E;
	Thu, 26 Nov 2026 11:06:56 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Thu, 26 Nov 2026 12:06:13 +0100
Subject: [PATCH v8 3/5] ceph: add wait_list_lock for wait-list
 serialization
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-ceph-mdsc-mutex-optimization-v8-3-5bb2299ef4ee@clyso.com>
References: <20261126-ceph-mdsc-mutex-optimization-v8-0-5bb2299ef4ee@clyso.com>
In-Reply-To: <20261126-ceph-mdsc-mutex-optimization-v8-0-5bb2299ef4ee@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795691181; l=4398;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=iD8fn2jHJiggYB291Y2t7iJ47QONEWyxmBRxD4/dJ2c=;
 b=W2zGeUwdzxeJLz6E3izzlInAS5GcQ6JPL6sK4GtNQ8gvgILrkYp9Rjmv+boFiZOLlSEt7ekVF
 hT2MzIW9SXQAYXVJvUb3anyRff5Jn1isyOgsZPLxiD2TNIOUJ+6mHvq
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

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


