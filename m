Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413924;
	b=cpqDarWiOnt9SUppPLRa4+7mJzvosNwKRlLpXKH+ZLIGIy5ot/PnAVJc+k1kuY9CnaWm
	 EcOenpQ0FQJ+FRYe0S9uNrc4K6laq2FDq7Au304HYgJQLgpIqPzjJKp5qZ7QT73IbDfgI
	 lyYOFaFIbDu9GEHSzsv5ynUXS9jVaOS2C85fQP9PvCXqWo8EX74YwHtnaDiGOWlT3sINK
	 QyyhQ83mjbujCjaYe67lfPWhe95YXbVNYIitownnj8mfaNjjIMYF4Y/lgjDYXmq7+fMKN
	 vcVPnhIK3/rtHs9flQoLmEIYFWZiP1tVwVZ4E1yeaBqp/mfgH9FzWxhGk1DJ+RL0/rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xB2s5ICjL3oZNT6AvTpBrsJtB4knw0Blt3rv8CPT2C4=;
	b=Pgdr6z1QnIqFIqgBA/y9+aF0Y/d8B/HIxAVcQflM4//gykieLtTVa1qQjWW7wnUK7TlX
	 MSlWxTMjrIqAdPbHPIP9OokxR8yTVQNyOU6r7K0AyxyQKk+CncruJgfXBLJKzoyNtKUYg
	 xmT+2oclLzzcXkRzrzG3HnaxxDcSfLWg56uUKg+ly4rJKG25PQDWtFCOeJMLaLyoOY7Nc
	 VFEjQnbywtJ6CGqzE80tT3vuzQkyGn1qpLvwvOWhowlJwW8u2tsNM/588qjfCQ2472p7A
	 MI1+kWRvFWY36vi7yWtX2OWERRJtDP7skgFoPl1LyTIejMt7kRYiNnoNGPpNfvjbT0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=TGAaFXZq;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCFE606A881
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 16:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABCFE606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=TGAaFXZq
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so29405585e9.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413922; x=1795018722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xB2s5ICjL3oZNT6AvTpBrsJtB4knw0Blt3rv8CPT2C4=;
        b=TGAaFXZqf2Brxuyh2Exohfr7P8fxYKFal37wdrA7UNjI79I0ZnjXdGiL4EJesRtQsG
         D76COQSg5iYYvHX9juvxJ/zB+k/o22jwdL8GzfsubnXIeFFE5hNhq8II71G5Y1CUZYoy
         9fLwoG+YTOnvITgSGe3iZ8iG14qxTwiQMvech6s3ROnxuMCwFR4/Ld/N3uXvTdm8vfri
         czNlMo8XOQGS+MKEsSBlIPtItvNBy74On4GuUOU/awT2qLro+LUpyCGGL2b4wpuOk85r
         2IKdHPSA/uSTx+/F8TwFPeDMsQln3bOiVp77+J1180cNhMl8sMou+OWPwjStpw7HbyLY
         usZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413922; x=1795018722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xB2s5ICjL3oZNT6AvTpBrsJtB4knw0Blt3rv8CPT2C4=;
        b=Ln6ZJkgAli+SCUbuoCI8neBr4Z7S/uWlKFVIR7ed3pf0aan1MPoRlR8lkZ7AXnpSQ3
         Egbc6Rg8Dr4gVCeW/Fs6LHTnkCswQHbJZJvWsiJPZFDH889rnSSS76fYXTW+QS5fBRTh
         PWbDSpRisjKwb7uNhVtEzQZ7zEcKbK/E9PQna2VHUW0B5rl4KU7n4xxf2OqYS66a9Fgj
         wrgizVvU7EAiSzHU62/4C6/AWnRdZMwWfVacAPkEhkP11iPujI5rShXCX5pmvUH96Xef
         vT+gLmHF1atweZyTldyDmuzlb5tjSmr2NY3SO6erHFST7JRyl8ybI95EEBMf60f5vE8B
         6YPA==
X-Forwarded-Encrypted: i=1; AL+hErGty8zbfokivRXL5TOAwjSjWVkgheyOFf2KKBy+CpIU+G/IE4fHmiDWEGDJ77kq3KUR4YnVw3EbCXjj@vger.kernel.org
X-Gm-Message-State: APuU4Z8xKKAih9j+916Nvt+AddRXz2J71DrbwPtpcR5ZFTvl9oXCr0EE
	h7ALG4Z1TIffRzXi2CjYA8xuppN5KiREvxnbtD7apVg0+YnypvK+MXPMn1YmR/vSndM=
X-Gm-Gg: AYBFou0enMMLAEGWrVfOeicRVrosvdD65TZ5bXmgj7ghtkVEUqhd7jxWrcMw4Rqvhv0
	6qi9VfBsLcNPdW2rNk5fU2TlbILcss1B8KLPbXe0kWT57muhuoYHaP75253ptCXcTvTWqMAgAv4
	dOhmkdGzxkMqNpftmj9Tn1ne6tdzn1o4x8dTn9R+WSOjUfpFP+fo0ZKegDAOTrDt0AK5ynL+I+L
	yeHtLLvCkSF8CipNSCAvZYsTMXz6rWGc69bMVZSqB/SMkiUjvyINgVyxcvbNIfQMT+tKu/9gAl0
	xb6ACFTNQsYzFF4pKzHPGpOtUI1LAWfBd8DsviB7AggFn3t1hkFJVC9iy6LzvCbJufgfiSCw488
	RwQYcu962RgVl10dfzvokV7y7LjOXjvA79IwGy7bVjgbrlQyfOq1n6quSaos8XqObQlzKOJ05Lf
	b9/UABn/Nmwr3bEQet0VAqZB8fC/X7koBiKTbHnWOHlHkg0VDcB7uGcs5AAZB67h+Oasa7vRKP6
	e+CX3jn8UMDulfe0i6mLVWKFm0U3tGUi2MQe7DMmuKfR+75IxIrhmpoBf2wKxORDskPXJ1wXc10
	kmMTWl9qU5j/c3bBl4PNeOKxNY/npdN4VfrT1rZ5daqnv5Sqvq6Lo3fGHcnzX7tzPQUGb27uO8h
	MnW5aDABEaC/T5d4Oj64qRD9utAmx43UAFsIAJFnmHKVN2dMajhM=
X-Received: by 2002:a05:600c:354a:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4ba0935dacbmr52726595e9.11.1794413922136;
        Wed, 11 Nov 2026 08:18:42 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:41 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 7/9] ceph: fix osdmap use-after-free in ceph_sync_setxattr()
Date: Wed, 11 Nov 2026 17:18:28 +0100
Message-ID: <20261111161830.1336485-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
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

ceph_sync_setxattr() reads osdc->osdmap->epoch without holding
osdc->lock, but ceph_osdc_handle_map() replaces the osdmap and frees
the old one under that lock (held for writing).  A setxattr() racing
with an osdmap update can therefore read the epoch from freed memory
and send a garbage epoch to the MDS, which uses it to decide whether
it needs a newer osdmap to validate the layout.

Read the epoch while holding osdc->lock for reading.

Fixes: 968cd14edc3a ("ceph: set osdmap epoch for setxattr")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 8f97b6448d7a..64ccf70aa3dd 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1179,8 +1179,11 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 
 	if (op == CEPH_MDS_OP_SETXATTR) {
 		req->r_args.setxattr.flags = cpu_to_le32(flags);
+		/* ceph_osdc_handle_map() replaces and frees the osdmap */
+		down_read(&osdc->lock);
 		req->r_args.setxattr.osdmap_epoch =
 			cpu_to_le32(osdc->osdmap->epoch);
+		up_read(&osdc->lock);
 		req->r_pagelist = pagelist;
 		pagelist = NULL;
 	}
-- 
2.53.0

