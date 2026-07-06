Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCB83AB286
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783353903; cv=none; b=VuoN6KWiZ6AFpYjTxHMKNM1bWWYdHxi/Sj5DN4/r+wjiqCdQj1sWnXQKxsHqxTxKNlgvcWCW74WnwSADmOn/4a3+I9M1RxxE924zMVH1JI0kRs4OWJSyuhKFkXmtXTL51C1pzBNyJPZmjU+MHENxWJO+cidZhCleVcxfuGX1WgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783353903; c=relaxed/simple;
	bh=o3UZD9n+83b8Cku/Gj7UgXynPNJ5nfcVTdTwlKA1WLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WpCbg7rBpu2N+K7yhuGdf0IkWbrk+ytEwwbC0xZEBWz2D3ZXIjDL2sKEgdvfqa7UNbxUdXUMHLwlQkiIRZdTCUShCinlSIcy+spx8iWk/lHz2V5SVqT94/NkLzJEfcR356DVfz8pvog3gqy4x0lSAE9FvjWb2EB2v5C6W4bZY/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aD+xltdf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aD+xltdf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c83474ddso29369275e9.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 09:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783353900; x=1783958700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fAtxCizj1p/QiS5BxHbmhEUHAndkrPUWvJDYWge70Ho=;
        b=aD+xltdfrvHOzZsbizB00kV4WUNpfDlbQIgvVTgW80lqupHbMR16OJDR+nbeONBUmE
         QdyS4LSVIJq5GS15QGsJzrhmnj9gH0tsonOK6Yh7uJDOWnj2BZPOtr4/ZqOuS85eKa5w
         wGLzQamgZbPc5n+vT+uih7DrU5kG6FGAzYDvpZ6s97rhb4FLXFWTVSR61Twc5wYoqtwd
         qZ/+MElj1Qf/SpD0bIGnfKjtlQUk9smbDXMuH+77QlhquZwB8zEqB3WczHm3iDSpvOzw
         zJt2ZXyKEMp1wjAnv/XJTFTohD121k7IwKn9ccN5mCjjVmqo5CcpksJXcGayHPyDTZZ1
         OJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783353900; x=1783958700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fAtxCizj1p/QiS5BxHbmhEUHAndkrPUWvJDYWge70Ho=;
        b=FI6ifeyOP31jfzjj02RFpLuWNjYZ+RftfhGhiKUWTMmM/78StPNYoQKtLPhJc6LQBg
         kB4g6rwKH5gG3Zgscc3Zf7h8m9p082yazNbSFIpDOn7gvqQjIMAyzRD9xYCTxO5ZxEZv
         AKKODcMPMsxPVV5cMw0RO08N1JsKiDESf0hb6cmODORXMA8Mk99e3oTFwwOQgjLEUJxG
         6nhLVcB0qcYHjJUw6E/hDslwYW6VZURdFqJeKxLQFJYVEVjvsD5bKtmuXa3xtAlNUsay
         dxJAgDtd7IIM1MGkkA3AYIEYVlQnkpOCLcSO/s0gXXW9QDH1BTOF9UodkUtQvV3rZgjW
         lVnw==
X-Forwarded-Encrypted: i=1; AHgh+RqLzOEZyIct+rgbNfmBf85AgHz274epdfGfq8qYSOc3rHnx5eng+HcCeCJjS9XkT9j5v3rNW0/B5Fjd@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbi/IeSbGGF9MerwjTN7Du/+HXgfy88ToQ1H6NtBI/gD2GPPxu
	TyFZ28PsX0LICEY8ZOiVnMlwRpjObtopp0B+hPEQT83+KpSWQCaupWK5cNvqyy3ecNU=
X-Gm-Gg: AfdE7cmS6nq2K0LuhkD9wJQi81Qkx5YEuC09rgp+ALft2Kc4EvvFjzkIqbFMvay/ybF
	YCBRQ5c1eiuIgtXCzWOzygGqxO2U3d4ADKwB79zQ/6xD/FxrGEWDi3uWOj2RSDB5f6XOl4xPdwb
	EUQ6PqssNUAt0SD/VgxL5Gs2ryuWmMuB06TKWPBvtjElDkmWe3ZtXuO/3dczITzYqnGbXy1pDCD
	j+sDGG16xSR23ixPPGlkrbYW33UL31rud/P+zVmXJ8h6Xk3G5H6iBKujSeOHY9pWL68Tb7nuJLT
	yookVTfqXSknee+ELHdRtGOlsnETuWry7wAYahiEE+aiP6OiHKpKYfqbm/dVfd7/kBbl7Tl9Iyg
	fIR+TW5wd23m4RZW4rG/yvxsXqjZ+UH6XwaVz0joCcbupN2ezC8oHETONwCdEC/dsyY5iVQrehG
	SLi6jz5wiQkyXhIMqnSI0LBZdj/NKuHSYdtmFltvaG+5cVnA==
X-Received: by 2002:a05:600c:1550:b0:493:bf84:53d8 with SMTP id 5b1f17b1804b1-493df06a55bmr14424035e9.9.1783353899805;
        Mon, 06 Jul 2026 09:04:59 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce12c40sm488808455e9.13.2026.07.06.09.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 09:04:59 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] ceph: Change system_unbound_wq with system_dfl_wq
Date: Mon,  6 Jul 2026 18:04:50 +0200
Message-ID: <20260706160450.370729-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

system_wq (per-CPU) and system_unbound_wq (unbound) are the older
workqueue name, replaced by system_{percpu|dfl}_wq.
The new workqueues have been introduced by:

  128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")

Usage of older workqueues will now trigger a pr_warn_once() because they are
marked as deprecated as per commit:

  64d8eae3f895 ("workqueue: Add warnings and fallback if system_{unbound}_wq is used")

So change the used workqueue with the newer, keeping the same behavior.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 fs/ceph/mds_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 853bf698b356..f3c3116d8b4c 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -5742,7 +5742,7 @@ int ceph_mdsc_schedule_reset(struct ceph_mds_client *mdsc,
 	strscpy(st->last_reason, msg, sizeof(st->last_reason));
 	spin_unlock(&st->lock);
 
-	if (WARN_ON_ONCE(!queue_work(system_unbound_wq, &mdsc->reset_work))) {
+	if (WARN_ON_ONCE(!queue_work(system_dfl_wq, &mdsc->reset_work))) {
 		spin_lock(&st->lock);
 		st->phase = CEPH_CLIENT_RESET_IDLE;
 		st->last_errno = -EALREADY;
-- 
2.54.0

