Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD7267386
	for <ceph-devel@vger.kernel.org>; Thu,  5 Mar 2026 16:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772728899; cv=none; b=NutAbqwXE2kXwZn3e2ofg2QANPS9d2fJsAqG9FOyjLqBUk5wz/k+9+q6VG1PqusSXmkFhtpx0TEraumHhd9UXqyLhhAx6EC1gwwD2Gc8f7dpR9J17Ks6nTel9t2wUuSGmBXEpQp/NMB1ExgIMQCjCxcujgsN9TJo2812fyIwDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772728899; c=relaxed/simple;
	bh=o5imodqKk6K6Zj43O6fmS6XQD1RiL3c0kW6ToDL3otI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3bJNmQsM+YvY82sLHVOWowk8A3H1iHDCqklR4jFwRe+r7j5H7PZhVgJqsrId6zG+jLSX86qYjHiKXXXrdIANaDfr4c27qzbHnliN1NJIIB9M9WaNvQ6fAe3yY8Dmhky/j4F3js2YqdE46ACs7xnTqTt7tMV5tOKh0n33PtIpMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=RAxoYlu1; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="RAxoYlu1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1772728889; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=o5imodqKk6K6Zj43O6fmS6XQD1RiL3c0kW6ToDL3otI=;
 b=RAxoYlu1JLFLDIzY2PZtzOMtQJQfGT+4u0ONYt5l3FBj3jFnPAtKYX6Ygcl37lKUBxp/3
 jTz+qKpyW2hVXkwzpuyF8ir8zFjHrqLtliUKANNMUsv1uubF2btHSzxr5/9IsVdrac5IAL1
 SvthQLsf2biGyY8MSqzmVQgaIkemkLudJwdwF39Ianhc3ZRl7TSw8jbEG+MOcJGvp7lFD0e
 Lz/Ywokenf+Ieic2tmgd1Bi/1roZByck4p1wuby6tBcBWyATlxhrsOpJCs2RPe6RDWuzHPh
 tJKOZ55MUDS9DzlLLxzDOgF375NUh2SXTh+L9oRtF5CcVo2YNRZzHereOKCQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 23874600B3;
	Thu,  5 Mar 2026 17:41:28 +0100 (CET)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 8A3DA5FC75;
	Thu,  5 Mar 2026 17:41:28 +0100 (CET)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Fix potential out-of-bounds access in ceph_handle_auth_reply()
Date: Thu,  5 Mar 2026 17:40:49 +0100
Message-ID: <20260305164049.2844606-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an out-of-bounds access in ceph_handle_auth_reply()
that can be triggered by a message of type CEPH_MSG_AUTH_REPLY. In
ceph_handle_auth_reply(), the value of the payload_len field of such a
message is stored in a variable of type int. A value greater than
INT_MAX leads to an integer overflow and is interpreted as a negative
value. This leads to decrementing the pointer address by this value and
subsequently accessing it because ceph_decode_need() only checks that
the memory access does not exceed the end address of the allocation.

This patch fixes the issue by changing the data type of payload_len to
u32. Additionally, the data type of result_msg_len is changed to u32,
as it is also a variable holding a non-negative length.

BUG: KASAN: slab-out-of-bounds in ceph_handle_auth_reply+0x642/0x7a0 [libceph]
Read of size 4 at addr ffff88811404df14 by task kworker/20:1/262

CPU: 20 UID: 0 PID: 262 Comm: kworker/20:1 Not tainted 6.19.2 #5 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: ceph-msgr ceph_con_workfn [libceph]
Call Trace:
 <TASK>
 dump_stack_lvl+0x76/0xa0
 print_report+0xd1/0x620
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? kasan_complete_mode_report_info+0x72/0x210
 kasan_report+0xe7/0x130
 ? ceph_handle_auth_reply+0x642/0x7a0 [libceph]
 ? ceph_handle_auth_reply+0x642/0x7a0 [libceph]
 __asan_report_load_n_noabort+0xf/0x20
 ceph_handle_auth_reply+0x642/0x7a0 [libceph]
 mon_dispatch+0x973/0x23d0 [libceph]
 ? apparmor_socket_recvmsg+0x6b/0xa0
 ? __pfx_mon_dispatch+0x10/0x10 [libceph]
 ? __kasan_check_write+0x14/0x30
 ? mutex_unlock+0x7f/0xd0
 ? __pfx_mutex_unlock+0x10/0x10
 ? __pfx_do_recvmsg+0x10/0x10 [libceph]
 ceph_con_process_message+0x1f1/0x650 [libceph]
 process_message+0x1e/0x450 [libceph]
 ceph_con_v2_try_read+0x2e48/0x6c80 [libceph]
 ? __pfx_ceph_con_v2_try_read+0x10/0x10 [libceph]
 ? save_fpregs_to_fpstate+0xb0/0x230
 ? raw_spin_rq_unlock+0x17/0xa0
 ? finish_task_switch.isra.0+0x13b/0x760
 ? __switch_to+0x385/0xda0
 ? __kasan_check_write+0x14/0x30
 ? mutex_lock+0x8d/0xe0
 ? __pfx_mutex_lock+0x10/0x10
 ceph_con_workfn+0x248/0x10c0 [libceph]
 process_one_work+0x629/0xf80
 ? __kasan_check_write+0x14/0x30
 worker_thread+0x87f/0x1570
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? __pfx_try_to_wake_up+0x10/0x10
 ? kasan_print_address_stack_frame+0x1f7/0x280
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x396/0x830
 ? __pfx__raw_spin_lock_irq+0x10/0x10
 ? __pfx_kthread+0x10/0x10
 ? __kasan_check_write+0x14/0x30
 ? recalc_sigpending+0x180/0x210
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x3f7/0x610
 ? __pfx_ret_from_fork+0x10/0x10
 ? __switch_to+0x385/0xda0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/auth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/auth.c b/net/ceph/auth.c
index d38c9eadbe2f..52450fde3139 100644
--- a/net/ceph/auth.c
+++ b/net/ceph/auth.c
@@ -205,9 +205,9 @@ int ceph_handle_auth_reply(struct ceph_auth_client *ac,
 	s32 result;
 	u64 global_id;
 	void *payload, *payload_end;
-	int payload_len;
+	u32 payload_len;
 	char *result_msg;
-	int result_msg_len;
+	u32 result_msg_len;
 	int ret = -EINVAL;
 
 	mutex_lock(&ac->mutex);
-- 
2.47.3

