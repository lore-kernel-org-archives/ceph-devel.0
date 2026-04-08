Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C38347503
	for <ceph-devel@vger.kernel.org>; Wed,  8 Apr 2026 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671920; cv=none; b=gtnEmxNI9OAntAwoRM9r/wu85HWQG4mMnz3a67GRFSss/1qbrNHCleNv+H2SeW9zUQR6vpkfEY+TWmtJf6p/a1+VczmArKJgVpps5LZh6GSN5igcmBj6gFaBiCtNwiY6Nv9Yj/XLCw1pXLrQqACB56G9eyFz76o6Bot0GLM1kP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671920; c=relaxed/simple;
	bh=Zv0tNE5niA8DJZx9zdKIp+Usa6lQwTQeIL24T6SKXUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1TEDI90GPYNvpRQIqzYYxxVuphpPzqAN5POFlyUFqmw5tMnY8E1Aqw332T2cmUAvtat0Hjd4SAxjQREeO9zmquHevlxC+NqjzYH0IV23DswAaHyWR33r4XI+wvjfi6/1JABU/AeSpYmY2rwjqbVrHMaj0zw8Sp4gvydG74Avq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Lm0fBuaU; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Lm0fBuaU"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7991db3dc98so399407b3.0
        for <ceph-devel@vger.kernel.org>; Wed, 08 Apr 2026 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775671917; x=1776276717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I5akrb9d7BApoz1cA1NMQjcGhi2drcsvjolQqKfTVzo=;
        b=Lm0fBuaUO1aiMPyKjB1FsSlLYrG6wRBShbU8eLG60BIOt7q3jFnTnMImnYS0a4Fh8l
         fC0HqXDvGHLgpdFKh2M+/IEV3JaVXAACIDJP10srncYy10D/qTdDrSGsACFrhUmX1vyA
         +ZiZcwS0iT9CsrgUnfviyZfv3d7PBAfvwyNrN9v+1wi0prfF5flAVfph4hLpqCDu2Eqm
         I+bUd+bacLw5xeW7MS/nzT6ZNK+FwV0hvThFp8hvaxi3dpEQJByUpCFJG+S4VujkXTYm
         Po2uPcBosnK+NnM33z8IWDU+ocrzCrmgX6z1/IfjkeN4ZXrtUKgJtI5DNxp+VdqrBxiz
         RNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775671917; x=1776276717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5akrb9d7BApoz1cA1NMQjcGhi2drcsvjolQqKfTVzo=;
        b=YLeJXrJLyGAFo7E8zOqetVL/q11tPxG2+eJkUHCWNo5FtB1+bd/hKeyicxhMr0zvl8
         YEmOsgAOQntbwwZ4aP3+nPwGJVg2J4ZuJOHjDenNFfY1gZ/qm/SS6IyrUo9EspHyYs0X
         ojo486jqDIfdQgtFDXYrJqGT816qZ+/JwwFSTa7pCiheBajnTYRQVRHmhElOlsaikaFq
         Wj4V6SDA6W+IStxImtOUrhoWBkJy4txvKfwNUtGAzzXPLyyGvUIZyw6u3unwt8bddr3Q
         a2Zqsn1UtKMBfMah7vKe8dVzNaFhJJy0b9oaPXvl3lta7f8BX1d1y08rLUhCeJ1TfAqk
         n3ug==
X-Gm-Message-State: AOJu0YyNKwUQjw8wxt/qXkJqqhGs/djiwqR4KGXNhM4pJrT/TzgFErXF
	3Kiwu7oYaSuDrg2ggG6Eyj5FeD9yaCKXlfwxKurHzSDxZU4dHEgDUyaMB/CXcdC5AcEWgrDQw+S
	Z5UAkcAs=
X-Gm-Gg: AeBDievjzq5jJiEjIenmcu7Zkh1XUQnarz/ax70ZlulK0YOBkEmCvN6nWtyZLiJsjvB
	fWk7Z45njfBS1KOUSqgUQdqMv2vIk58na9OAa6g02XHPj2fiMTwRilHAeguTE2IpBBr9pMmw7eH
	xnfeQSN43YhVsCsJBlg3nsGi9avmGE3E1MZZs/UQwTrlH14nCJqu8PqOhbTFebNPlGR8aJ6iJJE
	IfP//96ilNQ+mQPBsKD2PAP9wOzmU1hP8UyAga9tC4sTF1obekrigH5SWJac0QztJs6qTAImPaz
	RAyzg8cuEntyTh7wWDXZlBzaHJF+ALSwIqh5mIpqMpnZsf6Jt59XVhLb5diX34yHSWGkkdAiw6O
	gxfB/w4m/LqnkPbcIDpGpzf/n6XT+zJ1dpvn8HKLib/39N2TbX3eyL2BL3wnBtTzUdQKOHMOUwu
	p9DvQIYeG5sYvElDCcEpLvWL/riHl8CstrQMLMFU10sYztfjKH3aJbntU0mA1f/Y3YUotxHA3nX
	mr3Z11SgEgkGiOxtxe0mpmkG51M04I=
X-Received: by 2002:a05:690c:c50e:b0:79d:9d85:3622 with SMTP id 00721157ae682-7a4d2ff2044mr200468557b3.9.1775671917239;
        Wed, 08 Apr 2026 11:11:57 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:de59:1272:6c6c:a235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370ef4af8sm91417037b3.41.2026.04.08.11.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:11:56 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: add ceph_has_realms_with_quotas() check into ceph_quota_update_statfs()
Date: Wed,  8 Apr 2026 11:11:24 -0700
Message-ID: <20260408181123.310291-2-slava@dubeyko.com>
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

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/quota.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/quota.c b/fs/ceph/quota.c
index 4dc9426643e8..0fa0e7c4b52f 100644
--- a/fs/ceph/quota.c
+++ b/fs/ceph/quota.c
@@ -231,9 +231,14 @@ static int get_quota_realm(struct ceph_mds_client *mdsc, struct inode *inode,
 	if (realm)
 		ceph_get_snap_realm(mdsc, realm);
 	else
-		pr_err_ratelimited_client(cl,
-				"%p %llx.%llx null i_snap_realm\n",
-				inode, ceph_vinop(inode));
+		/*
+		 * i_snap_realm is NULL when all caps have been released, e.g.
+		 * after an MDS session rejection.  This is a transient state;
+		 * the realm will be restored once caps are re-granted.  Treat
+		 * it as "no quota realm found" and return gracefully.
+		 */
+		doutc(cl, "%p %llx.%llx null i_snap_realm\n",
+		      inode, ceph_vinop(inode));
 	while (realm) {
 		bool has_inode;
 
@@ -343,9 +348,14 @@ static bool check_quota_exceeded(struct inode *inode, enum quota_check_op op,
 	if (realm)
 		ceph_get_snap_realm(mdsc, realm);
 	else
-		pr_err_ratelimited_client(cl,
-				"%p %llx.%llx null i_snap_realm\n",
-				inode, ceph_vinop(inode));
+		/*
+		 * i_snap_realm is NULL when all caps have been released, e.g.
+		 * after an MDS session rejection.  This is a transient state;
+		 * the realm will be restored once caps are re-granted.  Treat
+		 * it as "quota not exceeded" and return gracefully.
+		 */
+		doutc(cl, "%p %llx.%llx null i_snap_realm\n",
+		      inode, ceph_vinop(inode));
 	while (realm) {
 		bool has_inode;
 
@@ -496,6 +506,9 @@ bool ceph_quota_update_statfs(struct ceph_fs_client *fsc, struct kstatfs *buf)
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

