Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA6543C7AD
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 18:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447573; cv=none; b=Nz1g9DSSK1jg4PWRiuwM683d12LnRSlb3ctu5rx3/VBy56pQXvehvmFUqLraOVENRqU9QgGTGYQgj7VCT55pG+Wplc1D/7gY0UQceoZHgfPLJJP9UbRWl0E7Y1rUeZ34/XuBINZw6tbrXGYCDNaDqlsbbpSYpPTlRjglqsMFmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447573; c=relaxed/simple;
	bh=17MHpz8YRM93pjU20+mNtcutvDfiEW+WTCuHxY5B/GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/fk3DftdrDN9TAy649WzvZ8arZlnKXq6di5Rq+xlOBPlnm24Cc5MF4k6RhpJkV46beHXO9Glrdz/pLVgZ50jF75T7GVive2y1OPbDNCf6OOgDblbKmSBwzrR7IyJl+75XOTYfy2PV0zf5VLqQ23BWDObY60lgKOnRD/ieJS3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJ3ZS3rH; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJ3ZS3rH"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efef6533aaso35230626d6.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 11:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783447571; x=1784052371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lJyAWAHsB52BJta1VOWSHIf/1ECnUgR3LU+s8CzHBxU=;
        b=nJ3ZS3rH2YH9ZQxqoibyHMMSovw7ovGozVaeAVq9QpyLgCAjZuQRzOA+Im1UnCnzwy
         R6KNi/EkdDIHOBdleVtqvowuwIaACyKCSsPOndf/rmk4TY9JprfsxKC+okxxClUhe6qa
         CdOcHkG/UyU33+tgCjbbV8eTL+uuDPZjMHwoQDmJeRTuzaj/vmZp3BTUAMu1svmxND0e
         5Yl/OKk3RQYZTXIIKFoNAtOmRQ7veuSdOARyi+ItJT4E+1fnJ6wfpqOYizGSOw+bLS9i
         PqIh0PREgR0yHQ9P2dS9hvudsYTsTF+5ZMmhz9J7DpeLkwywp0MBDVT/sQ/08BGFO7Iz
         SJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783447571; x=1784052371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lJyAWAHsB52BJta1VOWSHIf/1ECnUgR3LU+s8CzHBxU=;
        b=rx+Phppe1p+EBMziukdC2xF82VzgrKgR/96jqZk5JkmhlDrGKY92gaQ3RzFlLxmOfx
         zdSove8tKqsNZHvZe0LZAoDx7OOQbLKBKwh/HisQhRwNKasOeLviaGDIvtl3rUARzGXl
         C8uh8Ju0CG/UVoIJ/nbIC//CCU+tLO/EQnrMt2RJlK4Zsn1esVbZwHDd2W9MPSKZehfe
         CztEeiMP+bTNbtLrONTUZGGjhyL0u/Ul7ItvfazlmjmwUKBJkBnp07HhEIVxP931Rj9g
         dwwdJbOrd6BqKS5DFe6ZA8+J2+a824B7Ij2ToRYyJ70RA3V6yD698abOb8gTUnPcBxBx
         K4Hw==
X-Gm-Message-State: AOJu0YzRYwcD+b61Mpwj+1EUfIxzk92bO7s6/RmqqS78S+NerP++pgzg
	wNolRnjO1TnlnRpBuuoRGASc3IRwSTWAaiorIgoTQV7W9bluq427lThV
X-Gm-Gg: AfdE7cmPN1H+EKtssfHsmCVXfvJfJNcFs1TF4iARna6HQUJKNhkLu+XXc0p1bsxEZ8D
	r5cZhgfbIT8gkBZ8oKHm77uDtk8lUi9ljd6dMeZ4gLoqynkURAP9ju7aCpg+zX8RDJiyOeb2Vrl
	wLAqFOqf/jE62BA9aNfdX/+ENEHRrux7ZjYme4kmrwskQ5kzbY7IkIU964pPNmfmKwdgYxaBm7Q
	onqP7BBhPtPQ7iONXxX0Vqte7D0HrBD+JmAMcuwTbBqTPw85bBkIfcp0KdihYlkcfpLOSpbB0FS
	KgEYUYT/V/5iEPv4d88NBSyPeSZqgz77v3w6ZDk2+p5bQMIfwZY4N6m6sLx92I3VjpXZt4WCs4x
	+Erk1KE/fmaY3xQiEpmS/dAAoZCKj652CMNTQjtwRQPCPjG14RpbSDWFtTtfmZPZBYusj8hqj1P
	IBAPjXhNROkh23RE239/uH5l5uB/pIw1R77HCGY7QqMJDC9Pfgn2Z7kttUB+XskVYKBGnbR9zub
	nR5ua6iQ4mI7Qebyuq1jw8OcHEJjCp4
X-Received: by 2002:a05:6214:2127:b0:8f0:1b69:25d2 with SMTP id 6a1803df08f44-8fcb2a85933mr71857946d6.23.1783447571441;
        Tue, 07 Jul 2026 11:06:11 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de87e3sm166404376d6.35.2026.07.07.11.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:06:11 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] ceph: bound xattr value length in __build_xattrs()
Date: Tue,  7 Jul 2026 14:05:57 -0400
Message-ID: <661f2c76ce3e4224825c589b9d018e7b52dcc065.1783447231.git.michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1783447231.git.michael.bommarito@gmail.com>
References: <cover.1783447231.git.michael.bommarito@gmail.com>
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
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 860fc8e1867df..cc4ffbbcb719a 100644
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

