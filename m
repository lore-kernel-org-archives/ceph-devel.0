Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18303E3D93
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272477; cv=none; b=D1APm4lVuoETtUdpS3/Y3zkPyrPEIOQEDTZkMLc5jN5J/Vl5NyI6JInmhRBPWkTYEuMS/dvKPFEHf3sDgHvivHZNRz6Scs4Na0kzz3EoO7q8Gr6BL/x20Iq0FziwPGnfOvoTZVLmEbPre//7/PHYWGxCz6ZlBeUG/daghKcoXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272477; c=relaxed/simple;
	bh=+CTSEsp/2olU8L6a/rv052YQpe4i7E93BUYU+16kL6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LEL0/qrMjj5aMOpxKjOSQN2jtNSuYFmNbt51uEZDHcTAbRGfiu2rcqwJe6q8zCpjZidOimDsZnTYYvx/FN/pJbjXhxiwO/Z/c/RvDZZzL5scvH6Q/fvFAXsGLJAAUDu+CydJl8XduxMrIKb7iYZFVyiTo0owMlUhy8u/a3nyoUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FLSw1pDM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVhc8yYh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLSw1pDM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVhc8yYh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776272475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jp1zrO1uuVX04cOgiBvHowBM6uu8e3oJ6YY/cYsJ/g0=;
	b=FLSw1pDMIaG4ysfgtTIMimBILhcr+53sqiRb0fdOwX2BgiLt4o21ynrnX3fTCEg5Qtr1n9
	b4U+YxXbYqeVaJ+i7x3O2UL6rc/XNm/74etT/oFA7Bgfqmg/kupkRHrcxZgzL2prmWXXJj
	GRD3ierGJy6Sdq6hD0IAIoTHVn16EtM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-DJ7zET5aMbWRFsyeJetrBw-1; Wed, 15 Apr 2026 13:01:13 -0400
X-MC-Unique: DJ7zET5aMbWRFsyeJetrBw-1
X-Mimecast-MFC-AGG-ID: DJ7zET5aMbWRFsyeJetrBw_1776272473
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50b220c72bbso166354871cf.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 10:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776272473; x=1776877273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jp1zrO1uuVX04cOgiBvHowBM6uu8e3oJ6YY/cYsJ/g0=;
        b=dVhc8yYhOhgmnc6DigA2GDR1NyIwL/PnipBWz6snouKV53OdTzS6Q3SF7FWARw7c5j
         bUo7691iR/S0o3UO9CFVesqH3u63PwnlxeK7+FkKg9VbFDzml/Yl4SJE0V4Fk+UEWHkF
         KPMEpIMxb6MHvywGSXf9Bzm8oH6GO+vjfeAkv8z7CpPSk7Dw/NZTvj7y8j2xNzfV4lqg
         4SZaOfTk0ZoaNJdgU2CWAQsv5oVDGTfzlEC/5fK8Hpc1ose74RaC0tgnFjJmjg/5J8Pl
         ZZbv3hyx96xWTQNk6HxTHBfe8wagTQGUiPwXF4zljucS/pPztZJsS2WeuSSpO3oCHcgZ
         M3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272473; x=1776877273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jp1zrO1uuVX04cOgiBvHowBM6uu8e3oJ6YY/cYsJ/g0=;
        b=ErwJoTqZPFm3/OfUFRdaskYb1I8xZSOpGcuCfqIYo6A0I/lNjWPRWHomymzPZDhviE
         /B7oXbUaY+MyhVcjjZnVJSlMb8+EkoiUzNuT/Sf+4O+azibdEv2WU6R9caUGECJb4ujX
         Yv1ZGQ/KEIYRJ7JyxP2UU8HBvK95fTWxoHLdEZYgbdfAeePEL0RD1CvuEj4idFdxRwLU
         HdF9GoucjDqJ6Ejq2NVpSXASUSPvKAI8u1zObDuKotczW9Sf0g3Dzr+5WEpjZx4hWx6n
         R5KZCG4Ks5pmyOqdXvNDyUnse6UI7BIiZKsen7ROyDEHqUFnj5o6tNRI/2M3b35SNJng
         uFjw==
X-Gm-Message-State: AOJu0YxBVwoe0FjIGAls58Jm3310AMU0idI3bZjq9uJ16s1WXCCGe6NR
	Ui8m9Ll1bBkYajYGatYkNWwOnn2vepzaJNSH6WpFhn+7/KZUpoZWoZHdFED+xHgGgSs/wMJctFA
	x5MPs5aEMuaA8Za/fdNrzrAAaTezZbRIZIFTi6/tGQgoYpvEOmVSfTmOdHNnkN6Mi94ikEChq5H
	sveWDOcrCIzDbA0cGDv/mQILLhI28BNbslVMOPYKkEhvG+zF0=
X-Gm-Gg: AeBDiesNxlIcA0jMR9sjaAKo3/umgjLaJW0L6Ezb/53k7liIJWghMwR1k704xcL+Rzg
	92ruZya8lDuBLYZg8xL0pMhSAVCOZsBh0svbm8UZ+Hj3E11c52ykwg76aJi4N94XZDN1Ja+2vtc
	EYbR6iHdKLIJqy995SAkmqB76Qek0hB0M18G8JGfmvC3SkpYOj4m4XAbe4GSogTjfGftmWZb+rp
	EfaEbK1HYdWTeTW7nUDo7FGlW44XKzdWmdGM99Jwg24MfmK6CgvI76ZKV7R70ZVY7qGBRHBhrIK
	YosDZYHSjnJNcpt9aTm+6QENMJBzXFrR8eMYnF/uu28Ar/aOB91EfIUG+ndh4E18XS/k6UQOU4K
	dIjFAKt7AcWR7OeUrNjFGA7EDfY0cql1Ibqtt/eAYqcJ2GRHxSy7Z8sE1cNibLEa2lQ==
X-Received: by 2002:a05:622a:1b1e:b0:50d:38d5:c6b1 with SMTP id d75a77b69052e-50dd5b526bamr327474141cf.16.1776272472322;
        Wed, 15 Apr 2026 10:01:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1b1e:b0:50d:38d5:c6b1 with SMTP id d75a77b69052e-50dd5b526bamr327470971cf.16.1776272470063;
        Wed, 15 Apr 2026 10:01:10 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9dc5fsm16817841cf.16.2026.04.15.10.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:01:09 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>
Subject: [PATCH v2 4/7] ceph: add diagnostic timeout loop to wait_caps_flush()
Date: Wed, 15 Apr 2026 17:00:40 +0000
Message-Id: <20260415170043.3882912-5-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415170043.3882912-1-amarkuze@redhat.com>
References: <20260415170043.3882912-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert wait_caps_flush() from a silent indefinite wait into a diagnostic
wait loop that periodically dumps pending cap flush state.

The underlying wait semantics remain intact: callers still wait until the
requested cap flushes complete. The difference is that long stalls now
produce actionable diagnostics instead of looking like a silent hang.

CEPH_CAP_FLUSH_MAX_DUMP_COUNT bounds the diagnostics in two ways:
it limits the number of entries emitted per diagnostic dump, and it
limits the number of timed diagnostic dumps before the wait continues
silently.

READ_ONCE is used for the i_last_cap_flush_ack field, which is read
outside the inode lock domain.

Add a ci pointer to struct ceph_cap_flush so that the diagnostic
dump can identify which inode each pending flush belongs to.  The
new i_last_cap_flush_ack field tracks the latest acknowledged flush
tid per inode for diagnostic correlation.

This improves reset-drain observability and is also useful for
existing sync and writeback troubleshooting paths.

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/caps.c       |  5 ++++
 fs/ceph/inode.c      |  1 +
 fs/ceph/mds_client.c | 56 ++++++++++++++++++++++++++++++++++++++++----
 fs/ceph/super.h      |  6 +++++
 4 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index cb9e78b713d9..c40175dd77ae 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1648,6 +1648,7 @@ static void __ceph_flush_snaps(struct ceph_inode_info *ci,
 
 		spin_lock(&mdsc->cap_dirty_lock);
 		capsnap->cap_flush.tid = ++mdsc->last_cap_flush_tid;
+		capsnap->cap_flush.ci = ci;
 		list_add_tail(&capsnap->cap_flush.g_list,
 			      &mdsc->cap_flush_list);
 		if (oldest_flush_tid == 0)
@@ -1846,6 +1847,7 @@ struct ceph_cap_flush *ceph_alloc_cap_flush(void)
 		return NULL;
 
 	cf->is_capsnap = false;
+	cf->ci = NULL;
 	return cf;
 }
 
@@ -1931,6 +1933,7 @@ static u64 __mark_caps_flushing(struct inode *inode,
 	doutc(cl, "%p %llx.%llx now !dirty\n", inode, ceph_vinop(inode));
 
 	swap(cf, ci->i_prealloc_cap_flush);
+	cf->ci = ci;
 	cf->caps = flushing;
 	cf->wake = wake;
 
@@ -3826,6 +3829,8 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 	bool wake_ci = false;
 	bool wake_mdsc = false;
 
+	WRITE_ONCE(ci->i_last_cap_flush_ack, flush_tid);
+
 	list_for_each_entry_safe(cf, tmp_cf, &ci->i_cap_flush_list, i_list) {
 		/* Is this the one that was flushed? */
 		if (cf->tid == flush_tid)
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index f75d66760d54..de465c7e96e8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -670,6 +670,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	INIT_LIST_HEAD(&ci->i_cap_snaps);
 	ci->i_head_snapc = NULL;
 	ci->i_snap_caps = 0;
+	ci->i_last_cap_flush_ack = 0;
 
 	ci->i_last_rd = ci->i_last_wr = jiffies - 3600 * HZ;
 	for (i = 0; i < CEPH_FILE_MODE_BITS; i++)
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b14ede808436..7d17332d72d7 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -27,6 +27,8 @@
 #include <trace/events/ceph.h>
 
 #define RECONNECT_MAX_SIZE (INT_MAX - PAGE_SIZE)
+#define CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC 60
+#define CEPH_CAP_FLUSH_MAX_DUMP_COUNT 5
 
 /*
  * A cluster of MDS (metadata server) daemons is responsible for
@@ -2286,19 +2288,65 @@ static int check_caps_flush(struct ceph_mds_client *mdsc,
 }
 
 /*
- * flush all dirty inode data to disk.
+ * Dump pending cap flushes for diagnostic purposes.
  *
- * returns true if we've flushed through want_flush_tid
+ * cf->ci is safe to dereference here because the cap_dirty_lock is
+ * held, and cap_flush entries are removed from the global
+ * cap_flush_list under the same lock in the purge path.
+ */
+static void dump_cap_flushes(struct ceph_mds_client *mdsc, u64 want_tid)
+{
+	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_cap_flush *cf;
+	int dumped = 0;
+
+	pr_info_client(cl, "still waiting for cap flushes through %llu:\n",
+		       want_tid);
+	spin_lock(&mdsc->cap_dirty_lock);
+	list_for_each_entry(cf, &mdsc->cap_flush_list, g_list) {
+		if (cf->tid > want_tid)
+			break;
+		if (++dumped > CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
+			break;
+		if (!cf->ci) {
+			pr_info_client(cl,
+				       "(null ci) %s tid=%llu wake=%d%s\n",
+				       ceph_cap_string(cf->caps), cf->tid,
+				       cf->wake,
+				       cf->is_capsnap ? " is_capsnap" : "");
+			continue;
+		}
+		pr_info_client(cl,
+			       "%llx:%llx %s tid=%llu last_ack=%llu wake=%d%s\n",
+			       ceph_vinop(&cf->ci->netfs.inode),
+			       ceph_cap_string(cf->caps), cf->tid,
+			       READ_ONCE(cf->ci->i_last_cap_flush_ack),
+			       cf->wake,
+			       cf->is_capsnap ? " is_capsnap" : "");
+	}
+	spin_unlock(&mdsc->cap_dirty_lock);
+}
+
+/*
+ * Wait for all cap flushes through @want_flush_tid to complete.
+ * Periodically dumps pending cap flush state for diagnostics.
  */
 static void wait_caps_flush(struct ceph_mds_client *mdsc,
 			    u64 want_flush_tid)
 {
 	struct ceph_client *cl = mdsc->fsc->client;
+	int i = 0;
+	long ret;
 
 	doutc(cl, "want %llu\n", want_flush_tid);
 
-	wait_event(mdsc->cap_flushing_wq,
-		   check_caps_flush(mdsc, want_flush_tid));
+	do {
+		ret = wait_event_timeout(mdsc->cap_flushing_wq,
+			   check_caps_flush(mdsc, want_flush_tid),
+			   CEPH_CAP_FLUSH_WAIT_TIMEOUT_SEC * HZ);
+		if (ret == 0 && i++ < CEPH_CAP_FLUSH_MAX_DUMP_COUNT)
+			dump_cap_flushes(mdsc, want_flush_tid);
+	} while (ret == 0);
 
 	doutc(cl, "ok, flushed thru %llu\n", want_flush_tid);
 }
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index c89ad8dcc969..1f901b1647e6 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -238,6 +238,7 @@ struct ceph_cap_flush {
 	bool is_capsnap; /* true means capsnap */
 	struct list_head g_list; // global
 	struct list_head i_list; // per inode
+	struct ceph_inode_info *ci;
 };
 
 /*
@@ -443,6 +444,11 @@ struct ceph_inode_info {
 	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 or
 						    dirty|flushing caps */
 	unsigned i_snap_caps;           /* cap bits for snapped files */
+	/*
+	 * Written under i_ceph_lock, read via READ_ONCE()
+	 * from diagnostic paths.
+	 */
+	u64 i_last_cap_flush_ack;
 
 	unsigned long i_last_rd;
 	unsigned long i_last_wr;
-- 
2.34.1

