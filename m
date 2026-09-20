Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99A3F6C3B
	for <ceph-devel@vger.kernel.org>; Sun, 20 Sep 2026 11:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789905226; cv=none; b=ECHvfVNsmSIJvYvdqhZug2JgLn7Gf2GcQYSPpGUIwuOmD7iAiRMuB36dNp0yKI7hK3hM9DPajSwS1jAxLU2dcx7Pz/32La5Xg2Zy+2gLC9phSLe1UmJzd5jMiSOFdfbnz/CLndWGU08jXFN5gYdiTxCVotlRJSSqNGmCw2Un7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789905226; c=relaxed/simple;
	bh=EdvgcP4aHZc8haPwmoIl6H1B9OiogdwgeO18M9WYPaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWkNlzuuGVL3H8wfNAb5GK3zCltdT7wEK58KQYJTOYrYGmpL4KlJJlBR+U281nJ/62Uy6t9KNq0okDw2+qq3eHc2bvrKyUm67UryZM8ujoDJIu5+ZksDBL+Co0iavlBO0KgUDKDW5/1twIB74hQcP9kN0qgVFhqMUoaUwER7SkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJ/lIkJ3; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJ/lIkJ3"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccda24afso1543678a91.3
        for <ceph-devel@vger.kernel.org>; Sun, 20 Sep 2026 04:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789905221; x=1790510021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oWY25NeFXFYHw+xb7xVpN+y7ofPMo41LdHxDaElxJf8=;
        b=BJ/lIkJ3AYOwFIZD7yeT+bs3Mif8lQbppMOXA1fSTQtouoCuVDD6llZ8XDZqb9shVq
         9jgdD1k2ENb97iLrlnUtKiwkGcmPLg5eT3JpqbGBptGo/qOH5xQKgtHA9gLCuMyEx4u2
         YhyL0/kN+cTMLks8b/aFt8wtyVVqTng3EbaeutiMN9B4/o43Q1ub4u4JDHWc/A4dbUdH
         pkYlkZ4JJdXB/6wtbtEbBbjhAmVthKu+cNaR8pEsOUC/wYkW/89Se76+z3K1JAFceGla
         YWrYpIEM9qXDtvSISl4j2ppL738NAPQOgvzm2jc3D2nfVxEv1X0qsizLRFhMlNE4URte
         /fAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789905221; x=1790510021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oWY25NeFXFYHw+xb7xVpN+y7ofPMo41LdHxDaElxJf8=;
        b=W8NcLsV89S8ONolgroc1EIZpphAuh4IaNXfixlX2mNp2AXgwvGHNMcFvfVGU30+J4f
         9c3qlkVh4I9bqiD3jSQZWLAeYSWbsqRfUH53u2knociA5qZnuBelfHaXNLAp+U/tlqWS
         Eo+O8Pvy/7eSQRINfYRYsR/e4IzV79edP5iJLhRJQRLa8KzKeeQG7q9gopKtJPvRtoRd
         fDu5GBj2BF8mEVaLl3BEgl0hjhOWHZRa76cSIivAIHfxZoWuuwJxnmx8IUqBI9rjaFeK
         74SPM0divc0/65L1Gq0/nyKs8bbMs8MSeA/0KWrRlnwiKPT/4avrnuA6vP68i0+TMIet
         kf7Q==
X-Gm-Message-State: AFuF++nIBKwai7foehHUVlvYy3nO4F0KHqFJfp7SVZcpsJLmtu9EU2qu
	OiC443FArZg+ecf1xnHIoorladMsYljX9RaXENTpMNrVYmpRj4HNl0Sl
X-Gm-Gg: AYBFou0WYxd/g15MfeFbf4R+25faMEzWNPjRvMwEuaJ3pfy6oPmcGIrOfCtE4Roj4M8
	DBJ5VZji9qc7YShsh6Xf2o+2X81J/LCOyXqQuHlZdCjBFaG+OBjm3J5PHXw87Tpy2M3w7s7J87t
	ERy4KGmOfg/Z6GYaQRoV7iGyPfheDx/m4PrHOGOrmAVzNWrKr1g5xiCVVp0cJNYnfbwPdNRRlPY
	LirLn5GlcLheAXvJy2UZEP6xHy5AkOECGcULONpMUs5imDnk7gOeYsWS+u8HPQognueSe6bCzwo
	oEogfmbt0aFKNjcRkSM6RUUYONAN5SMpwgY1sCRa0gRt5yVbOhhWf1b5OsBZh1VO9nvt3vGyvmZ
	Cmjey+Cg4PLKcckC9JHbzPn9th/pYrqeQHp79wu4IsB/3DcP/bqjE8YXpg7ulZkJEDdc6C55gW5
	g1xhIrejNjrJ1OcMKVtQuylDnFWdzVaR0iRXjGA7BkoMfy18rE2jQ66HbPUKNeM3Z41r4jAzD57
	J3gvcIHtKv/2Go=
X-Received: by 2002:a17:90b:4fcf:b0:39e:6c68:1550 with SMTP id 98e67ed59e1d1-39e6c6832d7mr8193562a91.24.1789905221398;
        Sun, 20 Sep 2026 04:53:41 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:2022:c2a9:de8:d005])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm8537927a91.0.2026.09.20.04.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 04:53:40 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	syzbot+21f8628595b2061c438d@syzkaller.appspotmail.com
Subject: [PATCH] libceph: reject bad connect_seq in msgr1 READY reply
Date: Sun, 20 Sep 2026 18:53:34 +0700
Message-ID: <20260920115334.16219-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

process_connect() WARN_ON()s when the peer's READY/SEQ reply carries a
connect_seq other than ours + 1. That value comes off the wire, so a
misbehaving or malicious server can trigger the warning at will (and
panic machines running with panic_on_warn).

Check it before touching connection state and fail the connection with
a protocol error instead, like the other bad-reply cases here.

Reported-by: syzbot+21f8628595b2061c438d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=21f8628595b2061c438d
Fixes: 31b8006e10a4 ("ceph: messenger library")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 net/ceph/messenger_v1.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index c9e002d96319..b3ff3274344e 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -887,6 +887,12 @@ static int process_connect(struct ceph_connection *con)
 			return -1;
 		}
 
+		if (le32_to_cpu(con->v1.in_reply.connect_seq) !=
+		    con->v1.connect_seq + 1) {
+			con->error_msg = "protocol error, bad connect_seq";
+			return -1;
+		}
+
 		WARN_ON(con->state != CEPH_CON_S_V1_CONNECT_MSG);
 		con->state = CEPH_CON_S_OPEN;
 		con->v1.auth_retry = 0;    /* we authenticated; clear flag */
@@ -898,8 +904,6 @@ static int process_connect(struct ceph_connection *con)
 		     con->v1.peer_global_seq,
 		     le32_to_cpu(con->v1.in_reply.connect_seq),
 		     con->v1.connect_seq);
-		WARN_ON(con->v1.connect_seq !=
-			le32_to_cpu(con->v1.in_reply.connect_seq));
 
 		if (con->v1.in_reply.flags & CEPH_MSG_CONNECT_LOSSY)
 			ceph_con_flag_set(con, CEPH_CON_F_LOSSYTX);
-- 
2.43.0

