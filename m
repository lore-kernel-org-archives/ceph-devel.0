Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C603328FC
	for <ceph-devel@vger.kernel.org>; Thu,  9 Apr 2026 19:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761279; cv=none; b=Sh63IYIMfI/O6t/hLHQnQWmeU25jvoFMrSDKjBOEu+CgXCdqHs6zqW9u0G8FJS05sKJFniL35tOavpIjIC2nO6MEEeePK8pZfCBf89ZL/RsUo/Rj0r/bAyaNotfRdTDhOc6qhLd2/o7/ib0L9DPJK48mxAepEzHcyfpH2CRxeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761279; c=relaxed/simple;
	bh=hY0KfO1K/z022Q1PuKLkfRl6gjvByumiYd+sln7YkjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tCBolDBehILaBVRIzi79nNnrvmKNK8g/MLkJzeR7YYaoTcEiPeVMCIai3N5IDttZRgbCwdT6jzrEHOFyP+D/EHqDU5Ipwjmyivf5doW2bZsi9ISgqtnt1QaZnhclRahpe+kQ3SMOVZ2MtSDUIpFKGk1vGUWzoBW9VfXMIUrMJP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=U4+H5Moo; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="U4+H5Moo"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7a4f9cf2b4eso10685797b3.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Apr 2026 12:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775761262; x=1776366062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YK13ZqqjQ3wLQBdIjTUYThCV1qQdnIxPjzSA+72DBJY=;
        b=U4+H5Moo0wSNSVkmoo6xJ0g4fwkOXJ4+3ih7FwfzZO6gV935U5q1dyLCd4QMAmahGc
         k/jRp4NK0LF+GJ1O0D8+RfCr3PSmNw1noBDByluUmmnwumEFjz38Cl7/UFJcWYfAiZZC
         rXIXcvEZIqKbEgeFsd7yqns5ZvNSRr3fsZHLuyiCqWHaAI6FQOP/fNRXesfJ0axjF25t
         Hvga5ioeQh4enyuXtzq60GtelfrH/hyj9TM3REZvhyOV84AOVVzClF4bQfpa20Bvnxr6
         1jcYdzmJXj8k9XpO2/SWVQZ7H2dNUXqaudzF/VbXnFjWiyXPYLc+e0Th0FUIhYkfXtzz
         KnXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775761262; x=1776366062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YK13ZqqjQ3wLQBdIjTUYThCV1qQdnIxPjzSA+72DBJY=;
        b=CDh1sZmykFE3NswrnXdDcO56Gd0rOPM5MsIGlc4n0QIUkSkuMOYtMuWu4NIR0ODAFJ
         flJLkhp0EDEJL1N8CK7hQFCcleOZY2lkAw0AeDL/5MpnPdm7DUgKjsaLW7NIHoBVbjgo
         mu3AWJExN86UZ3uwWYwPFbUQV6iX24ShSzibxinHB8R0sCOPDJrUshIk8H1Z0wnvINTk
         3ieEeRnpkdfSSbfXNwJ+YUbse5yDbDljWQHAGWZQm+UJdL3fyLJPNUwJ2OCUudLCr7GN
         Vd/x3U2vIK0d8p4enoKBUYLhYbcLQm1UeMFWHohXtYdVcBN/T0bvwMzGqMFCRGnZPbOZ
         E/PA==
X-Gm-Message-State: AOJu0Yy5yXZIoLm3mT9Lc7swCfdcm26ghJbLNAyxnJx+mLPwyWYqpqY8
	5R7sKaNSJtOa4nwrwHyD3/kFjjHpqd7ampyjRjnAbfn9U0QoTZfbWfqj/bqVvVIr5Jbl/cwzmPv
	VHhHYEm4=
X-Gm-Gg: AeBDieuIDpLKGTooWHQOM2Q/D174o+K96TuWtMS8Y0Jlc4bjMCC14+byU9f6fkTEwLj
	MTk4FHt2/BTdbYLLFNfjsmuqhnf0HLq6PDvDKPkurTr+1KPfcpr+ThOIvED+lJzEPDpCOTfL6SG
	qIpmdkHCbLpPUlGXYgB2SSksa4cEqmH5q+UkZdUfodBMgPtIKOVj9Ar3n6YsAJH9hk7c7Jw2lvw
	v4aL5pRPwE/bAqGo34MBa70FtEetKJCr4Oxsile6lUJSOPcBbTEp2c/IyuWLXvqafsr81JUDtMe
	jiE99kaxy9r6JKt2yEZojdLnnrtP/WOx7X9H8+USr8PI68cv9tSGtcGVt90zz386wGOVNhjB+Zy
	jiSdmc88Zf9SXA23Ja/cNu3+zMzEP6uQ6k5Wd73ns4zp3aKvC6qACZihxUXPS8RTrySpKUtWCZ0
	gGnhv35VG8qifB7RznaxV+hAtn7opzVb+63gzy/3OuLC0lxcyWc7I+3Flx03jQCWAgHirKBIiFh
	jpjFgwnr8eV+SQln0IBu4+HMwNEThA=
X-Received: by 2002:a05:690c:dc5:b0:79b:cf31:9767 with SMTP id 00721157ae682-7af6ec4c6efmr1873047b3.3.1775761261647;
        Thu, 09 Apr 2026 12:01:01 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:594a:e569:c7df:c654])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3d6a9c87sm2899607b3.22.2026.04.09.12.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:01:00 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH v2] ceph: add ceph_has_realms_with_quotas() check into ceph_quota_update_statfs()
Date: Thu,  9 Apr 2026 12:00:47 -0700
Message-ID: <20260409190046.317760-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

When MDS rejects a session, remove_session_caps() ->
__ceph_remove_cap() -> ceph_change_snap_realm() clears
i_snap_realm for every inode that loses its last cap.
The realm is restored once caps are re-granted after
reconnect. It is not a real error and thsi patch changes
pr_err_ratelimited_client() on doutc().

Every quota methods ceph_quota_is_max_files_exceeded(),
ceph_quota_is_max_bytes_exceeded(),
ceph_quota_is_max_bytes_approaching() calls
ceph_has_realms_with_quotas() check. This patch adds
the missing ceph_has_realms_with_quotas() call into
ceph_quota_update_statfs().

v2
Small cleanup by adding braces for multiline if-else
statements and changing the comments.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/quota.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 4dc9426643e8..67ce1ff1a421 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -230,10 +230,17 @@ static int get_quota_realm(struct ceph_mds_client *mdsc, struct inode *inode,
 	realm = ceph_inode(inode)->i_snap_realm;
 	if (realm)
 		ceph_get_snap_realm(mdsc, realm);
-	else
-		pr_err_ratelimited_client(cl,
-				"%p %llx.%llx null i_snap_realm\n",
-				inode, ceph_vinop(inode));
+	else {
+		/*
+		 * i_snap_realm is NULL when all caps have been released, e.g.
+		 * after an MDS session rejection. This is a transient state;
+		 * the realm will be restored once caps are re-granted.
+		 * Treat it as "no quota realm found".
+		 */
+		doutc(cl, "%p %llx.%llx null i_snap_realm\n",
+		      inode, ceph_vinop(inode));
+	}
+
 	while (realm) {
 		bool has_inode;
 
@@ -342,10 +349,17 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 	realm = ceph_inode(inode)->i_snap_realm;
 	if (realm)
 		ceph_get_snap_realm(mdsc, realm);
-	else
-		pr_err_ratelimited_client(cl,
-				"%p %llx.%llx null i_snap_realm\n",
-				inode, ceph_vinop(inode));
+	else {
+		/*
+		 * i_snap_realm is NULL when all caps have been released, e.g.
+		 * after an MDS session rejection. This is a transient state;
+		 * the realm will be restored once caps are re-granted.
+		 * Treat it as "quota not exceeded".
+		 */
+		doutc(cl, "%p %llx.%llx null i_snap_realm\n",
+		      inode, ceph_vinop(inode));
+	}
+
 	while (realm) {
 		bool has_inode;
 
@@ -496,6 +510,9 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
 	u64 total = 0, used, free;
 	bool is_updated = false;
 
+	if (!ceph_has_realms_with_quotas(d_inode(fsc->sb->s_root)))
+		return false;
+
 	down_read(&mdsc->snap_rwsem);
 	get_quota_realm(mdsc, d_inode(fsc->sb->s_root), QUOTA_GET_MAX_BYTES,
 			&realm, true);
-- 
2.53.0

