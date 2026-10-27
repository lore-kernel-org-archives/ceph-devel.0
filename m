Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793084465;
	b=TK/CGR5cdGfniOF/Yne8tJkGuNSB+rNcucgB8Xg+L3x7P38aXEqpDmFUGkC94tcoNw8H
	 mjAf2c/tODTNst5jL5N+latD4dqsyfr1Tcc1BlwBtVRTEApyaaIuI/Sf1pQEF3Jt9DAeA
	 +/uBAlZAmezsTyKoYnVABpgH8oXaRpE5fLA3NgUhQIbStC+Gqu639QcHqd+mR5JgGHLBl
	 mWC1K/KqOZvBe3+0xvhYSNv9TiHq5bo9xXOrQPfH5mpVWW81K0HU5ekPZqqvkvj5sRmuO
	 63WLxbItm61cqUFmLil73PPrqH/3TW0AU7kZgD1SZVuMjwm8+QtRRKb7u5hiRYi4OSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084465;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	b=HW97aqPyjLDXoDGbseHIEZzKuMdy65WXSEmVLeYPefw1ScNxT4Vu4mJTWq5tIsPt4mDe
	 4OlTIpqb9Lb2da8SXlYY1kRXHY/Pm1C1OMTsfOZL8MoCw1k6qO7Z5YVI/PHa5ESE6kV3E
	 f47SdBSNplrlVNWnJ9qzPTSsbzjRde2WHRs7JPFi9QAiaQbJ1+T0PgLbN+nPcZlpjUnHB
	 maqOnOKmiP9IAz8W7Xk9sRNEgaTdWvQpPGMjyxtNsCmj1H3t/5xDX1y5Epy+p8xd7CGQX
	 0f6swZVcsYz7BRK2lWlqj4L54YrUVk/JHrFuWg5CRxp17XWsncE6lwA6PQoOpClpAhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UscR/jb3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4C606A325;
	Tue, 27 Oct 2026 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UscR/jb3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793084464;
	b=mQAjTzmpZ5bn8kiK8PtLHaSvW/TM7gUu/MjBA2Wyd4hLeosrIdB8UVv0BlEz/u+d5mM5
	 2SkxNGVGixHACVqVc/HszukVmtNIJf0PTkHZxGTLPZN/n+r1nr+P4UAlJ+M6eD0QvrwaP
	 kEMcWXwFHA8E46DnTF+XWTmhyAgNQVJQGLChjMITg5QPobUTvi8hQEgAtSEKUcv3HIINO
	 MmLG0fgEZklKaMeg3GOjr1VKHzcICeUFKT2Ag1g9YCbo3FlYnioe/5TRdsKhZJWsLMV39
	 7KAaBJBTn1yqoAI7ByxM1l7fDnjIsV9Zw93NpL6BUnmkvjNw2LaCY3d4WeMwLeXL0/g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793084464;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	b=g/J/pbTf96qOVU58oTp/evmY7K+enXH0eHaUYAg68ZsLjaGALwU13Y8t8Xdjn/nJUdz/
	 tBGQEA4SrsugojFRaL+9Q7BOjO+F0G4blDmKnGlTSP2T3DguOkOWlKebmJ8qEDLIRUIgz
	 V8TZjSsS+EFLd3AqZ7pmhw3CCyyJfUh/3Zh0RoTMTXgH2JWph4DjliKyzB7VIEebPzXwx
	 SwgjWFGdl3fAF4pRiezS6kJtBNiyoWxjtJkTAQq278B7xTQM1ZSEjDWsW9zTIRxW5JZsV
	 wGdMXt5jRQhbXuM661yqbLvyiBR5qjtm/8Ee8jtrJfbcQbR0UtVe+e5+oXDxbRTCVTw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B2B181F031E0;
	Tue, 27 Oct 2026 07:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793084464;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UscR/jb3F9JwU70bf1IA4JgTYIcK+wgkPiEoQIPUmcN7TMStO/o6UYK9rmWPD7jPU
	 BYwM5CEr0hBqdD8OCj93lLrK8Uayd4eKoB6Uz9Nb9+Z4lPMj9VrxBjf40JtjXt8Hqo
	 RdSCk8Vu5PK76jc8EEzJgfsIpObL8zRH4/zE23tUaFt/lbW5Xp37faY92xFAoIn6Te
	 w/VeV9fuD0YXxrsbXEw+lU5Asdqrf67j+FeS5wfHGX6O2GkFwKRn79gvFTPQrgFAzZ
	 tLD/seyRXAiorTKl9bj9fA4Ihvvnoh5hMw1Mob8yuuApADtBOyqZbCcqnhP/1zuYph
	 V8ldf1yCtds4g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1D73444FE9;
	Tue, 27 Oct 2026 07:01:03 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 27 Oct 2026 08:00:45 +0100
Subject: [PATCH v3 1/5] ceph: invalidate a revoked cache even while its cap
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
Message-Id: <20261027-b4-wip-ceph-lazyio-fix-v3-1-df2926c30867@clyso.com>
References: <20261027-b4-wip-ceph-lazyio-fix-v3-0-df2926c30867@clyso.com>
In-Reply-To: <20261027-b4-wip-ceph-lazyio-fix-v3-0-df2926c30867@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793084460; l=3450;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=8QRSQn0Y4TVaLVXe6qoY9/nZ1m8oLxj3xBc5YKZ5mow=;
 b=1ebnCVt5VLm4FD0zBjLY3YJbOHFhjIIwxsa/+1yyWeWhPt7gC/QztQbyYe8yQuir6UkRA5Nn0
 kDqjS7MqpECCoPwqBbPatajjW40ONkI2CpF+DnXjTpvMhMreuL3RBlJ
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


