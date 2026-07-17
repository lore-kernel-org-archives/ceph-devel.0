Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E7A3264D1
	for <ceph-devel@vger.kernel.org>; Fri, 17 Jul 2026 06:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784269635; cv=pass; b=VwRNBhu5lxnuNcp7lqctAEoerTOv25p6LXnK8zpjfyKi/kGstMBT33Np4qrQpkPB+ULycbVNPd1Ec+RbukohYq9ay3xNRYFjnfcQMTG7wz32EVvrl/lKrK1xKIg7rWdIVHbNnDc3gknHmbRXVJ3CCfbZVRnU/V5NPPHFZKynerQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784269635; c=relaxed/simple;
	bh=QJA16BA/QASuJOil8clU31p6Fuh18DMT5tfaMSxoL28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crR6L69S9rIbv9XgRR/vofgcKEc8DSPoodN5Am8qjbwWAuPJlUjqRpOc4UYgiSQXfPTU+9PJ6cNJT9c5Vb1YTOwGZszG7W/5S+n22U51dy3suH1Ho7sjXc8H1sc8uJGsuA6e8HVxT5hjMLWZ238DwleNPpLMWNTTCuDL/mC0LSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=mzOlxP4U; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="mzOlxP4U"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1601d552a8so782878966b.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2026 23:27:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784269630; cv=none;
        d=google.com; s=arc-20260327;
        b=bxAO0pi/eZzpIQAKlgjc6k/UhAjp9KiscEAFpdZaZlfYx0PvAkU2nnYOsAwJkJ0GII
         eLWRtzZyJ4U0OVOQ1UHY5MQgtfU0WhkaWMy2oFbUB1YkzwxzFI701TthQVdCBNlvPBF8
         ffdg0HNo/jGD9W6oOfhfaxrWdtvb/TCMLwdXndHHbpEAke67lb62LCkP4MIQNeDBxVGy
         phd7BwDiLT2+9F852NDAawzPyXAVgNiy1VE510wsZdSceVJjUUVX0v3LsaqXVn4eyqEj
         OTvgUu8B4vGtn96fQdCDzcJSProCg2q3xUiSln0prdyUm5iIp3dVYQnpx08ZQuxaG3mV
         Lkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QJA16BA/QASuJOil8clU31p6Fuh18DMT5tfaMSxoL28=;
        fh=lIj2fP9TLY8J0+u4Z5gxpYmcsDjYZerPZxdPGefRbRM=;
        b=XqRPQj7G0qT4ggbwd+e+roU3TFMkosGFiKv3MxK1loZs/rrpy/xT7XsxLDs0K6jUdn
         MezXXNEKwduHNu3ZMNYDwGPDckAa2hUqK9okaItcPDJ2HKGDLcMa9N3S5VBW3qsjh6Nj
         GlEymBDXsPLCEeF7cQGZZoUtqgBiOrAYa/TL2goDzNsV+TW2TOsgIhmeoDT3DqiKHkzI
         WCfXNk5ZVQ4cp28QR+tVriw62GGRkHDns/EwC5l4DhbgxQ3Mp7+G2aP6DbhRfvriJolp
         DqwjDGW9i3QQJW/0NloDdtKXo9KgKZYqWscCVFtBGpjwtpi48FlU+/hpadv4Ybbzs2Of
         3yNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784269630; x=1784874430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QJA16BA/QASuJOil8clU31p6Fuh18DMT5tfaMSxoL28=;
        b=mzOlxP4UC4umfY5fypAsUIuPR2t2ksX9VD/UbiwCITZxSv03kwn0Mx/S9r13zkHlsr
         1lerW18EKwAiTMYImI5swN1uZgcVQ7fGu02aNLIqLefygoezEtO7uNUbwTuUDdy/s9vO
         0GW4ZwqaqvHJLqdF0hsacWh0nioR64R6AfC6UCstwSG9tnvppRsIvtlD/GkCllVfb4gx
         RmIyeDRK1oGfjNB9qxjICV6kcoOecX6Mk9hNrH17Si2uF20/WB2VHFwnTU7xiv4Rdsgu
         pTJzoG8MAVNjogsD+jjlllRHBgWg1VQ0XLaqUxOzyk4kSZhkNSxFInr/l22s7RmJ656N
         d2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784269630; x=1784874430;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QJA16BA/QASuJOil8clU31p6Fuh18DMT5tfaMSxoL28=;
        b=HwWO6tgfAYfYPBl3stb1FpUMGR6tUZwbkkfkTml0WsWi7WVqcgG/8HeXrl07sIma/s
         Rg8IIASxgCbulK/tihcSHIZQokFesRguD0s2jqNkwyUtaDgQX1iD6YMOQ5eE5UQgem3/
         PVVestGCRnGB5IwGRFpFJcx+e3hKYjQ1YCa8n/1oG/KYUuk58sKFuvNAatoxQDK/0Q89
         0LqVSwsovCoCdVXw95Ckw8NncN1NXZ+/9VA9iZU67Z4wBSR+u/B5oCmCL0LRCKHX6BGw
         CFZO1NS/Q8ltNdCr+QqRfXHVGrbuPhM1fu1ZOeiI4lWt/I4ssGv31B5glbzaKXfhyOsk
         7nJg==
X-Gm-Message-State: AOJu0YxSG/IY/8a0gi2gdNRiP/NUiiurIszTfgtM0Kl+aHWJSJipfEeL
	Kb9iF6gR0KzvETIrp6XQ42n8KpSM+3i1Lwdv/gaH5EF7Tf3ft/2Q8+GSSdLc0djFB36B75hQ0CJ
	+Xw6/pgUku6htk4LuytrNW7tO2OxSo5GAS7bEkJEFWA==
X-Gm-Gg: AfdE7cmrFII0abtiOSUVtuZdPhT55XF5E7Zz46nFjfrmzWwTjdZAAJ7s0XicaaxXjZS
	3m1jwsxcx+tcj2No5kBWsWBfIH5S+ujANYD9yS6lV6qLfy7rKS+gMTHhlSgVlYebNLCFqzn6HBi
	myrkDvAGnDh7L39HuGG89K1MBy9G6eRvmlioQZTDiNKPBwqJR7WMVnrGkczvf0f7OCUJPJlZGPI
	2gOsq2YLlXEiVTTk3Exl/hMALFy73qTyY3hTeShxAyA4N+UW6ERgksr3YIsd7aZ063KXA==
X-Received: by 2002:a17:907:972a:b0:c16:46b1:e0c2 with SMTP id
 a640c23a62f3a-c16b48a8b9dmr41309166b.62.1784269630263; Thu, 16 Jul 2026
 23:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOJNxR+9tBWfnQ3-wyBdYeJ-ipVM+0oyULtUGk15C5-xnXHqcg@mail.gmail.com>
In-Reply-To: <CAOJNxR+9tBWfnQ3-wyBdYeJ-ipVM+0oyULtUGk15C5-xnXHqcg@mail.gmail.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 17 Jul 2026 14:26:58 +0800
X-Gm-Features: AUfX_mwmpaSJxCINpmKtX-qXBvOfYgeP0BLRrUyCX4Silkmr4vRIyKuGFxEjDMg
Message-ID: <CAOJNxRJQogEWqx8V0D0vj6GiTJMJ5Y9RSk9F6xq+vR3GqrgRbQ@mail.gmail.com>
Subject: Re: Survey: Is anyone using 32-bit builds of the CephFS kernel client?
To: ceph-users@ceph.io
Cc: ceph-devel@vger.kernel.org, dev@ceph.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just forward this since I wasn't in the ceph-users mail list and it
was reject yesterday.

Thanks
Xiubo Li

On Thu, 16 Jul 2026 at 16:53, Xiubo Li <xiubo.li@clyso.com> wrote:
>
> Hi everyone,
>
> We are considering a performance improvement for the CephFS kernel
> client (kclient) that would be significantly simpler and cleaner to
> implement as 64-bit-only. Supporting 32-bit in this case adds
> non-trivial complexity and ongoing maintenance burden, so we'd like to
> understand whether continuing 32-bit support is still necessary.
>
> Before making any decision, we want to hear from the community:
>
> - Are you currently using, or planning to use, 32-bit (arm/armhf,
> i386/i686) builds of the CephFS kernel client?
> - If yes, is this for production workloads? Or legacy/testing purposes?
> - What is your platform (distribution, kernel version, architecture)?
>
> If there are no active 32-bit users, we would proceed with a
> 64-bit-only implementation and clearly document the deprecation in the
> release notes with appropriate warnings.
>
> If 32-bit support is still needed, we will explore alternative
> approaches =E2=80=94 for example, keeping the current code path for 32-bi=
t
> while the new fast path is 64-bit-only, or finding a way to cleanly
> abstract the difference.
>
> Please reply by August 6, 2026 so we can factor your feedback into the pl=
an.
>
> Thanks!
> Xiubo Li
