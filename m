Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD6280A56
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 02:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779850761; cv=none; b=dLGEYEAmK4n55EdNyrO5aqh/zg4KrjlFa3h2haXkxT6DEBl2/FwewN6ZefGzF9p30XoJxf1gA6SKezXlnE6rhCwGH+VHTMxhFcpCcO5WPIxP9GQ2ek41VZvUzZrF2PnGGxepwO7D0bkJNvc1V/bmJqwHrKFr0gy2dyq8Crcv3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779850761; c=relaxed/simple;
	bh=YK969zcmEITdi2ESwgUBknPGuyQjoRuk0+gFO2c30mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A5nfeX/m84ja/Q5U4H0130OgI5VVDMy0a5XE/b46NM9HspaRyVpuPWbv2qBxiZN9ReNjTVq9zpkhj+9JXs7hYAtPjGggwwKe+/hI7r6Yf62p5e8CcgOgE69Dw+Pc6RwxzatpvlEzQFMrNSDgG5A4NQC+RwRQJgp1hW3AYcSOwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5H1cIlF; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5H1cIlF"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43a833aeda0so7852886fac.2
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 19:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779850758; x=1780455558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mj9MCtIAD7d1JSfCaa/HTdSWgA5gV5kV6QttYxTWGWY=;
        b=Y5H1cIlFiUI0fzaw6Kp/bQxzyQYicoM4xjPucITU5kqTsUZY4Kbu6e9gQgPBnbzjc6
         OsXe+cc4KSF4R6ZWX2x8fHNpQofNWKM4hAXBYa7mKDcbPvG8dHe2TYdQJvrZJPwMXSAW
         NjzUt/gc9FtBmN9/GBJjH5dY8aEXKMIGpDuFG7hqBT+4nrun4JFMwC8D0/lX7YpnX15F
         5XT/5leXE2bhlRgfpRLoL8/lCWlboe1Y0vx00D2yjJcD6Edz8JiG/Z3PAJlfEjcN6Vmq
         JXPq1zPnezZoYSKFjkSBP+hofDKNeynISnZiqN6bEt3VxhlXW/rb0Bg6GeLSx5FnUOEP
         YZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779850758; x=1780455558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mj9MCtIAD7d1JSfCaa/HTdSWgA5gV5kV6QttYxTWGWY=;
        b=kDgQd75e1M97POWuP2IAUn7+rkOWWYQDJZt8H3mr25B2B21xo8Xnmk3g6Xepblf5u2
         tH+BnhG1T1xenJGx2sEfnKzWcZnOuKHSvxNrRd2ghQCZB3Jniane0D/kSZtBipBKLARL
         yp1+HVJLG63LSFOmTCE8+Gdan/vrPXoYAhk9qgQgspN1Y2DaN16kMX6k9f77OpvkxVvn
         pVbjYlwO87FVPmryiYAG62ckSjJkFCRegTMvU+8k5uqSovIp1NuGAZsqaEIuUJqMwayA
         Kndyizz3RLtkK9ovGWzs780egPP9YktsPrGVXCUfmff1KRfme7+KhIwe3EuhKIAtbzSL
         q+lg==
X-Forwarded-Encrypted: i=1; AFNElJ/zJ7p5QTWo0uLlAlOn4EdBTGfpY5qxgZSUgIg20u5ArKpTVyMk3/kVaHoKjad+JPEBEPou8TBj9D45@vger.kernel.org
X-Gm-Message-State: AOJu0YwwpW8qjpYz/LEAu526RP3RC/b7H4DaPLcabconmpi89JXUMGvx
	qn0VFZcEiibS03Bc5ZGbBuhtVv4YdIcpg1FTBlvLsQGNNQ9bSetOYrHg
X-Gm-Gg: Acq92OEkd8BGGpnwGAJWNNEi2hIr4oLM6mJcU/jNX2Arxlp5WEBQrcxre0lFb/8XTC1
	wWxX7d9BFg1WnuNqnxQ9/L4TPEyMzC1GlSypODqRz5zAuMwiuKoQVsf4DcOTem9qeIfR1HTu16v
	vYlwaZ1FrmPOEtqehzaUZW0rBQAck5YW9K9mzwKipehalufu+ArS14pZrJdcaBvUHS98Hw1YHqZ
	l6M7eJCYeRDdWGAWsyeJHKP+n9Dl06fBFMNueF3eLBAljei4Rm+GTHhSOSigBD79xU76JAHCssj
	ipBhNGMe34hA1GcT8LCU6rj5vkXC6wcOT0nw0xalp02Wp+nrqO0z8/U+i2959y8Vn8JtCaQ+oSx
	S9cLxIWHBFKbp3B7dossucKwvbYZyowwe5U9QttMkI17ubBny0FekA8N713L6IqGS0SL+xUZiDW
	uLkN977IAPLDb/JTcYmLUC3WOfgAu7i3cU8dz/pDEhXJazV0FP/HoiLkGNGyFgG+Bf77sOrA==
X-Received: by 2002:a05:6808:1644:b0:484:e5e2:6b8c with SMTP id 5614622812f47-4854a243fd2mr12915019b6e.23.1779850757874;
        Tue, 26 May 2026 19:59:17 -0700 (PDT)
Received: from localhost (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-48570e55783sm5659554b6e.2.2026.05.26.19.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2026 19:59:17 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Xiubo Li <xiubli@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>
Subject: [PATCH 0/2] Bounce buffer for mds client decryption when vmalloc()
Date: Tue, 26 May 2026 19:58:26 -0700
Message-ID: <20260527025828.5966-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ceph maintainers,

This is my proposed patchset after my previous RFC [1]. Apologies for the long
delay, life gets busy (and my Linux hacking time was eaten by trying to stay
patched in the face of the recent flood of LPE vulns), so it took me longer
than usual to get patches written, tested, and cleaned up. Glad to be back! :)

Since Alex pointed out last time that parse_reply_info_trace() has the same
latent bug, and Slava disliked the already-high complexity of
parse_reply_info_readdir(), I opted to resolve the issue in ceph_fname_to_usr()
instead. The purpose of patch #2 is to make ceph_fname_to_usr() explicitly
responsible for handling vmalloc()-backed filename buffers (for base64,
ciphertext, and plaintext), using the `tname` parameter as a bounce buffer
where appropriate (and preserving the allocate-when-needed behavior).

Patch #1 simplifies `struct fscrypt_str *tname` to `unsigned char *tname`, both
in recognition of `tname->len` being unused/unnecessary, and to eliminate the
`tname == NULL` / `tname->name == NULL` confusion.

Cheers,
Sam

[1] https://lore.kernel.org/ceph-devel/CAH5Ym4ga7miUQE0K-cJA93Ya7w62P69MAN27R5cBiYnudoOHdA@mail.gmail.com/T/

Sam Edwards (2):
  ceph: pass fscrypt `tname` buffers directly
  ceph: properly decrypt filenames in vmalloc() buffers

 fs/ceph/crypto.c     | 45 ++++++++++++++++++++++++++++++++------------
 fs/ceph/crypto.h     |  4 ++--
 fs/ceph/mds_client.c | 12 ++++++++----
 3 files changed, 43 insertions(+), 18 deletions(-)

-- 
2.53.0

