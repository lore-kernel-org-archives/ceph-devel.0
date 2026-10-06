Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B034260580
	for <ceph-devel@vger.kernel.org>; Tue,  6 Oct 2026 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272325; cv=none; b=CjYX2uziQL6FAcu3Yhm5Gl/0/vE/u7AABUoE38jFDqC52SJT73bag+sIUmMKqwaMJpNs35uDXkmHgDMqR8FhjdaC0imKHnd82bxHfvb8T9SyCRr3GKwQBCTWNTrgCSzI7kb6Uu9TFCwfy2PfasTNQ2tq1f80d66QNeiTf6NO3Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272325; c=relaxed/simple;
	bh=uCyM0+PIjxayvpfvRv9JBUXuj6HqF9nwhvuwLZTnOeU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b6P8EAmm+3YMwA+6PUDbq2vzGxmiY1XZao8gzsA61K48ZNaMC4C1O2Ujhss0rewOrQN80mBTsapmhdryc0gZ1GMYoabNYYAPMYbkr/ZZoDGobulVViyXqgvo/bdtjOjx2j/AwWDUPwPRmfkaaDUTrEs61HJ+NjeAPpqTpOhTnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUyrPLNA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CsIoiZtk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUyrPLNA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CsIoiZtk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791272322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uy92/h8ADBZqNOZB89dPU4Y3tXGsnhGvUjg0l5F0MSs=;
	b=dUyrPLNAqmefx0On4enPQd8oYw4u7/tiMJrhXWG5iVUnThVFAir13m/iGptCJQxpJN9ffe
	aEKb8qTNv195U0iAcOfRbA987FDMosZj8r/Ac1n2h4qcRBAFnDtjKbUvtn+/A+g4B9aMrT
	dbOq37Y1ee9Vws/2E4Yr42VEep4IBbM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-3do0_MS6NJq_eTxDmli1VQ-1; Tue, 06 Oct 2026 03:38:41 -0400
X-MC-Unique: 3do0_MS6NJq_eTxDmli1VQ-1
X-Mimecast-MFC-AGG-ID: 3do0_MS6NJq_eTxDmli1VQ_1791272321
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917a3c27c9bso47273856d6.0
        for <ceph-devel@vger.kernel.org>; Tue, 06 Oct 2026 00:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791272321; x=1791877121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uy92/h8ADBZqNOZB89dPU4Y3tXGsnhGvUjg0l5F0MSs=;
        b=CsIoiZtkXO015fOeSD+VCRGk0eWNrSWp/8BIcopIQVSDQq3awyJIPxpnAYVQutor41
         6447aI2D8gxnsjgYU7wrO5qeTPNBqeT4tQcqJw4Ek0Bv6DFueZ3XDGAH2waxkGyFXEBj
         +T9GwK5Avd/JiDUX1SA0t0i4kLtpeGnxUffn4xJiFJQaRKXcGfh3Mf2l3vXqati0tRAC
         5nYETup3C5q3kp6sFQesFU1WZfjPYiBNDuIsO1H67PGHEQXBekxZq6KONFlQtDu43+oy
         AocF3EEfAi/BcFkvAAK5oKU/XX7RO2w0bHIWJyjj+lJu6R7uQVDvsqf51y9Lo4PRPBeY
         3IIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791272321; x=1791877121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uy92/h8ADBZqNOZB89dPU4Y3tXGsnhGvUjg0l5F0MSs=;
        b=cAjVICBjnM/TOc2ag7kXt8Dm7yt0XLB1+57KeEAA3poL7FeJUKmY6wy6bZAkEqf0tU
         r5MQTPMhzQC+vuLtgFJmN7HGhDf7QYArJoSs+GwuxGUhNLJRRRvcstoLx7N8PvSG2a0V
         lzG6NdTTYrEPPXm5ejZ8Hz8/Iux1FuVepU3733CYNfbSkxW2l6qxdtxCJpVH0HJR1S76
         IzIosKnmUZDpV3flq2lVgs0v5vGj8c7SktiXiIicdHXpFzH57MJT6UcYxNfoE+/Bnfls
         O/bK2qn6IflTYCUiOaqjHs8BjeAxxVYUMChxqSDxbntZEI61fTL96R7H1FUTdfYLiJO3
         gJdA==
X-Forwarded-Encrypted: i=1; AKwUvBzOWTKIripTjRTzNN1iRDWDzjCwEWHSL3YvCftVeQYfdtGQKIwM/ErQUWtlDJUSsIiSNGZtKDWlsbZF@vger.kernel.org
X-Gm-Message-State: AFuF++magbV9o1VMEx6lHFsjsbj7oyWOJturbqomLvs3rzzKMFPiNIwl
	GjyWuqlM2PvgH4wKYmOOILxP+Yqh8Fm4o4Uzok3opx98lAB0c+TqrsO+TkdlU51ghkY04imzFVi
	bWMiCXRkRR6Iur4jomjGj5bfnyIngcegEUEyK89rUkxt5pR8AtmvwPXY9sqw+F5yhoEg8hYyTsg
	==
X-Gm-Gg: AYBFou2raAXnO2Jv0Oq82aXxpFhntwPZ0O0oXjMKEbIkEapzL/vkWSf/E/pMyncEQW6
	qT5lOJ4Yl6H6iS/8bOMyR0mF/PHK6+YaTsEReWRVoP1Rsrp8GjhbjxPvFxdFVN/Rk20eDQTgAIB
	XmyuEAJLwarfp1hZ67UfpuANnFMPrmGlB78SCLXQhroLGpIUWA2I8IEm5yuTMfYSIRyn7hwBlZH
	X1ylmIlAU+Y1ZtxWUm/cbydHInI/AZD1NntYo2RNK/YG6/gg3Jug1fBYgZvWUKwXqgtJdr3E3Q+
	zYFJUPXNtTvWN9MsdO4bFFVgmZUSl7OPlosgX2F5QJ3YJRqTFDue4u4JREGK244NuuiPWMzEl5D
	iUmsReXokL9XBWgbkcdevgxSAC8WN26UF/bBAEJGxAF+LpLxKqIUnf7s+0Vr9Z/OzvqNe74jH85
	KVF5DuNZd2C4s/JQ==
X-Received: by 2002:a05:6214:320e:b0:914:563a:b3eb with SMTP id 6a1803df08f44-9198b7ea0a0mr11514296d6.40.1791272320617;
        Tue, 06 Oct 2026 00:38:40 -0700 (PDT)
X-Received: by 2002:a05:6214:320e:b0:914:563a:b3eb with SMTP id 6a1803df08f44-9198b7ea0a0mr11514076d6.40.1791272320128;
        Tue, 06 Oct 2026 00:38:40 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c2e98bsm106221796d6.44.2026.10.06.00.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 00:38:39 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Ren Wei <weir@nebusec.ai>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [1/1] libceph: refresh middle buffers for incoming messages
Date: Tue,  6 Oct 2026 07:38:37 +0000
Message-Id: <20261006073837.2081393-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002070921.2217118-1-weir@nebusec.ai>
References: <20261002070921.2217118-1-weir@nebusec.ai>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Ren,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

