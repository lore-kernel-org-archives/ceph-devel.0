Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E97A2AF1D
	for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394672; cv=none; b=eWhax1TqTwDbaGFD1rP2FVc1bK0GLk42UGVg7cGHmB/UQfYS2Hc80h0MMjsgFAlKR3c1cxYneBijXjDGO9LCwwBEstwAnGERpCWMz/5Rq6rEe6B3i42d0sGC4cLJsKo0WGNw56SkuuOPE7zl39653mTTYwBElCYAgq5pv6CwiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394672; c=relaxed/simple;
	bh=kIfp2aymoeUL8Vy4cuQ54skcXO7OD2rR6MpqfXG/nX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GeYzqUyYdAqhZL8oK/83AprrQqh+80DwJYSm1hGfzTYP37lddiQ+TeJgStLTSCb481TMnCoDX096Wgq9qiBJ/DdikGjVi62q20FfVkSNgkwlE86KIQZ1rjMdWLN8ae9MYp48Z9UXWZTgkNKsY/yOWIeFqBd2HIzwWiVHtmeETXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+4gBNoa; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+4gBNoa"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12336c0a8b6so6706321c88.1
        for <ceph-devel@vger.kernel.org>; Sun, 25 Jan 2026 18:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769394670; x=1769999470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOLQh9MA9MhTdiXC4zX1NuDh2cfiEEMs3r95tMeAbNQ=;
        b=T+4gBNoaQrB48jeM4EELu+E0yjUU4C6hwNw5rgeg0cMSMmFMiIL4NswpdDYWrzSDCp
         cXRezwgX8VDh+aJFd1nymctgsQlw7dswZ1mivpH3yWl9ugqgPwdyuOSTZi6MU+jSb9uK
         kAVB6Y5mEFG5Mk5It0yr/Z0ayxYbThg7hkPJ0GPllAC+LeEAU/c5njiyAJfOKOldzzc+
         dAzdidYUCqhodFIO4KwHC4yllNQZoEUpHwf4IcUX8rKpHeewDWP2LVACyU3B+NvSDtav
         Wn3hIzM5Iy69XR6MuuCOaND8DeIYgW6hi3SotEew113N/zUzoech6KRdE7raCdNHHeaw
         p4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769394670; x=1769999470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eOLQh9MA9MhTdiXC4zX1NuDh2cfiEEMs3r95tMeAbNQ=;
        b=M9wk8a3iPr7qD8usGHVNq+c4n6x3F1t5cmZCiza0clfRy/Ips5FZ4THBgumXjUPi0+
         YMdOLFvOAy2XJ/fT5Y8UY+3P/EocY34pBceNnHAvpTmjtuES2T5reMROXz2yFZstyBbO
         oUE5vKdQ1H8+5kuE6BbtPTqOYcZzbHMzwzjjGplDMP/x2H5OaaeguPRZUt99dLIgGmmf
         otywH5yOqogyY/kVHGPb5JTh47v/SJfN/HSfTIkeqC0d1t8BKhHG0cgCnNlrwv+YlVM0
         TjhXzGj7VVLB7n57xmWBd01VycAxNUg2ZNTGROuhif93IwGsTPCjTPBOxIHEz8n9oWbq
         cifQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuTbQNkQcOepOi58gn8e13HKalnBpCMB9Qd1brkU4bmYKkomRSwW18gl/V9ut5tuY+WMyhYdLqnbX7@vger.kernel.org
X-Gm-Message-State: AOJu0YzRScFZFWiN8YWpA/zGo877OXAMh42D3tabpjhpYye8o7Ew1wD6
	/kW2Uw4jpauuHM8sdYW0UBkWJc+Zb+a3VYJ79od/u15RwNf2RrsQiGhe
X-Gm-Gg: AZuq6aJk8YtCAG5f/MbJfOS8+GE0ihJhonpoUSbvS8quheYZe7CNdD9bkvDPNQQ9WtZ
	jIlkAv479b49Mo6BIKtyFHCktNrjBtpes6T+27tyY6Q1/FCmJrcpLY5J98HiUjY1A0xPz64e7XJ
	DGQLSj/Z5LiMYJ8yzYNAo86A3YyzdBG7NBBaBOsxaaF1pGHZHNH55/JW4ywTCjVZ0YHT/ea7kUF
	BcJfJxARKxAHndM5DE1D9/33EF63kRJxR5UBF0esFSo/0wKDVCoYW9e419xCCMacOYFW066BpmK
	t3My7hGNAbHzRIdVRzzIhvJ3bm9uxjrtlyI0VDGOGuLWnP9nlYag1xseaaffy9xu6AY8EIoiG47
	0WRWeg2KKb762rEtWn+2gxvaKvMP2FezF9hiI60PvJNL/BG13SnMjRk/gJM5JzpfdTtDOI+Yb33
	ctqSgMQ3lssS0a6srJb02c9GgQ4DEgydc52jrtVibCHRlMHLVcCmoc
X-Received: by 2002:a05:7022:923:b0:119:e569:fb91 with SMTP id a92af1059eb24-1248eb39492mr1853278c88.0.1769394669588;
        Sun, 25 Jan 2026 18:31:09 -0800 (PST)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91c52bsm17212277c88.6.2026.01.25.18.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:31:09 -0800 (PST)
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
Subject: [PATCH v3 3/4] ceph: remove error return from ceph_process_folio_batch()
Date: Sun, 25 Jan 2026 18:30:54 -0800
Message-ID: <20260126023055.405401-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126023055.405401-1-CFSworks@gmail.com>
References: <20260126023055.405401-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following an earlier commit, ceph_process_folio_batch() no longer
returns errors because the writeback loop cannot handle them.

Since this function already indicates failure to lock any pages by
leaving `ceph_wbc.locked_pages == 0`, and the writeback loop has no way
to handle abandonment of a locked batch, change the return type of
ceph_process_folio_batch() to `void` and remove the pathological goto in
the writeback loop. The lack of a return code emphasizes that
ceph_process_folio_batch() is designed to be abort-free: that is, once
it commits a folio for writeback, it will not later abandon it or
propagate an error for that folio. Any future changes requiring "abort"
logic should follow this invariant by cleaning up its array and
resetting ceph_wbc.locked_pages appropriately.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 39064893f35b..cdf11288d6b7 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1284,16 +1284,16 @@ static inline int move_dirty_folio_in_page_array(struct address_space *mapping,
 }
 
 static
-int ceph_process_folio_batch(struct address_space *mapping,
-			     struct writeback_control *wbc,
-			     struct ceph_writeback_ctl *ceph_wbc)
+void ceph_process_folio_batch(struct address_space *mapping,
+			      struct writeback_control *wbc,
+			      struct ceph_writeback_ctl *ceph_wbc)
 {
 	struct inode *inode = mapping->host;
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = fsc->client;
 	struct folio *folio = NULL;
 	unsigned i;
-	int rc = 0;
+	int rc;
 
 	for (i = 0; can_next_page_be_processed(ceph_wbc, i); i++) {
 		folio = ceph_wbc->fbatch.folios[i];
@@ -1323,12 +1323,10 @@ int ceph_process_folio_batch(struct address_space *mapping,
 		rc = ceph_check_page_before_write(mapping, wbc,
 						  ceph_wbc, folio);
 		if (rc == -ENODATA) {
-			rc = 0;
 			folio_unlock(folio);
 			ceph_wbc->fbatch.folios[i] = NULL;
 			continue;
 		} else if (rc == -E2BIG) {
-			rc = 0;
 			folio_unlock(folio);
 			ceph_wbc->fbatch.folios[i] = NULL;
 			break;
@@ -1370,7 +1368,6 @@ int ceph_process_folio_batch(struct address_space *mapping,
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
-			rc = 0;
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
 			break;
@@ -1381,8 +1378,6 @@ int ceph_process_folio_batch(struct address_space *mapping,
 	}
 
 	ceph_wbc->processed_in_fbatch = i;
-
-	return rc;
 }
 
 static inline
@@ -1686,10 +1681,8 @@ static int ceph_writepages_start(struct address_space *mapping,
 			break;
 
 process_folio_batch:
-		rc = ceph_process_folio_batch(mapping, wbc, &ceph_wbc);
+		ceph_process_folio_batch(mapping, wbc, &ceph_wbc);
 		ceph_shift_unused_folios_left(&ceph_wbc.fbatch);
-		if (rc)
-			goto release_folios;
 
 		/* did we get anything? */
 		if (!ceph_wbc.locked_pages)
-- 
2.52.0

