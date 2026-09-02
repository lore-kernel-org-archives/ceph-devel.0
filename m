Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE3374E79
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 17:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371873; cv=none; b=IZWMC3Ch1NvYOd1r0b4l5Zwluf73V6GhQB3U5kvtWX3IdTZoNTzsb+IeknZ3ljeXDHNke5HjCQPwaU5bMcL7bW3PJT/jJCKOjBOoj8ajrhMGLbUoqvJlHlARiPujkOGw0Y5K66G9kQyVwfuX+4aIMZ0n9LvvB6vWQ/J/lCngJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371873; c=relaxed/simple;
	bh=uf0MSJ51/l/ThtA8SWKg/daL1CCWZ4P7eL6aJbw5L/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=grOIW0gnEKvfyPloilinOTEDOLZsm0yNE/tyygWCztCAEZeJ5lX8J6UJroyzP6eIcYiNxHtzq7ADObCjLMNvWv9EHCyod7FhJGR0AHy1Kj9Ur04/voMuF8qGIdYtYn2usUJIJ+Pa+JfFHXMqzHYnknAJIgbn+jnayLvv5L0s+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAt/tymM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zf9vVfJK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAt/tymM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zf9vVfJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788371871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KDbkBpzee7kW17XYRUageSRTyF991PI7JtDtEZAP+8M=;
	b=SAt/tymMDFPyOO5Zfu9eR2eI83sFNpIshYAb8rUJumUWcsyXzMOtZrigZw5IZrYr3e+e8w
	6e5HOCwEOI7z7EijjQC1aYv1/Hf/puyQj4GXR+8CGMPpaCTpfkQh6u5fF0T/EXFuSH//SY
	WkmloeeAdOEj9rAKWmmzXw6wLAklCBU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-K4HwI1QUNfq0A1SIm3Gv8A-1; Wed, 02 Sep 2026 13:57:49 -0400
X-MC-Unique: K4HwI1QUNfq0A1SIm3Gv8A-1
X-Mimecast-MFC-AGG-ID: K4HwI1QUNfq0A1SIm3Gv8A_1788371869
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a615ab0c06so1285277a12.2
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788371868; x=1788976668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KDbkBpzee7kW17XYRUageSRTyF991PI7JtDtEZAP+8M=;
        b=Zf9vVfJKJZDqY9VyfBYLHvhU7tVGFlwWATNWpe7Kzyn2eFekgvX1oen6aET9HdhRgi
         Q0eml7/qPys8XqrNq+1D0D/sSrgJRf2/ZX9toao48+1bVUr17Xnvb7aqNF+sSQcGnLuX
         mnsSuDhJC2vDHOAB4LGsWqzrgqqj4erZZfAIX1+F0HUx0bvYH0YwsD+67OdZhD4XHvbQ
         nBUqcDVKTfRoRqXZcCMUfd3pE6RRa+Ql2O3a8wdwgfskDn1nBIdsOTcMMhXAFDuFTP3X
         R+rRKL+Ux3Ysfd77PVcunUuRlk1NGaPooA0vbqTFqfmYUBcNwmxT0iC7h6vot09TjDOC
         SN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371868; x=1788976668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KDbkBpzee7kW17XYRUageSRTyF991PI7JtDtEZAP+8M=;
        b=IyfJUh3jugahjBFsOOm07/BunawD9Jlv8AkTqEUsoJqGPtYLuGka62QJ9ThV3ndF0w
         eKStnXoJyjAJMVV96Wo2d1TV57NxNX2bh80wxWxPOyHXDhVJV/1oNQTMp25kgREh7U6a
         8xCzzivAZ22BdFWt5NNnn/nH4EJ4dRFXczw6u0mStKX5il/E8/GenPnrr3XoZF4QeHtR
         bdaxyFzz3+6XvHD1nj2mMTPrFVqpT+ts6O61L0BvIUq3HBupy5v1jaQLwSkVAFNRM7Ny
         Mare0K/3pBYHd6XVePzNvsWW530U/a0s7WsDjPlkkuwODXCx+Qcp06CKtQniq2XgIDFz
         OzUQ==
X-Gm-Message-State: AFuF++nnOrLmv0brlI5MXTdLnUdoPmx5i/mU8M06ln/SvwIi31qLLVRh
	h6kWAi67oeUYxzt4k+3I2WfQFL7/nPXgTITM4bWnrjxk3L11h0XNL0nyKWyVHiFg7vkYVxeLQjp
	kC3j/z/yNu8o5OG6Rkb1RgSENcsyqS0YuXPbOiWLJtjHikFsKYqAr56pycesL3rXwFyHJARpX1g
	==
X-Gm-Gg: AYBFou2dafMf5RAnDvviSRHmIYUfFwxIDmhmvkg6YzCmMNiJJsm+4BHDz+mQxgEa3p2
	dM6sbEMMs9MI+/CJzFOa18wCsMMbYjY5bbFaQf2rh0Ca3ALxZn+Do3Lhq4jvT+Iz0Bb1vsitUrE
	zQLlpP5rnKUW2rgr8uqBRUSTXzBtY4DjVsuhefJ4ESJTZJZ3lnzFuW9bcegt6bEQ4AN/WMWr5xj
	ppZYLbXJHIBgI86RMbI9wyQnVJ8fjWjFeJPpMw1285R/PblBdlVyCnLiQJUtNz5FNaJyM/wpDNf
	l3PPV5poJhGCKQtae23AZeLJyjKBQwdTuQhupwT5yJctzZhUOwZwfnszhZheG7OrH5hU08dQXWx
	B0cJVfAjon6d/aelRcWF2TzTsI+aOKnjvZAZBo8efMygig3RUf7kl7lfSq/9TVFouvJPB1xcU4h
	xR5Tn7ASeoZOHbIg==
X-Received: by 2002:a05:6402:440b:b0:6a4:21c6:1d14 with SMTP id 4fb4d7f45d1cf-6a6818d2536mr5615773a12.0.1788371868575;
        Wed, 02 Sep 2026 10:57:48 -0700 (PDT)
X-Received: by 2002:a05:6402:440b:b0:6a4:21c6:1d14 with SMTP id 4fb4d7f45d1cf-6a6818d2536mr5615729a12.0.1788371868104;
        Wed, 02 Sep 2026 10:57:48 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d002f1dcsm173252966b.19.2026.09.02.10.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:57:47 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v6 0/2] ceph: add 'lazyio' mount option to kclient
Date: Wed,  2 Sep 2026 17:57:46 +0000
Message-Id: <20260902175746.3205106-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827-lazyio-v6-0-2755b379b8de@clyso.com>
References: <20260827-lazyio-v6-0-2755b379b8de@clyso.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Xiubo,

NACK. Please respin. v6 closed the previous holes (bit 19, -EBUSY on
the fault invalidate, keep pages on CACHE revoke only when every
opener is lazy). One leftover, then this can go in. Patch 1 is fine.

  1. fs/ceph/caps.c handle_cap_grant(): drop LAZYIO-retained pages when
     CACHE is granted back, not only when it is revoked.
     After another client writes you correctly keep the folios under
     LAZYIO. When that writer drops, the MDS grants CACHE again. That
     message is a grant, so (issued & ~newcaps) is 0 and the revoke-arm
     drop does not run. i_rdcache_gen does not bump because LAZYIO was
     already held. ceph_pages_retained_for_lazyio() then becomes false
     because CACHE is implemented, and a later non-lazy open
     (remount,nolazyio, or CEPH_IOC_LAZYIO on one fd plus a normal
     open) reads those Uptodate folios as coherent CACHE data.
     On the grant arm only: if CACHE is newly issued and the mapping
     still has pages that were covered by LAZYIO alone, invalidate (or
     bump i_rdcache_gen and drop) before a non-lazy read_iter/fault can
     use them. Leave the revoke-keep-for-lazy path alone.

Do not rework the used-cap substitution or the all-opens-lazy gate.
This is the last coherency issue I see on this series.

-- 
Alex Markuze

