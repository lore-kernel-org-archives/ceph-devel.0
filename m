Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5CD223DEA
	for <ceph-devel@vger.kernel.org>; Mon,  5 Oct 2026 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201046; cv=none; b=rxQQwiSa1xlnBGJUJlDZToCezK4AYXYk8FVQFjQMr9DeD4+0+xcRGGUf2Ax558Fnk04T69SPHmDHPI57cMpG1Dbr/V46mgbKe+s6IKtpRWE8jQzslZ/VJpV59lVHAF4AAT9RNK72pI7gvChCMl6EBmEBmMPf8yy/12b8cRPDja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201046; c=relaxed/simple;
	bh=wYjnXXyCSAf3oW4Y5Nu3Q5yczEpyFnJxoUASGqY3J0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTHfh3O9/4wc9xsOqVGcvjmKRwT9STrAEzUlSBH7USV/CttSyc3MH/mOKdj+3w3zWeRp28tFtesHTQ6OTQJezPll2BR3g536LUNSC5QdKaYGI6VVbzZnDcwE8cfqzmvfA87/HmY+EBTwoYaQWSf7bdMrlvIKikAZhmtRqtne1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XawO9DBG; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AaZwklIQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XawO9DBG";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaZwklIQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791201043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W11m4zFv82Z+AdztugrUi8ZTdrF67Mr2+dG2rY6Nngo=;
	b=XawO9DBGhm+fQO7UHr/hoOgqlHvAKjHHREOGDq1DXgbP8rVu4thUb7eK2wwgLuKGppiVG5
	I9tK7tXq9Fdtw71nyolo0Z+mPusX1kl0+oOF3dvtGLHYKYKo61/gay+PWajl8ZOELYWX+A
	wQXToQiZ8R3lcGGvEZMBu0zL4uUFrtI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-VH5JOQltOVawzNTs4gB6lg-1; Mon, 05 Oct 2026 07:50:42 -0400
X-MC-Unique: VH5JOQltOVawzNTs4gB6lg-1
X-Mimecast-MFC-AGG-ID: VH5JOQltOVawzNTs4gB6lg_1791201041
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a60c4a94e9so1601799a12.1
        for <ceph-devel@vger.kernel.org>; Mon, 05 Oct 2026 04:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791201041; x=1791805841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W11m4zFv82Z+AdztugrUi8ZTdrF67Mr2+dG2rY6Nngo=;
        b=AaZwklIQz4Lxx4DaJVI4l/dYb7BeeWhc/4qX4nZUCqdBbjxse8xQU7Tr/BRrJW+eAw
         O4JNOZyP2zn+uHau/3171xS4vmue4nyAiAVd7z6YU8cBBpyrkjy7QaR+NYf39k1J/6kx
         IIuTMvSi00xgWgc4Vu/50mlDkIRCP9YWoVjnLVOPXFR9IhMnkWSR9jVCgGLye2rp67ku
         orZxK1vSnDwG4RDZoKuS/lNVB8B1VG9GDkEFbBe45BG64/de627a/zVgtOLI8OboCGb5
         BHMDhXiYVyyKJ1Otnq6ROH9qCQj8CfSAvs1xClWqKLqeqTQBoapJObjxdirY/Chb4z2k
         Pbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791201041; x=1791805841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W11m4zFv82Z+AdztugrUi8ZTdrF67Mr2+dG2rY6Nngo=;
        b=C36yQd8CaiROn4dNDyGil4SrJKR+SmTqXacuScwLmMWQCm8FM5lgGZRBrC1IfFXB1g
         B5Nnv2j4WqPiMrl4kot2Yy7lv9AX4hz8cFMdbuDorCjfk1ucpsOqhpOXW5M3YANnHv2k
         nJtFbniWo2XOfx/osF1XE+d9SfygC05oHYUYnhKxxCcsbLdIE+H17vUnyHOd5NQr+uIc
         GuITqejypmzQS2kqGfhe6hyxdJV+czhc+rAvO1DJsfC6arsX8yrNU39hwNuG0tx31QRM
         7lA5olJNEFDMq/gB3FAcEwP3r4E/TZiflSznRt9Ntx4DHMKsPvXlXGlxtzLlNIfnqvdw
         gKOA==
X-Forwarded-Encrypted: i=1; AKwUvBzRtwIpcPXfgtUT0tOWxCQNnFLtQ9HK44JuPWNzKNnk3hVf68oCbORtznnYD2JrutBv9VfsSdqI9hKw@vger.kernel.org
X-Gm-Message-State: AFq9FYKBhQHBQrV6G+vO6D3Zq606DRLHpeU55Hfdtn2EQZf+DINUY+LV
	PMpB1f1FszAT4qD49fg6S9/AbiNTVtl8l1qxOZPCJYLUiAdhshatpoPD2R951Z6QAvuwIA2n/lw
	8q5IaRP/JMNX1IbD1oyFSptwQmHhsvOhSAI+VQWs2ZHEClHsCMBmyZNcNhyIVj/UUdStRhqzoYw
	==
X-Gm-Gg: AYBFou2c56CrFKZ8rVXUawvEIZgiJ/fQe7knV8Ox+Zp4IiDv50wVTSFyXlZ3jqmy05Z
	mrtjoxFt2nCxrpOQlcNAAbLj4tLgIP6LPF+8k4+jPjNIvVG/2DF/mx7Lvo3VPfDSNI4bs88l3zS
	pg49qBmXkBFgjiYPYJZlV2Y7QBooUbal6b1h9DLoZB4fCdlyoBJ/DLUYDnqptWOZEGTvclJk63C
	yZbv65miAZ/py2jIz7m8K8dM+x7A3Rv2lJcDH5RoN9BvlukvZgAZYVVwWIsqqqIphQDb1s5nUZ7
	e9uTAZ9vudLURysQ/TU+O+n21IfVNce6wPtlYJ+e9gWTDNh0mYotDofs2hXvZ2pcK2VGBCr9Hfv
	pV9e3HgkGNXZfC1uuZfLoQDYh31nQU0G08NQYs0IrpdPwFSjP/Qr7XW9Vif5ZBKbLdDICoy67rq
	Ie8U4USMKFCrf4kQ==
X-Received: by 2002:a05:6402:51c8:b0:6ac:73f8:2e40 with SMTP id 4fb4d7f45d1cf-6afad901294mr6227296a12.27.1791201041320;
        Mon, 05 Oct 2026 04:50:41 -0700 (PDT)
X-Received: by 2002:a05:6402:51c8:b0:6ac:73f8:2e40 with SMTP id 4fb4d7f45d1cf-6afad901294mr6227285a12.27.1791201041000;
        Mon, 05 Oct 2026 04:50:41 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb01e572asm3264876a12.13.2026.10.05.04.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 04:50:40 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: ceph: clamp MDS reply result code to the errno range
Date: Mon,  5 Oct 2026 11:50:38 +0000
Message-Id: <20261005115038.1906846-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <40EB50AF-762E-46EB-BA7F-2227A407ABE5@stu.pku.edu.cn>
References: <40EB50AF-762E-46EB-BA7F-2227A407ABE5@stu.pku.edu.cn>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Yuanfu,

Thanks for the patch.

Reviewed-by: Alex Markuze <amarkuze@redhat.com>

-- 
Alex Markuze

