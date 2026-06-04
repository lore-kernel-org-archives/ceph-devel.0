Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A272B3B4EBF
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780596554; cv=none; b=ghT15+JLUWEf8//cxm8ZtM4ZDY6at4lU2p27cPmtlI4PEyTJPGTNBgE7yP6yjlvgfZBgxwGu0NKuPuT4KE6OkIeNjPOZGOjeVxouC1pT9pemn+JFwpMMXVJhp3cJbxFCjBeLn9oZg9aka0edWUyvwvZAMaOVBkKHY31akrgQOWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780596554; c=relaxed/simple;
	bh=bT58V/InFAWfeakk78BgVqBWmxLwpXGinvWy6zPUJf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FucV9LmgjbkTdSqap9EbdoTj5F2gkLWVgrLjN6uh60DTKb9A0rr1BVRkDroqmVpfZH86xtI8QcM9USWXhZIKAmZEYsyTAI0XLROdct94yk088gIid5K5Bms3myyjxLvoBKMhBvxCFZlBdeQrWNxvMmKV5U1UUFXQOSGyEJyXREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6xGcdsg; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6xGcdsg"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51778077b28so11152521cf.1
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780596550; x=1781201350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRBmb4WQIMwOp8EJqjAWjm9PjUUHk3D5HPtS2dDVrls=;
        b=A6xGcdsgzCcGOqoAjMfEDfRTvQBBJszQ0GM3jVbP65DDzfkevXrSXQQ3kkSw7HAgv0
         YtQ5D/PrRRC3g2Ixs1KilJEjSsPp6IdJ+x2z7wCXBbxOUja+bADxqUWuVxLH6F9wOpBR
         FItw3wtmV/SkpH/9WNiPS5DwGTK3p57U7Zg1qcDYlCyj/tpS0BkJjxoWDLt06VgiDAAB
         92p8Bh9in89XJLKOTA3kphDY3uMtSyHL0fEnxobfcxZIsTIJvlNo4L6PeGdrvpjXtGPb
         2qhSs82QHHkGV56M/J47MW/6Q2iZlA9jvSRaBqtdJAK/LOx3irjkm8EoqOS+5fEyD8zV
         7+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780596550; x=1781201350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRBmb4WQIMwOp8EJqjAWjm9PjUUHk3D5HPtS2dDVrls=;
        b=GrD1aLQVv+4JwcgK7yAGYfOH6YJ4bQUj5iwBFgrilhsn8Xyy9ZQ3rYyakZKfsHK1Gl
         f0mqfPMBOk/B0tww12kALNaoGKoium7l7rk/nwcN76P4qIUwBz2N7Pf9+LkG/kaFil1p
         oFxax8U6JLaasDBqdxuE9X41lRZFFwDPzQBh46rbzDnaOM7Wf/tZgT+Od4mAIpe5D9qy
         2r9bVVTH70PW86Lkmn/XQEya8CPZzGmgzop0qOMIVxwGdNftRYVeDgfeBpkHrEal/OpP
         DrFoHK2C0PkHdfK9PEGMOnmsIqm7scCsyEm+u70eqxzEQzxgAETst63TiDRnVOGWSLcq
         OOdQ==
X-Gm-Message-State: AOJu0YwxIAMWh7gbHnopWNQEghoYDgUV8K5QrEeZkSUD4lPAI9JC1nTI
	m5P8lC8bv4iapkOJaTqU89RIYI/q9fPS2p2npYPNde39kzh9rXWURVJp
X-Gm-Gg: Acq92OHyFz27DCp9jZLDUAO3JjAWTJ5+imOkr8W8WxDfL87XUMLiUZQCXHuNmkoOMIf
	o2ng6j/0v9WyWOFkPS8sYyO5+KN1+KWIX08ZcL0Mi6y22YJlQ+my9lyAJ4YBcRr2CUFUWdbIDr8
	gNRP3FMgBlnXFe/H9O0VKa+EGubWz+Hp9uoEGYo47SC9vLQgmh37utppMDodz4hl1YXuRDcYA0/
	VXgrFioGZjt8VfT44NRr2H/yv5Al2hP6E92ECRb0GErzjwavEDBj88h7JA28mqbDCdcOgUXN0+c
	n5MedwIOZcfNF9nj5jU9KKVEka0HKskXJmYx6R0Jv4Qaiycw735VdaPcMggt+JQMSQgGmwrYejY
	95zi9tcC86KrXkybY/5f08QADzjhXwbi9kB/D2PTOrYTu21bonzPKfGXNr4Je0slqp9ifG2DNBA
	UjaK+5dn4R++HeojcUTkJzyYKCUXVatMA0SztpJsaZFS3CCdpFfyZMjIm5jSm2jqutjCnNz41G6
	rWFapqGWxQSA18Webe24rymX7UlJOEQu91m88Sc2w==
X-Received: by 2002:a05:622a:a98e:20b0:517:8fb6:56ba with SMTP id d75a77b69052e-5178fb659a0mr25295821cf.24.1780596550612;
        Thu, 04 Jun 2026 11:09:10 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775dbd2c9sm59020961cf.23.2026.06.04.11.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:09:09 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ceph: bound xattr value length in __build_xattrs()
Date: Thu,  4 Jun 2026 14:08:57 -0400
Message-ID: <97a34ff3743172b1278f211d47a500a07eb25732.1780596023.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780596023.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
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
---
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

