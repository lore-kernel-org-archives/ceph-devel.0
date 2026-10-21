Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792583555;
	b=tNz/2mcrQ7hHFXz2QavWkoLmOWrt4p3m8IKii07oiURdRiGE22mjiu32+cSmXd6WUKl9
	 otY/Y1AApdZqoxz3MiOoUbQG4kVX+HeY84yqV+n5Rki6otIuGk0ZcK4Z5pQaTcIkPjQYz
	 c8EAwHILsmHp/1PFJ/0zUUqBAzaVWfiLgDhthMZrENyR89SOyxkxPAtfo96v0kj21LxpJ
	 JC7MzhfuYksd/r21o2UHPn8R3n4ryAKDIkZFPOiDbyFstgQi5oXXsHc7G8YPXD+E7Yi1Q
	 Rp/uTVT8futXSX0eUtuMGfcTdDM6J/LmLBiU640z99eOTvTNo5nieuu600AIl83fPIQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583555;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	b=r4qltb3VaSGRhjL4dtUJmUp2ssin7WI78BrOpUJL4NYWJB/EIwPxivk2+CAacS2p7QZo
	 Xg5Kf4xpIEHAfwgnqGZo9tXNT56JnM8OKZjkY8f4Mm/wldJUZjsuvPuu6o29snjNrrQ7N
	 M2tddRNHlnVrRh+Q451r/WSedpZDBxrKJQEf02ytYGzjC7zxNZcjRY/GwLUc6R4+iTq/k
	 x/Naq/u5cIqiTSCzzLbiQQFVQ4iE6CjtO/zFvi9uxKz28wk+DfxpFWLVDW5cocJsUfUni
	 I0IhJ1sUZMvytql+01FIMIvSSusTBNkCUq8K/W8qt7Ew29IoOGlU4qW6g+4aogg+c+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMdRoYF3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E90F606A31E;
	Wed, 21 Oct 2026 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMdRoYF3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792583555;
	b=vwNbVfzo400kIyOxe/wWsTP+1yD9Cacj73cWgQe1mt0mkyAt9oD24jLbNQJMTBuZl7wn
	 Gjv/LjkYJcsA7zRT96IxDH13uQsxrwqr+y+9Pc5hhiXlPWPVbgu71V2qIuwrVIFI6cL0k
	 jROisaqEX59A4z5ILhMQUr999Tu9sBjsaQNyge9w2gVF4bCvToIv+dcTOyEOCZMmIKzwn
	 CIIU+AckyzzinGYeC1eObe+RgeXpXt4iU64Pf/yXIV73z4tSvl1YqwjkIk7SkgySGh2Ga
	 I09hZWR7zFFtDEResGwMHXRPBC94Ov0AgA4Uj5sSmAxGx2eHn1gLkbA70u7kUcIV4Ig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792583555;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	b=F52VTAd8samZkAAUFCke8+p58w8igASVwkW13lx/dp2xa6EmN3pL5xYz/Wdi+LjPdLwy
	 gKtiQpdj5SWpwf5K0JsE6zdlRM8uEpPZpiMwweIbFmBgh4oyDMNttFE+ymwTI/Hxme7zM
	 rand3dKFGHgm0p4y3z/0M3HmOdBfA/0BhNj8Px6tjTRa6IfLG51PXN+eP6aUZHIIxbIcn
	 rYH3yJoJZdAox1q/Ls2FjUJ25GKv9QPX0S6msO0882G+K4Iwu5dSldsJi8p50ChwGnAoC
	 dFwxfM4kqCWr9r2Dof+a9BpFybSFIasBgVCvfxTDozE3v6RROVN9cuzponvS0gadqBw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BDAFB1F000CB;
	Wed, 21 Oct 2026 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583555;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HMdRoYF3NOiNyxsIDq5PFz2se4Dvu47tZdvf3cqaQ0KmMbvrS54SRl3MuEDKkis1t
	 XJHXjK2mmr1kI8hCu8aRym66A0QzqULgc0lIq2ZGUb2bl7xjpsa1sTAmgGc+T0EAy5
	 KTcrkrrNGvefVaisN3beSvrCgGwIlHvFIruBNNEKYcWeyZRlSO884WjvSephq4kzKX
	 7jz7r3JOzUiV3628KaonnzsTq+rACxSuhSq6YfCzdFyjmw7+lhhFYsvKuwoN4lu6Cv
	 66TjdjqP3OvepzQxZ/nYMf+eP3G7mdJ5DI5tvw6a6uBSyu3VpF5gCc6xkTm+bpzkk4
	 5WHfWCpCSb11Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2DAB54331F;
	Wed, 21 Oct 2026 11:52:33 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Wed, 21 Oct 2026 13:52:03 +0200
Subject: [PATCH v2 1/5] ceph: invalidate a revoked cache even while its cap
 is stale
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261021-b4-wip-ceph-lazyio-fix-v2-1-25d28479d6ea@clyso.com>
References: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com>
In-Reply-To: <20261021-b4-wip-ceph-lazyio-fix-v2-0-25d28479d6ea@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792583534; l=3450;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=8QRSQn0Y4TVaLVXe6qoY9/nZ1m8oLxj3xBc5YKZ5mow=;
 b=nYumE/Qxkwb+5GrS8YtwEusKpRzxaR3c+W2llfIHuR4OpoKl2fHeNPAll9K1NoTByNvMwhEeD
 9WIGcneeVoaCcwiL7BWVDpNL4+B7D186GvJDFVAaI+zUj+ioHYvt4uC
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 7bit

From: Xiubo Li <xiubo.li@clyso.com>

ceph_check_caps() decides whether to invalidate the page cache from the
caps being revoked as __ceph_caps_issued() reports them, and that skips
a cap whose session's TTL has run out.  When it runs in that window for
a file whose CACHE or LAZYIO is being revoked, it does not invalidate
the cache, the per-cap check then finds the cache still in use and
waits, and nothing calls it again without CHECK_CAPS_NOINVAL: the MDS
waits for the revocation for good, and every other client's request
that needs the lock with it.  A lazyio writer on a slow client (arm64
64K pages under QEMU, whose sessions keep going stale and getting
renewed) hung that way after shared-file writes.

Ask every cap whether it is revoking CACHE or LAZYIO before deciding,
and when a session's caps are renewed, check the caps of every inode
with a revocation pending, so a decision put off while the cap was
stale is made again.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c       | 12 ++++++++++--
 fs/ceph/mds_client.c | 10 ++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index b27bcdc24d29..ae7b62b07462 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2260,12 +2260,20 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags)
 	 * have cached pages, but don't want them, then try to invalidate.
 	 * If we fail, it's because pages are locked.... try again later.
 	 */
+	/*
+	 * "revoking" above only covers the caps that are valid right now:
+	 * a cap whose session's TTL ran out is left out of it, though the
+	 * MDS still waits for it to give up CACHE/LAZYIO.  Ask every cap
+	 * here, or the cache of such a cap is never invalidated, the
+	 * per-cap check below finds the cache still in use and the
+	 * revocation is never acked.
+	 */
 	if ((!(flags & CHECK_CAPS_NOINVAL) || mdsc->stopping) &&
 	    S_ISREG(inode->i_mode) &&
 	    !(ci->i_wb_ref || ci->i_wrbuffer_ref) &&   /* no dirty pages... */
 	    inode->i_data.nrpages &&		/* have cached pages */
-	    (revoking & (CEPH_CAP_FILE_CACHE|
-			 CEPH_CAP_FILE_LAZYIO)) && /*  or revoking cache */
+	    __ceph_caps_revoking_other(ci, NULL, CEPH_CAP_FILE_CACHE |
+					     CEPH_CAP_FILE_LAZYIO) &&
 	    !tried_invalidate) {
 		doutc(cl, "trying to invalidate on %p %llx.%llx\n",
 		      inode, ceph_vinop(inode));
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index d4ef8a355a48..dc8ecd771620 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2138,13 +2138,23 @@ static int wake_up_session_cb(struct inode *inode, int mds, void *arg)
 		spin_unlock(&ci->i_ceph_lock);
 	} else if (ev == RENEWCAPS) {
 		struct ceph_cap *cap;
+		bool revoking = false;
 
 		spin_lock(&ci->i_ceph_lock);
 		cap = __get_cap_for_mds(ci, mds);
 		/* mds did not re-issue stale cap */
 		if (cap && cap->cap_gen < atomic_read(&cap->session->s_cap_gen))
 			cap->issued = cap->implemented = CEPH_CAP_PIN;
+		/*
+		 * A revocation that ceph_check_caps() put off while the cap
+		 * was stale (its cache was not invalidated then) is not
+		 * looked at again by anything else: check the caps now.
+		 */
+		if (cap && (cap->implemented & ~cap->issued))
+			revoking = true;
 		spin_unlock(&ci->i_ceph_lock);
+		if (revoking)
+			ceph_queue_check_caps(inode);
 	} else if (ev == FORCE_RO) {
 	}
 	wake_up_all(&ci->i_cap_wq);

-- 
2.53.0


