Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D711B2EBB8C
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543939; cv=none; b=bzDQXSSrE0GjVbhw1n1a5zh9KLzE/by1En6Epe/32mhUoWCvV9xdFIHENZcWZBWsCsuOjG5LWz8/Acqq0Pyp/zG9XWKKNKrEYszaBS3Iy2q6uMkWi1ZQGFR5F3crruRQYX1e+00Kpien4eRvi8SbzM4OmVj8r8f53qMcaGwfxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543939; c=relaxed/simple;
	bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWkJ+djA2wKs/lL5ly0EVO/fXG0o7SL6ZTVeF3FZrUmCfZ2d1Hdr92b/i3Yl6E0y5ThdvqZ357WseWu30oZAoa6FnA8rImPjrrVbF7Sn77TAo0jOpKGz3lT/XvPkxsehLAJ7U58wL/Zj12KW3ozaO2aebmN3yTTuf7TooeOjjiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qh2YMvVl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLAAzFK6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qh2YMvVl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLAAzFK6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786543936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
	b=Qh2YMvVlK1IMm7RKvbXdlXTc+Na8xc+rzmeExluRyjmHPg2uSx42lvekT2pRlHBJhCAmMl
	Jh9DwxOuQsvmfuVbsZzmLC48yEqFeyEo7jWZ6EC9sxDej3Gl9/zgc7hwebDUX2MkvaevNc
	W4tvvFXRmQevpIAuVL1LPS7i2WyCPTc=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-i30wcTXrOAOoS-D1OPVbNQ-1; Wed, 12 Aug 2026 10:12:05 -0400
X-MC-Unique: i30wcTXrOAOoS-D1OPVbNQ-1
X-Mimecast-MFC-AGG-ID: i30wcTXrOAOoS-D1OPVbNQ_1786543925
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4412c255fd4so600024fac.3
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786543925; x=1787148725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
        b=gLAAzFK6e0zmRjFLiVL0zS3J/MWI9oN52bV9XHyYibJifniRmFQUOnNCA6vU5KnhIi
         pOwGOVYBhFQ3+CyfXHfOHY/K1UKC708glYYagRa2OR370fIr7ntPZLCIiBMaEOLjK9EZ
         XZ7ebfjStaCFvCyQEdogJM4D741oYXkJaNQVDsXWUpXY1Y/kS5NZCvPHlBSKitZRBXCL
         AUdNVIMDSuFqYxN7BWISl69SHlAjEEs9th1t+K8/jP/6G9AxPbjhQ1MZIztJfu0sMSW0
         nvPXhM0M3yc5mVbBFm7wKIn3IPKXVbx1Ogz16Vrpmcl5DAxMom2V2Rxcp186hLdpkAqP
         Xk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786543925; x=1787148725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mF7aoj0EZXHu2uONPfsqxJCgO7eZ9qmTKaS5W9ZxcQs=;
        b=G8CJJn12w9F7fz56UVedakmDxIckkosL41rBUXaa0uTznU/WiHnplbo/4YG0woRoz/
         7QO/O2UJNnfZ5gYVz4MN6o40eeuB1klpejspkF3ggapkDMBOOkVg0FNTzLQ/GEwkKuuK
         WMET11eLd9nXrIoYABZtSF+T3KXyxJ/d4lgGS1M3NaPVb8AFBWT5HYvSYfpPEKkPvOaU
         GodKvRcMmF4FSMq0kM+4RyuRw/7pRbahHU1t+7OUHK6K2wCjNAQbTWmKPT7eAApGqk1M
         WlYFey8aLAU4T0UX8EGQV4PMHLW+QUEYUc9fX2JjhoBBwy/MXoRJGdnc4YHX//XoZ15t
         KREw==
X-Gm-Message-State: AOJu0YwkiOZhvKf49Wg5W0iLFMwPpk8CIR6iV8WfYiS2qm+3Fw4pPW2U
	0BAWwsXX+6x7OGR3lGLGUlOOemXJ54a54yDkne8PnNkaaEW1eQz6uEpHhYEBU6zMn1shUYfYZW5
	JkUKkCCrEOdc6RHWVgidS8IQ+QPZfACajuW78ep0KFbjYS5mz7+5oXniBJgavNmfH6Mw9eXEq0w
	==
X-Gm-Gg: AR+sD11I1K9+U5s+7/xm3xWSKk9bzTK+b8V8PyrmKkEovnWaL4RS1dEnLHHlS/IKi/y
	YgPDocGBFMGVje77L/zbDEUBpDj7w1vg8KuSOMMSCJB2xUAvundYqA6srfUH4ldoC2XfgMZRgEL
	5VfkuTfIu2ItSwqvTQkkaJ6evMoIS+tHtgdmKKRBMvgbZh0wfG6kHUvppr6MkIRrUGWQN0j7Mpq
	DkkPaHjYigzV676Ikhw+6ybBU+XgmB0AlHVP5DZtstZASWiOohpBH3rXKEVUMyz1K+bw8OCsnVE
	koLTb1wPvmsslwxV6aQxs9u/pz62n+pfTt8B7DSLGaIWGZ0UC0SC+93a0xqPC2teragCgQ==
X-Received: by 2002:a05:6870:4414:b0:451:b3ae:e444 with SMTP id 586e51a60fabf-45e3e65e16amr4348966fac.1.1786543924777;
        Wed, 12 Aug 2026 07:12:04 -0700 (PDT)
X-Received: by 2002:a05:6870:4414:b0:451:b3ae:e444 with SMTP id 586e51a60fabf-45e3e65e16amr4348204fac.1.1786543919928;
        Wed, 12 Aug 2026 07:11:59 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e35175873sm1948860fac.7.2026.08.12.07.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:11:59 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: xiubo.li@clyso.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ceph: use GFP_KERNEL consistently in __ceph_pool_perm_get()
Date: Wed, 12 Aug 2026 14:11:53 +0000
Message-Id: <20260812141153.3356341-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <<20260812-b4-gfp_nofs-v2-2-9574af8a417d@clyso.com>>
References: <20260812-b4-gfp_nofs-v2-1-9574af8a417d@clyso.com> <<20260812-b4-gfp_nofs-v2-2-9574af8a417d@clyso.com>>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

--
Alex Markuze

