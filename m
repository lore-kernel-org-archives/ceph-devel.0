Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795158679;
	b=MUJmKNiWWgPeSyR5cZpZ2cFIqWWDaOOTRsUfDYILATlEi3sq88LijPwPFkuFdoCg88JD
	 mHrKdDHuKdDhvzyo8HTgPbK91C/Fuk2gwnV5WZK8qbfAEokzSzUBK3eNiFefgJBdN3h38
	 YuVEBB2XeJOuVLJHzUqL7ZK1SkqTKHCDXaI4ufzXgPXygfgivdfV42WbpUocv3DTSMxMF
	 qjCUNQmvCHNyhkngrHeTE1t5OoQNDNx6uaBpFbck20kYsOBVY30FSG4ls/WzaMgj5qN6U
	 dZfX3Vs6XNEYj05bAPBdPjRF/AT4ZB8XqJezeHEuDDqTJ0Wk0aWX+oV58jW/MqQva5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158679;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DdmgcgnyNK/CQ1FONRwFZ+hXePIalkwesXPAQLirVv4=;
	b=1sino7hHLEL1CJFvXYxrKM5qWJmehXeeoB+xSeXJffjnmRL+YqPgDS7zMS2FfH3ZrsRq
	 5Qk8GBrL5WNiCJUEEnVFgEhG2ECDvR6CbIoRF85DVCjVI80Wk/zBhcnvQgP/2/qUfgIqr
	 u4g+czWklEY0nVC+PITE2UjYLgpSvvLR9zm/wOri51YiEI3CG9dIxcmvKj2lkDh626Ort
	 mCdze1IaCWfLMkyzPwmMmrfsvm1Px3bYxzGEoejxi9Vzq9gObCVk24ZFbPqunL5NfqAf+
	 Soumy2gbK4xAcULWvBPXUZE/TgNWsJET2MIagm0XenOj3o9Wl/mQV/b30nxNXvUuy4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h83QxhY8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC38606A336;
	Fri, 20 Nov 2026 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h83QxhY8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795158679;
	b=u9LV4x1HSZNptVV1hkwEBjLJuF7x14xJBb6HyJSUeTX+BsZOjrqW03T8YQJ5cKoNsKrS
	 oIUHi+9GPLwxzIWgIp0rtKZbCei7NmjsCFRpdnaktzXEnJ+20gjAS7s9HPP7vwFfcBfj2
	 gqy6Fi8qJf62dis19hCzmLsuaoYMdAXLP3hezhieSTwGQcZxQxDB/L7NMpp/4JafEX2RX
	 wQylVE+rAStYP22yDHPJpUwr8KdBdCDwZ6ko2RDl9OFvrz4CfUMzOIGQmIYKggCwinABt
	 Q/MUDJP3efWBtDsTyrx6scbbVyEvDlS2/OCq2Lko+UP7/AH10WqlXH/bAwVbwGS3HrQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795158679;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DdmgcgnyNK/CQ1FONRwFZ+hXePIalkwesXPAQLirVv4=;
	b=rfLv35hd55xrAa+7PAiTOg6KnNIVuWy1I/yc4fdLEju8uyc+f2dOBvs+jSTa3a0VD72B
	 yAZH/Wa8az3blMlUJtZ0y3Rv7G1c2XMgEIMtxZuCeGmZ79IxyLfqO+Z64esXQnHcnA1nC
	 Z6fbpci+nJjkZ40XXwa+3+Fxi3v0lYxTztZfBrWnAk79YzgtNHtbUg5KTVptYBu2Ytohq
	 tkWp7vGBJzeIbNLC4C+pwnb+HEAz0x8y9M35BCsvXoTx59v8rkGz484xv1EhYZL12f45n
	 ZH+E1XYZNYRYVTBom0GjjY45FAo629I9pqI2KYFgV9XYiO5X3BpetXswFpCJ9L3qB1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 098911F000D8;
	Fri, 20 Nov 2026 07:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795158679;
	bh=DdmgcgnyNK/CQ1FONRwFZ+hXePIalkwesXPAQLirVv4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=h83QxhY8DQRSP1de1XcnCTDjOiwvC0NUXY75bw/RVQIuHiqawA3MwQuw41X6Q4dZQ
	 0U/idQBOnKKbLfuFhHm+vM2fLyr+mIafzQaY1rZsu9ysZPEmikfKq+yMbm10KNWEY1
	 pzH9Iv9ZS/LgrGR3wH5jWM2BImrHcjD8RSc9g0rpzOEZgOHp91zNhw6u0aDlGouOcU
	 3NXfrqzMm1Tr9gRtaJFKKBQFMHkM4+IASNHeWgSN3Fz3B4/Y8f1GkMxhl+AAPo6NNB
	 P2S/tVK3IC9KjhX11c5WRRDiZN0Lau3CueKrmh26O/wN/QotA8fOs8XnmP2psacmup
	 n3G23fJlLOZ+A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 850F84974C;
	Fri, 20 Nov 2026 07:11:17 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 20 Nov 2026 09:11:11 +0200
Subject: [PATCH v7 3/5] ceph: add wait_list_lock for wait-list
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
Message-Id: <20261120-ceph-mdsc-mutex-optimization-v7-3-a4eee70e0038@clyso.com>
References: <20261120-ceph-mdsc-mutex-optimization-v7-0-a4eee70e0038@clyso.com>
In-Reply-To: <20261120-ceph-mdsc-mutex-optimization-v7-0-a4eee70e0038@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795158674; l=4398;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=iD8fn2jHJiggYB291Y2t7iJ47QONEWyxmBRxD4/dJ2c=;
 b=dKt8JM4S2LTFn86E6YLpVvgcQYnWk9vi3+wHPWbUP4QwXeY0JO141hXGNnxW3ha3fcq/vzBlX
 Eb5nys4Q4GaDJNfyIKtqB2az6cooCZBPoELhQRToatX4mN/KLwWPSl2
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


