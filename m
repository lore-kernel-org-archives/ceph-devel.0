Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE49427F9E
	for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 12:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230598; cv=none; b=ZgVuDuzJ2ugDK23P4v1VEqzU50jlI2mxszDZbu9mqqgGvIRi+lYDUuBxNr34t+SnB/l4YJdo2V4NVu8A/FytojYydNJEInILzpY+kTACR47TPYFspnB1dxRYcukOYHnIVO1uuzFwECuW5Ftprt36wAFFk8ukJH0dg1XOQMGPbRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230598; c=relaxed/simple;
	bh=cOOy60jHpyzfHLgfV4jVM6AwWjutpc585LqkyBo4xyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CvBvcaHBKEZZGruEualauAHoZoSC6rcuRaqowMG/YdGJSvI6EGr7Nxo+JpdFbBZIwGkVoIFAJeAr6BVT2mTHiJRGzDUgYHTl7XE57Z5cswlXZ705ThGUNf/BBaGtMBNfKPVpnXj7EDT/7MScxoE/qmSDaQolErM/mJv9qsKfJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QfBCRvEv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=r3oZd00b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfBCRvEv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="r3oZd00b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787230595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/gKNZIZuOeiWQi6d82SfRRkDvQJsnJ9sC/NPWY9g7c=;
	b=QfBCRvEv3x7UA84dl6U9/zbq/jjEBmfd5XOigfW8q1BME3f2pbzLpBNZKSRkW5Qa7GOuMS
	QoJ5NDU9W4P+TQEc+OdFh5sq0N4vrUijr5bP0X9tjLc9ni643zzxRT31G28Svs1bXayVnR
	Ruq2Pf3FtrT3Z8cqTlUjrqNl059v2/w=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-XoJPxwrqPY2omfQ2kRkD5w-1; Thu, 20 Aug 2026 08:56:24 -0400
X-MC-Unique: XoJPxwrqPY2omfQ2kRkD5w-1
X-Mimecast-MFC-AGG-ID: XoJPxwrqPY2omfQ2kRkD5w_1787230583
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-69848bef5c7so1748076a12.2
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2026 05:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787230583; x=1787835383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/gKNZIZuOeiWQi6d82SfRRkDvQJsnJ9sC/NPWY9g7c=;
        b=r3oZd00bZHOWQe5RhnhXiu7kwpeWYoRnJn1nCtbz+HAhhs400ny3DsBsEwyBe+euni
         aAe38K9sqxLY716FwvzDDpKJ1iiSv1VYxJVaYPAU88xCRAino+Zm0GoC9gvyV2M9S7Ob
         1jb/uDzIKwnDe5DHPdZLllHugJkOeZdjnfwJNKOV/YAANdbKO31KdpEPcl40l/uAW5vp
         CgQcvloEYQDpsn6gr/IFPNi0UGSQZdH57X/g6e2rwQoUb4EU5QF+ug7tsYZJcmVHZJ7J
         yjYxBeSwhVaoNkwlpmtdISbzTmDKCzCZPzPdvQogl+BUnPhjmB/8pjHzF+tXbY58tw90
         Xw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787230583; x=1787835383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/gKNZIZuOeiWQi6d82SfRRkDvQJsnJ9sC/NPWY9g7c=;
        b=oxgEwS5rMHQd9U6scl2Qp8Jh2BOy8rN3a/7myrL6cy0qi0lWME8DCeNnDxhQKJqWHb
         /DEm/rUWaFjBvrX8/xJgKkg9vDQkEGIxFOFoSWZGz4l3JXs5wJ3c87UkzV9HyAXuT/dS
         G0PJc619hO30amFV9MKB6l6Fg3Oy8FAE1ttwB9UA4f3p3YPw4E/FGerRTEG9YExa/mjt
         JOje8So44p+9P8SNDQm/NvAWAkbI5H9WNpktZo/CzH2bjYitAON1ISNRTWAqdiIFAlRH
         YP3/n1PCbOfGdLTW3N4Y/rbnbC5coIIyuV0EjaQY6iEcwOGsyyasuJGvtAXRNdz0lkTV
         13dQ==
X-Gm-Message-State: AFuF++mI7S//+WpjguPZRywowh70Yg+BWGiXvTpha2nunaQ9gXzgwYgb
	A3LYMHdgbyevN/FaZTZXQLTfX2YvIezharzpU8PZZOy74KuLklldcYD47txXl+nP/cRkgboIrAD
	zhvRCwGNkiRuTBVC/30FXht/WRNxOQmoLXpinjK/MyAl51Hqu2yMPi8yHlo68meCmbf3dyN/PFi
	XFoYm7qU7DViVOTmhrE7pzCGRpTmHChheQhn1Gm3x6UbW4oKt0lQ==
X-Gm-Gg: AR+sD11tgHl8kmkyAwBAIChGSIcUvF2NZWkEL+WQpgUjuHAnyhpc5O/WaIRentNngqy
	M8VDWGkf2vGIRqNMWrUN1IzYLeLI7hmndAGLYbFKVPmQp01+PolskWNRjR/coYrKutWZpHXTd/V
	6opw78sLUQuQNuXnz95lQiTafDIDORTuM1Jea5JhrsST+MksYKoJxFAsc/76az2lD2vSX91Xo7B
	PeA0HnOqAYF+dM3GSQ9/u1MfhWhiBBpfWShQ19lpFAAH3O/raeqglodkPsOes5xF7esIDaMgKTj
	/HlW9+sHqRFT50t7kKJkH/xE1d27mhdauhDn0qBjMQ5vKVuRzZNErEvSjYLiqPru1D+UIq8Yk1H
	zkSAqX6uiwamQGzJiItowI+uVykxYVr2DEw==
X-Received: by 2002:a05:6402:2105:b0:6a3:691a:9d82 with SMTP id 4fb4d7f45d1cf-6a403296b57mr8399804a12.3.1787230582845;
        Thu, 20 Aug 2026 05:56:22 -0700 (PDT)
X-Received: by 2002:a05:6402:2105:b0:6a3:691a:9d82 with SMTP id 4fb4d7f45d1cf-6a403296b57mr8399739a12.3.1787230582332;
        Thu, 20 Aug 2026 05:56:22 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feec9d46sm2129827a12.1.2026.08.20.05.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:56:22 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v3 03/14] ceph: add BLOG page-fragment allocator
Date: Thu, 20 Aug 2026 12:56:06 +0000
Message-Id: <2be13f3f5bdc2e349ff75fcdeeda2f16ef375dde.1787229471.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1787229471.git.amarkuze@redhat.com>
References: <cover.1787229471.git.amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add blog_pagefrag.c: lockless page-fragment buffer allocator for
per-task BLOG contexts.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/blog_pagefrag.c | 84 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 fs/ceph/blog_pagefrag.c

diff --git a/fs/ceph/blog_pagefrag.c b/fs/ceph/blog_pagefrag.c
new file mode 100644
index 000000000000..523cb2d0ba63
--- /dev/null
+++ b/fs/ceph/blog_pagefrag.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Binary Logging Page Fragment Management
+ */
+
+#include "blog_pagefrag.h"
+
+/**
+ * blog_pagefrag_reserve - Reserve space in the pagefrag buffer
+ * @pf: pagefrag allocator
+ * @n: number of bytes to reserve
+ *
+ * Checks if there is sufficient space and returns the current head offset
+ * WITHOUT advancing the head pointer. This allows the caller to write data
+ * before making it visible via blog_pagefrag_publish().
+ *
+ * This is lockless - only one writer per pagefrag (per-task context).
+ *
+ * Return: offset to reserved memory, or negative error if not enough space
+ */
+int blog_pagefrag_reserve(struct blog_pagefrag *pf, unsigned int n)
+{
+	if (n > pf->capacity - pf->head)
+		return -ENOMEM; /* No space left */
+	return pf->head;  /* Return offset without advancing */
+}
+
+/**
+ * blog_pagefrag_publish - Publish reserved space by advancing head pointer
+ * @pf: pagefrag allocator
+ * @publish_head: new head value (offset + bytes_written)
+ *
+ * Advances the head pointer to make previously written data visible to
+ * readers.  Uses store-release so that any reader that observes the new
+ * head value (via load-acquire or under pf->lock) is guaranteed to see
+ * the preceding entry writes.
+ *
+ * Single-writer per pagefrag (per-task context).
+ */
+void blog_pagefrag_publish(struct blog_pagefrag *pf, unsigned int publish_head)
+{
+	/* Release-store pairs with the acquire in readers (pf->lock). */
+	smp_store_release(&pf->head, publish_head);
+}
+
+/**
+ * blog_pagefrag_get_ptr - Get buffer pointer from pagefrag reserve result
+ * @pf: pagefrag allocator
+ * @val: return value from blog_pagefrag_reserve
+ *
+ * Return: pointer to reserved buffer region
+ */
+void *blog_pagefrag_get_ptr(struct blog_pagefrag *pf, u64 val)
+{
+	char *base = (char *)pf->buffer;
+	void *rc = base + val;
+
+	if (unlikely(rc < pf->buffer ||
+		     rc >= (void *)(base + pf->capacity))) {
+		WARN_ON_ONCE(1);
+		return NULL;
+	}
+	return rc;
+}
+
+/**
+ * blog_pagefrag_reset - Reset the pagefrag allocator
+ * @pf: pagefrag allocator to reset
+ *
+ * Resets the head pointer and counters to the beginning of the buffer,
+ * discarding all stored entries.
+ *
+ * Context: Callers must ensure that no writers are active on this
+ * pagefrag before calling reset. The pagefrag is single-writer and
+ * writers do not take pf->lock, so resetting while a writer is mid-
+ * reservation corrupts state. In practice this means the owning task
+ * must have finished its current blog_log() / blog_log_commit() pair.
+ */
+void blog_pagefrag_reset(struct blog_pagefrag *pf)
+{
+	spin_lock(&pf->lock);
+	pf->head = 0;
+	spin_unlock(&pf->lock);
+}
-- 
2.34.1

