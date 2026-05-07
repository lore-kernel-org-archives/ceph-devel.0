Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189943CFF67
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156872; cv=none; b=jGjkY+norNYpkDUHaSgPXjA9oEGpqDcvxWR901v4R3tf2/ZHkASM/DIRxvYRCkvhJiRKaEGXIhOk9RjqTXjOujdlB/FN9YYYsx+0b0C6ImRAWDiJF+uKL+17cO/7CBpe65D/DfPE+8+5FaX92GjSERGHiPzgTd17f25r0Lft95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156872; c=relaxed/simple;
	bh=dFfXxXUgWjZXnJaD7FdFUoB2bFjm330eUC68lYkgAbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AkJ/rF5xDej3dAZBFSAS4HNeba/0gRXkzOUOp0s2MNLgQVSHT96yDQ7PXuWgTVfdEOkjMFC71EBeNVGzyaKnxOXBzHoUpERrmQF9tWG3x3HMd+RqZjtxgrUeRzsLPbbLBsQjAq3/JfUhws+Eu8Vn0LNOTz1BebLG3osftT+ZMv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1FIdEka; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IS2k4HPa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1FIdEka";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IS2k4HPa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778156870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FShB2QBNaYE6cemrLjaYKdu3+KNOFPBeUgQ/un1s7QA=;
	b=E1FIdEkaweLl4d+iJkRt6IB/jCmvOqac0DVn2AmTCB25ko3M68CzCxSduq6+HPkkiV8Zrc
	45p22iAv21lkxRjX5r0xB7K1QkEmFsAb5m/s1weiU450iDjZGEW2MkUVQZ0wTYnncPofGk
	LLdLXrEE+JGfZpASUPNIdcQBbk9iOx8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-ft5WaYGqOl-SiPuE617VcA-1; Thu, 07 May 2026 08:27:49 -0400
X-MC-Unique: ft5WaYGqOl-SiPuE617VcA-1
X-Mimecast-MFC-AGG-ID: ft5WaYGqOl-SiPuE617VcA_1778156868
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b9360e9f43bso80207866b.3
        for <ceph-devel@vger.kernel.org>; Thu, 07 May 2026 05:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778156868; x=1778761668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FShB2QBNaYE6cemrLjaYKdu3+KNOFPBeUgQ/un1s7QA=;
        b=IS2k4HPao6dGO/lNNtvjcShjhSsKWUl5bbcxsjYDghh2t+/4ZriUEbwuRq0dKTCAtO
         IoWYvR+VnOvwI0qj06/s8wiHxss/TaE177cOVaexvaKaMzOUO7w0us26ogpuke0hhzqe
         X1Sx6MiHa52jtqHUR0VN7jhDWWVhOUTRespLPXNexr7xQ2vJbxokmhGdSLbqDX7Z52za
         e23MWP7aP3Gz8tkaCF7ulUPZnzoM1o76JqG0xDUZXSX0AhCKI6PspPoaqpeGlWTYbRYt
         YZTrDqGhZdxFXLs0xRVbr2gX7zXOw/+eCsKB4Ol9RJUEgXzHhveQSsQCj0btMJ5EsLu9
         VycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156868; x=1778761668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FShB2QBNaYE6cemrLjaYKdu3+KNOFPBeUgQ/un1s7QA=;
        b=gSZM1lWazGEiBouYGuvlbWBMn0oyvZd61WlvRfjYaLnKGl78qckvdTEtmeMv8Fcqpe
         12GWwAVRdVl3ILu9zffu3vrAIFAkf7KW+gCMHFAy9WxHBIZQPylyuBgkqMat0VFtI1Q4
         WY3gNSzRh07vQpf0WdbGA8kCq/ajGgD2A/CRrWdn/AtpYDiRvwhTCtGPvUKvqbeN/5Ks
         lNhGOraQfPFdUrU8RpSDDxcng7mBicqgkEQwIgryXPS34DFkyA/Td99B6bidrcXe6xKD
         rYSexG9smfG+PniQm0RcD3pTDoHj78ql5K2wBPeCcfMGgYlgMUXKlycpMomYAfbqlrS9
         CSuA==
X-Gm-Message-State: AOJu0YzNA3bmKtJIiFAMlTJu5RFdPE8E38caoZpy+Zg7yW8iaUXBQk+Q
	i+tf75a95rWAsjS8obL4kWZlWw/fQ7AuZnJ9vICC5qFCC95GdGLYmh1iYoTDlw/bDTHQXA7dtW9
	afzNNaSg8d/bh6//GTpkP+3QvH3+WRKentEpjN9gjJFPTbdtPLHHfSHOK+Aa8mttfza+EwaMsoQ
	PLGs9Ztg0u8IVxdZUO51tqkDlrlQHjlFb9K04um1EGaT5FK+mk+Q==
X-Gm-Gg: AeBDieuKZSPKPsf68UrRofqhnUu1yXiz7XLFmx/xSWUoZL0mTdWrg953ycRtF8VKBPp
	QGKo/GOKCVmPUfxso471VxQTXK/ouEJG3KAmHcPiaSVb1HBocOaQxQO6Pcq7uZM+kFRlnAPS9KW
	rPkOD6HY330i+2Dg3JAZyX9Z7GQuzi9vgXUTI8NtRu7VsuBLMVtozIV/XMu32pgaWfplSvqbAvY
	j2/LirpujFWj2oej6AkOmASxmuQQZ/FjMLK3VWP08Hq/ZF+N3Nv+5Y46ZyNPGnWDhVz0DgJl9mT
	aP+4XlB2Z3R0JIZYMe7ybBBASpO5OPCXCYgpaTs5/N51llM7azU45ErOOsvcAdP/kF9Fl+6Q/EX
	oKJRa+etqNBdRCqN08ytXPuVsgVD5oQvQIiLuoqoldWwx1P/hc6V2LNcH7+pH6uEyng==
X-Received: by 2002:a17:907:1685:b0:bc6:7238:bd4e with SMTP id a640c23a62f3a-bc67239005cmr242651166b.5.1778156867654;
        Thu, 07 May 2026 05:27:47 -0700 (PDT)
X-Received: by 2002:a17:907:1685:b0:bc6:7238:bd4e with SMTP id a640c23a62f3a-bc67239005cmr242647966b.5.1778156866908;
        Thu, 07 May 2026 05:27:46 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc81cd34ce8sm76552566b.9.2026.05.07.05.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:27:46 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	idryomov@gmail.com,
	vdubeyko@redhat.com,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Subject: [PATCH v4 02/11] ceph: use proper endian conversion for flock_len in reconnect
Date: Thu,  7 May 2026 12:27:28 +0000
Message-Id: <20260507122737.2804094-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260507122737.2804094-1-amarkuze@redhat.com>
References: <20260507122737.2804094-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the __force __le32 cast with cpu_to_le32() for the flock_len field
in reconnect_caps_cb(). The old code used a type-system bypass to silence
sparse; the new form uses the proper endian conversion macro.

Also switch from a raw bitmask test against i_ceph_flags to test_bit() on
the named CEPH_I_ERROR_FILELOCK_BIT, which is the correct accessor for the
unsigned long flags field after the bit-position conversion.

Remove the now-unused CEPH_I_ERROR_FILELOCK mask define since all callers
use the _BIT form with test_bit/set_bit/clear_bit.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/mds_client.c | 5 +++--
 fs/ceph/super.h      | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 53f1012a9e7d..d9543399b129 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4747,8 +4747,9 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 		rec.v2.issued = cpu_to_le32(cap->issued);
 		rec.v2.snaprealm = cpu_to_le64(ci->i_snap_realm->ino);
 		rec.v2.pathbase = cpu_to_le64(path_info.vino.ino);
-		rec.v2.flock_len = (__force __le32)
-			((ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) ? 0 : 1);
+		rec.v2.flock_len = cpu_to_le32(
+			test_bit(CEPH_I_ERROR_FILELOCK_BIT,
+				 &ci->i_ceph_flags) ? 0 : 1);
 	} else {
 		struct timespec64 ts;
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index cb45a59dbb19..8afc6f3a10da 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -689,7 +689,6 @@ static inline struct inode *ceph_find_inode(struct super_block *sb,
 #define CEPH_I_SEC_INITED		(1 << CEPH_I_SEC_INITED_BIT)
 #define CEPH_I_KICK_FLUSH		(1 << CEPH_I_KICK_FLUSH_BIT)
 #define CEPH_I_FLUSH_SNAPS		(1 << CEPH_I_FLUSH_SNAPS_BIT)
-#define CEPH_I_ERROR_FILELOCK		(1 << CEPH_I_ERROR_FILELOCK_BIT)
 #define CEPH_I_ODIRECT			(1 << CEPH_I_ODIRECT_BIT)
 #define CEPH_I_ASYNC_CREATE		(1 << CEPH_I_ASYNC_CREATE_BIT)
 #define CEPH_I_SHUTDOWN			(1 << CEPH_I_SHUTDOWN_BIT)
-- 
2.34.1

