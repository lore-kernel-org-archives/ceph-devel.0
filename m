Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C594534B7
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992453; cv=none; b=r0qiVD3IO18+SNUYM8u3gszGM82WBohf7v3JRYq7NKA0Iln3/MyP9hgYGlk5pIFGQs/R9G7MPoXcyi3+aspvaxFK6MJPWDSlhKRW7Kb2BUiGh6xghFaNRQMrsush8aHqp/ma2uB8O42sfM9sHF+jRg3aWc4aDQVom5GhLfSkFhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992453; c=relaxed/simple;
	bh=Muh1Wr26sSqsFgIWZpFCNEZyCgQnpG01oUdb3fGH68I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbjN217YQTyVzNjQQNKr4TZBdDFvla/L8iF934RgjXZvYmJK32D5BuJJ6BUhaR7bONuDgAUw83dT8dPQZpbBpBmkfWRYNbtj2JDChcnWgD+gu/3+bo7NYqYPJ4ozDRjCLIWoRDicxTGMI8Evx7bJgy/gd/u4FHBRmbpq1QXt0mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQAwu99N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D+1gxzV+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQAwu99N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+1gxzV+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782992451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JMkEFAU2fEg/NP4HqunxeIDlW9R4pRnd4X5PES7Wicg=;
	b=KQAwu99NehvuDcoFSY94r6YcGzsLeGI7K2NJWs8L/S5bBTn7yfzCH0sz1j3Y7dXFIlC/xR
	WVwjtjIH+KcHTBkUNQCVzjPZT8yaLfBwtOIAtH2HjJ7raN5Qg7qD0uC72n+XDEiqq8vWOW
	i7s02A3aVN2Z+vM0JWaQ4DMDTVfgdi8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-VoXyAtxIM7KwQHWwKpbeqA-1; Thu, 02 Jul 2026 07:40:49 -0400
X-MC-Unique: VoXyAtxIM7KwQHWwKpbeqA-1
X-Mimecast-MFC-AGG-ID: VoXyAtxIM7KwQHWwKpbeqA_1782992449
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7eb58b8b31aso893034a34.3
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 04:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782992449; x=1783597249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMkEFAU2fEg/NP4HqunxeIDlW9R4pRnd4X5PES7Wicg=;
        b=D+1gxzV+cTGGPGdGfwqjdBipd0vK8hf96HjFrXq3WGyhfJ653syfRDxQw66wKzD8dq
         kQ5jg6mFmIPErFFITsDTfNNv6xLHy+QxgFHUhvMSZUy96Aeu5xOZDIzGQ+0t1ttjaLgV
         sFQBvsuOXGhXbkRxPqOwdwS591nUKxDEHmmRdyp4SHPdlmFNVpSlU9i9rsJMuEHEC60X
         DKEHVe+gfSvFinKwc4dfNuwtJlkeEmW/ZjtYsrsQrKRTD4lfm957J/ZrNO2+u614HJLb
         q2wzW85t4Qg9pP2MMMn9NRQrWTJ4rRAyuyfZy++QfN5OrH6P2vSb7cAM+i+x1U77m1c9
         6FAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992449; x=1783597249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JMkEFAU2fEg/NP4HqunxeIDlW9R4pRnd4X5PES7Wicg=;
        b=X0WDdsYu9uLispv+XzKFnCLocQKFVZIlGeIfORuGbRkDVMfqP2v73HvOpRTR3EbWG0
         jkel1JiPm0HxDDKR960fJBkIBdCGA07+9EmqwHo+bTrVQPBCrZN9vokagP9wTu1i1qbG
         XAIfNi5ZjQhZXh9U8ZwooP+uA7fMVWtaj/rjzihj6A5NmoZUOukF7tyce5vgUfT8BJjl
         aOKU/XkJqx7Yj8Ct2yI7JPR2Q4LynX6r+hyReJ87JmtaA5wDF4WtNsmCT7lB+DzLVo+R
         0qXkLhLdO4UqDRgAtsraTvAtLMBf9UKgB5KJv9jtm7NlevrofKj80F+oqCugrteJiQ8I
         gFfQ==
X-Forwarded-Encrypted: i=1; AFNElJ+eI9JQZKlJM16ZORZL2+GUoQ310uXmsF5/kg4F8gATSaKrYxK308GRGxOlqUdk1gwkDfPystzrAoKr@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3dGEvGDebVfRzN0XCZlZh4JlKGjKT366d+inEhA5hakWAz6b1
	iokynHQpipXv/p6F0dhXkThGRPpmDY1+ppXqm+CI4/TmDQzXf/1dlgcjkivIhvBAnfkeV5EkHcC
	YY29I9sL6pwIs1uL+WbCKvvTUBzq5fL3H0LKKa78ZEjcoQd1HyYrtFmV8Z5AQJPc=
X-Gm-Gg: AfdE7cmqMCEJsB076SvaOlfT1Ke97LwMr+LB97gycgBi6MAijJfGuDrntrNJAzzUrbr
	wAmpme0bGY4cWPA+yflUpWWm1hf0raGpqx5Su5qlScrlqFOq02z4xEh2PHS8Xzr6B646e+MTMLI
	wDG/0rYl3AY9n0xojoCbakMHnTKOp7sJmWY09CotuKKXEua7J+FcWljpQ+ZcC4e7jiIYAgn8CFQ
	tW0lb32Dyp1/ewqp+v6BSV9GLcwCt61Lnu9q22MJ4aPzYp4jkQdRFHigyye01XJvEuiQFdrxM+h
	oTGIxNfFnKPEPZPQ9x6a56yUCp+C66qnCxsmCK3ngaM4+9Db2vz1lLqT6dAClp+w09SQyzkVDB6
	BcdUf
X-Received: by 2002:a05:6830:3152:b0:7dc:3db6:f02 with SMTP id 46e09a7af769-7eb503793a1mr3260825a34.9.1782992448979;
        Thu, 02 Jul 2026 04:40:48 -0700 (PDT)
X-Received: by 2002:a05:6830:3152:b0:7dc:3db6:f02 with SMTP id 46e09a7af769-7eb503793a1mr3260819a34.9.1782992448534;
        Thu, 02 Jul 2026 04:40:48 -0700 (PDT)
Received: from cluster.. ([13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7eb545515casm2206351a34.27.2026.07.02.04.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:40:47 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	ceph-devel@vger.kernel.org
Subject: Re: [RFC/BUG] Use a bounce buffer for mds client decryption
Date: Thu,  2 Jul 2026 11:40:26 +0000
Message-Id: <20260702114034.917507-5-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415034020.11530-1-CFSworks@gmail.com>
References: <20260415034020.11530-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sam,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. [major] fs/ceph/mds_client.c:578: BUG_ON on wire-controlled length panics the client
  2. [major] fs/ceph/mds_client.c:580: Patch may not build against current tree
  3. [major] fs/ceph/inode.c: Trace/LOOKUPNAME path has the same vmalloc/fscrypt bug
  4. [minor] fs/ceph/mds_client.c:497: Assignment-in-if and missing braces
  5. [nit] fs/ceph/mds_client.c:494: Typo: fscript_str → fscrypt_str
  6. [nit] fs/ceph/mds_client.c:574: Missing unlikely() on inner-loop bounce check


-- 
Alex Markuze

