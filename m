Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C35190462
	for <ceph-devel@vger.kernel.org>; Sat, 30 May 2026 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780110424; cv=none; b=VUItNo3B/30z42Rzkmzr3IxgZVRsPqCYeWcTLjEe1aaYLW2nvwGgwLEmjOPCkl0O36xbGJTPs6yR5fsi8Bg1erGzGBsLSnJTiWFKHw2pPemgeXCT6EMct/kmZrC3Z4gc+MZm2+U0um6+OGjDVCaVQSPZpcX6sRwsgY/Zcn6ief0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780110424; c=relaxed/simple;
	bh=Jo8C9fYgR8M+9qmgQGvTGQh0xayfuj60QKKA2cUXXLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N21Ud81nssRnFtUVq5egx52GwbVsc8azB+kV76e1jXhWn88dmpa2eFXHWuEEOpCmTdgePZdFPxToTgCY1dASOXDMh+jVMhFkGuM4KVitGmOnk3WN8FXWnnC0GVJq+xGgompUYlptdLmoqHSZYoYKV2zz9Rd7T56weKKbKZ10OSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYNE2AnN; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYNE2AnN"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-47c7b282e21so5722421b6e.1
        for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 20:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780110421; x=1780715221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pL8uMvAYVmFHlT5lD+kMaVasC/p+a5VnYewFeWxq91c=;
        b=WYNE2AnNvM7/aaU05XKNzaOW02CQRIuP93mu4Y/4Y06DGSDHwe2IHsFZouST2E8cDT
         14qGzgqUYhhYm3N9+9gCaqcm8Ug/sCkSJnLpQ+UYmq40aGyRzEJ0LpsuIoskUYaiz6Gw
         Mj9X6RJlCqQ0qGHVsN1Gi9m/G2+zjTzTScAFZkz/O9b4tRI+w6bJd4mcnYIhZhK5P6S/
         EItcsPExpFQZPTT8JLJFY4ZOXxHPJsCnBEKQTUUCfLFu+VY3g/gCsKemVALM7nOWWNDn
         vHwHDYEWPiSsPjvDSseJ+KIfG1QBv55NGFIHMrmnZ8RKVTw8EmN+B5wy7GWSNF0w5iBo
         jCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780110421; x=1780715221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL8uMvAYVmFHlT5lD+kMaVasC/p+a5VnYewFeWxq91c=;
        b=ZRzsJ7EIn6knGx1859flU9of3QzMNybZk1CmAh5bxf7Nu7YHOFlVWUTjWiuX373AQ1
         4w+5e9d1lfFbpp9I4HtKbD2HkTwoSnaAt5Xng56aVZfamLAcwNjm/W8h1fWxbpG7ASoO
         rn0XNHXQ6HB0O1wdHywjiqfZaZzmVWZhMjpkLRbLZ4jar9QMTutL3DYdUFgHrF1iN06C
         3meSoWfKxjcS9u+imCWAXYkaWZKiR7LbUzLSmNLLBYVQ27fpPt3KUlkfG8B9DOP0BIji
         Kxoz1bYYy+lQCHioC1cqbpqFN1CnCndFLxUcIXQI0y4+iJdcllbqlbKQIeafe0d8dmia
         g9yQ==
X-Forwarded-Encrypted: i=1; AFNElJ9EEx1DApr3WTW7+lJ5UH6sIDG1y1F8gEYLXBT5BQvW9jrSo6LIdtKiP0HZA6mjivR7wFrPVrNItr5N@vger.kernel.org
X-Gm-Message-State: AOJu0YyxG83NjE1btTlV9561Js4vl766eWsODQ8txbXNj+XKQeOc21cu
	qsNQsWJMc/4HHzbd/mtP+AqlUYuc9IS7kImm2E4SosTJii5cmWtfGAkA
X-Gm-Gg: Acq92OHSnCTIxmaUaL4vLcZ9R6rgp0iYWgKMsCxdTrn7a7NK3U+dITWIDoRdicRfzlY
	QxmGG98jsTx2sn+or3rJ/bpOmImFwWGM3w0V2ky80vvOfDA5B4aZPxZ/ulSfCWcaLqldtx+BlGE
	WV60OxGudP8VJ5MJSJzAUZd44XUnqTUCCCWCGUcrWd1AoXcGHSZKUnINPt4RFSMnSDQNsYMUOx9
	YDUeLDkGXbul2wKdMMD6V0rPfmGq1kFezH3ldzYAN3gphFIp7SxMmZGdvuR5ydpjnWzX+LwL8ym
	rveb2HYp7QrxcYNJbNckpKBIApC2f069rzFFG1drldCY6QwrcbrVxVeMNIgRNBjM4CzCUoWvzcv
	CyI3ckkZR4k/P2X6e60ieo3ki4G2dtNH1uRR4WQ2jtiDYD5y85wPAORYktZ2HW3fxZs6urgRk9l
	ETpfFly7QgPyh6whfaKgnGp8CXX4Eb4r0u/Buognun2iziThViDqegozRs871b1LgCAc/++Q==
X-Received: by 2002:a05:6808:f0d:b0:485:5f3f:bd1b with SMTP id 5614622812f47-485fb2fca4emr1192006b6e.3.1780110421613;
        Fri, 29 May 2026 20:07:01 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-48606211a99sm37325b6e.17.2026.05.29.20.06.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 20:07:00 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH v2 0/2] Bounce buffer for mds client decryption when vmalloc()
Date: Fri, 29 May 2026 20:06:44 -0700
Message-ID: <20260530030646.85589-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ceph maintainers,

This is version 2 of my previous patchset to resolve fscrypt oops/panic when
decrypting filenames from a MDS message that spilled into the vmalloc area. [1]

Cheers,
Sam

Changes v1->v2:
- As Slava pointed out, v1 was performing `snprintf(..., oname->name)` *before*
  the memcpy() that makes `oname->name` valid. He also raised a great point
  about the if/else-if block's complexity. This version simplifies the control
  flow structure.
- Reformat some whitespace and remove unnecessary linebreaks, going a little
  over the 80-column soft limit, but improving readability.

Feedback not addressed:
- David shared some discomfort about fscrypt_fname_alloc_buffer() sometimes
  changing the allocation length, but it only ever lengthens the allocation and
  is therefore always at least NAME_MAX.
- David also began some discussion around passing an explicit `tname` length;
  I'm still open to the idea, but would like to get a consensus around that
  first, because enforcing the buffer size will likely require changes to the
  base64_{de,en}code() function prototypes to accept buffer sizes.

[1] https://lore.kernel.org/ceph-devel/20260527025828.5966-1-CFSworks@gmail.com/

Sam Edwards (2):
  ceph: pass fscrypt `tname` buffers directly
  ceph: properly decrypt filenames in vmalloc() buffers

 fs/ceph/crypto.c     | 50 ++++++++++++++++++++++++++++++++------------
 fs/ceph/crypto.h     |  4 ++--
 fs/ceph/mds_client.c | 12 +++++++----
 3 files changed, 47 insertions(+), 19 deletions(-)

-- 
2.53.0

