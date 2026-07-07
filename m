Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0519143D4FF
	for <ceph-devel@vger.kernel.org>; Tue,  7 Jul 2026 18:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447575; cv=none; b=h4AX5j9EZxrfl9GpXda4OMAo7kcFUISNbOnoemqpohu2wMbc/gwXmHtMP0x3wcnRvwzmjJ2rEDkSPw9mxOycRxy17YzKXWt5JHngmnPwekhkiYsFS0PnVrN5+DKcwfop4NQRh5TQUtIQ/nsy24bpro9rl0IXLjZgdNGvxzuaWYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447575; c=relaxed/simple;
	bh=DxXt3Q2DiIRmApvRKGH+cQ6dSbHwjJX6ntYdiXVePC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=it0Sj4NqX4HBGMklG3Jt67HdbHjDAIBIaD6Jee4bLHhMRJKupX7HAoutWtc5AAhSSBaTCc5TlTOQcAHK51W3SYEIBF2p0t573GMIX3auDsm7NR+RFdrJW/YCL9xWvR8GBQU2Hp37XBym+r5wLMIQAFGl8KmQhGyfd2o50+dLozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pEJe3G/K; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEJe3G/K"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8edda5d56a5so40993466d6.3
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 11:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783447573; x=1784052373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g90IJcGT+wQTcmQ/mehdTMw0WPxAuOtQnbadl+b23dk=;
        b=pEJe3G/Kvb6uUWc5WtG6Zs9rra+0hNM0hw0yvwsHOtFM5LE3o6S54LtqS3rBLFE+8M
         gnxQFD2yb/rpEoFyysw9mhQv2zhdEDHFlCm2EtWc1xLmhHN6P7SGcUcYUj+rcDnelglp
         Yf74IqKkzXh2m6aDACCZYGFVWDS1JqpzSdTF/lw2Vlow44szIarfQRGna4AZltv6mKC6
         uchj9RrIsaJzZ6Q2pX259GR3+J+vCI5nWgV1d/xjRjj7kfJu2UNJgO7n5ZhLo3/xpzRW
         5wcZFDfonS0JbH5eS9vFAM6CUV78mO3mepLfsm/+In0tTS8gz7X5NrwSV4Fa+Rto+QLX
         gQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783447573; x=1784052373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g90IJcGT+wQTcmQ/mehdTMw0WPxAuOtQnbadl+b23dk=;
        b=lq4sXTs5kZRJv+6g65VGlnZkhXLldPdtqXK+CG4oa9lZO8oejO3gb4gjXqlgZBbg0y
         1Wrmq3WECVxNSpGYNCbOEaWT2HAQpDvBuYuO+1jhudqOxzKvSDzOA1JFjnxwoQJEN/9B
         VJ6LWqk/25uNjTopBwB1t3SDIgRmqmty3BCw+/q1k2swkEmt6d0VFTJW8txGINjI43o1
         kJYzsfJkYb4f9bQY1p60Yz+XGQXmrOgWh9X9z0CQvtItQktEgSZUmFoA5eAmk/8+6/lp
         FBvEQsYw9gJEfoe4vm0q0uJqXqaQs3rjoLj4qe4fTPweQHq3Tb175RNZ2IdWmFEgezAe
         lV7Q==
X-Gm-Message-State: AOJu0YyTEtvAIeIkXbwBn+6GiliYPpVfOeO9bewWyKXs0J5sAuyAIm7S
	XAf4Y1WzGIcn/GQ7qG182UF5DSsJINxiZtBsUXciQr0XAzLl5Z3i108F
X-Gm-Gg: AfdE7ckLtO8tZLpPtARL/Hs9M/zNQqs2Z6az87KyFa5trcm940JTO73SwfFagVk2TSK
	6rakEOWUfU8+WLhyVY4IjBd/HrUGJuU51v0E6uzmn/HCz/ASfLSV8ezSmPSMeDSNGeWpO490IuA
	0DM3dVQOj+I8h8fJYa7ihsGh10lEI4cjgI1E1I12kUbGlc6y3KNluGQ8V4Jfr4g3SWWvhULaVER
	G9HbwRfPOXtbwoucnh1s85TQwIOCTMP3ForowhXCV9wcH/tJNR6APG0nTNSeL+RrARt7L84jGP6
	MZFP5QzIYCZaS+3OuTEC93R7/kKKPXQbWEOIpJ8Jv4ldbnHW427WJ++Os9zPScV3wxDHfiuEz4j
	wY9uH7mDwZcRl3RjZbyam+maMlMOHe9kFMXAjnAgr6ynzR2u9yUuh1YikfXPW/YgaGFIpInYkZ9
	xTG/6DMCXOCu/Vfy2FFzgB6ptBcScr4REC+2ZyJ4nZeceuD/DFHOkckL6la9/y3XH6st8s4j6y3
	wWC7ZkbK5sa36hfsiD6L9AS/2XLA96S
X-Received: by 2002:a05:6214:4e08:b0:8fe:2b7f:2a78 with SMTP id 6a1803df08f44-8fe2b7f3e0cmr13922306d6.53.1783447572745;
        Tue, 07 Jul 2026 11:06:12 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de87e3sm166404376d6.35.2026.07.07.11.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:06:12 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] ceph: bound MDSCapAuth path and fs_name decode in handle_session()
Date: Tue,  7 Jul 2026 14:05:58 -0400
Message-ID: <8a59da434c232933be009872b0223a5b907d12c1.1783447231.git.michael.bommarito@gmail.com>
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

handle_session() decodes the MDSCapAuth records carried by a
CEPH_SESSION_OPEN message (msg_version >= 6). For each record the
match.path and match.fs_name byte strings are read by first decoding a
32-bit length and then copying that many bytes with the bare
ceph_decode_copy(). Unlike the surrounding fields, which all use the
_safe decode variants, these two copies are not preceded by a
ceph_decode_need() bounds check, and the enclosing MDSCapAuth and
MDSCapMatch struct_len fields are skipped rather than enforced as an
upper bound. A length larger than the bytes remaining in the message
front makes ceph_decode_copy() read past the end of the front buffer.

The message front is a dedicated allocation (ceph_msg_new2() ->
kvmalloc), so the over-read runs off that object. A malicious or
compromised MDS can trigger this with the first post-connect message on
mount, with no client-side user interaction; under KASAN it is reported
as a slab-out-of-bounds read in handle_session().

Impact: a malicious MDS can force the kernel client to read up to 4 GiB
past the message front allocation during session setup, crashing the
client (out-of-bounds read).

Switch both copies to ceph_decode_copy_safe(), which performs the
ceph_decode_need() bounds check before the copy and branches to the
existing bad label, matching the rest of the decoder and the error path
that frees the partially decoded cap_auths array.

Fixes: 1d17de9534cb ("ceph: save cap_auths in MDS client when session is opened")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/mds_client.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 18be36c2e9e87..94f76e9fe4ead 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4434,7 +4434,9 @@ static void handle_session(struct ceph_mds_session *session,
 					pr_err_client(cl, "No memory for path\n");
 					goto fail;
 				}
-				ceph_decode_copy(&p, cap_auths[i].match.path, _len);
+				ceph_decode_copy_safe(&p, end,
+						      cap_auths[i].match.path,
+						      _len, bad);
 
 				/* Remove the tailing '/' */
 				while (_len && cap_auths[i].match.path[_len - 1] == '/') {
@@ -4451,7 +4453,9 @@ static void handle_session(struct ceph_mds_session *session,
 					pr_err_client(cl, "No memory for fs_name\n");
 					goto fail;
 				}
-				ceph_decode_copy(&p, cap_auths[i].match.fs_name, _len);
+				ceph_decode_copy_safe(&p, end,
+						      cap_auths[i].match.fs_name,
+						      _len, bad);
 			}
 
 			ceph_decode_8_safe(&p, end, cap_auths[i].match.root_squash, bad);
-- 
2.53.0

