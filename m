Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F322D9484
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814980; cv=none; b=Bvlwk3WQpQoufEJyDgtiAew1J8bn0GoTPXqjkoFJ5u+/g1qZS8vzcNMeIjk1lsIMHjBW9DxDuyzrITDI1uXka7st3y9A8S0Z8vbkksa8fUBPYACkb+VDFj5gQLxLosMUF1E5ntwhQRqUwZ97I+jYwo1h0dzObt5lobD2blKVq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814980; c=relaxed/simple;
	bh=GD25KSE9m0KngciLnBIXteVjEkcyMdl9IyeL26I6IrU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T6j9v+C7dbWzNyxBlaY8NQx7NUnLI1D6wWqu4Y0VjSX77zfL6vxYNGRkkomhjhEDD+XEeSJB6vi1lZ/znR8rmQJjQW9QWTzvoU5cgOYsaTPgI2+MIF8DKp2bQqdaCxwrRddwcTqFC6MrIpIRt2AVmhCdhTX009s6i0MmiWa9kvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOw9atAK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dh26nP3t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOw9atAK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dh26nP3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782814978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WFgWM+83S8jOfIuQH+CFsmfBeE3L81+gHes9GHrylSU=;
	b=AOw9atAKd4lDh3tSw3J/fINQv0NM8TvyPfyGL4K8gxrT0riWCo+8m3ittjnba0LMsO+hk/
	XTev3/gz9Uw0ZAX6zlnGz1hW+0OW3bkm3rD7VFkgKUkywOuQnjUi5+s16STzpE1Q3WSe3k
	+dYCHRPOa3neMlINj330MWc/vt6+3vc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-pUdXFaSDOx-GZvgSDo9XNg-1; Tue, 30 Jun 2026 06:22:56 -0400
X-MC-Unique: pUdXFaSDOx-GZvgSDo9XNg-1
X-Mimecast-MFC-AGG-ID: pUdXFaSDOx-GZvgSDo9XNg_1782814975
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c11f0760aadso410066566b.1
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 03:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782814975; x=1783419775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFgWM+83S8jOfIuQH+CFsmfBeE3L81+gHes9GHrylSU=;
        b=Dh26nP3tdYfw4Up2PJe1w58Td7D8d7ReFL0muqhFCbuhxr3/RiCyh+5eYNHbsbtMDz
         mGF7TWWzdNUZit27PgVt8KX9a46QtX5fSTMAeGgzVQs5KwD9XuCOyukuOTwHzA5w97/L
         n2JsFKNvNIplp5/H/bvNmc134kO1BH8j+ZhOKe+DJ7Hh3MaDEb8Wi3U/KTPyvVhpGFHd
         RFQA+V/mjOLnhXVnCTwzIioQ9NYOxYONQs0Wv+QWpSUwvtAsToF6NJ2+CWzkq4k8rs1d
         sg+NEbmldqKWm3xBMFzXK5Zv7NEtH1X301K0+Aduy67Vk9QBdLBtxCLArdDdlif4XBkG
         mFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814975; x=1783419775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WFgWM+83S8jOfIuQH+CFsmfBeE3L81+gHes9GHrylSU=;
        b=mb0/lMXfdZ3SmVc1zr4xTyW/C4ym++Hz+K9ViPy7PRVsiuvxeNqEB8NHlaWaN1p18M
         P2IIm+lvH8I30BYD6ETkxGSikdlNw9AjUn0OitAoqSzCba7wBAjMqSunKsEdlkCZNYlV
         pHKEjMfzgoSnclGbaQXWNqGdwR2XRSYD+Vsa6092UelfpSaEpYlANJlll5D9JvXAQQIp
         EF7Wlcy8hC50D8ZbJOJjkTnEyzW1nopomSbyhbdMoImq8LkDP9dJcEUK6B1WnJsRHub7
         ebnyVh0vdo5oSG453+vtPzd6jsql8j1/9vNr8v7c6ChnOGuT2gq1IV0KU9Tkjy/1pel7
         Ynrg==
X-Gm-Message-State: AOJu0Yx8MzZkKN0SW751WW5szNWaSDlfOJlX2UpXQWMr6yAtDnA8fq4+
	drLPwMQeP/9qA/wAAaxaE+VulHvdZFA4xBsUgnru5cuc0aMzLFRqbFKQcmzgW2dj0pgUeB1UF1D
	S8zhUKMnurh3BgrZe2hKwZNJtd9J0EWvEYeePW7m24ZxyGm7UeGLqDbkNg5T+vCCjLu2w6xjFYA
	==
X-Gm-Gg: AfdE7cngvtN3qMCX+qMf6n7tpIdCkxtx4LiRZHr/zivQAirKMXos3wv2M15dYPq2903
	JA8qy/hIKSmA86qNMQ9aWhMb4JreBNn9u4LqGB4Vh2bKrLPoI5OgOisSe+JDBnbB4DlJLc0o8yV
	ALuIRXGQ7eX/KEGYIXjMePOJ1SEOC4bwuj0EGkPh2EtguYQ/6+OeEhDWRU/oM/HW9lmlDbOUWZB
	1AyFPJdlGzYYEAKFx8aZkgcVtHpD3A7q35bSX6L/0RoSDtc1XMdTt8cnM+gtRHsIzx5w+xDVWFE
	OyRrih/DdCEMuBTPJvMDP81EK3HPnZFpivOPQdQTu9dutq7cXpCsAvcI6xDPx2SaC7/dgzXzVX2
	oVJERnXf4lWMSfMWesAVGfoy+T1MYaEd5MVWQWyVYnrZb
X-Received: by 2002:a17:907:1b29:b0:c12:7b3f:6c15 with SMTP id a640c23a62f3a-c128738175cmr142306166b.62.1782814974794;
        Tue, 30 Jun 2026 03:22:54 -0700 (PDT)
X-Received: by 2002:a17:907:1b29:b0:c12:7b3f:6c15 with SMTP id a640c23a62f3a-c128738175cmr142303966b.62.1782814974261;
        Tue, 30 Jun 2026 03:22:54 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f0e7c8sm102700566b.29.2026.06.30.03.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:22:53 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: support RWF_DONTCACHE
Date: Tue, 30 Jun 2026 10:22:52 +0000
Message-Id: <20260630102252.319068-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401053109.1861724-1-max.kellermann@ionos.com>
References: <20260401053109.1861724-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Max Kellermann,

Thanks for the patch. This looks good to me.

One small commit message nit: "needs preserve" should be "needs to
preserve".

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

