Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795379245;
	b=CBL6VFoKethj6NByfilRP6HfJmKcGsArIpfyghSRZzTnL090oOOpdaa/sIofk4VSUMPo
	 D5K6Bk8SL8kN9PyjRugYmK0wS46IRuaB8XWEuP5DotdwvBiKsfEVqWNJzKPT4nQowtZvH
	 qPlPj6cfV/rYXRhm0iAxk6+2ge7vWA9t07rBd+pPpeoTMMMIlvF7Bvo6KvYnha2YOHEjw
	 NYJQ9uOuxfHdPnnkmE5MPnyyG71KbVa0Yg1baB7PKvOmlhqsFiGf8MjiYjGUYV2PklBxW
	 bo+jAd/0i66Xq0tuzXV99CQC06plgIt07CjqqkRjXrip+x5yqxhm9PZ0ewFtFnqI0Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795379245;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sQDVuZluf8hD6XSUePZUWArQRh9PmFlRuzSAFyE+NUg=;
	b=qI5MhzyiLSvLqJyUcCL0FOqE76P1DXbeaz4xxUrUCLNluxnyKDoSzAP2e1KYqRtaEvE4
	 tIHK0dAG45PM/pz4Z3KKS4VQkfRspaTq5GoAlsUaJv8vk11yHq94xUyFb/a1f5EYjIewD
	 I0FGAoUvKIkSBRbPGc8FrgIT2d8oFz7cGInJVGP8gSH0Arogmy3J/cbUeen5p/GI08sZT
	 Is41UBH4+I1dIaW0takJsgi9IJ0fW+k5E3iprC4HzkkPB4JMgE9gjRuGYFiccN/5YSVy8
	 +OTVpSvhY/VEJoG5JQcjgDhEaap6ReW1vAwBSbduuoLXawrDBdnkJWVDklQYhWFJ8fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NQmxrlnO;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="LRGcPHw/";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4E606A31A
	for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 20:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C4E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NQmxrlnO;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=LRGcPHw/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795379243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQDVuZluf8hD6XSUePZUWArQRh9PmFlRuzSAFyE+NUg=;
	b=NQmxrlnO/HKKzHRCAMJ1IDAllgRkZ4erJGrJyevOZ6xkEgRsP+Q7I7iEM/C3f2uEmKDOiJ
	0DtED1UTO0BO9kcMhLLsJsyp3XCcjzx4++wLBjvSbGARYUH9EedgK3PFBs47xHUmbD6zFb
	1zcMJU8ukaQANKiz/D2jaKcLfvtIKXE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-90a-3OYgNlKkJmiuuaANPw-1; Sun, 22 Nov 2026 20:27:21 +0000
X-MC-Unique: 90a-3OYgNlKkJmiuuaANPw-1
X-Mimecast-MFC-AGG-ID: 90a-3OYgNlKkJmiuuaANPw_1795379240
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c50657eaef0so209471366b.3
        for <ceph-devel@vger.kernel.org>; Sun, 22 Nov 2026 12:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795379240; x=1795984040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQDVuZluf8hD6XSUePZUWArQRh9PmFlRuzSAFyE+NUg=;
        b=LRGcPHw/H4+m+odH3yKftlntTxHBu04oyLIpjZx/2Ho5eCVeNY5YZoMJAjCIkYr/53
         KJtbsrzSc3mKURMiXc7JrtDFpyhzpqhKoVkmnoVdf/nrqMWNDhmidY9kRmDNlczYw8f/
         Y829P8WUiNouvqkVr2ip6Tr0r6h+eGcBkEP/rdyNu9MFwYM20e6WwdlDOllE5vEhxBuY
         gbJGpxNBvHBPuzKaMsTf5a8zWsqN1DDAn/7V4nBXFH5dSSVUYDw9vnW+pEgtlm2myjbT
         GpkIJLXWDz8WGZAfz949octZuTgAR3PMZlWnJNhawSXZBKWDjHtKzLbpxzDtFW07Lxge
         TELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795379240; x=1795984040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQDVuZluf8hD6XSUePZUWArQRh9PmFlRuzSAFyE+NUg=;
        b=qPvvomDv8la/AOz5LL3F/QvpUxLlwXeSD9OraiYrdgdb/AG07DUf4lZ4r6CwIyMJrx
         RTnnZWMGbQarTqT0ecZU/c4FoiSy0uwD+0/LHkShaPMhfyaTFVE/UPvTO3oyY3g7I8FD
         ab7zSgxqHf4hsh/+ejJewAg9NPBH83mSqg2ws7k9w/lJaBIAQKrotYMhyG0bpnkPvxIo
         57Y5wk8lHDE0Fbf7ooNNTIKXCg3uFJGazwkApnc3FzMVMMeF0Q4ABBuWtAfsBn235bgM
         qvoD8QqyI5cM4mCu4E2SgdtT1sgKs9PzDvWc4EfuTA0InUboOuMe9mM1xbQawrp/jAJN
         l3DA==
X-Forwarded-Encrypted: i=1; AL+hErFtaAWjUO+ccBdfVofzOtoo6K7F9EBbqm7X6gXHJdW5yTnHHNyypMTPqpEJ2N2zPe1n4/1/ZuF7441T@vger.kernel.org
X-Gm-Message-State: APuU4Z81ewQraNrZK2D4mVaNdbkiwFYFEUGmT8bQS3/Yf6rjLnLsB1KD
	Kkr2ZT0gRa3JtOE1dP9UpUfIaz4yFVXxcNdT9SxEyeCJmqWFRR0DgUaC7lHBvskTvFqKkY+eCXs
	3mIXcOzELrBfIIWskf3VPeft7fHl3c4Q6gvSuw4ovklLhCUMJFWqTT/oLGaTRB4MojLrgs0hHNA
	==
X-Gm-Gg: AZFdTZeY5cQVWPxxDaxOklMclaGbNZxBbEda685pC8K36mqZ2yyahPLpxjiIR1OGpyb
	Bngo2IfpcZcMvfknxnC+2kM97QoO3wP8sktkj/p0wL9IhBssn9mMYDdQr8FceAsHEGRNjlF2uZX
	RYMfm8a3iwY6FJeCZJUB1gDvYQhS/a/MxwQ69hxNI7grZUdqBFgutm9Gyjbczyz+Wmmtn/Zrisb
	xwAj9p45GGRpgCNf0z5X9VLrccpFMDpTTVnHWZq/yZVeQBHLMrReyQpMWvPghDytwpKm5/32gsA
	nT8knioGgA1b+4dtuBB0E2EQ4QfZrNy/IDuzDH8gXq3sfhQ9dEWQF2+1U/hdD3xl8mPUeUB93YX
	eAWpkq7bJ/PtIzvbstC2l/0dvZi4k9BW3Zq9cuIygsMbuWmCHCfr7hBvJoAqG/NEb+SzBloKCzY
	9v/jN6/UmQKyXIhRVjy53BFPSCwcyeg7BrW/09yftTQROCwpNaLmgh0knRW4E8Apftomgnl+idF
	2FUvPlS2wLljQpBfbNbUEAkhJQBa3mGneFoqQS2v7C3mDJ74yL+
X-Received: by 2002:a17:906:3588:b0:c41:6de7:7dee with SMTP id a640c23a62f3a-c513a3ab1a7mr548910266b.7.1795379240273;
        Sun, 22 Nov 2026 12:27:20 -0800 (PST)
X-Received: by 2002:a17:906:3588:b0:c41:6de7:7dee with SMTP id a640c23a62f3a-c513a3ab1a7mr548909566b.7.1795379239939;
        Sun, 22 Nov 2026 12:27:19 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae9f705sm342880666b.42.2026.11.22.12.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:27:19 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Ionut Nechita <ionut.nechita@windriver.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Xiubo Li <xiubo.li@clyso.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] ceph/libceph: bound sync waits and speed up recovery after network disruption
Date: Sun, 22 Nov 2026 20:27:17 +0000
Message-Id: <20261122202717.1341108-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261120073431.53636-1-ionut.nechita@windriver.com>
References: <20261120073431.53636-1-ionut.nechita@windriver.com>
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

Hi Ionut,

The timeouts in 2/7 and 3/7 can make ceph_sync_fs() return while
requests are still outstanding. syncfs() can report the error, but
global sync() ignores the sync_fs return value. It can therefore return
normally while an unsafe metadata request is still waiting for its safe
reply. Both paths call sync_fs with wait=1, so returning an error from
that callback is not enough for global sync(). Please preserve global
sync's completion guarantee when adding these timeouts.

The default timeout in 5/7 also applies to the interrupt request for a
blocking lock. On the v2 base, if the MDS has already granted the lock,
the interrupt does not remove that grant. If the grant reply is delayed
and the interrupt request times out, the syscall can return an error
without installing the granted lock locally. The MDS can still hold the
lock and block other clients. The underlying grant-versus-interrupt race
predates this series; the default timeout adds another way to return
before the replies arrive. Please exclude interrupt requests from the
new default timeout.

Thanks,
Alex

