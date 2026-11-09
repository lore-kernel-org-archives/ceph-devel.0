Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255855;
	b=W/2XuN9PryL6Pf+Asplgqvtk1txbE/AL2+mtTrMirqIAvvUuL2GjYc6Yjd/yWAVtJYlV
	 sEIQGEqtJHwKVSFboKiuQVkSXLfXEHuS/AXOjqyydg+ueuowjcttdJUtwOozx8jNubnA0
	 4vE7KhyoLs37oVy6/9LF070Zo7uktGz9KaxQNdCAtvfRXxMXzJoA2Ks3on91ZlTRHMLKy
	 hhlW7iTj8LrLYhGlsMkAxVK7RFY7vb21zF6KkWX1WWdGKQhRZH5WjDwLSNSRfdYId1Tj6
	 QbjfJBZm+MS868Vuprr9egHv0sV90vnKHAJflFCdQdQ0YWkJkkzaRXBhiKa71JGT0xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255855;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=zjfHZ9/iY5srqvBdsWMaf3OjQqa8mz2FUGkGCnlSzc8=;
	b=iqX5b3VNzLYoVGOX+S9Fv8qwqcj89LvAkJMkE+CL4mr7zEZ1LZqzgrZNp7UXZ6lA6k8M
	 ebTN2wG1ue8OfY9fPr71THVtf5iDPCpSzfyKid+K2ucVJEllbB78XUQAgrk3JWC5HQJ0c
	 9Pn0RB0ZnP59XknIHr0nJhFAFgMtq65fYlSRkgEFxOW5JbM23aUSqyOjB8+x0BzF1U8q2
	 djuWSI0vxOdYi9oQY66VFM873wuN6LfKmmV2l+d3N7GhfktXtPhulEYgMl+/QEN9YyfkR
	 Cc5st+2Jyjc43IVCftLdXGzwHLuWuRom2A5N6gc1RJYPzMLhJ1K5U5sJFeOq5v1x8Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b="SN/5lmnR";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ji3kxree;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C660A2608
	for <ceph-devel@vger.kernel.org>; Mon,  9 Nov 2026 20:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 450C660A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=SN/5lmnR;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ji3kxree
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 92563EC01D1
	for <ceph-devel@vger.kernel.org>; Mon,  9 Nov 2026 15:24:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 09 Nov 2026 15:24:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1794255853;
	 x=1794342253; bh=zjfHZ9/iY5srqvBdsWMaf3OjQqa8mz2FUGkGCnlSzc8=; b=
	SN/5lmnRxvyCYIJe4s8rYb9vrDWLXjl6EnZKdUQOD8olmrfjn+PbAHfOTJe9fZB0
	aZg1r9osYBN1eqtNiZQQne7pIlGvyZWkIGAqD0m3b+vN0NW0C0xeJsPeH1wa7DMS
	l1Ay73cOMutJd1zyVMTjE1Pvn+83/DW8A7JgTSCetYMBPV9zsJBqOiEqSobCpUGZ
	9N2zMLfbfHKgleWn8qrE87DCqizbQCE7uoo7GL48EhVSKTfbpLPOP7qHDP1Mpg5O
	rv4ErZcrrhks0vsFtv1MVtG/MiWtcI2U4vxGSIOfp01BCrSfArVXJm54890pQVbz
	bE5Hrz5FvADKpGUNeFh4kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794255853; x=1794342253; bh=z
	jfHZ9/iY5srqvBdsWMaf3OjQqa8mz2FUGkGCnlSzc8=; b=ji3kxreeXH7CrHmw6
	Uco9zxkMNGaXC3QQx0oOIad7Ck8NQhyBR0MenyFcDUopLKlWJ8SkcdIDtqAlzDqi
	OlKMXNeBcNY0fic1QgiylmbQg87xnBHSopSwoyf1DaR3gImpaWCyfVjl8RbCxA/b
	uVgSEir0UHvzxEQ70+ymxCJtesItMXqDxXr23bj2PFGZdFSrwCnM4zkTpaMF3snl
	QDRQrEaBLvDiwfRt3hOy/WwrSDp70KE0/pgPc5ftrKGcvr6iNkHhf1XDKkiqQedS
	E9wZ2YqaRZGh4NemRy1av5WCProhAf2GQ+t/sd1VBAN88IUPR2Pf+qukE+qwLm5Q
	cM6RA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794255853; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGNlcGgtZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:DVhoj00fCKRfaC/DF8jH85oJ4Vi98XjMhGhF7L7rLj2+0XX
	SBunyw/Nkro77oVPhTBdACF4rpoSIPQMYSIZwJ1pEZhLEBLdKnZEA9pbrFZqPypJ
	w6HFNoq0Rwr3XK3ZmOMeM53KvYb8cVOJ8ugpcLDBJXijkcihLEhyZDZayb+9Wv8+
	6eCfIk87977SCa9KLwTCjoNszBlAeYo3vRFR5Zw+SdGBemCswmVlQhsrWT7r9v4r
	xX2oFnZVtyXy3FSAfMEalGalaT678FC4qb5VVp9Y9/YU9TCdhu1sMzy8/FCfS6yn
	L4ju5DlTWi1R6xcBPrH0mk1b5U6N/Ag8NDPB2ww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:ZwPKZuz+L8EKPhQhZ3y38gubA31Fi8M4Rr7Xj9LYAUo=:Fpx+T8KNcU+geTDDDlHvs65pG8ubwwLbqbaExriuqMM=;
X-ME-Sender: <xms:7Svyaqvi7htPQHxbaOGP_Zs8Y7ClTTcYXmgG6VEuVkghKXyDK9coDA>
    <xme:7SvyatuqeCZbnc5xvFrfBR98pRzwSFTFWiZ3oDUQ7Eii4h4dd_k0iHxVlvGaDmEUW
    FCqWg1tQ2kY4Fkqn-sZdm5BpR4nXslV5DL9sZY7qddm4zAo_iM>
X-ME-Received: <xmr:7SvyavHEEy7ulVNPHpOzUqDROp_35Fe3-6dc4i-hAZWhqoJgX51GaRiKeCmzKF2SG7OYFaWRqYJtLtLTGsJpop-V9g0hKEA>
X-ME-Proxy-Cause: dmFkZTEHjiJtDn94GBcxaAb/SYY4wvb3ou1/RLBHVMDUEF/zsfG7ADCcFeZBUosSipQ+sN
    Wd1K7I+t98j8FQx6X5ymfBWTf/ydag/l3+LeCQALeUb2giKfld6Zz0lPOptSgDuPu4zerV
    MLDYgqXPEcJDJ/3hLpO8yn23m1Jsu3oV98p7BFI4T9U7eSJ+VvYJiJLZC5uTz7Va8kl49p
    KKAteJj20s0ph9Tjr2Q/w19cJsZs+2Grz30d4s94LkJ5KvRPofJ8DVJZUmH0szaPfu+A+2
    F6l1fIoBVQvQsDyV2lU4WjRgkr4pCpmSW2YKbZj5DimKQBAWe0r6l1djqRXzmySdl+spK0
    MJm3YUbh1ED6PRNxMEpvXyJdn0jfpABb0YqVjzQwnccZOVG6h3a2UpGZKL+FH3JH519+en
    wXJGQ8d+NSO5jDK5tZaXvc7ipF47HizUxA2SA5KrgY0dtWAEFz6VztQ8x5qctnKydAjR2P
    oPKeoV75uvfzN194kQq6vJh1IzbC8H+Q7Fzd1VRBl4B1OLarzhEmd5edFH059KdJyiMQAx
    CuFBwp4Vz6l5QWxYGNsWV6rKfj8iUxavpFprNUWeXz0UvlqOmyfROH7J6l1cA1x2cYx+SP
    /J0WHu9bqKTDzLBPwREsoyULOn7Wu73MpWch1Zr202Lzr3XfAUAC5nEPgRkg
X-ME-Proxy: <xmx:7SvyaoMzbOTskPK97SXniM6lFy4GhbWMteip_fvyi5d2trVTN14Arg>
    <xmx:7SvyauK76F4wnrUvzdM-IKGoOdDn3bSvvUAm4-dcfJ8SN3TFpTQ2fQ>
    <xmx:7Svyah92bm8Ome2lbJpyukU2XuMIy2__BWcPahCnlEv8f0XnO3or1Q>
    <xmx:7SvyaqFeDT-6njptOk2R4iljMUdKAg1Wpfo0Hpg5rkhV2aAdBT86Ow>
    <xmx:7SvyatDAL8rs85xSij1CNKN6uCWoDsfi5PhWBD8_0wRxUOPxCjpD7560>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:24:10 -0500 (EST)
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
Subject: [PATCH v2 2/2] cephfs: Don't d_drop() before d_splice_alias()
Date: Tue, 10 Nov 2026 07:20:24 +1100
Message-ID: <20261109202339.1380828-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261109202339.1380828-1-neilb@ownmail.net>
References: <20261109202339.1380828-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
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
index 4a19a00be96f..159ec0bdf1fd 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -770,8 +770,6 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 			unlock_new_inode(inode);
 		}
 		if (d_in_lookup(dentry) || d_really_is_negative(dentry)) {
-			if (!d_unhashed(dentry))
-				d_drop(dentry);
 			dn = d_splice_alias(inode, dentry);
 			WARN_ON_ONCE(dn && dn != dentry);
 		}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index cfc438b3a446..68da14fced96 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1626,9 +1626,6 @@ static int splice_dentry(struct dentry **pdn, struct inode *in)
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

