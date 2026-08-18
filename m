Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F1448551F
	for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076715; cv=none; b=mgXpApgQOiLCyYzJ3pREPdOz6zJtM0DbzbZaMeZMB+FSk677wwduuVuYW79JDRVeoMQ2U1DrfDjBd1i2ZcghW16KmqQ7AFtEYKsKAkD30aTUMEREQxhOwStVHI/dC1e4bjmbPv6l1etT7qIxA7JqtBNb3vA1fLlSIK58qaz/cy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076715; c=relaxed/simple;
	bh=mh3Wvp3erJw6hgEc0BaFtMvIaRlm0xL2iUvFtRAjH5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ok66GHj3hQGdTcxIKvA0W2hRrRgXBVbPL5GYu+JWOKO96BvR1AjEmM+2l5WVKMPFqmKLUQDqPgXyGsE4KYFFqpxIP9phsTZKyNzTHh1O6Dho5AuRMuAJ9R8kb4TwOO8Hr0fqHkISrQuxg959K5G4eo6WwDdH/3Y5OYY4bOIScKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YpQBNPWw; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YpQBNPWw"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso32883f8f.0
        for <ceph-devel@vger.kernel.org>; Tue, 18 Aug 2026 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1787076711; x=1787681511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DYD6EXdc3EA1wjI8XloWJSr9upDOkRMjp4PLGykUXfY=;
        b=YpQBNPWw5m7gy39WRDx0qYLunHQIcmHP2i0fguEJTkYULUYNbKv4mEQLvwEdhEidvX
         ELDdTfDVhO8EiudxcIO0GvIU9wF2BQVDbaOv5I4jsSxcyREMEuMILIQO0ijqyMOJuFAa
         LeTPm6dZs/qar2waDy9bmTNydWnp6bfOxXH4a8Ryy7BwBLk7yZ+3TQwg/GP2dDQHlAQD
         QzOtzjbr1Y1ZT2vJWPmDZqJ9abV0gCcJeNIRkf/aT8HvWGb9Vk/Ir1aodRauPOFdVwPx
         66jJhTrL8g+zXwUKG869H+y9NFBR1VWWz8hG5jXBVxFmfXqLBShqa5xdz/Tz1r8RAz2R
         rOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076711; x=1787681511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DYD6EXdc3EA1wjI8XloWJSr9upDOkRMjp4PLGykUXfY=;
        b=mkqRMTuahscS3d7ilMvjTkn2fKH8lAtxkGQv7hQnDQlAKpbCpYgdeFfvHJJzhzKQ2L
         SekPzyzarxCqbkkC2e/3c6Bgo5xZ/yZt1MixS6KbEWP1ixuuIoffyITPwrPjidPQ3Ika
         A6PUYIZZPlgKXrgtGL+SEt7jDyNXVtW3sz+qdJFRlm4FhLi2FEwIX7mrTz+PJ1X6IloL
         QTZ+KR26bKRj+ZUcWkSvqI/j7FTvcAzFKczu8gTRsucczMGC9bG8ezt6mXlMyW96dD9o
         qH6+8fJ5/91bDLpDBFv+JbCo11edQvGGQlNYp3CH2qigM3MLxNpbzpaHvg0iTnfutBve
         o5Tw==
X-Forwarded-Encrypted: i=1; AHgh+RqPVbuNQUbJ6WGFYwJp7xfJOJsMcMW5HGPlmyR0fXCcybT3Ter9tQv+9E62TdF9ZH7HolcOCmRTxhOq@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRStJ/p4BX9Ya/75hSs3gBXVRRoUcc0LKUDfbBIdF0AeaZYBc
	R1QSatIMAF7JbGzTznFwDtwvH0JngI0Fb4o7Pkm8zH5YMJLLf5xLb/9rZP3w5xpJyyk=
X-Gm-Gg: AR+sD12KTelLfTttJs7SDv9gHNKCJDDk0Ae86rDaySJ2mTGQemfS1tuLqqrcN04ywyN
	XyegZRq5wNtRrxsvQjrJHEyoWqRAcJCRWNU7PhFg9Te0JuhYZbrjG1NH9mcjlTjVHDprcdZUEjf
	HeurVoX6w3METXLnG3/Z2LAXsybVpxJi/vcdO1fkDlUlVHslgVa31iHAjm3J0Yt1ZPI/iOrjfRz
	Pzv9B0oO0AssARTLen6KFTSg9D8yAZ1YI3JSNR3FcraaKk1cbackreNqAcGfSOjwWpDlPCdq37d
	1sR6y/Uwlq4vMusA9YDjZ07K2zUfm5eHDZkc1GrW0CTOI3CVa6NHnK8/OmVLFYL417yVxC48dUH
	/LdIuROD134bPE8x11LduM28tGzTdufHMiVTisEw8aoQlWQhWX37KXJrTsB2qiPdU56t9vk75qx
	5YlNdD223JFH+VM09gqLoU6J+swOxO7HQG9iO1sYMa3RAtxKIa2xJNauEa+eiR9usGSYPxdOuRz
	cXfQsfp7n65WKB/9NJO8hUWilZlJU3R2iqkLA3mGE60FMl4+1A+hk3NCvlAW7nQ
X-Received: by 2002:a05:6000:430a:b0:474:530:9d with SMTP id ffacd0b85a97d-4816072d2d1mr56968780f8f.13.1787076711229;
        Tue, 18 Aug 2026 11:11:51 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a3b896sm14302641f8f.16.2026.08.18.11.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:11:50 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 04/12] fs/ceph/super.h: convert ceph_inode_xattr fields to `bool`
Date: Tue, 18 Aug 2026 20:11:36 +0200
Message-ID: <20260818181144.3541770-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260818181144.3541770-1-max.kellermann@ionos.com>
References: <20260818181144.3541770-1-max.kellermann@ionos.com>
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

