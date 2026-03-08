Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7627717993
	for <ceph-devel@vger.kernel.org>; Sun,  8 Mar 2026 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773007696; cv=none; b=kQGKZU7YYgH0Cw2t8/eBkEqEo9/GsjPsPfHRopBbyop03TODIhG+wvtJGyCfeU5YJ5A1OsL8i0w5/w564jWj3Dpiwe/BbkT27FuOyzTP022gM4WYA0Bpu+HvYLkEeB0saYdEamtu9d0tofUhRLca2M/Fm2hxzMhWj+/0Zm/4Y4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773007696; c=relaxed/simple;
	bh=/cUlYErKITguvN5RuFFXKLAIKcBbAw+jp2xoEiVW8yY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dU4hriauZKqEM8MJZ+V80GAvp0tFU3K2qTRB6GDOeJ5Wac6dReqTZFgBeQj2HHVlnl2aCTKwlmihRfaYD+ltdu9Jrm8EBU4f2ueOCVqFXaV7UlnT6RlzjVOsc8DwHcPmlFuqg/NRSE9Glrae/DgZ+9umsLIY9Mf6cZSLQJtCxys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu7ZHsfJ; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu7ZHsfJ"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-509046c5c7fso16471141cf.1
        for <ceph-devel@vger.kernel.org>; Sun, 08 Mar 2026 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773007694; x=1773612494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CfiC09xPaT8Pp+JEZa7XGHwhJZpr+HrEJw0fXUj5FoE=;
        b=Cu7ZHsfJtIf4HBHFeBhAJe+BJnzR12biTURrE3kfmRwLgRkjEhifS04rIcjopQ/IOm
         JuMEwQS/p0iPi5WrmhWJh0JrVEYajtc4IoG2s4b5IZ/wBaPXwixRCRD6curN6qjh+6WM
         Q5kH+47quru1nKM3LsCx15ryxkvrme72aWIwwoh7DobpKNP79mgPBYuBCE272XIOgukf
         jWTE8dT1aoMdWo9cbQ9vdBUlYZi+7IcXovizXe/EkfkfbVIstwlWHI/+EmIaEfJ4bO3e
         Ov26mkBIvR9amV+qhH/nzfJNeE3/5BBPZz4nXQtD2LncloSrCe6S5YNSCudYrskc2JZV
         Xr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773007694; x=1773612494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfiC09xPaT8Pp+JEZa7XGHwhJZpr+HrEJw0fXUj5FoE=;
        b=rzGvTb4lCxwXEn44S8kKaa9Y+DJBUE9M/NoE6/ADMcL8C+Ib7MNfaSFgZo6nHS52AP
         dGHLqnOSA5jBbiz/gt7/NfKTcdJwytLeJ1MS3dstx2WydAVq1wEKgxSSMuvG5D1DkACN
         GTAkMy3b3X6F4pBD3Oi5zPXds6+xhvUbu0RqzCs3LBNl71y0Hqh3Dw1LC60PyWv6Y3gg
         MEX35IJ/U51SbibnCVprdLrEoUFnYRVI/TXSzA91taaw7HBS70OUNF/3TbmyvdytJel5
         zwQPhn+Rvj+dgkvruCTvo7iNBfpAsyxA8B9ziVLJlNe2/U+fXFdrdQ4d8j4KWfqDxOP8
         lXZg==
X-Gm-Message-State: AOJu0YyLQpn6UxOj2wojXZjZTjGR3s2hs+bjXDBAT0A5aY45Q5xw0Zsk
	rXLk9wzc+bch3M6UYVJRhFU6pOMf5Adisg3Hh97CdLQxkHTUhQ0vxvYnhxiyww==
X-Gm-Gg: ATEYQzynxN49hEO7WAixn0C09ckGf1p1Z10DN/3HleHCWAKGhbMcaamc7AJO/4bgWwb
	DJtuMTrQ4pATM8iWRivdIw5OHLPs7Wv5bhlETSaWIWBrmtxw0lgS/eqbrujn49iK1UQqlV+ZnFI
	WS6/aiuUGZebYPIbq4qTzHDyivbvsmLrWLdUFMetaa/Zhymuvv0yUa7FG9SLiGgZa4wYnahXboM
	l6JmcBt/SUJERYIOtcQuIwpdLRRshB4xCqMQ9vzsx4VOYSYFiv4Vpq4Q/kheIxNhG90bueMz8Vh
	5epN9gncxC7dQ7WJrk+9V1B2sqwGON86NT+HJ1APYajIGuTrnZK+y4wa5QUqLi726W4lFQR7+YL
	Dqq5MvfcHM9NgiCVqGV0WEqtvbnoDoFZWIAQwRrA2p0tjJn28Mf14CZrrFxQjuzbcOPsWY4AZHH
	NqJOJcwlr+geKr+BTZrCIjBiilVYlqSrQb5Y3YmeWsEmB4aY3V
X-Received: by 2002:a05:622a:130d:b0:4ff:8500:7881 with SMTP id d75a77b69052e-508f47055b1mr127752261cf.15.1773007694348;
        Sun, 08 Mar 2026 15:08:14 -0700 (PDT)
Received: from zambezi (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5091948821fsm7637941cf.19.2026.03.08.15.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 15:08:13 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: prevent potential out-of-bounds reads in process_message_header()
Date: Sun,  8 Mar 2026 23:08:02 +0100
Message-ID: <20260308220804.694227-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the message frame is (maliciously) corrupted in a way that the
length of the control segment ends up being less than the size of the
message header or a different frame is made to look like a message
frame, out-of-bounds reads may ensue in process_message_header().

Perform an explicit bounds check before decoding the message header.

Cc: stable@vger.kernel.org
Reported-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger_v2.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index 5ec3272cd2dd..ed618435d33a 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -2833,12 +2833,15 @@ static int process_message_header(struct ceph_connection *con,
 				  void *p, void *end)
 {
 	struct ceph_frame_desc *desc = &con->v2.in_desc;
-	struct ceph_msg_header2 *hdr2 = p;
+	struct ceph_msg_header2 *hdr2;
 	struct ceph_msg_header hdr;
 	int skip;
 	int ret;
 	u64 seq;
 
+	ceph_decode_need(&p, end, sizeof(*hdr2), bad);
+	hdr2 = p;
+
 	/* verify seq# */
 	seq = le64_to_cpu(hdr2->seq);
 	if ((s64)seq - (s64)con->in_seq < 1) {
@@ -2869,6 +2872,10 @@ static int process_message_header(struct ceph_connection *con,
 	WARN_ON(!con->in_msg);
 	WARN_ON(con->in_msg->con != con);
 	return 1;
+
+bad:
+	pr_err("failed to decode message header\n");
+	return -EINVAL;
 }
 
 static int process_message(struct ceph_connection *con)
-- 
2.53.0

