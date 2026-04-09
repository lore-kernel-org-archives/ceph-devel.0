Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17683242D84
	for <ceph-devel@vger.kernel.org>; Thu,  9 Apr 2026 19:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762135; cv=none; b=Wh1AM0ROs7mEjModV4g8exhXvEYURgavUn5q9CngfkMtIreX2Cr6FmqnZoMENnpSohl30aMsMXJCRAujy3Q11pHpx6m5d9JC4hQAV5J0MS2NVFhzy3EvI/jXXut/x0VGdjTxLxV0dI4IOiQ6oleWE9iw/0wFt8Sk61dj0AAVGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762135; c=relaxed/simple;
	bh=mLxbGdF+LocgfZ13nZ2Tg+a474WR2+r7/8rr6DVILOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mYEpHXECAO2HVPK1kr6cPMqMpHIqkJ3bSN+HZQaudr0JoMh16utb0kz5WqbbhWsxHvewNszsQEbo1F6nGanzDB8IY+i699HE9cpwxyZSr7WnRFi4YzhUM88VdTUUqx1yvFR/AbAkIyJe8774XQqbW0gwiXDveb2Yv3mF7HHHF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=qvMeisT6; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="qvMeisT6"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-797ab169454so16278737b3.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Apr 2026 12:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775762133; x=1776366933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h5Ot6MQCY3SHVCp2P/Z1z8XnvK7coQdd/EmtdJmQhrs=;
        b=qvMeisT6z5CprDyM/kuJh5ETD7RZ+BZTFh2/GUUatfZdfRV3l6PchA1fzG2e8Zvu4h
         pLk4+Btk5mlRcQl7WPCiNUDEPBdGKKFi88s3DMYGbXkgRDWRaXGcgVz8U1q5rwY+ZXnu
         GcKmpu2wk4ObNcUVMLMLsnGhcdqLLC5xfqgqK6hadu7d/9LOyIQem6JVINRJhpVEuOX2
         9FHd5DXWoTVWP6Y+IYQ0eI5MI4KOsEUh9Iw5KFz9Fs+4qU47e3Hlx2zQ4eZovm6jkrqK
         g5fd0RI5xXWT6qKXqC7i4Wqds55P1lsqyUOxgknkMpLomgBCYWIAWetwYZFM6h4u6/Py
         nriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762133; x=1776366933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5Ot6MQCY3SHVCp2P/Z1z8XnvK7coQdd/EmtdJmQhrs=;
        b=qqbFmY8Dj+bhv/ikOmge1z/aqNESkDqiEPPBcMeD5jHVseEWv05nElE8Mce4xu9ZtT
         qkuVzZvjvm5T/EMCUdjhzhzPa2Ly2K0w8WXQtPAqMjvmXTc/H/nTONtyZPAgXW+lw0if
         Q1W8Cl8AE+1KqWe4Dhlm1UxHvA4XTqalB9ACVoeuAQbCITX5Bu849aLy7PlTo7n4m83/
         hDjxPOWsRLz4fl3YubOXHS4x+ejeAShl0iuUPW8yHtVWZ0c43LrsTsNICySZvqequtsJ
         +5+JBaC3pdUf6NqR5fzGBNJ3B0mWNtiS+7ISG+qy8TejCSWIiJHVkB6Y9nkIYeFA+dM2
         F4xA==
X-Gm-Message-State: AOJu0YyDoStnozHLuYsyCjVEQs0KhuORgDJBnL7KGweU9SMRzgLGgTMD
	cEZw/inJKciwIqoQhS7AeVI0HUfy66PthaKm212RbAncVkG6aEtUkSQNr6TGgTYnAp5yXVggOi6
	jV9nRS64=
X-Gm-Gg: AeBDievLOho4UrrXgVpnXvyDZ8xcTquxOR9aNIy7RArq7xl4wa6giRnwspohV2MZQKO
	1IEHOIpgnP81WiHgjtnwaIAx6AMazsLn8oo/r02xLJvQFlMUKk52kdCJ61V7SwTHceJ8L0OjNd5
	1IsQBc1g55CywcvB3j5JMZlLKmc+pxGVmRifW3EcJF7xQvjm7HqhxHbyUd8w21f3qAm8zwfez71
	NhM8JVqbKdOeKLGBR0o9xgrGhATFe2RtyQfyBurm7E3OH4lsA4pjifaT3Xa+y3ZTwMqDAleKrud
	8mMYv3L1MATfvweR4nUafCNobE/VQuYm8quOnnpskwtpbE9U+6xQ+DPJUIE6kRxo/ZC2Hdfqupb
	Pxy54QU55qvRyvzQEKr1eyokGae74p2vK90OSOTjUiBPp1dFX0mlWZdWuyIw4SYOiykR/15G1Yp
	NbrICPVTQh4j0YwkgLdau1K7B7/A6ye9ET8VBo/aiL5VI7zecgKeQfERoNzHzyZmr4KhAMuRbgB
	e+iRKabFY7/qZBnKpE3TIKzVGbx1pU=
X-Received: by 2002:a53:b1d0:0:b0:64f:fc0d:6240 with SMTP id 956f58d0204a3-65198bda2bemr163013d50.62.1775762132712;
        Thu, 09 Apr 2026 12:15:32 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:594a:e569:c7df:c654])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65197a82effsm198983d50.7.2026.04.09.12.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:15:32 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] libceph: switch ceph-msgr workqueue from WQ_PERCPU to WQ_UNBOUND
Date: Thu,  9 Apr 2026 12:15:18 -0700
Message-ID: <20260409191517.318015-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The ceph-msgr workqueue was changed to use WQ_PERCPU in commit
27ce71e1ce81 ("net: WQ_PERCPU added to alloc_workqueue users") as part
of a tree-wide transition to make per-CPU workqueue binding explicit.

However, ceph_con_workfn contains a while(true) loop that retries on
-EAGAIN from socket reads and writes, making it capable of hogging a
bound CPU for extended periods. This manifests at runtime as:

  workqueue: ceph_con_workfn hogged CPU for >10000us N times,
  consider switching to WQ_UNBOUND

Switch the workqueue to WQ_UNBOUND so the scheduler can freely place
workers across CPUs, preventing starvation of other work items on the
bound CPU. The loss of cache locality is acceptable for network I/O
work.

Fixes: 27ce71e1ce81 ("net: WQ_PERCPU added to alloc_workqueue users")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 net/ceph/messenger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 108adb583744..dbca8bfaf5fc 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -253,7 +253,7 @@ int __init ceph_msgr_init(void)
 	 * connections, so leave @max_active at default.
 	 */
 	ceph_msgr_wq = alloc_workqueue("ceph-msgr",
-				       WQ_MEM_RECLAIM | WQ_PERCPU, 0);
+				       WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (ceph_msgr_wq)
 		return 0;
 
-- 
2.53.0

