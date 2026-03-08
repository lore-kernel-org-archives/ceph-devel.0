Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D13224B0E
	for <ceph-devel@vger.kernel.org>; Sun,  8 Mar 2026 22:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773007845; cv=none; b=JpcFXct+/y5gxNbtuzuHnrzGxuLZ2Y6LZOTpETrD7ve5IPplWhP971PcdvWz+beGXclkV2hSfRz+L7AlaYoTL2xIJ5ZIftBf3DwTCnyQmHVKMulbf/ArRrBbkP084EDdd3ZR7bVq6ozZSlOfnHOZdegMUAWMoVK+AMOjVQs23qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773007845; c=relaxed/simple;
	bh=RNJvgqPVhadjHmVzSAIe0LAYAg4DBFV+oyFQoPwT2Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZoMa+3JnlKCWVeUu3wvhA4L8LrMLh83R+S+mh0Qma3RO4vpvf58gtGHXikYVyFn+KRAG1EQHNaPLQ68/ivjXZlxMg/FwutIYOWhRF1zvzYWjz6L6w9DdGUGRwVc1TAF0y+NApqoGbaYTF+iNxTscpWKyLcTlH6dE03/8lqacrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMpiVTqu; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMpiVTqu"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cd75abd09dso214220385a.0
        for <ceph-devel@vger.kernel.org>; Sun, 08 Mar 2026 15:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773007843; x=1773612643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7iCjdsIzfUiqgPdrktYncSNku7wNYu96YUhr6tpCKIs=;
        b=LMpiVTqufFw4hrDiQSLHR8tzP1v4r8uDq5nuZIO1WEsDj6dgkRAVzP5eY+yJSqZj0p
         C4MBLnwXgWUxg99UGYIkrsmkx3X2NuVd9gpptCGdqNy3I/Le3/cjSyvSAKUNMKsaOhjG
         wqmAmm/83qkPPD6esOaQzVZ5RWCY1hA0c5iw6e02h2D3FeQiV/yZ55QqZZPizZN3czj0
         0OmkjDwfgQKtKzb3X0KTz30NDgebjQVwrNwV1WiLcef67AruYyP4qio1wbmd1KMHiq1b
         h0wQEp5rqhmGMEK17N2X0nrv1vh636ek+KnWj6v/7aobrtW5cp9ThS4C8pes4d2YFN4t
         0TeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773007843; x=1773612643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iCjdsIzfUiqgPdrktYncSNku7wNYu96YUhr6tpCKIs=;
        b=hlmeljSXxxrSPOG2IslRXTcVp9f2wp/6xWPoPXCBHTYWTz9fAvpza51jGh6Y7RXQ2w
         FmpEYhaIaDTou9sOknZAHdhDXp/0g6LnIw9kJ6LmXvkSdVCOCe419gfPp1G7m9Wbaet7
         BtxRWT5xdEG4tVOj8Fto6bJsmaYpmgSBwPK7yBaQHKgk3P1cwKjZ7wqnD9MMkSiLLt0m
         bHByAX2ta9n7HO6PFGKfLGXBQKZkdYUgixlyjHaliiYxUoDL0d3R29cIZnlCrUO9O4Ld
         sxUJEvzCFsMlI3kaLlilQW5ufGuTISvX/v9GjfcwUY+CQmcYKPRfCCeGbEypdPKk/ahn
         zO0w==
X-Gm-Message-State: AOJu0Ywaw5hEuMSxAH37PdkyatWMqrhRcNJuzFSrs2o6AMHYeeCttKoT
	+ggtGq0N61uExWxnGmIVA84kC6mOXtb9rMYK2x0gh/+g3cvwcZJRUq8fvuqGMw==
X-Gm-Gg: ATEYQzx9DOAlw5/FduzpUb/6nwUhU+dTDYZnHzld5osuuCUOE25ivkyiTTRmSYzymD2
	mXXMMBm8kZMthw+Fb5AqvtbQNJT2ksqyyfOLp1uD55XepBckutSv+PlbTZLdVAq5H9RftTGsXlQ
	z4zAh7yCgmE3l4WRJugM5bGeNk3WY3FD1trks3F4qMcXtLFCC9g8FuyuAy67PO4GAGq6TMOSCNM
	mAV55tYcpKmre29truexZndtufozgKYcLnAzVulMqc/jAk7NLlecitMUg6cmk8r3LcVFMXWZIY9
	bHn5WwRaC7Tzx9Z5azsoi+SRlx8uwb7wE0omcqrIuuzwaOwCNCHGdYUc0xTNZFkXaodk0cuXKqs
	ATh1vI36CRQ1YpxkVU8/Eo98HMMrOADwjty9TblQgGFRE/M+F4MQ4FpOH3Xpb085qSm2zw5TJZP
	WHM2b12Z51bVAGJmo/k/clPh3fTwUANiSfAppUpWo7Ax9sqGurhzYXwVVjQeA=
X-Received: by 2002:a05:622a:11c7:b0:501:4192:7591 with SMTP id d75a77b69052e-508f46face4mr125169931cf.32.1773007843330;
        Sun, 08 Mar 2026 15:10:43 -0700 (PDT)
Received: from zambezi (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5091a371f4dsm6482691cf.10.2026.03.08.15.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 15:10:42 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: admit message frames only in CEPH_CON_S_OPEN state
Date: Sun,  8 Mar 2026 23:09:41 +0100
Message-ID: <20260308220942.694505-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar checks are performed for all control frames, but an early check
for message frames was missing.  process_message() is already set up to
terminate the loop in case the state changes while con->ops->dispatch()
handler is being executed.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger_v2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index ed618435d33a..c4ddf7911f7d 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -2905,6 +2905,11 @@ static int __handle_control(struct ceph_connection *con, void *p)
 	if (con->v2.in_desc.fd_tag != FRAME_TAG_MESSAGE)
 		return process_control(con, p, end);
 
+	if (con->state != CEPH_CON_S_OPEN) {
+		con->error_msg = "protocol error, unexpected message";
+		return -EINVAL;
+	}
+
 	ret = process_message_header(con, p, end);
 	if (ret < 0)
 		return ret;
-- 
2.53.0

