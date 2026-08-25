Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CE23F9A10
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661720; cv=none; b=Tby8oHwxQjzWPs/vStvFBk334GC3CzMiuC1JRbDGgUAm1ZtMBe3+WMfdLIMrIgf2yHJdGAAjznO06naD7SlVZplpUk3vs/OW3lagta2sAsl/Oy+OoXUin0a680TgWB7fI/940Azj69SB2AM/0Z0Vze0q83zk3QxqU3SidR1WH2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661720; c=relaxed/simple;
	bh=lCTPtFoxtcyLzZC5JIDhZpR9SAAGT/fE/e8C9bYONAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OIlW3ZGecx4Mxb9jBYoUAhHtALdJq93bez2POBoHyTtcwv6f3HIXFjBhkrUHv5X/Q5mGezt/rhtbEWLuXuqooM5b9kMiULZrPpiZFq9JfmGglkU9h1mc7x1ampZqpFMo3rgD2XQJZ2tKw+w3m9xwWUerYOsEOqbIOTXRQZCOWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNwxTFnZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMC9rdRI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNwxTFnZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMC9rdRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787661718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
	b=RNwxTFnZg+ieqLDrYDCNcR0wOT3OSoDnIQiR8z04rbnuzxBpIuaCPPkxmErNcB/6oNdACD
	I2iiK62vXD+SBhM53SrZavGapqGzVgbO675LfSC3P+7Bs4C3tc9nrQQ4F+afc9dNNOQ7yw
	236G6g2REanODTtREoC6gODcBq51hk4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-kvYCtyLcOpy733WgCxwROQ-1; Tue, 25 Aug 2026 08:41:56 -0400
X-MC-Unique: kvYCtyLcOpy733WgCxwROQ-1
X-Mimecast-MFC-AGG-ID: kvYCtyLcOpy733WgCxwROQ_1787661715
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c16740eb587so368321666b.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 05:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787661715; x=1788266515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=VMC9rdRIqxrnWlqNtKfoL0/9965W36Dx2yJ0i9s1+/nfQWaDq2m7vRF4ISxadtxNUY
         V0K2BbiPapKLOD2WdpOTy1zP1lSG+qo+xaeWw0z2eF3leNJpv5/1j4d6T0Kxd66zEke0
         TA+w9kYEcG/eTB3jFH/8y9X//HUoCODnIgJkHfqEcNDysSynfB0bOJ9GyvBQye+JYiSk
         t5RA0B+7r7zKLf5RJOv5lrppFHw4kVSqux9E3IOIccqloSb5Eja5nvSIf1CFvwgT3ipa
         FxhUAvogvsco3fGJvAIKapwiX+oYEEsHbsXgNlOgzoY9IL9k9c+WLxgV9u7nsLJ1RYsV
         qcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661715; x=1788266515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mHVMhYwsXLNatox6AxU5DgtDl30GDL66OirEwafm/TY=;
        b=LYKfvQCEoie/cN/yIAiwcczD+o4XMoHnvUTDoGv0Wbuo7Jd16l3mCieuW8cpsestty
         +ZCGOFkZijWlcNw5T5CMid6gkJ5IGGf9riN5N//+WwZk1U3NZidf4+a63CRge6yUA9+v
         9WRFaHdvgl7LIXXsjNMVkO8pSJGxwqy4pgC/KaFHp195QsZJO9qtQ3pcJkHD4rAnfE6E
         WwBBZRIEwtJ5R0TE9e9aiQ5kAi/zKyVCNs3wzSxOM7tkjS+bC9E7gSoA7QKJwJkhdXgH
         bPpG0uxscpsMETJG5255ork/SsytFASgRZ8l7v4dmRRZVia//ysGlsHX0e2cLasac71u
         AujQ==
X-Gm-Message-State: AFuF++mBlaBv+9NBj9IlxANmecRQ5xrChzknZiRVgggLPUXJzcqHezYP
	PG9OkjDEFP1AQ4aGCpiyc6h5cuC+NhbURccEDt/BozoScyau5Bv8yhrH8vdmqwrxXe7l8XHpw0E
	tFh+kXUBLQPQcAGsbVSYpIdLTQpuGsMz0DUAkhM4jEaVQcFrBFQSHUr4JSX+SOvc=
X-Gm-Gg: AR+sD11n6XTIq4DDB7jD+wChIvICGuXws78P2RE+gC4Pq0EiVTBmSddXxG2WMhfVZfp
	L94kPZoqHVlSFZqZ1CWGJQZHjYyZaPFZRSpi45jYSYY0WG7py6zmgTsQrrK378cxvV9jLHaxwHB
	gGfBhdxzuuzbmFBHTHluK2JYzdrCTMoOBa/Flo03biPf18D/Vnagbvm2a0epE6HW6vCWYPTFObr
	91oxoXcW7it/l3hmIBLrgpUDMcg9uvXYBEykJBTJXFLYjRZG0L93ptVRr09KpNl0ItI0D1IrktR
	atZRv/whZr1S2N1LjbQdDU2XOrs3eesXGV5/R6BqUANEuoJPImcCwkJQNXGo6fHjj8v7gx9QuEh
	TnD+7qKwpAC+W9VjepH2frNOAJuWYrm8pcg==
X-Received: by 2002:a17:906:f588:b0:c24:d430:3929 with SMTP id a640c23a62f3a-c24e58cfc2amr722845166b.1.1787661714803;
        Tue, 25 Aug 2026 05:41:54 -0700 (PDT)
X-Received: by 2002:a17:906:f588:b0:c24:d430:3929 with SMTP id a640c23a62f3a-c24e58cfc2amr722837566b.1.1787661714390;
        Tue, 25 Aug 2026 05:41:54 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249673d43bsm1645308566b.47.2026.08.25.05.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 05:41:53 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: lock mutex in ceph_mds_check_access()
Date: Tue, 25 Aug 2026 12:41:52 +0000
Message-Id: <20260825124152.2611667-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824164707.225547-1-max.kellermann@ionos.com>
References: <20260824164707.225547-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

