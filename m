Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C8446BF5
	for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455684; cv=none; b=tjz1Q0RjyZpYtC5RcHVUbGbB/MnYWUEVe7XGNN6gviuKcs3pdoV/0TdeN8fgMwBMk7/5omN/z7aft3jEDJIBqE+QuLzmiTGeL9WERfC+3V1knSbp+CUO5r0SFWfwqkyhKC5R82jr3bURvCeCFXEcNRZtx/OSXWkaswZxDU5qQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455684; c=relaxed/simple;
	bh=6Z5AB6MguNWjUBT55YvnsHlAg2B4TKg34/tdfW0Oh3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UILUlurmv+vv2q4hmMpAQK18DGTD+OO2x6EbwTtDEw/GX/Hab6j2l4h9YjtF711ap1ti4gQge+11ApqGyhlOOW76LzJWU5Dk2FP8Vq/yUE7LEOrGxt37wOzHXn+semFX+jJC4qGvsxhWv+4RypBGms/NPWGBrrlOYO8Ai3R/NPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNV7gtpD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEv1dP3R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNV7gtpD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEv1dP3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786455667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Z5AB6MguNWjUBT55YvnsHlAg2B4TKg34/tdfW0Oh3A=;
	b=LNV7gtpDNGPJDXIyrsGpNaAQesbGFeEL8CFEnNSebypsVucF6bcUvql2XkoPrH/GFaFPWz
	A/UVOMHeJdeWlzyXsq5lHtPOZNlnkI7xAhpC5drvMF38OjVkYWoBHfAF73rjpSPovmZJyA
	nwyiX8wAHk7PeeAlHlAmsm4BNRpSjmw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-ngrgRYbZOP-r6jctcN-BPg-1; Tue, 11 Aug 2026 09:41:05 -0400
X-MC-Unique: ngrgRYbZOP-r6jctcN-BPg-1
X-Mimecast-MFC-AGG-ID: ngrgRYbZOP-r6jctcN-BPg_1786455664
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15e555a164so100459266b.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Aug 2026 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786455664; x=1787060464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Z5AB6MguNWjUBT55YvnsHlAg2B4TKg34/tdfW0Oh3A=;
        b=iEv1dP3ROYTrJyv2BwlZXXRMLWlqln7raWIApirSrbpJ1JdDItcHNVog2BU5k+p8Xy
         b66qrZOJu6tfAQXhyFvzpOnpdWH+SRX3WruMyvctAyNMjSyqSih27Jq1M7rU89XK8QjS
         gKPTe+otAtycjzwV/aCScGdB+Aovukzq0lWEi9zH1c06yGDhCcXVIR0jK61mcbZqXBym
         nt2Id3Dilw6Ho0OoNgynVqyp0rjIw4wk9lpFTR8WB9hfjJdeYgh3qud/V5K/c6osSbtu
         vfMYEeWSfE60GVGboudWd+RGim+jBpVLe82+J/jryUl0v3Bss2GLUmlXazf/k9jzHIse
         MCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786455664; x=1787060464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Z5AB6MguNWjUBT55YvnsHlAg2B4TKg34/tdfW0Oh3A=;
        b=d4Csg490U4own+LiUHyH7NnzVcnvdV/50lQj/t4mMxCAeHUmJM9qBbWrFZIvb+whU/
         x/wF73quWFLc4lvJ5smfMwFQcwAevGESmwYXWEL8fNXx/z9cD7EPo7XYaKMz+MivvNB0
         ExlMAXxrxAWPrSS4ivAKkbzjli3Xr5kcmPjZUf/ScZWGXhX4ThM9Z7JG3wUnSiqPM3ze
         UAxoU5tdV6ax8yoVJhjFiwAb9qLYgUqvAF2wLsbzLlgHvnyY5QTO41LRVFJBZxWLp6U3
         GQuMiGMRoTe/fiBvdWJ4OCpZcO3XnH48izbdmXOxQOLEZDy6k8sSMGzoELlTA/9py7Hk
         6bjg==
X-Forwarded-Encrypted: i=1; AHgh+RoFLDekJEm73h5FZTL+iSEOl+jFLYBcc4CCaScOa4CoCmAKHhURqZLNuj0SKEagn0mFMPFDSg7ee5dl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9PHfzniPUaewIqoSJXORz+GFNpHbgsy+heXZC2rb38IqZdtCB
	YOIvanDXe4qJyh1g5X0AB+1iF1HU6KXUBBWolBlQ2fcy8Qm4c8kHd3Vg4kNy2EsnljxitGxdJn8
	jnyzgZji+kxxctkZiVmlZUjNhlrNTHei1kCcQ8mcWlcb0rGEQDnTlHSSa4Jk28no=
X-Gm-Gg: AR+sD13TBhSxjKsES9YnQKvZlrNgRRTjbRrtCEo1A/gWyw2thBgDhSnkT2CqDsvdn+C
	NXLW9XO+WVMVUgZs9i+knqtQ1LLot0srl5201hridS1gnbXJ4keNNEeCOVam7iwnCMASvT2JefX
	hjXX11HRnRYPBHhVujfz5bizOl1m9iHYkBbzUY0XlLUPvxvJ2sTumlmuAQcb3Vlf+YrfNVszoIj
	sTzLu4rGSfPqVVTKHTRvdVnvDPrXeO2Rg+HjqKZjqUu5atCAfwVoNCPK7XyFC+uvUl2ty72Y9X0
	kM+zrhWiaSScY1/2pKIzfPLlzgpkURfpNIDA8L4e/dI9EWbCqMOzUQsCqFR0ESzB2iljozT12FP
	IChyHje/liGrlRzokV+U1g9DIywTCE1zJ8g==
X-Received: by 2002:a17:907:3cc1:b0:beb:d461:7b09 with SMTP id a640c23a62f3a-c20ed2726b7mr9179066b.11.1786455664329;
        Tue, 11 Aug 2026 06:41:04 -0700 (PDT)
X-Received: by 2002:a17:907:3cc1:b0:beb:d461:7b09 with SMTP id a640c23a62f3a-c20ed2726b7mr9174266b.11.1786455663769;
        Tue, 11 Aug 2026 06:41:03 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e43203fesm56156866b.41.2026.08.11.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 06:41:03 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] ceph: replace the request_tree rbtree with an xarray keyed by r_tid
Date: Tue, 11 Aug 2026 13:41:01 +0000
Message-Id: <20260811134101.2689120-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811-ceph-mdsc-mutex-optimization-v3-2-d031114419f4@clyso.com>
References: <20260811-ceph-mdsc-mutex-optimization-v3-2-d031114419f4@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

In __register_request(), ceph_mdsc_get_request(req) bumps the refcount
before xa_store(). If xa_store() fails, the function sets r_err = -ENOMEM
and returns without dropping the extra reference. Since the request never
enters the xarray, __unregister_request() is never called to balance
the get, so the ref leaks permanently.

Adding ceph_mdsc_put_request(req) in the xa_store error path should
fix it.

--
Alex Markuze

