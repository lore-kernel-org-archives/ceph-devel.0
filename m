Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0484641613B
	for <ceph-devel@vger.kernel.org>; Mon,  6 Jul 2026 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348733; cv=none; b=artC2ft4efHd79avKF1x8IJ6NSyjD5Fw6W0Cphi05I3nwk1aCqVfgtCnjq2B5MZ6AIhAYfm70sIO31Ypp9gOESVKOpfa1rf5NDE3zfd87h2d2kLVXm1DlRd2xTBeqA/F8Ih88uFco09htNjZV4w8rHUj+QEB4TpkFTYbXtR+Q/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348733; c=relaxed/simple;
	bh=T/gRztBIqVBSD2kK7VbhfmGoXJKIAij0LzG2UPJEt1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IfzbRmORiLmvDHHvsfzqzXL1rvUQmECRcBk/WzpwvHK/hGMdKJLV9HxdoSzansapkkld6QgEGfUn9AF3kA0NW0YKJr3Mz+DWHAUTwwdi0CAbe8aWLSwCaywESkb/YnXDIGKt0wQZhAtAt/H9kWKr0QZqWKIPa/1d0YyQqP/iKLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bRsKcwa2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqNwb3qn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRsKcwa2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqNwb3qn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783348731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGh1bJE3kCYXLLGANk+c/vm8qpNDP9lPJ7CLuzJVLRc=;
	b=bRsKcwa2sPwgsl6DvLHxybA9eGYCmnC6Lc22VJnvB2bxIVxMgypWYEBGUp1GQ4itgTcx7g
	jTclyg7xKFowrtEFcCi0/eQRbZdmODP4VMaQaLjGvVQvzu0LunEk19jdqD/mUa12ktvuBV
	RUMPelNG33DhM+hcLXlr9ISofL96yOY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-Hp6CLZ4eM12re1gqqlhMwg-1; Mon, 06 Jul 2026 10:38:48 -0400
X-MC-Unique: Hp6CLZ4eM12re1gqqlhMwg-1
X-Mimecast-MFC-AGG-ID: Hp6CLZ4eM12re1gqqlhMwg_1783348727
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-69885c8b7c1so3003080a12.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Jul 2026 07:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783348727; x=1783953527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGh1bJE3kCYXLLGANk+c/vm8qpNDP9lPJ7CLuzJVLRc=;
        b=PqNwb3qn5Zt8Xp6a/sMj+W7rt0dYPEG8RfMFszei5tKnjtvWGX4+zMeLwz60GoH/BM
         rCFjfOmGZ0BM3WDLOcvT6Q7EpChbj68g/8cT3DI1nXaUy5j1oFbnqMmV6GnDGZ9bJ8E7
         hCf2KdvZVzwvw4mZBtqhATsvYGTlIG+i/VoDdXGM8KX6afSzWl48joxdsGqod/AaT6T+
         NjTas++AiNvC2kVwrm7X3lnpr0UqjKcK9xsZ2+uI8HxYdOJeqiTK55B/RQSNyVkXZ8U2
         IFRMOCvLcXyQa57gZfPl0tnH5yJ4ygOCCXmO3pnQ46Uf1AxC0ayrSC2pgp6cldUxW2xb
         FFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348727; x=1783953527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VGh1bJE3kCYXLLGANk+c/vm8qpNDP9lPJ7CLuzJVLRc=;
        b=oZfNxsadtGlMBXTfZdUdXXFi8AvgxTmkaML5ojMOlWMr4Am2JjdkOPSZOnw4Xkl0AD
         a6b6hJiPnl8RZ3W6t8KGvCD4ulkGwX3isEjIqvhyrcVXbtNR+s96KmQ4cAmujtl4up2z
         d5NSpuzI+RnAyatQULMbd+xbBtv8hYYuMf60n8k8ADMNbbfoBJhpaQjuVpKCWSFNG5Bs
         byVilBWHSYgowP1SS6RCYyUZrvKCfeuqd4NQBbuWWWcmB4fDpDjttP1BFginrl9xwsF8
         +YJkP1FSQsngUlfWvZjj+YJ32NFuuIYd821Dg+5YaTdjShUjllbYVy/8phZtaAAEWRiZ
         x7Eg==
X-Gm-Message-State: AOJu0YxD63sAp7/+AOAaVZidKjxTTKz7D5snCnS/eHA/JEVE2jHEIl9x
	Uw2NKX67iz5/2uucaks+Rt+oVMHmgE4nWytSwrQYBUBc+qahp/XEfidzvVsORHvRP7z9uvXjHFy
	OyqxxDTKo3B3odOgC1feeOhMnz7eR1JRhTru+cJcRLrsa3ZT0QqknfE77QRTgGQZM6Sd7cxnzJg
	==
X-Gm-Gg: AfdE7ckk9GwtbV7ooFyJPzeW26m4Hmya9At35kYwsiI20ugCI9lkchZeAPinqgCWrbG
	cziucdk33YMY/pU3n3xpCkc+kIdOkyYCfI2CtKwnLogh11p/Up0TjMyztyKk3ohgmIXFppYgI0r
	c5tk/PI35SNcvik0YnnuvsD2jokir1YlwDF+Tlq8EIg81OP16DtByKBa9satVwbYI0eTEVkCMqJ
	zC0j1KC3bk7kT1VBpwg5+wJsq52efZbNiCgLP5IUVRMfQqPz6EjR2oFQbwX4B2EUVm+Njdh9UFe
	09AMEHk77e2jkWTQGTZ982MGUNludr2Oj+65+quIkj+ECtTrcFMn4tT8/GP5DaM4GhQaZVgl6uv
	RRjwS4lWVcpJy7vidoKb98iGHlx7wS2WWfCGHW9OfcK5G
X-Received: by 2002:a17:907:9d11:b0:c12:a468:fff4 with SMTP id a640c23a62f3a-c15a671c34cmr56924166b.26.1783348727291;
        Mon, 06 Jul 2026 07:38:47 -0700 (PDT)
X-Received: by 2002:a17:907:9d11:b0:c12:a468:fff4 with SMTP id a640c23a62f3a-c15a671c34cmr56921566b.26.1783348726866;
        Mon, 06 Jul 2026 07:38:46 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b62f5c41sm767276566b.59.2026.07.06.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:38:46 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: fs/ceph/caps: skip __touch_cap() most of the time
Date: Mon,  6 Jul 2026 14:38:45 +0000
Message-Id: <20260706143845.1980928-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260703113253.3635335-1-max.kellermann@ionos.com>
References: <20260703113253.3635335-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Max,

NACK for now. Thanks for the patch, but I have some concerns
that need a v2:

  1. fs/ceph/caps.c:876: Unannotated data race on skip_counter
     `skip_counter` is a function-static variable updated by all
     `__touch_cap()` callers concurrently (only per-inode locks are
     held, not a shared lock). The bare `++skip_counter` is an
     unannotated data race that will fire KCSAN warnings. The commit
     message acknowledges the race but doesn't use the kernel's
     convention to mark it.
     Suggested fix: Wrap the access: `if (data_race(++skip_counter))` —
     documents intent and silences KCSAN. Alternatively,
     `DEFINE_PER_CPU(u8, skip_counter)` eliminates the race entirely at
     negligible cost.
  2. fs/ceph/caps.c:874: Use u8 instead of uint8_t
     Kernel convention (and the rest of `fs/ceph/`) uses `u8`, not
     `uint8_t`.
     Suggested fix: `static u8 skip_counter;`

Good perf win but needs data_race() annotation on skip_counter and u8 kernel type convention.


-- 
Alex Markuze

