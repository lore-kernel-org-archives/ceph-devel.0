Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863434028E5
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283143; cv=none; b=eh88I1YviB+4eyOPtaYAQB4yHOlc9n+Z6MHQmc063/k/5l2w2bZBhY/itJSQIyOrTkCaIUkbvWka+WuXEi6Mbp5G2sLLofwW6hJL/sdHiZrbZ03qpUgs8sR//abgydoP3ldADeIwLPnGkv42aD0pmQxJBr+Vo82SoSK5/jYTG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283143; c=relaxed/simple;
	bh=/SjGO8GfNS/670m9UVV23LT6t08OYkSKEDbinH4DXnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJTc3hMgvDRSS1gi0hVZJMqtnfwME7WCnKSfcyfeq9KuMPFEWJbZbup9ilnPHf91180WAXzbtlOr7K9BS6aqVTkSlYakPoX/ETSLFk7xXwKw0aUvwepHQpUaJME13rEIhTiBi/slqhcgUr1BuW1xKgP2RIwbOO08b4gcZsqp7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=chypN7BP; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="chypN7BP"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eea68dd6fso719525f8f.2
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283139; x=1781887939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIgUAPbaBabd2HrM0wuWtfsAmbH9hZzIN1NzDEgYVGQ=;
        b=chypN7BPn80omgsu6qYyQ2sXMmpZgg+EMf9pjm5FbsiYqoXAMw/9HRPXO2i/Mm9vs2
         Msbw/BtSVx+hNTP1z/YSFOuQquyfUWy7OzqQly5CYsWmxJqcYw/PcFFl0XMdMZXvHSRE
         2m2icCUVeeYFHmOOL0Wsh1pgTRETtbLB5zVTA+2xnbmiUasrfDdiq2ikcmNXTIA0zAD0
         KDarsY0FEAT5JyhiiZAkc5hQ6qFSGpWyB/k/XgMTixvsfnUDyEqQJFGXfv59QYFyvVax
         I2FzFRc9jOIXgcriVzJCP5k+lDSFwXF0t1doVTbgRJvub9Psnz18V2aHPcjjN4HJPeFC
         1kNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283139; x=1781887939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NIgUAPbaBabd2HrM0wuWtfsAmbH9hZzIN1NzDEgYVGQ=;
        b=UZXmc4gtBr5ceTocpfZn7MqbPOo2s/9bWxwBn0t7gKQ+5YPbd4QDqLqcF/YPrRtehI
         TNUKcGOMAJL/Do9y3NilN8bpTIXWfWnw2+y5nZD6zMHZ8eih+JpUWiqCM2jb1rI41miC
         VLFfJ5cESW8N3kOTEEf4NACMNZSdg5qWtcxTicCXEa+1Rm+nu/TP/2d8vjjkhAbPAtXV
         iDsYvmb6VooBWthTZ3SapG9QOrqGcSEnTA9zxv2g6LR7+j1OJc7Wa5EQIUWR8bmu88/k
         ZCl/mbgnQ6DGysWwVqobjS7rl6bWl/MfFWirsF7E6SGkxHVJnA4Kt8wHUFo1ISufEkHE
         QBog==
X-Forwarded-Encrypted: i=1; AFNElJ+A805GKHVmLEO2IC7Mo1RVOM5pnMoGrlY9AuwkJvADBd8Mdha/UtOq642D4Q7epIiW/1wszUDT0qR4@vger.kernel.org
X-Gm-Message-State: AOJu0YxuQ4LJmYkt2tAYx3NRz42JCdpqZ4G3CAbp7pzPWoWh+21QzYEE
	bTLntseCqb4gNwGMh799/FV/1n7VZHGUzFPvQrd5Rd9gCOMohWAaYXbq/xI9HPHIoPE=
X-Gm-Gg: Acq92OGbLda/CWR1ipoABf4sm3OslnDmDLKAsCr/m9FxTF4Uz4I0Rk22THaPQ/haMx/
	HO0kGXb/eUSksewjMM3OITYGPeadoue2vtP6euM5MQa4cd+aRUihGwD1yFdVVRfgljKZ0/WJG9K
	ZcwQAc6ze7P9nNJsa4f9PZwxw9oMxfBvAz9mifYPzgEO1kadYeLq3ijElpHRc5Joc2jKRwz/Zhl
	tCEtgeIcJ0hZrHi+ouLRioyQnq/FSXjgENQYo+TB5TShuljrtIUgStrjX7txqItuoMKR+jVpUtn
	FLf5BO0mBX89MhKs5lsOYCUVmrtBqMIr7pvX+Myu+LVGp3nNEnNROu6MzeGXsYYgngVzWuda/sC
	zKkY1GfeKxvspdkPIRuk+xRa79e18N5l3t8CjOso+wk6Mmo/xUo9ojWj3lhrHAGc0PU7hIRDFYJ
	4Ap7eWIJApglHrp++mzjtiRQutHyhXUkHlcWV50MrL4tFYWan9SvOoMe7gjwzXgrCUvUy3SQUJm
	23iTQ7EaWbq9WAoKCymTgOrU44UwrgKOiPgJA==
X-Received: by 2002:a5d:5d13:0:b0:460:138d:c9b0 with SMTP id ffacd0b85a97d-4606da5a580mr5504565f8f.2.1781283138932;
        Fri, 12 Jun 2026 09:52:18 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:18 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 03/12] include/ceph/ceph_fs.h: convert `pool_id` to u32
Date: Fri, 12 Jun 2026 18:51:55 +0200
Message-ID: <20260612165204.86137-4-max.kellermann@ionos.com>
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

While the Ceph OSD protocol transmits OSD pool ids as 64 bit integers,
the MDS protocol is limited to 32 bits.  This is a protocol limitation
we cannot fix, but it gives us the chance to reduce the struct sizes
by only using the integer size we really need.

There is one caveat: previously, -1 was used to indicate "invalid pool
id".  This patch changes this magic value to 0 (i.e. removes the
special-case code from ceph_file_layout_{from,to}_legacy()).  This is
fine because on the wire, this magic value is 0, too.

This reduces the size of `struct ceph_inode_info` by 16 bytes (because
it contains `struct ceph_file_layout` twice, and that struct shrinks
by 8 bytes; the small pool_id now fits in the existing padding hole).

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c               | 16 ++++++++--------
 fs/ceph/caps.c               |  2 +-
 fs/ceph/inode.c              |  2 +-
 fs/ceph/mds_client.h         |  2 +-
 fs/ceph/util.c               |  8 +-------
 fs/ceph/xattr.c              | 10 +++++-----
 include/linux/ceph/ceph_fs.h |  2 +-
 7 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 0a86f672cc09..a11b5c633358 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2381,7 +2381,7 @@ enum {
 };
 
 static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
-				s64 pool, struct ceph_string *pool_ns)
+				u32 pool, struct ceph_string *pool_ns)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(&ci->netfs.inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -2420,10 +2420,10 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 		goto out;
 
 	if (pool_ns)
-		doutc(cl, "pool %lld ns %.*s no perm cached\n", pool,
+		doutc(cl, "pool %u ns %.*s no perm cached\n", pool,
 		      (int)pool_ns->len, pool_ns->str);
 	else
-		doutc(cl, "pool %lld no perm cached\n", pool);
+		doutc(cl, "pool %u no perm cached\n", pool);
 
 	down_write(&mdsc->pool_perm_rwsem);
 	p = &mdsc->pool_perm_tree.rb_node;
@@ -2548,10 +2548,10 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 	if (!err)
 		err = have;
 	if (pool_ns)
-		doutc(cl, "pool %lld ns %.*s result = %d\n", pool,
+		doutc(cl, "pool %u ns %.*s result = %d\n", pool,
 		      (int)pool_ns->len, pool_ns->str, err);
 	else
-		doutc(cl, "pool %lld result = %d\n", pool, err);
+		doutc(cl, "pool %u result = %d\n", pool, err);
 	return err;
 }
 
@@ -2560,7 +2560,7 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_string *pool_ns;
-	s64 pool;
+	u32 pool;
 	int ret, flags;
 
 	/* Only need to do this for regular files */
@@ -2587,11 +2587,11 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 check:
 	if (flags & CEPH_I_POOL_PERM) {
 		if ((need & CEPH_CAP_FILE_RD) && !(flags & CEPH_I_POOL_RD)) {
-			doutc(cl, "pool %lld no read perm\n", pool);
+			doutc(cl, "pool %u no read perm\n", pool);
 			return -EPERM;
 		}
 		if ((need & CEPH_CAP_FILE_WR) && !(flags & CEPH_I_POOL_WR)) {
-			doutc(cl, "pool %lld no write perm\n", pool);
+			doutc(cl, "pool %u no write perm\n", pool);
 			return -EPERM;
 		}
 		return 0;
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d51454e995a8..cf9916608dc2 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3638,7 +3638,7 @@ static void handle_cap_grant(struct inode *inode,
 
 	if (newcaps & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR)) {
 		/* file layout may have changed */
-		s64 old_pool = ci->i_layout.pool_id;
+		u32 old_pool = ci->i_layout.pool_id;
 		struct ceph_string *old_ns;
 
 		ceph_file_layout_from_legacy(&ci->i_layout, &grant->layout);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 1504b889622c..c26217ed2034 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1175,7 +1175,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	if (new_version ||
 	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
 		u64 size = le64_to_cpu(info->size);
-		s64 old_pool = ci->i_layout.pool_id;
+		u32 old_pool = ci->i_layout.pool_id;
 		struct ceph_string *old_ns;
 
 		ceph_file_layout_from_legacy(&ci->i_layout, &info->layout);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 4e6c87f8414c..7b848fdd6f70 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -396,7 +396,7 @@ struct ceph_mds_request {
 struct ceph_pool_perm {
 	struct rb_node node;
 	int perm;
-	s64 pool;
+	u32 pool;
 	size_t pool_ns_len;
 	char pool_ns[];
 };
diff --git a/fs/ceph/util.c b/fs/ceph/util.c
index 2c34875675bf..5bb40af08b1c 100644
--- a/fs/ceph/util.c
+++ b/fs/ceph/util.c
@@ -35,9 +35,6 @@ void ceph_file_layout_from_legacy(struct ceph_file_layout *fl,
 	fl->stripe_count = le32_to_cpu(legacy->fl_stripe_count);
 	fl->object_size = le32_to_cpu(legacy->fl_object_size);
 	fl->pool_id = le32_to_cpu(legacy->fl_pg_pool);
-	if (fl->pool_id == 0 && fl->stripe_unit == 0 &&
-	    fl->stripe_count == 0 && fl->object_size == 0)
-		fl->pool_id = -1;
 }
 
 void ceph_file_layout_to_legacy(struct ceph_file_layout *fl,
@@ -46,10 +43,7 @@ void ceph_file_layout_to_legacy(struct ceph_file_layout *fl,
 	legacy->fl_stripe_unit = cpu_to_le32(fl->stripe_unit);
 	legacy->fl_stripe_count = cpu_to_le32(fl->stripe_count);
 	legacy->fl_object_size = cpu_to_le32(fl->object_size);
-	if (fl->pool_id >= 0)
-		legacy->fl_pg_pool = cpu_to_le32(fl->pool_id);
-	else
-		legacy->fl_pg_pool = 0;
+	legacy->fl_pg_pool = cpu_to_le32(fl->pool_id);
 }
 
 int ceph_flags_to_mode(int flags)
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index e773be07f767..9808eb10625d 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -50,7 +50,7 @@ static bool ceph_vxattrcb_layout_exists(struct ceph_inode_info *ci)
 {
 	struct ceph_file_layout *fl = &ci->i_layout;
 	return (fl->stripe_unit > 0 || fl->stripe_count > 0 ||
-		fl->object_size > 0 || fl->pool_id >= 0 ||
+		fl->object_size > 0 || fl->pool_id > 0 ||
 		rcu_dereference_raw(fl->pool_ns) != NULL);
 }
 
@@ -61,7 +61,7 @@ static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_string *pool_ns;
-	s64 pool = ci->i_layout.pool_id;
+	u32 pool = ci->i_layout.pool_id;
 	const char *pool_name;
 	const char *ns_field = " pool_namespace=";
 	char buf[128];
@@ -81,7 +81,7 @@ static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 		total_len = len + strlen(pool_name);
 	} else {
 		len = snprintf(buf, sizeof(buf),
-		"stripe_unit=%u stripe_count=%u object_size=%u pool=%lld",
+		"stripe_unit=%u stripe_count=%u object_size=%u pool=%u",
 		ci->i_layout.stripe_unit, ci->i_layout.stripe_count,
 		ci->i_layout.object_size, pool);
 		total_len = len;
@@ -164,7 +164,7 @@ static ssize_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
 	ssize_t ret;
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->netfs.inode.i_sb);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
-	s64 pool = ci->i_layout.pool_id;
+	u32 pool = ci->i_layout.pool_id;
 	const char *pool_name;
 
 	down_read(&osdc->lock);
@@ -174,7 +174,7 @@ static ssize_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
 		if (ret <= size)
 			memcpy(val, pool_name, ret);
 	} else {
-		ret = ceph_fmt_xattr(val, size, "%lld", pool);
+		ret = ceph_fmt_xattr(val, size, "%u", pool);
 	}
 	up_read(&osdc->lock);
 	return ret;
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index 69ac3e55a3fe..7faa18493a07 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -69,7 +69,7 @@ struct ceph_file_layout {
 	u32 stripe_unit;   /* stripe unit, in bytes */
 	u32 stripe_count;  /* over this many objects */
 	u32 object_size;   /* until objects are this big */
-	s64 pool_id;        /* rados pool id */
+	u32 pool_id;        /* rados pool id */
 	struct ceph_string __rcu *pool_ns; /* rados pool namespace */
 };
 
-- 
2.47.3

