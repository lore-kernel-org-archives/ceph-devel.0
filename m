Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DC3D45D4
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323512; cv=none; b=CYNgrhDdCwt4x0WtcUn/xWTyZB0n/FPvGhTaCPX1rs4sQYCAyb6e2Kht8qAiBzE0eYiadJWIT0kph0E8tBfcMIe/wrbqes2ClDNy6oIJAHj1uXZo7jlNR5k5iJxtC0n1KEn3qCmpFo7hzjVRvJexP5ZBoR+O7LcPr6nIw3bS4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323512; c=relaxed/simple;
	bh=iNTzsAOaK8QW9cJR6y4vQmcIYFwS80L18BRlWtnmHrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdAsT3615jSuF8kMZTub4iidbnsjqvx75q3/awJDciFX8fzjvBsb9g7J4eHmTlTa+rBNNBAiWKI+aK3p85nqyY1omXUyjR+l/M5U+6b0Mbjt+ehwq1ua989FLZpTUCWNjaatdBrfiFkmqw+XH6VcBfb0wTHqFrXhW4HEHHiYDhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hF3W25oE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hF3W25oE"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4728c12ba97so1487460f8f.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783323500; x=1783928300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=26bYikNHWAybEiuxAETfIUmnNUmrUCebcqCIPmogzk8=;
        b=hF3W25oEUl4mPW7I3PoQ0sA9OhEZQh7feUFH84efUkBRtx2hp3+NpweaTYNVO+j310
         jPlxvRsozou4npIbdQeOcL83kWxStKpNRzzlNOezhq+8tPehd6IIVJNbIw4y9Av/1hTP
         mdhwVZEBViW4Bwk11Ldezk3Vot/G2yh320bXLYBNwRRWQBTG2WsF5z2LpC/nqMUJkdPN
         YPapBXDUw8jyB16zfnDSPQPTvvzGDmjUN01MVapB84OGJe4ZjKC4MTrcptH3diP3YHZx
         eyVxphlhkrZMjolK6P5wifUrtM2a5j3pjzh2oY8fiquNKAz/qbfjr3v66u6S3xk0RMzG
         YfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783323500; x=1783928300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26bYikNHWAybEiuxAETfIUmnNUmrUCebcqCIPmogzk8=;
        b=Om6n7dptd1CW8NWUa1VJk1QvEgsNJ6mHRyC9+GdYP2YqUrzW6UKsfirRUFk8E+HzXU
         UwEy7YgzCJeUrJZehDQFbP43rSwr43YVllhlFf+p2wvYx6xRqe38j916zTtqVu3RtnTo
         9D9raZqeWuEjHOGlD78K6yrMbvc15J0qxy+rF5AIsxydXUabQSIreXdMyGvGjVDRbfU6
         isZ84Kj3x0SgvZxDv1l8SH5pOodXXnuPd2qbzWHiCCHYPhEzukp8DoWs3aKs9Bgqja1I
         PmKkipSrlz8PCorQgv0H68K0syntTM3JO0mW7lbmXGthtGul4iDDUUbQnLXRdfo0GHNS
         B5zA==
X-Forwarded-Encrypted: i=1; AHgh+RplvbbN0q8Txz7biXDXHNzjrwawml0vwv3ZUvpkqD4zChTlxrQXJ9jSPv/3/nhxjAaz23BlWBC14k+y@vger.kernel.org
X-Gm-Message-State: AOJu0YwoY2Tlfa5+sZ2TXP/mdEMuGcbp/qmq/GgV24hDgyLL1gGWPJAR
	88rbTEcD9abizVjXRlmkTQsMc6yq40jKAXfqha7nN+8gS7Q9t3boPv0AU+0uZ6fGymk=
X-Gm-Gg: AfdE7cnEp69Z0uFAoOO1UkJ1+9mDmYkaMnM4ye6x8i06jlKeaQlTnMR59egG0EFj2mt
	jnBRFaUZfdyvdQggKZYuGgBOZDlqZLgvK6c6Df3JGA2O2TekaPWYGpcSxCA28swTik9K/Ua4QZt
	cHh3WO4mDfoHpZfECK9tPVu0Gak5Q+iJCJB5OMNyJir+XcC4IS5PsTBbUnGBsIG4VfaIsqsrQVo
	teWv8MrRZ0em2ugCWECBSNKp1fAPOyBiaKItGnCvt35KeoOUJVAoE8j9mvVH/FRKqgzqIrXFoZ8
	PnRu1cNpuvvI+yU1NeAiVVUOUnOP3bnPC8ZF4x/Hf32UaEUmczrqzvhEKVXyQnXXFypQD0fgXwq
	/cBOSgnr41YjhG8PwIE/Ef+cv6KiIJQky9+6IoyyLkLSMXb8jNcy8YERUZlaqu2BoqSG7Sr+TeI
	E23BDn27RXtK08gZZpcNWQ4lG3MbpoAgk+43/uISryFaoOLz7JHwrpmp6LRAqtlT49f2MHvkTSf
	SdDsFwpQ1Ak7Uub
X-Received: by 2002:a05:6000:186c:b0:477:3986:9b54 with SMTP id ffacd0b85a97d-47aa9b77cb5mr8962476f8f.20.1783323497428;
        Mon, 06 Jul 2026 00:38:17 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d8f1sm22248585f8f.3.2026.07.06.00.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:38:17 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 1/4] fs/ceph/caps: make __ceph_remove_cap() static
Date: Mon,  6 Jul 2026 09:38:09 +0200
Message-ID: <20260706073812.3922732-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's only used from within caps.c.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c  | 2 +-
 fs/ceph/super.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 4b37d9ffdf7f..c1213d72645e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1119,7 +1119,7 @@ int ceph_is_any_caps(struct inode *inode)
  * caller should hold i_ceph_lock.
  * caller will not hold session s_mutex if called from destroy_inode.
  */
-void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
+static void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 {
 	struct ceph_mds_session *session = cap->session;
 	struct ceph_client *cl = session->s_mdsc->fsc->client;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1d6aab060780..b878f14ca959 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1269,7 +1269,6 @@ extern void ceph_add_cap(struct inode *inode,
 			 unsigned issued, unsigned wanted,
 			 unsigned cap, unsigned seq, u64 realmino, int flags,
 			 struct ceph_cap **new_cap);
-extern void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release);
 extern void ceph_remove_cap(struct ceph_mds_client *mdsc, struct ceph_cap *cap,
 			    bool queue_release);
 extern void __ceph_remove_caps(struct ceph_inode_info *ci);
-- 
2.47.3

