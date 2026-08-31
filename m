Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212BD3AFD00
	for <ceph-devel@vger.kernel.org>; Mon, 31 Aug 2026 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161578; cv=pass; b=nUXqZ/CNpyXIiAVz9UaPNcOYngT5TjZcwTHJ4rMi2bqnjP0PAlbCiOWIyufa7aMNgOrr56oHCS1jy3eJZ/Tq9dS0M9xoYMVn0hB6Ov/tnpypenAGjciRaNGhgzqZhQHpmO7fOZ/ttSrK+6Q/DG+4gk6sIqBqlqkKVO/HrQhPbxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161578; c=relaxed/simple;
	bh=wo5jkpGnamGtjDuY1R1XZZcEwvVo/Wee6YR7yCBKlpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rYAKvNz0n4zRFebF0XNlv70fFcK2wIbAFR8JRgbBkWzF6p4VQufL0gqustGl4gP0/K0zMW+8GJZvw7pdXWtK+bZzZk7oG7/t/JL5+vORoHteNWfJH5neQpt2vwTau2LSlKNLAd8n/PfGGiGxtGm4x+/JeKzGuJMbfODM/uHBKwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=f6AYMuAK; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="f6AYMuAK"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2020421077so468041566b.3
        for <ceph-devel@vger.kernel.org>; Mon, 31 Aug 2026 00:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788161571; cv=none;
        d=google.com; s=arc-20260327;
        b=j+X8dVML4Hho3HFOXUDX6vE04r6hH6aqMxhU8IR4xBVTnH5Cm7FrYDiSOW4u9v0Jma
         yBo4MsTk3Jy06H9wW4WCffNV8JwA6j8jz9AcXom1UeJv7ClmciXUTnx9yNN6bKUGkHTT
         HmVKIxAGcsP3SldkkNYkitpZfEi+rkO+ds/Hspsuswy/h5PpM13eekFEsQajTP2rWwGD
         njom9pZitUHhp+CtE61QUARrjskkjaqGejBEDCeM8nxWzEYCYurhoAwEdPAQS9KzSydK
         D5DSV4Ld5iQ0x4e2hsK3jWoxESb/DJ9svuRnuzjW/b84dxQqhED1ElrpTfzMexuDRcKN
         XOQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PFvhvOnOzBnlu/OCaPBHd1SISKgOpJNjXdUIfIOx0Q4=;
        fh=XezuBYdM5Q6o9Q108W4mNuFSiRhV2zJ3jGp2w9NTA10=;
        b=ZeDQuhiC5/v826H0acDCrSB0aA4jwtgo+zBgnz5Y53AX18DvPywUgvzcq2Z5oqCM8d
         FBtWNhgs/s/KIZeBgRICYJN2BDsVkraZJLXq5EH7bi4xAkoVNWuvMPHccrfzfEEjj4lK
         QdWag6AJzr9uJK94aAb4wedzNUbCvxrmnhYdxNdkCMI0jsxkgv2bAS23HBIBai4IrVoN
         B5qaA62mZv9aEV1QeJFThLZ7aJOr79yHTJIzoSiIxVLbY0dO1mloMG2Ix5M8E3q9NKwN
         Uanna2xImESUwiF5rK4ZGUB5VgFoCS57hD8J4znb/ohJmHg3I9jF1/FAgHDpN+DnkPar
         chAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788161571; x=1788766371; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFvhvOnOzBnlu/OCaPBHd1SISKgOpJNjXdUIfIOx0Q4=;
        b=f6AYMuAKCVCLLVTU/UqAVPdDGMaN2fvyMC0JpHLPuyC1uPmnZ/T9g81RiK/tHorVvE
         7NreaCWxZ3qFY7UR56ICcQkQ+BV9+9buro2L17rZl+HpdEhJCxH9akKh0JVG9LUS8kRG
         yzZk/fOSzs2RIiT1uX8rT0pceA1CmSvgydPxZAcHbCZH6FdGvGRecyg6zREysf06Xj+1
         +84pww3ewgG9b2kj5FbfY1O7hfmbISSERzDrvIuJWMHW7GdpfxRoFh6p/B2UbSyublze
         xrnoDFziJsifRSGfBUVJsvNWyE76gYRv6RMpAOeOpgEfr3rQBrIh9QIVfWwZaHKR2DFD
         CryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788161571; x=1788766371;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PFvhvOnOzBnlu/OCaPBHd1SISKgOpJNjXdUIfIOx0Q4=;
        b=qG0yUAhw/8HmB6K5lKG7InOf7XHpN3CRUaaaomj/QVFvDW7GNpSicSJirfOkrZv1mg
         AgExhT9yp0zGGf88/KMZlgh+I5PKycgeCZikyDNwaCT1vwS0SArZ1IVSA8q1HG1aHj6+
         QLgDhi/3dAg4OLRAYiqzNAI2PAbmvt34oivhxpEOtnd8GNKg8pFk6zuqt3ZhqbQHh4S+
         y1UY5ggi4wtCvTxYXAVSu2aprhTfk1TfK+JqZBxD8sDAO7v7UvF9sYvVZJb98+jhXZWG
         EGJPo9BqFHd9folzi1pvi/XWwQPDuRXI+vw0y8xnhKwfJ9SFRJK5BTdN43uob+a+EWWU
         2zkw==
X-Forwarded-Encrypted: i=1; AHgh+Rpn/6ZRGeMbzIj/sODJBxLqAbTciyJu1EBfKZXP6hkr3dV3Geh21pBIpm2D/FS3hnCDk5xgnwkVAAlH@vger.kernel.org
X-Gm-Message-State: AFuF++mOUA+45q3+4zK2WkeqiEJz5nFqehRyrv4Fvo+43nZMHGu7NTIf
	COq6rKnkjdyKqqyBgdab9ZhEP+Y+xNq9XsmG9etpFZ11+fGbvmbeySYgiIFPDA9A7iHu++6hRQt
	nGuRlGUw+mTGiYH0OkkN7HxFuIOcUTqhkijLgU1XX+g==
X-Gm-Gg: AR+sD134dZXdBdIo02SygwrITQwk5Uup1kz9oYVT2+mkCUxP9qqxDaHGxm4kBNKnKwq
	zvTS5C9lsP1saYUzk1QrrUAmovwwOuSBDefZuVvgtdEiJd52WsZUQGchuXQOZGyctfB3HIjNvO+
	+2DzDwgrZ3Sf4xPf+ohee7puRk6b4N6zP9qtlJyRIxAmhkqLalCKojxsBb69B3PHTfyyfcsEhRv
	JVQxzbngKxvoRm00DBl4b5sZm2A0cBfeWn1UByxw+SqUvlJG5lYYgFdwwO/Gdon3qPopRvgBi+4
	7Z6oeL18YaaUVdgkcDu1AhSyRNQuzLVyXt83IZfnrYrHbZ4=
X-Received: by 2002:a17:907:c48c:b0:c24:4128:c19f with SMTP id
 a640c23a62f3a-c2557165b0emr1440124266b.11.1788161571351; Mon, 31 Aug 2026
 00:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827173703.2762844-1-amarkuze@redhat.com>
In-Reply-To: <20260827173703.2762844-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Mon, 31 Aug 2026 00:32:40 -0700
X-Gm-Features: AcwNN1UFM6BeUUDwjfOttejAbN8op5g5yEOcon2Mifr6PMyWshfSc_yv6nV-mks
Message-ID: <CAOJNxRKQcNv3aTe-WLYL7Lk46izVt62=J+Mtk8yUDDfe5mL=_A@mail.gmail.com>
Subject: Re: [PATCH] libceph: avoid infinite loop in ceph_pg_is_split()
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, 
	ceph-devel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

This also LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
- Xiubo

On Thu, 27 Aug 2026 at 10:37, Alex Markuze <amarkuze@redhat.com> wrote:
>
> old_pg_num and new_pg_num come from the OSD map. When old_pg_num is at
> least 2^31, calc_bits_of() returns 32 and both (1 << 32) and
> n << (old_bits - 1) are undefined in 32-bit signed arithmetic. On
> machines that mask the shift count, next_bit toggles between 0 and
> 2^31 so s never reaches new_pg_num and the loop never exits. old_pg_num
> == 0 hits n << -1, which is also undefined.
>
> Do the shift in u64, build the 2^n-1 mask without a 32-bit overflow,
> treat old_pg_num == 0 as not-a-split, and compute stable_mod in
> unsigned so seeds in the high half of the u32 range stay well-defined.
> A hostile map can no longer pin the client in this helper.
>
> Reported-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> Link: https://lore.kernel.org/ceph-devel/d1dc7faa-2373-4c96-ba0e-0e6d3e3b8457@tu-ilmenau.de/
> Fixes: 63244fa123a7 ("libceph: introduce ceph_osd_request_target, calc_target()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  net/ceph/osdmap.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index e3448915bdec..558c7c3a4a84 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -2307,25 +2307,39 @@ void ceph_osds_copy(struct ceph_osds *dest, const struct ceph_osds *src)
>  bool ceph_pg_is_split(const struct ceph_pg *pgid, u32 old_pg_num,
>                       u32 new_pg_num)
>  {
> -       int old_bits = calc_bits_of(old_pg_num);
> -       int old_mask = (1 << old_bits) - 1;
> -       int n;
> +       unsigned int old_bits;
> +       u32 old_mask, n;
>
> -       WARN_ON(pgid->seed >= old_pg_num);
> -       if (new_pg_num <= old_pg_num)
> +       if (!old_pg_num || new_pg_num <= old_pg_num)
>                 return false;
>
> -       for (n = 1; ; n++) {
> -               int next_bit = n << (old_bits - 1);
> -               u32 s = next_bit | pgid->seed;
> +       WARN_ON(pgid->seed >= old_pg_num);
> +
> +       old_bits = calc_bits_of(old_pg_num);
> +       if (old_bits >= 32)
> +               old_mask = ~0U;
> +       else
> +               old_mask = (1U << old_bits) - 1;
> +
> +       for (n = 1; n; n++) {
> +               u64 next_bit, s;
> +               u32 parent;
> +
> +               next_bit = (u64)n << (old_bits - 1);
> +               if (next_bit >= new_pg_num)
> +                       break;
>
> +               s = next_bit | pgid->seed;
>                 if (s < old_pg_num || s == pgid->seed)
>                         continue;
>                 if (s >= new_pg_num)
>                         break;
>
> -               s = ceph_stable_mod(s, old_pg_num, old_mask);
> -               if (s == pgid->seed)
> +               if ((s & old_mask) < old_pg_num)
> +                       parent = s & old_mask;
> +               else
> +                       parent = s & (old_mask >> 1);
> +               if (parent == pgid->seed)
>                         return true;
>         }
>
> --
> 2.34.1
>
