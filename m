Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DD1389111
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373578; cv=none; b=Wb04s2aH5m4i/AJerU1fskVSv3ulXhS3qUb9BdzwPJ57hGLjzBOqMi7uRG5ncNZHR8QmlsCxtA8SdNDaLDLFVX6uJmBE/fSvYBj4fGK6I8TT1pMeFd/ZDBfX0t5odWGufHf1xw0AV9E2rvhytylX6bthrBqTN4rcFug4kHsc7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373578; c=relaxed/simple;
	bh=16AGre52KACjglOSOHDbwZevBxBcMvBm/jrl3Aup3LU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JjAACN1TvvNo/3+iXB3p9AZWCfB4yHfGSIh8w0CUB/fcm6sVXrwar1ZT93XXUZinyrkNh1aBsg+Ll0OG6RPkWpA5yMwzepN/vbT3wE5nfXj78oxqGjIq3yoXlXCZgDTFvM0b6U2Wpu/xxu7rSWiY5LqctbjQChv8hHckXCvUZcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=rzLAl/Sz; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="rzLAl/Sz"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-806449d108aso51430877b3.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 14:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783373576; x=1783978376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H1HHG2kvBFgZpT+6uTuenonFTOapf3Lmxw4GWhzyxu0=;
        b=rzLAl/SzdcHt8rNwgDqeh1oP+ah1Hhv77sGRAyS3lGibTXwP+4ROpa93K1NuLOel/z
         XoKyiVB32zoTQRMwDL4N6OYVUjFn6K0TB3V2HABV4vjVMyZ6KiZaQe7aTqM32qmoBsOy
         wf9fWIMCRjXfraEjXTX1pPNzVmtVA/Q/vxKlT8WecRw+C2PQ9b0hOMWUSMAOOaEw+dpc
         LWa3nMR+AsPYornpRTf1zWn9MyLFxSFHRJ4rCmUfvp6MBkjfncgvfdQY5booQoIqtJ27
         zLNVO9+1LeHyYasMMDkhYGwzgMG69Z/shhNhcQ8NQWLnXGS4adYE6/koA98s+Apdb6bA
         nmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373576; x=1783978376;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H1HHG2kvBFgZpT+6uTuenonFTOapf3Lmxw4GWhzyxu0=;
        b=ibwCWLQ+GxHXX2qBm/5y989WKY8GrbeQ0rQaRBiIxK/vA06sYic+GwmY3O+qWOudzz
         9swnbPVphewg8OvRIIfEvvjivIdRJdhD7wztC1QxbKgpWP3pCExgXlwU6fLFaTDJ1DrU
         IHdiytnN6rLnMhyifgG2+LdNEaWUn8zAZELfA/l6G9z1MsvWGROBKRWgljhc2BYOY34i
         vVNiyXjJ0NYMZYJPP5cMUpGd9m/JvXuLxJfT7R//UX+ZYeqos7CB48SynyEaeYHsjEsg
         HwtKlcsAMsn3sSV0c3/d2v9WR71XuEwomxrer9oGuWltC3ZxG4DhJ1OTrv/tphjkRUqa
         mrhQ==
X-Gm-Message-State: AOJu0Yyq9xTHm7TCjGcskyOceMB5OhKOQOLmndbHxHNqa64P3m959Do0
	lbk5pkU3NqztrCab9gwOm4/T8231HN7aw7+BsQRk9nIPip6EbhtpkkrJigLvg8btcfd8a8q6Vfq
	Ju+Zuh9c=
X-Gm-Gg: AfdE7cnXZN6IWofaevXQbr+26mU46fr+0rAEATow0yRRcxvedUo2qc9PPNeaSu0o+Jb
	hxXcucRKoBW15oqTOVURprKDx8msADImfE/T8Y5lChvZldXlHVwVzw6yefcjjc6hSYdwfhp6dgP
	kGk4WZ52f2U1H+3tnZD6S3lRcq1qp1RcYYYe2bu5AM1VgoakdiZoHbJOlRaT4T0qvZ25wZ4AFDv
	cH/17FP/oY2tQ7SWOeKyBfZ3UnwQ2G5pzpO/B6E4jPqEFUwIFQMcbe7AOAWOVc9Ngw6KW2gFXYZ
	v7DZDofRSHKKSI/fQAcJZB6BeF/v5Z+UBtQxACcqXpFfbfr9Urmy32OE2qq5A607dRT/YwfQnXP
	xvgPdblc6jgLK6L/3PJjKR1EffMztvTRzeJ3NY5ysilLwaujqWW3vyytGIiWqj9L6uGy1TDqr3m
	2OZqODEhjBNZ/NY5HNybEI/yQYR5KptUb5k3jTX64fUY2KLdpCa6uaP36OMORJ1SqG5UjlF05V0
	1NCpg+ZggkAejuao32ofBBZ5b2wGR0Hr/g3j0+uLs7ZWcO9sPYr
X-Received: by 2002:a05:690c:6103:b0:806:5a1c:d892 with SMTP id 00721157ae682-81be2a74bd5mr18588587b3.47.1783373576120;
        Mon, 06 Jul 2026 14:32:56 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:fc23:ea94:e881:d8a4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81448dd0217sm62647927b3.22.2026.07.06.14.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 14:32:55 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	vdubeyko@redhat.com,
	sagemct@ibm.com
Subject: [PATCH v2] ceph: fix denial of service issue in ceph_update_snap_trace()
Date: Mon,  6 Jul 2026 14:32:41 -0700
Message-ID: <20260706213240.139919-2-slava@dubeyko.com>
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

A WARN_ON() fires inside ceph_update_snap_trace() when the client
receives a malformed snap trace from the MDS. The kernel additionally
logs:

ceph_update_snap_trace do remount to continue after corrupted snaptrace is fixed

indicating the client cannot recover the snap state and forces
the operator to remount the filesystem. Triggered with the call chain
reaching the warn from ceph_con_process_message() -> mds_dispatch()
-> ceph_update_snap_trace(). Impact: denial of service of the affected
mount until remount; the client refuses further snap-related operations
after the warn, so any open file in a snap-realm becomes unusable.

[  230.026879] WARNING: fs/ceph/snap.c:926 at ceph_update_snap_trace+0x308/0x3300, CPU#1: kworker/1:1/58
[  230.028125] Modules linked in:
[  230.028427] CPU: 1 UID: 0 PID: 58 Comm: kworker/1:1 Not tainted 6.19.0-g44331bd6a610-dirty #9 PREEMPT(lazy)
[  230.029089] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[  230.029815] Workqueue: ceph-msgr ceph_con_workfn
[  230.030177] RIP: 0010:ceph_update_snap_trace+0x31c/0x3300
[  230.030550] Code: fa 48 c1 ea 03 80 3c 02 00 0f 85 23 26 00 00 48 8d 3d 28 d2 3a 05 48 8b 73 28 49 89 e9 4d 89 e8 4c 89 f1 48 c7 c2 40 40 8e 9e <67> 48 0f b9 3a e8 3a 7c db fe 48 b8 00 00 00 00 00 fc ff df 4d 8d
[  230.031708] RSP: 0018:ffffc900003f7728 EFLAGS: 00010246
[  230.032084] RAX: dffffc0000000000 RBX: ffff88812282d000 RCX: ffffffff9e8e3b40
[  230.032533] RDX: ffffffff9e8e4040 RSI: 0000000000016f97 RDI: ffffffffa087e7d0
[  230.033008] RBP: ffffffff9e8e3c00 R08: ffffffff9e8e3b40 R09: ffffffff9e8e3c00
[  230.033460] R10: 00000000fffffffb R11: ffff888102928040 R12: ffff88811031a3e0
[  230.033937] R13: ffffffff9e8e3b40 R14: ffffffff9e8e3b40 R15: 1ffff9200007eefd
[  230.034401] FS:  0000000000000000(0000) GS:ffff888254a05000(0000) knlGS:0000000000000000
[  230.034941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  230.035315] CR2: 00007f7efa7be740 CR3: 000000012435c000 CR4: 0000000000750ef0
[  230.035803] PKRU: 55555554
[  230.036001] Call Trace:
[  230.036175]  <TASK>
[  230.036342]  ? mds_dispatch+0x1ceb/0x6f60
[  230.036645]  ? __pfx___might_resched+0x10/0x10
[  230.037010]  ? iget5_locked+0x44/0xb0
[  230.037316]  ? __pfx_ceph_update_snap_trace+0x10/0x10
[  230.037670]  ? __pfx_down_write+0x10/0x10
[  230.038005]  mds_dispatch+0x1dd1/0x6f60
[  230.038306]  ? ceph_con_process_message+0x1ab/0x270
[  230.039024]  ? lock_release+0xc7/0x270
[  230.039321]  ? __pfx_mds_dispatch+0x10/0x10
[  230.039622]  ? __local_bh_enable_ip+0xa1/0x110
[  230.039992]  ceph_con_process_message+0x1f4/0x270
--
[  321.986495] libceph: failed to decode MOSDOpReply for tid 9: -22
[  330.121991] ------------[ cut here ]------------

The error path in ceph_update_snap_trace() is reached whenever snap trace
decoding fails. The two entry points are:
(1) bad — a ceph_decode_need() macro fails when the encoded snap trace does not
contain enough bytes for the declared number of snaps or prior-parent snaps.
(2) fail — reached directly from -ENOMEM returns (ceph_create_snap_realm(),
dup_array(), adjust_snap_realm_parent()).

This patch fixes the issue by changing WARN(1, ...) on
pr_warn_ratelimited_client().

Fixes: a68e564adcaa ("ceph: blocklist the kclient when receiving corrupted snap trace")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/snap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 9b79a5eaca93..e5d8d59ffc17 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -923,11 +923,11 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 		pr_err_client(cl, "failed to blocklist %s: %d\n",
 			      ceph_pr_addr(&client->msgr.inst.addr), ret);
 
-	WARN(1, "[client.%lld] %s %s%sdo remount to continue%s",
-	     client->monc.auth->global_id, __func__,
-	     ret ? "" : ceph_pr_addr(&client->msgr.inst.addr),
-	     ret ? "" : " was blocklisted, ",
-	     err == -EIO ? " after corrupted snaptrace is fixed" : "");
+	pr_warn_ratelimited_client(cl, "%s %s%sdo remount to continue%s",
+			    __func__,
+			    ret ? "" : ceph_pr_addr(&client->msgr.inst.addr),
+			    ret ? "" : " was blocklisted, ",
+			    err == -EIO ? " after corrupted snaptrace is fixed" : "");
 
 	return err;
 }
-- 
2.54.0

