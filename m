Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D2D403156
	for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781283142; cv=none; b=aQi5SZp8/fQafpOfQ6cxmdwpUP33OKCNdAGIaSJIWX4gh6tJ9dSBeoiKYw9B26dzEnu5lk3OmrExnNl+TYemx6A5srU0ENMJxBSeQCmGZAj5GJHcTnPC+hofITRFlTf454Ch4+N4hmg8ZwOc9Rj5UDBfoMp5gnIwDXabyv1EpWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781283142; c=relaxed/simple;
	bh=fBYjXllmdSVYkoL6GO3Rebti0yLEo52w+xscqDUAO2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s67U63ineClksc8PGEpCz9Yrf62wzX74d2Aj2LezYY8R2iRAGznYraR6e/Kz6q6UFDe1kBzGOrJMgv805+os4QFZu4bolQs/I5gssqMgG7Prqz4ZzHUsSgtc7IH38BMSoFIQtKKG+87w3D843zRrTlveinQEtbkPyC450q3Zv2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VZMRllvX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VZMRllvX"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef29c5561so608572f8f.0
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2026 09:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1781283139; x=1781887939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W/R2A4vl0Ym4sno9PN4W63fDY3ZIti5Knq9cJRaCS4=;
        b=VZMRllvXiS730rqhCOJukrC/3raU6n3yiYQyC8j0aavde4Al7e0kL0R1dBhNdqvsxS
         CgktMJHMQIfsXYLKOMUK4Ftq6R/nRGn8rYk63oo7XTG2c7YZsHczGDdxhSMtBHgCKMYF
         nKmV0zIKVn7U3MjAuMSQvK8IBXUiSbMMiwjcvg+UQ7lZ8GxxekUKsQkbxeDyLe1gV5q7
         yljEO8jM9+eRlZRsJr983DPB5I76WjLRSwG70xtV7zQ5RVLEdFn8pOb6LKrPXI6pxTLO
         siU0I+8oUeWJCfJOyIGYnI4JJE+nfIwC8ed4CqZ/sXho6QgzNXnpk6dnmGoarOJYxBSl
         TypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781283139; x=1781887939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5W/R2A4vl0Ym4sno9PN4W63fDY3ZIti5Knq9cJRaCS4=;
        b=aenCtFZUVPBgf5aX0xTsZ8jvDpvSm2MDk+oehcROJY9h0kmf4bIfC560oRIV+aexJp
         9E1/P8Epx2exwsPYYMdJcGJb/k3oCmpADYis8XsUetSfw8Z2sAh2pqoAPBqbJYssDEfW
         fuDpzGfB0kWgtQ5xQBD/jOMyOx/oDFYAgjM5kTJrHRJQ8iEIg/apVPDbjgQ/yC48K6xD
         1GwJUKDRBIkci5VK5iSNu6fxce81RV+pQUvFDYQsGXPcf361xtmEQc0qe16x7hx9Rkxm
         8BJ41agW4YZjDKpoOxfQMETodk/PGeLWogHDbwzd3A78s0LhctDvpVeHVaafse/TT+gl
         EAsw==
X-Forwarded-Encrypted: i=1; AFNElJ8baXAAuiACPlVA8FtgtwNGrkxWaqbIHyESdm27hMkEywmBoXBqPVpILBpAfVNHAmRooMqO3nkBkr76@vger.kernel.org
X-Gm-Message-State: AOJu0Yy81tqZM/1b9hLdqiP8ZErvYQWCBWCJ0ubkgcvhrirg66jNG28j
	ng2EeIpuwvcQoXLF99wjLXINWx3RF/alhL/xs9vbJG8TIhVykiczytn/ft3J1doKhoA=
X-Gm-Gg: Acq92OGaPYo/2TKVliidEsXhW/ShIHkYYL5AeG2ugLHjaHQbRFLUyYlD7VdH82gPbki
	xjIAdSkqHWG/aRNDOUiLCagR8gtgV9CbboqO2Rg/+Tnx0Uh8cH43d8bmNQ1HPeuOfH5cjIgDgH5
	x3zzvcvBOGPqXd/ALIEUAmdUF5v/JgU1VWWOF3FOpglS3J80J+rY40lV7p/AXtLcjpSAMu7NHpy
	T/8SxMif6PsrDQE7KP2faOsQCzja60xuiL2n2C/x+ahlzGUunh4FQREnRG7Hoju396Az2ACIQhv
	768LA+/uE9klECjoAtRwG6/vUFzQOzhDtx1kg+yu0kDcZQR49Ab3K9J/jYIr/tvbfIzUPUt+C9g
	RpoCJGuZvjx1PsT7AEKsG/Xj/FXYg5ffl0K12RfaY8tRdV+8j/Eis9UrDE7s7sDfPs2kIhYU9hM
	w1U6NFasWaS5O7roYV2zNPRaIKQVIlPCGK0/IASpMSg9yXzIUrdlsl4xQWXYl7tARhfJ00ei6w2
	nJR1FEPEWPBwctjUa5slJZCvaPjUg7alywGKA==
X-Received: by 2002:a05:6000:4301:b0:446:96b1:f5f with SMTP id ffacd0b85a97d-46074a80071mr24519f8f.8.1781283139488;
        Fri, 12 Jun 2026 09:52:19 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f45eb00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f45:eb00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm7807377f8f.11.2026.06.12.09.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 09:52:19 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 04/12] fs/ceph/super.h: convert ceph_inode_xattr fields to `bool`
Date: Fri, 12 Jun 2026 18:51:56 +0200
Message-ID: <20260612165204.86137-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165204.86137-1-max.kellermann@ionos.com>
References: <20260612165204.86137-1-max.kellermann@ionos.com>
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
index f0f03aeb5b19..18960a9e735a 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -318,10 +318,10 @@ struct ceph_inode_xattr {
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

