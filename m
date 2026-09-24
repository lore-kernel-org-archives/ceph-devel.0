Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48BC4A0F07
	for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263858; cv=none; b=j7Oel3KQldXUzjdCiWeNG1l/aOOK/ku7aE0ThRIHhfDXKhsBajqGufgun0m2n+sFVxxEOdiFgYhAIirHF4U/PSXld0hdfdfUliZxbjb0+OhrCERo47KkbrwyT654eL7CFkfOD+Q2ilOYZJvCTKffjZ5/yzPlTj9pt46GX8IFKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263858; c=relaxed/simple;
	bh=HcG+gf3kSIuA0s5TkzCfaMPDVJeDLtQgHdrgfTPrGJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JH9FLKBKJ0MuYG+afhpJNj9lVxLBM0kk5XhZuOVqoRR5de2kTMj8TbC71rWufWkYHnkrlu7LfKZvpNsyeLhYhGmW7rh5U4D12z6iY59cRtg66mjIH6SQFS0JyvetolNbt1Z5+BFDnFsC+8xv3GIc8fBpgxhZVrLVXef6zdlP1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EdMJ1ztr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQ2RWZvN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdMJ1ztr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQ2RWZvN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790263855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
	b=EdMJ1ztrFmZGv0oBBo93nA8MEaI+PC5M3kqSSgbRnRPzMEAbU98jdfvCodo4IEYrYbVL+K
	Po0tdQ84CaCsLa6giru2SgcZA+rOCytW6XbURz0RSsMNR2MoAFITqsO6/KmyRPvSJPiTGa
	CgtX4NL2901VpVUDQL/kTbdpJv14dN0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-i9u1Je51MLq1Q4tOB86hUQ-1; Thu, 24 Sep 2026 11:30:53 -0400
X-MC-Unique: i9u1Je51MLq1Q4tOB86hUQ-1
X-Mimecast-MFC-AGG-ID: i9u1Je51MLq1Q4tOB86hUQ_1790263852
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a9b7c8f4afso2245950a12.0
        for <ceph-devel@vger.kernel.org>; Thu, 24 Sep 2026 08:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790263852; x=1790868652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
        b=ZQ2RWZvN+FI4bPUHnrQ6S529XFyrEm2ubXMbu5aRYXYju0okXLN1v2Fl+mIAPIfiYs
         6NuLZSq1+J4zEFxYPEtLELq7HqEJJZ+Z2eosrV1plUh7E6ockZBo2vEC0umv8hoNtdti
         jcGvyyxt1aCMHmxEddQW4+Ddn+h44+aAJEdQhU+0kESeD33DlYWGd8tDAOQ3wmX+KX4C
         6uo4kzJCYQIZscFVPmpywHIwQSE18GMBXrgXAGLj6aTuVpWbQLG+khARVRJEogcK8Sq8
         P3cxxxygw/RNBWhI8l+0JobRJv13Gkqo5lBzzmzDRxk1EE9BHO7t9352SIPoTyHZUP/t
         YUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790263852; x=1790868652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rFjkX1ePuoE6/06ofbLsY2fGk8ZgL+W00HFzIeDvwug=;
        b=yzo9AasnK2Q+Ul3sSd1ags4jq26u4avenSet421jJPdj1pLYeAg09q7DdbyieTTtIh
         AMnw57PI7SJxB8Tg7MWyHRJiJNhSd/zYRp1CNJyYxU4WKcf9Rqe5L0NhZmd81ZRIJtz4
         HWz9CcUlMB5Ui1lj74TVHLlyLa8V09P1nNp0tLEWFGDIkMCKbQT3e59m4FA5V0zTVBc1
         FlanSDu/Rgy2lj6mfGIGc0n+8Itw4cOoxcOL7sRBZIQTkzHFz47d2GOFPPkB4WUNef3m
         iSjdFysHVeb+DE+QkEq+FNvIyJPtNbfjkiNn07avLay0oWS+FtA4RnIXGpJbv8kKEw2Q
         npog==
X-Gm-Message-State: AFuF++kwh3g3z/i4bBnf/FTo+5p810brWfu1mSX56g0SGC+Sg1XoIkk1
	OgZOtogGWtQPQHgi2pmldJL2nI/4niccfBrfhPC4RnsxfnhThlPqegQ5hP+pS3BHaS0f31PMHjc
	jjqTb8dcDs9fz5HzFXHAneBG0NGATKennH74y9F+QlXsSf8DBYvXEPUmYH9jyPnpq/9QFyxfCiv
	Jbae6bn7fhKvtPMTyQ/mzqoHVxmXf+SunghN7yoV5lxe86+HfCJg==
X-Gm-Gg: AYBFou07BOPvqUBjr7d/Y0/nWKGplqFPxgNG6OAMCBrxhlZlSJj+wLg670m7iq1zAFs
	G7K/d04/BydBLc7Yy5KF/vm0kxH1ZTrmsDw08qLHd504w6Yw5/UXKq5GDNiyyJPdjadM1rBm4SB
	ZlOh2ayP9UJzMeVHfDaisHKuypcOBx0G1TJWS7aW4nEFdhN5x6Bdjk+18sRI22WNUGBniHrAUYj
	H8is2hjRT7YUNX4vkLoxobuK2Oeg9tEiHii265sa/DdHIQGPCqnBwF1UNQ7AHpJf8qQ9GRNKAgP
	cXzz46kWHW1rSPpkTUAXk225E0bEZh7bw1YcmswOGGagXsqVYdbl1JuKrLtxUEZNPXdjZ3YavTR
	OXTZwKnIFY4qUdx3xKlA8/ttssPpz4jcJEyO5sTcMM09WzGiwESVtgo8XONbooWtB6XRADuga5s
	AcQ2oBDFbajUBMlg==
X-Received: by 2002:a05:6402:454c:b0:6aa:b357:5e80 with SMTP id 4fb4d7f45d1cf-6aac8f00a59mr1972416a12.1.1790263852308;
        Thu, 24 Sep 2026 08:30:52 -0700 (PDT)
X-Received: by 2002:a05:6402:454c:b0:6aa:b357:5e80 with SMTP id 4fb4d7f45d1cf-6aac8f00a59mr1972385a12.1.1790263851818;
        Thu, 24 Sep 2026 08:30:51 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aab386e5b9sm3941908a12.8.2026.09.24.08.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:30:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	xiubo.li@clyso.com
Subject: [PATCH v7 03/14] ceph: add BLOG page-fragment allocator
Date: Thu, 24 Sep 2026 15:30:33 +0000
Message-Id: <20260924153045.994784-4-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260924153045.994784-1-amarkuze@redhat.com>
References: <20260924153045.994784-1-amarkuze@redhat.com>
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
 fs/ceph/blog_pagefrag.c | 62 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 fs/ceph/blog_pagefrag.c

diff --git a/fs/ceph/blog_pagefrag.c b/fs/ceph/blog_pagefrag.c
new file mode 100644
index 000000000000..20f57082fdab
--- /dev/null
+++ b/fs/ceph/blog_pagefrag.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BLOG page-fragment allocator.
+ */
+
+#include "blog_pagefrag.h"
+
+/**
+ * blog_pagefrag_reserve - reserve space without publishing it
+ * @pf: pagefrag allocator
+ * @n: number of bytes
+ *
+ * Returns the current head offset without advancing. Caller writes, then
+ * blog_pagefrag_publish(). Single-writer (per-task).
+ */
+int blog_pagefrag_reserve(struct blog_pagefrag *pf, unsigned int n)
+{
+	if (n > pf->capacity - pf->head)
+		return -ENOMEM;
+	return pf->head;
+}
+
+/**
+ * blog_pagefrag_publish - make reserved bytes visible to readers
+ * @pf: pagefrag allocator
+ * @publish_head: new head (offset + bytes_written)
+ *
+ * Store-release so a reader that observes the new head (load-acquire or
+ * under pf->lock) sees the preceding entry writes. Single-writer.
+ */
+void blog_pagefrag_publish(struct blog_pagefrag *pf, unsigned int publish_head)
+{
+	/* Release-store pairs with the acquire in readers (pf->lock). */
+	smp_store_release(&pf->head, publish_head);
+}
+
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
+ * blog_pagefrag_reset - discard stored entries
+ * @pf: pagefrag allocator to reset
+ *
+ * Callers must ensure no writer is mid-reservation. The pagefrag is
+ * single-writer and writers do not take pf->lock.
+ */
+void blog_pagefrag_reset(struct blog_pagefrag *pf)
+{
+	spin_lock(&pf->lock);
+	pf->head = 0;
+	spin_unlock(&pf->lock);
+}
-- 
2.34.1

