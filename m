Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8D9348C41
	for <ceph-devel@vger.kernel.org>; Tue, 19 May 2026 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232120; cv=none; b=HHEUIR+Gt/YkHSEB/9D4KdpOa+gryHrqAQCVzz7CdehBRytcsCEBKpYYqSjHZeoKcpZUliDb7OB5HKlGDgsDEhVjvmVRtx1A1ehXY2LIDl650SGf5zkqvfqnWLKgYUy4OLRagqmrVyzMkfXQTQwdZS+7cGpb9KOTX34AgeW4uVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232120; c=relaxed/simple;
	bh=vvuYvgl5r2+zMO8mmoYUux2FBoyvwR0nDQ4syjyVulc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LuJQn5lAT5d97R2zMFTXjOEEBB2iKb+fgt3uyGZI4LXKb4x7/4keJNu+ps4FxzEiaK0mhkd0KAsgUWSTDw4iU3bJynrCpTBCQhxhLOf6hyHYdu01ElXD/gxj9Kl3IDcTgxWLWZS2GIz/uyOPMvlY94sjQqTY+fkVzSHGdymLbF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rN7u82F2; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rN7u82F2"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9125d2a4d36so283933685a.3
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2026 16:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779232118; x=1779836918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f21qADPAPZFamDgHRSYoJCFxBmiy2bsMq/RgMiD6Z9I=;
        b=rN7u82F2wx5ct6pvcOhE4lzwmrpMvyyI977U5k4FXGQkZ+1INiG2ZgskV6T6H0pLFm
         2vVE6TIOtvYXmI0tGMqcuEPFUuEAIoBOONuHFDRx2F9NGxtvEvs2J66st0EUNuEz8802
         HcWPPUdWfHltkbnQlmivEBO0ty19iTIybjvpnRkW3FksZtGF+UaYGX8KtRqI0PqqHaCK
         hfBLXTaMelIKh4OTvTSk96bL24w55BeZ3IGgPAteKUHmrMUWZSFwiS0UtdkxNgkMBg4/
         dm4+gnGTgt2qzDFhyHLlgkaso9MeDMdBt3kqkKxKtY/1NQG/YSz+zRWt7kl9ESUc+6EU
         ISTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779232118; x=1779836918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f21qADPAPZFamDgHRSYoJCFxBmiy2bsMq/RgMiD6Z9I=;
        b=l8MgawjqWWGnQQXR5cOVnZXBIflnSbLejpL51rFT2o7YbwWlaMWUfLlLj56ld6qIZ7
         Ah+9GklmVMQYXazLAIJRFMfGLK2c93ikZGFacLIZdBekW9Zt49rBJ57dRllAVV3B04Lu
         UxDC4OreQ+kwVuvSVi/fClIhyJCsuv4ESXrJpzumMxpGXDbWEnDPatPSeGuZ+9pn9g5J
         pfd3XcqVj7EwsVvlqC3ueOoeO0kurxzsVtPBJq4iU9ave6RonRUT6PjWL8WCLUL23Y/2
         q0AxsYd4SIJ5oWv4dhypXeWx/LJgyW5G94fZQa7ojQVOKudHDRn9Sw+7zj5139JyUSin
         5qAg==
X-Gm-Message-State: AOJu0YxSwl+3w71RYTJh2ntqvgGLH+6h08MYuj+N0tDzFdfAGrofisB5
	pRdM3q7TXS29wfkQKu9tW6H9nrR4QkyWVaNnDrKya85qlUCWVXKV4jx1unyu7Q==
X-Gm-Gg: Acq92OGMd9NCwxCbxTllYOx4+bx4eqVy2gU8DvB+UlNpqfSSFwZpmWx8JQyrV/mpTMj
	cRRyG+ACq7F/7l7+uCKQPbVtzlAVT0mhdsRURPNqfd03T7rOPopwzuV5oQn2eMjyhG2RHbhSxNr
	uNxNKklrksjOUTAwjkbOCDEJTX1Vpb0Yj1I0OH/DBQtXYzwBOX16kNGExlem6RtxjZyW3UL37hK
	TPUevkFMzuY0JCkq9QDvxwvekIZpYAMkEL5aJFI55pFTiqCw1JSI+4O2lj3Eiyj3IV0QIvl/g4G
	3fbbMZ3s7itNuiPxjvdlKkuXSP3+hDbYtbmzgU9NCza5O6+IV8Qv3RkQSpdzwe477tJ/GIzScBL
	rDjpSqNlf7Eg5sIkVUuGDe1FWUsfTKU8CPtzSyGGzpKwgphir5bPZ7e+epVqJkfpmH3Yy05/W9N
	b7+KaTkDxzbKcafJLw3khXYMw1XTKKkV/1o37zsYB9aKxz86AmPbIc1k8ukImDWmM2T4C6uZBS9
	CghbGC1FcisWshHoNKhSr1wMQ==
X-Received: by 2002:a05:620a:2546:b0:910:9d9c:c02a with SMTP id af79cd13be357-911cf4f8803mr3287783185a.42.1779232117779;
        Tue, 19 May 2026 16:08:37 -0700 (PDT)
Received: from zambezi.front.sepia.ceph.com (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf35843sm1972463685a.38.2026.05.19.16.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:08:37 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH] rbd: eliminate a race in lock_dwork draining on unmap
Date: Wed, 20 May 2026 01:08:19 +0200
Message-ID: <20260519230820.1459703-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Given how rbd_lock_add_request() and rbd_img_exclusive_lock() are
written, lock_dwork may be (re)queued more than it's actually needed:
for example in case a new I/O request comes in while we are in the
middle of rbd_acquire_lock() on behalf of another I/O request.  This is
expected and with rbd_release_lock() preemptively canceling lock_dwork
is benign under normal operation.

A more problematic example is maybe_kick_acquire():

    if (have_requests || delayed_work_pending(&rbd_dev->lock_dwork)) {
            dout("%s rbd_dev %p kicking lock_dwork\n", __func__, rbd_dev);
            mod_delayed_work(rbd_dev->task_wq, &rbd_dev->lock_dwork, 0);
    }

It's not unrealistic for lock_dwork to get canceled right after
delayed_work_pending() returns true and for mod_delayed_work() to
requeue it right there anyway.  This is a classic TOCTOU race.

When it comes to unmapping the image, there is an implicit assumption
of no self-initiated exclusive lock activity past the point of return
from rbd_dev_image_unlock() which unlocks the lock if it happens to be
held.  This unlock is assumed to be final and lock_dwork (as well as
all other exclusive lock tasks, really) isn't expected to get queued
again.  However, lock_dwork is canceled only in cancel_tasks_sync()
(i.e. later in the unmap sequence) and on top of that the cancellation
can get in effect nullified by maybe_kick_acquire().  This may result
in rbd_acquire_lock() executing after rbd_dev_device_release() and
rbd_dev_image_release() run and free and/or reset a bunch of things.
One of the possible failure modes then is a violated

    rbd_assert(rbd_image_format_valid(rbd_dev->image_format));

in rbd_dev_header_info() which is called via rbd_dev_refresh() from
rbd_post_acquire_action().

Redo exclusive lock task draining to provide saner semantics and try
to meet the assumptions around rbd_dev_image_unlock().

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 drivers/block/rbd.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4065336ebd1f..6c1e7347e6a7 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4565,24 +4565,12 @@ static int rbd_register_watch(struct rbd_device *rbd_dev)
 	return ret;
 }
 
-static void cancel_tasks_sync(struct rbd_device *rbd_dev)
-{
-	dout("%s rbd_dev %p\n", __func__, rbd_dev);
-
-	cancel_work_sync(&rbd_dev->acquired_lock_work);
-	cancel_work_sync(&rbd_dev->released_lock_work);
-	cancel_delayed_work_sync(&rbd_dev->lock_dwork);
-	cancel_work_sync(&rbd_dev->unlock_work);
-}
-
 /*
  * header_rwsem must not be held to avoid a deadlock with
  * rbd_dev_refresh() when flushing notifies.
  */
 static void rbd_unregister_watch(struct rbd_device *rbd_dev)
 {
-	cancel_tasks_sync(rbd_dev);
-
 	mutex_lock(&rbd_dev->watch_mutex);
 	if (rbd_dev->watch_state == RBD_WATCH_STATE_REGISTERED)
 		__rbd_unregister_watch(rbd_dev);
@@ -6548,10 +6536,18 @@ static int rbd_add_parse_args(const char *buf,
 
 static void rbd_dev_image_unlock(struct rbd_device *rbd_dev)
 {
+	dout("%s rbd_dev %p\n", __func__, rbd_dev);
+
+	disable_delayed_work_sync(&rbd_dev->lock_dwork);
+	disable_work_sync(&rbd_dev->unlock_work);
+
 	down_write(&rbd_dev->lock_rwsem);
 	if (__rbd_is_lock_owner(rbd_dev))
 		__rbd_release_lock(rbd_dev);
 	up_write(&rbd_dev->lock_rwsem);
+
+	flush_work(&rbd_dev->acquired_lock_work);
+	flush_work(&rbd_dev->released_lock_work);
 }
 
 /*
-- 
2.53.0

