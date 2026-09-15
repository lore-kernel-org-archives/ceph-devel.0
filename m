Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2E53876BB
	for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2026 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508441; cv=none; b=sQxNDLb+nHQIoH4Hn2YmwzwjqMDUPpLcxT5kYkCziHtdu4c0v1vapjyfG8yiizoacdSRUi2D0NMTe5xeV40jXWRODuYROEGBbLtIXJ0kYmTrHyRVQuOsjOTUH73qf6rpxftUhjq2N5SkOY/3u09Ep3Iyt0clxSq9on+mAtsZIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508441; c=relaxed/simple;
	bh=3vMP89IgAq10Nq+Ss39mGCvVdYNolsX9+u7Nd5404Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldsAdAPMr7tpJsiFly+9RphXh99HLjqeDPU5WU5+crg0rS8hDYfl4IzrYeuUqn0jca/fwsvjayKEPo5gflCRW4wB2JrkDD0QBo3Kcg8qciGWkOmSPcCq+1EJg9mpsUtR3hMycdj3tA2yw9twcrzhf5guQ+G3orUeSOBPNgrVumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=N/SkJXHy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="N/SkJXHy"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so12601545ad.1
        for <ceph-devel@vger.kernel.org>; Tue, 15 Sep 2026 14:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1789508438; x=1790113238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+c8xCF6msCY4/3EPPq3dq+wZSxF7xobbUNc2NOhYkXM=;
        b=N/SkJXHyDCLRfE4hjeyQRwz6Kg+vG35x52LvhN70VuJ524O8jZodMFxV5ZLkfl2RvC
         ZzkRqqBZnM3lSzY4/wvQ2wbFBBMSSlkAWYfJbLa20q10ekK8fuXAK8s6hPrjQbgF/134
         D1umsx1ukt3dLIrD6TKVoOVwYaIT9+hWkIAqbJOj1W8p6LeSEFF5NMMtg08DwhCUkPuU
         gLPSJc4jk5Q+/6+ptveAJue6l91cRPWeNCrjsj1Z6JVgOWGA6aNCWJLYHuHwy0WVQHvz
         Wly3gqo7tUI02jgPiXHPxiM/PemsmoHD/kwoIyq+JMYrlaHJOA/PYr+6Q3seJhaua3nT
         y2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508439; x=1790113239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+c8xCF6msCY4/3EPPq3dq+wZSxF7xobbUNc2NOhYkXM=;
        b=L1CdVdC9cU2xiyJcv+jIOkNZBVMm1eel64COGhyWRGb49Jvqhd5CyVp1v3G2bXp71l
         3a3tVq1BG/4BBfaZIg+PpsbVSfSz5yrZvEMGfw6SkdtQxvxKSyHRgaFUsh5VCncjrszq
         n4ozGhzWG3ZDxkMmyA595ndtxVjVdjXCctlI8qMFfZloxd45KVhDTR0XpZiEplG8mqk5
         ahcixpZGvKu3Q3ie3MCZMw4cyrFS8d7J5HgV30Fu6+r9EJSUOQ/hoA7SgwugWEmk1TQC
         27jDlGffa0p/Lzy2o8SzpUK+RB971iRI08qjNFUc6uOrzpi2nWQOUN/E+3M9+NdIsKls
         GIcA==
X-Forwarded-Encrypted: i=1; AKwUvBx1lnc9qYnDKb1Msu3C+q6U2yY+94Kudv4KvJ44b23eYUpM9Q6Erih77g51ZXqZ5+VP3lUbfKhVidL7@vger.kernel.org
X-Gm-Message-State: AFuF++lWW1hH0ZIjLh1jGoZCpoGr/fLOt/BBv1R6Y97RiTdRo+O9+rHT
	Bd0c+09cc++gddYiHryeNnqpghDq8Pns6d1rj5YHrAXSFdmVhfi+Z5scun++vX1kNQ==
X-Gm-Gg: AYBFou1SRLRPq8l97OLgvJr7xKqW+FdCRFbdOMZcy6cp36TsgotnBDpSWjO/yZ6gfJR
	r/U9KGvBAbl6wcHRQ7Q5ebs0gf/gh+d/ASW3nfMuSpNUlDrtJ+koCTQx+u5ZVSI2Wr1X+AU3iRO
	UpEUi702CbLFJtYPHzpSGOKVLCGLp82EKkB2yBBBg6AqjeVCyK0WGQNKFa8/RWhHNbLeCV9kZkj
	b2NdiOlBhnNzxLjZc+TehBtHGWXrltrAfr36Qw1YGp8F4n2hTX98XMFkQ38an8L3q51zmDRViM7
	4exZiTTbTlpZT0Mezezqp6H0f/RoKiyBKt7gOzmsyqI4u/iK7Pg7rZ/3aqQ5VHTVV0fXzr7YMUp
	DgusIatHO4DS1bnpqO9/fjeY2JS0xanYhtHlsLBmJWloX8KwU9blwrP/DWmJftf0T3lUZVSgmjk
	RyCcKvDVBV68IRS8UyvmicF7SNK/Z2cxUPZt/n+OSmBcnglwVvfMZuuOPC6KDrN+SlHRvWyDIQH
	FUMb4Xw2ADyS8pF5vtOD1MwZic04+EUBjLKIQ==
X-Received: by 2002:a17:902:d58a:b0:2d6:ee34:c043 with SMTP id d9443c01a7336-2dd76519cf2mr74246805ad.11.1789508438632;
        Tue, 15 Sep 2026 14:40:38 -0700 (PDT)
Received: from p1.. (209-147-138-4.nat.asu.edu. [209.147.138.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5ad6b9dsm1682223eec.21.2026.09.15.14.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:40:38 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	ceph-devel@vger.kernel.org
Cc: sage@newdream.net,
	co+ecaada42f806f629@bugs.sh,
	stable@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH] ceph: fix integer overflow in the snap trace bounds check
Date: Tue, 15 Sep 2026 14:40:27 -0700
Message-ID: <20260915214027.1415623-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_update_snap_trace() bounds the two encoded snapid arrays that follow a
struct ceph_mds_snap_realm with sizeof(u64) * (num_snaps +
num_prior_parent_snaps).  Both counts come straight off the wire as __le32,
so the addition is evaluated in unsigned int and wraps before sizeof(u64)
promotes it to size_t: an MDS sending num_snaps = 1 and
num_prior_parent_snaps = 0xffffffff makes the sum zero and the check
degenerates to ceph_decode_need(&p, e, 0, bad), which always passes.
dup_array() then reads num_snaps * 8 bytes past the end of the message
front, which ceph_msg_new2() allocates at exactly front_len bytes.  An
unsolicited CEPH_MSG_CLIENT_SNAP reaches this from a malicious or
compromised MDS with no client-side action, as do the snaptraces carried in
an MDS reply and in a cap import.

Compute the length with size_add()/size_mul() so it saturates at SIZE_MAX
instead of wrapping, in the style fs/ceph/mdsmap.c already uses for
num_export_targets.

  BUG: KASAN: slab-out-of-bounds in dup_array (include/linux/unaligned.h:28 fs/ceph/snap.c:500)
  Read of size 8 at addr ffff8880102a16c8 by task kworker/1:2/129
  Workqueue: ceph-msgr ceph_con_workfn
  Call Trace:
   dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
   print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
   kasan_report (mm/kasan/report.c:595)
   dup_array (include/linux/unaligned.h:28 fs/ceph/snap.c:500)
   ceph_update_snap_trace (fs/ceph/snap.c:836)
   ceph_handle_snap (fs/ceph/snap.c:1155)
   mds_dispatch (fs/ceph/mds_client.c:7234)
   ceph_con_process_message (net/ceph/messenger.c:1424)
   ceph_con_v1_try_read (net/ceph/messenger_v1.c:1430)
   ceph_con_workfn (net/ceph/messenger.c:1576)
   process_one_work (kernel/workqueue.c:3396)
   worker_thread (kernel/workqueue.c:3479 kernel/workqueue.c:3560)
   kthread (kernel/kthread.c:436)
   ret_from_fork (arch/x86/kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  ...
  The buggy address is located 0 bytes to the right of
   allocated 72-byte region [ffff8880102a1680, ffff8880102a16c8)

Cc: stable@vger.kernel.org
Fixes: 963b61eb041e ("ceph: snapshot management")
Reported-by: <co+ecaada42f806f629@bugs.sh>
Assisted-by: LLM
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
The same (n + 1) shape exists at fs/ceph/mdsmap.c:289, in the pg_pools
loop of ceph_mdsmap_decode():

	ceph_decode_32_safe(p, end, n, bad);
	m->m_data_pg_pools = kcalloc(n, sizeof(u64), GFP_NOFS);
	if (!m->m_data_pg_pools)
		goto nomem;
	ceph_decode_need(p, end, sizeof(u64)*(n+1), bad);

That one is not reachable: n is a signed int, so the only value making
n + 1 wrap to 0 is -1, and kcalloc(-1, 8) promotes to SIZE_MAX, fails
check_mul_overflow() in kmalloc_array() and returns NULL, so the decode
takes goto nomem before reaching the bounds check.  Left alone here
rather than mixed into a fix for a reachable bug.

 fs/ceph/snap.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index 9b79a5eaca93..5ba325aa147c 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -788,6 +788,7 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 	struct ceph_snap_realm *first_realm = NULL;
 	struct ceph_snap_realm *realm_to_rebuild = NULL;
 	struct ceph_client *client = mdsc->fsc->client;
+	size_t snaps_len;
 	int rebuild_snapcs;
 	int err = -ENOMEM;
 	int ret;
@@ -802,8 +803,10 @@ int ceph_update_snap_trace(struct ceph_mds_client *mdsc,
 	ceph_decode_need(&p, e, sizeof(*ri), bad);
 	ri = p;
 	p += sizeof(*ri);
-	ceph_decode_need(&p, e, sizeof(u64)*(le32_to_cpu(ri->num_snaps) +
-			    le32_to_cpu(ri->num_prior_parent_snaps)), bad);
+	snaps_len = size_mul(size_add(le32_to_cpu(ri->num_snaps),
+				      le32_to_cpu(ri->num_prior_parent_snaps)),
+			     sizeof(u64));
+	ceph_decode_need(&p, e, snaps_len, bad);
 	snaps = p;
 	p += sizeof(u64) * le32_to_cpu(ri->num_snaps);
 	prior_parent_snaps = p;
-- 
2.43.0

