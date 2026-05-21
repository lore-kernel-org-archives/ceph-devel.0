Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E51EB9F2
	for <ceph-devel@vger.kernel.org>; Thu, 21 May 2026 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382970; cv=none; b=iSGVgy01ZWbCkfa2iyiXC0qKkdyz1o6+Tt/xyEJHxpr8Q1EQ6hi7rLwRmlTb8tf7ETyHLpysvOP8rho72p5DRSsVfjoSacdcUpWkLrx4wIab0g8kOGdAcvU9r73ko8UIlFNZZHb4qAuLa2n3T955MmvUkl1GjivZAtkT6asFenI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382970; c=relaxed/simple;
	bh=o2rwJH3rg4n0IyTgb3wBFbXuLrWfUcMx3QDfps5r9Vs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kn4BUyDURPiKvu7zMbZrF0tKmiU+b9lKVTVLUGeDZWfiPtW/U/rr0x2D9bZ0VRDVmEdEi+eTUUoq0TZHJivibVje2/xziSOdiDFoZyEq7yv0ZzaX0VdSnWLMIC/8V3xjtgI3RZEyYQPEae0JT2e1kmBv3FdrF0ltemw8J9RU9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNGUcOo5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNGUcOo5"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c801b30188dso3015610a12.3
        for <ceph-devel@vger.kernel.org>; Thu, 21 May 2026 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779382968; x=1779987768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+D7s1JXk1C2HHkvryXwPr7t7F+VrBvyKHcCcWWt8whs=;
        b=VNGUcOo5pPBm10H/lCoQAzWNpQ75jlbKyR1EVVBFZ7VN2cvQF2M7nIbUiyS9c2gaA2
         dPOTWKsr0vbFPQGedriIQVmeMd08OGdoEdZYmNv0YiEWvauznjvmSFiW34DNx1WvHszq
         k+d8Y8jHiVHkg9gLOpctllaI7pB7wAk8/p2sNzggsmQ50k+tDR5lAXEqxnZEHMVbkAeZ
         Yv+jUpiF3/ThzB7Uc+/Ly/YqHaOP/8dv8s+ZUVuCVS/T1nukLEf1saEW3KF6vwSQF+Ht
         YP60UUo0dAkXbyx4q4FKlk2N8NYdXsx/viLDeUdWDKzEoxV67xDCaD4JyLBfHWmthevL
         PPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779382968; x=1779987768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D7s1JXk1C2HHkvryXwPr7t7F+VrBvyKHcCcWWt8whs=;
        b=XYnvF50MMOvhng0oWFVSozkYSAvjqM5B+Qtl0KSDTWp6rXG7AQ/+v7jh+Ik83ztESw
         bwUcNKARj3llgXiSwRziBmmr/7U0eVx9LQSJwGhdu8Q2tH3yzzVZRDI6Aib82DNScEju
         NfuAqgt3o6oEaIQx3k8r7gsLXeuPJRkRTwiH/RPTx9D55WSGRtN49Upv/WmSdht2ticA
         sTjB0NbjQXXJAjgDe5fakTePVPGskVDomFu/Y/7tV/hFGpaUePGchVbe3KI2FT3gybtH
         u4FcBRISwfR9cmIAru4h68g8j40g6DQiHVtrWzwY55hVCl5+/ffMOp70w6+sEYU2U+XU
         8zYQ==
X-Gm-Message-State: AOJu0Yz6fs45rRKBrv3a4NtAzfMTIkKTGWMcBprDW/5sxczQYea1wxmf
	tznn2H7bBUnjAmriiC97Qlg58dDxGFWziA/Z3WWASAy1OaghgjY0NK6O
X-Gm-Gg: Acq92OEUemF92HvqoK2u0HuCCW2hKLPThRGCF4ObHNSFD7mqtWkxAuEdWLNSoDtwbRc
	zEscuhpXknQzvrGHRXieBSaJBHPcVz+jpYqgcMWixrX342mqOfCGPjhLw6hiuHaBJKyFJdSdEND
	FYimnllMZKJkOjolP9E3jHPGPHdhkM8u3jFiKdKjMNlRO+ORmBnViBX/CLr2tOsdaPMmfeUFjg2
	Fi0VaoH50DNu/8zIrq8CvGwCCN24gNpKzqbqWHuh6LOa8gjwFX4yv9uSi3qgDYFXGNC/40sH7Rk
	qx7o/c5CdCyF6cFVcR/ae5hZL+lbkJb4AVkPtSPO9hV8AMjPQ7namoLK+M43fl361/H/TAkbBkZ
	PoehwrAHoFdaeTzmMhxMXTJOnz+zmmwhq9gGLDKZzay0F28EVrrWeLnvq8Wk0YxrrEQm1H5zgt7
	0a6LJuf6yn7FLjsPc9+wKUv8CJDkz6igIzv6WrgGD0KGTsgh+V
X-Received: by 2002:a05:6a20:a122:b0:3a2:d976:2210 with SMTP id adf61e73a8af0-3b308540f7cmr4393640637.8.1779382968042;
        Thu, 21 May 2026 10:02:48 -0700 (PDT)
Received: from zambezi (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc781fc883sm10968446d6.46.2026.05.21.10.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:02:44 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fix for 7.1-rc5
Date: Thu, 21 May 2026 19:02:34 +0200
Message-ID: <20260521170235.1584548-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-7.1-rc5

for you to fetch changes up to 9fc75b71fdd38465c76c6f6a884cdd4ae3c72d90:

  rbd: eliminate a race in lock_dwork draining on unmap (2026-05-20 22:09:08 +0200)

----------------------------------------------------------------
A fix for an "rbd unmap" race condition which popped up on a production
setup where many RBD devices are frequently mapped and unmapped, marked
for stable.

----------------------------------------------------------------
Ilya Dryomov (1):
      rbd: eliminate a race in lock_dwork draining on unmap

 drivers/block/rbd.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)
