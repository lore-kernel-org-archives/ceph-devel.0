Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341467;
	b=3bTaG4EKPgt/U1uyaHxV95CICvBq0oAvvZ0ksA4JnaSmhngWUAT0eLmbtcoPgA7EPG5D
	 13HukqYmtX290oRJ41EB9OOwHAtfiiQZczz9BVpGOIzxrSgjBIqxPcIkeIX8OrhzLGIoG
	 MpE0hHJA0DNMXfcnAs9Nt59WKsIPmNF72yS1jj9NrY/DfRMXpqzPLmZlvFLl5v85Cu/ip
	 DVaRnXrgpOXeH0N1WLPFAyZzzO35DLjYUCO1e0xDW8/UNGEUThEEa56Kwra8kPYKxbn02
	 30SwiBeFmG1wRxb8aeduVwZMe9jU7o339YE6pzTe4srEWoK+i9PCPo3gB7V+ZUZVxdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341467;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=u/VuDror7c4Qc2gIynWtFMp7xq9YgDMQIObIS309kqg=;
	b=Th82jRz69o+7ZlDUR5iqf0RhH9/jogtwtJ4dDYoMyyQl0jDXBjKvBbl+vauieT7C9OCs
	 vwlyk10UNyda/mcdtVNq4vbfmqvRwWz/iWnrv/4yeCOOdHC8olLNXXzPWL9DYLyiSVaCZ
	 nCjDaiUlUC7kc15SsZpIwn42WTUo2YcwgMjclzwgPNkPyYdDn5lFoM6eP0KzF2ybw5PLI
	 ESgm3UUgrVIwplyaOBz5jz1DqMXoFBUK1/uX2uZNMn4En3gSP5owi74VvLRBpAuyOC7qP
	 Q2PmeIg+0rigwUsYiFcN+xNYsMdcLS2yxOXDGz90S6E5z9kdxZEGrsJD29cz5+q9oEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SSzgcOX4;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D34360A2600
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 20:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D34360A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SSzgcOX4
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f22a8515eso198073585a.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 12:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794341466; x=1794946266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u/VuDror7c4Qc2gIynWtFMp7xq9YgDMQIObIS309kqg=;
        b=SSzgcOX4O2odga5kF/LnsNcgmHgKKR3eIQm6NiXh5qxC9e3OYu8BJ8cX9IexZkJkB5
         cl4LKJJAWg2X8gg49OsAHYVLU5WwtHTExRESpWFgQvV+89ylii/kWTNYcoSvGaQk/fHt
         aVx1qx7bY4luwhg/Hk6PDZXgw5rjrn4hM/bBO6UnkUy7obzwXRekozntGi+hi7LKRT0u
         vQ5KjZw8Z7JJPOtbmiFPZ2pBJ5w0UtXT/9y/TlXIw4BYJkiksMf2ylG47ROsSwshWQ3K
         MsFyUdRw6kGxZ2Hx4+3LrEE02kPt2dqNVSnDPTZthm8JJNZSQPe9S6Th4nG2ygdC01ah
         rtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341466; x=1794946266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u/VuDror7c4Qc2gIynWtFMp7xq9YgDMQIObIS309kqg=;
        b=ElBvwbwfUVr66MuWMMCDALqfEwUpr04kITkLcHS9Ax51SSbZ5EZUjkGqyuHCrBQLv7
         lRX0Lf/S2opOURHIpUWaHTiIfH1dQLHQAE5y0j7R8TRE1YJUsr5wuRT/njLvsAdGkKEK
         b/EbTJo9tX64QPalxTtJdo0AqGv0hzVsfhkLsIb18qou42kstimvc94pTgmVEiKbK7ND
         HVWA5CqXzyNmkb3jjevse84oSfXvuKDVzLT/6ObQrbvzttxK47I0ZX+8fg0lHTMJozxx
         b6ayKDsunwwOvroe61u/rTWkGYGRoswE6u7xJ31jdSH4hleAcBXs+rMS437XfLywGWKe
         pZKA==
X-Gm-Message-State: APuU4Z+eGLc1ZbkiusSp7FbaAfuEd6N6GBRQ68ihGTyYiIKH7Nl77qAF
	bcG2vEfjwiz02N8avFA1WAxoebyVG6HrRoGyybx4Y1N401R/nLA3WY2gK1Ehypz1
X-Gm-Gg: AYBFou3CAZg39HQlK3xXegPIG/sN917aMBOWOhFHVneptK1a1uxO3GD0Zr1QdXOENwd
	+c7J5meavr50qIxRsPlli/d5I96/dnPFTgKixT3IMZSaXB0EgyVNRH6LZ4Z/LACmp5NYtNZ48I1
	n/RZ15X9u8/dmG8AAD2vgseMlcgGG+Q1+WxLUgWCaXFlgPKXDVn54qTYuHRPwqz/EvZce8rrhh9
	upuiWg0pAgRBX+KToo82vULHrQXqsIUy5nMC6Ha/4aCudL1l4UBLhnBxtManMVTsC/AqGBA0X6Y
	5YUTBo4atrGD+nHq6GCotq2QtGKmZuSJJe7OE1ef8QLHK7uWPYj4VyJ7H2Rm7H/He7j55e5Yaj+
	ooDYmWvZeG1m/2tGo5q7u/yTAmlvF9WTz2L67ppQ6oIKaSBf0Ykp8dshzKFid1j5rTvva0pGXJk
	HWuMCGMagpxT+RCxKJhlegFdayUamnbxyvMXO/qFUsXh5NBHx6G78LCcLUuEEH2cbaGF0A0xrE6
	Ulz35ti2OA3tXyg8owRiOVd1Fy1ssogi9uy8w5IHHPWpIn7VGakMeLNlGS+0MIySR5vo9PDYndO
	sgF+r1IgTjNjCUlbdZY/A0oQJqqZ5M9gKKv6KiAR3j70tEzASg+9Og==
X-Received: by 2002:a05:620a:2686:b0:93e:f4f4:346 with SMTP id af79cd13be357-947b002d3ffmr8114185a.39.1794341466109;
        Tue, 10 Nov 2026 12:11:06 -0800 (PST)
Received: from zambezi.front.sepia.ceph.com ([2a02:8308:b10e:9400:faf:460b:2f23:8f6f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73c84bsm301815085a.9.2026.11.10.12.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:11:05 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH 2/3] libceph: don't cancel in-flight ping in send_linger_ping()
Date: Tue, 10 Nov 2026 21:10:15 +0100
Message-ID: <20261110201025.255594-3-idryomov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261110201025.255594-1-idryomov@gmail.com>
References: <20261110201025.255594-1-idryomov@gmail.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linger pings are emitted every 5 seconds (by default) but currently
there can only ever be one linger ping in flight: send_linger_ping()
always tries to revoke and free the OSD request that corresponds to the
previous ping before allocating a fresh instance for the next ping.
Because these linger ping requests go through the same per-OSD queue as
regular OSD requests, this can cause some pings to not be delivered to
the OSD on time or be lost entirely in environments with high latency
or where low/moderate latency is coupled with huge spikes.  That in
turn can cause the watch to time out on the OSD, exposing this client
instance to the risk of erroneous blocklisting in case another client
manages to proceed with breaking exclusive lock before the watch gets
reestablished.

Rework send_linger_ping() and related logic to allow for multiple
in-flight linger pings.  In hindsight, this should have been done in
commit 75dbb685f4e8 ("libceph: fix potential use-after-free on linger
ping and resends").

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/osd_client.h |  3 +-
 net/ceph/osd_client.c           | 73 +++++++++++++++------------------
 2 files changed, 33 insertions(+), 43 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 0847c522f897..7349ca09a227 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -314,8 +314,7 @@ struct ceph_osd_linger_request {
 	bool is_watch;                  /* watch or notify */
 
 	struct ceph_osd *osd;
-	struct ceph_osd_request *reg_req;
-	struct ceph_osd_request *ping_req;
+	struct list_head osd_reqs;	/* w/ r_private_item */
 	unsigned long watch_valid_thru;
 	struct list_head pending_lworks;
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 5053363134ee..b2ad2510fd91 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2771,13 +2771,13 @@ static void linger_release(struct kref *kref)
 	struct ceph_osd_linger_request *lreq =
 	    container_of(kref, struct ceph_osd_linger_request, kref);
 
-	dout("%s lreq %p reg_req %p ping_req %p\n", __func__, lreq,
-	     lreq->reg_req, lreq->ping_req);
+	dout("%s lreq %p\n", __func__, lreq);
 	WARN_ON(!RB_EMPTY_NODE(&lreq->node));
 	WARN_ON(!RB_EMPTY_NODE(&lreq->osdc_node));
 	WARN_ON(!RB_EMPTY_NODE(&lreq->mc_node));
 	WARN_ON(!list_empty(&lreq->scan_item));
 	WARN_ON(!list_empty(&lreq->pending_lworks));
+	WARN_ON(!list_empty(&lreq->osd_reqs));
 	WARN_ON(lreq->osd);
 
 	if (lreq->request_pl)
@@ -2785,8 +2785,6 @@ static void linger_release(struct kref *kref)
 	if (lreq->notify_id_pages)
 		ceph_release_page_vector(lreq->notify_id_pages, 1);
 
-	ceph_osdc_put_request(lreq->reg_req);
-	ceph_osdc_put_request(lreq->ping_req);
 	target_destroy(&lreq->t);
 	kfree(lreq);
 }
@@ -2820,6 +2818,7 @@ linger_alloc(struct ceph_osd_client *osdc)
 	RB_CLEAR_NODE(&lreq->mc_node);
 	INIT_LIST_HEAD(&lreq->scan_item);
 	INIT_LIST_HEAD(&lreq->pending_lworks);
+	INIT_LIST_HEAD(&lreq->osd_reqs);
 	init_completion(&lreq->reg_commit_wait);
 	init_completion(&lreq->notify_finish_wait);
 
@@ -3055,12 +3054,6 @@ static void linger_commit_cb(struct ceph_osd_request *req)
 	struct ceph_osd_linger_request *lreq = req->r_priv;
 
 	mutex_lock(&lreq->lock);
-	if (req != lreq->reg_req) {
-		dout("%s lreq %p linger_id %llu unknown req (%p != %p)\n",
-		     __func__, lreq, lreq->linger_id, req, lreq->reg_req);
-		goto out;
-	}
-
 	dout("%s lreq %p linger_id %llu result %d\n", __func__, lreq,
 	     lreq->linger_id, req->r_result);
 	linger_reg_commit_complete(lreq, req->r_result);
@@ -3084,8 +3077,10 @@ static void linger_commit_cb(struct ceph_osd_request *req)
 		}
 	}
 
-out:
+	list_del_init(&req->r_private_item);
 	mutex_unlock(&lreq->lock);
+
+	ceph_osdc_put_request(req);
 	linger_put(lreq);
 }
 
@@ -3107,12 +3102,6 @@ static void linger_reconnect_cb(struct ceph_osd_request *req)
 	struct ceph_osd_linger_request *lreq = req->r_priv;
 
 	mutex_lock(&lreq->lock);
-	if (req != lreq->reg_req) {
-		dout("%s lreq %p linger_id %llu unknown req (%p != %p)\n",
-		     __func__, lreq, lreq->linger_id, req, lreq->reg_req);
-		goto out;
-	}
-
 	dout("%s lreq %p linger_id %llu result %d last_error %d\n", __func__,
 	     lreq, lreq->linger_id, req->r_result, lreq->last_error);
 	if (req->r_result < 0) {
@@ -3122,8 +3111,10 @@ static void linger_reconnect_cb(struct ceph_osd_request *req)
 		}
 	}
 
-out:
+	list_del_init(&req->r_private_item);
 	mutex_unlock(&lreq->lock);
+
+	ceph_osdc_put_request(req);
 	linger_put(lreq);
 }
 
@@ -3137,10 +3128,13 @@ static void send_linger(struct ceph_osd_linger_request *lreq)
 	mutex_lock(&lreq->lock);
 	dout("%s lreq %p linger_id %llu\n", __func__, lreq, lreq->linger_id);
 
-	if (lreq->reg_req) {
-		if (lreq->reg_req->r_osd)
-			cancel_linger_request(lreq->reg_req);
-		ceph_osdc_put_request(lreq->reg_req);
+	while (!list_empty(&lreq->osd_reqs)) {
+		req = list_first_entry(&lreq->osd_reqs,
+				       struct ceph_osd_request, r_private_item);
+		if (req->r_osd)
+			cancel_linger_request(req);
+		list_del_init(&req->r_private_item);
+		ceph_osdc_put_request(req);
 	}
 
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, true, GFP_NOIO);
@@ -3176,9 +3170,9 @@ static void send_linger(struct ceph_osd_linger_request *lreq)
 	ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
 	BUG_ON(ret);
 
+	list_add_tail(&req->r_private_item, &lreq->osd_reqs);
 	req->r_priv = linger_get(lreq);
 	req->r_linger = true;
-	lreq->reg_req = req;
 	mutex_unlock(&lreq->lock);
 
 	submit_request(req, true);
@@ -3189,12 +3183,6 @@ static void linger_ping_cb(struct ceph_osd_request *req)
 	struct ceph_osd_linger_request *lreq = req->r_priv;
 
 	mutex_lock(&lreq->lock);
-	if (req != lreq->ping_req) {
-		dout("%s lreq %p linger_id %llu unknown req (%p != %p)\n",
-		     __func__, lreq, lreq->linger_id, req, lreq->ping_req);
-		goto out;
-	}
-
 	dout("%s lreq %p linger_id %llu result %d ping_sent %lu last_error %d\n",
 	     __func__, lreq, lreq->linger_id, req->r_result, req->r_start_stamp,
 	     lreq->last_error);
@@ -3210,8 +3198,10 @@ static void linger_ping_cb(struct ceph_osd_request *req)
 		     lreq->register_gen, req->r_ops[0].watch.gen);
 	}
 
-out:
+	list_del_init(&req->r_private_item);
 	mutex_unlock(&lreq->lock);
+
+	ceph_osdc_put_request(req);
 	linger_put(lreq);
 }
 
@@ -3230,12 +3220,6 @@ static void send_linger_ping(struct ceph_osd_linger_request *lreq)
 	dout("%s lreq %p linger_id %llu ping_sent %lu register_gen %u\n",
 	     __func__, lreq, lreq->linger_id, now, lreq->register_gen);
 
-	if (lreq->ping_req) {
-		if (lreq->ping_req->r_osd)
-			cancel_linger_request(lreq->ping_req);
-		ceph_osdc_put_request(lreq->ping_req);
-	}
-
 	req = ceph_osdc_alloc_request(osdc, NULL, 1, true, GFP_NOIO);
 	BUG_ON(!req);
 
@@ -3247,9 +3231,9 @@ static void send_linger_ping(struct ceph_osd_linger_request *lreq)
 	ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
 	BUG_ON(ret);
 
+	list_add_tail(&req->r_private_item, &lreq->osd_reqs);
 	req->r_priv = linger_get(lreq);
 	req->r_linger = true;
-	lreq->ping_req = req;
 
 	req->r_start_stamp = now;
 
@@ -3298,10 +3282,17 @@ static void cancel_linger_map_check(struct ceph_osd_linger_request *lreq)
  */
 static void __linger_cancel(struct ceph_osd_linger_request *lreq)
 {
-	if (lreq->ping_req && lreq->ping_req->r_osd)
-		cancel_linger_request(lreq->ping_req);
-	if (lreq->reg_req && lreq->reg_req->r_osd)
-		cancel_linger_request(lreq->reg_req);
+	struct ceph_osd_request *req;
+
+	while (!list_empty(&lreq->osd_reqs)) {
+		req = list_first_entry(&lreq->osd_reqs,
+				       struct ceph_osd_request, r_private_item);
+		if (req->r_osd)
+			cancel_linger_request(req);
+		list_del_init(&req->r_private_item);
+		ceph_osdc_put_request(req);
+	}
+
 	cancel_linger_map_check(lreq);
 	unlink_linger(lreq->osd, lreq);
 	linger_unregister(lreq);
-- 
2.55.0

