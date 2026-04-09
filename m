Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77A306486
	for <ceph-devel@vger.kernel.org>; Thu,  9 Apr 2026 19:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775763524; cv=none; b=XQwqv40yCX3V3SZYd5xooQzAQDLLwkT3a67vHRT9vJBLWePKB1i2b2UPwr3pq8Sl1wrK0ULrLwPhduaYGYnA+ewvBDUf0GkVHZqBfaTb+opLOnKChlS14t9oyf1OdKaWfVqHkXd53/NcGhULYMUJPZ9XMPpArs0p2u5m84lptTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775763524; c=relaxed/simple;
	bh=M3keG6vQkBcVahfdNtoAk2Jdip7RTKHKrW1dvJ0kByQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dp7OMeTYg7e1FqR7jo8j2ftv8t7X02PnYsCcfsuNY63sWX2eVGzqDNJyINaDMkf+zrZpKGCT55X3hnFGobPyiw85TpfKpK2+bBmVIK1KHo/DU3EKOR+Z/Et/TQCsFby7U2G2wO2iJJYCzQ5Qi2e24I8WHqJHzug+ka7lWq6xV1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=cu5hfNiv; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="cu5hfNiv"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79ab3e26cceso13438937b3.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Apr 2026 12:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775763522; x=1776368322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EDMf5DiqxzIRFODg39rHWew8Gffuqkfj+AOOcAvVplo=;
        b=cu5hfNivBe5KkChwlaW+Ni3oUOhzyP+JlwPi2OH4FOo72QXT/WwPc4qeXE2KKUP8A+
         9OzP0yYiPk4L9cXa2bDW+o3lPh48AtoZ53vEnG3mbgCBlEOYufbK/IaTB6J8omeLOBYF
         wy2mfX2seF5yoNV5MW/iS6uY9MfFn1DpEbJsrXKLBkgEGnjzY9i3h3utMpxmwbUMAsir
         2sSszhk8tWjOs7JKDPq1NkUyFNp6tCYPB8Jz3pp0UdL8mpPvK8btiM2VJ7/PmpAoZFez
         64IQN+hbTLc6B4F3WzNeKE8IUVM4L1mDg/rL5xMSMW9/PtrQUJ5IMcoo//UQRcvUVD/U
         N8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775763522; x=1776368322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDMf5DiqxzIRFODg39rHWew8Gffuqkfj+AOOcAvVplo=;
        b=AYiZK6i8JKaPskkEsSzwUWN7csl9BVhcbPwHsR/xnQxVarq/5iYsAkfyusD5c30CLA
         lLON6xwn/wcIrAPKSgYZdFfwU8iIfAuFHi5CxgI9GVMkorZ9EVymtmyXb11SMeI7xpnE
         YT8ld5/pBva3e5MCWpHqel3BqIzLAdbvGwsQn5kXillG3EM7dmHoI3CL+54ZCB0DSzoN
         dyaqZx2peE0UxsuRh0Zrs9naGMVcHXxnnJIPUh7kyt26sk/Xwvn3Mxmh3i7xlwLMtTCq
         Ge9vBxiWnKRa12KDbrJNoeKysOmf6BSJbq+VzcrNfZLXmV/0K7PCWt0j+7obIwPRWpZa
         Oy3w==
X-Gm-Message-State: AOJu0Yz41TdCPmVRwUWak66cqTy3c2umyzWyv0nw/dsZXa+4oMwR+fe3
	nNk8HxPcPJDZ/Pv+jUL2a9TH1S29JIvn5JnO1UUp1AKbptmY66TW2kulu3vI2OKPpDCneuSac4U
	sA/mF/Jk=
X-Gm-Gg: AeBDieuFI5DEh5K71vhsa0hrI1IaLKlt+BCcTJ5yZbrJ9Ov6105MGiFxDbliRwNBkfs
	aNCeBDSF0+V6Zu70GpUxUP4rY+mcqFeE9YzW95YS4mojt1FJnRqOVS4VrOzsU5KtMwVFvDHx7f7
	McfqIQofN3ljFrgN3tQUUxKZ+ofMv8R7s+37n/aH+x1/3LPlIWliDbwEr6nrRjpM0qSo4+/zMli
	jo/1ezlLKLLW469NwE0JA7KaQ2bvbDCmOSCx++ga6HKw4ul3vXrTn30fMjIb5JQb0d3i6zRBZ5d
	p82Kf7O5Mlz/t17yM5xga+JkBfzSJw8v0iaE4uWB0vFcDDrh9PgmTCZuXtPeqzEVp0Pwlcnj3gV
	5cOshqPxczvIsExjT0olUlbswNOugnDmM3DlRDieonyueAjNdX8EUjLXtPs9ZCPAaLbT1OOc3R4
	Oa94KIghspCN/BRVQOWpGMDzoYMJrNcTGY3qodnw5GPIJqAch7VNECX833OsXTdWij+NYpgxrmO
	e//4/oxOeMNzbiobnOKFteBzHae/mMIyeYxOvbwmA==
X-Received: by 2002:a05:690c:e3cd:b0:7af:6904:3f1a with SMTP id 00721157ae682-7af6f327232mr3590377b3.11.1775763521895;
        Thu, 09 Apr 2026 12:38:41 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:594a:e569:c7df:c654])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3cfcba46sm3343917b3.16.2026.04.09.12.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 12:38:41 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: fix a buffer leak in __ceph_setxattr()
Date: Thu,  9 Apr 2026 12:38:33 -0700
Message-ID: <20260409193832.318303-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The old_blob in __ceph_setxattr() can store
ci->i_xattrs.prealloc_blob value during the retry.
However, it is never called the ceph_buffer_put()
for the old_blob object. This patch fixes the issue of
the buffer leak.

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 5f87f62091a1..c6fcbf428317 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1294,6 +1294,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 
 do_sync:
 	spin_unlock(&ci->i_ceph_lock);
+	ceph_buffer_put(old_blob);
 do_sync_unlocked:
 	if (lock_snap_rwsem)
 		up_read(&mdsc->snap_rwsem);
-- 
2.53.0

