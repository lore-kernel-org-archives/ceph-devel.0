Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6113B2BF006
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376473; cv=none; b=uMnjKL6Wh6PO8zGZ2XxW2VbAW4mCyUsFanfr4kNHp6BclQ+gQ5rVvq1gkpiF5vH+NpX8FPZAA8hsl96fy7wzlmXVxwILX7q6XIU5O8CleZ3xI6H6i76vnH6HUGo5uzjzNJ+JCy0X5am4SWJaeYIyMXCiLoLVQvCreGJlBDaHdRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376473; c=relaxed/simple;
	bh=N0BNPTBKn8tkPzSxOqAu78EhsMGa/E+5kYRZ3EZjg5I=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=c/xrFWzPiqHWiqMgWiDncUnunV6Wk8np8vcYdew6oNcplKAhEEsSZrzCeqWFhJerANACZqvsYQ0rfO61Z40o8jN8ZnCOdxr/LfNlGru4SbeqK/Pph6cvR4W8n/Jc3NFl8onEQUOcP9766TZHRd0xMZVKMwyXwag5vUxxjfc97jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=reframesparkle.com; spf=pass smtp.mailfrom=reframesparkle.com; dkim=pass (2048-bit key) header.d=reframesparkle.com header.i=@reframesparkle.com header.b=Ut6AD/nK; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=reframesparkle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reframesparkle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reframesparkle.com header.i=@reframesparkle.com header.b="Ut6AD/nK"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8aca6bd57cfso104774796d6.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 04:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reframesparkle.com; s=google; t=1777376471; x=1777981271; darn=vger.kernel.org;
        h=mime-version:date:content-transfer-encoding:subject:to:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N0BNPTBKn8tkPzSxOqAu78EhsMGa/E+5kYRZ3EZjg5I=;
        b=Ut6AD/nKEdomCU7hm2qOZfTbvjykzGmTrCKdG+hS2KegsFfkmXDOYNeoH0zF2r+HiS
         TRBAaKE8eLwh5vDcyO9Jx5yFyOnPml3dv8heTdeY24eZe25HVFsCy8am7tjfsoEGQnro
         XrVNYcg0p0/9BSbg2EMbKZoABmhKGorkc+NI/El31WLpzo/nSW08GkF+VwKhfkIZID57
         seZRvu0NyMowD6aV7ZfMP3AygKtM1sORnNg/TfgSURB12+jNh+YbaVWG5pzGqJbt/uLo
         hpS8Ck2eF8hHCju8JA3dsxr7ZaywE2N440kJLQURSfhdoJZd16gUibnAEkkj0E6PipSJ
         HVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376471; x=1777981271;
        h=mime-version:date:content-transfer-encoding:subject:to:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0BNPTBKn8tkPzSxOqAu78EhsMGa/E+5kYRZ3EZjg5I=;
        b=DHIusMqBkntLE2DsQt3IDQ4fJhGDVRZjc8lnOCDWQrAJnKcVou36E6rJS/PdvezpAh
         WJMjdKeE3KZQZP6dBKYoG5v/nVYWYuPj1SpKuoKfLznYXENZ8WO1LFvIc/2VWEbost0D
         kYdqjl8WbPxOl/+Vk07thUiKvODCH92KebBWdIC//J2Laem9bwfq+ZQP/vOaD66UlSo4
         3S6qWkxYgmfIfAW2qfb59CcmYmX6gZqklEDjMh4J4sdv5ytxZsrzkwikvhP+aS8/2Ioe
         HcH5HPfPL16IdEh4e7fW4BUgyVj1XEVr0q/GqtM7xswmNV4fYnJ4PSaNevZzyjdpLhuM
         Am3Q==
X-Gm-Message-State: AOJu0YxjDVYX5z3jxRNUQkGox4yKh008B+ahrH3m5k8JRLYuM5ntEq+g
	b0x3jhVu4fpMTd0u1EKAzDizegGpt/lHDgOgtuSivVQddAzh57cfB8w7Gv4eF4JcyG260MRUWXc
	NY8ZCHKE1
X-Gm-Gg: AeBDiev1Dm1J3Wk0Z2c0sPEeih2oKgbRMe2tg8ALT8mbpMXalVryoddLtsNiyxwVzk+
	FJImBShlbMqQsNif+ywxGj1cXYblM/su/Rd+vV61a1sNkJ1v5M6ScSovQC4K4Ctn8Xrfyp+VhgE
	CevwcSuAeZJvRovzRh3AjGzuw8zadLcab7mJdz3QZH2aQx9IeA5OSUsYvxgb6ufng2mN6PsUNfa
	xd3wBWp9n7vcN1dFnlzVAn+94+XQ+Lq+Q/dTvR5B6UVOg/Y80OnC3xgLZbDldSnnWXs8MSYWuKc
	bMpM8JzFas9t3bk+qDqLlN0R3j24DksTuQXcsdNUNjlnajz3hpG3W/DJRWzC2fC7+Mtax+SBJY8
	8ak2bcFK2Q4OPAO/ISxM+ossiMk9re6qTAVnQA+gvYLot1bTuxi8rPI4ZR5MH5e3OjmEwSzusZv
	f5s3hDYogysmTcjQ6XqmS/u73nDewVVPCCKXNGOiXwQlYI0sQHQ4Dp/orfUN8FfjtiWnomwuQ3H
	xaeP6dOeues2nG2hqTkc+TUhX6klQyqVf761sSilWmv1XMr+kWYp/CKpjdq2DmMKBchnqyxBg==
X-Received: by 2002:a0c:f11b:0:b0:8ae:680c:81d2 with SMTP id 6a1803df08f44-8b3e31ca2cfmr32014386d6.47.1777376471170;
        Tue, 28 Apr 2026 04:41:11 -0700 (PDT)
Received: from 019dd3df-3f9a-782e-ac1b-d3784da5ee64.local (ec2-3-149-4-118.us-east-2.compute.amazonaws.com. [3.149.4.118])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3e28623dasm18191616d6.19.2026.04.28.04.41.10
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 04:41:10 -0700 (PDT)
Message-ID: <019dd3df-3f9a-782e-ac1b-d3784da5ee64@reframesparkle.com>
X-Mail-Abuse-Inquiries:
 https://app.instantly.ai/privacy/report-abuse/019dd3df-3f9a-782e-ac1b-d3784da5ee64
From: Richard Jones <richard@reframesparkle.com>
To: ceph-devel@vger.kernel.org
Subject: Just added 1TB of proxies to this email
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 11:41:10 +0000
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hey,

I just added 1tb of premium resi proxies to this email. just create =
an account at Geonode Proxies and you'll see it (promise this is real, =
check first if possible!)

We power proxies for about 10k teams running =
scrapy, playwright, , httpx, that sort of thing. figured PyPI maintainers =
would know what to do with it.

No CC needed, 7 days to stress test it on =
your actual workload (countdown's on the dashboard after you log in).

2.6M owned IPs, not shared pools. Same infra our paying customers use.

if you'd prefer another email just tell me and I'll handle it.

ps. sending from a weird mailbox because our marketing platform had an =
issue - promise it's legit, just sign up and you'll see the 1tb

Cheers,
Richard
