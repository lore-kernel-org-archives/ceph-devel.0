Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F13D3327
	for <ceph-devel@vger.kernel.org>; Thu,  9 Jul 2026 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593695; cv=none; b=mRU15xcURtvLcHphl//ARQysRZqICOtN8xVJ4AQZlJQ3DbNxNSVedjK43D2f7Kdwa8wngaxe/l2O3HDoHUq0WLt7SgcUYiYDAO0zYjA8PRXAaT9mgAvC4jxpdWyROW+T6CcVmVAU3EJbE4FgedI03G6+0uGoxd5+cCRtWd/Wa1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593695; c=relaxed/simple;
	bh=KPbPCOJupLtgbfkwQuiY9y4rmSQ6+kX2kfa34PpTai8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q+6rlBzoHCnOwcPKHglDAan+7aaWUfNRt2VS4fpkVuV2wFvao0NCawiUR/IlmK91FJpCdQjxgnZuAO+YdVl3CCxw/tdsGHux06zXA5igbnmOLGXM2E8S5RnYm3U9qqFSnMDLTGRbmdt6WSE57vaEbemEHmzlibYmXbGZpy74oaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IROYPzcG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IROYPzcG"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493bb510ce4so6006775e9.1
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jul 2026 03:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783593691; x=1784198491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VcxBreFtU0+wtDz0xoOBoUPW2Ts808RC7/+0WsMP7qU=;
        b=IROYPzcGNs0XcLt62LkXDbF8wcv2aZT9W7UKDo3fwrdyYQUcqnBusjL8NcsGRHFNPh
         u2Pl1k/2yH+GfMPaV6c6cXidreF5rLpkmOOf7ygyLxfs3Djds7FYXJYFuwgA3qYmRpf+
         C26os9LU3r5GgBhbuDtT/6+NK++hKwD4KlD1j5Y32566SoK1ix/hARNJwXT8DmjzErlk
         uZ4kNreC0f+eShSm9cSoandkZrbPqczWBgwnUaz8VsIPfJ+VKp2p5jLfGxIU4404zvs9
         qIa54QbG5vq2KUB6Spk8zLtgm4Zf4t0WNGq5UJlUJWBcy1WHk7BNxIYtbG9ckzxtN2C/
         FFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783593691; x=1784198491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VcxBreFtU0+wtDz0xoOBoUPW2Ts808RC7/+0WsMP7qU=;
        b=ddzHD7wOaiPyMYG/ov4SikaWZkfLJHkfqBKn9wAMpKF+7bt1Bl4z43+9vvER+WXjDB
         pJEuU0apxpCRKXAPjlR+BDmxsIPNvJvWwRNRD21PBxYQMuVlW9nttzU8hMwMvHcomNbC
         4QqT1yS8DrvSBMIL5+lsATLMeV+sXtCHZp5UND38jIFPPLTEj8OnA2ynVXdLHatn8XwH
         u7of1rkiYDj0RBRBHI4M5pFyWtE1SQHT3kux1Dpwm31NDk9l4KZM+TkbPPlV/ECBRGmC
         2EXaYcb13HMS1NmUMXREooucNFERGe8gdBjKqIEzRsn6scfjUA1kcLCbiDQJshcXeCrD
         FYcg==
X-Forwarded-Encrypted: i=1; AHgh+RqCJwG8OY3d3wkb95rzuQzvTTXJYBBLXdSOCGNQVVGRnm0G0bVYo1UsQ3dKKLBXvhBerLnWVSKr87Jm@vger.kernel.org
X-Gm-Message-State: AOJu0YznRNazyCHONYC3YF/HXoimTplv8GMAhCyvqStOtUwPuuLxIQO2
	M2VsV3FSScFe3Bzg/1XVEeVPdqVBN3/u3mI8em3yIKHjCx3A4O9x4M+cxF/2bHty/z8=
X-Gm-Gg: AfdE7clRcqF6bCDGdoThHOCUI9ml40+IxFSkX40GzLcE4v2GNrg4pAMALgDcPD3uIHZ
	tXhijMAmQQqzJrq/9WeF4kY97dabaJN4Njh+V9nKaLxdt9NPfwkl62YJXCBr1WzSMF47LAVGalW
	OtjlnqgenniEp6+U9ZA4CdUKkfOHAaWbLfWy6IGsq/1pPWW/fTvVrB7q2+nTDomPJbIeTwjZhfq
	3+DaDBph3ihmupR+XZ+Ub3fOESi7erRJf71Nebe8wGsB9CwMBVaVWx475u0P1CjqsvZM/EoOsRy
	D+qfzl53w4aaNicGVOJy+IsykLlIGMyUhdsH7VXAq7aAzbvQe6o5hlyiNQQBSzV/qdRJ/mnHqwG
	n1HQfI2cT3TuThgTscbC6HE6ZuEaYvVC81Z/F/KTTfVBHGVMBbIsqKPiKTRZ2TSYltTMYGzht7N
	81ZC2ykJ2/PHCZ5LQtn3pxFx2xFuPWuEGS6r+fFtW9IaIK+YpzEt9l4XJ6tswvBwh0imTH5arpA
	YW6wkf4lTiCZ7fH
X-Received: by 2002:a05:600c:6095:b0:493:c453:600f with SMTP id 5b1f17b1804b1-493e68aed40mr60747805e9.6.1783593691014;
        Thu, 09 Jul 2026 03:41:31 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f34b400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f34:b400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb742a49sm50255765e9.12.2026.07.09.03.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:41:30 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/dir: __{dir,dentry}_lease_check() returns an enum
Date: Thu,  9 Jul 2026 12:41:21 +0200
Message-ID: <20260709104121.884183-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The declaration of these return valued (KEEP, DELETE, TOUCH, STOP) and
their use in __dentry_leases_walk() suggests that these are bit flags,
but there is only ever one bit set.  Converting these to a
non-anonymous enum expresses the intent more clearly.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/dir.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 27ce9e55e947..6b1891289ff9 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1626,11 +1626,14 @@ static void __dentry_lease_unlist(struct ceph_dentry_info *di)
 	spin_unlock(&mdsc->dentry_list_lock);
 }
 
-enum {
-	KEEP	= 0,
-	DELETE	= 1,
-	TOUCH	= 2,
-	STOP	= 4,
+/**
+ * Result of __dir_lease_check() and __dentry_lease_check().
+ */
+enum lease_check_result {
+	KEEP,
+	DELETE,
+	TOUCH,
+	STOP,
 };
 
 struct ceph_lease_walk_control {
@@ -1640,8 +1643,8 @@ struct ceph_lease_walk_control {
 	unsigned long dir_lease_ttl;
 };
 
-static int __dir_lease_check(const struct dentry *, struct ceph_lease_walk_control *);
-static int __dentry_lease_check(const struct dentry *);
+static enum lease_check_result __dir_lease_check(const struct dentry *, struct ceph_lease_walk_control *);
+static enum lease_check_result __dentry_lease_check(const struct dentry *);
 
 static unsigned long
 __dentry_leases_walk(struct ceph_mds_client *mdsc,
@@ -1652,11 +1655,12 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
 	struct list_head* list;
         LIST_HEAD(dispose);
 	unsigned long freed = 0;
-	int ret = 0;
 
 	list = lwc->dir_lease ? &mdsc->dentry_dir_leases : &mdsc->dentry_leases;
 	spin_lock(&mdsc->dentry_list_lock);
 	list_for_each_entry_safe(di, tmp, list, lease_list) {
+		enum lease_check_result ret = KEEP;
+
 		if (!lwc->nr_to_scan)
 			break;
 		--lwc->nr_to_scan;
@@ -1677,13 +1681,12 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
 			ret = __dir_lease_check(dentry, lwc);
 		else
 			ret = __dentry_lease_check(dentry);
-		if (ret & TOUCH) {
+		if (ret == TOUCH) {
 			/* move it into tail of dir lease list */
 			__dentry_dir_lease_touch(mdsc, di);
 			if (!last)
 				last = dentry;
-		}
-		if (ret & DELETE) {
+		} else if (ret == DELETE) {
 			/* stale lease */
 			di->flags &= ~CEPH_DENTRY_REFERENCED;
 			if (dentry->d_lockref.count > 0) {
@@ -1700,7 +1703,7 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
 		}
 next:
 		spin_unlock(&dentry->d_lock);
-		if (ret & STOP)
+		if (ret == STOP)
 			break;
 	}
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1733,7 +1736,7 @@ __dentry_leases_walk(struct ceph_mds_client *mdsc,
 	return freed;
 }
 
-static int __dentry_lease_check(const struct dentry *dentry)
+static enum lease_check_result __dentry_lease_check(const struct dentry *dentry)
 {
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 	int ret;
@@ -1748,8 +1751,8 @@ static int __dentry_lease_check(const struct dentry *dentry)
 	return DELETE;
 }
 
-static int __dir_lease_check(const struct dentry *dentry,
-			     struct ceph_lease_walk_control *lwc)
+static enum lease_check_result __dir_lease_check(const struct dentry *dentry,
+						 struct ceph_lease_walk_control *lwc)
 {
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
 
-- 
2.47.3

