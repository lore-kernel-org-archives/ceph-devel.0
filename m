Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462813DEAFB
	for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845340; cv=none; b=OCir/OCYz/Q57Q1zUbM3owX+H5WjbvIvqhTBTjAhPiplb+etGbNMH31PI/LFY34yt9Dpt3P0Jy7mC7uP2gTHsA87wrZEB8kD65X5BN/X2Ea6fHMGBPM/UoyItRZ6HzF0SvsqUeWpllJYnV8FFQzrFu1/54L9DsbU+249XpLq+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845340; c=relaxed/simple;
	bh=9cJj49EYC19oYmVFPOho3+rdY9QtyOK+L8RcJVhrDU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hq1Sw34XtJ9TfF786WVQjKmDmk37bLchJwJH3ZPELRnrbjxD/YzN0aCteV20z9MDuCmxEuWjCvmS4FclxYykfMs9hHDdYu7gzvX+1iuheD7o47qgfuB+w3bvx+AiK049+Yshwq9fM8JJqmwsXg+xSOpU0CzRr2GlTTKa0iIxZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYgxEeSU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OeOao07L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYgxEeSU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OeOao07L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782845335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJYK0+cjTXP5qgJ871oPkuAmgkxlLCtwWBZr0VEcamY=;
	b=VYgxEeSUZbyMF8BfBZOceORpZVV1LWB8anOhJ+OmQJAGLnXfj33i7+zxO5LzmxiFrJQWjl
	bH5exMqSt1psKDbLYt67bT5qLDDqUOv8vSo/mscHpdetQWG0vAsOgLfj+0n6/yLpbro3Dl
	0w3aSE0CZ4D4OXpL6YI6s2i7f/phOK0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-X0b9PNtyN_STZXoI8Prq-w-1; Tue, 30 Jun 2026 14:48:53 -0400
X-MC-Unique: X0b9PNtyN_STZXoI8Prq-w-1
X-Mimecast-MFC-AGG-ID: X0b9PNtyN_STZXoI8Prq-w_1782845332
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c125ef89f4eso247040666b.2
        for <ceph-devel@vger.kernel.org>; Tue, 30 Jun 2026 11:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782845332; x=1783450132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJYK0+cjTXP5qgJ871oPkuAmgkxlLCtwWBZr0VEcamY=;
        b=OeOao07L3dN07rm7vkb4vmc5nljxl50xLEYKrVbjM5c8FK8VI5npPXFlsVqnuyWGK2
         EaI1Z7TpRc3oLZtoaZKDA28z3Y2ht0YfWgEX8jvzQOlfVYO0gv7Rh0ZSqkPNbYSK1pbY
         IAVT6eBdx9WRRD9jBTFVgRImwGHh5DGXjdyMNj4dJpe/WzKSFopSBUJGiOi2bqi1phBA
         KGM1UqRZ6vYiczXdpGN2EJd5XhWCFxh6HRcJaF2B6LDcJdQzdwy++nrEjFN84ewp5YNR
         s5f8hPgug0xboCVnLB5XKxwzv/5V4wEOADJahuhEuL+3koSw/H80tFEp8ca8nG8ZRUfP
         BCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845332; x=1783450132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IJYK0+cjTXP5qgJ871oPkuAmgkxlLCtwWBZr0VEcamY=;
        b=Qjt5RqiEtyxS87Me/P4DY7dRpbs995zfcTK95jWCdBWQcmESLq9tStvJx4+rln9QQH
         fqo1uahxOKcC2R8X5CUq43/35oq/BgUNFM/fHwxsWUeXDABMNMI/mNniBEqRT/H/MvIj
         NlZtt8HyFSFgefcaO4mK6n01yzYrZhOedcHnEt9fWvkgnFvqBA/vAw33QOXHTpfR5VMc
         hUSq0RUOShHzj7uvCRSwTcKXQdOdktK6Rt/nmYr+c5ddpE+WPz9xbkAJA1vkyiYBOkGD
         W1J6WOO3lb1XYlk4wH0J3s2+VEmTJKAKoMSm2QTjcCQ9wL8Am5DlBJK9O+/aA59QAmrG
         VkaQ==
X-Gm-Message-State: AOJu0YycWDEmZTdm0tFqXfSu7N+PATSlUwuy6pyXOK6tcb6MG+qX2qaf
	V7Xc/Dr83veY3MIqOkizhAR6AIhAN9ud3c0RO0SlTtpAb35nyHtOFW3ubd9ZSBC3jS8lcw7udD0
	reCeejrDOMd/vyI9M4RYvLuAsZLBYWged6uMFCpMVW0kItdVxzZcnQ/n1/WkLjtw5VYaYKs7e1Q
	==
X-Gm-Gg: AfdE7clPfff5aKDTzfnX3MgCpQSjAMTqVQbXawZs2sVd3yhfeGcb4n2BD8Fe170FkVk
	gSA0BPnZGIlLPon2jBdsddvpGF6FPSKZOezm1hilPjHaAaeFBBl2Hh0tjSbfkULK0aG2rUZ4qcb
	KbBu9LupkhxPTcfFYdAlgL2tNJG+ySglhWEI10DMpmHQu5bReUcI4r0C33/Nh3RDB/47t9g4I2l
	PioYfkJy+fyTM2PAN/vub3/3G3G+rs71OV0XkaqWijfrA3WVGG1EHsohuICouf1kg7babNk5Xl1
	F+ngrOh9MxmJooXeZsc4Zv2h4fiQs6xPkPbbydtGJ/TUNBAIDg8UX/rrEkAlKfbkxYBCKISGe5m
	R/nP6k/N2rxL/EJZPbXG6bX5vnZ0Lqorte91pLCfp2I0f
X-Received: by 2002:a17:907:868d:b0:c12:80f6:7fb1 with SMTP id a640c23a62f3a-c128732b9eamr226987866b.51.1782845332312;
        Tue, 30 Jun 2026 11:48:52 -0700 (PDT)
X-Received: by 2002:a17:907:868d:b0:c12:80f6:7fb1 with SMTP id a640c23a62f3a-c128732b9eamr226987166b.51.1782845331871;
        Tue, 30 Jun 2026 11:48:51 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f4771csm163080866b.42.2026.06.30.11.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:48:51 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph: fix refcount leak in ceph_readdir()
Date: Tue, 30 Jun 2026 18:48:50 +0000
Message-Id: <20260630184850.457733-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611144007.88851-1-vulab@iscas.ac.cn>
References: <20260611144007.88851-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi WenTao,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

