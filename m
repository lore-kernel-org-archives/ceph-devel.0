Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C56939B4A5
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566606; cv=none; b=Z04YAWyGUXGZl4AyBFEcf6aTV+JQ1JOH6pan0JkQSQL5KbiwdIVu2Cql8tsNrpYPtyIY0bOUPeo92iU5tK1ud8Khr8JWuzIZzPtWyq3lm4ppUMAeQOql2itZQUDrAvjzyDTuZ5MhibvFGfv+GYceIdmGC9/WT56/kv36wLsMfSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566606; c=relaxed/simple;
	bh=spohi4066YMjfHPtqROzqn34a27EiH9ElD9O/6aLbLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcA0/xP8GB328W8pu3ueI77EjFawmXwdPyEkHQQ6afjPsxxTsJjXoJGvWeH1M6qBkmzg/vkkeYuCpR0BkYn8M3UlMtNtZEzdySBMnD0eJ8aMODGy7wwXVxL3wSN7CfS0ye2HN3XNrCiozmA6qvVWNDiAEKFhDd+RjB0NHvj6fG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=FMvNps5d; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="FMvNps5d"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49553515a8bso19819385e9.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566598; x=1787171398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ux0lu9FQT0gRJf+GGs5dOF6JEoNBqOqUh6OH9cCfwog=;
        b=FMvNps5dYXKknGgQ8sXe8VNyl5jnfVTr4anHX0SytfqtWqFn1GgEVErlyu1RI2HSsz
         eAgO3fvQXA8q40wAj/9ZjOxJ6g/OZNheiw/1lxLmNWlzTXH+Hr1uASRqBiAcExi8kJ8b
         WgqhZg4VSTNzSaVEnOqUSloHBNa9kp/qiq+yawMIngcDr+EB826p2eyi8fFlGooLVW+M
         YAhGhclDOhU1g/QUEgQduCd26sdjXYQpI55oU72jl5yJxde5hig593U6lhuOwVYmycgC
         K4vq33G7Xz0Ev+SO78d5dVfNgB/1tpsFwbixaurX6bqn9UiPOPYCdz1K66dJZLnuFbOO
         dabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566598; x=1787171398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ux0lu9FQT0gRJf+GGs5dOF6JEoNBqOqUh6OH9cCfwog=;
        b=qTn5R3q9GrwuAh2agqvBSoEBM44MttPDmCNC56Zb9hJiXSgEwsZ7JeMaSqJfGQ0rlW
         NiSu0uN7XeASGOagxP/NlEAEhABIe+YZ9Y8h0zsE1Sl6hcUDM2rMSYh1P136N6JRZZ16
         lqdFGiNWDXbozeTtXDWLOczwscY7ysLlzl9Q07MBxzElgOlY0i0dydM+KyjUq+8/Z/Lj
         4nGtLZAl3Gb2ajoFHyywbqUMULiiI3/g+ZSire1MvK9v4t6GyRisHfduxLtgWW39d5D8
         FgAeODi5X/pr4bhySlWQMQO0kIc6EVDq+oiIQU4OsnHxkGMcnB46eJdNBvw1suUk9g5Y
         Mn7Q==
X-Forwarded-Encrypted: i=1; AHgh+Rp3hz8bH1vGARa721zInU3mPnSUDmJE8HrklaLjOnRoKCopew4EUQskQVvv2eCUZXkD6R+VZBn8vRbm@vger.kernel.org
X-Gm-Message-State: AOJu0YxxWsfTaH8oUlnV60K+TNHrUkKJ8FOsaqryzXxB7pggkwIz1UY4
	1y8MfOcmODMYwO+IEq97ymfqYDMBnlsyqefMcL6yAZbL8ON6qcifZ+S9CmNJWZmHiYI=
X-Gm-Gg: AR+sD10zpXAuLexsT7kJpoTO8yEIAYvL5g5unVP274aAOJYgXS1dLHdFX9p+iSbPkbC
	RkGzq7X5eSjPIDUV+WOX2X/bWVjC1gDzk+pA1BO3LYJHwH9KS2GHhQfDT4XvLs7yweoMfP/BcU2
	dZHle9SdKXOqRK0s7hVdRB95/zjfBCM0CO6VXROTy8efJTKyRXbBf0sdf4qcqAzsLAALaPhXXRj
	7KmqjB70zcKmQz+8euygvyuFrt7M+RhtToswSFJoK6j3JRibgJp2Dop2nRUb9aDACYJ1zGJzZAb
	e/fWectxl0q0FaEgH84V50SQhsQxvOtJH8V4/q88N6zCC6mpXagmCBOSYaLLicY+fpjpjKSIp66
	jON9hz142EzWBrurr42dqDtve3JjgoXuJrE66arFh29KVedoOICk0q1d9SOqPcjkrBRgGbdsOf8
	PcJJWWLuNnK1OGJGpwxV8kr1sf1IoxvpVoGVoHn6j2wQ86Dpt4zF18NVgjH/U9m8piwh4heN3Zr
	5JLNClRkiE5516hVdR7PSaGwMHl8JVzF6gaGm9CJLi0AaBHL0l8We4gXWV1U8FzlmU6hSQz2Xw=
X-Received: by 2002:a05:600c:828f:b0:499:518d:ebd6 with SMTP id 5b1f17b1804b1-499821d08b5mr3929715e9.17.1786566598062;
        Wed, 12 Aug 2026 13:29:58 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:29:57 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 03/12] include/ceph/ceph_fs.h: convert `pool_id` to u32
Date: Wed, 12 Aug 2026 22:29:40 +0200
Message-ID: <20260812202950.1800340-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812202950.1800340-1-max.kellermann@ionos.com>
References: <20260812202950.1800340-1-max.kellermann@ionos.com>
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
index ecf33b66610c..77f1ff658663 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2390,7 +2390,7 @@ enum {
 };
 
 static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
-				s64 pool, struct ceph_string *pool_ns)
+				u32 pool, struct ceph_string *pool_ns)
 {
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(&ci->netfs.inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -2429,10 +2429,10 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
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
@@ -2557,10 +2557,10 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
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
 
@@ -2569,7 +2569,7 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_string *pool_ns;
-	s64 pool;
+	u32 pool;
 	int ret;
 	unsigned long flags;
 
@@ -2597,11 +2597,11 @@ int ceph_pool_perm_check(struct inode *inode, int need)
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
index d7283fb54cec..1b904089b56f 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3654,7 +3654,7 @@ static void handle_cap_grant(struct inode *inode,
 
 	if (newcaps & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR)) {
 		/* file layout may have changed */
-		s64 old_pool = ci->i_layout.pool_id;
+		u32 old_pool = ci->i_layout.pool_id;
 		struct ceph_string *old_ns;
 
 		ceph_file_layout_from_legacy(&ci->i_layout, &grant->layout);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index bdb82f123033..cd1e09c32eba 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1176,7 +1176,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	if (new_version ||
 	    (new_issued & (CEPH_CAP_ANY_FILE_RD | CEPH_CAP_ANY_FILE_WR))) {
 		u64 size = le64_to_cpu(info->size);
-		s64 old_pool = ci->i_layout.pool_id;
+		u32 old_pool = ci->i_layout.pool_id;
 		struct ceph_string *old_ns;
 
 		ceph_file_layout_from_legacy(&ci->i_layout, &info->layout);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0ece4c9e3529..5fcbc03806f9 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -441,7 +441,7 @@ struct ceph_mds_request {
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
index 860fc8e1867d..124dde705e79 100644
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

