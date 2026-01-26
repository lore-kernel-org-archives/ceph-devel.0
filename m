Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3571E2D781E
	for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394674; cv=none; b=cTZCnn8+kpx6POWfpVvPBVedGius3cx4Y3+fE6WRNECRTyYx4Srkdl/DnfzfbIEEGibXzCZlgalUxpzHbRErDovZo2RLaTRU99oBIUMtIRSTKs0eNdNOcr3XeVpMilZQAh5O0hFHern+4nHG3sZzax0nbd9x108xEbIjVK+i+Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394674; c=relaxed/simple;
	bh=LEM4dAMdc0CIh1pUicq2+gOIh05/dvfUnzW1HBv6u1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F38QktESqVCLWYnkkCT+LOQJ/O0qHYuQDkXq2/oB5cDOsVsVAWtv+WYuJxKBnfjE8ZSC00VDi6tp1/XXqBry1nhyWD/PaOX56aJJP8pmG8pakt64eDxHOtcXz9Hjnu1/oon7zYpeKMpLI8yeet6LV1/XOubydrKKeb8Jw/r4DYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JM9sa9O/; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JM9sa9O/"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-1233b953bebso10325031c88.1
        for <ceph-devel@vger.kernel.org>; Sun, 25 Jan 2026 18:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769394672; x=1769999472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymnLBLi8khxZIsCQL9bJnfvhV+yX6mpInM8DP2CqmnI=;
        b=JM9sa9O/2Tjk3oFtofm64g2or4VsGlgB8RCbWr8ZfzTdEaAIE8xguDRdBfbtt8R81g
         FPKJ6BNrE7NYz1aGQb1S+hyAuPhrI2L9rQp9k3eN0SahWodcB00MOvn/065Ec+5kSjRw
         LVoRiYBO3hTY6gbYBYpxcmQZxmSThR08aQEIvivhCsvoF0J45P3JQXlTr1Bfg5FLmYMJ
         xagCoAyLTDE5dJArR8j67EoBe0YqrHzmwrcLBc+SxaL4iwxu0COCcaTtJurXCNLSM2si
         ql8oRk3ibHKp6ahEMgP6kieoqcF4NPJhVDGYIS6BcPMfg2xfEV9XhPfz9tNLixDUhSa5
         KE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769394672; x=1769999472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ymnLBLi8khxZIsCQL9bJnfvhV+yX6mpInM8DP2CqmnI=;
        b=EbhBemw1/kdAvGi921s2kD4MxP4tPZwC6OZEThKf9qvHpjyRbNXZ+mQJDOs8n+MeBi
         o3PnUldyk5mr6MjUEUjuig9AeStzf8ODFPaEXWk9xIdtbasWN/1nqXodZaOXK4pKavzA
         w20t77vOBsIf7eOU3EJkX6ZC2VImRTMqKXzrQwFmhd+3t/+V+w7pVv1uLVGq5ploPKI8
         9Y6aRzz6PBx9VUIbXcLtpvQJffhiWNoHBbUWDu78YtN6LnKMAfAxJs4kB0341YLJL0KN
         5VXrQlVeLTPqNAc6TtQ9uG4tt62NoQFzWO5J2S+kE1VHBtePNmxPjVlH3uqUpoHri9mv
         VupA==
X-Forwarded-Encrypted: i=1; AJvYcCU+rc9437+xFnfdrIc5GzRBkfbxP6CsQYU5I5NE937eGXKM7xNn8ea9vc2REIt1rx1cQ6UQDrHHLPVh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrpfbf4Oh9XjaebUUAv0xZ8MVhjpVig0stw7b38cXChwo2lO37
	VG0WQ6MXWoV9IuAr9NCGWsmKlIpo9MJkNceGnLjRM3H02bwna/q4qZ5b
X-Gm-Gg: AZuq6aLW6QUi7JjMfPWTvKRXUP0e1Opaio8t80Mo/TaqAmczaod3PBBPcXGzpJDR1ZF
	//cVPuXr8NejSH48YmeRan5eshflRaf5Llae4m29R80FZula4GV03m3WTIIE8Rv+LEO5LcV1lJ6
	SLjRknc86Nzfy+6mTkIC5B7l9XdSQLUNv075MxehCtVytKAMbSV524WkmLD26Ir1Vi4N+ARc7et
	bPqiHQFLibWblMid/3Qkqa0HlTCVEVGEofFUUVyo5hPi+Oe4P28WRQJ+qWTQOZa1sm4kU3GxqqR
	tAlvFXQgxaqQDUfHwN5HiqtrN2RWlkADpPHnGvlFzAHXPGsTAVnO2Rx1ENdG3Upkc7DJmTTHmjn
	udHgsPP2GpiEn1Ajyx8fF2l4Gbe74L9C+W0+zNcDXvPJWE79i1PnJFpJF9Gu1RcbWeLBWe2xbWA
	lJkqM/1mfwws4fsXtKWBfm6zFwQVg5BG1rVLwAg0ZGAPMTrcHCvio23r72HfzPmsU=
X-Received: by 2002:a05:7022:6285:b0:11b:bf3f:5240 with SMTP id a92af1059eb24-1248ec0e28amr1564767c88.9.1769394672048;
        Sun, 25 Jan 2026 18:31:12 -0800 (PST)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91c52bsm17212277c88.6.2026.01.25.18.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:31:11 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Milind Changire <mchangir@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v3 4/4] ceph: assert writeback loop invariants
Date: Sun, 25 Jan 2026 18:30:55 -0800
Message-ID: <20260126023055.405401-5-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126023055.405401-1-CFSworks@gmail.com>
References: <20260126023055.405401-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If `locked_pages` is zero, the page array must not be allocated:
ceph_process_folio_batch() uses `locked_pages` to decide when to
allocate `pages`, and redundant allocations trigger
ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
writeback stall) or even a kernel panic. Consequently, the main loop in
ceph_writepages_start() assumes that the lifetime of `pages` is confined
to a single iteration.

This expectation is currently not clear enough, as evidenced by two
recent patches which fix oopses caused by `pages` persisting into
the next loop iteration:
- "ceph: do not propagate page array emplacement errors as batch errors"
- "ceph: free page array when ceph_submit_write() fails"

Use an explicit BUG_ON() at the top of the loop to assert the loop's
preexisting expectation that `pages` is cleaned up by the previous
iteration. Because this is closely tied to `locked_pages`, also make it
the previous iteration's responsibility to guarantee its reset, and
verify with a second new BUG_ON() instead of handling (and masking)
failures to do so.

This patch does not change invariants, behavior, or failure modes.
The added BUG_ON() lines catch conditions that would already trigger oops,
but do so earlier for easier debugging and programmer clarity.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index cdf11288d6b7..4e392fc70d33 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1663,7 +1663,9 @@ static int ceph_writepages_start(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, ceph_wbc.index, ceph_wbc.end);
 
 	while (!has_writeback_done(&ceph_wbc)) {
-		ceph_wbc.locked_pages = 0;
+		BUG_ON(ceph_wbc.locked_pages);
+		BUG_ON(ceph_wbc.pages);
+
 		ceph_wbc.max_pages = ceph_wbc.wsize >> PAGE_SHIFT;
 
 get_more_pages:
-- 
2.52.0

