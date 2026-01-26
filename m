Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EB429B799
	for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 02:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394471; cv=none; b=pbo/HGzFKNjDXHU0KeGe0YFyWUMM9+2Yb9Mvx3nw4H33H34ZHuL4etE65wlbWQcya+gKciGXLxsi/fKoqKWZI4uOOy6gEpvNLPxvtpK8y50LtXzwmCNHYSCCN5uvirPQ2Qbhhnvd604hJI4k1yYRDRW3/r5Vqn/dpHmqHA2Y61s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394471; c=relaxed/simple;
	bh=VatR0ch63Gkeg6orcr79JOIcdXVHhBuf3GDTixsYryo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPgQ1i7bl141YVMdIjzuJBdSuwAh0Rlj8ZD9h33bySRTtq65MK32OnqCn/CBfkHxioaKtIvyPG5+z7W/Kdq+dOVZzudjaVVHktRPxX/mnxKtduOPiDr+EET2wvhk/AjzZN5+Fz/ZSQPp4Kc6Xu5YLDpvtQQOR4OXgrNoqcGFlWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2NK3B7t; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2NK3B7t"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1233702afd3so5469094c88.0
        for <ceph-devel@vger.kernel.org>; Sun, 25 Jan 2026 18:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769394470; x=1769999270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlGgkhnP8WsVCC5l4yVsMbASFDS3ivVR88ahQjlsei8=;
        b=A2NK3B7tllSfRev1c+ZIycYYlH+zcG0tJB5xrXphu92gEd/Zg4pEd1fAKuV0yA3LHb
         wrTKas/hwkacrnSAbgaui6WGWWnaaqsQIfNUjtLnE5UQ6EawzcEj0qlz5symFaMJBDe3
         dd/5LDszkykvpAt/zXhjhlKx7ksJWiwe1UIoBaNI7V3nD8hJMn2E5uQat1Qxj+4LKOrA
         5lDiu3H14CvbOFlCGSIf4jIdri9q+mB6UOC1pEGA0fX3GX0lufZN0wkeJOzxaAZPZfnl
         +rlFaf06LrC1v7QF9w9cnUFmVAG9sve/yLO2AAfT+VZNJs7X42j02r/QXCTmYnxRf8mv
         KvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769394470; x=1769999270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlGgkhnP8WsVCC5l4yVsMbASFDS3ivVR88ahQjlsei8=;
        b=dg0IJLYL2Ob+eCn3pVid1zdHI3T5ZjA28LQjrd2sAuQtB+K5Y47QbgRDhEyy3zqVqI
         d2/zZrdRNWXKVLBiTzxsrfJbfZOh+j9GarEV5XPNponQQyRtoJpp+rPZ8v4edURAYBb4
         xxdbKmzNVcq2RUrUTYMofREBVQxNq7A/dzqCBYZYiaSH/q71QxiDLAywmFGLadYx4HGH
         dw8i4ytWPm8LA+/0d2rNaIcRzyJnAH1PJvJuP9iylBUy+lOrqYNvfaTMz5eT1pOrZp4p
         su1nP+S98PF47L40JRMh0VsZVzusr6vnbklIxl68gMeETxCSjEycjUzCgqom4Z/9lR73
         IpoA==
X-Forwarded-Encrypted: i=1; AJvYcCVg9nce1jQdZ9tPQ6Fdv04D2+58eekMajpFDgY2YG9/ZmM8w6BvsQLNLvKsUA2Z3ADM0VbmMWXQfC7G@vger.kernel.org
X-Gm-Message-State: AOJu0YyjOTuD2zZUoD3rWSpFyVXAxsc2wMpTJOcvmC+vwpX+LjWmQtpa
	tncTTNPgAARdhXjZfrpvrYMDn1O4c9ggGlWfkGU8bKOlVl2cbCMtQtd+
X-Gm-Gg: AZuq6aIZV1neCbhXypSfbfJ/GZJc9fQ+bOaOTM7fyCaUfPlB3KoYyo7jpp9zEaJDBFx
	qkgqWqhCKIwziphFWXYkARvES7x7z51ZcP6Zh+dy+t2HHULqTBrgNoVpnljh23vdvtauc8dPesG
	xjyP8v3SN3mbbyVy6LEFmuEj0V9HizWriRKFpD6ohNg2vOuheb+6mSovj8Rto5xjOOnMigwzmnT
	f+EyllLw38/aWS3StwcZBmCElJSe2xyZ6h/dpd8pbzxaThslxAASN2oEFjyfwW9DGB566kYNO4e
	itCiA80K35gfsjOt2I7Px4wvMzDk5z251DvMo0XTvLeNCC/WiiiLwvHdLfEWY1JoidSBeQHkpOc
	8S+CLLGedXgXTQyjQJkQ3QE2N13yDMMpdWVdjjq8OiWELB9Y7szp6p1hVZQk14tqaFA5n6KZjR3
	PKF+hWoq6sK1dg5mC7vTtWSFE+11CUGu6RIZccAvauXQfsS/ZfYU+t
X-Received: by 2002:a05:7022:6189:b0:11b:9e5e:1a66 with SMTP id a92af1059eb24-1248ec0542amr1402757c88.14.1769394469589;
        Sun, 25 Jan 2026 18:27:49 -0800 (PST)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90cda6sm15266037c88.1.2026.01.25.18.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:27:48 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Milind Changire <mchangir@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 2/2] ceph: split out page-array discarding to a function
Date: Sun, 25 Jan 2026 18:27:15 -0800
Message-ID: <20260126022715.404984-3-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126022715.404984-1-CFSworks@gmail.com>
References: <20260126022715.404984-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Discarding a page array (i.e. after failure to submit it) is a little
complex:
- Every folio in the batch needs to be redirtied and unlocked.
- Some folios are bounce pages created for fscrypt; the underlying
  plaintext folios also need to be redirtied and unlocked.
- The array itself can come either from the mempool or general kalloc,
  so different free functions need to be used depending on which.

Although currently only ceph_submit_write() does this, this logic is
complex enough to warrant its own function. Move it to a new
ceph_discard_page_array() function that is called by ceph_submit_write()
instead.

Suggested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 67 ++++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 29 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c3e0b5b429ea..28463b9a3bae 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1222,6 +1222,43 @@ void ceph_allocate_page_array(struct address_space *mapping,
 	ceph_wbc->len = 0;
 }
 
+static inline
+void ceph_discard_page_array(struct writeback_control *wbc,
+			     struct ceph_writeback_ctl *ceph_wbc)
+{
+	int i;
+	struct page *page;
+
+	for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
+		struct folio *folio = ceph_wbc->fbatch.folios[i];
+
+		if (!folio)
+			continue;
+
+		page = &folio->page;
+		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
+	}
+
+	for (i = 0; i < ceph_wbc->locked_pages; i++) {
+		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
+
+		if (!page)
+			continue;
+
+		redirty_page_for_writepage(wbc, page);
+		unlock_page(page);
+	}
+
+	if (ceph_wbc->from_pool) {
+		mempool_free(ceph_wbc->pages, ceph_wb_pagevec_pool);
+		ceph_wbc->from_pool = false;
+	} else
+		kfree(ceph_wbc->pages);
+	ceph_wbc->pages = NULL;
+	ceph_wbc->locked_pages = 0;
+}
+
 static inline
 bool is_folio_index_contiguous(const struct ceph_writeback_ctl *ceph_wbc,
 			      const struct folio *folio)
@@ -1449,35 +1486,7 @@ int ceph_submit_write(struct address_space *mapping,
 	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
 
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
-		for (i = 0; i < folio_batch_count(&ceph_wbc->fbatch); i++) {
-			struct folio *folio = ceph_wbc->fbatch.folios[i];
-
-			if (!folio)
-				continue;
-
-			page = &folio->page;
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
-		}
-
-		for (i = 0; i < ceph_wbc->locked_pages; i++) {
-			page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
-
-			if (!page)
-				continue;
-
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
-		}
-
-		if (ceph_wbc->from_pool) {
-			mempool_free(ceph_wbc->pages, ceph_wb_pagevec_pool);
-			ceph_wbc->from_pool = false;
-		} else
-			kfree(ceph_wbc->pages);
-		ceph_wbc->pages = NULL;
-		ceph_wbc->locked_pages = 0;
-
+		ceph_discard_page_array(wbc, ceph_wbc);
 		ceph_osdc_put_request(req);
 		return -EIO;
 	}
-- 
2.52.0

