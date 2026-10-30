Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793347674;
	b=rR4MQHL3sDLj4pxLFCl6LYfjtfbJ0sWjITYJsTRhdsiq8iTp7C+lGGL0EI5Llxzl5LhE
	 8MMcWuVnUtZA2YmJ8yFy0lcwAmMjHasPajhA3kB9VHkNXq10ZuflcNFnFosV87ZM/IlUr
	 P+w6xEug9cl7q6OwkiA5hkUMDQuzfmGLAfqj7U0QLb4ScgCgwpul7NcfFQ4gQ4O8JKyNb
	 588/Fj/qA7mYsKMSLd/WbS9nmikc/ce7A6ejKe3rOc0h1fPCJrLZ/FP5uj9zx2+m0oNfZ
	 oS8kKfETxxY7d9RR/5jRbc13qis6lazXbSqq4ZXDxKZnjMgngTEHh/JbLA9l/l3mk2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347674;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	b=H4SkR0ZYWKuingHd5/c1KIu6fBbpLmV6iHvGZiNk4nnlGIzmN1B8nA0mnMDxpV4X4z5Q
	 2kWJOsjG+ltua2xKJEOF4PFnGD8I71NpSas7UgPHvnq60wetULm/ouQU1/J2tR8tdNgY4
	 IQA4OpzIL5dNUyODT+EGI7t07WZ04K7PJO6M40VWzw1FhO3gWpqOaz5+asqXMV3Dc/IMA
	 O5XsHgxHvrPLjD+gAFgHYLvilsLHBhg33i4ysK3UaVnR46S8dTyfGkvUQVF7lry+7Khsi
	 yUXFbXjkZm4mYAvAQO07YgB/h2PPayprbYTrpFyHiwwTrb0Eeykx+MhNS9VZN8NrQ5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVOk7G9z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB6606A31A;
	Fri, 30 Oct 2026 08:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NVOk7G9z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793347673;
	b=neEYSjmt0mXWkaH6SB8+6nBYmBEGSgjCYKw5OAJetwDB8kKmW6SIEuh+9qdt4F8RR7et
	 ziyCVUcPvPxYvtNJn3p4m2v2FtuRZBkBlc4xJ4dSJXfc6QQMb593SyZnd5IxQiMQ55Vlj
	 BLCaQ9zVxARapptfnPt6U5TgXoiKbmrOayG/qr3xK5eMLV/whfgeUy7amDt7AaYV14Ndy
	 2wcG7Q1n+HqN21FvghdL7TEZCgduoIyut+aMOtPOOlNf4PfFx2oK/w+oy4l/qsLBD/age
	 7L23uR0jH/D/e9CVq6ax/O6TlFsqm+lZdTkTh62wMoX+DAws2uQx4+NTVS6ZIep7YTg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793347673;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	b=27FMYFuwbb8Pza+izE81FxQzA7uiTCwBTxoSMegPhg59cepdGmYXoRIuorpxKp0dnTYW
	 UVPQtRrbS+wH8fftNPd0wTHQd0vQGgV2zWjjsIB0aB8hmB6SP5K+mqs5RR12UxEOv59N/
	 4kYBCBJMXb6GjqDScRkyIl0PAR2SgQJwNjX1io0JRgaLNOShMqbwk+JWtCn6F5/SrowL8
	 veTfJShVLMJa4SwfTKILp33ylUGmisivZZ5pe6dsDrq8sgnSt4v2bMpJpcsfU9m2Fm8gv
	 yGleJVouViFeqtQhgPEgrD2f9KpafOSyH1mkQyub45eye/GSwn3YuIOUoXCRnXawTSw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 210C51F0093A;
	Fri, 30 Oct 2026 08:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793347673;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=NVOk7G9zmF4tpab7l4wRjQnkvzdhzqx/cagmwGQwJ3H6F8sjuGldvutsIP65WHh2Q
	 d8+EW7I29cLSkkiM7xUYJy8lW/1d3gXnB7Cuc6YV2v8H1e4X0OBQBDmTSkYhAyb0Q7
	 7/SCS0Bn9vQIEmtlEO5Tl8aqPy0HRVh1B6qHDP0AillSQR5V/ZeOYpnVfZ8kT8xR80
	 tgtcOJWH9wgjRVuU9+zxUagXuFYgaYMiWu8sG3VHDe5W9kKo94bYE9gleAiE9QLauK
	 joUGlmiEQ03ul5nC0WCZu64cYk44+trHBplQjNum5Qg4ZQ6o5b0cXlg2Ii1CwPX4Ru
	 1miinpP5yFDeA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A293A436BF;
	Fri, 30 Oct 2026 08:07:52 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 30 Oct 2026 09:07:33 +0100
Subject: [PATCH v4 1/5] ceph: invalidate a revoked cache even while its cap
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
Message-Id: <20261030-b4-wip-ceph-lazyio-fix-v4-1-f734a26bbaab@clyso.com>
References: <20261030-b4-wip-ceph-lazyio-fix-v4-0-f734a26bbaab@clyso.com>
In-Reply-To: <20261030-b4-wip-ceph-lazyio-fix-v4-0-f734a26bbaab@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793347670; l=3450;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=8QRSQn0Y4TVaLVXe6qoY9/nZ1m8oLxj3xBc5YKZ5mow=;
 b=JDksaCLY86ul6/TMCeBEW+hlgW2u8yYXAa4FcTvzF49aJWypKiTolsE8qMXAkeTUu5R+igGJg
 k/MWfOr6h7EB7k32GYv2SG/UDeIQvllqtixZHAJyFYMS+WyioIwPoy3
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


