Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715662FB084
	for <ceph-devel@vger.kernel.org>; Sun,  5 Apr 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775404103; cv=none; b=SjU1ly0vVV0oSewXkmhYhvNiomccF+o2QEWMGYjD9wcCnRuUthKhgLacj6D3v8tqm50u8Ov2j/AjOqQpFyByOXQJKn9f1MPqMjaEQ2fO6aMNssEMMnapz8EEvMzecVtdWhy5aWDkLPwFHEY7PAfoyMOSGZSyzaJ0uCwmJEAygSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775404103; c=relaxed/simple;
	bh=MrlBMIl68Z2aMl2ScQ2BVndAayou0hU09d6+YgdqAzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPTqES9IXBKORz+sCmLbNeGIJdzqJu77MypQTiuBb2F9yWrbjkScf3QYMlt66gKgBQ9XWe3dWqI/2mWeiKf66pqMRayvHXI6+GbtYTsdMhERr0FlpHuHVTx7dPb3d9EWMZWaAIykLcpkcMrdi6mfABsn7hphxHtLIba6MJ1Vov0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzhnYc9c; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzhnYc9c"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488afb0427eso2828675e9.1
        for <ceph-devel@vger.kernel.org>; Sun, 05 Apr 2026 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775404100; x=1776008900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ejC9X9oL82T7UTRyPRfLQE9jbWqA07yGBE+sGIzbzg=;
        b=SzhnYc9c09ZUJxViq8NuyR1J7rbrygz0aqcsGwT7xHsRtqeEdMuAMciD4L0qEjBmhr
         65zFQtLOvov3XBgjrK5tbT23IB3PdDkzugL6mhtsBKr2xEO684tupfhprQBh8wcXUWPS
         5Z3G/SaLQXD8mmlPwBDKDbh6DfBUcxN/Nm2zA5f5DcwkCPo07WyJEOz+CqOQbVknq2dP
         pMmqnhNznctm+RdHSjGItJlsN1qEaI6ZslRBtPQvtUbFb6KE1JQpiNkbLF9OyO4CI7fK
         5akgoU5tGSj49n1jkwBjf0glBNYMnraz4P6u0TSB4AMJ2K0kC2llzR2VUnQpbntlB/rM
         ASpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775404100; x=1776008900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ejC9X9oL82T7UTRyPRfLQE9jbWqA07yGBE+sGIzbzg=;
        b=bxOrjrWGalL/eF/RzzCUscmYLCIncSsrakdASfYSoofKVwz0a/KMlsded9j8pSlcFu
         f6Ld6znb7hBi/REY3piwDlBPRfnG+9uY7TiuXmOhyksQX4bPHbzCJjV2lUsf1/3HHtfm
         NVk32hG9ict+TTMFw0NXaFwtfpp47AjwT2tQG5JAZZCaDo/xrkxqJm67eE4njxD1vKsj
         LhbwauSWZZYCbFAdINE+H0/CX34pSebwZd2qMGOyRxSJKSNJfYg7JPceJrIrfEQWw5tV
         7bylOrEdryTxxVgeVMF4mJxybWjZ0Q1lYGOJat5JkGjRATeB5XAwMp9ZKRG9nTMzPmyv
         PgWg==
X-Forwarded-Encrypted: i=1; AJvYcCV+nPE4W9aXS5jnIiZQjNqz8erbD6kiF+RsINKr577X4q/pm3R6Igh/pio2nXSpeD2nyLYWxE6+Lcl0@vger.kernel.org
X-Gm-Message-State: AOJu0YwquW2szOweV7C0bRpjA7czCHlRV2dXmP+32MJlHyTw+C8H+VMt
	gWnwY4k7t1CUvZYH44crYmfjHoboqwj7MWSv6fb/QHx6m1RIbVoSU0Z7
X-Gm-Gg: AeBDievMZfWbxW9t2hlM+kCeJJPedNAqmBw9LmOrv10APtlzhrPZFKT57G2dzrxnsdF
	4jAkM1dabqFGaxZLYfBMSE+lcVvCvWpglarW00OmIi7ChsgdHhA3fW07pJ7ib+wwwryYkRy5lZM
	PxnaaL9KY15YnVEo2R9Ah8iRkMtHffgMaYyiJx5f/RmXz0jcKM7+wGhTyCWQY+a0nwJaLb1zHza
	S9TV30TiRhVoSn9twQaBaXL6GvhVp4eUEcrI1ugWLdq+j27RrlTQXgxTGYJ2q6mkmVhfaJb+9or
	AtpStdQWqYQDGy8JzelzICFaQ+VSHJ6vIIYUcwnQwa4bCnn47juJXDMRWLC/M7UFwcthcLJ6kmN
	dYzLd1XYJrxRqJp+XylNheiQXwjQ6661sIEyppW4xLU/8P+DuctLKsA3OkDFc84bIQge8MoDgTT
	Rvbufi6RXHO186wMk8XSZhqkJ0QW+fXha37gaj9/bvGAyoLMAWAHVxIZm7bz1BoEHFjYlB1ZyZo
	HVGrODtc1iF
X-Received: by 2002:a05:600c:1396:b0:487:338:b4f3 with SMTP id 5b1f17b1804b1-488997d1371mr147256185e9.17.1775404099759;
        Sun, 05 Apr 2026 08:48:19 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e93cf2dsm390530145e9.11.2026.04.05.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 08:48:19 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mptcp@lists.linux.dev,
	dev@openvswitch.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
Date: Sun,  5 Apr 2026 16:48:16 +0100
Message-ID: <20260405154816.4774-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the typed random integer helpers instead of
get_random_bytes() when filling a single integer variable.
The helpers return the value directly, require no pointer
or size argument, and better express intent.

Skipped sites writing into __be16 fields (netdevsim) where
a direct assignment would trigger sparse endianness warnings.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/netdevsim/psample.c | 4 ++--
 net/ceph/auth_x.c               | 2 +-
 net/core/net_namespace.c        | 2 +-
 net/mac80211/mesh_plink.c       | 2 +-
 net/mptcp/subflow.c             | 4 ++--
 net/openvswitch/flow_table.c    | 2 +-
 net/sctp/sm_make_chunk.c        | 4 ++--
 net/tipc/node.c                 | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netdevsim/psample.c b/drivers/net/netdevsim/psample.c
index 47d24bc64ee4..717d157c3ae2 100644
--- a/drivers/net/netdevsim/psample.c
+++ b/drivers/net/netdevsim/psample.c
@@ -94,7 +94,7 @@ static void nsim_dev_psample_md_prepare(const struct nsim_dev_psample *psample,
 	if (psample->out_tc_occ_max) {
 		u64 out_tc_occ;
 
-		get_random_bytes(&out_tc_occ, sizeof(u64));
+		out_tc_occ = get_random_u64();
 		md->out_tc_occ = out_tc_occ & (psample->out_tc_occ_max - 1);
 		md->out_tc_occ_valid = 1;
 	}
@@ -102,7 +102,7 @@ static void nsim_dev_psample_md_prepare(const struct nsim_dev_psample *psample,
 	if (psample->latency_max) {
 		u64 latency;
 
-		get_random_bytes(&latency, sizeof(u64));
+		latency = get_random_u64();
 		md->latency = latency & (psample->latency_max - 1);
 		md->latency_valid = 1;
 	}
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 692e0b868822..936b43ae4a95 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -571,7 +571,7 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
 			blob = enc_buf + SHA256_DIGEST_SIZE;
 		}
 
-		get_random_bytes(&auth->client_challenge, sizeof(u64));
+		auth->client_challenge = get_random_u64();
 		blob->client_challenge = auth->client_challenge;
 		blob->server_challenge = cpu_to_le64(xi->server_challenge);
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1057d16d5dd2..deb8b2ec5674 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -411,7 +411,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net_refcnt");
 	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net_notrefcnt");
 
-	get_random_bytes(&net->hash_mix, sizeof(u32));
+	net->hash_mix = get_random_u32();
 	net->dev_base_seq = 1;
 	net->user_ns = user_ns;
 
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 803106fc3134..7cbab90c8784 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -712,7 +712,7 @@ void mesh_plink_timer(struct timer_list *t)
 				"Mesh plink for %pM (retry, timeout): %d %d\n",
 				sta->sta.addr, sta->mesh->plink_retries,
 				sta->mesh->plink_timeout);
-			get_random_bytes(&rand, sizeof(u32));
+			rand = get_random_u32();
 			sta->mesh->plink_timeout = sta->mesh->plink_timeout +
 					     rand % sta->mesh->plink_timeout;
 			++sta->mesh->plink_retries;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5cfe19990f31..1a7736145dbc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -72,7 +72,7 @@ static void subflow_req_create_thmac(struct mptcp_subflow_request_sock *subflow_
 	struct mptcp_sock *msk = subflow_req->msk;
 	u8 hmac[SHA256_DIGEST_SIZE];
 
-	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
+	subflow_req->local_nonce = get_random_u32();
 
 	subflow_generate_hmac(READ_ONCE(msk->local_key),
 			      READ_ONCE(msk->remote_key),
@@ -1639,7 +1639,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
 	do {
-		get_random_bytes(&subflow->local_nonce, sizeof(u32));
+		subflow->local_nonce = get_random_u32();
 	} while (!subflow->local_nonce);
 
 	/* if 'IPADDRANY', the ID will be set later, after the routing */
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 61c6a5f77c2e..67d5b8c0fe79 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -167,7 +167,7 @@ static struct table_instance *table_instance_alloc(int new_size)
 
 	ti->n_buckets = new_size;
 	ti->node_ver = 0;
-	get_random_bytes(&ti->hash_seed, sizeof(u32));
+	ti->hash_seed = get_random_u32();
 
 	return ti;
 }
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 2c0017d058d4..de86ac088289 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2727,7 +2727,7 @@ __u32 sctp_generate_tag(const struct sctp_endpoint *ep)
 	__u32 x;
 
 	do {
-		get_random_bytes(&x, sizeof(__u32));
+		x = get_random_u32();
 	} while (x == 0);
 
 	return x;
@@ -2738,7 +2738,7 @@ __u32 sctp_generate_tsn(const struct sctp_endpoint *ep)
 {
 	__u32 retval;
 
-	get_random_bytes(&retval, sizeof(__u32));
+	retval = get_random_u32();
 	return retval;
 }
 
diff --git a/net/tipc/node.c b/net/tipc/node.c
index af442a5ef8f3..97aa970a0d83 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1275,7 +1275,7 @@ void tipc_node_check_dest(struct net *net, u32 addr,
 			goto exit;
 
 		if_name = strchr(b->name, ':') + 1;
-		get_random_bytes(&session, sizeof(u16));
+		session = get_random_u16();
 		if (!tipc_link_create(net, if_name, b->identity, b->tolerance,
 				      b->net_plane, b->mtu, b->priority,
 				      b->min_win, b->max_win, session,
-- 
2.53.0

