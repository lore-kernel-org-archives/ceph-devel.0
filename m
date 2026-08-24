Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C7385D61
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596934; cv=none; b=lSzyKyKQngdagRNUU8vxeVaCyJ4I3NZxTTFsjgVk0Y/nqKz1vUUzOMY6kal/r63OCRz/krqW5W13YoJtvgAfSZFBFwCsxhNYE2rw/+pmKC4QQs6uu0STDMDkQNg1fjz/QLuy+SdA1zhewjicVyWcO/iOvSdxHSHhqCVZ2PmjCiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596934; c=relaxed/simple;
	bh=mh3Wvp3erJw6hgEc0BaFtMvIaRlm0xL2iUvFtRAjH5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USSSfxGrP1Xd+a9LtNVhd6hQySvcjmmcuaqLjxJcrLwLZvOGjsBEifIhg107T3R6TW5J2xJxrrao3kTk+ndY1iJIR78DWBZVpAZ7MeYGoOOEgoPu8c3lUL8hz1gqUZzqkocH2M4O/qNhE+FJVvEaqLFvRv+w6Hw9Ivo3gO3c0xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KBB94X2w; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KBB94X2w"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15cd3fd760so466997366b.2
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596931; x=1788201731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DYD6EXdc3EA1wjI8XloWJSr9upDOkRMjp4PLGykUXfY=;
        b=KBB94X2wZwSXbFKfkRabFJNL6UPqQyFOa+asMAS5XZmzALJyZlAqBqqYYvxQVpGeIL
         BjKTY20GLUBGs/oQIm0/XM1f5BT7/K5cbprR54uZaSv0OKJb+/fFLa/IQr43JrII1rWD
         QPI5xLLywo9Sw9K4WFlZ+x33EkyCnSuqjMb1AucY/MzESxs8hS+fYX3ZlzP8mRmYrcBR
         txMUa8vsfwK6Sg7OzNxb/CLUZvykIhCT9mZWX2R3P6boz+tL0UDttvL9H6xc/XftLIk4
         H1yRQDITHe7+FTwbPd1N/HnjMs/Sg2S2EmFVl5UUMp/qRjrHDmcxSN7HgE95wl07l4dP
         Va9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596931; x=1788201731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DYD6EXdc3EA1wjI8XloWJSr9upDOkRMjp4PLGykUXfY=;
        b=egKgjIbkCyJrfq9sMO+CSH1kknm63l8HW/4kXAQPzBkC9um0p2WTKoDuGoYt59zwBf
         X+3nsLHGiB/vQtwVK+IyDl+YPatKIT80ANvTJb+qNSGTV971tyB5snBstk3x0uNwtxYB
         MJwZouFAvy7vpSi3IZ6LdERAC6gQCJqAXFW24HYp90e8bsoc87aeoNQ6NU+aHpPspo/s
         3rptqVLRDHUUMJsf223qmzW2PXKlw9C3JTvqfXjn15hUHv5eZNDLm1+xAwTplIbrG+DD
         EeuJMBjhgnjiMEB3H1ulabyL9hXr8cDPvXgiI9tFISJm3SMAUShR0cW0SLpBo123l16C
         fGsg==
X-Forwarded-Encrypted: i=1; AHgh+Rqea20In9gfTuIH3BNZiGuZE6LFIUhminwwJnaFiecXdGStqB5a6m9gwvy+vNRv+WBYZiVo31GAtBwH@vger.kernel.org
X-Gm-Message-State: AFuF++mEreR5QU5o2bWJxfu6KUxQoQO7yDsf+JefU45ZNrZmv0zJMH2q
	gUcbpO1QYk19ZVk1FGvlHQH4HUrG/xOOJQuWnYO9cc2XtCTsfuOkJq5039loA3kIzJc=
X-Gm-Gg: AR+sD129bqKG6xQXDpvbR6kpsY9oQIcHlFL1oAZNLwqLKmgBzhzuEJsDuZwtwK21fnP
	/qqo8XHvvXC9wxwEsMEL+4+m46NQM7iFaVUvwr/5UlmLF9rLttTLoSwbuG5n3BhqS8g4UX4RM++
	7ZBqyWJnSvCnD7QdudPdLVsixWQj4lcJeMFUPXdZpuaroTsOd9xKqT/OXwpO75+qze0kr8GdLc1
	7sjHKic2B6hnZSJzXy/XucgfPtG9mutWyblUEbGMQF9jRYvjg6NLzEnDpWaOKg17mlgLvQIfx+j
	LTcuAkr35Sb7iylw/HUZnd7NBY4EU0v7RfBBNifzl/e8rXfvEgPx04fymSba3qA0Zfoada/p36I
	DblUH/i9v5NJkc7eZU4Mcv+pPmAr3oHHIH2gt4fPOzLmzeU7zvx7jHOta+MA8NFqrkGCCOTfmgU
	dYMQt0icOglqY5ea0YW8Y0kS40SoGqZluL+JCRDeGK/iom8Uc5UKXRpzkwc93TVWtmgQZ0WDu+1
	VxmJnDqmEzRL8sC+vZE6ogsTr4FiGwHZDIRECaaf3uwYhIG9eHi0dvFCmqKxGDC
X-Received: by 2002:a17:907:72cc:b0:c1f:8145:820c with SMTP id a640c23a62f3a-c2492579d7cmr2188829966b.2.1787596931002;
        Mon, 24 Aug 2026 11:42:11 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1533526066b.8.2026.08.24.11.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:42:10 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 03/11] fs/ceph/super.h: convert ceph_inode_xattr fields to `bool`
Date: Mon, 24 Aug 2026 20:41:51 +0200
Message-ID: <20260824184159.240821-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260824184159.240821-1-max.kellermann@ionos.com>
References: <20260824184159.240821-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reduces the size of `struct ceph_inode_xattr` by 8 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 7023af704e14..a3dae2c0bbee 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -320,10 +320,10 @@ struct ceph_inode_xattr {
 	int name_len;
 	const char *val;
 	int val_len;
-	int dirty;
+	bool dirty;
 
-	int should_free_name;
-	int should_free_val;
+	bool should_free_name;
+	bool should_free_val;
 };
 
 /*
-- 
2.47.3

