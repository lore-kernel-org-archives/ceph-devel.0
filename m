Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BC937C930
	for <ceph-devel@vger.kernel.org>; Wed, 20 May 2026 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313640; cv=none; b=WbT29c3kfR+zQn+G3xbDQd/5iWwnA0IRSiTh3PdaQ3wq9IxDDQOkzK2aF2GPgRv+kTGivJ32eo7noTpfLssWUPdCPFzzs0qj3OZJVGJaiPBf/nBZzvajq+D8vVNiuyyrE8/1BMpwYXSmTNVRxFyWgtUnEXysmlv+cRz39+V4Pr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313640; c=relaxed/simple;
	bh=NKs8ioIT4GNOLloiVcuQ7wCdXkO1syOO3P0T4A9XlZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S6Oo5rJjSZucl77Iyyjh4UW2HRGEZNoR3GTwU0qezNo5Fw0iuP8+gbKPdSFl5am8GYALDKKovFtNK2+p7gGg91+Kk5wXTORh9/a4ZwsA/uj2Y6Uz4YmU4PK/NdRc7N7/lkRqlIYu44+dLKqkx0z7OU3W+x8mGTATxhXaKcdDqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=AN6lMSIJ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="AN6lMSIJ"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7b37d84a6b3so48665347b3.2
        for <ceph-devel@vger.kernel.org>; Wed, 20 May 2026 14:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1779313638; x=1779918438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cEeOx8/xhFZsrcl/1GIXqMSpQIHlDxoBYeOisqb3d54=;
        b=AN6lMSIJwjz+++UUonmin8KFg1BSpSfcQbSJAWeZA8dLXn7aob4uR4H1RroHxGH/Vv
         cxXMT/2CEhjK4D2tR2E6gUDZ4wTAeBefOmaQfL75vjC3XicymjfEO5lL8JVW5Q+A6nUW
         ozRZSSCVf20weBd2bYIPEBNplHU/GC/QPGeKktb3GMsZRSwdHfgMEf1tbMnwcn7319Sm
         DyYGEYQ/bvsCTDcC6bsv0vzWhBt0TkduHNVMlNlzdDMJA+emn4c3PwgpMncAGFYl12Co
         A6VhYHIrR8gJDT3BR38npNCKA2dfhuOtjC10ZK61eam96aX97BmohWj/PEs9iERaNueR
         g9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779313638; x=1779918438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEeOx8/xhFZsrcl/1GIXqMSpQIHlDxoBYeOisqb3d54=;
        b=m6yV1E8eebBCO2XNXGkbCgxHYG0LmnkFrRFqM9I1R65/G/yELexCDN+u+AZzi5PHzd
         xn5tmghd9osUv5Mcd1kJqpFk+CJhdM+xsCLmUnF13WqRxIOAwAhe+vzT4JUpWRaqfZSE
         I30kr/4zWtM6RyteltHG5ADX2G6XZLucJFh8wzJN3Vzwv2XjqdjLQTb7P3nrPbuqbdQ2
         xyN2w0zgOR/9S898vhvuSdFZvJzvxrGobh6A+3he90a6ww2A389Gtw5olloP41kPZlUe
         Y2LR4x4UOp//lr7bUasgYAmcESYEawooGW33gCKgvcCa9sQH29scS+pp+K27P6yLHdsc
         e1pg==
X-Gm-Message-State: AOJu0YyjMBRxplPSdTqw1wW+ZAaSazJNql/NgKVSKzyfHC8Ygym7Iryf
	lmj1USwlKt8Po9LYQ3nh2gM0mpSgQA1g9hiPB9NxHTH146Gpexqr4k/3gIcco9GMreqhgKQV5R9
	MlOWWcXA=
X-Gm-Gg: Acq92OHpZTpvuyY0awlDmrqXSQVbQm/6Zr1oj5ZD5rJn8YknuFW7Hv/iStvJ4G+sxzk
	i49LFBklh5QIKy8buTY90yQiMyersWlYeK+ISsb7ax2eWYOZ8HHMyQRHnDw26ehjZuh5jscew9h
	3iFsCKL+ZNDfIcMv+1ptp3llhEZJmqNMPiYYlJGlQ0jdUH0mrLENNzcLEoEAL3SvpnElzEUXWXt
	38R0ULCPMcLdsP/Izr06WXPdrwWs4arxln5dw5PGl3DhHkDLq+XuQe0k6tiM0gY9albMtctV8ww
	qTSIMaarDwwy4aXz99CkQ49iqkv0rt8qEubgG+PO/3GhTQMqz6qxmIbPoWeZtSD0xrlhbujLv36
	+O7K2DlYGFv+ZiSHltqwt4zLKuRs9A2WobFYZDWRIMKZ8kq4ez68dOLlcxICCf/LETRMXBP1eNP
	F2Kgyeb5SWvH2R5dai4WMkTGK8RQL+vWf1UDzU0faC5svT+ypDSgHLYYR5uR2JOlhoKhViJYYpA
	XMO66FaYIVe9r/e1tGFA1BrcLnd
X-Received: by 2002:a05:690c:9c0f:b0:7d0:261a:69e with SMTP id 00721157ae682-7d20cc3df59mr2857607b3.27.1779313637655;
        Wed, 20 May 2026 14:47:17 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:8978:d38:491:e9c6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc996b7d54sm58080137b3.12.2026.05.20.14.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:47:17 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com,
	sagemct@ibm.com
Subject: [PATCH] ceph: fix denial of service issue in ceph_update_snap_trace()
Date: Wed, 20 May 2026 14:47:01 -0700
Message-ID: <20260520214700.1265095-2-slava@dubeyko.com>
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
pr_warn_ratelimited().

Fixes: 38d46409c463 ("ceph: print cluster fsid and client global_id in all debug logs")
Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Patrick Donnelly <pdonnell@redhat.com>
cc: Ceph Development <ceph-devel@vger.kernel.org>
---
 fs/ceph/snap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 52b4c2684f92..599eee32c8f5 100644
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
+	pr_warn_ratelimited("[client.%lld] %s %s%sdo remount to continue%s",
+			    client->monc.auth->global_id, __func__,
+			    ret ? "" : ceph_pr_addr(&client->msgr.inst.addr),
+			    ret ? "" : " was blocklisted, ",
+			    err == -EIO ? " after corrupted snaptrace is fixed" : "");
 
 	return err;
 }
-- 
2.54.0

