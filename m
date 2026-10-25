Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792949063;
	b=ksi46oRH3hbUcc8SfyHx1FGemNzzNLXowMpZJXaD26IpuZ3ZKA8RDnI50x3GlLeXoqZp
	 XErAV6p1QikXl9L2X0v6AbDxzxnQppwjGdpJFeu5SewaygxZQEbRVArg58rxeYAaAZTaq
	 b++UgxAv7Mm7NWbnh3BmB8xAqMp5qLLQtHe/rxXrqzkd1FSSPWSs+uJ/L/+RfW9XQxExE
	 FaFLlPEnx8KfhiJwMcGoNOsY3TvPujzrmLY6eAeRSKStpkkAtC/pbgDvb0J0A4lMP7Zo7
	 m5cWZ59zCa5wbb5fU+9i5NioYdp2mnuDDoliBlViHsrOWHfhVuMzFrzmJDRLOpXEO6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792949063;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IP3NQEvbf308HkmU7L6IBXGpVGQlHGWaH9aykgMPiok=;
	b=fLGB08XonUJD1POeYh2wao+6FQuTs5buM9oMazJHsXtnWlTxDTMrbXSWXrOeoQ8bzlIz
	 jEhP7D0TBtR4A6VGW7eEZDGO1Du9AyoX0um775Kvd6UOOrRSg5spu9J5zEneSHi6I9Fdl
	 00Dyrzz0t1CTPxWesrWs0oCp6/f8VDZfrQHcUWmDAUNoyV4A+mkh1mbU0QBFbXyaeUt/s
	 ylOZ18ixw7igsUQyqo4Q9ifNuqvU1eoUx98TxnYkc6/sKJ5+AKJtFnQbuYSdjkDCUb0tb
	 7MS4wht/uHESK6jj6do6va8cLpOlSepz385WU6XoocgUjgUKl/O0xinU/zTaEIKEuxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZAjfzC0;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=acwl0Iy3;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921DD606A31A
	for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2026 17:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 921DD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WZAjfzC0;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=acwl0Iy3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792949061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IP3NQEvbf308HkmU7L6IBXGpVGQlHGWaH9aykgMPiok=;
	b=WZAjfzC0GTiqnSUe1ZE5cSE7WhUJ2DqCMuHg/Pi3qzxNFmL7SPoLeITv4M2uR99FZEZr0V
	4ksQEe4X5KExWU3VDPZlCjsgT5LQAD4sjxDwRtEUqbeoDW3emMm1020myjr/TqCgeZ7qXD
	BDhryPxoKPQoW+GAp/36bZ9rIv2T1Ac=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-Tvgln4zmP82dBsMZWKmrTQ-1; Sun, 25 Oct 2026 13:24:20 -0400
X-MC-Unique: Tvgln4zmP82dBsMZWKmrTQ-1
X-Mimecast-MFC-AGG-ID: Tvgln4zmP82dBsMZWKmrTQ_1792949059
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c414c206673so259757566b.0
        for <ceph-devel@vger.kernel.org>; Sun, 25 Oct 2026 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792949059; x=1793553859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IP3NQEvbf308HkmU7L6IBXGpVGQlHGWaH9aykgMPiok=;
        b=acwl0Iy3hd24Bpj2lUlQrAnqPhT7ZkfkGMTKZ35/qebZtUTVrs8q0mxxh/M9uD1qU9
         q8Aciu5+wyQxt9jhCm6BSUD3ff8v/CFGFw9KITTddiu0oLnfhhRcwss6SJf1pMe7ZAwV
         CNHcbesVMV6NLuLYn0xtLZ6jirwHGx3yrx0hfaYdRuPMt3rJ2vopbRtXBsVr0ybyQFvX
         KTJMCskWaTFyC7LveRWYNWf0S9pC9gseo/XYtIURP31yaik5y/vp9nXqJ+dQ1AfueaoS
         6QzjC9ZrAU7eDiBAOwNssPj6XzXrFE6mDzCl7f8ZvdhsjGK1+VKj+WEn2ZiOCAKSK7Jk
         N9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792949059; x=1793553859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IP3NQEvbf308HkmU7L6IBXGpVGQlHGWaH9aykgMPiok=;
        b=Z0N3h2DYUPBfIIZN+yRM4t+RgLBb3vfhXrLtVAv/4N+onX6CJrvnXomJwAMBgsWEci
         5ZYhHEAyBsUaYtfV39o2yBXI5QXgyLgWQaQJFpwW5ELZfs68ySAYoxNr/px3zt2byBZa
         qANpunzxgAqy7FWFYJUYrqAgtjsc/3nR+eqU7G49ymg5YT2Rq6rRdG/EUsFDGEYpicVu
         T2L2bEg+xxTjrK3gjPnNWcKKvuLmElbx3L9FZINlWdcwhl85PqScAtbAgSqDOeZtiEUk
         81tvFN69OVFIjv6LcelsbIL8Biq7u4GjLHr08uMzVqjnFZ+vxfi60shUWVO+Yw6GSGtP
         qQ+g==
X-Gm-Message-State: AFq9FYJ2vSwSaG+rIcYm+QUAg5TtzAZisne06JrAx09xuIuVyDiw9CUd
	WE6LfrBsOHSBzDGf88iSD7d+TpV1pLepPGeeKgGOP84ShWTtjErfqYOIBj98TmsOg11d5OU9Ke+
	KAHOiBmx8HvnT1nv8nnsG4FiWwGGmHMOxWKDF5TAx1JMBhFz70e1yXdQdXE11qYAbaT0Jxx4=
X-Gm-Gg: AYBFou0dPtfG5zaYNiQF1dRJgwL7LtlnTz3bvP5uCu6G4k2q04KcK50zgfdwL1kJfin
	vtrzsTt4gS1eePavDMT8Hi5+NxnK9wdj4mY53KRv9NrrskZG3AVtOxOEmzuvQNNneIi9rhyDRUi
	7ASf5jd6U4bihX6gEy30AKU4cGrcprKYFyN5ZwLxWJsV6ZhhuiGaMqT4qHgTBCyhC3cEvIZtSoB
	1HCpy8JbZNq5lKJIOINjT7jsvaEKOJ+nTVtUHRB5k6n2czhagSsriJebH+wsCjbKTeRc3XMBKSW
	eQJ5UiAFuC03RNFJjNl3cwElmjQxH/95FUZ8wcVt2+2LSIIgtWuRXSGu1U+RtNTaraoX7joNWvo
	P5INDMb7KbnxTiIE8u8LiOebp3ZmZtaD8ew16RUPyHzqRidKgZa4jKGM4Ih5t3+b3dfSG0bLipL
	wNQVlpbVdO8Url0WHAdhR5+ncUP0o4hbrw4zPeWz9rMUI4/7XhtkhZN7rmeChIXbKgVlViogBQV
	X0=
X-Received: by 2002:a17:907:d308:b0:c2e:378c:8ce3 with SMTP id a640c23a62f3a-c46bde8c44fmr551004066b.32.1792949059045;
        Sun, 25 Oct 2026 10:24:19 -0700 (PDT)
X-Received: by 2002:a17:907:d308:b0:c2e:378c:8ce3 with SMTP id a640c23a62f3a-c46bde8c44fmr551001866b.32.1792949058652;
        Sun, 25 Oct 2026 10:24:18 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd5202d9sm226441166b.32.2026.10.25.10.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 10:24:18 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] ceph: write back only the dirty bytes of a lazy I/O write
Date: Sun, 25 Oct 2026 17:24:16 +0000
Message-Id: <179294903374.2850169.9863420725827161378.lazyio-v2-nack@redhat.com>
In-Reply-To: <20261021-b4-wip-ceph-lazyio-fix-v2-3-25d28479d6ea@clyso.com>
References: <20261021-b4-wip-ceph-lazyio-fix-v2-3-25d28479d6ea@clyso.com>
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

NACK. Please respin the series.

A writable GUP pin can survive writeback. A later lazy write can then
install a narrow dirty range while the pin remains held. If the pin
holder writes outside that range, unpin_user_pages_dirty_lock() sees
the folio already dirty and skips folio_mark_dirty(). The range never
becomes whole, so writeback omits those bytes.

Please handle these pinned-page writes before limiting writeback to
the tracked range. This is from source inspection, not a live-cluster
reproduction.

-- 
Alex Markuze

