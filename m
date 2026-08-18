Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED24854E7
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076715; cv=none; b=ZulQVTrcPt6eHPqQDQ3V4dVYhjC1YLpKkXYtyXXRG+7APMbkYj/EhwCmn8YFbpDrkJx2QokU8r2VoltGtUKIPSpev03cOqTLsLQG15Ct5qQPCT17VIjASUwrX2hxmBTOUnf1rUY6405k+KOvKo2vRhrLpV14gHMcdQBvZauvvzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076715; c=relaxed/simple;
	bh=spohi4066YMjfHPtqROzqn34a27EiH9ElD9O/6aLbLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8MNZG0ouU/wW4HV+RZKWkbRFxT+XxNci0q3UauNK0q2Zz21LynJ018ANsbBMyWjooxlmKOOok81DSH1NMyITpJKI5EaoWdg5Ku68CPFfqfN4XZMRMYObQE+vERv+2bQuQXgZ8t0w0+n0GrcRkHULcCTuRaWqJw110AGzPRlqn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=jMbaBgi7; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="jMbaBgi7"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so90861f8f.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076710; x=1787681510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ux0lu9FQT0gRJf+GGs5dOF6JEoNBqOqUh6OH9cCfwog=;
        b=jMbaBgi7YxMSlwdHtiAG/37tnBXoOD9zp1RmjdLl949/tyqlzVnv/ixtVZnc+w5LQx
         mGf11HsUtg9b9TfQpzPWTWJ/3EEkRzCd4pHmZRcTgmS1ciSbuUSTEHSEMb06kTKXv1cr
         y3g24mUU8mLuMpbSrbHJuzgktZJCPNifzTdEwch0tEternZ2W32g/hPva7twJsXo8vmE
         ODKkPS8+BP8DpviFa6Et89+/KFKX8c7fif7nl2CrahJDpE23v7F15TCY0YjiWkQHdINh
         OprdsxLU3YYEMcX45DOGWb/vVvDfBzGVRUJtFRTb7D2Xj1mt+lbpC3z6VHjYVrG0JQcx
         BE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076710; x=1787681510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ux0lu9FQT0gRJf+GGs5dOF6JEoNBqOqUh6OH9cCfwog=;
        b=qliGVpU46Rkh732rrvSKSAmJ+D15x0dzvdzXsvN0ju2H1zss6y0MHxKMqiA0YSuN/2
         LfC6/KeaO7jo76gRM+sXp+CyJ1kuKfZkqvyh0v3FLlWN3pefFcikqPB256vVGnvsVKGS
         q/CXIhWJSfwtegIsQhKyKsQOenbZmINK/XUXCiXzjL2opiRHnKK6fOU3FXRDokRfQX+e
         7YEQnFYhPcaV58W82hfaBiCgWnfS+g87yMIj4NsSfT1QqIS46FGpWoF7P4oI7fb2Hmt6
         NzlYqB+EF6OY53j+I+EvdW5PH0aHxVR3MxDSOqb4zYZVqoqdZJIv/R17GzQj5Jm+My/b
         R6fw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+FveILhrvWRUoHddX2dK752Hh31ScvyPJWtSzGSSWdO9x0e/uKia2ZiO57a471JIfPC0M7wqRVKjd@vger.kernel.org
X-Gm-Message-State: AOJu0YwleyteKj24+YcgJJ1r4wcna7DriAL9rfLszI2Tc4RkKD5fIpqg
	/HS77kPfTtqTTRSel6J0V4h1Lo7lI56Roq8DP2eRtKD6tJbkq2jgxQo5m6xnTUiNExw=
X-Gm-Gg: AR+sD12gByXTTQ8ZTKgxkOhCuWsjkFi1thWtI006SwBU7P8FMYVT7X5U4PjwgGL76WG
	tI7vNRyZdkqetcleTUvLkT9SFeo+x6kWGI8aD8wznzJNgpkin8D5O832V/D0qxkgFsFQbDBr/9C
	k3yDGTv2cyZ1I4m5IrUDfT5n/XWAoqwWdBi07nQJmnBhGpHpqOy3hk8UE4g6Z2Rjh1YXXKUdE4W
	Ppb28M8dD70nhTLPH0zmXtgITMTZYgXd2+rSDJsp9SdPKxucl2x2dFhF9QVP5VP8/5bPvQmcCC7
	sc2/OPcBJGe44TFpVhlYDptli6Yi7gDIovnsgNKm+nwojdlV0vVY0+jaXbNok9Je8CiiDgKOtTF
	d+XR7EAic8cHY9StN6cZx40hiovs/XvyFCMcDj1s5IYgZK2ypoYaqJsMrhLNJTCwVgqB7UZKHIg
	+oSZq3YmjxpJzLDx+Ry6AwtJf+StfpNQzeQxk69hUEDlnH0OvG9cXTEwEyFIHqZZeIMHk2cYaTj
	JQi9sQh4smzMT3fa9WUdRNmsJkBmkrcEGim/hwYbwvTOCzIzXOo6RagHcxjrm8jtBcHTr9tISY=
X-Received: by 2002:a05:6000:2406:b0:47f:7129:e30 with SMTP id ffacd0b85a97d-48160710333mr58124995f8f.11.1787076710436;
        Tue, 18 Aug 2026 11:11:50 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:50 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 03/12] include/ceph/ceph_fs.h: convert `pool_id` to u32
Date: Tue, 18 Aug 2026 20:11:35 +0200
Message-ID: <20260818181144.3541770-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818181144.3541770-1-max.kellermann@ionos.com>
References: <20260818181144.3541770-1-max.kellermann@ionos.com>
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

