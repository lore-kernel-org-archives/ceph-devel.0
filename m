Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341465;
	b=N+7ZAoDiYxcGyrzz+hnfjqKKG4NHbUs28M3Ai8MVrYp0220I3PN83HNmJLJPchlD7//a
	 yyymrtFWv1/3YzhN3td7G6djxBMqBRQ2Im7oqs9zY/09c7FPstasQWcr4LrVB+72iY+ua
	 mg0FvLxGKmNrXWXr7kM5NFy6tMuXXpYuHxS3J3W1RmkAfKI8kplmvPn2evkqZVdutEfuL
	 2zRd6MUuHI7wSEIWsFLN0Does3Rx7Y3N4I2iWtZDcrkGzER3lWwQENa7m8dRDscJOqqFV
	 y2gYOtuY+ib2V8Ks/NzjK9AjE7ph4Thy9fj1UHimIX3WWHvBoxy6AQkfOHrjJcGyEVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=S7zqB5SvRtnuqQjx4/vkTzi7+UFhTC8EsGHBx1Mz340=;
	b=Lvl3NZZwFu5ZAeCMKNfRR7svhhhBEeaacsIr0LFZ7y5IrdNco0cowlgHNQLZBoehpBoR
	 rNpX8AtumWM4V3AO2a6ym7fFMlmXebC0hM2zMmrRhu1Ir/0QAZKGHairUwKiaL7WnPVj5
	 MzkWRbliQjb2g1wB3vRsqSTYyjoTCFD3HTVG0Wfc/7ZTYW4VdiZKJDWZxWm/c5P1F5jV5
	 U/um3TuGYKxzlwBN9lfEAyDR22xz4wOMVtOPiWRzL6O8YHRHoj/OU0MiS1Qu/iNbYuhPN
	 ysj7QdtKtmonuaIg7WnpJEZ21408dZcbhCI9JK5DDpMdaTk9e8xvkhHRiEpdOy2ZsUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmwSTMhe;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4B606A320
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 20:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4D4B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HmwSTMhe
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f3c616c84so228709685a.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 12:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794341463; x=1794946263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S7zqB5SvRtnuqQjx4/vkTzi7+UFhTC8EsGHBx1Mz340=;
        b=HmwSTMheNwcrpeFLVNfMVoTvpSIiDea4eZJjTAeJCfTfsP0XiArNoUv7FKXbJwpYqc
         ngDhwcGksCyZblDXM8zV1Ghz7VN78rJqbkRzhx9NpdB1Y+zYrIkAnTn/bCP1AU1wJ+4o
         w/bQcgvTHyhWuAN4LQkpiVnGQHIDdqU+iacnnAYzpm6ahbKk5qH+8h6VNz4v+6PsmDEY
         5Tfevxwxkbpy/+VtfMx5HW/UgZm7Grm71KQNRr6SNVaaXqZntaHFTOzpSWcVx2TaMw30
         Rr/6tjcLvcZnFiThSCKFcKroxz6uyEkbXModSpnvmC66LNp+jkM0VTU8ratbl0WbsI7q
         fpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341463; x=1794946263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7zqB5SvRtnuqQjx4/vkTzi7+UFhTC8EsGHBx1Mz340=;
        b=t00vbEAosVNN6PvOXWj9Rd/B2hdVfESOCGL1bV+dVddb7OPAPSuLYDrxlT3NGmR3rV
         shY8xs9pgezT8p/lh1O01yhpOCMbG2IeG60tgBNpxsj4lA/B7ee9uaCqTTbtGQlacfnN
         Lo1WOLvGQXhxIbjjmKzY1KaG6YanuGAb2Bk89dv9spGTNaUZqOD5SoiGiumSrO0et9wC
         X697/OHk0DlfzmVdgb0sLdG7y27SxayK8vt9xxeNtuBRGRBl7Uc+7YdOFwbuuyRvGscb
         kqIeCOu1oQDlaxnDQCgMubqtEbLCMc0LoRoJHbG5yJvtG9K0BT9lvmuXyl+1ewAgkMC9
         lIPg==
X-Gm-Message-State: APuU4Z/TTmdL9iqFXd3WASKo9U0KNOZ2YzqqA2+lo4C/xeYRKgpAcDAS
	3ZTQzu1zeMfp/fEebt3SbA/5rI32vI5Z9uOrhlAnSmQzs24RE0JM1zkjL25Df5EO
X-Gm-Gg: AYBFou03tpFF48fBNyKVUaME14PGsdi+VqxAuE2aNEpOAaPBeDl644g0nlC5/YU5JCi
	fn9plR+sSaaKNvvgJkBKlmFfLoPQ14esL6gAsxNq0owlQW2xfkRk6VSv5A0XYvCUdXpbMfIXVw6
	rVX5ZB6IOM71J6siqQlB7VaU29XhbZPTPJR6ylA+TXvNBNaxIl1Pp3+Q5blnJAOejZqHqd9HUHZ
	LSx4GIW813eeKcEEwBk4Yorc2mBNg8CXqa8NjrAdLuCC8CzQuYjY6rPs7c5+IID1GJaAKV9DYcN
	xcQnf5gpcWvD3m6JjKIOTW2omY5SccCmXhNcohNAzduou5o2L0tT8jZz8lS1J/HjDZUbHjpZX1+
	uDgl321+GExTl1/LVYvNpD8IFq1f0aLz0ogGxIBZCiMsZXCE3tDB5D14RVoWKs/WLeYIjVKxw6a
	Ik/jkFl5rHEuo7HBIc9O51Mmimc1apwO8W7BNcu4fJGBgwx4w/VWJsdKl/GHmBJZVLTt9/LpXK0
	mmykItS6rJ2hPSKVhHFeUhkxHt5Ej/m8z9bquPJb7IOH1E/gDcBjzquHLis6Xb7EmBQB1RPiBEw
	aXWgr6nTXBZLLeBLM80yO3iQCl5eJph6UJUQAvJRdVIoqQTVY6QV
X-Received: by 2002:a05:620a:8089:b0:93e:8614:bbe7 with SMTP id af79cd13be357-947afb8bfe4mr16005385a.12.1794341463584;
        Tue, 10 Nov 2026 12:11:03 -0800 (PST)
Received: from zambezi.front.sepia.ceph.com ([2a02:8308:b10e:9400:faf:460b:2f23:8f6f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73c84bsm301815085a.9.2026.11.10.12.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:11:02 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH 0/3] libceph: allow for multiple in-flight linger pings
Date: Tue, 10 Nov 2026 21:10:13 +0100
Message-ID: <20261110201025.255594-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Hello,

This change significantly reduces the risk of erroneous blocklisting in
environments with high latency or where low/moderate latency is coupled
with huge spikes for RBD images with exclusive-lock feature enabled.

Thanks,

                Ilya


Ilya Dryomov (3):
  libceph: replace lreq->ping_sent with req->r_start_stamp
  libceph: don't cancel in-flight ping in send_linger_ping()
  libceph: include current latency in debugfs osdc dump

 include/linux/ceph/osd_client.h |  4 +-
 net/ceph/debugfs.c              | 12 ++++-
 net/ceph/osd_client.c           | 87 +++++++++++++++------------------
 3 files changed, 51 insertions(+), 52 deletions(-)

-- 
2.55.0

