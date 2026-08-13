Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0D635CB6E
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622735; cv=none; b=bkITw10MCwfEbE29lEo2MIxWchZM/5N7Iz8OPb36XvZsraZ9loweflOvTa/hado9w2eG1oTYKLDfZSpUzPIEvO+FfLlkNEVwKz7VWP4AZsUSrJ7prkvJo8//ODgXQkIAjUyxPgjPND7EJahvhjecJwnIVy2dd9Z5SVXMEQ8AbAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622735; c=relaxed/simple;
	bh=4ZqF56FeiGFHAU+HW3yAHNHVjDs6rzjM51wMlQAP3dA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dqPKh+O3atapKuwsvITyrDrNPrwyR/SwuJCwTx3TpOHAQ0La98pHojukLzhQIjo7lHVynpd6Gape+FCpBr+gXRb+ymmm1y5CLM/M21MZ6DPLeiBfIOngtPez2q2Jb08EGy+xov2UNXSPqyjPDHdhvCgvljOn4ppWYFP4J594RT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iq3aKBaY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H17uMMal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iq3aKBaY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H17uMMal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786622733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZqF56FeiGFHAU+HW3yAHNHVjDs6rzjM51wMlQAP3dA=;
	b=iq3aKBaYRxrc3G3qaX6fw6Q+DG2m7k0j15tS0I3FxZzntA7SxqM6gaKxyxz38G458XZl0J
	nHrhtsgcVrY2TpRfDVamCqAel2dUwxoQVU9n6F1HSgLPWufN0pueAJs1ns+tIGBr43qWic
	a7UBndfsMiHU91XvBRLmzHz0oLLNwGo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-ri502s2lOSqFxSlMMWRUQw-1; Thu, 13 Aug 2026 08:05:32 -0400
X-MC-Unique: ri502s2lOSqFxSlMMWRUQw-1
X-Mimecast-MFC-AGG-ID: ri502s2lOSqFxSlMMWRUQw_1786622731
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6a36683ee94so707875a12.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 05:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786622731; x=1787227531; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ZqF56FeiGFHAU+HW3yAHNHVjDs6rzjM51wMlQAP3dA=;
        b=H17uMMalCeslUAlKqlefTABkQOs9FCKshHnbixrOUCm6iAqAsb4nEPPM7jdTvOy3Vd
         xqbZef04YTOxE+I2jwQP3bBIvthfCuV8hf1Jo5xTvXrD7Le2sUkFwQPjmWFKUqa5IRKU
         0na/9HmuwkVLggIGK1UB14/UEZaAT0QXSxWAEHVQDooengM1gwjkn1nOzv4eiXemmngL
         1SR7ZANDG51Ppe4wskIqeE9PN2Xl+zLUaaB/X6AIH2S3Y98tb69occh8w0kXhuDOYA2P
         gaiB4CHKNtmc6/300R36RikWH7KZSqGDZN4DFBIH3V6+q1bK1zXoi51RUolL65HsCECs
         4ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786622731; x=1787227531;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ZqF56FeiGFHAU+HW3yAHNHVjDs6rzjM51wMlQAP3dA=;
        b=YYUJWa9GZo8MZficLQCgmqw6pxJpf+WnbP128walyQuF2MFSHild8CC5Dopr4aNCDE
         8M7aYHlNYmQY0c2X4lnQNKHdfJVS53vYKz58yqAnYtU2dZqNotzfoP6h51IpGHUbqLwD
         Eg/7XlHA5gs+bfgERkrqz4h9Irc8YWzqul+fPlAOfmbDtKqB5wbNk8LvQGdT3YCsCqxZ
         dK7k0Fpo1t+DMj6X4eDgVUbgUu5MzUnw1haCc3JSoabv4D70V6aekSHob7q2wa9SbJlk
         NOzKZ+gOcL3XtFu6LhsoOpOH2Yd3cPAHTR82udkdb6i+I29528GMwieUHZp9g2tTx9QL
         WaBw==
X-Gm-Message-State: AOJu0Yx8Wk8G8XxIRYHdxpX7C7/WRaXSrs8AUkfYWVMJFe8kl+A5Tn6z
	gJKPhwuCOJtTAbdhhWn7NeO28xn9zF6gTCAtB6MNgY7CkwhffP/0RlCe7iOKEkLAGJSheX2B64K
	VpdiZuZPET41kehOkoDchcNGy/ZRPah8MlG+CHHF3op3HQgUnKpE0VFwCDNY0bNPjg4OKvEfv+w
	==
X-Gm-Gg: AR+sD12aSRj04k+AU2SEYnNbRHjPdONofnGPd21Di11A4bW3aSD74ao+4ZiA/di3DN1
	5Elvdb22l7vNRZYFQOEkSzhcuA5pTU8MZ2Ge4pEqhD5+OeMaHpVwQQnvpjrFcIAbXVC8kWvQU3P
	0+Wt3UmwokRMSt8WmnNhzCOMAQ/C1J7VLwVP1IpSqL0pd7jzj6TpcqZaSCR3dX6kuKY6BRG7Tos
	48miLfBgjhf4dMyy30RDsz6eheuzdJw4h2YDbdmXP6ccI2nnvM3bkcgXexkY64WonNf61D+WpU8
	ul/zS5JUlZnwxT3yMpOqivh51BkYFkN1YC8Y8oWN6lscj1NBv2a/lfLwrzlHtaYve5NgvU5ZMDq
	m4x7BwzMmxG5Mx0MaJSGpE4+VksjkhiLLuQ==
X-Received: by 2002:a05:6402:4406:b0:698:6620:d988 with SMTP id 4fb4d7f45d1cf-6a380604e87mr2502043a12.15.1786622730850;
        Thu, 13 Aug 2026 05:05:30 -0700 (PDT)
X-Received: by 2002:a05:6402:4406:b0:698:6620:d988 with SMTP id 4fb4d7f45d1cf-6a380604e87mr2502010a12.15.1786622730460;
        Thu, 13 Aug 2026 05:05:30 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a37f8b6573sm825217a12.20.2026.08.13.05.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 05:05:30 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: max.kellermann@ionos.com
Cc: ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2] ceph: force a cap message when a deferred revoke can't be acked immediately
Date: Thu, 13 Aug 2026 12:05:28 +0000
Message-Id: <20260813120528.4000503-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812201915.1783578-1-max.kellermann@ionos.com>
References: <20260812201915.1783578-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Max,

Two issues in v2:

The clear_bit(CEPH_I_FLUSH_FORCE_BIT) in ceph_check_caps() fires whenever
any cap flush completes on the inode, not only when the deferred-revoke cap
message itself is done. A concurrent cap flush for a different cap clears
the flag prematurely, before the deferred revoke is handled.

Also, ci->i_ceph_flags |= CEPH_I_FLUSH_FORCE is a non-atomic
read-modify-write — every other flag on i_ceph_flags uses set_bit() /
clear_bit(). This one should be
set_bit(CEPH_I_FLUSH_FORCE_BIT, &ci->i_ceph_flags).

Could you respin?

--
Alex Markuze

