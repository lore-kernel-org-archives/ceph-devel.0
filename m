Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB33B4E95;
	Tue, 29 Sep 2026 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650504; cv=none; b=Sw+exZ2yyVGyYpKzgBa2oHCRMMqkZIi0DGQErZmLR3WLuutsSDUJBISXqqXOzT2jwpd9ld9nd3IXl7rpRs6IBa+qQBUhTFTHTIj/zDUxVmCi4JBonGjhEqCz1EXgmovYem8HXHcNupItapy+TD8WAE7yNYWU/JudZwuFcE3woK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650504; c=relaxed/simple;
	bh=6ri3n4AMPOhN93rwGQCUGZoU5XRz+3Tx8COdKaqBdL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGl0klzjZsHDvYefnqynkhVg9kCR4VcUq4RC5xBGeTO4AkMAKHB+Tk963tDe0rVSWT5v+QZuzj0S96lkHU9O4KY799iTvsU9A55MH2NqNHd2AsNwQ+7SQGwe3C8B5HTQYSIFrMLJcA8uB1vgTJL/HLSYLzoeaiamybmu3QDkojY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=k2Qzvyfa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GCJC3r5p; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="k2Qzvyfa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCJC3r5p"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2F8EF7A0150;
	Mon, 28 Sep 2026 22:55:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 22:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790650502;
	 x=1790736902; bh=R/xXK6KZ5tFxGzHjcARAQju5Y6MZIhRxA+brEfe7okk=; b=
	k2QzvyfaBxHjCz99dAIMjshPj9dA8oEMbDN7BwsMbmz2so9uD/e+Y3Xr7yBa5l2v
	sdHw6oOwooXAl+Xu2MbYGFLyRHiZlW+pMbZpGsfG6v92iCUNWn6CWrzsW09+qOph
	l1dVRg26xhOPl+4DrxNa4KtIeSGARD1Bg2arrg+a9lzo42ixtmirtw5y+RcxZ4xN
	81b/y7so6E51HpC1ZCtFBF3HEjdMa33MaVyrQJJ4l90UEp6XA5+7Zcl2YZqB7UvU
	P7Q6q8VaPA9dJ1+L2ygrdA/2DC1YrdoPfcGFp1aiYyOlreTGtEB1C379xWm1HZ8G
	1hL74Pqp/uRUUL0qtCepwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790650502; x=1790736902; bh=R
	/xXK6KZ5tFxGzHjcARAQju5Y6MZIhRxA+brEfe7okk=; b=GCJC3r5ptpQW9IPAD
	i0X57EBAltKWhWPXjTF7cxKHORB0wo2DOeNMjIpjfSimjVLBvnLDhzstToawG4Ni
	RCoKnQcglR84pAOM71ua98PePTlKSqrNRXrub1lgah0R7v42W2z3WtOo2c2AdTF3
	jb0DCQqABCAJa4WhX3lWiZCu0TyKcsePtlfB3t/3Kzv4oCYtAvj7/FokP3JdnrfV
	yEtAvzQ6B40G+bS9eE1bYCecHkLkSSZTabNwI/m787lcSz9j0w/IYTCqehatqcSC
	uJPB04Y2PRTw60Bfq4NkoPV/I+kZWYC6SqyPPi3e0lyQ8cjQWmCpM24y0zwMUIeO
	ZXGyQ==
X-ME-Sender: <xms:hSi7ak8P2ExpwuwXG8_xYvctpaJ4bPudYIh--gDbXoqMeIBieSkGUg>
    <xme:hSi7aq8EDNfLGySBSwCbKXEYJVmZFbGhY2YU4GxZbqq6jIeguw9X3Bh6QRFna5r6R
    VpPqVChnWVeMUoc5V30YgXFjEVjIub87ulmPEZQ2gcT68hhSlY>
X-ME-Received: <xmr:hSi7ajV89WZnW523I8k21ZwcXllbqatscymvPddv9ez5qUHXCxaxfNaAWL75-az9gDWgJORrJodxq4C82Vj80DlwEfHXDYQ>
X-ME-Proxy-Cause: dmFkZTFKYCqEexP321uWghjOpW93sfMhbvfA1cxtQil5/LaoWYPKzQMb0JC9utbFplf0s3
    HCVAVWNTDp6w22LqKwfBm3b4T592iz5cYik89g1rioSKCyOBtn6sVLVkZFXvDPI7mjgnFU
    QEx3JN2QCBhEaiq2mDwjfBZ2pBewTbIY5OoCfCVeHwr/svYMqrisr9su+amzPf26UxL97O
    SixFjakEUswZwmBvrx8T+tlXkDN2+NarAEDkOps9f7n1P8K+5jugve3LX9poopqrBppLST
    oEtVfrAjH7fJo/vT4RrVddauLeJ5fQh9p/R52F41ioJ55PMFeqbtCvLGFp/tCvBFBrDJe6
    NiXWTJ2rGpcM/TiCnLxBtup+jIpTdRo+dlfZBwvtbA3GUY22uK4XwnmGzNCoMLIpIyn7D1
    I/lQwTnoS2i9SlO7f7ew73K5o1+PqNQ2AILNKvP0HiOngAZaN+A2200eN/IKsCrIc8nMya
    EQZ2yV5D+8o4CQD2wb1GkQCDSuNqEIxKJABxyxJIXysKtSzda63EH56eGvqvwNoeI8BmMC
    j0v4lniLeHGlyZtqari+NWzL5dMYLZKyOeMU1ktQeiMLx2wMXNVdHdZecM9UvUpWuwJeAl
    JLdz4hapmOY+cnOY77Bchz1Cuo754fpsKqNHgc++F067AcRq2TrNvnd2uiVQ
X-ME-Proxy: <xmx:hSi7andT3tHdr0NrSKeDZl5IvkDPN1oIItoHMFWnrNIaDynXCwwK3g>
    <xmx:hSi7asaOJQ4IvQZ1U0yP6t0OYfJ2GKVB8iCgrCCnMazchfkoAzeCUw>
    <xmx:hSi7ajMZ_dPN9g6r4la8mtzpSEeghwYhlj0Fu4YPalzIfXdVzvaBbA>
    <xmx:hSi7aiXGvOTJhHX6hL0HqP8Mu6dbZwl3Rhct2ulrp2D55Q3Wpq3OIg>
    <xmx:hii7aqEscu9J8zVjMXC6w7XOWVfuymn_RSJ_BP6rkAnCc3T0YvEvPeFm>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:54:57 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cephfs: Don't d_drop() before d_splice_alias()
Date: Tue, 29 Sep 2026 12:47:40 +1000
Message-ID: <20260929025331.1436824-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260929025331.1436824-1-neilb@ownmail.net>
References: <20260929025331.1436824-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

In two places ceph drops a dentry and then calls d_splice_alias().
The d_drop() is no longer needed before d_splice_alias() and will
cause problems for proposed changes to locking.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/ceph/file.c  | 2 --
 fs/ceph/inode.c | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index bd3e3f5c269e..62c1b77fcd90 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -772,8 +772,6 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 			unlock_new_inode(inode);
 		}
 		if (d_in_lookup(dentry) || d_really_is_negative(dentry)) {
-			if (!d_unhashed(dentry))
-				d_drop(dentry);
 			dn = d_splice_alias(inode, dentry);
 			WARN_ON_ONCE(dn && dn != dentry);
 		}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 74a107b6ef3c..01c468a509e2 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1555,9 +1555,6 @@ static int splice_dentry(struct dentry **pdn, struct inode *in)
 		}
 	}
 
-	/* dn must be unhashed */
-	if (!d_unhashed(dn))
-		d_drop(dn);
 	realdn = d_splice_alias(in, dn);
 	if (IS_ERR(realdn)) {
 		pr_err_client(cl, "error %ld %p inode %p ino %llx.%llx\n",
-- 
2.50.0.107.gf914562f5916.dirty

