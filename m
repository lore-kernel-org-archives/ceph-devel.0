Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4579350A2C
	for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769604403; cv=none; b=q0Bz2R8Sa28e7XMQYXKZqzN93t14/kZ9r4m/bTZ46ddAJtA9rQ2oTZqiQtAkwDQXw0WpWqE+zVEN2p3Oglv7vyjAmvFL6JX+9xKCnNmO7v4Cc6j3tqYU04U4DYF/2qj8by51a13+FQFhQhvl/QXZm098KcAa7RG7go9IenhOYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769604403; c=relaxed/simple;
	bh=xt4egEij02FlZlJaQ6JTEsv9ypSEKLICLstFJnjpnEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=da0lK7GwiaqczEW6LtGmlSC7/G8LxQeAOmHu3HYdJlZ1AHigRkJDEACPYQ7juMsG1h0uiS2j791JaVvYY+krkZWAXPn03pWqpOuU0yxCpQCu85U1m7Jee66FCrtUFDKzZYN+PkblrkhfLJhDBI4NAq/58dcJZuRMWnSvS/xbRzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cr7Xcgid; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cr7Xcgid"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6d76b9145so814054985a.2
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jan 2026 04:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769604401; x=1770209201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ltzjaTCGRmVhwk2lXwvVt7pcFdhPMhZdvimUb35SsKE=;
        b=cr7XcgidMD89NxIjCOc59FUNsYzzoOJ2qTiI+6L7e1Zv1C7SHkcYI6+GOq1XGhyX/P
         exHllyLAOOVqocD9RM+3hl+qKQcrSkc1FzUIOeJkUfnUzweMQSMZYUNqx9IHiOhk5D7c
         JfMqfNogxzBzp/QIkLUPSC180QpbZa3ORzgb30lTlqPDsoEkUVC+MTql4irltcfNUKTG
         HTVjqjSzjPk19cts9egv6yyyGstyLuDUf/Z8Ql9RVTzP5vkgVir4PRAhv/kWWd1m5nlI
         GJMIZH1buumuLJxiA9WfKTamIb7hdU6W80aak6crtVhLRna5BSAtu7E4igOa0HVlmhpb
         y4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769604401; x=1770209201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltzjaTCGRmVhwk2lXwvVt7pcFdhPMhZdvimUb35SsKE=;
        b=MdUlStcxAPiFhtB/tAbwYSWQWZpbDARriV3U2me4yPJpUacFDqsYSix2OwJICyll8t
         +VGoiMWFbEdFOtKjdIrk0tjEeS5uiZcbtPR80k8P60PqOD3+jjIVdAW7FeWxqWTr7uqy
         s30OycpNpw5COTSki8ySUHSKfw4Qku2OQUPkuHKnvH3s2rjMTSG34fUZsmFgyd9X6NGK
         15cmh7qCTFuQEuEpnBxbAkg65Bg9YfqVVxbgboqg6bn+XDJ7LLarOH0vYCJl8921w1d3
         1e5AdBLuI3aqv/lNMRqZez4SpkpsEys/CJrKnYIj/l2ycNJf0G9nGC+wYiTeSxM8SVp7
         1cNQ==
X-Gm-Message-State: AOJu0YxmO7Zs4aQIx/CppGUhyCnwXatESpLHfjt9u1Vm3jjBDPngZ003
	oo8rgVat4sVnvH47mDOo2chYZ1tgc2l4UXDsoIKQwCUPYkKmRhVs9Nl0UFjRdg==
X-Gm-Gg: AZuq6aJM4qQJ3DAjHDHg6LukKVzuoCJOvuN9ZG1WIhEUGeimnaCkOh+oT88zJo+u9iO
	c7nbQHKK2+WmPbKjLTyZj9owYMNlGFuOIGM26pvA8eL1AuOP5IasfguOvOkOGQ/7Oy82ISJBkeQ
	nkhwVzlGX+yHUzsL5dp1nu80JW1FPCkIJbYGPet2aSGXmmYeRq7xdDv80RW3a4/oETYAn49zW7M
	niEe56JGkHaR1fGVBFyDv9o+GMSEt4xZniJASuhLtHfrxzcMZC9nmJlRlsSuEVSyTYqsJcxX8fr
	5FRuXU9I3AO4VM0fG0wEmShY1Dw0ueaSTjSpI5A3d1CMiZEeqOFtgn3g+jnPdhtwiejPFy/L9pj
	zPWSBvddoLMQrxyLONXnpbw3AZDqrZGjLq62vpgEORMYI7Jh//0ZGafdlrp9ufcL2n1hRPMBOLM
	DpF4876h60ieo9ZHBVPXsaQaH4z19X/g0PArFR2728HGRkQZfMnFdgBQ==
X-Received: by 2002:a05:620a:4713:b0:8c7:17b3:ae1a with SMTP id af79cd13be357-8c717b3b606mr102936385a.45.1769604400676;
        Wed, 28 Jan 2026 04:46:40 -0800 (PST)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7b380sm180245685a.10.2026.01.28.04.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 04:46:40 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH v2] rbd: check for EOD after exclusive lock is ensured to be held
Date: Wed, 28 Jan 2026 13:46:21 +0100
Message-ID: <20260128124623.970785-1-idryomov@gmail.com>
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
v1 -> v2:
- refactor to avoid taking header_rwsem for IMG_REQ_CHILD requests
  unnecessarily

 drivers/block/rbd.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index af0e21149dbc..8f441eb8b192 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3495,11 +3495,29 @@ static void rbd_img_object_requests(struct rbd_img_request *img_req)
 	rbd_assert(!need_exclusive_lock(img_req) ||
 		   __rbd_is_lock_owner(rbd_dev));
 
-	if (rbd_img_is_write(img_req)) {
-		rbd_assert(!img_req->snapc);
+	if (test_bit(IMG_REQ_CHILD, &img_req->flags)) {
+		rbd_assert(!rbd_img_is_write(img_req));
+	} else {
+		struct request *rq = blk_mq_rq_from_pdu(img_req);
+		u64 off = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
+		u64 len = blk_rq_bytes(rq);
+		u64 mapping_size;
+
 		down_read(&rbd_dev->header_rwsem);
-		img_req->snapc = ceph_get_snap_context(rbd_dev->header.snapc);
+		mapping_size = rbd_dev->mapping.size;
+		if (rbd_img_is_write(img_req)) {
+			rbd_assert(!img_req->snapc);
+			img_req->snapc =
+			    ceph_get_snap_context(rbd_dev->header.snapc);
+		}
 		up_read(&rbd_dev->header_rwsem);
+
+		if (unlikely(off + len > mapping_size)) {
+			rbd_warn(rbd_dev, "beyond EOD (%llu~%llu > %llu)",
+				 off, len, mapping_size);
+			img_req->pending.result = -EIO;
+			return;
+		}
 	}
 
 	for_each_obj_request(img_req, obj_req) {
@@ -4725,7 +4743,6 @@ static void rbd_queue_workfn(struct work_struct *work)
 	struct request *rq = blk_mq_rq_from_pdu(img_request);
 	u64 offset = (u64)blk_rq_pos(rq) << SECTOR_SHIFT;
 	u64 length = blk_rq_bytes(rq);
-	u64 mapping_size;
 	int result;
 
 	/* Ignore/skip any zero-length requests */
@@ -4738,17 +4755,9 @@ static void rbd_queue_workfn(struct work_struct *work)
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

