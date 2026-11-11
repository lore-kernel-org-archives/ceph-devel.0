Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413925;
	b=wV1tiH/iFZdoGK1LkqDqzqNN6MloXPARYzsTx87YczCWzj0wSDnU99tuov9XhLyn/emw
	 quBLehbIeHeu94vochvnf9bCQ/6Y0Xk+5gawVaFSZQOi5gCRNG/ca4BzZJKPDdwmqtQTv
	 Q0W1ENtS4wV/xtbqRiiUjtp8YzeUmmEPjq1oXbuKentYB6X43P65xR12SNsQBBBPEqTn0
	 YSl2mLs0pJYu1PY/o2e1YwiiS9v/eXlBwo+uRtzyxgpeURHwQO7Q2BixN2QMLJJjgw/mw
	 +WDBFTEbalYIIaXryyndIchPeVkcjUK9zDlHlS4Yive9jfhGWAmiwtUrf7MEJLgbtBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=SQTg6mu9eOLnWguJd3WECuqCcHwaFD0TQuF9ZQxG35k=;
	b=eFi8n5Se/yM//qUiGGJ5CuZRqpaj5DJCbhDzq8cV1rSfyuxMcoY+SL1B+5mNaRs//1Kl
	 lCgQjdKA3/uSuG86meT56N4bkGI/DtiYK6yx791P7z8av6rJl8Q218WC/gqG63EJVQROX
	 yiu70mQDsjGmKSPZORyH0Hl+hLEw7bS/vkQGjaI39vSLaXOwxpsHgoeqadNLmnGea+ewJ
	 bbRSaHr2nTqbtVCE+FVNMite6CVCNaVa4oSdaPk5nug/ZFPj4HuEHQaFGUDP29W3JLWxY
	 bLnQ+Y0ZMk9Npqe2IVY9cio+b3Pgf8RjqhIYi+czSo2p0Zdcluf7XL+n+WLoZwATOzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ionos.com;
	spf=pass smtp.mailfrom=ionos.com;
	dkim=pass header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b="L28Sy/53";
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA860A383C
	for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 16:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AEA860A383C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.a=rsa-sha256 header.s=google header.b=L28Sy/53
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49134c8509fso2746049f8f.1
        for <ceph-devel@vger.kernel.org>; Wed, 11 Nov 2026 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1794413923; x=1795018723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQTg6mu9eOLnWguJd3WECuqCcHwaFD0TQuF9ZQxG35k=;
        b=L28Sy/53fBIDZZA5JNFU3qj7CHWSZMS6zMvqhV8cs690h/ubOdtBbR3+T/B2a7JVTk
         rVQVjtZ+HqfCHbRp/0W3IInVub3vTTcOBJt8pKiQmJO2Ber1TGHkM5n0BVt2BU+d9Ary
         aavTVlcexyEZgM14fKIqNkE/GB45NFm9ffMvANhq1eJRoG2uv2PW3l7E5Bwq/W6assIv
         ZK9Y4cPi5d2/UR6x4cWRCzl3aK82HlMQGOCtZY9uEqEtVmi7T0mMDSY9bkKbKo+cnCLo
         7ZzDuiGmLS4CMjK05w8jpB1fQBJYi48vr0kfClvaYl7dc4aZfhNgZmNnCoEIR78ktG0k
         wj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794413923; x=1795018723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SQTg6mu9eOLnWguJd3WECuqCcHwaFD0TQuF9ZQxG35k=;
        b=kQ9Wq6XbvJsH1X9DeEC+SpKgi7BxC/JdB6nmGwArULLWrMHg9co3jH30r8ayjU1AJk
         0kJGHeljus6cvrX0h4f0DjsWP9H6SOxmTOxk+z+fePB6UHCKrvVBvHlU4qpgXlqotDod
         E7QbBVCsAY4VzQDoH42V4V461vAebbUcGNe/c8FFf/Dt0rs0G9+k95Z3hxPYuxotALyf
         uKcIZbBGQPUG8DMaq0AGS/4AuaNPOjj4Jl39iBPHd7aA1m5CJIGlHWRWMGuVBWkUEve1
         vYJU5sTxZlhpSB0TfPSSneWt8phwSeGrMbNE9Jcswcp4HepCeoLQ6gurWjelk1IRFpV8
         yvhg==
X-Forwarded-Encrypted: i=1; AL+hErFHlHq6Wf6qYNPA2NlHX1v0PG5JggvVQ1SxQpmKcljP2nfljyFvvlqtPARBTvK3syWdEjwUPFxQXbzR@vger.kernel.org
X-Gm-Message-State: APuU4Z9/TRLtIcfKTRGABeGLnMjcrRikFGDZgqAhWbvdBYUV3wSMfQot
	8Sgqe8ksnmMbOIvRk5w0J+XHu0LzQuX/17JAmgqw/n9w09ankGxp+0Lr9ubwHcfKrtk=
X-Gm-Gg: AYBFou279VKCxr3KZIa4Zyi2qgSGu9Q/Om2q7Ar0He7j1boZJFOPy3WXefl8X9gCz55
	2Ei9xsmt87mToHEsYF39fmS4sGcM1Pk/OXiofudaXBnxTpqd9BoepeRDGhmi9PerEzjR7XK65DU
	9XSpFvDQzqNoR3VP5IiKUmX3WMzz1/8VR1t0Ug0fk86JSvDyHBuOSrxfJGyzC3iQMQ2EgwgIT5y
	ZVe7CBjoyTlpModAFO4rVYpIBhp2PmZX2JOmzUQPERvckJY9X2KTqcBwvMmKYnrNly2dDVEAT/i
	pjE6NdLGYpH7njwFFbhYDwlsujRqsqB1EoEk73h3rpl60BpUZIf/Qfn6dwsl354H5yfYw0zS+SB
	1eOq/dR0OoXplCvVC0Bn5xzqJ5PLmPvKndhTk760wfEyQWrSvJJGxIPFZ2KE0hpXgDJbNjc9CR4
	WsptfFSZ/tXlOT+8Q2Nv1GfCkBJnIBbm8kGKs0gA2mEa8SvE+ZkIPHKU4rAT2tk9Bf2zGYhrX2/
	+wahUU4S0HTQnk662YV5ayJv1MwJXcjsn+DH07HZOUCDb5tchyFbb/zrO3Nu6z0SLsCY1/8XuJV
	NPft9trGo2F5OymrYbk85RdI/SuVqc8grjabH0X08Bz/dFcCaymiGp3GePxRAvllCFH4NTpGwYj
	EcC+qWF6p/EboZxbtONay0ef2P1M/NA==
X-Received: by 2002:a05:6000:993:b0:48e:7508:bc20 with SMTP id ffacd0b85a97d-499c38bb64cmr5066357f8f.2.1794413923390;
        Wed, 11 Nov 2026 08:18:43 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f4cbe00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f4c:be00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bd6esm12209506f8f.28.2026.11.11.08.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:18:42 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH 8/9] libceph: fix osdmap use-after-free in ceph_wait_for_latest_osdmap()
Date: Wed, 11 Nov 2026 17:18:29 +0100
Message-ID: <20261111161830.1336485-9-max.kellermann@ionos.com>
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

ceph_wait_for_latest_osdmap() reads osdc->osdmap->epoch without
holding osdc->lock, but ceph_osdc_handle_map() replaces the osdmap and
frees the old one under that lock (held for writing).  The function
waits for the monitor's reply first, so an osdmap update arriving in
the meantime is likely, and the epoch can then be read from freed
memory.

Read the epoch while holding osdc->lock for reading.

Fixes: bb229bbb3bf6 ("libceph: wait for latest osdmap in ceph_monc_blacklist_add()")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 net/ceph/ceph_common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 67e88f30409d..39a0ddde3554 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -863,13 +863,19 @@ int ceph_wait_for_latest_osdmap(struct ceph_client *client,
 				unsigned long timeout)
 {
 	u64 newest_epoch;
+	u32 epoch;
 	int ret;
 
 	ret = ceph_monc_get_version(&client->monc, "osdmap", &newest_epoch);
 	if (ret)
 		return ret;
 
-	if (client->osdc.osdmap->epoch >= newest_epoch)
+	/* ceph_osdc_handle_map() replaces and frees the osdmap */
+	down_read(&client->osdc.lock);
+	epoch = client->osdc.osdmap->epoch;
+	up_read(&client->osdc.lock);
+
+	if (epoch >= newest_epoch)
 		return 0;
 
 	ceph_osdc_maybe_request_map(&client->osdc);
-- 
2.53.0

