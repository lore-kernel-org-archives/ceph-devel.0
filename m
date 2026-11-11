Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396646;
	b=wDikZZOpi6OkcZumJs4Ysqmvjqkl8M51iUVjH1kOFmdX2MPBIx/mQ26E6AYEiDSD6w3P
	 cw+3QPo8e+iRGWmjdvfdDSr1wBYvSsD7y1bFIdeWrKZnxgPfK63uKFN0aIru9MR7RF7WF
	 KJZ0zEgxzsfgDC6r8Q35pq01ANhh8wYO6hdS+rF67JIcGvdO67pdcTNvp8CFgy4QzpHpA
	 kULXsRRr/59a2eOJpO7+7pCBqu9+P4GTkUxOOyU2NByUKYig6Nec2ZC+DaOW3dBtmmQNa
	 p5YONauZMPuEGq/qQu8QtT0JyfWST6Lm64xBeNG5t4ccuY6Ubtn0suQ1QecWskq+OVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BR3C7X5L79A8iSQFZKFRMc0cQ3J+KtB6+sTRGC/NFlE=;
	b=5qKqwHlo/S+4G/ykH2fmRb/gPsz+AJFLpnTvl8aJlLmzqL/2FgS2D1u1loax0ZzyrEk9
	 x7nkX87EienO3HC4r4F0+poVS8VC6IpZhedlTSDcFpTMURV4zSwqoPugz3vmR663hZA4C
	 faUs7W+v4rk7ozVYJCiM4Lu8OwRcF8+Q5SzeHPqqyeMedheLjMT3DWVpCwQ5IGWNlkU1I
	 Xn0Nxe5jQVqnXXWDOk1U7nEjs6Cu3pytaAgizdEKJ5LJq6YyIBmhwBePKYlJ9vOGUUkWt
	 Suk6NSU1dKwuYxkNjFTh1FhsqhQ3IRBMw64oRcpDQWYQ0/9dIt1UQ6fDjwGFL0BQj0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=ZkHo62if;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4F606A32A
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 11:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7F4F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=ZkHo62if
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-49134c8509fso2525568f8f.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 03:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794396639; x=1795001439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BR3C7X5L79A8iSQFZKFRMc0cQ3J+KtB6+sTRGC/NFlE=;
        b=ZkHo62ifmcuJUtylp4XDkQj48Cq1eIVrNjJUmhzuVRZI4EFKmh6+AdJD4N8fLb4I+q
         QA3oNat9Tf0IX75M0A2qeE3AR8lDGbA+EQ0RTcnfnSJDIJ70j1nQkn7EDfB9LwG+M7hO
         vZQKHWCD+phtyXlyEjrxGdJ/SK3TOrBf+WeKNN+3FwqReLFqU9Ge3AIUFS/rc3nUb7gj
         R0RAwO5jQBasn+CyCpgzeZzF0M5xtUiPtH7QBH+n4qeJhpEkZKtWsEfUPVW5df9JZv13
         vESRig50GhfUGkjaB4Wqh73fFh9wiMsc6wpBP4P+4lw7FbAKVjOKMKcaJir9KBwh9KtD
         jjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794396639; x=1795001439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BR3C7X5L79A8iSQFZKFRMc0cQ3J+KtB6+sTRGC/NFlE=;
        b=pLtS/8etVQqY/Y4jZ0+t5ci3JIcQ+rWdZFHHBLnboQr96NNME007w9ByQPvlTOotGY
         esThAgHl/bDEueMwgFCVg0le5VNSZJ4769FX6QZ/iskaW8rL71cI2Yk2NELp6lMS62GB
         IZDEFLCI60bmcVazBU4IBr37q593foqUbeICoGSNzesbWgFGkGC9tAFjWegW8NfLQut0
         C4c0THX/BKXmMaWrziEMNlW627ySCSLGoVM8mZChljQOqSWLfuTe/JEj5jr+A88zERDD
         RbG+fdMhQlIMq8dBIf7q2qKSk5WeEol4KZk6Tehxw5MlNfcY1baqANM5h80JStNNkFBS
         mtMw==
X-Forwarded-Encrypted: i=1; AL+hErFIDboUHtqX+v6z71R3ZrC93EDfrcw3hBC2023HIYMSuFNwL98+VH/12HHLz/KLMsc0nDR50i2vSQuX@vger.kernel.org
X-Gm-Message-State: APuU4Z8XQaubzrE61IV7LdldTh6AHQJVRFj4ROnl1o4zhWGqrSbWLfp3
	Zy/I1lDHwDwiGlOMv/QGTGQ3ajtzcfCuaZyEhOIzvEN5Ep/W+RVl8pGEOoV6WLBmp7M=
X-Gm-Gg: AYBFou3EKs4LObSOhmBbATRnlM/2pAGh7TNdP/UgJ0cJdi1h9/Bc3B7xadd0jHH5aJ0
	YNgeJftnz9AnV0kB/lYg6thfig0WwDGTI582rE3oEEPR7NJOGP7i9TQhyoGwUCJcK9GaPbuoQco
	4zlySlvxIw6BMhyLlT2yVNzFNG4cL95mrz7FrQYNKlUYpBiF+buJuOx7/y5YekYb8NVeCQ/eVyP
	NMXwUXPWfIsoL3z2Clq9YFMa7PcbNe7hGu5TdtTEpjVecsCJlRzOJMQMrXMFQhspW9FdCq8smah
	u4L21nnEBDuZTG2/bG5b8GcSiLuUVGfwKCJ2LEjAUau61VMtwJbqlSaUSpT2w6r+GLQk2Bi7ArX
	M5onaLV0RsbTXorCPjzKKf2yE/3+NA2s8UKLOOsRgYEBYjV6oEnJbYkdTaU4XvgibeGr7YIMMFR
	2aaXkXA24ltd6jRMJWanuYvXSjQaYCAWbviMMvsM0Mgbtq0lMm89Dyt5te8b9ZHBCZ5P/gEDZqn
	dPuFb780hBedcLDcQlQ/A0k5V1PfryO68RtpZZBHnx/Y8G1b2nn7w4v5k5ZHaigDorAjtbohIkV
	fWJ3HkvWyNPQ7hOCgwTQ4HIw1lvVA2Z/rOMIcRLJHPqmxvkKMjEil9BNk1EkbBNjA0X0vaJ/AgN
	l7Fce3HxnLlTfqmZpkqa3qIMZPOxRPk4=
X-Received: by 2002:a05:6000:4008:b0:48e:fdd:41d9 with SMTP id ffacd0b85a97d-499c6e979camr3766412f8f.31.1794396638819;
        Wed, 11 Nov 2026 03:30:38 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498357648f0sm10959991f8f.12.2026.11.11.03.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:30:38 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] ceph: fix d_lock leak in debugfs mdsc_show()
Date: Wed, 11 Nov 2026 12:30:29 +0100
Message-ID: <20261111113029.959595-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mdsc_show() walks the request tree under `mdsc->mutex` and prints the
request's dentries like this:

  spin_lock(&req->r_old_dentry->d_lock);
  seq_printf(...);
  spin_unlock(&req->r_old_dentry->d_lock);

(same for `r_dentry`).  The pointer is loaded again for the
unlock, but ceph_fill_trace() can change it in the meantime:
ceph_fill_trace() runs with req->r_fill_mutex held, but not
mdsc->mutex, and:

- after d_move() for a rename, it swaps `r_dentry` and `r_old_dentry`
- splice_dentry() replaces `r_dentry` with the spliced alias and drops
  the request's reference to the old dentry
- a lookup without a locked parent assigns a new `r_dentry`

If an unsafe rename reply is being processed while mdsc_show() is
between spin_lock() and spin_unlock(), mdsc_show() unlocks the other
dentry, and the `d_lock` of the one it locked is never released.  The
next attempt to lock it spins forever.  I have seen this on a
production server, where our monitoring reads the debugfs "mdsc" file
periodically:

 watchdog: BUG: soft lockup - CPU#67 stuck for 48s! [kworker/67:2:3746175]
 Workqueue: ceph-msgr ceph_con_workfn
 RIP: 0010:queued_spin_lock_slowpath+0x4a/0x240
 Call Trace:
  <TASK>
  ceph_fill_trace+0x7a4/0x910
  mds_dispatch+0x9f4/0x1ac0
  ceph_con_process_message+0x66/0x80
  ceph_con_v1_try_read+0x392/0x17e0
  ceph_con_workfn+0x329/0x590
  process_one_work+0x146/0x2b0
  worker_thread+0x182/0x2f0
  kthread+0xe4/0x1d0

 watchdog: BUG: soft lockup - CPU#55 stuck for 49s! [cm4all-kernel-e:16346]
 RIP: 0010:queued_spin_lock_slowpath+0x1a2/0x240
 Call Trace:
  <TASK>
  lockref_get+0x47/0x60
  ceph_mdsc_build_path.part.0+0x85/0x2a0
  mdsc_show+0x239/0x3e0
  seq_read_iter+0x11f/0x480
  seq_read+0xfd/0x130
  full_proxy_read+0x50/0x80
  vfs_read+0xa4/0x340

Both CPUs were waiting for the `d_lock` of the same dentry, which
nobody is locked but nobody will unlock it.  The first CPU was in
update_dentry_lease(), called after the rename swap.  The second one
was the next read of the debugfs file.  Since the ceph-msgr worker was
blocked, all requests to that MDS hung.

Replacing `r_dentry` with a spliced alias also means mdsc_show() can
call dget() on a dentry whose last reference has just been dropped.

Fix this by holding `r_fill_mutex` while mdsc_show() uses `r_dentry`
and `r_old_dentry`.  Taking r_fill_mutex with mdsc->mutex held is the
established lock order; __do_request(), handle_forward(),
ceph_mdsc_wait_request() and ceph_lock_wait_for_completion() do the
same.

Fixes: 76aa844d5b2f ("ceph: debugfs")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/debugfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index 6a9a5551d9d7..83506d9207fa 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -109,6 +109,14 @@ static int mdsc_show(struct seq_file *s, void *p)
 		else
 			seq_puts(s, "\t");
 
+		/*
+		 * ceph_fill_trace() may replace r_dentry (dropping the
+		 * request's reference to the old one) or swap r_dentry
+		 * and r_old_dentry; it does so while holding
+		 * r_fill_mutex, so hold it while using them.
+		 */
+		mutex_lock(&req->r_fill_mutex);
+
 		if (req->r_inode) {
 			seq_printf(s, " #%llx", ceph_ino(req->r_inode));
 		} else if (req->r_dentry) {
@@ -151,6 +159,8 @@ static int mdsc_show(struct seq_file *s, void *p)
 				seq_printf(s, " %s", req->r_path2);
 		}
 
+		mutex_unlock(&req->r_fill_mutex);
+
 		seq_puts(s, "\n");
 	}
 	mutex_unlock(&mdsc->mutex);
-- 
2.53.0

