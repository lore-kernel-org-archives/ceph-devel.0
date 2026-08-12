Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42E399375
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 20:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566605; cv=none; b=ohONaaKfRN50y0pSWZKFz9Dv79XZrUr3DRBrJpl3sCjNFeG3tKL221jdTHzSXT6YuLTQmblCzcTAL+y7yT2UsdQ4TpLNKHCSXIbuChYbN+bb4TiRKYmuExoWnTc+EZQEyQDR3Altk3F53YB5y0+tW4Gqd1izP5jLk9FHTYzA8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566605; c=relaxed/simple;
	bh=rECAuaCU+sisvFAxlz4wBECy3Fjxf/Y512+AyaTPnw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dElQuTR6A0arCDgIqyowdtlVggNxbllb4z7apvlR8oBr5PQ2wc1NaaHfeCA0snG3rYr8B10yO88CReUdPZg0jnftS7fd0zggIjLqViNEL9soCrVbeZ0j9h13kw+2srqwEtBNZgVqzGbKVf2/9B5q7oVpgF2jVoxuc6Ib2Cj3C0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gYj2qtJ/; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gYj2qtJ/"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4813ea321cdso159648f8f.1
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1786566596; x=1787171396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sXE4QLrQi2i/4sxK4k31CjHlNpeUbWys3Ip47/zk/0g=;
        b=gYj2qtJ/tSAxXCuhI+gY/mpcN92pFGrcfQBNC3UgBpEuvuH2MUf1QqWG7JMXIDDi53
         Ice41kea+BI2l17coyKcBx+5eCgoH58zsdbRU6nGPK6tCTRXAYo7YRpnPv8EbndG82tQ
         q7SYqo4vuS7XwkigyAuKhdHTEHzo/PBJSZlpRFgeiMzMUv0fVaEpCCdY4Kg9Ep8yQoT1
         YioI1n1p8257FP9EuRA3ftgCpCEDtxLpBnWbCPHlnJSPjflSAg/d3hJCBO8oPOdTL4XJ
         7wvLF+eii7LzLcyDXAs1TU7D1qIhoyFQfL8rKLMNqJFJ4oCTacDKJR8qUE61UZ8g/pGA
         Yh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566596; x=1787171396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sXE4QLrQi2i/4sxK4k31CjHlNpeUbWys3Ip47/zk/0g=;
        b=YrxqOPWhVp9qJGSVswHhxFxtCEM+cfA/m68Uy8497NHmLdyVQs3q8aOZoN04iTEfPL
         xR1RsNihuKoKmFUArYEO57iWypQfasfRDM6z6FRx+TjIfJB5RSJzvRUc23CCqJSSjaze
         5QcWyzAFqbZMk/seDF2q30yvnU5kbzgmUj08FW9cBYcRDHD2yZ79xh/cvsOnbPXznXOA
         eL3jOONyXaKqr4/UZ6vDqXEVhNlKni5yqRf9hbT62VI4EzIykHgBZmUK1D+lUywwWjUv
         rOreZrMkKWDMSEw+v/j+MRke5rKaZJ+QcT2yAP3pEo/8WgKRvt+v4cGmgC5S00WleNZ4
         JFfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqn0SKQ9Q0qYjqbI9qBOFyjugund9+l5e5uiBBo32y2liRSSawVDcFmVoo1kZvnEf24CaLVyowJZbN/@vger.kernel.org
X-Gm-Message-State: AOJu0YwTbSYVuAinJOQqMCHVsfsBLFec8d2C5HMHNGTDEEABjGcifoTQ
	ol3m8iRRQqL97xBP6zBPOlA8Ygvs3yQNxwXXhI/z2CSrTU2djdRokA42Kh4gH8c7y3g=
X-Gm-Gg: AR+sD12iZ+kWJwGHBxjm/6iLtv053lFA0SwuuN8bDZst3G9nACrF+Uj0YbD3ryzwSx/
	DsFWC6NLD/bU/eGS2WSUGcUgoTBMMujxanGYWCf36gNNcm7hwstmbu7w+EWOw3SZQ4/m0Ag4Q/A
	8IqNvyMaN4SPPEvH9bUJSXbpp9wRchxZ/K7EBNJS3mB8yOvLgBaT/xHcLLGhJtEqX3U0et+FFat
	CqcIuvYldiThHDJ8W4FqA4CoKN7Tpa1pdyjg3E+jcqrtXNeMxExC2CGx0LudfQRxPTKKeWGOXxT
	Wt9lCXWqMRIEHjtkFcXp6csOxMd2UybT1KvJrsA7TaNtAJavZspf6OSWeN7WuvTzB9Njf9GGzlV
	qIGXTNR6MnUSmkEsbz1B/h8N2RapBN1XoXpDi57lOFz6K/3qu1qMlOIHIL4Ko+d07Ia5S4jOu18
	aGtyiN1hOgMAUFtkrz8KzX/CD5ElRymA9E6QBiWtKfHmSlqQ6x6wPqznDIQYxFZdOy4brkRxNvt
	NQrZQEczRKJwNlfTQpsn+x1jUx4e0enumOZNXafaO44I8fUHfaBQR8+SczZj/iZ
X-Received: by 2002:a05:6000:41ea:b0:481:2fff:2a09 with SMTP id ffacd0b85a97d-4815a540db2mr425678f8f.14.1786566596589;
        Wed, 12 Aug 2026 13:29:56 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f02b200023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f02:b200:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a569ab3sm328979f8f.11.2026.08.12.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 13:29:56 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3 01/12] fs/ceph/super: remove unused field `i_cap_migration_resv`
Date: Wed, 12 Aug 2026 22:29:38 +0200
Message-ID: <20260812202950.1800340-2-max.kellermann@ionos.com>
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

