Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6944542FCD6
	for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787137644; cv=none; b=N4OgLDXq93pxCEry7H0+CL+OXz8GbkTyXCvzkAODERbIa8Fdlrin//GPCH45lABXi9LbRHUigPyc7HnCsS5ossOKmity7BdDt3L5v/k1qc863KqLYuU6iSYxerrVTaaOh+w9oIevG47DDNbIgNNghhrB0COGLdkhVsyzlDUCxxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787137644; c=relaxed/simple;
	bh=UlpcL8D/kHKxvV3KpuNkjghoqkSI78GUp7B29NtoKPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDIKD0NscYMYNdxhcl9Ur8iuUsThfXaMy3Ki4oPpLwMj++QhrMynSAi+mMIvt1N0N+/ftSwRamCsWBzpTdHuLFYz952IPSRxyi1b0LTjj+SD+HlYZmssQnH5mt61/h3CSNzlSWbaMPS+G9F9hU+87fP/GBKtjxpqirTucDdeKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqaG+l8j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+bWgsPo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqaG+l8j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+bWgsPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787137642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlpcL8D/kHKxvV3KpuNkjghoqkSI78GUp7B29NtoKPw=;
	b=PqaG+l8jdKkQQxQWOMifJefT2mbJEpPge/kMDow542HWGIuGco+gBp4Toc/Yy4p/mjid8T
	l43+0scKRpekmFG/TtV3+4GkhQdIKXy5YACm4SCYO7d9seAXg3YUZiIwZ/ErDi/o4CiqcI
	xyZ05uYUt59MU3x7G6vQ1RlijfTgWDc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-ebXDHrF0PzCXSa9GfN2Rrg-1; Wed, 19 Aug 2026 07:07:21 -0400
X-MC-Unique: ebXDHrF0PzCXSa9GfN2Rrg-1
X-Mimecast-MFC-AGG-ID: ebXDHrF0PzCXSa9GfN2Rrg_1787137640
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c11f2b9f62fso62361166b.2
        for <ceph-devel@vger.kernel.org>; Wed, 19 Aug 2026 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787137640; x=1787742440; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UlpcL8D/kHKxvV3KpuNkjghoqkSI78GUp7B29NtoKPw=;
        b=e+bWgsPokATWjV0JGDWLx8SLIgtqC+TU5G97NxFU5FhY+GavyS9VJW8EQL7tseu09r
         l3qtDzAtFcB5f4SpmaJnQ9dY+5yoKcZxwwPIC/RMDN5/tgpCOdKxO5E3o5k0GoWB16oc
         63VZWXqx205+lpWJDnPZ2lrJKGeRkKoehgfUeVfSNJibjPCq3RGcrY8baskbRAdzor2s
         VvvLUBd2y9q9TnFdDka5adzLKJoNy3DrfopAjyZOqXs+SpsJt/AzOutIuNBE4pFgGvMZ
         au1/5XgMZnIo0C1zplcFK0PH+SrT5eMRwrfAmE+2x+skGmGLeuKNfGixt6Bb2D3FJyln
         nTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787137640; x=1787742440;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UlpcL8D/kHKxvV3KpuNkjghoqkSI78GUp7B29NtoKPw=;
        b=sAqANilnclpX8rTXdfGWkCsHG0KVV282KxUzCS2CmSZXNB19AMuGnG4k3thg5N/CQK
         mU+Ffdi1kdsE6Q9EdlZnoWXz5S2vAn+ZNoa3sKpiLCJCZgjH9OI+3EF0CSNRIQKKfgHE
         Z+zoc9w0hO2F8STvKt62UgE4NlPw07SyXWDsmdw0VSj+37TAyt2W+2sUer0Tl5f/viWe
         LF603Vo8vxDv+0A0VNTt0oygijnI15SDGG6xcoGF+pLJAiH4tUtTsBUJg3CklDI5FKdB
         orMH86brCJvQ5/3Lv2mXMN/DRWIC8BD9R0p6avfyzq2aaA960NSuFv+A1OtJE9wG3Dpm
         6N3A==
X-Gm-Message-State: AOJu0YyW47RPkrZe9trVzxZVkcUsnW2fp7XCFnMJBUiuoel9bYlW9cEv
	hiq6bDKepqnNLEl9Cu7Sp+uWk2QN9nqwcL45RsEhu45esR27+FrQFubOuxCCndNeeBEMh+zU8Kh
	VTmpfWq6rfd2lkTpUJkMAEVeb5rGNFKVcy11SkJM6FZFxsVLLMzV6jXcSgdueAso=
X-Gm-Gg: AR+sD12+ya6FXG7JeihSbkxNyPSNhAhc8UIloMGa2+b02Bs7+wqJOYgIoy0acs5NU7g
	U1YgF7M6YR+4/UY3GAG8yCN4mdKhGqIhAviD67/BOOgk2I5F7rg2Vq42rv8VwAcihlr3zCw2ZiR
	1VZGKlJiH2M8t/uBUUJQAWtCypJi5IKNRD9B6gPJzpJ2wl6Qo1BzGHCqgtMiSQ09lMyDAw+eCo5
	2VP8qFf6Dhq8Bmj/DADI6FHE6L2sc8Oo+g/2CE+rDWj7Jhna45etS/j5i81brg5ZLnXSH6StqFR
	npNqGaZ7UjZeMrn1UhxVMoM+KZO2F1W9RFZ/LLYcaNvFS7UOBbKgOiKwueuDuedrJxO8d0Smzcr
	e6xY2pGKAmDBgUEdWuJJb6HmDGkia+G4ESg==
X-Received: by 2002:a17:906:fe42:b0:c21:9cf4:e1b0 with SMTP id a640c23a62f3a-c23f929e249mr208983466b.3.1787137639953;
        Wed, 19 Aug 2026 04:07:19 -0700 (PDT)
X-Received: by 2002:a17:906:fe42:b0:c21:9cf4:e1b0 with SMTP id a640c23a62f3a-c23f929e249mr208977366b.3.1787137639524;
        Wed, 19 Aug 2026 04:07:19 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c7ab943sm59222266b.17.2026.08.19.04.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 04:07:19 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: tz2294@columbia.edu
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v4,0/10] ceph: convert writeback path to folios
Date: Wed, 19 Aug 2026 11:07:18 +0000
Message-Id: <20260819110718.1304071-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <<20260817-remove-wait-on-page-writeback-v4-1-0e5e53d47eb0@columbia.edu>>
References: <<20260817-remove-wait-on-page-writeback-v4-1-0e5e53d47eb0@columbia.edu>>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Tal,

Thanks for splitting it up — the ceph-only conversion looks good.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

