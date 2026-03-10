Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D2B40DFA5
	for <ceph-devel@vger.kernel.org>; Tue, 10 Mar 2026 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152907; cv=none; b=NyY4/JxUEBKSe0LtFU0K85d6ABsYzcORpnZWxru7rboF4ME1GGfN5P5qF7zYdFInYN0+plJBQ+k9mYdWZdQaA6TbEKTqb7jdOA43HLOeqZb7JK/EZp01MjxZ5YeZGB0h2LpHcGP6KF4HQUl2WnudIaqf1LWx8DbPyC0HJdnkez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152907; c=relaxed/simple;
	bh=lg3gR3gQxi3io1jvciiMnOCgkNZUMqvstBtYVi2xffA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oze8nEw7iEkRVOkPUmP6bcTitBBN4EOMwmQJCy+OfbV23rxfrlgptsaQYP9eGFTsb8MLVnJRsYfIhO/s74dQJtKvkhNs3B6Tj1QUolvaBsfYfW5rvJOdSgBAB8T24urOZFgCpMirHlPNFCr+xCR7QYl5SpCIIwl1zzb5JyIVb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=J2RaYdek; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="J2RaYdek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1773152902; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=lg3gR3gQxi3io1jvciiMnOCgkNZUMqvstBtYVi2xffA=;
 b=J2RaYdeknJTyc7aJQ/V3ccUHa6hCI0XNgw5DZg0xOpYNmXXd9Y/QvAz/v9on1V7rQlccs
 piA0gvw1JRHAbAPdE0uqIzclmOMLhWgOeQHsQm/5UWPn9w9w3rLBhvMbBAy9QIaaXHGQA6q
 R7cyptgaOambzXhchTzBgaiV/ykxF5+l7eB91s6AWNu2Lv0RId7gEXuJjEoyw+7A9AjjCGN
 WsPI+GnmMV7Nr54wo/C5m+PyIaGn23QSDUEaoRedg03qUaVUoFiDsfZJ45QZK3ujGoQPPSL
 +9lqDPtd/1wYriEF/wC5ayqSjOtQ0zYXrC+qboLgYMJcmRXReXyO2bfNSNgQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id B807F5FD88;
	Tue, 10 Mar 2026 15:28:22 +0100 (CET)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 1B61D5FCBA;
	Tue, 10 Mar 2026 15:28:22 +0100 (CET)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Fix potential out-of-bounds access in ceph_handle_auth_reply()
Date: Tue, 10 Mar 2026 15:28:15 +0100
Message-ID: <20260310142815.3747443-1-raphael.zimmer@tu-ilmenau.de>
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

Also, an additional layer of sanity checks is introduced, ensuring that
directly after reading it from the message, payload_len and
result_msg_len are not greater than the overall segment length.

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
 ? __kasan_check_write+0x14/0x30i
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
 net/ceph/auth.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ceph/auth.c b/net/ceph/auth.c
index d38c9eadbe2f..ee85c5e45773 100644
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
@@ -217,10 +217,14 @@ int ceph_handle_auth_reply(struct ceph_auth_client *ac,
 	result = ceph_decode_32(&p);
 	global_id = ceph_decode_64(&p);
 	payload_len = ceph_decode_32(&p);
+	if (payload_len > len)
+		goto bad;
 	payload = p;
 	p += payload_len;
 	ceph_decode_need(&p, end, sizeof(u32), bad);
 	result_msg_len = ceph_decode_32(&p);
+	if (result_msg_len > len)
+		goto bad;
 	result_msg = p;
 	p += result_msg_len;
 	if (p != end)
-- 
2.47.3

