Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795369028;
	b=RKOvxtCoGQMM5I7BJZ6JGA+qDxbgHagnPv24f+OtkgDoHKChFy3WVpSaK7RZVwmIQL/j
	 KGuzl05MziGFbjAgS7obJmxpSOzE/Ht1n/8jhxObDWwUwwq/5zYtU6r+zOR0rKTGwn8Y6
	 NoBvf7J45u2vsSqzWXyT2Q+DCFWrmAXYb4ST2RTv3xGwNuuEtl9Z5aht/Ve/IBOBJ6HUR
	 zuLdIr1ML4b/aTBp1GPMrsEZ2p7Yg7bf8Gae9nc2ca/83wojdw7jxb3C5psHXsFh/ll0r
	 W8CvYZMMpIS4fO8Rjlmar2CqGraaDQBzGibWPCsygd9pLs6hRcPrfQe/yuu+adr5rVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795369028;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BbGrtGAYBDXJ6BhsvPEeazwnrpM+UIvWRxiQpjaPFH0=;
	b=PHyk0SUYBDnZuARtMAFDbdWpRgVdHT0SW+YqRNVcWJJba+hCVtddQALhlx5ay9lN5x0F
	 F0LolPStTY2f9EFNg93iTXEpFCnTRjLS7aXVQaInux9KsVMa6YaiUmGFeFxxVSq056paO
	 cybxjaGq7PpKMcvMoUqrnQ4HAMWxfqlwtVzM4HY11c57CV/LQ2XQZPF+mHLbbcf4qmXwy
	 6xlJxJSwp49ERjMCJ3zrXOWTfZsz2NGt9ghgLYGQxT2iBCt9oRpiN5CYoe2SumuqeKxop
	 3b2KiIaQiHpRVyljlwu8iNpPweAp+xobMNYtTYmC7V+eHHpHaktxct12ABZAWH+0FYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HSsR5n+e;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Zdx+hJeE;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AB606A32A
	for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 17:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE2AB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HSsR5n+e;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Zdx+hJeE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795369026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbGrtGAYBDXJ6BhsvPEeazwnrpM+UIvWRxiQpjaPFH0=;
	b=HSsR5n+eMBgLIxK+s2vq2u7KgDqDTdXRv7M3rE5hjBJDUnCtmxldmAhb1I1OExlZyWcRZk
	azajeQL625+E7sWmQgbrFDf8+V4Y6HTsPI6KZYqFJPMpJZmSXeZRqQM/lxZNsh0Z6/Zljr
	2o280ifcGk+8j/wE1SjBWZzxtoIA/nY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-Qu6TBmpMPtC9lYLNgmkeag-1; Sun, 22 Nov 2026 17:37:04 +0000
X-MC-Unique: Qu6TBmpMPtC9lYLNgmkeag-1
X-Mimecast-MFC-AGG-ID: Qu6TBmpMPtC9lYLNgmkeag_1795369024
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-53661e036a2so51785531cf.1
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 09:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795369024; x=1795973824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BbGrtGAYBDXJ6BhsvPEeazwnrpM+UIvWRxiQpjaPFH0=;
        b=Zdx+hJeEh0MenRAqMOKWJk2CUx5CVTYwSVhnSyUaOiXIxCSUWbp4Na9pLorxmly6hO
         mdrGBnD/yz7l82OVYHzDBOaBWRyQqXPfsYzNWareW2vOMCNWFbkm0qrfRbT97mh5U4aB
         UyaIrmOxtoWqLZf6JjML8oRf1+d9CabovBFKTr1AxQcfDlrhU4QPI13j+mni4g4Dkm1M
         wyI0RL+gqySNe39wKZJYHM9TWhdc/AkjdHTR2ywlKSJ9sbT9aaFaVJvF80aZtLyh41S1
         NxS7F5doQYEyYXgV3SiIdzf4TlhtytprQy5GTMwkqgF5FhTouQUN5g34cd1aGukq7a/9
         UB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795369024; x=1795973824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BbGrtGAYBDXJ6BhsvPEeazwnrpM+UIvWRxiQpjaPFH0=;
        b=jnthpFiYwQ4YURPB4F+Km/IGH45xOPjBE5TmLjOZiFSjcuvOj57JEHJilfyUYD3Qj+
         SBrvdflEA6tq4qEGOTwhpnjEEW0hZMvZlqWCZ5serleD69ThregvgLajZ5tryhG2YaD3
         op0/dnViPJtBJ/tCjRAUy4pfiGo0mrpx4MXB1z0TVi5fgeUxbwymP+GhGL19lnTnAoQn
         v99kXHMzmQLnhKHwV0qP9yEm5h+AJISRLJs4Y5bWUY++XvmJastCoP0k/EaKBYnMe5Hi
         hvFWbj9DAf2UAhcqWp0WdIXGzz0bHyIfReGsRgGYZy0f/VyWjJqvRIju4kICfiKtUYrX
         u5AQ==
X-Forwarded-Encrypted: i=1; AL+hErHtpHW77zH8xjyDeLdPiwgNBgoQ79C1zrO063klf/2ic1xvrYIu0+dGGWioilQNY5JbN3JTfQQqR1aK@vger.kernel.org
X-Gm-Message-State: APuU4Z8v23Re6cahiCUrQW1wjTif+qj8KxGgqbHwEEaABlrN+9OMvqec
	pFOANc267iLESqo7XrW6uGVQzbPnDxl7P3MZUmmWfpW9A6EJa28ClAMFBxfJRmBO8FvzUj/EetJ
	Lz2GvlRow0j+gWT5yQmSy11bjxd39MypvEgleH9PSX2qc9iwJztC7abnP+UDb1wo=
X-Gm-Gg: AZFdTZfCjz1KDnUgpDYKIIPzNBNGblIpfGZoBUR+mGl6tPl+Um1yargUMW/G3yKaQBV
	xqNYW4GuIOShEjv9m9vVJowGbX3F74F3XIsrsmmiaoAk4+wsvBoSU6R8VcTxaDEp5vFJitaeINT
	m+UB4vbn4M1UhZdYaXEs6pLOAC8D850c/SH5ohBI5jOFVFMn+3GScES+sfQbJuPKPszvgIYuhAG
	gvXpxX3t3/CcIscZaIgkp2vEGYVgymrjgdRNlhspeJUB+A7vw94O9HhdFUD3Lopqm6248IxKPff
	P7aHeMa97l1MOGXMMOMRDUjfztWoUeRSPtaLAY66TD9IY4n++IqGSy85YVkBt8B8J3F8+LKoBcJ
	OwFSSakTCjRS4aBEWhySPtGEa8zicnEJrBdeQSWoTjRSJEf0BvAVyyDFUCLcZlvMqTvkDv4ugVM
	ZdA2+wd/L0K/rj+7lofjzItepzb94QdGNXgCY40xvApfZsVssMOiEsoRSbknY3XkDUiaaTHoIUu
	zJlftUY3lcIwXO5fTWtkYXlUZy9mFQPpHTBCZ/TVJf3NNm8IQ+4
X-Received: by 2002:a05:622a:308:b0:55b:f621:e7cb with SMTP id d75a77b69052e-55d76a6e9eemr177660931cf.21.1795369023894;
        Sun, 22 Nov 2026 09:37:03 -0800 (PST)
X-Received: by 2002:a05:622a:308:b0:55b:f621:e7cb with SMTP id d75a77b69052e-55d76a6e9eemr177660721cf.21.1795369023504;
        Sun, 22 Nov 2026 09:37:03 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7c654585sm71310051cf.5.2026.11.22.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:37:03 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Daolong Zhang <dlzhangak@isoftstone.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: add compression_hint mount option
Date: Sun, 22 Nov 2026 17:37:00 +0000
Message-Id: <20261122173700.1281165-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1795169573.6B001D21.006.4jWB3k0l79z3mds@fangwg01>
References: <1795169573.6B001D21.006.4jWB3k0l79z3mds@fangwg01>
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

Hi Daolong,

If a mount starts with compression_hint=compressible and is later
reconfigured without that option, ceph_init_fs_context() allocates a
zeroed options structure and ceph_reconfigure_fc() unconditionally
copies its alloc_hint_flags into the live mount. The reconfiguration
therefore clears the selected hint, so later writes stop sending it even
though the compression option was not changed.

Could the existing value be preserved when the option is omitted, while
still allowing compression_hint=none to clear it explicitly?

Could you also check that the patch applies cleanly to the latest
ceph-client testing branch?

Thanks,
Alex

