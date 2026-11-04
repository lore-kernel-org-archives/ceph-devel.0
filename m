Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793797626;
	b=H7fs/PbFyio7F/d94866vCAheG1lvgrsC5x6s6p9qH8A9iO5cv4gDL+hpz3dt01ZObDl
	 sdftjYG2GQGqWD9DQtG9hbt9vhKwnhtzZokqHudhA3Dha9NzWhQpbuJaOL5jc8PlBTU9S
	 vfVoLNQRmHFo1ynH7pukKb6NmLazGc+5UWt3C3kJCc7fYY5ajOcq6XyIQfxUbQLd5hf/y
	 82GtokMF0JUlPq/Kl3YGByEFsOcDOqX6zbbeQ2/KaCqQr8jOgOGbUG3/i2Rq1Q91f3NPE
	 w/MhJjOj9hmKSNYmzQJB7/m1QOu3mn51zukKBIKvBH+wRUMMA8C4lsX7K6wN4nnT1cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793797626;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=N+AMljX3Rr1ApSBVoa8DYAxeqnDMufje5SScB7xrnN8=;
	b=iSnN9bFRdUllpXDHd0KRDp+rpow5K2+R5qm12RalKDoa1Hs5uedTAxVqztvsZWqK+7eS
	 HtnSE8fVBLuPPDd9A4JJspOYE+ngPv7Q3v2CmbWA9MrGuXrK4LpnuQgdiN4HPr0vRGatz
	 qg10RFjBSOolQDD7UM1OjHiqd1WfN2AiFqQ4CWwKFTMVnPpCedhN0Gfkm30bVp4iwJWlm
	 w0+OHJJTAe0T3ogvUYatY9PorSiudDkwFHaH5rmMi2EdvC4417Fj2wtuf5srgnGKAN8Ea
	 snAiwxwR+nYoHeE1haLNht13XoVvMLXC+DZJTsOJ97kCQydNzxrflIIrMN6M3/E9o0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hk0r0ZqW;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="ZmRfLQ/I";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39387606A336
	for <ceph-devel@vger.kernel.org>; Wed,  4 Nov 2026 13:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39387606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hk0r0ZqW;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ZmRfLQ/I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793797625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N+AMljX3Rr1ApSBVoa8DYAxeqnDMufje5SScB7xrnN8=;
	b=hk0r0ZqWqycmNXECFALyOdURq3+r8TcsU/ShjCw8C/SZrjA9jBl1FHUlC5DLTpFBDiJT+p
	T5LILeLkeuOcJlYCc1DPB5kDEKh7Cwb1d7QKE/eZAWAR9ngz4Y2jBIIm7H0O61Lr18Sz/o
	5BApEHmMhrrzQkiHDGYEADIs/tEuqlA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-3eg8xkb8NOGUVAo1WtGAMQ-1; Wed, 04 Nov 2026 08:07:03 -0500
X-MC-Unique: 3eg8xkb8NOGUVAo1WtGAMQ-1
X-Mimecast-MFC-AGG-ID: 3eg8xkb8NOGUVAo1WtGAMQ_1793797623
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b3f6d9827eso649862a12.2
        for <ceph-devel@vger.kernel.org>; Wed, 04 Nov 2026 05:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793797623; x=1794402423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+AMljX3Rr1ApSBVoa8DYAxeqnDMufje5SScB7xrnN8=;
        b=ZmRfLQ/I6LeBxy8Kp29g8pNV6Th/FqE0mQaZFuQJSGpYvq6R/Hx9VAQlAfQs9C48YA
         kh+WKjjigXwO4gJHokUtuSU8urD8wXSw996JIn58L24l/8NLkCDBVCgxzOW3f7Len8+O
         0Qc+ou7XsimqxE2w5V955fagp7ZdXuh9SuNu5z3zqU7dk1xHNSu47xguzKskmzwra4UF
         ZDmewfJoUHG/o4sevuOW9udslwoiZinOAweFYPvNf+wtvcSfs4Def7z0AyPoMAVLK5//
         /P8iny840VWw1k3xSGZl6LEs49dvJCm5e4jiM3AC2T1TlSomZ1ycCUEDs6fwrgA6puTq
         bw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793797623; x=1794402423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+AMljX3Rr1ApSBVoa8DYAxeqnDMufje5SScB7xrnN8=;
        b=runVbTMjmhYPYkKj7vJ/FshDOi4KvQ3NRprZXCVoyNJ+WrNrkrFqT8I4MyqErdhNC0
         AEhrSa4Ah8bLLE96JgHzWIYoTh4tJKq2GW6OVl5Mz5p30d9FgY6b026HcxhWaJ/0cc3j
         tTe+b1n0zKuTJjbJmLQKeq4LgnXVRr/Hw6DhAZgkDpRkRiPf8sAhPE9q8z8KkxHNMDvU
         zGOoyT/3b6LALIbBvDHCiXRfLNN7PTR7fRP6DpCTzu/rRkjs/ib+D8TcMgavSjzsfkEP
         w0rvSAUUOj0WU6Mr/OZYmWo5nPgp2Bec89ic4rB6CGAcO8b4FfpDNl0AAWCZhCVD91J6
         1ghQ==
X-Gm-Message-State: APuU4Z+Zg4LzDI7OQMbAme88OoXfU8LB9dJuOPnAXiYnHD/WnDRZBfUt
	Rjcc2f00GLdlDm/dcTpF0Bdb2fQXj7AA77LIczMQ+H7bbw5ybR6btOBMYkg28lvR40KyRDoytNG
	ClXTn1cqsVKjZkijO5Sc7U59J2cCNZhmoC55VVBftZ5PMfOsKDuhiL2H9+Hws6Tc=
X-Gm-Gg: AYBFou0NOWY2VdrjC1n+s9gPslNvfnacTGdK7+U8b0+jwfzEECPjHQhk4jHn7Ecctrq
	Qkb3U69DD5W4bYTVkp6mvQJLJ4GcDXYkVPbcBLMpXITy24oKItul5+MKyYKUvriGuAi2jL6o9uW
	5DyrJ67qDrEhAITjpuQiMrJNAsu8rza1TR/mHlqG7GdiaCDvVVzZ2htjWH7sqYeRliigBEc9P4f
	L8jq36dAXQO0B5wklVN5PgViWfVF3tZCrB9BxZfsU5VrRTENMWuktf38GmhnMEFoScxXUR9mjaA
	RfueOlJJrvomzImj8VnMJRdbPOKw3Rylt5jI8suZ4nvcOd6TdhHsiAqgE14lvmlpOQroUSa2iPX
	/YVVK7UgQ2D01vBo0Z+BV0u173k061Cf8UJTM0EFP+JXZnkFy+RURAAiUEk2MwRlHJUjA3NRM0P
	fjAl55AU8xj3pnmFYoweW/RA0MGt6pD2gX2iCVuSpUlovBIEJ0XjpebbzSy0ftOQF04d/AWgcLm
	aPpCeFjNMuBeLsFKII0S3l5+aWKSQm2MEOt2/TMxZemoqNA9of5
X-Received: by 2002:a05:6402:3221:b0:6b5:6614:f5e6 with SMTP id 4fb4d7f45d1cf-6b56614f740mr1041259a12.7.1793797622879;
        Wed, 04 Nov 2026 05:07:02 -0800 (PST)
X-Received: by 2002:a05:6402:3221:b0:6b5:6614:f5e6 with SMTP id 4fb4d7f45d1cf-6b56614f740mr1041251a12.7.1793797622521;
        Wed, 04 Nov 2026 05:07:02 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b561955d0csm452116a12.8.2026.11.04.05.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 05:07:01 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: drop the mds request if the inline read getattr fails
Date: Wed,  4 Nov 2026 13:07:00 +0000
Message-Id: <20261104130700.1099418-1-amarkuze@redhat.com>
In-Reply-To: <20261104021529.1468722-1-vulab@iscas.ac.cn>
References: <20261104021529.1468722-1-vulab@iscas.ac.cn>
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

Hi Wentao,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

