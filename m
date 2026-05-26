Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9EE3C98B7
	for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835132; cv=none; b=bbyPz0iLoNcVu0T3RbvZYWVrO1Ei76BRgno+jeNRimNBMW2Nd89a3/kbI1XeupoNMXBN4yVIVrpSqt7TyFTkjj/Z+LZClQX/8pNh3CGxQTcRpOT5X359afT2XRsrqKKJpgUgdD4/tXrqP7/BxGPoB95kdAgNiGE4HGEj0sMbhH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835132; c=relaxed/simple;
	bh=PEOnU1euQksNTBNEpTVO434Z1jfRAyw8+p3ekYQ4Oqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GKfe1Ha75BiAWurYnAoNjuly10msXSUDDjZyBafmUvB682I2A1HbEjOH3PTLssCrGIU0fWR9oUmlQV4CXEJHPAwP00O45b5y4YNocLVKeFrPBx+wEfvAT4wxF7UvuZD8LodbvQuPcsqWThlwBcpjBdxipIKYMMsKiWgFGjzJmxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=PWmWm9wE; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="PWmWm9wE"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcdaf06498so7233173a34.2
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2026 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1779835128; x=1780439928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAedWjqG73p0z+Bcksz0PqqemyZWbohHadUN5qn1TcQ=;
        b=PWmWm9wEoVFsdRQPQCkctiZEsCgafhee+yu4qVk0vCj8tw0aps0E8AWmTKytSV2fOC
         W3nvQjPm2ZynWyL2LPPoqk3faf3rzsNi41m7EgpUxPkFQAPr2PCbNgdNE4IAzxsS6DjH
         US6A2lq2zF35p1SvlbbMsKV1SOKt2wiLuHAXOiLGmIDvdsrZam5R7BylE19lcI+5LFeI
         4/ZL/7CwGeth3BLto8SHnoHfKfT0EBXIinPrKmcEF1VuV9bCUJ0xHQRgWxIgt6vKMx7C
         0sqtcR21kgO1C6Qxk9qNZ3Sn39pmh7otZ5P/3+qFdc+8yUkVeRx6dBr3L27JgZQ/GRdF
         GjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779835128; x=1780439928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAedWjqG73p0z+Bcksz0PqqemyZWbohHadUN5qn1TcQ=;
        b=tCiL1HcLlFTlofoIo6AX0m2UOH/xzzuQQWSAvmotdPsVfgR3A+ApNf6qz4vwADDCxS
         ymii9NQly5IrDV0f8gKG5BYGYAmaEqovo3st9i8gAdL1Q+pPo7w+68y9YvoCKXrPmN9h
         zCXB0iLRyMZyeQQ6815pLjzJpZkAd9vqNr1VszKbpYG3GkXDloRsHOT7tNdiGxcUaHLM
         rfWP/G+SP4yJs1KO36HCrNgPGECm9Y+FHXjiA5X3cEkv9rU4tiVwEdxW9Xv5MIFTXUlv
         0kYb0jxldFzU4ZFMLdlJuWd+/QSImgVAOa0SndHjvZx828/s/gA3JfPireqOXvMYDOjj
         kBZQ==
X-Gm-Message-State: AOJu0YxFHGPv+kMUBxozCiJyd2iB3n83sx1tLLTV+ZNHlhOS0PrSLttD
	8NCFLtnOgvSrsA+4wjGJojapKy49d5vvBo9Q+NeAHoAoqHPIWTBcGVSYJZcCLQIoLRJWZzIiT9a
	2bJ4g6Zo=
X-Gm-Gg: Acq92OEcvMfqr+734b5q8nLGnDA29Qy2SaLzXTMxZFL/trMQNVnyGas4OEKrvRg+Pi5
	75Ge1XagRw5mSOilQ2htEyQIHLUba49QGcFJf0Okl8PWuCkrAk/djPLz0BZOxF47jBFYidL0Icd
	cDMag2rzptx8+unV4Zn+2KmE05HCxR41WavossXgdxFF2gVNeP8/KFVpGd/QRCTkGz5gBeiNh/2
	Cl3Vt/aN/RJsqblRSEih0CxNk4wk5w7PCsFEEd1fQXijLM4iFlZX3tqCD0EojB6gu5rT0/B7ck4
	ckW+VxpBEyzfOAKtSzT9RsVieOYWW2biJ7k/ka+YwllvHPqY8bH1palTZsEN3TdtFSgA8sG+lY6
	IHYlWUyJFlFd5+ULcl5bwAo2uUEBCKLk2CokJd3MpLlYjl+kOJLqQFJA6EZ9Bd6IPhobxlQEvRV
	oJEj+/p9gCQlO7MMFE5XR3KmaBGh+UWaQlAffZW/aQ78ccj/Eg1ZDW4+9iT8ZbubPhbRIlC74Re
	Ct7n4FnYhMssWeHboArG8qvQym4Nfw=
X-Received: by 2002:a05:6830:6482:b0:7dc:d587:af3 with SMTP id 46e09a7af769-7e5ff08ccf4mr12142890a34.23.1779835127937;
        Tue, 26 May 2026 15:38:47 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:c597:e624:3ba8:752c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6065e5ed1sm11150345a34.14.2026.05.26.15.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 15:38:47 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	sagemct@ibm.com
Subject: [PATCH] libceph: rework behavior for not recognized tag codes
Date: Tue, 26 May 2026 15:38:30 -0700
Message-ID: <20260526223829.1385751-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

[  196.609307] WARNING: net/ceph/messenger_v1.c:901 at ceph_con_v1_try_read+0x4e0f/0x6020, CPU#6: kworker/6:0/49
[  196.612062] Modules linked in:
[  196.613111] CPU: 6 UID: 0 PID: 49 Comm: kworker/6:0 Not tainted 6.19.0-g990dca9c3b7a-dirty #47 PREEMPT(lazy)
[  196.615707] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[  196.618102] Workqueue: ceph-msgr ceph_con_workfn
[  196.619417] RIP: 0010:ceph_con_v1_try_read+0x4e0f/0x6020
[  196.620919] Code: 85 a9 fc 90 0f 0b e8 c0 85 a9 fc 90 0f 0b 90 e9 c4 e0 ff ff e8 b2 85 a9 fc 90 0f 0b e8 aa 85 a9 fc 90 0f 0b e8 a2 85 a9 fc 90 <0f> 0b 90 e9 2b e2 ff ff e8 94 85 a9 fc 90 0f 0b 48 8b 3c 24 e8 68
[  196.625686] RSP: 0018:ff11000100e4fa30 EFLAGS: 00010293
[  196.627142] RAX: 0000000000000000 RBX: 000000000000001d RCX: ffffffff9eb8ba8e
[  196.629041] RDX: ff11000100e04480 RSI: 000000000000001d RDI: 0000000000000004
[  196.630938] RBP: 0000000075184a6c R08: 0000000000000001 R09: 0000000000000001
[  196.632874] R10: 0000000075184a6c R11: ff11000100e04480 R12: 000000000000000d
[  196.634763] R13: ff1100012698a533 R14: ff1100012698a0b8 R15: 0000000000000000
[  196.636667] FS:  0000000000000000(0000) GS:ff1100040bc00000(0000) knlGS:0000000000000000
[  196.638807] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  196.640390] CR2: 00007f3f19a5f3b0 CR3: 00000003408a8006 CR4: 0000000000771ef0
[  196.642293] PKRU: 55555554
[  196.643105] Call Trace:
[  196.643782]  <TASK>
[  196.644481]  ? register_lock_class+0x41/0x760
[  196.645739]  ? srso_alias_return_thunk+0x5/0xfbef5
[  196.647303]  ? srso_alias_return_thunk+0x5/0xfbef5
[  196.648896]  ? __pfx___mutex_lock+0x10/0x10
[  196.649986]  ? __lock_acquire+0x466/0x2260
[  196.650770]  ? __pfx_ceph_con_v1_try_read+0x10/0x10
[  196.651784]  ceph_con_workfn+0xa26/0x1340
[  196.652617]  process_one_work+0x8fc/0x1990
[  196.653496]  ? __pfx_process_one_work+0x10/0x10
[  196.654430]  ? srso_alias_return_thunk+0x5/0xfbef5
[  196.655393]  ? lock_is_held_type+0x8f/0x100
[  196.656260]  ? srso_alias_return_thunk+0x5/0xfbef5
[  196.657229]  worker_thread+0x6d3/0xf20
[  196.658062]  ? __pfx_worker_thread+0x10/0x10
[  196.658904]  kthread+0x37d/0x490
[  196.659590]  ? lockdep_hardirqs_on_prepare+0xea/0x1a0
[  196.660573]  ? __pfx_kthread+0x10/0x10
[  196.661370]  ret_from_fork+0x67b/0xad0
[  196.662167]  ? __pfx_ret_from_fork+0x10/0x10
[  196.663059]  ? srso_alias_return_thunk+0x5/0xfbef5
[  196.664008]  ? __switch_to+0x7a0/0x10c0
[  196.664751]  ? __pfx_kthread+0x10/0x10
[  196.665547]  ret_from_fork_asm+0x1a/0x30
[  196.666389]  </TASK>
[  196.666822] irq event stamp: 9881
[  196.667490] hardirqs last  enabled at (9891): [<ffffffff9b40a7db>] __up_console_sem+0x7b/0x90
[  196.669088] hardirqs last disabled at (9900): [<ffffffff9b40a7c0>] __up_console_sem+0x60/0x90
[  196.670667] softirqs last  enabled at (9664): [<ffffffff9b267a34>] __irq_exit_rcu+0xc4/0x100
[  196.672258] softirqs last disabled at (9641): [<ffffffff9b267a34>] __irq_exit_rcu+0xc4/0x100
[  196.673711] ---[ end trace 0000000000000000 ]---
[  197.154025] libceph: mon0 (1)10.0.0.2:6789 socket closed (con state OPEN)
[  197.155329] libceph: mon0 (1)10.0.0.2:6789 session lost, hunting for new mon
[  197.158745] libceph: mon0 (1)10.0.0.2:6789 socket closed (con state V1_BANNER)

First issue:

After the client and server complete the v1 handshake and the server's reply
tag is CEPH_MSGR_TAG_READY or CEPH_MSGR_TAG_SEQ, the client increments its
own connect_seq and then checks that the server echoed back the same value.
The con->v1.in_reply.connect_seq comes directly from the network —
the server's connect reply message. A MITM who corrupts even one byte of
that field produces a mismatch.

Using WARN_ON() on a value that comes from the wire means an attacker controls
whether the kernel warning fires, giving them the ability to permanently taint
the kernel (TAINT_WARN). WARN_ON() does not affect control flow — after the
warning, the code continues and opens the connection as if everything were fine,
with an inconsistent connect_seq.

The second issue:

The bad_tag is reached when the first byte of a new msgr-v1 frame is not one of
the four recognised tag values (CEPH_MSGR_TAG_MSG, ACK, KEEPALIVE2_ACK, CLOSE).
Any single-byte value 0–255 except those four reaches bad_tag. An attacker who
can flood system log with error messages.

This patch compares con->v1.connect_seq and con->v1.in_reply.connect_seq.
If they are not the same, then pr_err_ratelimited() will be called
instead of WARN_ON(). The second fix exchanges pr_err() on
pr_err_ratelimited() for the case of bad tag in ceph_con_v1_try_read().

Fixes: a56dd9bf4722 ("libceph: move msgr1 protocol specific fields to its own struct")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 net/ceph/messenger_v1.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/ceph/messenger_v1.c b/net/ceph/messenger_v1.c
index c9e002d96319..5b2b68220e88 100644
--- a/net/ceph/messenger_v1.c
+++ b/net/ceph/messenger_v1.c
@@ -742,6 +742,7 @@ static int process_connect(struct ceph_connection *con)
 	u64 sup_feat = from_msgr(con->msgr)->supported_features;
 	u64 req_feat = from_msgr(con->msgr)->required_features;
 	u64 server_feat = le64_to_cpu(con->v1.in_reply.features);
+	u32 connect_seq;
 	int ret;
 
 	dout("process_connect on %p tag %d\n", con, con->v1.in_tag);
@@ -894,12 +895,15 @@ static int process_connect(struct ceph_connection *con)
 			le32_to_cpu(con->v1.in_reply.global_seq);
 		con->v1.connect_seq++;
 		con->peer_features = server_feat;
+		connect_seq = le32_to_cpu(con->v1.in_reply.connect_seq);
 		dout("process_connect got READY gseq %d cseq %d (%d)\n",
-		     con->v1.peer_global_seq,
-		     le32_to_cpu(con->v1.in_reply.connect_seq),
-		     con->v1.connect_seq);
-		WARN_ON(con->v1.connect_seq !=
-			le32_to_cpu(con->v1.in_reply.connect_seq));
+		     con->v1.peer_global_seq, connect_seq, con->v1.connect_seq);
+		if (con->v1.connect_seq != connect_seq) {
+			pr_err_ratelimited("connect_seq mismatch: my %u peer %u\n",
+					   con->v1.connect_seq, connect_seq);
+			con->error_msg = "protocol error, connect_seq mismatch";
+			return -1;
+		}
 
 		if (con->v1.in_reply.flags & CEPH_MSG_CONNECT_LOSSY)
 			ceph_con_flag_set(con, CEPH_CON_F_LOSSYTX);
@@ -1456,7 +1460,7 @@ int ceph_con_v1_try_read(struct ceph_connection *con)
 	return ret;
 
 bad_tag:
-	pr_err("try_read bad tag %d\n", con->v1.in_tag);
+	pr_err_ratelimited("try_read bad tag %d\n", con->v1.in_tag);
 	con->error_msg = "protocol error, garbage tag";
 	ret = -1;
 	goto out;
-- 
2.54.0

