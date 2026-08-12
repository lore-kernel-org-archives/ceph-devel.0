Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715D53101A2
	for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541691; cv=none; b=qDnvjk9eD9oOjZda3dw//NLxcu6bgyXDNONtmyZA8f3hx5IjwzC8ZpkLDGjLqqzWsA9BGJ2Rw6I9njkTL0yeaxmiMdsVefVKyXb8HmkSaioeWfFHjACcIdu1kmyQOBPo7UdgwoHvdd76dTRdLvWfNlg6zDDH3cQDOSaxoQsRhg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541691; c=relaxed/simple;
	bh=aLZs9/OLdBpXe8GAdK/E02aGac/fTZMReSo59UQcxFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nk8AlkSTxISg3xdLDZ1GDXrw8GsYTKWsCHOSMfgaSCWxyoItOiDQ8tw2Rsx19VYQRKG2KHqLgQnXIlFzSe7NropP0OGMPt1aJ3Eyh2OGYiX+Dcf27crGfmmiIDJNcfJwFrXT/oJw1BdyhQHMmgJCUhpNMwzlmverar0VfG6DyNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C3VXWaR9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qn3zTQmc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C3VXWaR9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qn3zTQmc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786541689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89Ot9HnzcEwJJKpGeowFJUBn4sQpdYR+K9a0+2a5Sag=;
	b=C3VXWaR9OGkOvZ2pT2qDIOnJGwjCtlBScYqYedkCc3p+q2qBh9WaKra4dR/cn1GTnmWE8M
	T1sSQegsBo6Dr+58G3I/ZU9GjnwiqjB2llXhxt343SXb1RcmcMG62fGwBVrlZIRCXdWwxo
	VZxFtXQ+/0AU+DmOdlmazPeL3i8USP8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-XAgaYbSgPQ6B9ab_k4bAVA-1; Wed, 12 Aug 2026 09:34:48 -0400
X-MC-Unique: XAgaYbSgPQ6B9ab_k4bAVA-1
X-Mimecast-MFC-AGG-ID: XAgaYbSgPQ6B9ab_k4bAVA_1786541687
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15e82278cbso54155066b.2
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2026 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786541686; x=1787146486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=89Ot9HnzcEwJJKpGeowFJUBn4sQpdYR+K9a0+2a5Sag=;
        b=Qn3zTQmcUGyM64QJbu/PaLz71OTzew6inQj/ZXoKObKeaTiSnu+NS/5F+JIQs2/6vR
         Y1BJiE8owfrEWvHi+aTbXEE7hZP7eXG/rg5xYfnO+bNbeFvhuQ6UE1BDomtWpzN+SfUq
         STGFm908EosyhpYmYSVEamgXjLG3VgD396fRL/UcuDdiPlWVlBDDomfu7e3d9y9etCBj
         Q6FAvKNUMLB+g9d5CWFJG4aOmxTsVSg3cqdfeTppMNJzEPJmaisGmNje3Go4vfoMBvQu
         Qr9dEx0L3a9eXaJD4mcHOQGXIFi1/cBlHkNOmROK2rn3OsgZ+smlFS5ev3pZTFru/iBP
         BSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786541686; x=1787146486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=89Ot9HnzcEwJJKpGeowFJUBn4sQpdYR+K9a0+2a5Sag=;
        b=TqJlxP5jtGkNBCmS6XnSEoTVsQ/Myj59drAwWmJ/5vsw4L2K9PNfd62DXrgQUHh3MC
         3D5jyPh2KfRaRf7FAVZO7Mp/5Qw2tcmpMLn8Ry1aerh30gqmPcdD090pN4K6eL5L3qsT
         ss3M6f1YuzBedG8LnuMb49ihMhLIxnEXYQUxZ/60VWVRbV2BxbQSYX1hpLH6nFjs8cAK
         KKQaT9xD7rOGc+318qwgUM1EK+F1B2Iz2i03UJR7R/qsfBkxmYdQ6SD/yYK7HUpa9Myi
         SirqIZaDqoMdPec9w40ZCeZ96MutK0lHxbZtInkSe1Fuqn1xwFvCJ7TZKK6s6iuE3cUw
         mpTA==
X-Gm-Message-State: AOJu0YzokjSWnmD+v/CyLpRqKz2fCMvxert07o/kljO1pCSreOIJ3vye
	cjSDs9GkiAJ4rLJHE3h9hTokSg3Pxuw/BqwqKTaMukoJtZeS81lvdSSNRxLXtcian3H0hM8D78l
	2XKyhjIgkXLh4uNLDWPmgEMn6YTWj9SkRyiKz35yHvTvrIqUr/g0xxWQvrvXEfd0=
X-Gm-Gg: AR+sD12DK+T+DZafIxyChmmwq9Cxy5ovUuBpGWaByBHcgonoXr2FPKXNumljikbip95
	5eIo1Gm8JrHpg18E8oqlQsqvhKdnE7jIwH62eqD2H5KebUtx/b9bIWQ2Q03lR+xNsxRBCl5dmt1
	e69PkFjNIfr3SLjCDxrK8kDeUnUp3LGlNuJXRS3klpWChratbpEvSGrZFqKRz9kEatmFCmvefkI
	gb+RoPQwww8KY5siBycLcnyFl0ZW/9s5nH53x0D3AjRWG7hp7TacyTMYmK0yF2AZeoDi5rhDNuh
	qYGMr033FKA1S5P6h4FpL0sQuqEcLeBoonVrdvIt7DSdwjLUHjtYnRq3CBPwdUygxHxRjhjPCGy
	SvAfBy5dxGOYJG9y10BJCVT22b+0uXLZ/5w==
X-Received: by 2002:a17:907:c1a:b0:c15:fc59:cdf3 with SMTP id a640c23a62f3a-c20f2ea968cmr208005466b.12.1786541686624;
        Wed, 12 Aug 2026 06:34:46 -0700 (PDT)
X-Received: by 2002:a17:907:c1a:b0:c15:fc59:cdf3 with SMTP id a640c23a62f3a-c20f2ea968cmr208002866b.12.1786541686238;
        Wed, 12 Aug 2026 06:34:46 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20f059195asm93538966b.0.2026.08.12.06.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 06:34:45 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: syzbot@kernel.org
Cc: ceph-devel@vger.kernel.org
Subject: Re: libceph: validate banner payload length
Date: Wed, 12 Aug 2026 13:34:44 +0000
Message-Id: <20260812133444.3288921-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <88076cd2-1b1c-4988-905d-aa4745af3872@mail.kernel.org>
References: <88076cd2-1b1c-4988-905d-aa4745af3872@mail.kernel.org>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi syzbot,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

