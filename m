Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.150.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367980;
	b=dpvAnRdO1pbmX5QgiB2NYbQqJhw2PFOdYQFXh9H7ScwVh3qXM/j7cEOGygQIrOnGpbHo
	 zBEmMGrNj4DKy6O8zv+odx4hsyLmPaecSI8sf/CiXwk8jnbOV7QMgRS+XGicyRROHoZ43
	 eubXPpKfQ2T0L5pIhiV5Dz93GC7NWKs62ZnaMUpESDfXxn4GOMhyQRercZRbihP6lQgaH
	 eecyBrKjgkI56LVTeOqyDE8uDnMzNxmTzGDr4O7iuzqeS6Y0uaxnJzvUPejlpwF7wCtEG
	 oL/Rcnx0t8zxqNFaVK2kAWJYTj6qdw8NCOzwiGW2araq9pGyUc4+dT88vx20OmjXyKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367980;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Orig-IP:X-Proofpoint-Spam-Details;
	bh=bQ7xCGeyKivCNLHanIQkVR3eV/kMY2IG8KqwPvVm/cM=;
	b=vWc5KfeBHQ/NNZqMVtLU2qp0+qDOqLz+dIgZU4dWhqMozZe6QdwI+XeMr4zh14QDcMe+
	 Llfb/mSUwZjD+gzE4w/VeENwvqA4anBIR/06XNFW6QxkR3I0AWoWVSuFyDZIq2bSn/GBd
	 WaRZav9ptyo2hPR54XVl6hGvSqeHVfJ0r/1OXkvZcH1ddNbCia6DLecM5/QkPVr/g9oUy
	 kSmLUkvk7k7/mPCKy5ud42AOdnE9P+ABsi8tiSx9mNxjPLgeUljmADkwK/cYbxOBKbqf6
	 CJPlR+rasUiihuX8qwA7WbNptcaWfxkYd2vVBvlZQ2vVVB5efyxneGCWH03QwjIDE0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=v6iMNFcf;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=uPsmbQ47;
	arc=none smtp.remote-ip=148.163.150.240
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5C606A321
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 03:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFA5C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=v6iMNFcf;
	dkim=pass (2048-bit key, unprotected) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=uPsmbQ47
Received: from pps.filterd (m0380321.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AALmVki098904
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 22:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=bQ7xCGeyKivCNLHanIQkVR3eV/kMY2IG8Kqw
	PvVm/cM=; b=v6iMNFcfWrjyl90pLk/uRuozJ2Go+1iAeDdwrlxiLR1pqH5vbGQe
	SxJ+LwDeaezfrmtmCOpyB9Z8gp39d3hZbjRomWPgPmu8okU552Qkw2waE3qMPdsO
	nz+Q53ytBGWVuXJyNWVsnTR4GJSHddCE/R1/F+7fCrvs0Cp1ojfe4C2fHsWHH572
	6Bayfen+GQgz2My+usDvdC+QmM1SGNZO7IgnCOFUw+QhSxAxPxfwXJAQ6u2mv9OM
	HTqltuNDwdjBNSEkSViLg/+49bSA8cxzzxTPmhJwobWBb/0BTVp49llGSQoIAbCo
	8Th4nC14oJHg47HvxPyvpn6mejnYhqigzQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4hvbgubvwv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 22:32:52 -0500 (EST)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91ea864ee9cso75143316d6.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 19:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1794367972; x=1794972772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bQ7xCGeyKivCNLHanIQkVR3eV/kMY2IG8KqwPvVm/cM=;
        b=uPsmbQ47UIY/FJS/RsCm1j9cJWsT6UksWf44W0uJthuxDbn/9DqBG2RT/dencJlEGi
         uOmpKPw7WSyTglYAjNYkR7JK1ZhUlZdiF9NZi3gCEDaEZBTrpuD4JQddz4GjvfggZqFc
         n/qrUZfv3DDrl4n13wP5UROlDNy3XLGfuTQs9WMa1ZA/qNdWqsJ2AK0vX5D0wrXub4pS
         yF3THlErtlk6xyFRZ20LvnNcFy+oxGVkVgij3q+Bw2wg3WvFD0DpmidXSJIQ2DdzgytO
         5au7W1JDtDoXllGOQdDglUSoNU27hxijDiT0jg72aSbNIQ/Pz51MDCvfMLVE82ogRSy/
         GPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367972; x=1794972772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bQ7xCGeyKivCNLHanIQkVR3eV/kMY2IG8KqwPvVm/cM=;
        b=v2HwAzC0VkYxVghPt25zYodtnHfgEuuDT77zrBqkzLA6v+SaLuo4OXFIBeHiJgfRfu
         4lfDB8eEbpSIUliiOpoy4lH1ufJWtsmHJOAyT9qF9dLv01lqzAtPHcfhOraU0yn0RVHn
         qnTDxit2Cluo0GCW4qlgnHyofS0h79ZzbB4v+csp6xp47jEHDqdhsPjrVhy/LemRefa0
         oHNb+51jYx5cjq4CaUHgcVphbttSIxTfdGfO7hUwXsVbqiZBWEVLbcvYZb2FjFAMH96l
         FDrjjTGoVYHy1gyEtbz5zhD7qUUrcux5i9cUa5ZogRw4Rbcu1dONfQ8H835VLflFoVvP
         w3NQ==
X-Gm-Message-State: APuU4Z/CcUYe/+rHWgJTVs4MQw69Uk3nJdJDsBWJl5VrxRAOS8vCaGrN
	BvrnM9NysuhRZIBHBEiIsAAPG2tsVAsZXFVV5fPfy0pKh69Mv79FDY0+RU8AOfnALOXfRHvnX6Z
	FJuGAOvJRioZiI0oN5HVzoFDNHCSOfWWz5zKLWHBqLgS/KoK9hpa8eAWIbzjs
X-Gm-Gg: AYBFou02VsRR+CbpGJsLegwzkyriqLoQsI+Dz56/URO34mq8uYwNbJoR0m/HmwHkmxg
	Hv8pHECICv7GZ1sAKOIUefjRZBw2dX4Xknlz4/DQXmgi9lYBYYcybZ8gjDUPU7gjDVVhjLVxr9b
	QSkiDGjUWoGm5ZgDC483GLMJUe8p1I2wnB0WQFU9ZhX7CtfOXne6YGhz4kyTndFIY4KnR1WZY01
	u+77p+i6SaVXh44yOFDtd96UpAAt1m5SYAhkLC1o1yn9gLY5gdeCSPaYqhO0k26m2M7JTTp4EVN
	J6E4+I5g5hL6AsXYqA0WdXAYKbkjDSVXI6EqEzsdf9t4Ran6YMTIPyquNEanWzG/ZDij2uTJ4hx
	ahqTjZ8VC6r1jMcW50gcLCVIhG0J2I6smbpNIHIDW975+kTCQV16giHd+IVhh7BHyQ3Wcv/rSDH
	mhfLMUEcbJYA==
X-Received: by 2002:a05:6214:c2f:b0:91e:a762:94e5 with SMTP id 6a1803df08f44-91f0404accamr24041336d6.14.1794367971946;
        Tue, 10 Nov 2026 19:32:51 -0800 (PST)
X-Received: by 2002:a05:6214:c2f:b0:91e:a762:94e5 with SMTP id 6a1803df08f44-91f0404accamr24041056d6.14.1794367971473;
        Tue, 10 Nov 2026 19:32:51 -0800 (PST)
Received: from jerrythepro.nyu.edu (216-165-95-164.natpool.nyu.edu. [216.165.95.164])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef051dc53sm37025576d6.32.2026.11.10.19.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:32:51 -0800 (PST)
From: Kaho Jiang <kj2864@nyu.edu>
To: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+408fcc361565713f@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH] ceph: Use unsigned types for snapshot split counts
Date: Tue, 10 Nov 2026 22:31:50 -0500
Message-ID: <20261111033150.847104-1-kj2864@nyu.edu>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAxMyBTYWx0ZWRfX1ZvNFn1aIomZ
 auaKfiOhlD+DAO/4DQ0p9EndbD0yLaM94UrPF6QcpSCtLfg5NHu6LsBCB7b/wJGIjpsDzaGayTB
 r5SyBGE9bRKkUSeNVyWuCvl3Y8xaO7/5FkgyZADXsE/8lIVLmp30W3Et+uJouhT/ceWmNQNdhZv
 khC+mMUpiWVSWv0MspEaGWiwnlG8tSTZbpa0ZIaOBzeUfCPqa6jwdxj/oC0b2urbe2VEP4pTPnm
 Kk9XW5IFrcbt9NQV+cLWohaSkNcR6yJ87LLQKfOWMvDcUiq5/Ao2FJZxBzD0dX7epEZ4xI188iy
 HkudmbS/mGaWrzguuY1+COHAkLkPb7aVAXNwHAtw5841+BGx/nWBe0CRSuOKFA3Wo2l9TWncube
 Qbg1BdrpvnmcX4FwzCDyu0JInc/vGtanjpbe9++p471Zm9mXxBDTfH1IoqFm7FWgQ6cAaCzv1nP
 7gZO7LtRSMLjdtKLKSQ==
X-Proofpoint-GUID: -oF0w3A0KjV8Z_jI7zDvJ9iQ61MohsF4
X-Proofpoint-ORIG-GUID: -oF0w3A0KjV8Z_jI7zDvJ9iQ61MohsF4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAxMyBTYWx0ZWRfXwlyqSq5Xkueg
 Oa8Ja/pJymo9NE/N4YtC5bM7CA31kqcfAvTHI6I1mPITQo6kvE0+4SAaWApkTaCQqkn87z04Q2J
 qOxxf3dnzWCrc73U/sz4i/9coFxbLFo=
X-Authority-Analysis: v=2.4 cv=KIfPn1Fo c=1 sm=1 tr=0 ts=6af3e1e5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=ZtTe6gSuN0kH6OIYMjA5WQ==:17
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=Vu6uP2Wp0I46Sktgawq-:22
 a=VwQbUJbxAAAA:8 a=yYqStf5IHDHNmpx8MkMA:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Orig-IP: 209.85.219.70
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110013

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

Use u32 for both counts to prevent negative
counts from moving the pointer backwards.

Fixes: 963b61eb041e ("ceph: snapshot management")
Cc: stable@vger.kernel.org
Reported-by: co+408fcc361565713f@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 fs/ceph/snap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 9b79a5eaca93..7ed782abfbbc 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1027,7 +1027,7 @@ void ceph_handle_snap(struct ceph_mds_client *mdsc,
 	void *p = msg->front.iov_base;
 	void *e = p + msg->front.iov_len;
 	struct ceph_mds_snap_head *h;
-	int num_split_inos, num_split_realms;
+	u32 num_split_inos, num_split_realms;
 	__le64 *split_inos = NULL, *split_realms = NULL;
 	int i;
 	int locked_rwsem = 0;
-- 
2.43.0

