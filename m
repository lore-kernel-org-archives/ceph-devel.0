Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E59C3859DF
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787596933; cv=none; b=WHBV43WP8ec+pbicUrD2z3rHtuOrY6oFTy3GIiKme5szuT7YfyYiSoHlwX8wE+Mix1olvqNrs3O0tUyDr0Sm72WJRC0XEyL40uRXec8RTxowtqEpV5DA3cYuH6peGgGutVuxBUCaUN9s8tSHuSgW+ppfHUZaw4MkJ0oelvGW5CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787596933; c=relaxed/simple;
	bh=rECAuaCU+sisvFAxlz4wBECy3Fjxf/Y512+AyaTPnw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P83rahEh/dw9Gfc63dkOw9h4i0HfOeFjMiR4DQMLR6IuVMIb7LNw3hCqc8o7iikGHhsPKwltpTe42oDA+F5J6kcR+yyhC/3plxKlvOrEGalR3dwP5nFPcvBk/VCu37aL9gkt2wAlkiqsOercKxJ5hAeIeViIsm+iZ5CJUmq5i2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=ARdM550l; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="ARdM550l"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a18e24ad25so5262735a12.1
        for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2026 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787596930; x=1788201730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sXE4QLrQi2i/4sxK4k31CjHlNpeUbWys3Ip47/zk/0g=;
        b=ARdM550lU5vLTTrgFazPs2B+vw6KTTZxD8KGXHebysDrIy9WrOXrI93OCNGr+aTJhk
         5g3BKJfBLySvzLAh3MAh8JIpgvWprllviyLo5PKyqArHyNPtrTAk7J+xA8fVBP+t5W4E
         Jrv7vfgc5HxN4HNDjOxFFu8jl3+lxXrJAclMmsoZRLhv6xQzdMzUSJq7gYnU1YP1a5Wo
         YKuVRBV1qLo/WFyjEwJf+tmBkvZA3SaVeUCLoAyYuuER6QZ5f4zUwQ9+C7zV38hyOgWx
         iU0uUsfnvtq9bVvApLiwxk+1I8uK7LDJFrk376+nk1GZtJGf1wwBIUYwb1i6280pOIR3
         tS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787596930; x=1788201730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sXE4QLrQi2i/4sxK4k31CjHlNpeUbWys3Ip47/zk/0g=;
        b=lfKgVWBw3RaNvX6VSxCGmcESIv+X/xa+2b8eHLJk3CLoajYhGSxBVpCYR/W379wJUK
         h0qD6PgVsn4XpPytnDSP6KoC8atLQpeYGgRJqJzyG5c54r5CxMgsqMzAVsldB8wAxITO
         lTr+5G29cnJfNTcrEbHXcsgj0BTkJmd3A0Emp/oyxkyuoozK5dqhWn+o2jT4puLEt9oN
         g3ZAfl4vz1l++MyoNbzsyDQETk+EMTUIGPZgqiYbR2V2CWvVLyQHgEkuqAQIpnEIMsy/
         aCc3jM8KW3iLp6LKAVLeADVMGARTFzI1qpsz2IXpPfpDKju/D1C9amHe2b2Cl/WZJPm1
         F4kA==
X-Forwarded-Encrypted: i=1; AHgh+Rq28b+jMjae9nGzHzBJ15S+FiljMG3ZJem4cJTLSDSRl0QJY6OEySFCp1t/EwhOXMD/KzKdSB0x0hho@vger.kernel.org
X-Gm-Message-State: AFuF++me6VNktn4NpuYIiO0zED1I3C0XlTMAI26jiJReikS4+pwBfwhU
	1mdZ7lVX+MCSW7V2xjNrVL0MDdCV00039KV9CITva5Ji3mdlxNEuLKmaaQCAEzabBE0=
X-Gm-Gg: AR+sD12Lb1boCkZMgzqgwx+mUmCueX2JdEz5DDoGnRsFHkecTTK8AGuPEUzVIrFLJt9
	7KC45ACZ1oUqrTe+GTWQ97xtVRmGhOsdfv4GKlUVffxiJ1vrZMIxRfZ0oQPi2zzkk7wv03UBhpJ
	p7cF85KCy6rZ+BfFjPO2kJoTXTOaz5+4kveKpIcydbiQPnbJI4ZRSbmVFYOpBXH5LX8PLrd73Ne
	lLZSqJdBLSDFCuWv4/hEWgO6fUCUxy7vk9z2fi6VFlg9TNQnQ1T0k3G+3FQqVwSeLXlpb7reWm7
	2Zl9tY1YEQ/4KaagMNarlCpCNP84d4XJzdYIKKqhfOiFbDQ+hnJg0t5J6Mq9bxsKDhc63tmO8Ko
	v2TWxlhZgT9kr/pGVOnzNmgyVKpyNsBk1QfvvVfy+nKYvsd+bNjZEgxCwC+Mfs96gi5jv5qzKPJ
	P/5Lg3ZaN8VBlNi3aRTPmEudX05/YFHkniaUQysiempK9y6/Dsc1+1XUZqws7YHstXhlvbXnWTd
	0NskP9Eqjkioe7s8vxSdoGdUb0jrWXyLav4KJRBZ4s3lVpEogDhima1fuCm13YJpXtoDFHfKic=
X-Received: by 2002:a17:906:100f:20b0:c24:e1e9:69c with SMTP id a640c23a62f3a-c24e1e916eamr99284466b.0.1787596929507;
        Mon, 24 Aug 2026 11:42:09 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1533526066b.8.2026.08.24.11.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 11:42:09 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v5 01/11] fs/ceph/super: remove unused field `i_cap_migration_resv`
Date: Mon, 24 Aug 2026 20:41:49 +0200
Message-ID: <20260824184159.240821-2-max.kellermann@ionos.com>
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

This field was added 17 years ago by commit de57606c23afd ("ceph:
client types") but it was never used.

This reduces the size of `struct ceph_inode_info` by 8 bytes.

Fixes: de57606c23afd ("ceph: client types")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/super.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 1d6aab060780..3cbd320b49a8 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -450,7 +450,6 @@ struct ceph_inode_info {
 	wait_queue_head_t i_cap_wq;      /* threads waiting on a capability */
 	unsigned long i_hold_caps_max; /* jiffies */
 	struct list_head i_cap_delay_list;  /* for delayed cap release to mds */
-	struct ceph_cap_reservation i_cap_migration_resv;
 	struct list_head i_cap_snaps;   /* snapped state pending flush to mds */
 	struct ceph_snap_context *i_head_snapc;  /* set if wr_buffer_head > 0 or
 						    dirty|flushing caps */
-- 
2.47.3

