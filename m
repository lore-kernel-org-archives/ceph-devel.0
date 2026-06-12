Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02AC403EA2
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283143; cv=none; b=Wry2kaBpKO27UKYGzVZsQs3XDyR8g0ozaTM+/fv9nF6cW4Rt+ZSblm3pqc3cOH94rVstxQamTZ8d6roWUOUNThaqoZnEolp6o2rqkqkuMKfzk+sRrLR9Dm+QkIwxvg1Tpwpva1Bz1KzlP+mZeTfEHJfqYcRH2cvvCdY0qb37f/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283143; c=relaxed/simple;
	bh=v95EqBmqD8bvtDCHu4p8+OxsxIA/K2yD5DT5v/avur4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN7+I/Ebi8HFoJ51wt6gBChEPqSQ4Ax5TNiJE4NO0DN02nAPqQ0LB+0GtqDpYM89p9652C6pWzaV8s7J0++8sQ+o6hkrqIfDhKOGe+itiSeVqfVjubjbtlqpK32lHxaBBdRpFR1eOnMr/wh8CdTuEn1WwBmOTWqdFSvlflYseGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=LU9kPvwt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="LU9kPvwt"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45eee266c6cso1077353f8f.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283140; x=1781887940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JAFXf3xlSlpOVQjGUTrsX75pZadXaUwrTgQU6I93r0=;
        b=LU9kPvwtFnMmxVLoKxsOesT0KUaG4IefWw+oUJIyX+2SUPCPkoovtXEG0I9bxkN4/t
         9fdmzRTxoSnnBtdq7hSsWKMw4FRdK+2tqSpcAXD2fv4+hpLQzRqS3Z/ia7JhG3/G0YfF
         ABwZyszx2YrSkHq97UccY13anqsviaIUxDFa/0ggRqjNNxHd9iaDUQ4zdRg5TkK7bpYD
         AD4U/ECkT4SIGAlk31Ea1rIT32IHnm2cOZDO7hjCtOuZ3TVjqynubuJ/NbxAYJqrBvQK
         GuGlt39VNMZLRevNjF4UcCSI406cZxDD8ENDLnz0izvnCp9Ds/XYcZje3jaWkit59dfy
         E52w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283140; x=1781887940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3JAFXf3xlSlpOVQjGUTrsX75pZadXaUwrTgQU6I93r0=;
        b=dFqsIXiwJmUqxWGxMYpDtMcL4hoVlJMlzoco+xWHcN/AYEt/krKpVE7sWuR7arb/nd
         XV9sLG27lAf97xF2mD/Lc8j8lTTPAibmbQ6g1DI0/a1mugiAFZr3iqJahFtZAgZg0W8h
         fFzmLMGLrE94vlSQkIAU8eaZSEWC4JajBJTk3DEu0SF0wKtD8pZUVK3WyEKaj+eN1MsX
         +vekMc19uJ6zpWcRDo7Sxktw+z9T/4HDul7q9H7eMYPUG8nqvVRoLaPgCzWUa5ALKzdm
         4W1uNLMapnnfgGIg3spFqVFziW5l3B4vATMB7UuJpfWb3z255pDuvRvWXwAJRJv+aIv9
         TxSA==
X-Forwarded-Encrypted: i=1; AFNElJ88VgIE7YP7f3syZvYpNgreun2OyxLHlDW6crBCwUnFq5cO9UXiGcUstvn941rvqBqSERkHbfKkDqbj@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2hRWyqLTKo5CBBmCQB+WPbMWZtxy4pevAYXvYzCzCBHrp9yHT
	oHKeRbeuYFVt2SYV9rK3rJmQ6yynKuomKJzaG0waaezGDESTY9WSRPeFkfQBKp6TNlU=
X-Gm-Gg: Acq92OG9e7BOWRiK/42hEGyIz7gIG2Drw6q+iACHqskoIqGKhI81am6xvx7g3lVFuqS
	fhpJpFzoo3YTw77U3xxr0uHPP5TL6H55P2FVt4MHodfLGgr4QQ69kXir4NOiABDiEEWLDIUL3Uo
	aMEZenOYWmKtwIiC1VFK1IUcz4A0tF/y147YzLfzz1jpc1oB+KBFtXmytY7lX1TLXgwrGZnaB5p
	MwM4SFUQHZek7VZzk43Teh5D1j357uaWXgxjIkR5stofdn2muHew8E2RwdSHW5DsQ7a4oAM/jv+
	K1RiFzU9kOPtnAU3X4avuyL3UL1AZcGAWP7qnOzIutAfJtp63tW0vInwFJmQZgIQowKsHioynO1
	NZPPRTsaz6RtXyZhyDCkz0rKUIOSEK9g1kWgou9NgGLKRNhmW96PMJrp2WJ4GvUxcK/LIN4u0BJ
	6XXgjwwq6AgD9qwDzAkuiHzqXKmE8beZ6FNMs6cUXHr3sH61A2haqHGF7r5uEYibyxvCDzEIVoG
	YI0eSesaO3uLN3qWGlrPMUyr5g=
X-Received: by 2002:a05:6000:1847:b0:45e:ec18:f207 with SMTP id ffacd0b85a97d-4606db9a69bmr6011120f8f.25.1781283140080;
        Fri, 12 Jun 2026 09:52:20 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:19 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 05/12] fs/ceph/super.h: convert ceph_cap_snap.writing fields to `bool`
Date: Fri, 12 Jun 2026 18:51:57 +0200
Message-ID: <20260612165204.86137-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165204.86137-1-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will allow better struct packing.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c  | 2 +-
 fs/ceph/snap.c  | 4 ++--
 fs/ceph/super.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index cf9916608dc2..e50bcb393c8f 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3288,7 +3288,7 @@ static void __ceph_put_cap_refs(struct ceph_inode_info *ci, int had,
 					struct ceph_cap_snap,
 					ci_item);
 
-		capsnap->writing = 0;
+		capsnap->writing = false;
 		if (ceph_try_drop_cap_snap(ci, capsnap))
 			/* put the ref held by ceph_queue_cap_snap() */
 			put++;
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 52b4c2684f92..6dbc7859ff49 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -521,7 +521,7 @@ static bool has_new_snaps(struct ceph_snap_context *o,
  * However, if a (sync) write is currently in-progress when we apply
  * the snapshot, we have to wait until the write succeeds or fails
  * (and a final size/mtime is known).  In this case the
- * cap_snap->writing = 1, and is said to be "pending."  When the write
+ * cap_snap->writing = true, and is said to be "pending."  When the write
  * finishes, we __ceph_finish_cap_snap().
  *
  * Caller must hold snap_rwsem for read (i.e., the realm topology won't
@@ -627,7 +627,7 @@ static void ceph_queue_cap_snap(struct ceph_inode_info *ci,
 		doutc(cl, "%p %llx.%llx cap_snap %p snapc %p seq %llu used WR,"
 		      " now pending\n", inode, ceph_vinop(inode), capsnap,
 		      old_snapc, old_snapc->seq);
-		capsnap->writing = 1;
+		capsnap->writing = true;
 	} else {
 		/* note mtime, size NOW. */
 		__ceph_finish_cap_snap(ci, capsnap);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 18960a9e735a..505a1552f355 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -269,7 +269,7 @@ struct ceph_cap_snap {
 	u64 time_warp_seq;
 	u64 truncate_size;
 	u32 truncate_seq;
-	int writing;   /* a sync write is still in progress */
+	bool writing;   /* a sync write is still in progress */
 	int dirty_pages;     /* dirty pages awaiting writeback */
 	bool inline_data;
 	bool need_flush;
-- 
2.47.3

