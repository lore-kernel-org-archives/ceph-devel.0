Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382A19E968;
	Mon, 23 Feb 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852656; cv=none; b=OJK+dTasGTjUFsyBWwqva9N2Cu7yD3Qe+4LUAdsjSR75lWSqgEw6tBSdpcmciH/Ho3TuH7Zhzw0gE5161qWHSWFCyE+zfW1DXX1pilTSjXhbG3SswOvsTqeSzjG0vNGujJOx1VZoF3q+f234g2mrKoD7qgUdBHRPhjYxfsvtmiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852656; c=relaxed/simple;
	bh=+G/1w4UHmGZB2tP0EYfPJdEemLHQWlp7jYKH5CRM2zQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nyP1ritm/IAxY0nMr9xvC4hIDlZkg6Bj82OBwt3ul0rV0sKNTiywbFfSwvk57M1Dt+2ribu3qzhliuQTvJOhNY2Ls3Y4eNwP7qfJStwiaEtKuFjmr1n0yoJbp6R+P3Ok48LRY4c1ew1PZnwx+9Pi9VnVunakVGPoTIKGlxsm/ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=wxUUqmGm; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="wxUUqmGm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1771852527;
	bh=kbW+nN8CLf1K8ezZTRNZGWtFgDBlgqApxmu+/irLCcM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=wxUUqmGmNz9k1rFUBx6/OyYeMnorSSQiglaPVcV+IQPv+gZ9OPU/BEjNjelEeE2zo
	 R1Rr/R38kGZ/T6PPMS70Lr3q4H29c1Pfz5ZegZkAzqEozBmW4bo1oDHe/iLM8Y1XcE
	 GmdFkc293voGngaJeKgl+IywHr1WL3AdNVbZr6G4=
X-QQ-mid: zesmtpsz7t1771852512t86897996
X-QQ-Originating-IP: uoRXbZmPIVRmffkHo4u1JgMFdYlNlzunyolPqvcKnLg=
Received: from localhost.localdomain ( [116.172.93.199])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 23 Feb 2026 21:15:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17217219590840233451
EX-QQ-RecipientCnt: 10
From: kexinsun@smail.nju.edu.cn
To: idryomov@gmail.com
Cc: amarkuze@redhat.com,
	slava@dubeyko.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	xutong.ma@inria.fr,
	yunbolyu@smu.edu.sg,
	ratnadiraw@smu.edu.sg,
	kexinsun@smail.nju.edu.cn
Subject: [PATCH] net/ceph: update outdated comment
Date: Mon, 23 Feb 2026 21:15:07 +0800
Message-Id: <20260223131507.901-1-kexinsun@smail.nju.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrgz:qybglogicsvrgz5b-0
X-QQ-XMAILINFO: M3vv73qU6a4uh4OGKw/8bS1jSvZWciER65uzIdHNEVjM2Grckht3m+I9
	PkxY4NUFgL1w0KAZwMnUbx0bD3204GZe17zOF4LFaSS01e7ke5QsjIsLPRQ5q32Rhs3Feyj
	nA2dGGhz/qqN4MC+u5fTVX+fcMoaof1XH6Un/GJMDO6k3wvNiGIusZmTBoNoj4lB3tOFN7H
	XlCRwYcvlZWKA7zzKhwizdfnt+6eqptZnaWB8lgg+wcDjFcvK4Z+JKyw0MSqZLGTxXVRXl0
	0CeS/XrP7y7J43zH7v4/3E/1n7OOlmQptqEEuxSz1c3BhAHjbKUYWaQobp9X9/jwDDJ7ZO0
	p6MSwYX7swPTyNsOfTAvmWnGzYCuLYq4GK9N/ifundeVRpwKUHyxLb/l2D2UqtM9XtB8/k9
	hi4Ygu4/1gkT92GaT64zhL3CfGMHgNsPUKhxtQFQ+nqFx/tV3kJgyRgxiBw0fXRVhOPIks4
	huxbQtN1mcaQ7luNPxaVeYoRd5NQXiQVoXSBGhfNXC8RSNRvgOhGGmvCr23gtiAVhbUmJ3p
	D0CEFn8Nlr0pUl7NxZXsbZofxRdtKCi96c3KBMoXQMmJWy4Bpv9LYVt/Wd7X7E1KSTKDP50
	RSaApduq2KXPbnfzt2YIiG3DK36aDEA613/ihlqgCjI0sN9/ixQDH6ftvSmabdS1R/RusY2
	cJtk7w9JLfNa8zu7NbqayMbOVIWtYz9WsnfBZMQnKmtU8ieXt1UyYQgK/Izg++6Eko3HJbo
	2e/RYAtn/bQR/VSxlheo/Mjwm5u7PnSpAC4Cx3JwLqWG+9r8lbfZYnOyE+zl5qCDdVAlmOL
	PxyJv+iv1Fba6PW2SxZkWCO2chAqaiMNmTV9ja4lfK9huhT2AZ9e33jx+A6s3szcO1ntPlL
	YB3QALdGomx6glwlN9GGcbvJK/i5ZzqYnS4PSzfrizhAqDEiHxJBRbiZwQEEfPpHCj7Lpde
	onqyDVTzHo6c2gNo0mKrGPfnIS4REnPTU7o5EFDg6w1+JzCpB89MXIrPI21i9FAjD4XPuUT
	BCRxJydQVMWbmRiTYn1dl09Gw9YTRdnrZIPNyA4HSVeETo4KiN
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

From: kexinsun <kexinsun@smail.nju.edu.cn>

The function try_write() was renamed to ceph_con_v1_try_write()
in commit 566050e17e53 ("libceph: separate msgr1 protocol
implementation") and subsequently moved to net/ceph/messenger_v1.c
in commit 2f713615ddd9 ("libceph: move msgr1 protocol implementation
to its own file").  Update the comment in ceph_sock_write_space()
accordingly.

Signed-off-by: kexinsun <kexinsun@smail.nju.edu.cn>
---
 net/ceph/messenger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 108adb583744..a041725ddedf 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -368,8 +368,8 @@ static void ceph_sock_write_space(struct sock *sk)
 	/* only queue to workqueue if there is data we want to write,
 	 * and there is sufficient space in the socket buffer to accept
 	 * more data.  clear SOCK_NOSPACE so that ceph_sock_write_space()
-	 * doesn't get called again until try_write() fills the socket
-	 * buffer. See net/ipv4/tcp_input.c:tcp_check_space()
+	 * doesn't get called again until ceph_con_v1_try_write() fills 
+	 * the socket buffer. See net/ipv4/tcp_input.c:tcp_check_space()
 	 * and net/core/stream.c:sk_stream_write_space().
 	 */
 	if (ceph_con_flag_test(con, CEPH_CON_F_WRITE_PENDING)) {
-- 
2.25.1

