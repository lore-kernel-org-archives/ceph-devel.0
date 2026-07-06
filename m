Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE2348866
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322735; cv=none; b=pz+T/ucoz/UGVnoldKEjzjpelDT8HwQ1+qcqB8qf7zI3yzU+DV7BN3vukiYfbCGQ9xhNOk6Q539x+Q0Vne32PRG5FJnNaSooSlJp78dqyQbN8kV/mOhY1HU3UI7JT3kmvMGz2ehHZyeSfk8plAVVfN8p3LYuurzuT4+Dk+ezzY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322735; c=relaxed/simple;
	bh=ootcSuo3/3d7uGjEh2RZCoOruKfSPiu/8VHprd/k7Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcZckL9ZMgUKw3RgrD75gTIoQwhTewg5YlQnu3Hi0LFkxg8Ejxc8nQRA3Lyn1ifchubTIelPfshIWq9NqEvTs+E0uyAO1IXWLBsDz1hFI5q0sEbc42hSLgDT3w/q0urQ5PDUnpo5qtxVhzZuJpRFSYSnmHp4NQw0V6PIQl+64u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cSOe+ny+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cSOe+ny+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-470174001a0so1237594f8f.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322698; x=1783927498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0RS10XrQ0EJ9+cvLAKMYnaMxvJAYjF/Otib0XlTVOq8=;
        b=cSOe+ny+OQHUNoMz4x2jCymZYaX4+ohKeDw8uu0urCSUzaZTy67wp8Ykn9mUbxaHDm
         kg+/ADV+XzO0KE26WklONmzkuvX0wsyL+aT5WKApNS/ixJetW4/49frhTSp1qB529BYJ
         Th3F/aC1fj1MqWc6+8vUAhBwFEJFSDCuNHzFBQUja/CbucjSBSEHZGbrn4UP0dqQPcCF
         NRjwh3yAcCys2i7tIC8Pmxqg9TX5dvGnQSocFrcH+HfEIkmA+nMiHFVTk83Q769W7Yel
         LxNqKR6ddF8ETKXfFNcjGqTZNnQwr9HJkgNN/dwwIaDTuJWHBRDpwS+VKEap6PcsepI/
         nQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322698; x=1783927498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0RS10XrQ0EJ9+cvLAKMYnaMxvJAYjF/Otib0XlTVOq8=;
        b=KaUc8xlV7XYX8QHP30p9P1KQa3CMXNvXiPWGSOcjDOl79QycBsukpEb53wsPh04A2U
         TkGsZEVDw7r+a9xUz1WqtfmwtL0HCmRqduyGNRL0Iep5ICGKHjIawTaoZSF4a5hQ8+x8
         Xf37+1aq3oJBvvf/xTTDJnR/EWjzhK0FMwc9iW9NlufDiIm9JOz0F+iHbajKWl58XJtX
         X1qQXqar70KtfQK+vxb99GJNXlSCd9NW4Ws1pcgSUX5Ht+AdSNn8bQzpNSCzfPbZXQnS
         YqzPLaoOFKSkDor8Kd6r82G8FmpLsNNrVl398Wc/sYvi+GXyow60RNDKzmNIT57gfxDR
         SFSg==
X-Forwarded-Encrypted: i=1; AHgh+RqYC51WomgUOOAqp+nS2wpAeO3vDSzFQdKGJNjzY4JmKd+UgoC5aTsiRx513Zy0rfpY2TxZJiQjKeHA@vger.kernel.org
X-Gm-Message-State: AOJu0YywoiZ49bF2lrUPVo4mXGz4fFKHden7xF7g9X02a23WM4KGw1Xd
	UEb1RTtMK9JgXKh/miX4AWhncfXih2TEJ+SPMskj0hAm6+HGuSHpkqPe8rfNAvCdxdc=
X-Gm-Gg: AfdE7cn9fMh4drta7pkFj77OdE4W1o4rAkkCEXEX3pvotup+Qrv3VJpM+PHFGTIXuzC
	BZZgVU8NgPQON2dGdWlhXMm5stmd6dO1eV5eeanCxvEEcnQyzC9uOPFwMuO+i+cyzIAsE7DnpAJ
	Zoiou53CX7K7pzy29Yme+1N+M570Xw6jpVvLomQk4eaEsjqxV3KPiNFiq0tpbyasQURjcc3yGnO
	w3GG5YCran4S3NwnGjvY8k+xES1D5TZMfEZ3MBADeXFUYVCLRu0IbD5CufGJH9dTeIwtele/Z0i
	z6oqxZ5ZTu4XbmYsvj9wrNUCvtZv5qwZHKuGne/2XXA+dZpJMYRdl9qOy9ZEfhxX9V9JsuO86sx
	kajrZakfWZsKbkvOVN8yp4VgMr0WPlronxAOmQlDT8cfhFAZU5mFXdh4uoaxlzaZEn5CX1kYo9Q
	CQA6Cc2MrDy9P82R/3oeN0dmJDWQ2//HKwazgKDk8eatHzQQ6z5ZMu8JCMz/Bq/a4eJ8w+/WnWG
	sxViEtBVjJ0nSxF
X-Received: by 2002:a05:6000:24c7:b0:470:4900:8d14 with SMTP id ffacd0b85a97d-47aaa7f8f37mr10478741f8f.2.1783322698302;
        Mon, 06 Jul 2026 00:24:58 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:24:58 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 03/18] include/ceph/ceph_fs.h: convert `pool_id` to u32
Date: Mon,  6 Jul 2026 09:24:34 +0200
Message-ID: <20260706072450.3920010-4-max.kellermann@ionos.com>
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
index 61bd6d92ff25..481654872e9f 100644
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
 	int ret;
 	unsigned long flags;
 
@@ -2588,11 +2588,11 @@ int ceph_pool_perm_check(struct inode *inode, int need)
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
index 4b37d9ffdf7f..39dad1a528b5 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3641,7 +3641,7 @@ static void handle_cap_grant(struct inode *inode,
 
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
index 731d6ad04956..d59bc904f0ce 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -440,7 +440,7 @@ struct ceph_mds_request {
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

