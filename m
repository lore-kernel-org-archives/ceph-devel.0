Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2293624D4;
	Tue, 16 Jun 2026 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607958; cv=none; b=sftBhUNLIwuxGMdVmUR5AgtAkPqmeo7x8nkruiuEGrJj+yVKCh9px6sa7Dl/o8vF+ZXy0nHn6r1oft0CILlqwkNs5TacZDUhZfwyQZs1zncQNRhClD1DACZ5dLY61pLnkB0EA/OYtGDfMGQuhywVTjUiECDpGXGm8KzI7h6XY/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607958; c=relaxed/simple;
	bh=r1BhSfp3QVOTGpgZX30xiDxRa7EphYe18LodIZbldsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rOcJqKyKnMCQ9XgsEIIsHsv5uPKuAYWOfTnUTS4ZFzxJhPKJynf1NAcRgewc68lh6yRyNyhTlj0hAOsTf0Q2witVV8pH/5DaLBg7/0YwLeicNfpfiW1z0Zgwhh355zHTGviUPrqP36EQHtP9l1tW13intDZj1IsAmr9vF+nRfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjS9KXv4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjS9KXv4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249BC1F00A3A;
	Tue, 16 Jun 2026 11:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607957;
	bh=+gpgVachHS2AwWnMw7Iba5WauFGfbjXMwbGMwiFMNXk=;
	h=From:To:Cc:Subject:Date;
	b=gjS9KXv4tMJfN3DAwEAI8PyLZksAgT9TPLWraW2IEkkF4DwQeRWFJw8+RUTAa0gvP
	 AQlSdjQxHjxG7qnKF1wnYcnAKrnq3X7tMn3QHYh6VKLrcWEoVOj0XWOZYX6i/NfeN5
	 B9+fSTfPkeyd2VFvQrJ+8StBgKL+kjKtTrVy0NgreNOHWJrW7xJudY+8aJnbpEa5XF
	 J9kmvutGXr1k3Y0/bKD01ZjlIjqGfptpQXSmaHhFT8FN4jpAje6lXbO+DzAkFqHxzv
	 uhHrijSeW7nh6NCI+qCY9wA2GISb8uWg99948Tfq2OD4DhXE8IZdrtSo+30PfPpzki
	 WBAUXsh27yp/g==
From: Chao Yu <chao@kernel.org>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] ceph: use fscrypt_finalize_bounce_page() for cleanup
Date: Tue, 16 Jun 2026 11:05:43 +0000
Message-ID: <20260616110543.3188181-1-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use fscrypt_finalize_bounce_page() to simplify open code, no
functional changes.

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/ceph/addr.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1454760332ff..5c7099ba0f59 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -932,12 +932,8 @@ static void writepages_finish(struct ceph_osd_request *req)
 					   (u64)osd_data->length);
 		total_pages += num_pages;
 		for (j = 0; j < num_pages; j++) {
+			fscrypt_finalize_bounce_page(&osd_data->pages[j]);
 			page = osd_data->pages[j];
-			if (fscrypt_is_bounce_page(page)) {
-				page = fscrypt_pagecache_page(page);
-				fscrypt_free_bounce_page(osd_data->pages[j]);
-				osd_data->pages[j] = page;
-			}
 			BUG_ON(!page);
 			WARN_ON(!PageUptodate(page));
 
-- 
2.49.0

