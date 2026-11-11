Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413921;
	b=31qXmx3TF9UcQJo0lWpf7TFN0m4j56wgDPfyV8KWaa7Y655Ae4wC4P9ZdJ421Im9wLNF
	 2N9eeUCKSdY8aoS4Uw31D4y3NyDZTMfdNr22qi39il86MIc/UB0cwK3TtVjxIuLcgrvmb
	 hah5sp5ep0O9pz7VOfRAS6r2hWcfuTWCnl1pqpdwzjjxEE8UFwc78HNNhRDI/icC1FyKl
	 pM3rtdU2jr0/b7aF7PKgX+Khf0+sIbRCv81Ev+kkopVTGU+ChqszUOxMn/FIB/l45/Enl
	 f9usCF5mbxzoGETdWNQg8nacIm1BtMBKl9o15WQUjOf9eg3gUsxW3cwGFuIHIAS/WOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=izt2/XobLLqiqgA/+J+pbNOAtloWX7VwrLq7qFAm7og=;
	b=j2MSkyHWTe2OvEbI4KPfk1yRVM424Sjw3OQt5d0r0uiQwkvFrVtruk0DajzKNdhMspRk
	 u4cNnabnVd/Prujl8zUQaXW5cYtYotjXLeZ9Cm3j0Mxhx/VtWFKz9+z1aa5IcZXaogE/q
	 th+eK2jVDfxv+250D+oRoEjBjFzweNSsnVgs1pFQY8CrRu+O4xpKj6YYjVrKkw/54IqqS
	 AzoAEbQcuc8+3EN5Kk7iWqtIrbUF9hT9JxHQvi2iEdDsvmIgUki3A6s+sX9pKBFPfajfw
	 BTY9VK8IkCVfEnVbaHZecZpZvi8WU/C1sQ6TTx7a9D0864Oe3PLr1juihibacM7T46A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=h6ew7d3v;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FC60A262F
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 16:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 448FC60A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=h6ew7d3v
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so40651855e9.0
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 08:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413920; x=1795018720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=izt2/XobLLqiqgA/+J+pbNOAtloWX7VwrLq7qFAm7og=;
        b=h6ew7d3v9vf+Kt4CULQmOkrk+4e7JAubTLtfJ7E/tSjtsBGHL9SF6ngarbtIfGRi7h
         rbsDjhgtddpXtFjcd+ySROzj/rbNWdonvsfTizLLb6dxcLjM9g8F5ouUxNL4tqzr2QYs
         GxbdA1+axsxLjLiS8/RT7IhwkPVQR9S1LKgbiaIeE4pchX7GWlYu/XGnhl6ZZ0BPf0EI
         yb+6CIhhZuspDWtoCpycFnQ8v2aYnTIKQvzuWY58Sn9avpw87EMnDUUXYRauoRgQEdIh
         jNL93vujq4WplSxed1q7pIkgDzIkQvjIvCjEhF062CPfzj/rwNwiSc1hA45Q22s7oWYI
         a5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413920; x=1795018720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=izt2/XobLLqiqgA/+J+pbNOAtloWX7VwrLq7qFAm7og=;
        b=XQ6nG+azCwYG23CT3viCXHhs9WTeVo/sw3Fek+XBshR/3sbF/lEZW3R1GNyFW620rS
         lipGKDgzHzcc7rm2CTd3hkm81HYIOEqLFgVvBpbc4DNvpon/kNXt+v2vIe4ZKtuCBC5h
         iHbpUyQLppcXYeuPJgKo449GorW1gBF+vId5G7KcDu8LtsMoe+vnHFTkbwYv/tFqloHt
         0T/Nm8lbC0KkMviVusxrOn6VnMuUORHlt9xei3WU79i1YoNtSqq7CzLvaRwJ8CkdDcjW
         wAGPjIsQ45aqUTH2XJQ4i6K1zdXu5/LztRfS50APYBPy+XZrImGMMCg3i8wPkg651LVA
         iN/w==
X-Forwarded-Encrypted: i=1; AL+hErHmPQpP0EIZCQAIG57YrBVvhr5Jv+cG7urHc2ancDkTmJbxqb7gAjNZ1lBX5lNK0ywhz5mAanK8Oz9b@vger.kernel.org
X-Gm-Message-State: APuU4Z9tdh7CM4hJUfqimqlr5dEzqtHcXyyQTsl/yG8R7folYuWmF4CA
	kdNUVVVA8+6Suu4iS+YT5Eq4sq2GFnFIMJS7oeVMs+ic2wNbtJhYosAgBpejCeAexo0=
X-Gm-Gg: AYBFou3erwgrVFDaraslYOVWyoDfpAIuceA8GkFhV/QytlglfUJMDWJti0hJXXkQ0fs
	qoiEUs02e36yCbIkJzXOM8OhIlPeMkEZZxpbU7k+6iyN1O+8Pe5aMQQ6m0X4sZW0ah1j0HWV/9E
	dL9ECe1qTChw5oGOec0Sf82cmJDycwBb03lUIA8cxCHsJ9QN80mOl7r42sENikQz4IQ/rN0onqx
	j2jYwaGeyEkV1gj8wxpkWMI2AWEF6W5JeuIYA0IKQpOfoq0K58B96tNdrbkBSCK5b1eP0eMmjDM
	Cz5UUZz0UrqZT+x4Yj+ygxaxQ2cg0OYntBdJcA2kesLz02G0YnxvUPUi2gwlZcQ14c6bIa0l44f
	XNHHNacFHLNnkDoW0FXHsDy7TgF+dkmB6ix18EHQVKyIwqbyrhCYcvbrginhbNzh1/NOi0rZoac
	JXiS5JdkuFQXjtE4uZ4W71Pr1wX/slFHJu9z8KOzAzb78SO0UwTtjY4omNwidIkNAjhRD18v91G
	tU4JxUY5lWK33wQsGydDsiDFgnXfhDrVpTD4RReGzDubgjGBr3WmPnBNQz160PqxHV9qx2j7LRx
	wKqFkA/10RFo/dB/ZcwU2b3VOk9z6A0MkYaA5upK3g+2IssLTKN9F84DItV/pxJPWXZ15DoNvRU
	abrEa7IxuHOFbYBBV7+C/eKwJHXXcQw==
X-Received: by 2002:a05:6000:268a:b0:48d:ee35:b3fe with SMTP id ffacd0b85a97d-499c57838f3mr4997398f8f.8.1794413919771;
        Wed, 11 Nov 2026 08:18:39 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:39 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/9] ceph: fix mdsmap use-after-free in mds_peer_reset()
Date: Wed, 11 Nov 2026 17:18:26 +0100
Message-ID: <20261111161830.1336485-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111161830.1336485-1-max.kellermann@ionos.com>
References: <20261111161830.1336485-1-max.kellermann@ionos.com>
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

mds_peer_reset() reads the MDS state from mdsc->mdsmap without holding
mdsc->mutex, but ceph_mdsc_handle_mdsmap() replaces the mdsmap and
frees the old one under that mutex.  A peer reset often coincides with
an MDS failover, which is exactly when a new mdsmap arrives, so this
can read freed memory.

Read the state while holding mdsc->mutex.  The messenger drops
con->mutex before calling ->peer_reset(), so no lock is held here.

Fixes: cbcb358b744b ("ceph: skip reconnecting if MDS is not ready")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/mds_client.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index a43ce23d48f4..aa4406fd65b9 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -7300,13 +7300,19 @@ static void mds_peer_reset(struct ceph_connection *con)
 {
 	struct ceph_mds_session *s = con->private;
 	struct ceph_mds_client *mdsc = s->s_mdsc;
+	int mds_state;
 	int rc;
 
 	pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
 		       s->s_mds);
 
+	/* ceph_mdsc_handle_mdsmap() replaces and frees the mdsmap */
+	mutex_lock(&mdsc->mutex);
+	mds_state = ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds);
+	mutex_unlock(&mdsc->mutex);
+
 	if (READ_ONCE(mdsc->fsc->mount_state) == CEPH_MOUNT_FENCE_IO ||
-	    ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) < CEPH_MDS_STATE_RECONNECT)
+	    mds_state < CEPH_MDS_STATE_RECONNECT)
 		return;
 
 	/*
-- 
2.53.0

