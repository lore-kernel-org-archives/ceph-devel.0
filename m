Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05ED25B0B7
	for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784519371; cv=none; b=TkGj5JYY9ZgeNLVW+MZg/dXam/ACSz1A8yxLrrjo2abTuuzpXg39/AWFzoyGK2UWkg0WZ4MN3+9QJz/+H6cJVEY61aAwT3VAuB5NMOvcZ0qbRYOKF8RGWF/utRUaDbA2l9RwU3OBVNTYSfWO/rU6srbKQ1O52XxB630xIg1itxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784519371; c=relaxed/simple;
	bh=kir6JiAv6OiNotS/NBmbZrriUiOsqxo9mWwzbHaFv5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjVZeKGvWVx42DXSDzvUEqKpC4Qr88i3DPRsw47e6K4/oXdhgtP693uXChngmyQoF8OT/WFOuHT9ZGZtFj9yxVd6nl1LhbY159iNCdsZd/kc1qY+CefYndR/9hijHU7RAMAFKIIZITy9cca1JQmiDn+/xBVxDFZzylQ8wrgSxjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfkfhVwu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfkfhVwu"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84867f07d63so10795521b3a.2
        for <ceph-devel@vger.kernel.org>; Sun, 19 Jul 2026 20:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784519368; x=1785124168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLVd1C7N0pqHmxO4TslxwiJZdDfXSAWMp+9yvVkftLk=;
        b=FfkfhVwumgkqzFVPfN3jcvj92rbZmhQN2P1VKfdL5gfgB4PPuaXAgSosXQWG9mUsli
         GSrIJsQ7lqhA1x1RVj/blYOx3IeSYX9N9jkVq6Qfi3wsOexOFA8xLru6QBEVB5sHO/rY
         /4TxLrV7Fe7GtzD5eWFys1M/D0hU3ZLRLJuT7CQPbR/m/p1GVXYyo3JyJXmzP1hdIcmw
         fc5mdGCriYZNT274elwhvOLaOgggl3L2TcWnkD2e0bKsAmldjJVr6Q8QlRTfVJ1D3uI4
         GFN1d9tOYdve2xXHcV/JV66Z3JQLAqn2emSPO8Z/nV5BsETwhT/kzWDQvPU+7X6GemJ3
         Y4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784519368; x=1785124168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLVd1C7N0pqHmxO4TslxwiJZdDfXSAWMp+9yvVkftLk=;
        b=scLn0mxYs7QGrFQGsAvP6/1nKFhxXuK5WgVMIMP0q4mnaSPHJ1TW/gCdkhiyqP7gZ0
         TQSbgpVVXO3iXrjl0YGTFWetQKJ9FNaD8UbyF7Ra1eIvuz7JXdJW4KX+dI0xcpkw+t1i
         bfbfggSGA9j8E9inqXOmFousEU0dda00pIqPNDewaWbPls9C7PQ6cbQf7K4BXhp2Ac8Z
         fxvuDA4F4k/qFiFn1jR85FsSjub9Njb1IDmeITfmY0mG4fnH3ShpgJuqX+3VGFFV8o8c
         U3/mRMzgzINaAo83t7rQFHMLfWvwbG3Zg0tFh+7N0znnai7Fm8R1gvcvD528yAfpIDu8
         2VSQ==
X-Gm-Message-State: AOJu0YzpG42P7yeFeEoN91ixVOkYrT/jFUIzTp92WLqRcpXUOQ3wc/cM
	FQA8XlJUtqAuKq/v2Uwy0uCe7hLLWSruh5/CnSZmHuiS2zXDlqjhXiNlxOvVznZTS1U=
X-Gm-Gg: AfdE7cntwdi13pKGQZ3slQWh3gczCBd/Pn8Cj8cOZ78uc2Y1gBI+hZeqorsRTtTIicW
	+f6Mj1CndsO5fHIEG4ZyMeKfPe3PEgEWNLrAtyP7ddYfNOwo5ZjdKXB//tBrzyRfpBFT5zow4wU
	j2g/pID5pqcx7c6vJH8tLG8KHH7hxWfcMq77IVzwFR1fznh8NP576vkFr9ttlBl7oISokZaa7du
	zOw+N440u0Y5ykSS3AyB6+drfIKGNm1e61ermSmT5F6GpqyfwhlSJuUjI/n2BbViZZoSBVlvEqf
	jIGVhvD9hc7sNWLLnm5hKzX+CxRAX/9wGktsg5T3bpc/dh+r9n3rC5mXUSKWGw4dfVTdAUTHT+l
	d5KX3ZMstEAA0q6QRGfd6YQaO97LBYwc/MyBja2HVH4T6qdZcrNqEhsL0JdqFkdIJ5Yyr9oZDwf
	EYuobzUZiKvQFmRswMuw==
X-Received: by 2002:a05:6a00:6ca0:b0:848:2f7a:2e52 with SMTP id d2e1a72fcca58-84c294df7b6mr11491219b3a.65.1784519368200;
        Sun, 19 Jul 2026 20:49:28 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e3f6sm4813498b3a.44.2026.07.19.20.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 20:49:27 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	sage@newdream.net,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH 1/1] libceph: unpublish osdmap before destroying it on stop
Date: Mon, 20 Jul 2026 11:49:06 +0800
Message-ID: <bbcdd44d07efd11c7211195b6302b179918cb253.1784371311.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1784371310.git.xizh2024@lzu.edu.cn>
References: <cover.1784371310.git.xizh2024@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

osdmap_show() takes osdc->lock for reading and then walks
osdc->osdmap while formatting the debugfs osdmap file. During client
teardown, ceph_osdc_stop() closes the OSD state under the write side of
that lock, drops the lock, and only then destroys osdc->osdmap while the
pointer is still published.

A concurrent debugfs reader can therefore acquire the read side after the
stop path has dropped it and traverse an osdmap that is being freed or has
already been freed.

Take the osdmap pointer out of osdc under the write lock before dropping
that lock, then destroy the saved pointer after unlocking. This makes the
write lock wait for any current osdmap_show() reader and makes later
readers observe a NULL osdmap instead of a freed object. Also make queued
OSD map messages return after taking the lock if teardown has already
unpublished the osdmap.

Fixes: 76aa844d5b2f ("ceph: debugfs")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/ceph/osd_client.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ff00070c181..70467eede336 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -4145,8 +4145,11 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 	bool pauserd, pausewr;
 	int err;
 
-	dout("%s have %u\n", __func__, osdc->osdmap->epoch);
 	down_write(&osdc->lock);
+	if (!osdc->osdmap)
+		goto out_unlock;
+
+	dout("%s have %u\n", __func__, osdc->osdmap->epoch);
 
 	/* verify fsid */
 	ceph_decode_need(&p, end, sizeof(fsid), bad);
@@ -4238,6 +4241,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
 bad:
 	pr_err("osdc handle_map corrupt msg\n");
 	ceph_msg_dump(msg);
+out_unlock:
 	up_write(&osdc->lock);
 }
 
@@ -5268,6 +5272,8 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 
 void ceph_osdc_stop(struct ceph_osd_client *osdc)
 {
+	struct ceph_osdmap *osdmap;
+
 	destroy_workqueue(osdc->completion_wq);
 	destroy_workqueue(osdc->notify_wq);
 	cancel_delayed_work_sync(&osdc->timeout_work);
@@ -5279,6 +5285,8 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
 						struct ceph_osd, o_node);
 		close_osd(osd);
 	}
+	osdmap = osdc->osdmap;
+	osdc->osdmap = NULL;
 	up_write(&osdc->lock);
 	WARN_ON(refcount_read(&osdc->homeless_osd.o_ref) != 1);
 	osd_cleanup(&osdc->homeless_osd);
@@ -5290,7 +5298,7 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
 	WARN_ON(atomic_read(&osdc->num_requests));
 	WARN_ON(atomic_read(&osdc->num_homeless));
 
-	ceph_osdmap_destroy(osdc->osdmap);
+	ceph_osdmap_destroy(osdmap);
 	mempool_destroy(osdc->req_mempool);
 	ceph_msgpool_destroy(&osdc->msgpool_op);
 	ceph_msgpool_destroy(&osdc->msgpool_op_reply);
-- 
2.43.0
