Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2304374A01
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 02:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783392265; cv=none; b=eoFExzRFjV505uEwKMPoE3Pvz1czfzeDz6/KKZYrts3Xf9ZAfhA4GlPukLX5wkh2QUz1MZ0Vv3XPp+3i1ebHohUh2hJahlUqeV8aSudJpV9cssIAv8bkJiB4jZsP/EcE03rjuVzdsoD5/SviFwf9EKSc0l7uLijcOb/g3mqOdCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783392265; c=relaxed/simple;
	bh=1PLq6WY4CnR0zi7/8JoPBsNi9U2U+pDCnLrimvlEcck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4sVIJFNvNopfOb1P+UxHatjoRD8Jp5n90SGaZtwTDHN+4S0YRNb190BCteIcUTCZhSqC3Ho3Y7yGmwwpMTw3FYTXcxQ3mBXOGavWqP/arpSmKYhS/QTO4DilyCb2/wJhTQAF4AzhlYPW/b8iuNRhP4ktuIyEz1EMi1HiC3MpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUfo2489; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUfo2489"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84830c774a0so101077b3a.1
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 19:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783392263; x=1783997063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ChMw8OaemqtHhUVBRsG61U3VgzcJsabcXu4l5Ex7ygA=;
        b=bUfo2489xVPCAgT8PXtCZoGQxS92Uy23d20Eh8atETkpOLg6UegY8sMzPtNVABLX3m
         jsj6B8cKkuNEOO4phubu9gVR2pM1wQEey5Z8KXNCZmOJXQrfy3rlDf+2tb4zoQ0kQMQF
         XgMvUhc9/ELbQdmRV2IIRPHcnH9uS1FY5xDfBJ/DWOB+VN6wKQpWnGDhWtbRfofChA8i
         e5TqzkEOhTylHCn6fbUIgnz1cwtNe5r22YtSnvDD9EaIB2QRdHpa0iKrxzJoPwA2OYcp
         5XJrWTniG4E5nDvTj1Dv4lJrcz5rUyfQVIb+IeEd2uTQFOvXpcBFV/DI72VH185d++cT
         h02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783392263; x=1783997063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ChMw8OaemqtHhUVBRsG61U3VgzcJsabcXu4l5Ex7ygA=;
        b=K5ZYlqFaJnf0c6oZg8Qyzje2UuXKndE696yhWu/hS+d0rc0V0xebExnk08ALb/sban
         gFq66G6cjPDpEKJzjmiKoP8HZloHSbtoC/c9hJ9Xa/npUrOY+SCwoZ31uwI6zigNsk23
         tc/Yj9cs+11q2KKiyEJ4cvp9eFpKgqTPWIxvCDYrVTgRvOhHmJ51s2QkAPbcFyKn93XR
         X6aKZX9Ui1l0+oTapDrmsjAUuzAqNZ1+BkZ1JiFEqBvVSPbAZMDOZ93WJlHjBTQaXHgh
         HBehKI9nfJHqL0bquQW4Zrwy4MMEWhi8JcqWSZtHZGpKF/y26TK9FnDSUJbmSWBXR0wC
         nTlA==
X-Gm-Message-State: AOJu0Yz1NjpgWpteG6j5QWw5GJLfWdoD7NccPa29P19LFqL8Qf9U7m+B
	uj8m2k2Cr68IvHgIwXbXKA11DyLnia1Pys7gh7U6SKiP/eHtQyHaMkdx8qxRZmmtros=
X-Gm-Gg: AfdE7cnVoKZvp+P6DjdpU5IHc9vzvCxKLatsvuUK2P1A6VgG1sc5BJcHxVaPITNrA6u
	SPy7Cq+HPeVoYYdRCq+Ef8qp1DErbTgI/rGRRotG95gMDLPEIGKGH4tIGcmGPbpZ5+Dwepves+S
	XpxeIXGnT68EvzsoJJ6po/KGdPCfTrXPKmy+q3Tv+6nMK6j+/Wpj9hc5p4olEGYkxb+K7pvEf8m
	N/vUzGhmu7KeL03GFiPQ7mYhX7P8bp+6/kuYVmWAdajkmRXly3BYwfh6UZ1wPM1I9XzHiG5re7C
	pRZjyAn7+sHHJiNOBafQM/KGh5PzLoKZ0WjG6ae0SVbkgjdDKFmL2afENaUTNr76DURKaXCOwLu
	Y2DyM4uFiH6iKpOdMO+ktKWHzZq8GErNwzlxOtbT0uNL8qcxsG95sYkumm+oWwRvrA/uFJV6dFM
	WtLZv0bFqbtqgA79PD/HP29DXa/1dnXg4=
X-Received: by 2002:a05:6a00:a0d:b0:82c:e9cc:f61d with SMTP id d2e1a72fcca58-84826be1dfbmr2963495b3a.9.1783392262951;
        Mon, 06 Jul 2026 19:44:22 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([123.114.53.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b64819sm4811900b3a.12.2026.07.06.19.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 19:44:22 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	sage@newdream.net,
	yuantan098@gmail.com,
	dstsmallbird@foxmail.com,
	edragain@163.com,
	enjou1224z@gmail.com
Subject: [PATCH 1/1] libceph: use RCU to protect monmap in ceph_compare_options()
Date: Tue,  7 Jul 2026 10:44:04 +0800
Message-ID: <8f8d2b03575328c52405f3d660b5d31e0c741ae9.1783342642.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1783342642.git.edragain@163.com>
References: <cover.1783342642.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

ceph_compare_options() checks whether a new mount shares any monitor
address with an existing client by walking client->monc.monmap via
ceph_monmap_contains().  That comparison can run under sb_lock or
rbd_client_list_lock, so it cannot take monc->mutex.

Meanwhile, monmap update handling replaces monc->monmap under
monc->mutex and frees the old map immediately.  A concurrent shared-
mount comparison can therefore dereference a freed monmap and walk
stale mon_inst[] entries, triggering a use-after-free.

Protect the compare path with RCU and publish/free monitor maps with
rcu_assign_pointer() and kfree_rcu().  Annotate monc->monmap as an
RCU pointer and use rcu_dereference_protected() in mutex-protected
paths to keep the accesses consistent with the new pointer contract.

This keeps the existing non-blocking comparison semantics while
ensuring that replaced monmaps remain alive until readers are done.

Fixes: 4e7a5dcd1bba ("ceph: negotiate authentication protocol; implement AUTH_NONE protocol")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Yong Wang <edragain@163.com>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 include/linux/ceph/mon_client.h |  4 +++-
 net/ceph/ceph_common.c          | 16 ++++++++++++----
 net/ceph/mon_client.c           | 34 ++++++++++++++++++++++-----------
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index 7a9a40163c0f..98a745f6d9ab 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -4,6 +4,7 @@
 
 #include <linux/completion.h>
 #include <linux/kref.h>
+#include <linux/rcupdate.h>
 #include <linux/rbtree.h>
 
 #include <linux/ceph/messenger.h>
@@ -19,6 +20,7 @@ struct ceph_monmap {
 	struct ceph_fsid fsid;
 	u32 epoch;
 	u32 num_mon;
+	struct rcu_head rcu;
 	struct ceph_entity_inst mon_inst[] __counted_by(num_mon);
 };
 
@@ -69,7 +71,7 @@ struct ceph_mon_generic_request {
 
 struct ceph_mon_client {
 	struct ceph_client *client;
-	struct ceph_monmap *monmap;
+	struct ceph_monmap __rcu *monmap;
 
 	struct mutex mutex;
 	struct delayed_work delayed_work;
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 952121849180..705800e07591 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -133,6 +133,7 @@ int ceph_compare_options(struct ceph_options *new_opt,
 {
 	struct ceph_options *opt1 = new_opt;
 	struct ceph_options *opt2 = client->options;
+	struct ceph_monmap *monmap;
 	int ofs = offsetof(struct ceph_options, mon_addr);
 	int i;
 	int ret;
@@ -180,13 +181,20 @@ int ceph_compare_options(struct ceph_options *new_opt,
 	if (ret)
 		return ret;
 
+	rcu_read_lock();
+	monmap = rcu_dereference(client->monc.monmap);
+	ret = -1;
+
 	/* any matching mon ip implies a match */
 	for (i = 0; i < opt1->num_mon; i++) {
-		if (ceph_monmap_contains(client->monc.monmap,
-				 &opt1->mon_addr[i]))
-			return 0;
+		if (ceph_monmap_contains(monmap, &opt1->mon_addr[i])) {
+			ret = 0;
+			break;
+		}
 	}
-	return -1;
+
+	rcu_read_unlock();
+	return ret;
 }
 EXPORT_SYMBOL(ceph_compare_options);
 
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index d2cdc8ee3155..1c7f1affa37c 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -206,19 +206,22 @@ static void __close_session(struct ceph_mon_client *monc)
  */
 static void pick_new_mon(struct ceph_mon_client *monc)
 {
+	struct ceph_monmap *monmap =
+		rcu_dereference_protected(monc->monmap,
+					  lockdep_is_held(&monc->mutex));
 	int old_mon = monc->cur_mon;
 
-	BUG_ON(monc->monmap->num_mon < 1);
+	BUG_ON(monmap->num_mon < 1);
 
-	if (monc->monmap->num_mon == 1) {
+	if (monmap->num_mon == 1) {
 		monc->cur_mon = 0;
 	} else {
-		int max = monc->monmap->num_mon;
+		int max = monmap->num_mon;
 		int o = -1;
 		int n;
 
 		if (monc->cur_mon >= 0) {
-			if (monc->cur_mon < monc->monmap->num_mon)
+			if (monc->cur_mon < monmap->num_mon)
 				o = monc->cur_mon;
 			if (o >= 0)
 				max--;
@@ -232,7 +235,7 @@ static void pick_new_mon(struct ceph_mon_client *monc)
 	}
 
 	dout("%s mon%d -> mon%d out of %d mons\n", __func__, old_mon,
-	     monc->cur_mon, monc->monmap->num_mon);
+	     monc->cur_mon, monmap->num_mon);
 }
 
 /*
@@ -240,6 +243,9 @@ static void pick_new_mon(struct ceph_mon_client *monc)
  */
 static void __open_session(struct ceph_mon_client *monc)
 {
+	struct ceph_monmap *monmap =
+		rcu_dereference_protected(monc->monmap,
+					  lockdep_is_held(&monc->mutex));
 	int ret;
 
 	pick_new_mon(monc);
@@ -256,7 +262,7 @@ static void __open_session(struct ceph_mon_client *monc)
 
 	dout("%s opening mon%d\n", __func__, monc->cur_mon);
 	ceph_con_open(&monc->con, CEPH_ENTITY_TYPE_MON, monc->cur_mon,
-		      &monc->monmap->mon_inst[monc->cur_mon].addr);
+		      &monmap->mon_inst[monc->cur_mon].addr);
 
 	/*
 	 * Queue a keepalive to ensure that in case of an early fault
@@ -542,6 +548,7 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
 				 struct ceph_msg *msg)
 {
 	struct ceph_client *client = monc->client;
+	struct ceph_monmap *old_monmap;
 	struct ceph_monmap *monmap;
 	void *p, *end;
 
@@ -564,10 +571,12 @@ static void ceph_monc_handle_map(struct ceph_mon_client *monc,
 		goto out;
 	}
 
-	kfree(monc->monmap);
-	monc->monmap = monmap;
+	old_monmap = rcu_dereference_protected(monc->monmap,
+					       lockdep_is_held(&monc->mutex));
+	rcu_assign_pointer(monc->monmap, monmap);
+	kfree_rcu(old_monmap, rcu);
 
-	__ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monc->monmap->epoch);
+	__ceph_monc_got_map(monc, CEPH_SUB_MONMAP, monmap->epoch);
 	client->have_fsid = true;
 
 out:
@@ -775,6 +784,7 @@ static void handle_statfs_reply(struct ceph_mon_client *monc,
 int ceph_monc_do_statfs(struct ceph_mon_client *monc, u64 data_pool,
 			struct ceph_statfs *buf)
 {
+	struct ceph_monmap *monmap;
 	struct ceph_mon_generic_request *req;
 	struct ceph_mon_statfs *h;
 	int ret = -ENOMEM;
@@ -802,7 +812,9 @@ int ceph_monc_do_statfs(struct ceph_mon_client *monc, u64 data_pool,
 	h->monhdr.have_version = 0;
 	h->monhdr.session_mon = cpu_to_le16(-1);
 	h->monhdr.session_mon_tid = 0;
-	h->fsid = monc->monmap->fsid;
+	monmap = rcu_dereference_protected(monc->monmap,
+					   lockdep_is_held(&monc->mutex));
+	h->fsid = monmap->fsid;
 	h->contains_data_pool = (data_pool != CEPH_NOPOOL);
 	h->data_pool = cpu_to_le64(data_pool);
 	send_generic_request(monc, req);
@@ -1267,7 +1279,7 @@ void ceph_monc_stop(struct ceph_mon_client *monc)
 	ceph_msg_put(monc->m_subscribe);
 	ceph_msg_put(monc->m_subscribe_ack);
 
-	kfree(monc->monmap);
+	kfree_rcu(monc->monmap, rcu);
 }
 EXPORT_SYMBOL(ceph_monc_stop);
 
-- 
2.53.0
