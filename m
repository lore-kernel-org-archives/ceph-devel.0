Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795376316;
	b=nbv9DgGAodS3QPm4eIRxGl4/IWK6Ny0jXM/8F70oedqpY85astfeYWEzDxYb/+CjL35k
	 Uo4+VU8i31tY3JvmByUsT8cX0xjCq61zesdlsytLKOU4tIJZOcCdXsVI9zXzbyRBgh6iF
	 X8ucsrI2abIjqgHlElbbCiK7fWd0D7QwXE2+b8eEWf9oHkeirJTk1xUArVUVzjrT4EPgp
	 hc38lOBes01fo0Jtb5u38KXYLRFzs+C0AHCwKc7cl0lRop0B2kEJADP+33kpLTrn35n4U
	 hbpYX+4MiVA5ArFY6wvKhCUmfHoOzb3p1XFFEfGvamY/R1MG1vptDiwJXXpYFSdrSTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795376316;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tcHY8ySguSV5bs++kGDNGH1lzJuHpk5Uq6ws1QUg8Sw=;
	b=KhI2Iq/OcTMJLm2HeZN9XAEnQzPF77dxfPrjZl0IXl2nY4YppU/bF8HmA4WKs6Rx5Otr
	 uUYb/aQJhK2q+ZS/4LQZ/BlSplXcESN2X7WyoJLrY6MeKcRPIXn9No1LZzkDybyRCzxLi
	 VNFlSZv48rcKbT8IN1CqMEolRorP+Dl3vODWH2aU/CblpFp4t7LaD06r5nR8m00PJq0+1
	 M1Xr7XWTdsBu4W3aZnhfVtDeM6kCXuF1KMi9EtFstSrp5G056WwBtYgrBmlSDbrcDpG3y
	 S6GJ94PYuyoNcjyE+tWLEVNmnoHxdjHkx4RPFutSOHNzmnRX2MP5/5QCDHx90L10ZAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K4nabTcZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B0Vn3vMi;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA1F606A31A
	for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 19:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEA1F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K4nabTcZ;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=B0Vn3vMi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795376314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tcHY8ySguSV5bs++kGDNGH1lzJuHpk5Uq6ws1QUg8Sw=;
	b=K4nabTcZc5GhqIOGY2U8QAq2ZNxfdrJu31siiL3mmImQlKq5aE0jJD0RKjqe5VlUGVdWpk
	tyGA53G1Md/0bf98LJwdqssfj3aCcUZ8GID2+vOBfqJAUQb3Eb6Nsjb93WM2V9JwSfQyvu
	0P3dDDjc9v2etsiBXqIrAnh3FHJSrSs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-9ysyAGEYPjSa2Q9fmCV6KA-1; Sun, 22 Nov 2026 19:38:32 +0000
X-MC-Unique: 9ysyAGEYPjSa2Q9fmCV6KA-1
X-Mimecast-MFC-AGG-ID: 9ysyAGEYPjSa2Q9fmCV6KA_1795376311
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6ba62acd927so1528238a12.3
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 11:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795376311; x=1795981111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tcHY8ySguSV5bs++kGDNGH1lzJuHpk5Uq6ws1QUg8Sw=;
        b=B0Vn3vMievd8S1JDBAXzMOwQbWpX3ytqBuazD/8HjinR6Fq+7fXce83cRgK2gU9HTA
         ev2JpY9Hb70SgWOmTU7mnWsWxVuU2NwoSM/bYnkz6QpZ6yc9KV7cAGGDBc/jAxFgEK43
         idweZzF7ZCcK0z1zT2yqpxHI8qnxBWtsFg6oQ57B+8MbAPXIx+yzu4ZOtqfQrSRNVM0Y
         cROZK4M/AmehX7M0tcOnnVeT7XTUFwd+r9f1R5kYVLO32u87ddQV4Hg9bmlobpXDcnfs
         27TSGSQhcPT8NJdyJVKBRcAzfX01s6n+Jv1x8in7EBbsb20GtTEa+LKzb+HQQFrcmy9O
         FdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795376311; x=1795981111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tcHY8ySguSV5bs++kGDNGH1lzJuHpk5Uq6ws1QUg8Sw=;
        b=YwTAtgX7bznukTqMWLxnqhtDAePG22+BnlkNWo5Pk73SuyV254xDk7wKMvBlxnGyob
         NAZHSineKvfATbWV8X/DfG+W9eIH6gZAQU2s0ZmfO0I62mE5mcGS/ieVrz18BZEAXRS/
         xXmJUfv2J09JLrlmE6dSexwt9YwAt7aQwXM8JmGqB3U0813jRc6xijUU0lNKhAbN4Bam
         Wn4pRc2bIieM/bDukE3ltNyP5Sv3Qx8qcG/o6czjwEinjWutLP34yOzJrBsF8eY7x/aP
         g7Zikle/lYNsOBuBsJrUvJ2Dlkdih0xjLzibEd2NT+OykjGmwvkWJwb8kFyQ+Wdsg4vs
         v+QQ==
X-Forwarded-Encrypted: i=1; AL+hErGueaepVthVWnKlU73qA2FxaM5Zhp9EdskEHyn1gJkC31G82j8hc0gPxCviVinzRDnwt9sptu6d+41w@vger.kernel.org
X-Gm-Message-State: APuU4Z8sg3o6uXXtBa2hEx9jskaKrVNmc7MoIUYaiOBMAcX7QqY48Buv
	4W9xgAbxztuFvMcQTLv5hY4CrPs+7WU5oChyHTR+f6+90p1L7pUY+TWD/BpgzlmPhSstseLxJlM
	v2kH46EP84AGPJM0tFSN4RfkNz3LARNny4jksQejOy6HVn/1NI3ZCCnEffNXatKo=
X-Gm-Gg: AZFdTZcdrbJxQQ5Lm/TyuJuWz2Z/akGyecfA9Ni1nXPuIJkPza+CsFHC1XgTwJs4NET
	3NKOahL1nqmk1FuHb9t4sAN73ZHPS73eIj+TDJ5D6ENAPMfkqV1+z2GobYjk7SFKkm4M2MfeTAR
	deVu3QRu4HYGK+yXVy3xZvrIxveab8PiE6cwcuo0g4G4zeU2CIOCPpDnZRb86jVJVs5/fblfsDb
	kF6bd4VQdCZFvAKb9IwMlCy1ZjDH35uD72e0FH6EgH200oxkgSfKr2SDYSIz2zazS8sBW10S6I+
	Vepj0NkAuBKPqE8UI5eJBbFkKA31kXTTAdO8k5VEytcYVh99WJ4Ls0S8JfSTETwE3zbX50QnvMn
	ifBc82PAKFCeP3XsIfohbcggUgHJzS63ewXIK679pVS4+PCW2YFTBw7ftCu8CLmHs4ld8xWZoLQ
	2vOgsQt/sjG1rAO0HQAdDw4TwbS1LnFSQqKOiwE+ZLZ/wkE1H98lW5onK93o839IriILWlCGAqm
	nR7azVjdNSrYKSJSRMyjNAOs9s+Ynan8RBnKvYDdmjHVHxNJOv6
X-Received: by 2002:a17:906:6dc1:b0:c46:9876:e9b1 with SMTP id a640c23a62f3a-c513aad1c20mr553233566b.43.1795376311439;
        Sun, 22 Nov 2026 11:38:31 -0800 (PST)
X-Received: by 2002:a17:906:6dc1:b0:c46:9876:e9b1 with SMTP id a640c23a62f3a-c513aad1c20mr553232866b.43.1795376311100;
        Sun, 22 Nov 2026 11:38:31 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ad01afbsm342072466b.5.2026.11.22.11.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 11:38:30 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: zhangdaolong <dlzhangak@isoftstone.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ceph: fix inode and i_filelock_ref leak on file lock rollback
Date: Sun, 22 Nov 2026 19:38:28 +0000
Message-Id: <20261122193828.1324376-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <1793858040.6AEC19F5.003.4jKs1y00vLz3CgW@fangwg01>
References: <1793858040.6AEC19F5.003.4jKs1y00vLz3CgW@fangwg01>
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

NACK. The rollback leak is real, but skipping fl_copy_lock() for every
unlock is not the right fix.

try_unlock_file() removes the local lock before the MDS unlock is sent.
The temporary i_filelock_ref keeps the auth cap from being trimmed during
that request. Without it, another cap can cover the bits the request is
using, and the auth cap can be released while the unlock is still in
flight. A second lock from the same client can then be granted without a
new auth cap. Processing that cap release removes every advisory lock the
client holds on the inode, including the new one. The new lock remains
installed locally, so another client can be granted a conflicting lock.

The guard in ceph_fl_copy_lock() already stops a second reference when the
request lock is attached. That covers the rollback. Please keep the
reference for an ordinary unlock.

Thanks,
Alex

