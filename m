Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0093436F429
	for <ceph-devel@vger.kernel.org>; Tue, 17 Feb 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349875; cv=none; b=DEUWGawbKw8ytMd5tqnWldz20LqGlD0GeU2kEM2P55xIgMglzRFExIEs5B+PWvbgpBLRviw6VPeJMtyr7BpdpSVT1QOP6f5WM6HoG+JgZUt8d0VMYgOQh7suP8r+nvQpDBByHv6+xTyZzPxKtcPUFeE6Zm4jOS4RvuAUVEQwSM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349875; c=relaxed/simple;
	bh=/O8mZf8sOCE+xpC/pVrk+nJB6wwX6emX8N7JWXT0RaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4xVLqgWwD1khO5XRySj76FVSNfxdqSGMY1m28X/G6e+9q/bep+AnpehbdI2PZzR5tYSMJPdGzlQySu4ns80Sl/qVOEZ3eBS+NEWLcPqKqBFO0k6m2pHmuQlTZEnhNEU+hkUdC0EZewTBn28EcfZpPQC7sMSF8DBE7mn27/L2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5UZwbfn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5UZwbfn"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4359108fd24so3136507f8f.2
        for <ceph-devel@vger.kernel.org>; Tue, 17 Feb 2026 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771349872; x=1771954672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTh7PIg6jJ+L6rGerLpDgxos/TEVMQWeVph47ACMoog=;
        b=V5UZwbfn7VwEzjZf7qVtrANQwV1XIweVLNw193FzR3EzsOoOKfY41VgQ8NFU7PIFem
         tVTF47u8XJcTfENtJlwLTMWHkQGmKS8993MBIYTItC7iXu8m4KosF1dXqQSb8uSS5NjS
         cDqyxNrGjOxMaPBFq6nTRQDZFU8ubagcKxUae1qlq47/vaXO/Si+vhQudqVa8UlmUqSd
         VmIhttPSGx7f6g96pJ0nJT1RfG2UVa+Ya8blR9kwznlHn2SryhIw3DAcfg6dfDrqXBL5
         5qoH7W084BTlls+uGAyLrl+M7RyRAS4Mzz0Svx0XBSEZozPf/7BmfMLq65BZAyilXevf
         POpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771349872; x=1771954672;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTh7PIg6jJ+L6rGerLpDgxos/TEVMQWeVph47ACMoog=;
        b=mLDdjJVgkSffmAC9fgT1SS7CrEGeQIn93zLriAcRsecErNtycj5NrR2uqXTFIXLBfm
         s30+p9zI2xuFbM9C76WzjOgYWvvLhsCZBHQjd+hBczsPzGOXOdgDO5jT0sGtR6Hjejm8
         m4v9KSsBYFOtulguCGai+8EkeDPsTxT+XcrRFyd7sHUUOZPfWvtW+k1hwPPpU+IqMnKM
         FWURO383Oeh3kwanxAAwVckSJaX2CxWimOOBMKbIANJdkKrEEmXSCo0avLkN4YoNaTBJ
         NN+TTEw2210aV/Cs0PJ0Y700xIhzDAq89TzNxP/PtI54WlxANr42axpoSyUMVnP4VVXD
         ztHg==
X-Gm-Message-State: AOJu0YxUeUAwW85VPA7SKYgj2HEVJxMCw3KLUMBrp3HD0XNXND5KFH8D
	uFMChnAskYMKe5TXbsRFuCo9Na11hJd3ma91ML3wmeMbX6NZ/gzs7lV6e7e9/A==
X-Gm-Gg: AZuq6aJX4WqFVvi5yLCSo2IAThJ+1b2nMSz/hTs8A9+UxlHLP8BKiK/gOKoiKVZvohU
	eu4k2tw15IG1nT1Wdc8AEYqlCvTS/ub5zw9dLEFid9DlfJ0WIZ8DCjSq3+XlEjmywXQXmYPOrzx
	p87nWCBrYUcI0Jq4yh1TROyxoqiNf+MuHLl5l98tfO5VJY2hLTVPC5nRIkDbh6gdSHHp4J7Z+l7
	d6Z+dptoSyoYb30nR4tmydtHHnTDDOkr00LLxPgTxEKru2HR3M0MD+R6LiKLK1IZLX5euTrvlzt
	cIVYoEoLXIPOXxwR8VIhzDKHIoQWTD094oBqX7/w3fY0538t4aynHlKAQ9/J/8qkj4J8iZOQPQM
	duaoQQqugBZ893e7ACRs0HokNYItFRfMtHZC/G1xdByGxQ4CpgkHhdKEOkbxgTBt9YxT8A5BydX
	Cg58JSE7DlWnLA1BgDTp7kMVTndW+LSm4r2gPSFkntssm6E2gmCf2rDYs8QYo2LesqN0QburFc8
	5s=
X-Received: by 2002:a5d:5d88:0:b0:435:a83e:88f with SMTP id ffacd0b85a97d-43797850f65mr22505615f8f.0.1771349872049;
        Tue, 17 Feb 2026 09:37:52 -0800 (PST)
Received: from zambezi.front.sepia.ceph.com (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a74918sm36156103f8f.17.2026.02.17.09.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 09:37:51 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 7.0-rc1
Date: Tue, 17 Feb 2026 18:37:40 +0100
Message-ID: <20260217173743.1840319-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b:

  Linux 6.19 (2026-02-08 13:03:27 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-7.0-rc1

for you to fetch changes up to cfdde144ae455b8612a756fe7419d57c9b7833c1:

  ceph: assert loop invariants in ceph_writepages_start() (2026-02-11 19:14:32 +0100)

----------------------------------------------------------------
This adds support for the upcoming aes256k key type in CephX that is
based on Kerberos 5 and brings a bunch of assorted CephFS fixes from
Ethan and Sam.  One of Sam's patches in particular undoes a change in
the fscrypt area that had an inadvertent side effect of making CephFS
behave as if mounted with wsize=4096 and leading to the corresponding
degradation in performance, especially for sequential writes.

----------------------------------------------------------------
Ilya Dryomov (5):
      libceph: define and enforce CEPH_MAX_KEY_LEN
      libceph: generalize ceph_x_encrypt_offset() and ceph_x_encrypt_buflen()
      libceph: introduce ceph_crypto_key_prepare()
      libceph: add support for CEPH_CRYPTO_AES256KRB5
      libceph: adapt ceph_x_challenge_blob hashing and msgr1 message signing

Sam Edwards (4):
      ceph: do not propagate page array emplacement errors as batch errors
      ceph: fix write storm on fscrypted files
      ceph: remove error return from ceph_process_folio_batch()
      ceph: assert loop invariants in ceph_writepages_start()

ethanwu (2):
      ceph: supply snapshot context in ceph_zero_partial_object()
      ceph: supply snapshot context in ceph_uninline_data()

 fs/ceph/addr.c               |  47 +++++---
 fs/ceph/file.c               |  17 ++-
 include/linux/ceph/ceph_fs.h |   5 +-
 net/ceph/Kconfig             |   1 +
 net/ceph/auth_x.c            | 195 +++++++++++++++++++++---------
 net/ceph/auth_x_protocol.h   |  38 ++++++
 net/ceph/crypto.c            | 275 +++++++++++++++++++++++++++++++++++--------
 net/ceph/crypto.h            |  21 +++-
 net/ceph/messenger_v2.c      |  16 +--
 9 files changed, 481 insertions(+), 134 deletions(-)
