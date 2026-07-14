Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157BA37A847;
	Tue, 14 Jul 2026 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010048; cv=none; b=pYwMpxusDWmDK3hpf8u7+LcmF3mxDCCwgs6rlYa4ew6CPYLTyO0+YClm1PwlAi1aascWVsUcNL824AZTcRw/f5hoMDTZCb1xn81R5IhW7bFcPpuG5OveTWOOfPuJDlXUfpLNwbMtHyEbPc2CKTMDdjJsSLc2YRuvruJGWGMDfIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010048; c=relaxed/simple;
	bh=A0MW+KjCx8TWRjHL9RMq3OieHzYG7xFT6vyAAjg+tIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K7yImJNQMpJaHZHpeErEL9G7VOKvnDzkd75qk+fTp9MxHscNYSpSqr/g2qf54Cyrc/ag1z4A089lniquynyFM6Qy8BWwxbmVrgxzGwicWPllueFGcwS22phlAeWEzn5xo5zIq1o56KgQ3KCJKOCofuHfJvkS8+IFnQt0nSioulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TB80AOQU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TB80AOQU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0071C2BCC9;
	Tue, 14 Jul 2026 06:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784010047;
	bh=A0MW+KjCx8TWRjHL9RMq3OieHzYG7xFT6vyAAjg+tIo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=TB80AOQUpHA7yjseRWzlaD35hjDETjDFX2SOP3Ao5vO59gcs+YRv4b+XmiDLo6ZgU
	 ihBPlMYL5BYsDVy63FChRBGwFApHtdx8/cblXnNO1YiHmnnkVbYEwcHEkG3oo5Q0cM
	 4OZxNoUwzpe2JbLEp4klhAwz6o/j+XcPE3+JSmr5fl9E/m/Cck4LUrQtyvxllRPXjl
	 RSPVqJ297KUjMQcB/kXOC/7cY6ju78QAidbE+PnMOWqcXEN6LPbTTdAqgpXGmR32wH
	 ZejGXJUGj3BPOO8kRmR0teoOq8eigeWL37rikcLkAP0NvqkC2W1qGvKvOJZmNifsHy
	 qcu1ABF8wXtrQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD1BC43458;
	Tue, 14 Jul 2026 06:20:47 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Tue, 14 Jul 2026 14:20:37 +0800
Subject: [PATCH] ceph: fix use-after-dereference of NULL ci in
 __ceph_remove_cap()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-ceph-fix-remove-cap-v1-1-27b5bc6ee2f6@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPrugQZrSq5Q+rOtYt1ANiYog3
 t3YPn4w8++UEA2JHsVOEaslm8aMuixIBxnfYOuyyVXuVvm6YUUYuLeNI77TClYJrL3v7uLFNU4
 oP0NEXvyqz9ffaWk/0PlK0XGcpd+6AHcAAAA=
X-Change-ID: 20260714-ceph-fix-remove-cap-cf7d8a7a242a
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784010045; l=1741;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=ooSqkK6IVYP8K/OVskBxW937t4pyDtOQPUpfeEISEHY=;
 b=4//FPhq6KgagTG7f41be8cBiCVClaxaFVnSh67AOzk1hzSy6SbXQvnVf2R60XFFiAHUbODHSR
 gtMFoGu8RKWBfFyD7Ojs+kZstipgGwStwiWiMciXlZWJ7Tpgy1a/kAr
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com

From: Xiubo Li <xiubo.li@clyso.com>

The NULL check for "ci" in __ceph_remove_cap() was dead code because
ci was dereferenced via &ci->netfs.inode before the check, and
cap->session was dereferenced via session->s_mdsc->fsc->client even
earlier.  On a double-remove, both cap->ci and cap->session are set
to NULL by the first call, so the second call would crash before
ever reaching the guard.

Move ci, session, cl, and inode initializations after the NULL check
so that the early-return actually works.

Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
 fs/ceph/caps.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index f8d898ad091e..8568edf494b5 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1154,18 +1154,21 @@ int ceph_is_any_caps(struct inode *inode)
  */
 void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 {
-	struct ceph_mds_session *session = cap->session;
-	struct ceph_client *cl = session->s_mdsc->fsc->client;
-	struct ceph_inode_info *ci = cap->ci;
-	struct inode *inode = &ci->netfs.inode;
+	struct ceph_mds_session *session;
+	struct ceph_client *cl;
+	struct ceph_inode_info *ci;
+	struct inode *inode;
 	struct ceph_mds_client *mdsc;
 	int removed = 0;
 
 	/* 'ci' being NULL means the remove have already occurred */
-	if (!ci) {
-		doutc(cl, "inode is NULL\n");
+	ci = cap->ci;
+	if (!ci)
 		return;
-	}
+
+	session = cap->session;
+	cl = session->s_mdsc->fsc->client;
+	inode = &ci->netfs.inode;
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 

---
base-commit: fc67edb66b3c9924c4e0bb366a92b32ea13c526a
change-id: 20260714-ceph-fix-remove-cap-cf7d8a7a242a

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


