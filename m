Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792483571;
	b=eKV4hoHyGOzNITG43+tPrSxiQnCsCABOX6yKhGqGd7byzHTLckcT1KERczaug9l5YhUM
	 AomSlFyZqO72YM8W8FWo5Mavvrv5HMDHHw7mD/zF67ap3pPRq7CzZrfTed9Qxo3UbuXCf
	 /LI9kmlVlbeDReVsI03X1B6oHlp+X3A3d2zY3GD2upTBSZWDs6dAkd/MeTMG5F/vV3p26
	 lrp9JzDMyvRfSdksFGlDCiGgFWugLKq4jHtvXP17XL2zvPqgHmOsLDCwOOCRvcHEDefHW
	 JGMQAT97hEz4WZZKz6SLZK+sDnCliZTGUewF6LkoeDLeCZM7TurKhFM55meJxaJlocg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483571;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	b=QHlZqzcDV92O8u8k40oFArb/TvwMt4RmOsYUiKDjVCZh6LA4EDxqhCFv4J7aMlevWNvX
	 03lzbDSkNXaqsBiddGiJvIHtgD3Cxy80Q0xgSo/XNFpdjhiQQI7SBUxoR48s6nKXqsY7U
	 5j6x3mR4Ei5d65dXWgvLYgRK14z82Fqtb4Kqe3SLBWiNh8+k+HsgOxY6Pwf9b9ZAScOCh
	 SStx6DSIwNm6yezVnubk5Tsh66OWP4kFEF8DeBd7RS2EmZ//t6kdx91NdC5FhS1cjLRVa
	 MsM3u+3M9OuEYI1fFIgz7NKV/JxMctkwaE3Qbnsqq57r1gEX+U2umQA8woau7/DwNZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaTVdAa+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7009606A31B;
	Tue, 20 Oct 2026 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KaTVdAa+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792483570;
	b=XElfhyACZMb3z5cPnICO1WPI7GsG/eYpKDNzc/HBaqBgLS1La2fldXk1tiy1Oa0P5Q8j
	 SsIfzOQTMZ8BcbmERmt4c85hZOjzgPVxrGl3slEwDcmXtXwjRGl2N4SW3neIHGrs0f0Ag
	 Ner9J1BezELebc/+1l+AESFDajCtxLq+wpUY4dzxCqhhHB0+IA8KjxCUX5tttiDps2FCA
	 Nc0la+QnkZRA6Yq3TVPLWWcy+PPUYHLKuNmL7veze1Vg8AL078MxyY2URUKQVQ0vujqIH
	 rk1eGqE1LdlIfgUPFKQtr5NLrd7uXGXFmzgP4oJMHRxuxVFHilX+ViwAZad9comdLFg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483570;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	b=pUiVt/lohFDnXvGGhxQ0SEhE8Mm3qy/jNNI1rjpsFDVqD5BFxVxMauMVGWlWY92YH4rE
	 zOJIlK/ZMBpPUjVO8gE/Tph3t5T3XzBGyB9KvLlUkpVNM3xlxi8euFyhIM5r+t3/iMU65
	 ra+V8vKFPA4YTJrMhxwL4SGse4RD3w6aEAZ6AP4oJggXgtBtGEX2B5tXmQY2SaiOrtor7
	 8sWoBZd8t2cRyoLl82L7wq16wBA1Dr/VYmNBZKB/5xCoE1obAmQf4OmEFZO+jc7CRt8GR
	 2yYkBwJ2l4h5fttoM02yvZWv05Kvlp7kI6ue0bzLq3AiqXgzGASJGhYLssJsuA7j7kA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E16101F000C7;
	Tue, 20 Oct 2026 08:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792483570;
	bh=ACpglGQt7Aj2gzw/u4Za+Ar6SJo3lxfvogJ/Od0/Xgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KaTVdAa+qY4OSu3Eh0rtdrxBlJPuxnXMx2K20U0LO1tNEGtFh2MHWHumLvAJWipNG
	 rVpkEXAeYqbOf0oGPFPZTE9jvxN39aTB6a1adrIbqJ6ysTjOugCFDOizE8ccBuMoVq
	 SrKQVayi+ZtQNlRvii/eYxINPskjNnfOWCV5nA/iZcgGoBiGr7DfQaBgHvyH3v8CPf
	 B/7NAPCMhPwWNJBmovanZTeGkbiMRLDhfq0osfSKTwbr6KDHibk4V+nwyqk44WrTRn
	 EOoX+AD5BRn4T2RG43efMyZxDgZZgxm4vxYd30WPdu9GGBJFlzfrmyuerKfUzJ+TuS
	 Oyp0Pwh7rpbLA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 48D51430A0;
	Tue, 20 Oct 2026 08:06:08 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 20 Oct 2026 10:05:47 +0200
Subject: [PATCH 1/5] ceph: invalidate a revoked cache even while its cap is
 stale
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
Message-Id: <20261020-b4-wip-ceph-lazyio-fix-v1-1-f4cc62459d37@clyso.com>
References: <20261020-b4-wip-ceph-lazyio-fix-v1-0-f4cc62459d37@clyso.com>
In-Reply-To: <20261020-b4-wip-ceph-lazyio-fix-v1-0-f4cc62459d37@clyso.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483564; l=3450;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=8QRSQn0Y4TVaLVXe6qoY9/nZ1m8oLxj3xBc5YKZ5mow=;
 b=M+s5odNfeMnvYKp2XeN+IPmR1jeKRLpe8Ci6JNrxzpHU4D91iQkX35ltYjokA76tnD6botd0N
 tn5KoG0mmpsB3pTs1KqKwMFqb3aZ4R+rcpKfZJoHgEu95XMxT28rd5B
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


