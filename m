Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.150.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794962246;
	b=QGOZtbVWE3IlvrctOOIlLzYR4jR0/PwxAnlnfi+6xUWChvmww+VhekxDcAfEbG3Oh1/I
	 m1eXKcvqR/j7oG4cClgVn/vG3VkiMdd+nxYvqsFTTb9g3NqMyyTVUbuaBFPmhK/bU6uNA
	 /xcaEw2LLjH7d+eFB6Ly1SFGvMiWY3BcqL0/KVJKaFLzzPrIoNoOs4jF8h80vuAgjGhM6
	 PgNI8YWHgpjReNRKYGLjq1DqIxS77NHSTPldhT0WCQZQp2zk1TJG1hN4o+fA1qzUQTMXL
	 FSgkIlTE8T+zzKfFKOFaNhK1KE4LOYm9n3xwtzuraRl+MjOm8nxR0szsgiCqLP8meXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962246;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:X-Orig-IP:
	 X-Proofpoint-Spam-Details;
	bh=BmH2HJBNU7g56YAYVpbKo3jnFN4guXcX8zC5qVeFtW8=;
	b=fFx0GtpdcJKfdzL4uXWE0zSNOEi9tf0g7NiL/qC27O/bpFcm6rDjypJt2gxKI5ZDp++Y
	 3sX5zwv3RumSEExNXa1uhVk8nB4/QgagTiMuoEHzm7d0phTfuUXZg+zwwe8qjJQTxo1cg
	 Lv7/3TszSlDVpHmEZf5YK6SPKvQFLnzpVAK9hd8MfjRxCPjQldD/MQ2bbjZB1/V59ZhXl
	 kOmUAMeYRf+53UY5QE+49gY0SpslbaVAHlhIvPNsUNRJ88Yj+y0tjV7laqOQIGtyK4Zfa
	 4FpaBmrx+R/vjYHAMUHbLcQMiTSDoyLmTdMwjhTYoHtvivkIZPazYKv8YwU7c4hGxvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nyu.edu;
	spf=pass smtp.mailfrom=nyu.edu;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=e13sx5Uo;
	dkim=pass header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=UjE3mKJ2;
	arc=none smtp.remote-ip=148.163.150.240
Received: from mx0b-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B9606A882
	for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2026 00:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 747B9606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nyu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=20180315 header.b=e13sx5Uo;
	dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.a=rsa-sha256 header.s=nyu-googleapps1 header.b=UjE3mKJ2
Received: from pps.filterd (m0355794.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMYIa2227207
	for <ceph-devel@vger.kernel.org>; Tue, 17 Nov 2026 19:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=20180315; bh=BmH2HJBNU7g56YAYVpbKo3jnFN4guXcX8zC5
	qVeFtW8=; b=e13sx5UoG1M+/4I/Kpj1YUj79oDw7obH6vaHjTYyK3KmH82/XEJY
	gg/bedyw3LVVo13zGNQfSmtSj5M9+ZoDnNJAuqaK/eQUr9AYRLq18QLe1jtV16Xb
	1gCm7QXQry3nQaN9mvJyY/QibdEZI4MdNCorzd0ayi4Voj85rIlMQiLOfdzMgw2X
	rYHHbziKuLoCouPnajw6E1DHeYrMzDszhygp4w2rIbEXaz4g+893GsY/zLEEj85m
	uXR3nzsbs7oYVM6LV+JXCmbLYWSZtDS3MmP0iS77V3F4vBsV7rsYgBFYyK71NkES
	j4g9gXDLvd4h1ZYZvfgGU59S5XRpEshReQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4j0yu7sfuu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 17 Nov 2026 19:37:18 -0500 (EST)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-947a607ec40so50749785a.3
        for <ceph-devel@vger.kernel.org>; Tue, 17 Nov 2026 16:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1794962237; x=1795567037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BmH2HJBNU7g56YAYVpbKo3jnFN4guXcX8zC5qVeFtW8=;
        b=UjE3mKJ2KHDLQgcUEQPAtKB8x2CYc26FXgPieugBwPcEHKwyr20qbxc8CPaQOWOzuQ
         4vZNcIJZSVJoc8btUD2OvCKyPR/Hl4MG/ENrEAB+3y5RnMgVupm/J9J6ikoGoK7IlCUL
         zULIOnoUpWPIXCFnY7rK0B48d/Un8DfQoCi3cALZ/UzBNeS9x2AeOyf5hIRoKKB7Osjn
         nLtL4QVoXSLypPtV8l+PgDVtYh4oTtD6JtcDTI/8dM1iALxLa1vK6D5Nhw+4Gm5i0zNy
         z9LnR/FIucETI9ojKvRuA16c7hpxHZohHk5kPXvbbv3ISO/uASZQ+Qubox+yBdddnqJh
         E1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794962237; x=1795567037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BmH2HJBNU7g56YAYVpbKo3jnFN4guXcX8zC5qVeFtW8=;
        b=e9BkfaZx9Ssc5e+a2/3r5c8x8YgN9t2CfwBc63x8T+bdyuGeAFIXOkgzqulMXdWSGS
         OH3vSgw2xnZgqK+0/8pg8D9gfefdBU4JXwpbADfPs35ufYAu0Ak4bd7edYEV/vHFNoz9
         KsedqUpfpK7ZnOk8TN22ejeMuYkQBhFwRTRl8hNnFsbTp7zOjX8VpMUGsR5kLLvU+NQu
         SstEt/vxfVQpezUZn+AzJtmh3vJu/e2j+57DRj4BqUBAiVlp7Hc3KnMCN1sq1f9GJ2KR
         MhHyzP4ZFZhzBjsMqDG48bmlVtGiSdF0y2i5pkfVncFH9wuwMnapF6f4+3cjnTPtAK0W
         wHfA==
X-Gm-Message-State: APuU4Z8F+bHmOoz7iWPXT2A0IqZELUEOs7gReFiMnoZCFLBqVFj5f3+l
	XuCR4bZqjp0wFXBpizh5pCN0bDPQh0rL9iDYOav+i2zcrDwvA0Um6Z7XivrqF9yoZuWfKmIAaWd
	az0QFwNp7KbjR7NE1WdP+pH9UYK1oKwuAPQtgkNIgnQmEteOL/ssZaKnvEtFG
X-Gm-Gg: AYBFou0/NJJr64+Pa5qEYzamkm0Y4+8brKDKrRVnth3crZVz/5Y8oL3gdiYhc25eSQV
	V/kgWPObI4aiJGHYX+6yC6b7q+Ek4UujbHv/puwOGlH1Uy3W8CU7PucHqoDC9MTal1CPlfZou3d
	sXQOqDwfr8fUj923lqNw3zUsaYTlG1Wb21PxIvL22eFWlckWydRulkC+00MLNPxYsG0jwDHYUeT
	cXD584sjC03vH+QbENoXA5WZj+vtVlkZXwEDhV9U/WjWn3vdUDlggkUqgRvA/drBW17E/BJZ6vZ
	qGXDdpZSK7dPjB8VeujoaUZ7chM9xlUnYjjHIVWyrXBrAhAT+MDyMsmv9+BHklYo+Tn4L+B6zgz
	Af2Pa3VQRkIS3MIRqmTczr/qH19EXsx6bc3LtX7skUe7g+6AhZBehofOLHpLHG8pkOiwI6np+gl
	cdBOpQ/GeSXg==
X-Received: by 2002:a05:620a:700e:b0:949:698f:8be8 with SMTP id af79cd13be357-94999648996mr248098985a.64.1794962237307;
        Tue, 17 Nov 2026 16:37:17 -0800 (PST)
X-Received: by 2002:a05:620a:700e:b0:949:698f:8be8 with SMTP id af79cd13be357-94999648996mr248094985a.64.1794962236622;
        Tue, 17 Nov 2026 16:37:16 -0800 (PST)
Received: from jerrythepro.nyu.edu (216-165-95-155.natpool.nyu.edu. [216.165.95.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b7475b8sm51691785a.18.2026.11.17.16.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 16:37:16 -0800 (PST)
From: Kaho Jiang <kj2864@nyu.edu>
To: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        co+a9f1a2fc804a2921@bugs.sh, Kaho Jiang <kj2864@nyu.edu>,
        stable@vger.kernel.org
Subject: [PATCH v1] libceph: replace undersized receive middle buffers
Date: Tue, 17 Nov 2026 19:36:42 -0500
Message-ID: <20261118003641.1069010-2-kj2864@nyu.edu>
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
X-Proofpoint-GUID: GnKi2RH831BrTurKMcItxrvi0hF5zI4G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwMSBTYWx0ZWRfX+d16rPCuwhci
 CCGJcpUdegisRb1+LQRHZXmIZkYbrbDjpWE1HQL8Zm3tuUUbUFhimawe9jC5RVp1NS3BLVG413k
 bzIvTqa1w7ojcEIvAJ0NGlzK5zGtNkk=
X-Authority-Analysis: v=2.4 cv=IMmXmQvG c=1 sm=1 tr=0 ts=6afcf33e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=DJxkqqoNvFVJFTNdoq0VCA==:17
 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Se5WoFf3ZZRiLcel0nel:22 a=A3cO9-ABBa8CDv30UOuY:22
 a=VwQbUJbxAAAA:8 a=6fTL0N-4C1eZiWn3T4sA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwMSBTYWx0ZWRfXwcBusBnEjDti
 6Fx3DtDVn/WU1uqlFekGFg2f07SMp1VVN6HVfqC6P6gcKIZkFZfEmsO8c/0DJA+5VA9P94RTUEA
 GbP+2NDA6rvCAxFqW/0Fux1HPu54T0Or0Fqnls81jDGahisy7D//hhFuKfePNlSQbuu2Nu8+PKX
 7gXEEM/MlQhiY+AI2TxvfH3bXfLix5Lp+2uEqaktB+w9iOy52hgZvvqgKYqwkUweMnofbdR8CD4
 5pGXjjn8qqS7sqs1ar6tu+MxlN13VIMWizJpauabeKlmqYT8zzmA5o8cipTKkG2ylTb72zfVuGz
 nmMA5NMfYQo2D/JcMZp0UGX56VR3ywulmDIMkHOhC8iSXcy8Iir+A9t4qgPc0LTJUZcVR0pxK3F
 WqhPvhhpkGBDuWZf5wNR005mI1tU2KS5gubmEepX2mlSYG1P4fJ/5Wg2HZ5xzGZrT2DW66hmT0D
 6zYmGKf0OUsyBbarLWg==
X-Proofpoint-ORIG-GUID: GnKi2RH831BrTurKMcItxrvi0hF5zI4G
X-Orig-IP: 209.85.222.197
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180001

ceph_con_in_msg_alloc() can reuse a message whose middle buffer is too
small for the incoming middle length. The receive path copies that
many bytes into the buffer, causing a slab out-of-bounds write.

BUG: KASAN: slab-out-of-bounds in _copy_to_iter (lib/iov_iter.c:77 ./include/linux/iov_iter.h:86 ./include/linux/iov_iter.h:308 ./include/linux/iov_iter.h:332 lib/iov_iter.c:197)
Write of size 4096 at addr ffff888023765000 by task kworker/1:3/4983
CPU: 1 UID: 0 PID: 4983 Comm: kworker/1:3 Not tainted 7.4.0-rc3-g666539eecdf4 #1 PREEMPT(full)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: ceph-msgr ceph_con_workfn
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
 kasan_check_range (mm/kasan/generic.c:186 mm/kasan/generic.c:200)
 __asan_memcpy (mm/kasan/shadow.c:106 (discriminator 1))
 _copy_to_iter (lib/iov_iter.c:77 ./include/linux/iov_iter.h:86 ./include/linux/iov_iter.h:308 ./include/linux/iov_iter.h:332 lib/iov_iter.c:197)
 simple_copy_to_iter (./include/linux/uio.h:228 net/core/datagram.c:521)
 __skb_datagram_iter (net/core/datagram.c:435 (discriminator 1))
 skb_copy_datagram_iter (net/core/datagram.c:535)
 tcp_recvmsg_locked (./include/linux/skbuff.h:4268 net/ipv4/tcp.c:2851)
 tcp_recvmsg (net/ipv4/tcp.c:2955)
 inet_recvmsg (net/ipv4/af_inet.c:894 (discriminator 1))
 sock_recvmsg (net/socket.c:1154 (discriminator 1) net/socket.c:1176 (discriminator 1))
 ceph_tcp_recvmsg (net/ceph/messenger_v1.c:34)
 read_partial_message_chunk (net/ceph/messenger_v1.c:975 net/ceph/messenger_v1.c:964)
 ceph_con_v1_try_read (net/ceph/messenger_v1.c:992 net/ceph/messenger_v1.c:1245 net/ceph/messenger_v1.c:1417)
 ceph_con_workfn (net/ceph/messenger.c:1576)
 process_one_work (kernel/workqueue.c:3495)
 worker_thread (kernel/workqueue.c:3578 kernel/workqueue.c:3659)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
 </TASK>
Kernel Offset: disabled

Release the existing buffer if its capacity is smaller than the
incoming middle length, then allocate a new buffer through the
existing allocation path.

Fixes: bb257664f748 ("ceph: simplify ceph_msg_new")
Cc: stable@vger.kernel.org
Reported-by: co+a9f1a2fc804a2921@bugs.sh
Assisted-by: LLM
Signed-off-by: Kaho Jiang <kj2864@nyu.edu>
---
 net/ceph/messenger.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 212e7797f9e4..ccb650708663 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2098,6 +2098,10 @@ int ceph_con_in_msg_alloc(struct ceph_connection *con,
 	}
 	memcpy(&con->in_msg->hdr, hdr, sizeof(*hdr));
 
+	if (con->in_msg->middle && middle_len > con->in_msg->middle->alloc_len) {
+		ceph_buffer_put(con->in_msg->middle);
+		con->in_msg->middle = NULL;
+	}
 	if (middle_len && !con->in_msg->middle) {
 		ret = ceph_alloc_middle(con, con->in_msg);
 		if (ret < 0) {
-- 
2.43.0

