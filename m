Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793722986;
	b=wTcigA/d4mHH3wCfnUaBB4LDj47nYnl6uQzsg8xQlkIueoZBe8HGYWq9inUpTvkZyNHX
	 re3z1TjQB865zdZkd21j63sWOfENKrjQf2GcNzeNHAKHm0wF04hvKmXeHCfyULcMvxnyd
	 PBNdVMd0hvIADshzOsW3jebXqH5GLoJicRMs6t/yJFK22JScCVrbjRWsjVK6yDC89No5h
	 PKPafoIjeLFA9pmt15+2qTokFgBSfEFHt/gHUpR8vLPIR8uBeY3hOO+Runq2kbRpfwHEp
	 sddiOhs60KWCDYuzED2h+nNPa87j90Yz0gBwpPEloHwS8MKxELi/ua0S2/moifL5NbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=93riYcJlLAnFynJurIkyvUiaXMItBgFK98KFEK7jbvc=;
	b=T37104evkDCeKG8kHKSjWOUnLkjJ7mlYMEgzDxpB3shC+Iwy6ITOJzc5ofWN2TUQFXJV
	 9f1fgBc748ykpNvDt8K7x/M63mYPkQNLp2ltfBGTZsKYLGqeI+x47jwMHp20mEsyy+dMq
	 y0CjtP2lgGbNX21bqwRbszJBbUZWjYJcH2cJ1DtAPjC/dD47mABP5J6B5gRLOq/RdbuQl
	 Cw4TkyL8Z1wHy5nuATnKQAvUOTFqI+/IVgQ943igdwMBqJeTNoLjbnXO6v0LnmRA0PPOs
	 T0SeQa2MF9Ezm0Akj99vEhMW4f52R/TTlxeYK8vr0CZZc5MDnrsgVFP0KZYlIPbdmoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHbst4bj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B48606A324;
	Tue,  3 Nov 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHbst4bj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762F91F00919;
	Tue,  3 Nov 2026 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722986;
	bh=93riYcJlLAnFynJurIkyvUiaXMItBgFK98KFEK7jbvc=;
	h=From:To:Cc:Subject:Date;
	b=PHbst4bjxWvYbgLPWOEMm1vMooIlQtLl1xzM5j2rfP0bf8QBJ527wdNHU4ED5fcZo
	 Jzo7K0K2GGxn/Gf4qzEceickif0Bx3bUNmxLiBX5Mc1n7u95llvXmdKMrnINDKWha5
	 aKkJIWHEbDrZ5r/jYDl5LJ5cWH26eGpmit6eITCDv2wTUZKxZT7tmeamiXEMzvtkcW
	 qID3i0BBozoIR7HLSJF2v3Br3uhsLG3HDuaBNraWnZQCcQ/dZDC6MYxgrmns8xMFbs
	 1aygxfkUHSKR4+YAFVgr5YO3VevuaTX31YP08V49vAHlcfB/GJw0NORVjAifm3LGXQ
	 qSCaRW0osdrdA==
From: Thorsten Blum <blum@kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] libceph: Annotate crush_rule::steps with __counted_by()
Date: Tue,  3 Nov 2026 17:22:28 +0100
Message-ID: <20261103162226.433523-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=blum@kernel.org; h=from:subject; bh=4dEsgy5eXGD2Hw0EYUQ8J0Mbzw0Qy8DSrJ00SHPTElQ=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFmvuJw++HxSyF52ivnW9JTStZe+V5qGMli8nGDz/KRli BHf4mbfjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZiIxmRGhrklBmVzrMWzT3FJ brC92Sg6KeLflTyrIuM3zs+/Rm2frsrwz0T01Rb3F95Sn3fxNm0xO3FqbkrMw1qOoKQvB/fO7mC t4QUA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Add __counted_by() to crush_rule::steps to improve access bounds
checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 include/linux/crush/crush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 30dba392b730..7d243b9b1093 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -87,7 +87,7 @@ struct crush_rule_mask {
 struct crush_rule {
 	__u32 len;
 	struct crush_rule_mask mask;
-	struct crush_rule_step steps[];
+	struct crush_rule_step steps[] __counted_by(len);
 };
 
 #define crush_rule_size(len) (sizeof(struct crush_rule) + \
