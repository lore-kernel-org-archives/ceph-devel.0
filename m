Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794825354;
	b=VQezlMXbRVnt9yIKkPj/WNExV1F5QWqBH4ld6HqLrXVhyjZr1PRfjE0jtb9hdNzt9hVl
	 uimi4on/67mj+1MG6HXardtPSezwZ1JlQ+iDlhLKwnl/v3YilrWiBB0PVYvZ0xXsinfNu
	 UQoVvWsJOmLks97QWSoCLxfj4eZqRMYnOc2XMxvQYZLjSfJaGrCCqLlE59BVgilhTE/d4
	 xPI0ozg2WcDUl4ci2WNITRrOXix/cekvox7unQjsoUyvA/0lO88uxcwXQn0ZsTKiZ5m01
	 uF6EqPB4x7XkvkwR1FXq9UGLDR0z6Xp9GIi+8Nk8MdyRu+M2zz8fx2ngbpNzZCG7aVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 X-Mailer;
	bh=RnnPUEujxIMz9aq4T/DqMRuoHHKPpk/taCaN7AFQ/aA=;
	b=IGPLCVlGymqwd7ZQHtUHm5gOXc2jUEhNzc/WlGaYK27oFTkEL3ZZ36HfBAs+Jw+UYeda
	 wzAGc5wIfueKWG5NzzJ8wEcVXj2MHgeb9fqozZLV9OwCLRLY8C1ngGK7n21Nykr4+KK5w
	 O41kxTn/UvrcMSLko+YOaACEsh42f/qb7kXg43CL6QlB7abS7cBqfeIkSULAwVbxSPMA9
	 N5SbrA7pc0io0r0L00aEQYlE0Esn4q1x2SWawOmgXiGyXsDJDedUXJwsxpI7cjzOugWOm
	 nZi+Nw5s+X13Rd4wRLUCrgC5XCPw+OIccMFBnhbU83y2W61QSE8ASrCT6IoL8In4UPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MvKXl3Xg;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D1E606A329
	for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2026 10:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8D1E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MvKXl3Xg
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ae93a86008so2095895a91.0
        for <ceph-devel@vger.kernel.org>; Mon, 16 Nov 2026 02:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794825353; x=1795430153; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RnnPUEujxIMz9aq4T/DqMRuoHHKPpk/taCaN7AFQ/aA=;
        b=MvKXl3XgpfxZs6uVLiYiPB4WZOaFz8W3um3QN8F3GxK8xmjglrqhxEEJ+urQiRg0fT
         soX8nHr+msmmcv/Suggm85I7U4ajEsz/ceu5RHZPxyWxVYbtgtJbLWvNwCXTkDe9kpJ+
         dAjgW6oBA74QhSZysVkkTgdSHLptd4VZG3khUq4uoI7xKjeiyiYcZAk1pHs3r4/Hyrjn
         Mq7YxyxUAPUsVcxAuCBtkziqrFgvbIjKD/O/En4X91X/e+2OArrWvlKIf/+Qs/+KKt2W
         M4spoD0sVEawa3EH5uG0Qu1uxYLex+Zv2k9xpbloSDBCk2slgQvPtUhL1LdhwpoQnVO3
         OevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825353; x=1795430153;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RnnPUEujxIMz9aq4T/DqMRuoHHKPpk/taCaN7AFQ/aA=;
        b=n/ZLdQSbTzIiemBk1SKfLIljagGbSvv7XweHlIB7z40DqXUS7PbFQl4viStp/R7BlC
         D14LtU340Gl+e2rdm45MwSWVBmf6xroTk1FEUKLeEdmD4az+nVNUpXsuvq6k7eEpej7c
         oGfl8AnT4EmzWeVjtf2L72wRZcfsvXs5OEKGbmJ8b55FhpUIkbxMs7yVLLq9oozCd0tG
         l9dN2ZX5cEFujwWog/hrU+/hRKbc+jJQM5M6E+HIvDsKrZGyPaJqqcn1Z5bKBggKINPr
         kGMIj75J+BXnOaZrlg5IhZ7LN6od/AWDQWSzU3pTI+/dil4DKXSu9aJCDQKfz91iUMim
         DExQ==
X-Gm-Message-State: APuU4Z8zPexJnFN9HkWboNTzDERvTBSJvz2Zscb8fBKoKwsvA6sFg50C
	RdtVWw6x759/Eqy5mVTqwv6k59rpfrcrWdpdwEQNTOaChvI9zpqIzZme
X-Gm-Gg: AZFdTZf4iGR/NzvNIfIHK4PeoSSewkGcZUa0wHTCDTPrs8H0h3Q2jCDquaNZ7OcoIQc
	9wz1628Qs7+Pcq9nwOKMlbtWPIb9DlV1WTugHzKG3CerzUCNTaOtQaAcqJOGVlGBANailES1L21
	7S/czOyRdtP2odbg5lZUzy0kMsX9MlcDOrDVnVeznHua08hHL8UY1j4JO31XkISShCAfeQ2Mmq6
	U1LbRLxfJrqFu3OXcG1lQuqjaDrmAHNOEJm4qfGalIdXBq3vVntPc3aJGSHaenoEl7GwKoAglds
	VdQex7FwiIwk2euYEUYMWyrQoG5YTMaj1nMYhQaAdmy+NIQeZP0/ITgLvFVV2q0X/yA0q9b25RF
	03g/AG8v4K72ce/S74cEwhEWtGOK/srHudVPt2sff0tZKyRomXq+PMk740NHO2LeDu7bgYt5wE9
	1Qw0Q4eYAJUoIUl+2r6AU2ASuqEdpNbJcMNrw7atoU5LtsX8ZaQdf6S7lGAUMx5/Ftjk61MNERW
	3AifL3LdSRcHWIVXfy4gl8Akf6O4DhadHiBbAFDKm+Yi8Wa5Vv4ubZwNOXJ0nxXkfRV5ZNGT85E
	lcARWC4MPzSFDWizqtUuRgk=
X-Received: by 2002:a17:90b:1cce:b0:3b1:3598:f881 with SMTP id 98e67ed59e1d1-3b1b0a4adbfmr10108704a91.53.1794825352990;
        Mon, 16 Nov 2026 02:35:52 -0800 (PST)
Received: from hhost ([2409:8a55:3160:1c20:6e8a:d3e1:a22c:99d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f6e0sm21438578a91.9.2026.11.16.02.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:35:52 -0800 (PST)
Date: Mon, 16 Nov 2026 18:35:15 +0800
From: Xingyuan Mo <hdthky0@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "open list:CEPH COMMON CODE (LIBCEPH)" <ceph-devel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Xingyuan Mo <hdthky0@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] libceph: don't reuse a middle buffer that is too small
Message-ID: <20261116103502.20414-1-hdthky0@gmail.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.43.0

con->ops->alloc_msg() doesn't necessarily return a brand new message.
The mon client hands out its m_auth_reply and m_subscribe_ack
singletons, osd_client reuses req->r_reply, and so on. A message like
that may still be carrying the middle allocated for the previous
message of the same type, but ceph_con_in_msg_alloc() checks only
whether ->middle is NULL:

	if (middle_len && !con->in_msg->middle) {

If the new message declares a larger middle_len, the receive path
writes past the end of the old allocation. Below is a KASAN report
from a fake monitor that answered an ms_mode=legacy mount with two
AUTH_REPLY messages, declaring middle_len of 64 bytes in the first
one and 2048 bytes in the second:

BUG: KASAN: slab-out-of-bounds in _copy_to_iter+0x81b/0x1630
Write of size 2048 at addr ffff88800df07200 by task kworker/0:1/11

CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 7.4.0-rc3 #24 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: ceph-msgr ceph_con_workfn
Call Trace:
 <TASK>
 dump_stack_lvl+0x5f/0x80
 print_report+0xd1/0x610
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? kasan_complete_mode_report_info+0x2a/0x200
 kasan_report+0xe5/0x120
 ? _copy_to_iter+0x81b/0x1630
 ? _copy_to_iter+0x81b/0x1630
 kasan_check_range+0x10c/0x1c0
 __asan_memcpy+0x3f/0x70
 _copy_to_iter+0x81b/0x1630
 ? __pfx__copy_to_iter+0x10/0x10
 ? mod_timer+0xf/0x20
 ? sk_reset_timer+0x19/0x70
 ? __pfx__copy_to_iter+0x10/0x10
 simple_copy_to_iter+0x19/0x30
 __skb_datagram_iter+0x40b/0x790
 ? skb_release_data+0x4ca/0x660
 ? __pfx_simple_copy_to_iter+0x10/0x10
 skb_copy_datagram_iter+0x40/0x130
 ? tcp_cleanup_rbuf+0xfe/0x150
 tcp_recvmsg_locked+0x154c/0x29d0
 ? __pfx_tcp_recvmsg_locked+0x10/0x10
 ? _raw_spin_unlock_bh+0x40/0x60
 tcp_recvmsg+0x120/0x590
 ? __pfx_tcp_recvmsg+0x10/0x10
 ? release_sock+0x176/0x230
 ? __pfx_tcp_recvmsg+0x10/0x10
 ? __pfx_inet_recvmsg+0x10/0x10
 inet_recvmsg+0xa6/0x320
 ? __pfx_inet_recvmsg+0x10/0x10
 sock_recvmsg+0x14c/0x1a0
 ceph_tcp_recvmsg+0xca/0x110
 ? __pfx_ceph_tcp_recvmsg+0x10/0x10
 ? __pfx_inet_recvmsg+0x10/0x10
 ? mutex_lock+0x7a/0xd0
 ? __pfx_mutex_lock+0x10/0x10
 read_partial_message_chunk+0xa3/0x220
 ceph_con_v1_try_read+0x13ee/0x6400
 ? update_cfs_rq_load_avg+0x5f/0x5a0
 ? update_se+0x2f8/0x1110
 ? __pfx_ceph_con_v1_try_read+0x10/0x10
 ? __kasan_check_write+0x18/0x20
 ? mutex_lock+0x7a/0xd0
 ? __pfx_mutex_lock+0x10/0x10
 ? __pfx_pick_task_fair+0x10/0x10
 ceph_con_workfn+0x82b/0x1080
 process_one_work+0x6ea/0x1190
 ? __pfx_process_one_work+0x10/0x10
 ? __pfx_ceph_con_workfn+0x10/0x10
 ? assign_work+0x123/0x360
 worker_thread+0x45b/0xc90
 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x2d9/0x3c0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x380/0x5b0
 ? __pfx_ret_from_fork+0x10/0x10
 ? __kasan_check_read+0x15/0x20
 ? __switch_to+0x40/0xea0
 ? __switch_to_asm+0x39/0x70
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 11:
 kasan_save_stack+0x3d/0x60
 kasan_save_track+0x18/0x40
 kasan_save_alloc_info+0x3b/0x50
 __kasan_kmalloc+0x9c/0xa0
 __kvmalloc_node_noprof+0x1f0/0x590
 ceph_buffer_new+0x9e/0x190
 ceph_con_in_msg_alloc+0x317/0x500
 ceph_con_v1_try_read+0x1868/0x6400
 ceph_con_workfn+0x82b/0x1080
 process_one_work+0x6ea/0x1190
 worker_thread+0x45b/0xc90
 kthread+0x2d9/0x3c0
 ret_from_fork+0x380/0x5b0
 ret_from_fork_asm+0x1a/0x30

The buggy address belongs to the object at ffff88800df07200
                which belongs to the cache kmalloc-64 of size 64
The buggy address is located 0 bytes inside of
                allocated 64-byte region [ffff88800df07200, ffff88800df07240)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xdf07
flags: 0x100000000000000(node=0|zone=1)
page_type: f5(slab)
raw: 0100000000000000 ffff8880074418c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88800df07100: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88800df07180: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88800df07200: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                           ^
 ffff88800df07280: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88800df07300: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================

The front segment doesn't have this problem: mon_alloc_msg() drops
the singleton and allocates a bigger message whenever front_len
exceeds front_alloc_len. Give the middle the same treatment:
reallocate it when it is missing or too small, rather than only when
it is missing. Both messenger versions are covered since they share
ceph_con_in_msg_alloc() -- the WARN_ON() in v2 __handle_control()
should no longer have anything to complain about either.

Fixes: bb257664f748 ("ceph: simplify ceph_msg_new")
Cc: stable@vger.kernel.org
Signed-off-by: Xingyuan Mo <hdthky0@gmail.com>
---
 net/ceph/messenger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index cc7db8c61db37..754d051fe771b 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2098,7 +2098,11 @@ int ceph_con_in_msg_alloc(struct ceph_connection *con,
 	}
 	memcpy(&con->in_msg->hdr, hdr, sizeof(*hdr));
 
-	if (middle_len && !con->in_msg->middle) {
+	if (middle_len &&
+	    (!con->in_msg->middle || middle_len > con->in_msg->middle->alloc_len)) {
+		ceph_buffer_put(con->in_msg->middle);
+		con->in_msg->middle = NULL;
+
 		ret = ceph_alloc_middle(con, con->in_msg);
 		if (ret < 0) {
 			ceph_msg_put(con->in_msg);
-- 
2.43.0

