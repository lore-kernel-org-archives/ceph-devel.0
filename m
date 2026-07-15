Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E35431A59
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 18:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139385; cv=none; b=B9kVQrK3w8F8OUA++9mtN5nNsZpP/wF48uMAybeW09yOs8Z0cKNDNJAdE/+YIoVZ1VpxK8rcwbFXBZuFGAFEQ0Pn90gOoS3miCG36R4PRRG9fE+Kq/LdBhKteQOxTghOk5aOo/B/E9juAb3A9EhLYNqCK94W6GMTnYLD0O/ucaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139385; c=relaxed/simple;
	bh=GM6d34a9+B5GkIXCNxp1J5SFUKQw286MTpYkgcEq5es=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lGn3tSYHPficeE0f772dI0uxn9H62zmYpe0Px+hFD0wgmMl4kLeQ3jdnCfpVNvxgWr7u74klmZ+8dw+ye3stauYN8Ax5VfK+2p3bRjgF+V6XKOGRehhOQMFbhrBsEfZprYPbfGjJzeq6QfePfGqmVv39vZQzAUwL8hzgyXAeMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TqFMQxgq; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TqFMQxgq"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-381216921aaso5998991a91.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784139379; x=1784744179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jC8A4bQUBZATwC3H+9qGb3XrZulRHbJS/r2BT20lHtY=;
        b=TqFMQxgqLDOEYmAbKam8rrM4+Os9artIpE7RjlP1tAeWkFAVbU3f798uZlNIlc114n
         Aozd9KZd+Di2l+X3o9iVMGCOVfiUVXjGoZoMMs8kN9yEy9iXh/bNsKabMCe7+7gLqiA0
         VED3kdhVWjfGecOmj8dCFg5llSsOoVP0oJSzyzznyJUcUVBJUrxEjAtdBq+q+YpidONI
         SL1bkJvYXjMYgWOao6U9K5YE88z7Xx51QO52Bc4ZhOuVOxyVHE8J8hYuXILSv4t+VLIF
         BJvAn+P0Cb1RNBCiB/7bQRVfyG0nfYK0lGBGQCAHD3/vZw1zr2g+Gki1hIed2EkpHbPB
         gIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139379; x=1784744179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jC8A4bQUBZATwC3H+9qGb3XrZulRHbJS/r2BT20lHtY=;
        b=Ph4+S0XI530XhKfxb+KLncjVWKUBRqN9mDwmolVNpU3Cv1Gypws1V/5kmmWzVuRJt7
         vjPyc58yxueTlJ2/YJkFuZvW8aicEq5lC7j64vyS6JxU4EZqm6OiS44W3WLrzMK9QeDJ
         hL4XLWUJ+OwMp2BDmgmtX6RdX7Wd03R0wMCZv+m3wQ9r8Y5BU0IOtvkUhFy/RES9Bryn
         3f9uGGO0umEonvhWeRWyva7x/aNcw4qUm2uzpVnATMjfIhh9P7anTyDaVHh3D+qXxxKg
         aSNXBVrJBcLVQ1BXCHXupqM+jqu/jL8+sauNL/fPDtbchdhV8gNhGcEtmTgr3m8/LDGx
         qL6w==
X-Forwarded-Encrypted: i=1; AHgh+RpDVseF0mF95n7eFPcHnGP+aF7wrUUGT+Rty2BlRz9o1MWKdeV4ud81QVL9hkzaJkGmutjX4GatLLCG@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXNHMb5/ju3WSk6BQ1QrDExWkYvGfWyjJ1g97sTbb0nk5M3Nc
	dU+Gp9gmzWzo98CXC4gPp3cBHUzApHOrg2b0exi6jQExXR3FFVj+pDOu
X-Gm-Gg: AfdE7clG91k5b5Os7boSQ7kkPNS5XfEzWP5y7NBdf4PxTPmIRPPXrnsbPQKWlro6SxQ
	ROPoHOH0M13FRCk0Xl+8ygz4psfgD+I7e+xpdtVwZRDvxrihGlCmXnA0wAd0OyNifyf2/rae8XC
	uiT+Xs5xhiF7ZFQcm6XF94W0KYoMUGY0zuSqzqCwjPv+CB+FpJ/qmfo4FDkbd5mG7D0qw0nPFe8
	NlqhJggvNehaAQAgOZf0v6usK+LqsL3hp8tnb9V2LzbSCrxUbO7Ny+pRrcMzQgf0ZBJs9U0UZm7
	DtT8xlG6nuPvm/oicttitvC0giBHL5tgmzbD3/PgzIi8M24V9nBEMkur3guj9156YMhifLcvKQ2
	9nMgkZQEQweY7fImn8un8wuRNEWOvXCHEDBQgIrOqPj9AijX1Lq80CObWTucDKXGmtteFy7iIdU
	cYYcqu/jxF/vAK7lgUEzGh6C+LHmrwAHNWJAqWR0nwi6vMovpZ2XwlrzWDARwaVA==
X-Received: by 2002:a17:90b:5783:b0:38d:e12e:83d9 with SMTP id 98e67ed59e1d1-38e1b012d5emr7577927a91.40.1784139378919;
        Wed, 15 Jul 2026 11:16:18 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:90:2db1:3066:c473:74d2:497d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6e9cd8sm3245525eec.27.2026.07.15.11.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:16:18 -0700 (PDT)
Sender: Deepak Rao Gaikwad <deepaksraog@gmail.com>
From: deepakroag <gaikwad.dcg@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fix: release unused ceph cap reservation on readdir error
Date: Wed, 15 Jul 2026 23:46:11 +0530
Message-ID: <20260715181612.18192-1-gaikwad.dcg@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Return unused reserved caps to the MDS client pool when
ceph_readdir_prepopulate() exits with an error.

Corrected standalone submission: this patch was mistakenly
sent earlier as [PATCH 4/4] in an unrelated multi-subsystem
series.  It is ceph-only and resubmitted here as [PATCH 1/1].

Link: https://lore.kernel.org/ceph-devel/20260715143646.15828-4-gaikwad.dcg@gmail.com/

Signed-off-by: deepakroag <gaikwad.dcg@gmail.com>
---
 fs/ceph/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 61d7c0b81..2d6a80054 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2188,6 +2188,8 @@ int ceph_readdir_prepopulate(struct ceph_mds_request *req,
 		dput(dn);
 	}
 out:
+	if (err)
+		ceph_unreserve_caps(req->r_mdsc, &req->r_caps_reservation);
 	if (err == 0 && skipped == 0) {
 		set_bit(CEPH_MDS_R_DID_PREPOPULATE, &req->r_req_flags);
 		req->r_readdir_cache_idx = cache_ctl.index;
-- 
Deepak Rao Gaikwad

