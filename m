Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1915D3F20EE
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322718; cv=none; b=VuM4Gz1XEv6PkTb2oTP5pQkByNh86v7MaNL9Jm5iGH9d5Opqnyuz3SsIuZQ+nM/9OKnNFb8sThGXxexRqJQyAj1WZugLpUKla+v/DEGmU0GNog+BYERSFcnE7C7ZimrohYoNQHBK6GU6tIyCFyPjGA4qCGV2hK74xHvsl3FLTgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322718; c=relaxed/simple;
	bh=rMATcTzNEPAExjisuV4h8drnguRJS39nPvUj5pvdhT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REjn3sxpu5FVHN4aM/mbtifl4wdXbaBs5cmuvVk7vUOT4InfB6heWV57CFs8+/B0+LCczocSGJvD9HkU+qNDj0Hj/I6Wk5mIDWW8l8Acjt5P1Ci4avs1DPm6Dmx0WMRkyQqIh+xMYyf7IMYpOIBNc9RhbmQygebhVSOgRH14de4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VCNsJ5ym; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VCNsJ5ym"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so9332935e9.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322707; x=1783927507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WlUx7FJI3jHMt0+d6JmF1hqOHHnUGnwftrb8B/z+p8k=;
        b=VCNsJ5ymAGEpKlnPH3QaVDMVT5aAq0nrSvACrNkA/Q8KraagtFYuy3pplINdefH9gA
         8QimXWiBAsTB3pGB5sMTJyH/HU4b1eMIPG+mwVj8jhPRS5HIdoNiNlszkgnpqKwK59ec
         ha3K/CxBwcFYM6pIhhx31Bj5O8le17ltGo/bT2g9WNShW14cbaFgnEC6yJLt7baTRZF1
         jWVS8p+qhfv1SjG1xcBPQBWs5uW+qkLtgK4vDKwHacpdXe6kaWnpwjBpkaTTaXgOLD05
         t9GXrvfNk0Ufm+Qui68+2W3pZsu2Ud2/Q4cTi4KdCiBn9eCUt87HqsJTTU6L1VVal0cx
         pUUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322707; x=1783927507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WlUx7FJI3jHMt0+d6JmF1hqOHHnUGnwftrb8B/z+p8k=;
        b=Rq4ZrzFMRzdfOHbmTEZQMV+navxgB/XiOpg5PnWsB0FTI0+vXWOYoxPiO8ejutoNxi
         xythJDlFQmzdzmC4i+EGyeqDRO8zFjFcI7sdaabtd6p5cXGdV8cQCNTUdvvrq722V4Vj
         20aYLn9exW6BM4iy8NzpbqSFy2upeoD4calBq/fPgQI45v/ACl8mu4Oqj2Sw78629e2k
         pwwZsZ1FxVYcSj8auOUXwPbtjiWfhU5819TwTq/FSOvFegtynSZq2KpCq+DaIJ4yQSVS
         /00AcJ1MTZdZnyjoSkNGJkorRRqbapzBczGqM5RESV1xLCyjYG8rl/dPeKD/SSovqZWe
         /M7g==
X-Forwarded-Encrypted: i=1; AHgh+RozqiiSPTsx20+z7uYO0lEtrU7WbgSEOvmsYov7A9K5hBBrALHqqWVH1/1xxvYwkd8foTfM8p+UjtnQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5L8lxKGEEooDqDi+r6EtGYIGIZtJBAM2nN9JWUHZY9pUHaO+r
	mAHgL23uGgYJU5ez735tJe0UX1Gnk/yu/0Ry+FD51tGYe8O7wQ/h6ayljsfuBtVUzz4=
X-Gm-Gg: AfdE7cl8pbC/7JNCjw5hXW5cUpCT0RV5dsiCU1r+nGx6HiW6oJpHTUtwcdfuG9iNxXg
	GFqMyiUrecf3iqcYzAJdsexJIwZz+/yXUqQQq1B/lLZURgp3TcYQcJYOtgQQ2pPDW3t5wfEzwiE
	SJroKN9FRgvKblnc32xrF0B45z3ZYRaDObUxlffG4rQFKQ/Vtd/fLn2DcVzrX2KiZLtdixWFkLT
	LCy/8qok3N1ta3Bs9aejY/fq2Kr3cIae18vszUjmF9xF/JwuNsnSipjv/4r3hGMYeR0cuTvim4s
	JIK4cJPvqUTALkKe2eJHjf93M9xNEf7zMpRYoesQ/Tf2CZo23viTMNYV0OvHQLbxJp3wl+3n23X
	iWeMexKZdNYAuhhlKFY3CWhMdLMoUit3YWNSsV0kv9VazAiBMfpL3uQe5aC508m/Y0Ap+JLWzWH
	MxgV1NrtEWlsdrHo6xMVF/w9s0hiZy3/Af7IL1AVYjEARnzxnR3QRZ0RyeZR0+3nebUg523/GCz
	t7AV9JzNdYO1g3D
X-Received: by 2002:a05:600c:6792:b0:493:b4cf:d37f with SMTP id 5b1f17b1804b1-493d11d7dd2mr101176875e9.16.1783322707462;
        Mon, 06 Jul 2026 00:25:07 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:25:07 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 16/18] fs/ceph/snap: add a kmem_cache for struct ceph_snap_realm
Date: Mon,  6 Jul 2026 09:24:47 +0200
Message-ID: <20260706072450.3920010-17-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706072450.3920010-1-max.kellermann@ionos.com>
References: <20260706072450.3920010-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There will be lots of ceph_snap_realm instances, and having a separate
kmem_cache seems worthwile.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/snap.c               | 4 ++--
 fs/ceph/super.c              | 9 +++++++++
 include/linux/ceph/libceph.h | 1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index f064b5ad3bf4..12f80df4b651 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -118,7 +118,7 @@ static struct ceph_snap_realm *ceph_create_snap_realm(
 
 	lockdep_assert_held_write(&mdsc->snap_rwsem);
 
-	realm = kzalloc_obj(*realm, GFP_NOFS);
+	realm = kmem_cache_zalloc(ceph_snap_realm_cachep, GFP_NOFS);
 	if (!realm)
 		return ERR_PTR(-ENOMEM);
 
@@ -205,7 +205,7 @@ static void __destroy_snap_realm(struct ceph_mds_client *mdsc,
 	kfree(realm->prior_parent_snaps);
 	kfree(realm->snaps);
 	ceph_put_snap_context(realm->cached_context);
-	kfree(realm);
+	kmem_cache_free(ceph_snap_realm_cachep, realm);
 }
 
 /*
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index c05fbd4237f8..73c316c23315 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -910,6 +910,7 @@ struct kmem_cache *ceph_inode_cachep;
 struct kmem_cache *ceph_cap_cachep;
 struct kmem_cache *ceph_cap_snap_cachep;
 struct kmem_cache *ceph_cap_flush_cachep;
+struct kmem_cache *ceph_snap_realm_cachep;
 struct kmem_cache *ceph_dentry_cachep;
 struct kmem_cache *ceph_file_cachep;
 struct kmem_cache *ceph_dir_file_cachep;
@@ -945,6 +946,11 @@ static int __init init_caches(void)
 	if (!ceph_cap_flush_cachep)
 		goto bad_cap_flush;
 
+	ceph_snap_realm_cachep = KMEM_CACHE(ceph_snap_realm,
+					    SLAB_RECLAIM_ACCOUNT);
+	if (!ceph_snap_realm_cachep)
+		goto bad_snap_realm;
+
 	ceph_dentry_cachep = KMEM_CACHE(ceph_dentry_info,
 					SLAB_RECLAIM_ACCOUNT);
 	if (!ceph_dentry_cachep)
@@ -984,6 +990,8 @@ static int __init init_caches(void)
 bad_file:
 	kmem_cache_destroy(ceph_dentry_cachep);
 bad_dentry:
+	kmem_cache_destroy(ceph_snap_realm_cachep);
+bad_snap_realm:
 	kmem_cache_destroy(ceph_cap_flush_cachep);
 bad_cap_flush:
 	kmem_cache_destroy(ceph_cap_snap_cachep);
@@ -1006,6 +1014,7 @@ static void destroy_caches(void)
 	kmem_cache_destroy(ceph_cap_cachep);
 	kmem_cache_destroy(ceph_cap_snap_cachep);
 	kmem_cache_destroy(ceph_cap_flush_cachep);
+	kmem_cache_destroy(ceph_snap_realm_cachep);
 	kmem_cache_destroy(ceph_dentry_cachep);
 	kmem_cache_destroy(ceph_file_cachep);
 	kmem_cache_destroy(ceph_dir_file_cachep);
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 63e0e2aa1ce9..379629cafbce 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -276,6 +276,7 @@ extern struct kmem_cache *ceph_inode_cachep;
 extern struct kmem_cache *ceph_cap_cachep;
 extern struct kmem_cache *ceph_cap_snap_cachep;
 extern struct kmem_cache *ceph_cap_flush_cachep;
+extern struct kmem_cache *ceph_snap_realm_cachep;
 extern struct kmem_cache *ceph_dentry_cachep;
 extern struct kmem_cache *ceph_file_cachep;
 extern struct kmem_cache *ceph_dir_file_cachep;
-- 
2.47.3

