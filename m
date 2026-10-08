Received: from cvsmtppost22.nm.naver.com (cvsmtppost22.nm.naver.com [114.111.35.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1E93644CF
	for <ceph-devel@vger.kernel.org>; Thu,  8 Oct 2026 06:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439675; cv=none; b=YG/C6YFn3siKrsx3mzX0K7uq8r6E+mCDBBT7WR55JQktY7NMXtbHq6Ymgr0kzgP++XTSzXEFtdOtuPLGsNEQWelvkoxOD2mjf0tHhh855tySuTyJrp3K7HKLkT2+DN7nKYsRubu9fTs4fsW/1MI/mff6uTgJrpS2pw7vYg4oYdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439675; c=relaxed/simple;
	bh=1Tuxlbr7znEtyXph54NO3YqQlC6RN+GpFIZOGO41kiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=farqZXan5X422astbRbAOwid+y83JZDWsXDpT8Hr9gLXTKUJWysMBaHwLdKs10AufYYvAS9RI4Qpg/UoS0Y7XtEVRLJn0gpuMDUc82/hLpLdtkNnK3EPHEV8qzi0QtUPKYChl3gjLoMa/9Mlp1gzUEJ4BjWWEC0kEa72v1KKV+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=iiKMEfNM; arc=none smtp.client-ip=114.111.35.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="iiKMEfNM"
Received: from cvsendbo023.nm ([10.112.22.35])
  by cvsmtppost22.nm.naver.com with ESMTP id Ybg+omrWTXqbNK7KTGVLUg
  for <ceph-devel@vger.kernel.org>;
  Thu, 08 Oct 2026 06:07:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791439665; bh=1Tuxlbr7znEtyXph54NO3YqQlC6RN+GpFIZOGO41kiA=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=iiKMEfNMrxFax2QLKcD+IdjTSwaBTz72lKnc/oV43Hfqi3dwrNoToz5cFEsKPnK0r
	 jMdKZK0Ig9duD6Ll2wolvAozcTzSI4r5CRxwQPAVvVer0CUcMNJHMq52nU6mymhqem
	 Yib0EAOPffL/AhO2mxNuuf7oBmOK0CW7s04JgNk7xvF91P1TbzhilDruWDqShoZE8w
	 nGB6SjVIq54ITBKrCI/wjIJbNW/YaF6uVn0/KRH0AUuEpNH8/OrH+nt5svGfriaoYo
	 BY0LZD2RriubpRh6PBNa5hAs/vCbHOb9JwkEQ4GDd1R4tWVQGZcDtXJrzN8deXjhbn
	 UFDUUKsZx9Hew==
X-Session-ID: 3vEAfrUhQPCbSJ0RTliJhA
X-Works-Send-Opt: OPFwpzGdjHmdKHFOMr39Ko3YKHmdjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: rqYmFAulFqJZ+HmdFoUX+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp007.nm.naver.com with ESMTP id 3vEAfrUhQPCbSJ0RTliJhA
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 08 Oct 2026 06:07:44 -0000
From: sung byeongchan <tjdqudcks0424@naver.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Subject: [PATCH] ceph: validate encoded xattr name lengths
Date: Thu,  8 Oct 2026 15:07:38 +0900
Message-ID: <20261008060738.183352-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__build_xattrs() advances over an MDS-provided name length before checking
that the name remains in the encoded xattr blob.  On 32-bit clients,
UINT_MAX wraps the cursor and is stored as a negative internal name
length.  A later ordinary listxattr() converts it back to a UINT_MAX memcpy
size and corrupts kernel memory.

Check the name range before advancing and reject name, value, or aggregate
sizes that overflow the signed internal accounting.

The malformed blob corrupted kernel state in two baseline boots.  It was
rejected cleanly twice with this change, while normal and length-only
controls remained safe.

Fixes: 355da1eb7a1f ("ceph: inode operations")
Assisted-by: LLM
Signed-off-by: sung byeongchan <tjdqudcks0424@naver.com>
---
 fs/ceph/xattr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index cc4ffbbcb719a..ff70e4df9331c 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -11,6 +11,7 @@
 #include <linux/security.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/slab.h>
+#include <linux/overflow.h>
 
 #define XATTR_CEPH_PREFIX "ceph."
 #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
@@ -843,14 +844,23 @@ static int __build_xattrs(struct inode *inode)
 		}
 		err = -EIO;
 		while (numattr--) {
+			int names_size, vals_size;
+
 			ceph_decode_32_safe(&p, end, len, bad);
 			namelen = len;
 			name = p;
+			ceph_decode_need(&p, end, namelen, bad);
 			p += len;
 			ceph_decode_32_safe(&p, end, len, bad);
 			ceph_decode_need(&p, end, len, bad);
 			val = p;
 			p += len;
+			if (namelen > INT_MAX || len > INT_MAX ||
+			    check_add_overflow(ci->i_xattrs.names_size,
+					       (int)namelen, &names_size) ||
+			    check_add_overflow(ci->i_xattrs.vals_size,
+					       (int)len, &vals_size))
+				goto bad;
 
 			err = __set_xattr(ci, name, namelen, val, len,
 					  0, 0, &xattrs[numattr]);
-- 
2.43.0

