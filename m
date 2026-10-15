Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094A56853B
	for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792086676; cv=none; b=jwGcRaDuVpSv2UDU+K/kZxPx7Uxb8wUaEPRFLcUA4GQ2Obh1Zxqfefvm/Ptr9I1YFwf82oN3V1hb1uOHxVc+yvF3xdmr21V/FfgKWOW6MxqjPz52lnpsw+9JOe3BNqgCOP4w1r7jODNkYS9EK8lNzlRHC0Ve8ujyQX1Udc33Oqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792086676; c=relaxed/simple;
	bh=8Fy0rflHfxw9J4RwOgBEcA/HQ7YuoXLUmYdZgzbU5BE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=scDZefTqwEFj1+4oEuLxhjmgonCou7v8C0AvEjA+5A3BNgfrGHjIGu/j/Zer2QGec04lRUsjfS7jOKY1w7wLyXUo6uU9h2luQBY2PwHJdLTCYS51Tgoa8/9IPVqKpclWRBHezIHPolDbXsTTBjmpQ/pv34S5K3NHVAQTcRLZp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X1anKXeR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IJqiH/fl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1anKXeR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJqiH/fl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792086664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0w/I8rtyWHulp/P/42hdbsoBEEdQyregUdltmPb4L3o=;
	b=X1anKXeRPjIzBNHktp17sEZxsAHQQdSYzv6ZlqIx62I+j/X6CgjEEdONpYDYtpVE/kA4QK
	4IqZYX4si4VmKWEUZjmLWlx6hXkqNqd6laJv2tNG2qp0yYwBXYYshTvZ453Vm+KWm/NARi
	LfYRN9608OriW7Zw09lhh+foGANFeV0=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-MUNTOuCtPTad02TixOlr7Q-1; Thu, 15 Oct 2026 17:51:03 +0000
X-MC-Unique: MUNTOuCtPTad02TixOlr7Q-1
X-Mimecast-MFC-AGG-ID: MUNTOuCtPTad02TixOlr7Q_1792086662
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-35d4538fd74so6685601eec.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2026 10:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792086662; x=1792691462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0w/I8rtyWHulp/P/42hdbsoBEEdQyregUdltmPb4L3o=;
        b=IJqiH/flsrGWsauBfeiItU4tC/u8ADWEsw+AO2WDkM6NmlAuEZGIIPvPM47sjyVVzV
         HiHI+mV61pmBOac5HxTjZ7eEljF2cJi4grMryBRzKDKyiB2C6dch7YcsSdB9rBvCMXkD
         jCf3/QI8wFHwexUj7vCfR0AM9+a6Nftc+PCFxqzDX17qgtauDHGql3Ye5c5u2BIzhMSs
         d5/2aF48xG4p7a2N3U/PkFHBhUps5xFjEA+Z645w0NYTE+hj0DuTFDKNbPXcP3QVgftD
         RalqSGAGS3B0Bzwi9QXyVavrewW1wMBCzdqY3PJiTKIrJkC0rxrMnbToUUdTjkuBUKT0
         ZkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792086662; x=1792691462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0w/I8rtyWHulp/P/42hdbsoBEEdQyregUdltmPb4L3o=;
        b=rdAXG9cPflHCz3aOtpL6MGRz94U/AEEyO2U3Fscd2IFMfF+pOKdohuenddsh+QtdEb
         X2erNxM+iDhAsUbv8I13bdwMVuhVBGlNXum0+QOs/pQImQs3kXLqEe5zMcTORutYLmem
         ssdnLvPBdGhM9xkLrprvyGZMIEINuDWrXpOAlwH2b2pesjpsLMgXxp1S2clYG7oPv+If
         vwFld4XzOfr6XVFfIYo/fuwUvpG4FMpCR+WUBnV+s+tcPOQhKSmv13nsXalHEjSQHq2R
         mBVlo+Muthpv8y+Aa8koJ8B5WFCsrZm3wxqy7GXXzy9+QkwUPiZ2ErIkOmf5ELDz6fGN
         +2oQ==
X-Gm-Message-State: AFq9FYIhX2FvdIBk1vLityvl3nMZLtM9Cvapy25H0Hqo6oSli5g5tDXc
	JjkoySgL/c+/cEvUXIaH5OCoygs73Tod3M7LFV+IT/KrFdwZNVjKfYzA27xBX8DQPdXecOKulDK
	R9TXa9wY3D4IvwfDmIbMqzGVmA06TerJAd2KDCakU5MMKkv8as4tOmQQbKC+FaNyI/y1GSpi3Z0
	TkXfgC8jUarazxs+r5aR3u1UnJ5u6pvkX9s6MqBXnOCX+3rM9QhA==
X-Gm-Gg: AYBFou2Z/s8HCdSvZU+o92GB/TITfNcbaF/WBHhPhokehXH+wncuuG6Q8xvpACPbRG6
	FKuSMEfyQaTh04xlsM6/1rc8MV+6RvT856WvfLcLJrj20tKgFOUZIuEnZ/++oQx/yMMOltaaTCz
	eSEDbhYyG7QaCKTVBLV2aSePtKwWd3kk/UhOMjSxEY7dyCYQEUmebHqc2Yx7gdMdogNcFEk6wGa
	wbRjgT5xu0d5rUue+UcDMVOUqD3kiEBIhRQUmtVl+7oDhLsq87vt8XSb7epC6vLLs3VZYwv6XzB
	cbNnPsw3GhsksSB0UuEPZH7pN3PE9DoFYqOW1SJJFfAlDYdA/XwUnHhBajDPTzRgA2Ok6mkZcUG
	gkvKud7Nos2EGy2VB828AHiWTbX7iD45y7dT2UeTyoII6mvQQLpTkxTcBBi2NwYNDfilSmVCB37
	dzzutEtAydU1/aah9eUVR0LrD52eL2A2Zz8UQp6zIeojzKIpD4wri3uUtSfqwObzwVWKxHTv+Wf
	60=
X-Received: by 2002:a05:7300:55a5:b0:35a:29b6:b466 with SMTP id 5a478bee46e88-35a29b6c486mr16512149eec.30.1792086661756;
        Thu, 15 Oct 2026 10:51:01 -0700 (PDT)
X-Received: by 2002:a05:7300:55a5:b0:35a:29b6:b466 with SMTP id 5a478bee46e88-35a29b6c486mr16512098eec.30.1792086660838;
        Thu, 15 Oct 2026 10:51:00 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3605898ade0sm417355eec.24.2026.10.15.10.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:51:00 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Xiubo Li <xiubo.li@clyso.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH] ceph: fix uninitialized err in ceph_netfs_issue_read()
Date: Thu, 15 Oct 2026 17:50:56 +0000
Message-Id: <20261015175056.156195-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261015061805.3366-1-kmehltretter@gmail.com>
References: <20261015061805.3366-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_netfs_issue_read() declares err without an initializer. On the
unencrypted, non-sparse success path nothing assigns it, then the
out: label does if (err) netfs_read_subreq_terminated(subreq).

With CONFIG_INIT_STACK_ALL_PATTERN, err is 0xaaaaaaaa (nonzero), so
the subrequest is terminated while the OSD READ is still in flight.
netfs then frees the rolling buffer that the OSD iterator still
points at, causing a KASAN UAF / oops, and finish_netfs_read()
terminates the same subrequest a second time. CONFIG_INIT_STACK_ALL_ZERO
hides it because err happens to be 0.

Restore the err = 0 initializer so a successful submit leaves
completion to finish_netfs_read() only.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index dd2bd8ed2424..55226eecd090 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -392,7 +392,7 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
 	struct ceph_client *cl = fsc->client;
 	struct ceph_osd_request *req = NULL;
 	struct ceph_vino vino = ceph_vino(inode);
-	int err;
+	int err = 0;
 	u64 len;
 	bool sparse = IS_ENCRYPTED(inode) || ceph_test_mount_opt(fsc, SPARSEREAD);
 	u64 off = subreq->start;
-- 
2.34.1

