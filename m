Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F721DED57
	for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 13:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434666; cv=none; b=ORK72Y6eLUWC2fb8qQqf0/CSIOvORis68vFisQ2hOEQP8Zee/nZ8yVWm2B8+1bDwD2VZBm36S0YosbIDO4QZ4cHyfP5aLl5wbt1FKYOtTMyv90XTfr7oUp5SbipEjJEyKDH+Ps8jwVZo3w1sBLBTSXvIAvAyYYGPtDMQtX14YsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434666; c=relaxed/simple;
	bh=5wNrdP+SVkbfGyZLnq2bAoMphi6wq9lCW2QwQ/DWmUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XP60VugtaYCwi91OvZgwHnZr/OgqhvNKayd3mjfTuPFJnU1VivbIgCFNwQt7EMSGn+g38+xv319RAafR+MztSnGyNBASI3BFDyEOTubh1/pMUWCO6h6zlOdjCznRua+CpGYFwxEv0kSy44NMhzRMnGNyvNH0gTBI4Fdx7fpCrxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3oLVPMW; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3oLVPMW"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c6c922850cso469481985a.2
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769434663; x=1770039463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CXcqhBLddkz8IEL1C4auddh0XCHUVpurWT8W+/cLh7Q=;
        b=N3oLVPMWamg2UwVVa/BC6qCM2KvVPOx9LG44TLA3KRkJOEEvkz5EAuAKfjx5GrLrWK
         ctKLr27dPs7II6xOlmVfrYI38aYVLqydPWBx2hFHaZ68EKtDWUmuwu8Oz1DUAwFiO0uh
         B2iO/Ttig8xICycrXNpgG4lu+6zEIZTCSNATzuZi8nyCM3uks7yutZhXdBGeocGIgYvW
         s0pv/g1U/Dzq3AGBOElf/zYRuI23oD4Cn8EqcIoEyz8623G1rviwWOH5yNCjs5tXUfmw
         fIrST+u36tyhr5OT7NOSYkgQ1ta6HTnSIxalzf/jz2e2o2Iw6FiqColJvdlM+qH3WQpA
         pNnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769434663; x=1770039463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXcqhBLddkz8IEL1C4auddh0XCHUVpurWT8W+/cLh7Q=;
        b=cgWFjUfVptOKI8/Ih7NcF7VRDQTCOr63esB+xcSm0/axXBRNQm2i0jgkPUqQxrYz+v
         apCiloamU2Z1+67lvI8eZ85CI4s3Zsg0NHE5LfUbe2KqXCnk7j5Rg5Ur+oxEI8OncmEf
         MJX/S6U1Q4P3UpqLYs4YuDsDtV8K58QbQMm9HOzpp9Mf0DEJ/1x689n4iuYW+ZXY3qT8
         gS1y4Tm2NRdEHEgiam4hj6kex/vGDGgX+U9PV5Z7Eb8QHaXQ4RyRgt7XKqmh/rkx6b7W
         pzdaASvX0su0BJcmArzeYeLN3sTPR59qHnCJ7HD2sZT9F7UTpiY3nQVds9qnqx5XlQ1o
         JejA==
X-Gm-Message-State: AOJu0YwmqGV4phYtMo5NzsLAIO8bFe2JAaz3Nribh1fv80Vkx+6hx8xF
	4APdwMEV7moK+CCtT7BxQmmn+4b5a6pPPhCiQDu8ZZS+ykq01bNtSll+aasaKA==
X-Gm-Gg: AZuq6aK5s6cFrNzxJRa8jO39vQfcrqFZDnTDXFbbVKs4b9Pa77T9Pynt2a4X1h1lBcJ
	SNlxiKjHV1szL7NGQdPm5x5LbXQdqNHBhM6WT5b4PzDmlYqJDTGiOrrtEOKfOFAjIEe3ISYfP/K
	e4cbPz1ib9TGtZZpmM2bibsboO9J3J1BVR5BrTimSYpEXw4+0EM9Jub4pyYi2fNYWQFVUQevL/j
	9/AWcbJWehMNOD6+Zekr7NnlTv3YT5OKRdBzaWJ6XoC7lNpyKG+3Kqh4oPtHqR3bH7Ry2zHcUmf
	D5JI9VcSYYLKxE84+6k4/Vh74/pRciwAPKu/nQoRjY4iFsXiCe9kwvnYtHhpyVpL546q3akS8BB
	kBwB5mb+84epqlNXkJxreQyIfTzeOqWGVJ1KOLc5t/gnHGMoAovjSS+BVi1HoIOcVOKrfAgKQ/3
	JWi+o7MUIRavpSnjzmoff/wzLoflaPSCFhLeX07bp59EWESI8dUZmKRtbwhImg/PI=
X-Received: by 2002:ac8:7f92:0:b0:501:40af:96c4 with SMTP id d75a77b69052e-50314c5ca44mr56571401cf.54.1769434663443;
        Mon, 26 Jan 2026 05:37:43 -0800 (PST)
Received: from zambezi.front.sepia.ceph.com (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-502f7ec610asm87814361cf.10.2026.01.26.05.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 05:37:42 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH] rbd: check for EOD after exclusive lock is ensured to be held
Date: Mon, 26 Jan 2026 14:37:28 +0100
Message-ID: <20260126133729.867488-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to commit 870611e4877e ("rbd: get snapshot context after
exclusive lock is ensured to be held"), move the "beyond EOD" check
into the image request state machine so that it's performed after
exclusive lock is ensured to be held.  This avoids various race
conditions which can arise when the image is shrunk under I/O (in
practice, mostly readahead).  In one such scenario

    rbd_assert(objno < rbd_dev->object_map_size);

can be triggered if a close-to-EOD read gets queued right before the
shrink is initiated and the EOD check is performed against an outdated
mapping_size.  After the resize is done on the server side and exclusive
lock is (re)acquired bringing along the new (now shrunk) object map, the
read starts going through the state machine and rbd_obj_may_exist() gets
invoked on an object that is out of bounds of rbd_dev->object_map array.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index af0e21149dbc..44f4dd6e98d9 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3490,16 +3490,31 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
 {
 	struct rbd_device *rbd_dev = img_req->rbd_dev;
 	struct rbd_obj_request *obj_req;
+	u64 mapping_size;
 
 	rbd_assert(!img_req->pending.result && !img_req->pending.num_pending);
 	rbd_assert(!need_exclusive_lock(img_req) ||
 		   __rbd_is_lock_owner(rbd_dev));
 
+	down_read(&rbd_dev->header_rwsem);
+	mapping_size = rbd_dev->mapping.size;
 	if (rbd_img_is_write(img_req)) {
 		rbd_assert(!img_req->snapc);
-		down_read(&rbd_dev->header_rwsem);
 		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
-		up_read(&rbd_dev->header_rwsem);
+	}
+	up_read(&rbd_dev->header_rwsem);
+
+	if (!test_bit(IMG_REQ_CHILD, &img_req->flags)) {
+		struct request *rq = blk_mq_rq_from_pdu(img_req);
+		u64 off = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
+		u64 len = blk_rq_bytes(rq);
+
+		if (unlikely(off + len > mapping_size)) {
+			rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)",
+				 off, len, mapping_size);
+			img_req->pending.result = -EIO;
+			return;
+		}
 	}
 
 	for_each_obj_request(img_req, obj_req) {
@@ -4725,7 +4740,6 @@ static void rbd_queue_workfn(struct work_struct *work)
 	struct request *rq = blk_mq_rq_from_pdu(img_request);
 	u64 offset = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
 	u64 length = blk_rq_bytes(rq);
-	u64 mapping_size;
 	int result;
 
 	/* Ignore/skip any zero-length requests */
@@ -4738,17 +4752,9 @@ static void rbd_queue_workfn(struct work_struct *work)
 	blk_mq_start_request(rq);
 
 	down_read(&rbd_dev->header_rwsem);
-	mapping_size = rbd_dev->mapping.size;
 	rbd_img_capture_header(img_request);
 	up_read(&rbd_dev->header_rwsem);
 
-	if (offset + length > mapping_size) {
-		rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)", offset,
-			 length, mapping_size);
-		result = -EIO;
-		goto err_img_request;
-	}
-
 	dout("%s rbd_dev %p img_req %p %s %llu~%llu\n", __func__, rbd_dev,
 	     img_request, obj_op_name(op_type), offset, length);
 
-- 
2.49.0

