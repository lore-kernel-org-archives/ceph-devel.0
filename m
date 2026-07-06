Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1869318EE7
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 07:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322732; cv=none; b=czOP+Z9wFHcCC6RqTL7Hp9Tho5X/AvdilIskbvJfO+Is0Kufjp6afiHAKszZ57vdhxfv/Rv9uJnfyS7DQkIpEFO0WD9baLcdGxyz+RxoOAdnHA156diM/pZJDIxRoMvaJD5HkFM+pwOrs+AmMlsAHWrtiuHYMyv4gzlMf+qz9IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322732; c=relaxed/simple;
	bh=HiEwHDUQmih0dg759t4MjyvJaa/EbuIuSN+VdPQaJRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=taVjj9yYbvhBOy+PbLdNxy+nfg9iJb8NFAI4yYEnvUpie4anxMMHr3zJ5V34vXN+oZ0vLaSkGM1w6X7yHb1jBt+F/GqFOqS+sdMfsLw/mZ/LpK4Z35PWhc5BE/s1xYlZvqluhdy5/hZkcpndmv9/c0bXPE6QKIYx/iCtGfY7+XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=g0Oq854K; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="g0Oq854K"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493d1e8aa46so12771855e9.0
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1783322704; x=1783927504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tN6eytsmx5k6QHDkkEjf18snkpdr+Uwi2Oi1KKbKdR0=;
        b=g0Oq854K8ll3DoLBDhyqb+84eeBoAkFsmGow/AXBsrSn3hxN2SqJGeKR0SeBzbSbRH
         bbDAVQwI0mcylqYKsGU9b+D9pX9cW5TjyGc2/9zVVu7XHfHrIwcIBC0HaKslWo2qgQAD
         g2O49lTkIdle8B6V6UmpCrpbE3FSHFQ7aWPZ6l0bZVzI02GpBIdwIkC82U4uhPxXzXAi
         xK/GlNypK9VqsOIibnbGL1gyaWrcG8RX3v/swVYqRtqmVbdytrzswS8bhLc0ePCP4Acr
         CXhqwY3PvDjmmni4vbv1pXiGrYxgJ3YM70JGZ3vy1Nlv/x/3yT9XIldRYVrDTcCH3NWy
         WKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783322704; x=1783927504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tN6eytsmx5k6QHDkkEjf18snkpdr+Uwi2Oi1KKbKdR0=;
        b=AGZsGTWOof/umxuPDvdQ6IBgzUMGi0L2CqwIIH13DXiTvZyBJld+EilBIHjuUBx7jf
         yeP6Em+DjMiPHr9XSwpM/WRQtnMY+yLsL6ReHoak1jtbRCy3UAMMsCzgKB+bs6RLzeek
         gUV4cw60fxPtF4ir4k0e4EpsbZxPq8TMPs2hRtJvq9Qu3UVC7stNkmrl2yYzM/MMWBFv
         7KglnmWgfTy53ytUdnhEifW1kZ17/wfTNBy8Hqg26qquxDIBQNAcpQz2XdEwCBZpIIGa
         kDxCp5vogDwzb3TLqsg069FDWXzG8mBhJNxXKBPKVHw4mTiLktWFOcHS/oUqrfkn6PHP
         bjqg==
X-Forwarded-Encrypted: i=1; AHgh+Rp89gi9eFMrXI0HVVOnMkviru3uWsKamj2pGMTNQt2Y5hkfOm0zzaJ9LPJ9zuazaZIY7qH30dvvg5C8@vger.kernel.org
X-Gm-Message-State: AOJu0YzddaowQ2INI/fvKStdptf4gLaptN/ToN+czzsi9qzscJ8ADnHJ
	5Cd2mJ+81d3vDGTHpMQ4UxJ8e95qKqOhaxnMKSJNt3Lml7w3NYauGoxQL3YVH75OhAaxLANt0yn
	EusYkpYs=
X-Gm-Gg: AfdE7ck3iEIOcdgVIg2SKAqGd82ccCBBZi1DSxs880c7uNurJafr2oPPIgq05UE56yJ
	IRmCCXZTbJ7Z+RsSdQPnIUPUOfcse4B1JLen1ETMZ32Teo0wOtMlntc7tvCthKojjgWrl8BzPwd
	nKC/1hgGuVaIB7yF01tOl4Zug4/CwzY5kdBYCv/Kz93U12Ar+CgpSvqxxTP1lH7bbIiZuGmHq7L
	k5pUP9BG/BbeVVuDxlfE2om4kabIe58E9p/jKvaKy7mM4KvPmt7PInDEsa2FORejBEb1wRlrpI2
	e3sNf4Bk8sRq82jewny7TVmUgnQmAXWRdrzJGjvZx08h6xvKJdVIIglo8N1+On0hzcNUtZvCfA2
	LkiHELQ1iQefO2020n3PA2gbYyeQdYQWg++WYAfXH8aR/osm0XkyRi0uUi0gMdSbc3RmxlmPP2u
	iN8ykIEQtUZDcP03pha6CWdWIPSpa+orWS8jS+xqrMunLwXnAdIpgAMq/RfRihXCb86w86Mbr8G
	55g+ISO6CpJLPzy
X-Received: by 2002:a05:600c:8b0d:b0:493:c59c:94f1 with SMTP id 5b1f17b1804b1-493d11cf2c1mr96761185e9.2.1783322704588;
        Mon, 06 Jul 2026 00:25:04 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9de1d905sm22324916f8f.2.2026.07.06.00.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 00:25:04 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 13/18] fs/ceph: remove unused field `ceph_cap.last_used`
Date: Mon,  6 Jul 2026 09:24:44 +0200
Message-ID: <20260706072450.3920010-14-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706072450.3920010-1-max.kellermann@ionos.com>
References: <20260706072450.3920010-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reduces the size of `struct ceph_cap` by 8 bytes.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index e5ab1b83a84d..4916faf54915 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -224,7 +224,6 @@ struct ceph_cap {
 	};
 	u32 seq, issue_seq, mseq;
 	u32 cap_gen;      /* active/stale cycle */
-	unsigned long last_used;
 	struct list_head caps_item;
 };
 
-- 
2.47.3

