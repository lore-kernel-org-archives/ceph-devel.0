Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310384;
	b=mGP/PoKmG4r0qymY2zWlxZxzDkSzHCciNFRb2HHvNYOCBh0XUOg0MF7JkhhbbtxBvQQS
	 3dGiBv2z0ezRKSbNdBi6VNLEdRaAJ2hYJaK6VCfi9TKUKJSobxJhKolTLqXByLlZuxx+S
	 M1xtD16oaDdOjapohPFLkUoGD74PyWkdWPjb7JkJXBsr5CWMhXt6IcYRAkduOjqGanpTN
	 82mr0CTHwKjPX+7zCSFFKViT4rQGo/J6L6zulSIIadjOR4HbKp6IQ4X5QwzqUbZEs47S0
	 mMzuOVPuzmDCjZBGQa1I977T4QEF5Di2OizPeaVsjPn8ErSxJUSjy+xQSkqR+Uo2n4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310384;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rmOrPhHNNOb1rXLbGxdJVlIkd+E2HTOzlTHaZDygTTc=;
	b=aRiHXHF6dZl5pAhp51kys0ki5l2DspsHNLQgNvQMX2RL3LEZbD6AEQmHLZMleoD0d7yr
	 aTG81Crkmec/KA9Ti/Yu+qwTAGI7sk6n4AHvOKOS9Is/dbo/qQ4JhgAmnjQBA3/1o/hTQ
	 4RXgS3AldKEbOBcp+qChtmECCY25Reln4jaGqxy46L694V1P85FM4UqOO6DrApTasIGIz
	 T5gTinAoZs9qq2IBm+8J1hN52mKnTsU/Z9nrAq/tOHYPKcsHMbAQY0cpPViRIubEPKzJT
	 34Z1e137gRJ7tPHmyjTqLhdc7mPi61CyJvAXvI2I1zASK5r8WcR/7rE4bFx+Y+A/JSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKoY9dN9;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cst+y2Yj;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFB3606A32E
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 11:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CFB3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WKoY9dN9;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=cst+y2Yj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794310382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmOrPhHNNOb1rXLbGxdJVlIkd+E2HTOzlTHaZDygTTc=;
	b=WKoY9dN9oHqoZcu+/gE/W3jzC8A8CynpSR743ibnmCjeo+OH054ZX52kpLiRp9y1Bh4qlz
	n1KLh66znYqx1AUrTvmugUjWqkhDhlfhKj4jd9RKSNwxmiatgvHTjwMfXagEUGC6ROLd/K
	kqaJdYg92cmAfXNGliXtj8lswEGn9Mk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-JBU9e-pqOOau22VFTmLV1w-1; Tue, 10 Nov 2026 06:33:01 -0500
X-MC-Unique: JBU9e-pqOOau22VFTmLV1w-1
X-Mimecast-MFC-AGG-ID: JBU9e-pqOOau22VFTmLV1w_1794310380
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c504991a35eso79793266b.3
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 03:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794310380; x=1794915180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rmOrPhHNNOb1rXLbGxdJVlIkd+E2HTOzlTHaZDygTTc=;
        b=cst+y2YjJKbp+ewNSEv+RpVkR3L+3OW6kdozjzI9CjqQ3LaSCIa/VC13qJE5e7Aay/
         c8LCXMOWEhW2Lu3q+ldydKZOeRhQ8t39576Fiee+PLQlSV8Dg2PWRtIxMqaRnim/ny5M
         pFbtFH0JP4W5ExXJNwB1OJZdztkeAZc+jWxD2ijEzafxU++Bu/K2FnTKkQfjmiivjZVp
         b3uuBm4uz5ZGjF+0P+Ed3KZGPjSJ6J1Pd0D+gVJwAH4NX/Abg/AI06dWF+xLHmqEDsOf
         6ffhZAyJUTnbKaRpPGqnkzY+heYErbg2HLxW32gh+8mld+rrk+BoBZL2kN+s2VZlRwrX
         huUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794310380; x=1794915180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rmOrPhHNNOb1rXLbGxdJVlIkd+E2HTOzlTHaZDygTTc=;
        b=JruNnicqbZj31CQQDZAmF0+mc98TsEsDQ5tfbGKlWhoLIkD6AUSGUFR/yB12vqLTPe
         6KqfgRuky3zly1oVsJIDMNQJfhCwImSFUTuI2bYA8WjE2QmHgVV/gjwcSZ/tuYEiHcWy
         SPVUItzwiiKaycxacTHZreF3n93/6P+bL0GHL/gkgpWPiYOSKl/macW4uMnmujL8lUz1
         rvOd0mpzi2Fq1AFD+mFmSRLz7V3yv6VBMWgCINUtzR/TWXNkiDnZm77nJJH5cdeKszE4
         mYkvfD3l31wrjpoBjwcoK0i3RLoLu9b3AC+/w+PMIKgXdEcTauNhUjLxB3FD3JaQIc49
         vHsw==
X-Gm-Message-State: APuU4Z9UaLzXplpdK/2dgFa1R+TFoQossnydezOjcQgxOtY+Itn6WGE9
	9wdXvKsDrLZHots7945c31PEgrDqjiq18xnKP5cf5vjz1crp5N7mmpSW24XgGKWenS+UHXmpeHC
	QGRla37X4CATfblOz7LWXP8EcZL7N8ddRPklwKpGjlb6q8XaWeupU5+kyluEvPuTP5ltjFy4=
X-Gm-Gg: AYBFou0LOfpJASqeNnjcZKURcFspGlRSCic+/OH2fsCg+T26PCGDsUdyG5GfQKNYUdV
	apSc2X3lVe5MJATfdGctR4ctqejYPIjCRK1Ppofxtd5HTf0QxAazxl+9i0jfMXv1bXUsnS+G9mT
	MA7lPIEQl55PAb1Uz6W7FlaLYIf5yAio2RKesQNawXy/1hGajbt2ZgW65PEDtJPo+P0Y7QbQ6pi
	iPWGZQT4yRfihdTjOd47sttBJl9XLJNrKL+T/1ZZLCVf8swrrbX+Jv77QLcEPtk+G0GI6Pd/0PT
	BRfCPTlRmeILwMyvU4NPL23Qp3NR527nCdVLzyTCwLE78ZxbQ9TdFh+jU10ez8KWPRfrq38ELFc
	SyuoJJwVkmxIc4u2nXy/ntxTGnkIhc0QLfFtJKYFkKTqQ3VhataYdv0qNtgff6HjqbovaBfNDIL
	zbRMgi7C8De9ii3wubLqCvNSfvbuLEtv0NRplpsEqPnOjBxJUWWy/PulyK4ZQjlYIjfov1t6YSm
	2RQIn9GleczLjv/v+MiHXAP2wtRegbU1RO+SQ==
X-Received: by 2002:a17:906:4796:b0:c4c:eb16:4014 with SMTP id a640c23a62f3a-c5048f91f22mr220423966b.1.1794310379889;
        Tue, 10 Nov 2026 03:32:59 -0800 (PST)
X-Received: by 2002:a17:906:4796:b0:c4c:eb16:4014 with SMTP id a640c23a62f3a-c5048f91f22mr220421566b.1.1794310379481;
        Tue, 10 Nov 2026 03:32:59 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a6551efsm97814466b.68.2026.11.10.03.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 03:32:59 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: Thorsten Blum <blum@kernel.org>
Cc: ceph-devel@vger.kernel.org
Subject: Re: libceph: Annotate crush_rule::steps with __counted_by()
Date: Tue, 10 Nov 2026 11:32:58 +0000
Message-Id: <20261110113258.3264505-1-amarkuze@redhat.com>
In-Reply-To: <20261103162226.433523-3-blum@kernel.org>
References: <20261103162226.433523-3-blum@kernel.org>
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

Hi Thorsten,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

