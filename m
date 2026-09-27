Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA5421A07
	for <ceph-devel@vger.kernel.org>; Sun, 27 Sep 2026 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531072; cv=none; b=d0KkkrUnpHAnzLLxjBGkhXz2jhOCk5aKhV7onhPfKmRCXQZxK4AlPYwSqQL7oHuvCHz4JuXEPcD7BKLZmQ9k55kKgkZYg277iYi9nArH7gqacI3qMnKR7aYK3Ym3VQSEIE3YAEOLMlV9s4B1FpakEgexYGs5OZ1Xjea2xfkfWSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531072; c=relaxed/simple;
	bh=IqWJg2agBE61Hwref8/QboYAZsi5aV6fYgmg8wjRCTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAllO7f98NA+k5lGMEJSTwTcmLqTrSp5R1cstmRiQhnWBwKRJsqvgrjaHKC26fQ6SqQtYMhw3VFvaAai8HiOT+nZKymji24+8ui7HzSKLXVQ8XuCf81T0i8j+rSyK5BOEfg0knpnicgcO7GqwpOO2xb7F1UveE9dpLsSDV+G4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=g0pkNGpg; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="g0pkNGpg"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0df0bb2d6so735184a91.3
        for <ceph-devel@vger.kernel.org>; Sun, 27 Sep 2026 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790531070; x=1791135870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fH0GJVne8Jg+qyeTLAM/8ogcMcE+uAgM6MoLg0h42pg=;
        b=g0pkNGpgbSxNw63FXHIsqDaIsPKjDJiQq7Pr38XWNKIWxahsdC47sk1xWvdJRlvgUy
         ORztbmd7PgKrqaaGg9CodhNXTDqJrmH76Qqqmm2eQYGjxgREH/ES3Riz1l65uxc9kbNX
         mniseILRA8IMl1dsYHMofn8OFc0Hju7WFQrBCpuzzJzEoAuy0oGC3Z6Ou2E13wJT9agW
         M+GUuwkp7L3Pcjacs/8IL7cybfjLWn9yvZL7gPhOWfVHIW0EEoNZq4wJxZai/AGh0lvt
         1lyRHjnTxM0b4L5UClbic4seepV2jCNNV/w7asd2tfSTCXuIsAoKWYyLJhnDfyly0JDR
         Ypcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531070; x=1791135870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fH0GJVne8Jg+qyeTLAM/8ogcMcE+uAgM6MoLg0h42pg=;
        b=fiIHCUvauBaDcr5s4s1GAFgPCCakMv8q7T5q+qkn973+mE0n3TIeIyRz9bkKVAtLAa
         xZZ3bvPgW47fkHdn077X28C/OMWZN7XRs8jFEyRSJgVs8vLSSagMbMJBx5gJ9iNq35JC
         SlF0YGd/fnIsp017gJ7FBe6Ln2pUwiE/vewJKGYU53QJqtSz2F9RrY8qUY6Yt2rsS2h5
         gtbFnxzKDAC9tYzX8K5xAr3lAQ0sRFAwcCPnRq8oXQDuhgbS4XNEeAnF4LzrvcLiocfp
         dxYTKUzkGcGtyzfbEJIXV2LtC3GNPDrqEyvRaVYM+w/h1m6WH5BvX2F+HjHclpKjmSOi
         oQXw==
X-Gm-Message-State: AFq9FYLyYXATpKw6mEnVVsBZWV13fgOnrm9WdZYwHwwNIn2a3DxRW6rl
	W4JGs0UQnrBGQgls2a/8i3TjrgxAbMbM2SC0nMN8LngStrlZOYROIUojt5xM0+aRW4f3AQQf19W
	RE3OPC33kth8=
X-Gm-Gg: AYBFou1G2V6X3egh9m/s2p28YoAjfCcl6JnesbLsVGe5PWFpx3ZHADWV/P3bS5lzXEP
	WEexP4liscGZ8wHWMUgiRaMw8FPy00QiPm4qI6BMszjdgoFrhFYpqCF38xQFKa72V3gTcuc4Tlj
	2EkuuWD4vuq1Ry0T3zCCTiq/+aNfUXiHUgVc9BMH83vKrNXINz7fBJC9Alq3rgUrxVvNwfZYcOB
	RRCh5yv7vD+RVpkAXj3+u0Zq2/Z4iAFs3CmkgCbB5u7+J68HqFVQN2HMIrRRRjZgveUhCKjc2O7
	CqqJdzQwWoSGXKBL0Dp4wajDA5YLXMhMdMIo4V/hW71pAJHxLem9AMjY6C0EdreDfYMyPoZaMd7
	RI6DMJOLoIxLFo++460/2rMgqCb+jgRF0yxluxBp0Kuhis0HOq+6I5mQVTgeRenHMEEzXJU+QSV
	cqzvDPOlO6XyeIGvpXcVUOOUbe4+omnr04nh8crjHsCtoUvFcHJtfk+mCVnmwulfhdGXDyPwmpD
	PP5KhC4mjA+MPxwIPI=
X-Received: by 2002:a17:90b:35d0:b0:3a0:df61:3fe8 with SMTP id 98e67ed59e1d1-3a0df614b3emr3411764a91.13.1790531070516;
        Sun, 27 Sep 2026 10:44:30 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([23.129.140.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm16070056a91.6.2026.09.27.10.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:44:29 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: ceph-devel@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>
Cc: amarkuze@redhat.com,
	slava@dubeyko.com,
	vega@nebusec.ai,
	zzyy19904204639@163.com,
	weir@nebusec.ai
Subject: [PATCH net-ceph 1/1] libceph: initialize CRUSH choose argument weights
Date: Mon, 28 Sep 2026 01:44:22 +0800
Message-ID: <e7db8a6e1dbedd5177b772b570674e8a00b23214.1790491709.git.zzyy19904204639@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790491709.git.zzyy19904204639@163.com>
References: <cover.1790491709.git.zzyy19904204639@163.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darong Lu <zzyy19904204639@163.com>

Initialize the CRUSH choose argument weight-set array before decoding so
entries start in a defined state while the decoder fills them.

Fixes: 5cf9c4a9959b ("libceph, crush: per-pool crush_choose_arg_map for crush_do_rule()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Darong Lu <zzyy19904204639@163.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index cf34b35c9a90..2a9265653ed8 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -319,7 +319,7 @@ static int decode_choose_arg(void **p, void *end, struct crush_choose_arg *arg)
 	if (arg->weight_set_size) {
 		u32 i;
 
-		arg->weight_set = kmalloc_objs(*arg->weight_set,
+		arg->weight_set = kzalloc_objs(*arg->weight_set,
 					       arg->weight_set_size, GFP_NOIO);
 		if (!arg->weight_set)
 			return -ENOMEM;
-- 
2.53.0

