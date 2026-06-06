Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288092F8E82
	for <ceph-devel@vger.kernel.org>; Sat,  6 Jun 2026 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780772452; cv=none; b=E47d/JlmQp7qzlLfbvMQ+ypi1Dv+dUL4hkXwOxxJYSlfwo3s+tBHmHtnLmVT9EqaSR86cQjezAudepCGwWdpRRN5q6Xg9VCQpNRyWN0xr19XLBBUBDrHyQ4K4R/G4KnAa8NyTI/ygCtep9kl8TW9F13JxHQ/2sLYLOtf0P1AZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780772452; c=relaxed/simple;
	bh=p04gKZewWGHGeiIshvk8TxG729gV4NtSvKoh07Wi73I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7njpIltI0UgMOz51DduPs95w5JxBGGYrXX5bN8O5ZdeQ7oI125gmNZvm2aOLiDJ/rwpKw0ZKgJs1+Zk34c1jzc5OqUobF+e8nj4RdoFHN048bBX0DrUrXuNRTUdAhePy/VzEjymdoLqua0znJTe+p92viyirq9p0cVsAWUKx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYYr7jVx; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYYr7jVx"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51761d27612so34919731cf.3
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2026 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780772450; x=1781377250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXuQS8LAd9fbsQ2k1v5BJHiia9ttbolctoKgd5+Hdl4=;
        b=fYYr7jVxzJY3p9j7iP8baThsLkX9WC5zc4Dh4fel1GSAUD3dc5rvDj5X88xKPAG+T1
         ERpNWuO6p7cXTnNd3Sero1TZvYf0EDW4vrZ9Z/5ur7U0dh40c2YRPU5xfkYzyOPKJDli
         nRhb1VjreEY835iTmjwjH6Ab/A7GpoS1FYW/jJpo7aOyybCZ+3liVNO60hEXI5s58sCb
         EHKa8cFQgZlJ+HmszKOmUlCd4Iks5AqShJTCNQwIr+QK7XrDkhSutjthZJirK8Vhw14w
         lzO3wHe72/6/aJm0Wy/5IeWkteZph6oLbyOrBzksO7L4D56KIw/vxopQ9z6+587fW/T7
         0evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780772450; x=1781377250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXuQS8LAd9fbsQ2k1v5BJHiia9ttbolctoKgd5+Hdl4=;
        b=EnTTqrVbWrhw/3ta9lARVCRWIQCMLdp+Q4M7HXGm9sBOcxHAmMtn8Fp8LrKsX0Osea
         nBWInkIqKDaN36fL+PfHMD29Zu9USP5mnXOssy122xLD6TQmapVJriZoMZ+Q7/T7mFAl
         ej6QdfN5uw2I57tU9FK+5Jdxfcd73QHJgcLwlRl8Y/EWKzmIlJg30nQeycANG1sJnmic
         +9hpE1REW3X7Gug0/0VJOWCBMDyb/smOY2Qt2mswiQYnEG3J11RFTL+euuUoPVbQjZ3s
         XCjSrWz3ErL49oNiFnTlpaUj+G2lnBaFt5yrcGZXjzzhuQrLVsCXzjY58hY6W0zcJ9Vg
         +smA==
X-Gm-Message-State: AOJu0YyFjgqHa8eNtB1FEUC2D39ot3dt9Ez++l00YNk+NIvJxLhTnaHg
	kKzhE+5OpeOD7E6vd0/UJ/ogBw5ET2fG1ETGjOwSryqYSZi9pJQd1+Bw
X-Gm-Gg: Acq92OFoxe3UXjBISzRTO3kEqxbOuFlEnG9kTo99v9tjnRGYpXTwWdlOELDm34PQSCy
	q+o2EsLSOeK+Vn6dgWKeBHsW/reh2VG77vSvj0sOreSTcuiisJu4jMYmjFIUkLgOT7eDbB/Ahu2
	584yV7MWbMk4aSi3IdVMomNDZ70CccTIRbJ0lQtwOcwkfNblYmm0Mnrx93wnnLDQ/aLcT5XdDdI
	ogGEj0+eNVmzF4KsL4P44mWfsMnFqrGocqnqIFUzr+GwtVlCkqSKYeag7GdRwy5MPvpOL3w++78
	Zi55OzXoWZYr8zwVhITCqVqMV7bf9UBXdN25RMevNYih4Tu2xLgxiuy7GxaTo6EGbOpWc+43/OR
	x+JLf9OCUZsS6QswSkEaFHUQ9WtCoz2BkNqQ1UsnX3z8Suhw40lE19CgaQ3kFwkAIPr0+WOEdH4
	wAvMO/mFMC8YJxpxj6juNZFDYGAMqfcc11LgcMtRgtTCuy0jE4TTYrcqtI+fzsye4LPlyXygZEP
	/7zdEkm9Nzrdio13J6OY3vUavziQ34=
X-Received: by 2002:a05:622a:1451:b0:516:e031:933f with SMTP id d75a77b69052e-51795b0e76cmr128614291cf.6.1780772446093;
        Sat, 06 Jun 2026 12:00:46 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5179dd9d908sm40084581cf.15.2026.06.06.12.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 12:00:44 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ceph: bound xattr value length in __build_xattrs()
Date: Sat,  6 Jun 2026 15:00:22 -0400
Message-ID: <b95f479f4cc52c879ace02ee224894b8feae942e.1780766417.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780766417.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com> <cover.1780766417.git.michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

__build_xattrs() decodes the MDS-supplied xattr blob one attribute at a
time. For each attribute it reads a 32-bit name length, advances past the
name bytes, reads a 32-bit value length, records the value pointer, and
advances past the value bytes. The two length fields are read with
ceph_decode_32_safe(), but the value bytes themselves are advanced over
with a bare "p += len" and no ceph_decode_need() check that "len" bytes
remain in the blob.

For every attribute except the last, the next iteration's
ceph_decode_32_safe() on the following name length implicitly verifies
that the previous value did not run past the blob end. The final
attribute has no successor, so its decoded value length is never checked
against the blob bounds. A malicious or compromised metadata server can
set the last attribute's value length larger than the bytes actually
present in the blob.

The blob is a dedicated kvmalloc() allocation sized to the wire length
(ceph_buffer_new() in ceph_fill_inode()). __set_xattr() records the
oversized length in xattr->val_len verbatim, and a later getxattr(2) runs
memcpy(value, xattr->val, xattr->val_len) into a user-supplied buffer,
copying bytes past the end of the allocation back to user space.

Impact: a malicious metadata server discloses adjacent kernel heap bytes
to a local user via getxattr(2) on a CephFS file. Add the missing
ceph_decode_need() so an out-of-bounds value length on the final
attribute fails the decode and returns -EIO instead of being stored.

Fixes: 355da1eb7a1f ("ceph: inode operations")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
v2:
- Add Reviewed-by from Viacheslav Dubeyko.

 fs/ceph/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index e773be07f7674..d488bb8fc00ba 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -848,6 +848,7 @@ static int __build_xattrs(struct inode *inode)
 			name = p;
 			p += len;
 			ceph_decode_32_safe(&p, end, len, bad);
+			ceph_decode_need(&p, end, len, bad);
 			val = p;
 			p += len;
 
-- 
2.53.0
