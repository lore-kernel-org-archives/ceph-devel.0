Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794539007;
	b=ed+Xdb+UOzmPjUxZsQGZoYwuCP5xY689iaKYtOG9AMEKDdzq2a2yKlrGY4BT2UfmcSCC
	 I+azoQg5WlU0sjRHiNogO2fT6ZP5CXEmm7yMjqCmfmWyctFg3hv4VLoognTq8MjlDoJAo
	 b6AzBPVmTYuhB7cgui3wpIQgTNVkbcmBKrd0IdqgsXl8OL7ztE8rHNI90DS6CUQ9HFKGC
	 1RdlfqPRx1e1FOto+ffImWIg11pLRu02/MBiesUdiVaP7iGhQFInun/LgpXHemmB/oehM
	 j6aE+PM37RlpZWf2bsD35rdr+N20aAw0dV6no7giK77Ai0xPJVAhQwQCbGm4W0W/GeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794539007;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:X-Orig-IP:
	 X-Proofpoint-Spam-Details;
	bh=UZPdBtWA9pQKMZMHNBUh0eB5Fnnm3slLNwC8Pi8shQo=;
	b=i0F3GesPE/mwl31PSxv12pkZDDu8h3BEYupGePMNyPIAYbtbiqgUs/EANWOU2aJo79fV
	 eEqnl7JeUu1ZTWb92qxoNU73f9bm52u9STZ01qfkXbB5Yq8sHmcSQnPRqpNp1EezBpFJX
	 jpDSZLH3fNGLSJR8BBWnwsHy5pLAcOLXPgE0x7frH2uW1TgCumQ29TgBpUz4B0EJzLngE
	 3K4V9X1E4ZJPum8fGBAVNuntCaCdookLK4CTp8jDE2M5fMmspud9AEiouRlYQes+CeWJE
	 S2ZYYiSQ1sP5VpIY+1jZMgBTVZPwdqXPTwHuhMsjYRMO+uGYTtW61ChUaRXbOr/E4+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=pkgUP0GT;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=R6rAnkXE;
	arc=none smtp.remote-ip=67.231.153.242
Received: from mx0b-00256a01.pphosted.com (mx0b-00256a01.pphosted.com [67.231.153.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9410606A323
	for <ceph-devel@vger.kernel.org>; Fri, 13 Nov 2026 03:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9410606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=pkgUP0GT;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=R6rAnkXE
Received: from pps.filterd (m0119692.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACMBREq1746306
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 22:03:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=UZPdBtWA9pQKMZMHNBUh0eB5Fnnm3slLNwC8
	Pi8shQo=; b=pkgUP0GTSqLkHf8q+wXoGyenYuJcwhv/WLF5KOZDx0oedEdUhbJF
	IRUw68ezuiY30hzY1AFFGTZDBvvDM5TaDPpImCICqJSQnnC1FCKzIcAOckZ4oawZ
	uhZpl2jjEOguHwBtltTsDAaOuk5ZvcYSz10Brod3iDGaziRO3ZvcUiG8O6HFNQWf
	2a8yPwJqECVxUKoxRqMDQhNZX+/+YledREEXEvxJNZcA8DU5zAtw5yN+7KPcN//S
	AXaiDczMdiMO02v9TZASFkXHfZMySSelNW5YuUjH1uTPBhjgnne0hPoOUcZMnd0R
	AIZ5poKlDeXY1SjGW8kERH5LbBhXWwGjtA==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hwp1kat22-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 22:03:18 -0500 (EST)
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-8b0bf2140b7so9051557b3.3
        for <ceph-devel@vger.kernel.org>; Thu, 12 Nov 2026 19:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1794538998; x=1795143798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZPdBtWA9pQKMZMHNBUh0eB5Fnnm3slLNwC8Pi8shQo=;
        b=R6rAnkXESu2Q363z3aAdgxXzm0eYqZEvsg5siKL0IT0cya/QX2mmHr1bldf02AruO8
         /Vym84hBFwTlbMOTY0GA3jA+R9/1QfJBodGbdqDlvjoe2mVQDhp5t9Ytf4WC7B8wg6ca
         8zwjIR+RR2Bj6lNiNxrGpBmF/CYxDBUVfe7M6ztvpOZwACzydj9H2SGG9WoRagjJdU8u
         J+/JMKFc7TucTWHUQW6Xf1qqeyWQjNGHH2YHBaPxT6+CwF4MDtE2zyL39sYWGSpw+BcR
         W/y6tUIpD/OSyRpG+3b776ce7jzSX4omaA/arFe1JdN6eQ13L/RItsxoSaBEHV/YKiAc
         4MJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794538998; x=1795143798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZPdBtWA9pQKMZMHNBUh0eB5Fnnm3slLNwC8Pi8shQo=;
        b=yq5RIdXE2y3xemqwZNPKJskUViAH4vfiin/dSMRIOpuV/ndgAsK71I/loV5j28ypRM
         zVu+p3sUna0Vffeif/xs3d5jKSMeCdI5WLMcmmZERppCJ/FsFzTFwzZIeTnpleP1GDpT
         AVu/57uzo1Dvx/de1GGr8d5PFHUry+luA2D5eGUSbSzg0FlOOBJtEU0ttkcvg7hve7rU
         Y3fkQEfKNd9v5VUSxyGVXMbOfug9xFXUT6ZPQLe7GXqheO8673lohTaGeONL7QITaOWh
         gkMf3HQjydplwmhAj/Bw5oVfLrwj0uK1x6MeIfFL9Y8dSlY1P8SQVffbtHFOd8I/Ihnf
         OlhQ==
X-Gm-Message-State: APuU4Z+zwDAEWRLt3ovLxEPPFa9+It+mImcVO25IJeeb3pqvHoL7V1wh
	sgC/1/RWCyUCRQHDG7jsqvNuoqeLmqCKYweXaIlc5Sl+yGiDCuGU1lnAu+rJog2fpjUGx2+eFGX
	WdOBrkxougU8M1bnWBLrz7LDBnD0SuJl2Jlkdp9iTZnTw4LR8/Uaxc+vWe3US
X-Gm-Gg: AYBFou0kGeGogPgnZMy34ru+MgOq+s4I4BGVe/5qgiYzsPx73u2aZqb7S7j/3coglQA
	vCw/4ltAwTxwYtTawBhmvEqV7k/kDa6frJI7kDpE/91++G5rMpu3rmxb3TBMR8aFCqAsJ3C/y3H
	MFC2dw0NzvfcKqiNO5ZYS/VnIw9X6TaI4Uq4h+eMnA7/j8zApKnaBFPcSdo6FtJMYCmoIQu75aF
	kq/hp9/S2Px5Cpc0COgsRPK4O5zNt/D/JzxLAf69E4PbkMs701ZK7zyB59sxrSBuWzsE5JxiW9z
	wT984bWtD1/9Gv0rcSHP5LkbUc0euHWX9H/3+lMSlpURlzsU/HceC5khUI29Oz7J4tsIiohTjT2
	0JZ/wKw4TDlwrmG0kikAreg10sTj6cuLNp/PCjF1Nd0Xv0Wyw1ypSyF/FezUp3ut1HCkcKwaKnF
	q0QmXz6lgg0A==
X-Received: by 2002:a05:690c:1b:b0:8b3:7782:6759 with SMTP id 00721157ae682-8b4aa323715mr13793427b3.38.1794538998363;
        Thu, 12 Nov 2026 19:03:18 -0800 (PST)
X-Received: by 2002:a05:690c:1b:b0:8b3:7782:6759 with SMTP id 00721157ae682-8b4aa323715mr13793137b3.38.1794538997808;
        Thu, 12 Nov 2026 19:03:17 -0800 (PST)
Received: from jerrythepro.nyu.edu (216-165-95-156.natpool.nyu.edu. [216.165.95.156])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa99a6a3sm10905557b3.28.2026.11.12.19.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:03:16 -0800 (PST)
From: Kaho Jiang <kj2864@nyu.edu>
To: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+408fcc361565713f@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH v2] ceph: Use unsigned types for snapshot split counts
Date: Thu, 12 Nov 2026 22:02:58 -0500
Message-ID: <20261113030257.1061200-2-kj2864@nyu.edu>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-ORIG-GUID: 4058YEawnLNNOkcXbkdMx0vMohoYarpa
X-Proofpoint-GUID: 4058YEawnLNNOkcXbkdMx0vMohoYarpa
X-Authority-Analysis: v=2.4 cv=Y65tIReN c=1 sm=1 tr=0 ts=6af67df6 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=00YF/gXxkIOuibRGLzhWGw==:17
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=_0uBWF9-lnOxR1nRej8j:22
 a=VwQbUJbxAAAA:8 a=09FrV-9A3yaSbjUTAGAA:9 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxMSBTYWx0ZWRfX/LMM83QKS8Lw
 GJFS+BM7YS63IQz0+RlgKSS9sTJIzfeQmRhvVtbwqaQCac871PUibi00gv/le5/FDpCeGJ7+qKL
 6NGva2QZc90v3DJq5ZFWYD4ciJzKZxM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxMSBTYWx0ZWRfX1YcgRqiEYkDx
 RMivH9LSwcZRekdWLWuxivSi1P/GQkJ6fIFthq4fB5fvjalbq1jKivxJ1u4nnbYhxoC2Iv/cWDm
 Kq8KdA5IvP3f8waKG1KBRjvTe6kygI4uGcpyWTp7LrHFSbAD+z81qJ4z2Dn5mP6fNT1GcKXiTFQ
 jweKbnJeHcK87c15M339uDYGop36z1oZb1+Lal5eTAxQafXCSXZpUj28dIa9J0Q2Ndl4jJI7SqO
 adGOKZhUj2MUOZRBRXMtobqWNsEjiA5LVVBm7FaY0L2K+ui1awI2A+rkZq01sBv65d2Dx0rr5tT
 qm2WJC4mehG52QfVqCh4+SaMb0FcL/6R96bGjmtI15DYU1cSOlb+qfCM8EU2CQvvO0uppaImiPt
 MMNwiUQ3oWcz3x3HXhVDnOebov8C+uWJra/8z53I9EG9PWuRnibY6LTNN0BDOPXYDSQTs5/zNYn
 cucHibmyJwnPspyhgjA==
X-Orig-IP: 209.85.128.200
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130011

ceph_handle_snap() stores the unsigned 32-bit split counts from the
message header in signed integers. Values with the high bit set become
negative and, on 64-bit systems, cause the subsequent pointer arithmetic
to move backwards before the message buffer.

BUG: KASAN: slab-out-of-bounds in ceph_update_snap_trace (fs/ceph/snap.c:815)
Read of size 8 at addr ffff888024f45478 by task kworker/1:3/2220
CPU: 1 UID: 0 PID: 2220 Comm: kworker/1:3 Not tainted 7.4.0-rc2-g7475ea8b5861 #1 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: ceph-msgr ceph_con_workfn
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
 ceph_update_snap_trace (fs/ceph/snap.c:815)
 ceph_handle_snap (fs/ceph/snap.c:1057)
 __pfx_ceph_update_snap_trace (./include/linux/list.h:172)
 down_write (kernel/locking/rwsem.c:1350 kernel/locking/rwsem.c:1356 kernel/locking/rwsem.c:1632)
 __pfx_down_write (kernel/locking/rwsem.c:602)
 ceph_handle_snap (fs/ceph/snap.c:1158)
 mds_dispatch (fs/ceph/mds_client.c:7298)
 find_held_lock (kernel/locking/lockdep.c:5401)
 ceph_con_process_message (net/ceph/messenger.c:1413)
 ceph_con_process_message (net/ceph/messenger.c:1424)
 ceph_con_in_msg_alloc (net/ceph/messenger.c:2094)
 ceph_con_v1_try_read (net/ceph/messenger_v1.c:1434)
 ceph_con_workfn (net/ceph/messenger.c:1576)
 process_one_work (kernel/workqueue.c:3495)
 worker_thread (kernel/workqueue.c:3578 kernel/workqueue.c:3659)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
 </TASK>
Kernel Offset: disabled

Use u32 for both counts and validate both split arrays against the
remaining message buffer before advancing the decode pointer. Use
size_mul() to detect multiplication overflow on 32-bit systems, and
ceph_decode_skip_n() for checked skips in the non-split branch.

Fixes: 963b61eb041e ("ceph: snapshot management")
Cc: stable@vger.kernel.org
Reported-by: co+408fcc361565713f@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 fs/ceph/snap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index e03d89db61fe..b7f0db7bb515 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1039,7 +1039,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	void *p = msg->front.iov_base;
 	void *e = p + msg->front.iov_len;
 	struct ceph_mds_snap_head *h;
-	int num_split_inos, num_split_realms;
+	u32 num_split_inos, num_split_realms;
 	__le64 *split_inos = NULL, *split_realms = NULL;
 	int i;
 	int locked_rwsem = 0;
@@ -1079,8 +1079,10 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 		 * child.
 		 */
 		split_inos = p;
+		ceph_decode_need(&p, e, size_mul(num_split_inos, sizeof(u64)), bad);
 		p += sizeof(u64) * num_split_inos;
 		split_realms = p;
+		ceph_decode_need(&p, e, size_mul(num_split_realms, sizeof(u64)), bad);
 		p += sizeof(u64) * num_split_realms;
 		ceph_decode_need(&p, e, sizeof(*ri), bad);
 		/* we will peek at realm info here, but will _not_
@@ -1159,8 +1161,8 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 		 * positioned at the start of realm info, as expected by
 		 * ceph_update_snap_trace().
 		 */
-		p += sizeof(u64) * num_split_inos;
-		p += sizeof(u64) * num_split_realms;
+		ceph_decode_skip_n(&p, e, size_mul(num_split_inos, sizeof(u64)), bad);
+		ceph_decode_skip_n(&p, e, size_mul(num_split_realms, sizeof(u64)), bad);
 	}
 
 	/*
-- 
2.43.0

