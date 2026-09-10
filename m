Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46948823D
	for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2026 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044009; cv=none; b=DYfofLZbnHU54OU87I62LxYSsRIZ1mifgRnNNA3aZaICvIZ5A0ZqzA0zN1ULO9fjUd8epa0JfejSRf4GEpUvYd1plUcWI6EMvHyFtpWQutyHMMjkMDpt5sqHzPdX5ksBN3AaZnMrDM74vhzuqwH6KTHoIlkxB3TnPWe2dkhB7CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044009; c=relaxed/simple;
	bh=6LqlKf+FYofwcDQhFYY814dcnCTs1AOdxpAa4fg60Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEx6kYfgYk2/NEE9ratfRrgtaauUzkbn36GpGDBN/ImmaAR++nNcuNAaVwj8ilxI9sOZoO0bDSSi54oUTB8Zh2kZLoyzuz0ttEf31fG6v654m/qyrCNrda63CgqOfi/4bPpgJZiebynG+VULdIz2pu6tLPPZ2/UdXw2bzDkFtIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=c0a4QiVm; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="c0a4QiVm"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccfd61ecaso14560505e9.3
        for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2026 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1789043999; x=1789648799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bGNNUPPrMK7iPNhDm0eJff8Lfnx2v/X9Vd7CYMITuOo=;
        b=c0a4QiVmQDzR4eveUXTvykl8Jc90H8wEq3nUS8jtbjEju+K7B3fDQ4h+VXbAd5NKyA
         CJYHYYcOWtNizrmgQAtpkiBAyk2V0ACy8RhqdC0pm5gkfIXBba/VB/UOkOdtWGRMY0eC
         4n3vKg66mpE6dYJ9tQENTDVWXeLjWOBrxFa4tiQaZkhuO7aqN1r1opMayOXBZWpqZ101
         P610oTnz+1TqvCWA1BVL2hFZYpak0yj9y+wb9dEIBo7nQdgzsp6Y9vaZLr2R9cKMyOoS
         n9DikuOrlyZOlPHJshatKf+3MDv78LTBrBKgB3Ks4TjgmmuRZHfUvsq7lGGYZoLcO3Ty
         phtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789043999; x=1789648799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGNNUPPrMK7iPNhDm0eJff8Lfnx2v/X9Vd7CYMITuOo=;
        b=CjnZh8Py5q7N+H2qtjgZSmoRPsN+aITKlxjz86gZubDWCApSWpcKw2Y1J5tU/awXFC
         XYlFSjrB2vQA5WWT7606Ob/p2dpQnZOEHdGG2Pd1cjI+ljyDHYIWRyi/YdHNuoz2n4gQ
         oidi/AeIk9CwjS+Uj340WZ/l0HtoaYEkPmnL1nUpK6H06qT+wpJkUbLfqQfxbaFdnzdp
         cCzj7aD1ZGQV8KZ8qDkTncZa84tP78uxcEMYpAK4bZIoz2q6OAb0dJJdNC8ktimWyasw
         BmXCXFwTjfF6rdidKtO9FmyZ79gq1AgJiFNCO6gtuv8ciRO+Dp/NgWKUm5K7Y/5KuOpd
         kx6g==
X-Forwarded-Encrypted: i=1; AKwUvByV3Kzd08EXv0UZCbnALStGAThM2gpNJsAHlL2/BCTvvLP/IMEbSmsEldUoOqYX2h9ZtLDozwyu/G7g@vger.kernel.org
X-Gm-Message-State: AFuF++mjPgv/4vKU1o0MMvcCK4Q77T/AwydgT7T3oqi444RT62en7yKc
	iLZi5ixzcNyN5Ve9yMqapqQD9iii5GIHzxc3FpuwSH4oMlmxid4clrjZSSroOZWWfuA=
X-Gm-Gg: AYBFou3CnETtyTnrKrF3Lhfsjan0hfF9/zbkveNmp2CXgH2QqpZu7d1KIhI2qBeo9gx
	xlnusHQNMu9yxUi0Twy7nkkSxkNuJMLupF79MKesDSiAQK5bViDmP73nDQbIAfeUTOseB+pM8V3
	NJXF3MHq/x6H+4hEYazbbMTrsA9MVdmyvx3Jnr2xeMzOnNodqQo5d+7bSlIbQnijFtG3B7QP1eP
	7T782w0nQvRkYHCZr8ariqoVMN8bomSYIUXUKrjNZXOXsLuhxI42Bgzw7ArTyCXQrqiEuYzHq9L
	ENva67n2VLgzpoPkYVbOMPez2HaWRfpcvysQAMV7Ff+PCtGeb1mW7mvCDhe9kOTck90YPW7sK2S
	/vsSQIsp0z4V0YOvvGk2kcAgoIqhKLZgHI40BeDHylTug3uy9rQ/K0/qyXshjjPNie9RDgp45v7
	JaW9qtyIbT/9osVst7AF/QhgXVux6Rm0pfSU1YMoBIxTO1g9B/0O347V8pUN+PfH2AvzdnAL4Dr
	Ipr7N0ZjwjhJMwB+ne++0ODROR2J30CHJDgeQRqLzPh5GPPPsdUKg4GW1tJZcK13qATyODMsjU=
X-Received: by 2002:a05:600c:68d4:b0:49c:fa21:e747 with SMTP id 5b1f17b1804b1-49d259174d7mr52120315e9.29.1789043999092;
        Thu, 10 Sep 2026 05:39:59 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26bdb789sm83283285e9.1.2026.09.10.05.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 05:39:58 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] net/ceph/messenger: print TCP connect error
Date: Thu, 10 Sep 2026 14:39:50 +0200
Message-ID: <20260910123951.1241279-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A non-blocking connect() usually returns `-EINPROGRESS` and fails
later, asynchronously; the actual error is then only visible as
`sk->sk_err` in the sk_state_change() callback and was silently
dropped.  All the user got was:

 libceph: mon4 (1)192.168.1.42:6789 socket closed (con state V1_BANNER)

Save the error in the new field `ceph_connection.error_code` and let
con_fault() print it next to `error_msg`:

 libceph: mon4 (1)192.168.1.42:6789 socket closed (con state V1_BANNER) (-ECONNREFUSED)

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/ceph/messenger.h |  1 +
 net/ceph/messenger.c           | 23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/linux/ceph/messenger.h b/include/linux/ceph/messenger.h
index 6aa4c6478c9f..f3aa977d7886 100644
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -482,6 +482,7 @@ struct ceph_connection {
 
 	unsigned long flags;  /* CEPH_CON_F_* */
 	const char *error_msg;  /* error message, if any */
+	int error_code;  /* errno (negative), if any */
 
 	struct ceph_entity_name peer_name; /* peer name */
 	struct ceph_entity_addr peer_addr; /* peer address */
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 212e7797f9e4..f989e043686d 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -398,6 +398,7 @@ static void ceph_sock_state_change(struct sock *sk)
 	case TCP_CLOSE_WAIT:
 		dout("%s TCP_CLOSE_WAIT\n", __func__);
 		con_sock_state_closing(con);
+		WRITE_ONCE(con->error_code, -READ_ONCE(sk->sk_err));
 		ceph_con_flag_set(con, CEPH_CON_F_SOCK_CLOSED);
 		queue_con(con);
 		break;
@@ -448,8 +449,10 @@ int ceph_tcp_connect(struct ceph_connection *con)
 	ret = sock_create_kern(read_pnet(&con->msgr->net), ss.ss_family,
 			       SOCK_STREAM, IPPROTO_TCP, &sock);
 	memalloc_noio_restore(noio_flag);
-	if (ret)
+	if (ret) {
+		con->error_code = ret;
 		return ret;
+	}
 	sock->sk->sk_allocation = GFP_NOFS;
 	sock->sk->sk_use_task_frag = false;
 
@@ -467,9 +470,9 @@ int ceph_tcp_connect(struct ceph_connection *con)
 		     ceph_pr_addr(&con->peer_addr),
 		     sock->sk->sk_state);
 	} else if (ret < 0) {
-		pr_err("connect %s error %d\n",
-		       ceph_pr_addr(&con->peer_addr), ret);
 		sock_release(sock);
+		/* reported by con_fault() */
+		con->error_code = ret;
 		return ret;
 	}
 
@@ -501,6 +504,7 @@ int ceph_con_close_socket(struct ceph_connection *con)
 	 * shut the socket down.
 	 */
 	ceph_con_flag_clear(con, CEPH_CON_F_SOCK_CLOSED);
+	con->error_code = 0;
 
 	con_sock_state_closed(con);
 	return rc;
@@ -1613,12 +1617,21 @@ static void ceph_con_workfn(struct work_struct *work)
  */
 static void con_fault(struct ceph_connection *con)
 {
+	int error_code;
+
 	dout("fault %p state %d to peer %s\n",
 	     con, con->state, ceph_pr_addr(&con->peer_addr));
 
-	pr_warn("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
-		ceph_pr_addr(&con->peer_addr), con->error_msg);
+	error_code = READ_ONCE(con->error_code);
+	if (error_code)
+		pr_warn("%s%lld %s %s (%pe)\n", ENTITY_NAME(con->peer_name),
+			ceph_pr_addr(&con->peer_addr), con->error_msg,
+			ERR_PTR(error_code));
+	else
+		pr_warn("%s%lld %s %s\n", ENTITY_NAME(con->peer_name),
+			ceph_pr_addr(&con->peer_addr), con->error_msg);
 	con->error_msg = NULL;
+	con->error_code = 0;
 
 	WARN_ON(con->state == CEPH_CON_S_STANDBY ||
 		con->state == CEPH_CON_S_CLOSED);
-- 
2.47.3

