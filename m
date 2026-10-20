Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792493952;
	b=ODEa8JexW58aQf+bbi2PtueBTX1jWmodbq5qBKWMLU58RtqIGsBB0Lito3hYenOv6wpM
	 3xzasbw8P/BfO0Zt0cpKIw2Zu+QWLzvLESQA/Dg7KnivPZoGupFjCzueNUT6XinHjSfkb
	 letlAJw7iX7/SkKghTajFcAfEgBPwqjXwJwXf/YO2EEH1nO4PwQPKveWCbzmSoi69WUi0
	 jET9s8FpNyM8K9Lzw6MijhCZhDl6K0uf0SSXp2+zmGoZwpWLPeH20cROBpFizunUlcTov
	 tLBv6jG2xyEnKsIH6k0WlELzOvdy8HCWtUeaCeWNw+gZ0fhR86WQlArSuGyHYHF/FLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792493952;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kfXjBjT8EwI6q2NIzcfFnMZrad6cZ2ffCbI1EX6N8OA=;
	b=cfmY23I08Z+mDnUuL/cNjEvySkRSKLnXkttOczgU47dncijjQRILQ4tZZuUt+AhYTtrm
	 3YD6Y67MopGWCrTggtctBOcZipis8hM51nLBbUZgFzqCkjtjyCZEcBPufQ90ZpchvLNBN
	 NEmomtRiXY5omR18O1szFWRBWxiWoh4heuq+j518HYKQ3ahOlcJt5nNLlVdHf6I6+HFXp
	 s2aejJKQaLPCKphuhPlhc2CwP9ejHBRfjbhClBwPjT8yI9o2yab3i7PQ7YTEo3tCEjxp3
	 tOc5XO3u6dctb39NYWFw6MNZj+hWdj1nYgJR4Llw6nJ/VlK4UaRrOumlVj1DgDm6JiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TW22jsbn;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IFdjasgi;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE39606A31B
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 10:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FE39606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TW22jsbn;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=IFdjasgi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792493950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kfXjBjT8EwI6q2NIzcfFnMZrad6cZ2ffCbI1EX6N8OA=;
	b=TW22jsbn5XMhMKvq5g7RtFXTQz3NzpCD8lVJyb3R+J5nVbAMAyDW3urPF2r7K1qoBBvlyz
	tvOyBe3K6YNQR+R6r9c0gytbMB534ps4eanCopaHAY5gRsa4IpIVYZQqHQOYcqKTpm978W
	Kx8ZwboBUdL+XpzeH2K/HyUmWm5NVQA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-lZfqffTLMcurF2sFIzfcHw-1; Tue, 20 Oct 2026 06:59:09 -0400
X-MC-Unique: lZfqffTLMcurF2sFIzfcHw-1
X-Mimecast-MFC-AGG-ID: lZfqffTLMcurF2sFIzfcHw_1792493948
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c4069f03949so57999266b.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 03:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792493948; x=1793098748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kfXjBjT8EwI6q2NIzcfFnMZrad6cZ2ffCbI1EX6N8OA=;
        b=IFdjasgiTVyZbrhCZI3CMNxSm9DtypPTVb0UDd9XTgMdwGW/0wtThhdugLvRoJq90T
         DclTkR7MzjaDkHzHewTKRYsNuyIoLt0/C6aulF81c1OnZeG3+iEeDiEI1P9dKhO6OOzJ
         W4iyYv5v9xumYng0OfeQ4Ppuiz77Ek3y6oGXWwhz/vHs+BNflhzK2dNpbF0BhcR8cX9o
         M4J+E8+9GDTfEYheDFEmYpaFFlZ8x7shyEpUNnH7anVKzB6PBsGPnrVF8gxYa4XbPsmV
         Zk8VSxzoktP7OaIoHi2PhKThNhXg4450V6Es0Hg1+9F6BRrZuPFI/vJG3F6pcRAXcgK6
         BROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792493948; x=1793098748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kfXjBjT8EwI6q2NIzcfFnMZrad6cZ2ffCbI1EX6N8OA=;
        b=OHWYHUC2gF2i2Du8dTqwphs3+hMONEWa6BtmCg1Z4rw1SX6eSleu0lTR4yGN0avFwa
         BhSVPc6NbVlkpLkYzg+kyx1lpRP5vbZpRNO4dkrOMlhSJMLO6tOwbZvefkLqfCM5EZbg
         wZlfD2Ng0LiVQ+o2gAC87APy2ylZgxq6DimLZaWlKn9+boHEBKs61BrPWzTLFJWlf9l7
         r1ivUbC1/khpIarTLYWX2I2p3zuwAQX6/hHBk7enoRmKjqhwweeDIrP7kgJBJldTY4/z
         qEf2EN1HRJJvN7U+Hrgz3lZIyoAs8srUAoW9xdLvhMl4hesN3WE+fW9jz98sUHKSc8z3
         pSGw==
X-Gm-Message-State: AFq9FYKO5WaddYauD0JwsDBDSHeoa4SR3CD5LxGs1xdkDECGRFzJf5Yk
	+KOgf4hnGH+LRWQcIqefLP/JRNuM3WHFfW8Kslyf21xDtYQ+pMFqezO7jI9qOSy3mVFDOqZ+gur
	K/EVM3BsDUPCBb0Cbk6RvrwZ8cklKEx8VGntEXJK7dQqpODyhCncZfubbVSrlGssbZrS8I3C8oQ
	==
X-Gm-Gg: AYBFou1MglDqAdVBWvxjKtEknlopsopqRI2JWyFKeCItA9vutdVgCtSq1LdFc5647QC
	spz/2lry+tvNrgA0lofXPnRkVdEyXvP/zRjUe7iX7h9RSMCNfrzl0k7sR21porSthDEmVtN0E3T
	rFpinIAlEOaFoEdTRJ/NHa/sr33RFFtWQ7dg6Rk0Rb4uPtfjrrB6WYObwPJS2cdWRUGpm5EXJKZ
	B+191eEL6Gmr+P0TgSf1GyUJvg7EopzsVe+Bmm8eFLIq77JX2DAH1kN5Q9+q8eEFNrGDTijTUT3
	/fhjvyOJJwp763Td7dELYNymRQ6LMLtgsXSjdSKBBrJBjYztkBzY3LVrynr0NyzWUAFCG8GgufE
	lHuJpsPdJsqexEMsTSqUz+NKLr4gD3HAq0NlNwZ2PzjCOX2aDkQxlMRffPczESrOThVPR9p/0iV
	dSI0bAUS48yDSYbr5hf9UqHTPuGpv7EGrl/kx+ApJ905oao79zmkffSFXnQM2KiU7GJ2iUPtQMS
	ig=
X-Received: by 2002:a17:906:794f:b0:c2e:4397:7c82 with SMTP id a640c23a62f3a-c4601376d5bmr137802866b.6.1792493947886;
        Tue, 20 Oct 2026 03:59:07 -0700 (PDT)
X-Received: by 2002:a17:906:794f:b0:c2e:4397:7c82 with SMTP id a640c23a62f3a-c4601376d5bmr137801266b.6.1792493947473;
        Tue, 20 Oct 2026 03:59:07 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb39a3sm467056566b.81.2026.10.20.03.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:59:07 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [3/5] ceph: write back only the dirty bytes of a lazy I/O write
Date: Tue, 20 Oct 2026 10:59:04 +0000
Message-Id: <20261020105904.1326043-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261020-b4-wip-ceph-lazyio-fix-v1-3-f4cc62459d37@clyso.com>
References: <20261020-b4-wip-ceph-lazyio-fix-v1-3-f4cc62459d37@clyso.com>
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

NACK. Please respin.

  1. fs/ceph/addr.c:302: Truncate past a lazy dirty range writes the stale prefix
     Xiubo, a lazy write that dirtied only the tail of a folio must not
     send the bytes in front of it.
     If the clipped range is empty, drop dirty (detach snapc, put the
     wrbuffer ref).

-- 
Alex Markuze

