Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9839A81B
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566606; cv=none; b=uCD7WJFnYRQn2VIHMSqMrAoK83uYsDTVeRsj+BzfBAMc+ohjIAEd7XTIKf1QsKWNRwyk12DCuoXpVUSodFuXcNGC8YO/lPA37tnh3tiS5bDLZNZab5rQQ9XZ1IsBumdleVNtWkZ+4jKv8ylaPcuG14cactJuGKSldgwn27788pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566606; c=relaxed/simple;
	bh=mh3Wvp3erJw6hgEc0BaFtMvIaRlm0xL2iUvFtRAjH5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czVDvHmccCa5Ubl5zEluXw6YjukTFcttYOmxl5GigLKcd0OXlUMQhorBmhz0llo/UcrVUcY6TrmlJcU99Mk9NBV0AueywnzggEcGo5gEL15WfVZzGP5t1fjl/+vvYFk2OgmnFmW1D0MGzPAgLEPk52tBh2cABcJITI2er5EhT10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WK9aqTKf; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WK9aqTKf"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47ffaa8ebbdso1125621f8f.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566599; x=1787171399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DYD6EXdc3EA1wjI8XloWJSr9upDOkRMjp4PLGykUXfY=;
        b=WK9aqTKfWsP235+xvpSaQl7ZJPYJ43KQ5vjeeM5kB3YzV6d+nW15WRW9ne7IWuXk55
         3ZQlAIg727FnbaHlka4iE2mP3JlHf6HMufWzUf/HzqnRYlHw+hOQQTUiAdhG202f3TUl
         iT6JZjzVxMbAr3GKzLtDvox49diDkhVuOUo3QCijbOyAhN86V/88/+sr5ir2Io2EA/6b
         7K/snJA2CfO3/Br4g18K0JZYuSiTr9xvrJrZf40gIDWKapPSc1ZpHhrSIyYXtEx6Ik4D
         pZw0FuJMFD5ZpodKk63GqsRQYQw/FkBga6SROc8UYTUcyfN5+BMWDZLLOIorC3fHrkPc
         rePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566599; x=1787171399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DYD6EXdc3EA1wjI8XloWJSr9upDOkRMjp4PLGykUXfY=;
        b=kiVeMRxSIzG542Ov22mennpCD8WdwDmszfutlJvONhmWZGBqdA5CE2l/ecNjwJCmr1
         9X9YQGqPxG9OjHRrX5CBuTTYHIyD3GpG8C9N//al5kyFsO75QEPeBTyLEPIRfSo+S139
         kZYrGrp+ClM91UOV1ZtuT3xQgfzj+lTxLX81FYDAPB7+INZ4gv2omD2pNw+dyUB3UBIr
         e/FOxzn0sWTlQmozef9jVhDKYyuxUZOZ8Anr88Kx9kXLsGhHpJISZXQyX37BJ/25u41B
         hnidQuUV+jTkTPN6dThS9PnaEu/U/5A28/v+glnjn2MeTlcq63ZaofUTGpsX6SWL8wcH
         GD4g==
X-Forwarded-Encrypted: i=1; AHgh+Rr6pQWfmu6sz4EcDaL/+zvvu1hhA1Um5sQEUPvvMdAJX5iaoLoW095k6+Y33KVgUl4y9k6HzeXrlp47@vger.kernel.org
X-Gm-Message-State: AOJu0YxqPSYHvcsbT1xDdiFMwbIRVE4reZLAivFwnOJ9XGt16vHgV8h4
	td7qvhmRmc+NXmTd7+kYGzOl5BKdCCUEegqOo5JNNc5UQGjIGup40cUenM7HFWt+6xw=
X-Gm-Gg: AR+sD13Dgr8WQPdxGDVt1q6Tr2B1pkGrbBUycR64K9EB6N+uJENIwMXY0ROIAMIyVzA
	QIJsx25TKtqeacWhCWqPiSS4UHUKgua8I8UhN0iEv5Ed3SWCsvHQmIuNs9iREp0vQUQ8ea218d6
	zcecvI7OyPJoWrOm/2k+ZE28RJFLxpKntgYdi/AfmOZpLEfbrU/Q2l32AyGfOyJ4rCQx5rngvuR
	lMHMFkUqfqldb7CiI17gtV1BzcXPfUJxPg296dYWG84MVA4GSTmGNrbRt0f834VaHf6FrMvEOWh
	v+rTy6VC6nnMDcs8xybDt86KTQ9H8FiwJkXhyrnQIbSuwbBgf4PpLa4lVAOWjaJqmayv6fdFnwo
	y0IN0XnFej1siiq5YmBxr/VdHF6ayvSCtfh0JWXldWfb6EYCY8sFHqlBwDwirw612FRKrIwKkQV
	U4ICOXnwum6AtXARbjyQA/WfQQiTf5XVV2EJSDYkWoSEMnIGe5EP8PYvHSnoxPLF95b05lfUD2W
	WEsUfzIZNUCCfqokwpPSIZausFGxgxh5qfU/Iew4reLvSCla6H4DMJMKniiHZrf
X-Received: by 2002:a05:6000:46c9:b0:47f:8fc8:af01 with SMTP id ffacd0b85a97d-4815a01017cmr598862f8f.27.1786566598647;
        Wed, 12 Aug 2026 13:29:58 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:29:58 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 04/12] fs/ceph/super.h: convert ceph_inode_xattr fields to `bool`
Date: Wed, 12 Aug 2026 22:29:41 +0200
Message-ID: <20260812202950.1800340-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812202950.1800340-1-max.kellermann@ionos.com>
References: <20260812202950.1800340-1-max.kellermann@ionos.com>
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

