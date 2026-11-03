Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714683;
	b=yGwt1Gpmmj2r/0cojr6SiESmY95Fp34zEMikZHp3aE9NTXOV0lRWzkeV74sKZTcOLP8Y
	 ZBW/AZwPGikR0owCqie0AwU6bui34n8eYZol6sXKDvWHZHw+baQ3VFC/ytiS20uBNYG86
	 hzEfUX1PLkXoiLnST2pGlY08oJMgTDo0MkZZiVU23PwqBQBQs2ky7aMm+N3vgMevI57ag
	 Lu/l1QkYD6O/LojRz0E/ndBG63vFU7TuLN5J9SiHzIcjvleST7Z70QrWtjFkRUxumjN56
	 Wj7I+eMRfLmg/aPELqP4h2tyJMyq/B0iNy0tjwG/C0iPMIfarfBEnkaNJIprF8pmjEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714683;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=BUZlBeNWgSCgeQAok/VJ2lLCsfVUJPaJcH8B7xMB5YLxQxQfE+myG5rcPX8x1OvQj//U
	 /Qq72g78cWs99kYPuMNDDlB+zMf63fottVwgkyg7QH9gtg+ViPyXCHKJmNk7+xDB1dgU5
	 EK+TkP4VjvE7KvEl/PEkz47WZpi4QgcC4fvsbWGRqnUgGFjjVOQsVIj7RQpB34oRN94UE
	 YywoQsU1ulsX39zsaX0viv89YZajXD9RQptXl3vHFcKhxcVePkvi9+fdxDCzXX6PJSnhF
	 jkavc1papLVrIADXITmuVBdAfWLakwGQlpIHsYmuMCHnGT4blSfxpquVQhZp2vhQ+FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="BXg/ttZS";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z6w1pmtQ;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEF2606A326
	for <ceph-devel@vger.kernel.org>; Tue,  3 Nov 2026 14:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEEF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BXg/ttZS;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Z6w1pmtQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793714681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
	b=BXg/ttZSQZ886Ccea07TASwy9Fel2HjGFpOtJ2JSg4usO+fryLdu+AAXDc72eJ+dJ6D+X0
	2yL3Ox9sKVLxty4JYPpEsNv2p3yQa08ARVtyGu6AWCzGh/uDLwWej8WJaLweSqdf83nk4I
	xrhEs3GE4yAAa5HTvOhC8Q2DIxnU1w4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-4apJ9ncLNaG3t8jO1e-QLA-1; Tue, 03 Nov 2026 09:04:40 -0500
X-MC-Unique: 4apJ9ncLNaG3t8jO1e-QLA-1
X-Mimecast-MFC-AGG-ID: 4apJ9ncLNaG3t8jO1e-QLA_1793714679
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c210c66672eso539982766b.2
        for <ceph-devel@vger.kernel.org>; Tue, 03 Nov 2026 06:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793714679; x=1794319479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=Z6w1pmtQjxTKCmTVdqkuth4GRKitZTFIgZZjccWTY5ScaFcwrLpDBAmJtAwcIV1VVL
         /cp26SNwtDeqoeCBK9u2ZjazEgR4Q0FN/iKwyBQlsHQ5hnOYnBMsJWsD3Ji/rGOX9w0m
         1z2ryKhiK2Obb4fGGoh0br/91+ia4GUp+1GoQvqRv6ELnl7xZrKDiHfOICOavvb2dhrj
         p//9tD4XW/vjMxj4AxV6oRyZdIFuFAFUXAhEnVKXBTNlqnzvtnAUaRqzsZnAmkMQjF8Z
         jE5f7nOReSpveWs4VrNwf2nqFGjho5UlkIOwJC8aVWkeMHZkI4Ug3LbTjJuISrjSqkX7
         SArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714679; x=1794319479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QXMKzKJ1tvAdYcvy4+GirvQzIyrrS8LlfStHEJpnk64=;
        b=ZqWShhtF0w5SCDGWutJGpQc+q301is+CqPDKptRamxHzwOm87sV9LnaF0ixwBXya7q
         XCcH+5cCOhQVU8rv/RzeIGFpOrAFJ3XYDtxrXu/uRtSrPXfG4zop3/jyOK6EXUUQFCPU
         ZTI9pYZWqVGjy9pB+dBwIYIsbfSHIJYMumnKkXZRkT/Uo8vHBufEtKQsUURBPwtm+09h
         YHW6TAWHQ2c7hNpmciRNgLdmBTlr3exFXy3pFVs1s4pcJlPgEr7zME8aeYA8LJngP15j
         UNHsCLUnrlXxwCI2RAT61B0ga24iBh5CJxSKBrJEsXcCaSD3Uuh5BU8yJm21skfy/XVR
         e22A==
X-Gm-Message-State: APuU4Z/vRYR5my2tMORBOXi9S0UTkFKSCuw7MtZg3Ie+d8z6jcv8Q2ej
	CQga7CmIAYehQG456j1Tqw6lXUC5JfiaEcd3quJGaTiJKKt3q+haMolz13BquLqZXhtwMoT8qKw
	fKoEi15aaSqYmFPpceuszS6tmoH2hZK+e/bbHqYpDgOMFzmCwBjiRK/UNCObCnvY=
X-Gm-Gg: AYBFou0Xe+TGtDRLDGpTJb03T551heiiSQ3ffyU78EMGtd5MJTWpdxDzNBU5kBuuaTt
	jULSmXeVUwULE8i01us8N4KkR50hBJCzxw63DFW2Pe7Fi2KXrTLxnGd69XQg5pPrTbHc5Rd6a9G
	mTfjghM5WxVvLrf4ilSniKM9AN/i6igC6/y3P/3mszVPXfmju3AmWnuJF3bsNBJ/q7/QhN/9xAY
	lSBT+TB5WIyCGXU5u4k477apZL2msf1s6sm9cOmyDpASRLrBWJ4Y7XDE6z1FWpbh2lQK/Zruxx2
	QwGrihTO1gY8rBB2xbJbEoVDy6TQpYNHb9IKSEeiOXAJjS50iJjP3nwhreLScor1zy30d52dtFw
	NHbNDqRuDLjTyaq6U59udbtuc5i+duL72L2hPZ4dz8icf4oRv8cu4j/H4LO5CpxI81BXRQFAYmu
	PAHJ8YKl5+3wq6S4tc/qmsYgTAqomlDqzNmxrEnhrzA9Tlvdo/VBTKOGtf95BFv5gXXMj6LJR9t
	0PKFuMAooJFHNY450HBf0H9MRhAtxRSQajtGKEamNV/Qq5SmWc3
X-Received: by 2002:a17:907:fdcb:b0:c41:f29:72b1 with SMTP id a640c23a62f3a-c4ca7aeb21bmr1081095166b.47.1793714678937;
        Tue, 03 Nov 2026 06:04:38 -0800 (PST)
X-Received: by 2002:a17:907:fdcb:b0:c41:f29:72b1 with SMTP id a640c23a62f3a-c4ca7aeb21bmr1081072766b.47.1793714676474;
        Tue, 03 Nov 2026 06:04:36 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebd36f43sm90504366b.2.2026.11.03.06.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:04:35 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v4,1/5] ceph: invalidate a revoked cache even while its cap is stale
Date: Tue,  3 Nov 2026 14:04:34 +0000
Message-Id: <20261103140434.943229-1-amarkuze@redhat.com>
In-Reply-To: <20261030-b4-wip-ceph-lazyio-fix-v4-1-f734a26bbaab@clyso.com>
References: <20261030-b4-wip-ceph-lazyio-fix-v4-1-f734a26bbaab@clyso.com>
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

Hi Xiubo,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

