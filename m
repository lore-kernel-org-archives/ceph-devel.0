Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E023EF670
	for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708405; cv=none; b=lQ9/40cr5N1B636ClVH4JwDMfTJfhJvUvmiL/9eejvMoHZLMo8vVRp9sKtOPEmVepUR4cyP65FwX1TxXMla38aRGrKGxA7wz4RQGKmF52X9vhWlLQC5aEObwSBz2l/yxu1GUNo7Ldlp5hH19fDKMFRP0L22w7/GrHQDM8rQnjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708405; c=relaxed/simple;
	bh=GVoW/u+EUYuUBRuepaFw62HU7Wzhz6FMAoZDVL+RUmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y1WgWuO2u51J9fKfYu3kFXSDGTrEUDGwdEgU5Sgnjp/QJqh9RgczZACD9RV42QLQehIDjiyCpUgIoH6l3XuuWPDeWkSMLqXVaXIxxI5nognXr2HDDZM50THtZMI00NjZcXThW4hWanJEbJ4uaY+AY9Xl5Cq+v9Xgyr7cwW9RLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gC0chjcB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZO2Xdorn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gC0chjcB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO2Xdorn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781708402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCZaY2vdUqdR4Jx3U3Qimevn9xxJRMASlSBclQPdDeI=;
	b=gC0chjcB1aWRglsgzf2FN2p1bcKmMbQS/TGqobKgeHLjUYdxRFBF12+kzp6dI1XFSivI4K
	h+RGH03w7NnLwZa9OYZniURV2Fm98GCxK3Yqz9VBgdiTK/ZL9xzSpRF47I/d8BJoHA88/q
	ghI3brqJ0e+Fk7GOkH8GohcB9fFQaWY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-r7jmmA_DPmKCI9HH7O7DQw-1; Wed, 17 Jun 2026 11:00:01 -0400
X-MC-Unique: r7jmmA_DPmKCI9HH7O7DQw-1
X-Mimecast-MFC-AGG-ID: r7jmmA_DPmKCI9HH7O7DQw_1781708401
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7e6cea6ada5so11994582a34.1
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2026 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781708401; x=1782313201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCZaY2vdUqdR4Jx3U3Qimevn9xxJRMASlSBclQPdDeI=;
        b=ZO2Xdornjfsy8UQkSLwD8dAah10Mo/y//+021orFng0H1P3aUUJvK7TfJXc49QwxJE
         2ENAxBSyGwAwSb0uhMloA1FFukBslefMZXGANEai5GeRIBT7dknXUDbvnfZ4p0bVsQGx
         dBO0O0C0R6KoMpAqaSapjx+dZHNMbdPide5PdXUc0qGy6cjKoy01Y4iy3n8leNySC45l
         cp85cHLANWK6+aEX+doPSUR8aPabvkx/Hn9JfbsQ3g5wfareB45lsKYvocneGK31T08F
         7f96LNaAlDOrfbVby0YFXvQEAihqKBk3LbPq6mEiWMbvEOutgdXdA0Ony5vzhx3lQTdm
         UpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708401; x=1782313201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PCZaY2vdUqdR4Jx3U3Qimevn9xxJRMASlSBclQPdDeI=;
        b=TaeakBwTHUwPkZvH5N6aebs8uf13bjTAw0tQUdEmEbyFEZ1e14/Kj+5Qdl6VWR3w8a
         pxFBP36bhQMpxjZqz80Li6hcJKAFxBflFGboTg8qrvOXxjIbeERy6KZooFgEhNhatgXu
         XWehmo5qO/qW/BB9wD86CCtHNE+QmLFydJw7xEWIDRp2v2UEH4gX3Rie0zZHOU27FW9l
         9AKLZtnNS6riVqj10Y1ab09MvQXY2GrkguSCa0YZCR74oXrWpyrqRFmI6aW/6ZXIqSeE
         nNBlSgtUy5cI6aPjHlYisvc5+XsRFmN8zJlTWyCsRigxb/pAx4sQX4hDtW2WHvGbhzXZ
         yj2A==
X-Gm-Message-State: AOJu0YyxL+deUaiXXjVmaQGJzrd7MBXrk2dqudMez5C/IztqUxA6QlBD
	aMQLMH/k4quyGoCWUb/d/y6ddsIZKC3Gh62dvKVUqVIy+qvmpoy/FmtEHkw/9ekmFnugCEK5zIh
	A6TceX9vRer0YcDss+xA7fxP8W/fwl1DGA4UQbz/WEidK+f7Z36HCOveov/DyX8o2JV3LHRFLnF
	b60xCJ5Bq2S19xA8iS51dRVzKikLcT9BtKSSmfzaizLKNCLS4Lmw==
X-Gm-Gg: Acq92OFibOFLh8irxEwfHfLoKR70IrR62OgK+KH8642ZEit6b0S/m0/slClElAkT4XV
	60oFCJzj+FdK3a64nsxJ4hWu2kVhW0WYiKJQvYmCChc+UZTR0VA3WPvrNPBkRIHNmwwTn++jLic
	8f/mdW86esJA/NZiPLr9PmSulJmUvi7Uotpa6cZVyr3K9Qzwk4/nEWutvEyVxmpOXyWDTbdJqfb
	20jjKBXd/tbfkRf6KBoEQBzibmtXsYu6skFqHOz93ZOe+KLOIAQWsvhqn3a2Rn3qJvsTg74Fljg
	gxMdPxw65/6Fy4pWoF8n/yWzrHbmQ1xAU0KidPryUC0GXEBitm2hUN/RF+hSHqnsTSImJ5ZWbb+
	+Mt/+7eY5xIe5dZxloMnxYUnpl2unDrQ0/DkvmOgtgsFH
X-Received: by 2002:a05:6830:730b:b0:7dc:e30d:6498 with SMTP id 46e09a7af769-7e90b2f086bmr3593129a34.1.1781708400829;
        Wed, 17 Jun 2026 08:00:00 -0700 (PDT)
X-Received: by 2002:a05:6830:730b:b0:7dc:e30d:6498 with SMTP id 46e09a7af769-7e90b2f086bmr3593096a34.1.1781708400239;
        Wed, 17 Jun 2026 08:00:00 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f5a12e4sm10101847a34.6.2026.06.17.07.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 07:59:59 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	slava@dubeyko.com,
	linux-kernel@vger.kernel.org,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH 03/15] ceph: add BLOG page-fragment allocator
Date: Wed, 17 Jun 2026 14:59:33 +0000
Message-Id: <20260617145945.1912736-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617145945.1912736-1-amarkuze@redhat.com>
References: <20260617145945.1912736-1-amarkuze@redhat.com>
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
 fs/ceph/blog_pagefrag.c | 95 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 fs/ceph/blog_pagefrag.c

diff --git a/fs/ceph/blog_pagefrag.c b/fs/ceph/blog_pagefrag.c
new file mode 100644
index 000000000000..bae88ea82aec
--- /dev/null
+++ b/fs/ceph/blog_pagefrag.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Binary Logging Page Fragment Management
+ */
+
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/ceph/blog_pagefrag.h>
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
+void blog_pagefrag_publish(struct blog_pagefrag *pf, u64 publish_head)
+{
+	pf->alloc_count++;
+	pf->active_elements++;
+	/* Release-store pairs with the acquire in readers (pf->lock). */
+	smp_store_release(&pf->head, (unsigned int)publish_head);
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
+		pr_err("%s: invalid pointer %llx\n", __func__,
+		       (unsigned long long)(uintptr_t)rc);
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
+	pf->active_elements = 0;
+	pf->alloc_count = 0;
+	pf->last_entry = NULL;
+	spin_unlock(&pf->lock);
+}
-- 
2.34.1

