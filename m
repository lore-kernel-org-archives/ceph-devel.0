Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEC4189C2
	for <ceph-devel@vger.kernel.org>; Fri,  2 Oct 2026 07:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924968; cv=none; b=ZycFsnCJv29h+BUb6nWUU8RR63EIukHkLXQxURiqTip5/rCU3NU/BTK+AReCiOPWHW3snEngS6QKYQF+K8ZAhthYanRBjjKaKTlnrPnqs+d0Boa5P1EPWI25Ewy5btUciQhsY8DhyBr2QxyDv3W5VLFf03n7UWpL0InlB7+/37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924968; c=relaxed/simple;
	bh=9+1/mB4SG1CWMNGPyhbjlY25G5DfHb9OkIz1tVZzmIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkuhRhItdNYiVrhCKayZCEtt7BJg1crch1lIHX0vEKrZADaAQUDzRq6Tj7Zra/PfVS3Ywt4oWB4gMwln2Vx5FmFXrR/+FmcBgCkDv+nsVRFevHXeKbUKzSD19oEM9hhz2/py3f2GWAyKbQp9bOqGQMzYuU7AmAvik3DHnH8T9Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=HZxwAZ7I; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="HZxwAZ7I"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2d9fdf798so15033615ad.0
        for <ceph-devel@vger.kernel.org>; Fri, 02 Oct 2026 00:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790924964; x=1791529764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/++qgKzFBfWPJ7y4nRDznqSG78KTSgC5SSZmS+YUXvo=;
        b=HZxwAZ7I3OFQP38qBPUPEVGVoKeMQKcbfJvsRQHeoiTzLfxuM9MTcPPvM0Ff/FPa9O
         eq50u20EZAo+mlPvS/zbojlDUpJSVGGQRhnNyMap+LbiFhHHfAM9EnxRJ6fMlZokrSS1
         FXfe6yclPgYJc4x6kz9XuEm0ODZD5k/3vVmDDwUWPd/Iu6Ltp2YN/OCETCNPWH8Do+PV
         KvLi4C3iI9oePblflbiFoSWgSRAum1zMnYNxjPUTPjc3FdcdV2zgEowwTEecg6dhkbBd
         e2C2tiWSy/h7IWsXNTZetQN4S2Wr0ZG/QT4wiegofcC3BHwGj9UdYCoQSf3XIdHSqH+K
         QGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924964; x=1791529764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/++qgKzFBfWPJ7y4nRDznqSG78KTSgC5SSZmS+YUXvo=;
        b=Ad2VvoLe/rv+LWv8OJPDJnflDDPIxvCdvs/vjExK+YIGF9bzFH+hIVS66p4E+rS8Z7
         b5v3h4+P5ohZfgYvqJlHrTtns8CJiBRKX9kc2n3VmAhlXv61mjiEj75YZPYn3mXuv9ez
         0JQTELK51dKXX5ArBBZArtdG+VFjDtVI2IbVjilIgg/MedTDzMAMVblmC4QKGZe95MoL
         a23L8Q1cg4EfshOaHLR5Hc4uM3exVe5Lubozkd1g7OKWksBVN6Yq6ohRfiA2c6nwjfAc
         rgxomg7u8zRzP5PtMvCunQct3Ay1ejOFBy29xPNlO5Xq/uuBL/OqS8/4rHzIo5I1CL+i
         zdZw==
X-Gm-Message-State: AFq9FYKFwwcC/1W8RtNPs8U7BjA3XDfafxEOB+odiIpOnILgmW9WbNuH
	prUuG63yHmk5iXpWgArt4VHx6ggNqNBCgGBC/3kR9CpY824S+ZM2DP1m7t3FVmAF18aoJ4RPYgK
	pj6SpIQ==
X-Gm-Gg: AYBFou29AkgX0cB0r4c4q5v6ZBiUlgK44Zk2HEg/vnMGFAESWbn7OFaIaKefWF0qMJu
	o9Ezsh6/sOx030P8UCKsNxqIroxgd4tgxbWanjJ1i4OwtLLXXhB25lxPg8HjzZ0hfpPY9UCi8EW
	ZZoDSuyIDrWJGOptMhCGfUpxe4moOyEmDZi1NlQtZPRBqiBvcX98Ttl3NxajhHTAgIayJvgwAc/
	Puvh3TIIDUGlwRwM2qCjYtdCsnmI7uxgkU2473qC/2PLLlNfzOq6ga55UQMg8ff06VL218vTF+B
	rjxn78+OtFKegZDanzgsoj1am6pDpj9XGjV9nxL4vP9CM42i8L5zJDaWlQ5K0Hy1iuUgPpgxzyH
	bM4Ib12NpWhXjUKw0LyCBDj866rSnE+I+t1hihT0Yw+UaHJ+K4aIJTdk1L2mhSE+S+JfPeriZuk
	5YuKMnqPd7FPLfocWvyLCTlTI3BwAwcZT2y8wAA6bbE1Vljk5UqoG5TpCFlxrdVRBsjvadB3lu9
	s+AIQa4dX5ddbCYdPI=
X-Received: by 2002:a17:90b:28cc:b0:3a4:a045:27cb with SMTP id 98e67ed59e1d1-3a6cecb20e0mr1115439a91.46.1790924964174;
        Fri, 02 Oct 2026 00:09:24 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd5d88e4sm3051869a91.13.2026.10.02.00.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:09:23 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	sage@newdream.net,
	vega@nebusec.ai,
	Ycsuun@gmail.com,
	weir@nebusec.ai
Subject: [PATCH 1/1] libceph: refresh middle buffers for incoming messages
Date: Fri,  2 Oct 2026 15:09:16 +0800
Message-ID: <20261002070921.2217118-1-weir@nebusec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790813978.git.Ycsuun@gmail.com>
References: <cover.1790813978.git.Ycsuun@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yucan Sun <Ycsuun@gmail.com>

Prepare the middle buffer for each incoming message before receiving its
contents. Reuse existing storage when it remains suitable, and refresh
it when the next message requires a different allocation.

Fixes: bb257664f748 ("ceph: simplify ceph_msg_new")
Cc: stable@vger.kernel.org
Reported-by: VEGA <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yucan Sun <Ycsuun@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 net/ceph/messenger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 212e7797f9e4..35a45380961b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2098,7 +2098,11 @@ int ceph_con_in_msg_alloc(struct ceph_connection *con,
 	}
 	memcpy(&con->in_msg->hdr, hdr, sizeof(*hdr));
 
-	if (middle_len && !con->in_msg->middle) {
+	if (middle_len &&
+	    (!con->in_msg->middle ||
+	     con->in_msg->middle->alloc_len < middle_len)) {
+		ceph_buffer_put(con->in_msg->middle);
+		con->in_msg->middle = NULL;
 		ret = ceph_alloc_middle(con, con->in_msg);
 		if (ret < 0) {
 			ceph_msg_put(con->in_msg);
-- 
2.53.0

