Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617452F12A1
	for <ceph-devel@vger.kernel.org>; Sat,  5 Sep 2026 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571107; cv=pass; b=YbtRSYI8T8/LJ6ahnWtUiDmoTj2iUIuVxyWyVIJn618SFvtSgMhCOrD6eSfrDhrVkiY41FUdfC21Mmr0e4Mcyh8G8m1KiZuMCOwUHk1k44sB5FAT7kHWOnJm6gOAz0/GhdkWbFs29D+3fNPPSmzDCyPrPz6cqzUqHRMP/J50tUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571107; c=relaxed/simple;
	bh=QRWFS+GgSuBuV0EOpOPKRYi+MPqomhFhRkXTuO72POc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DLytEAUvzbHjvH/G6tW1cMwxUw9UhFpHEL8H/6wQnLXbY9mC0IFlsoeqQnKpKex2TEf2qwLB2jJ6g3qXel97gLwoV0eRT/SVSXwtS9SRClWB3LpySt2n311CSlEm2IeCPy/COR0MrF7bxwap9j16XvHi2r/55LLirKgIl2Un7nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=eAWN2CTo; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="eAWN2CTo"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2531f453eeso221012166b.3
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2026 18:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788571103; cv=none;
        d=google.com; s=arc-20260327;
        b=ifFU5WHuh99JfQvFiZC9yBpC2f8bB6mP1v2JVoTOaW3MUnG99m9cczux/cF194rM4Z
         XsyFcCDxRXdJy9eaVRhOZTysmcPHlBlL4Zi2g7cJs6GVmSzkCS2NGpLCJ5Y0Nx1OeWwI
         dQLes4RnQYBWLIRTACYHNcMrBsU8zA4Ts42SWGbhtzcNqE8oDa4pGatY9ZrfHxE/Jzao
         6fBWPMjmXoR/DXuoXZA+N3k0sHcBddpiKZRcOCnrJgqa2iutroKu+vCuWMmGv8LzVpIl
         G96g3BaVUMvIi7gJ7T5BQ40kgODZEfJUfC7S5BGcTBECHKWet7L7ctJNsnUpvbOLVQhO
         6fjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MC2O83yQA370xxba7M3dBk2YHStIU44lILC32r6Jnrk=;
        fh=Q43/aYtkk+pFD/CG9qrr5zY1TQryRKhiveU/nlPdoHU=;
        b=cMDND1QSxW2qj2E1MeiyU07X7eBLF51pPnClF1s0dt4iqUUhcqSxIvXuPyR0VDf1+o
         3e4nT3/BVqMjZFGqblMQ+1FOpTUKRQSsageF9UBkKnvoWoMbe733awGhG8M4HbSiaLDz
         eDPniDOMVkK9RlRrU9A9hh4Da4ukvnaueNWZsmayXf0BoC/kY2usDw0dBKGrKnhK7dYz
         CNS4XKvTT6o72Ag4nRkQbvLzSSPBZJSIo4d0V2eD3O7S6OneU+2kMToH0oG/knCm+i2k
         EJSnzNSvwpZQB8WW6Iwx55HIXeYO2iHVW4qL/PxUr/aEqC3VrDxnXSjOEhCqziIhrP3D
         IvYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788571103; x=1789175903; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MC2O83yQA370xxba7M3dBk2YHStIU44lILC32r6Jnrk=;
        b=eAWN2CTow+E996I5x9d1j3DbWJx0UtN8ZH5WYW1MFMlMO/xKXywG29SOt/pOWkUxEn
         fEaNTEKjWtEG0mo3mv5vf1M27dAHBmsVcCuyX3neY7Xb1TIhZ+H7PmpEfHPwjmPt0doy
         sJHPRt+mSEmHUFs74+p5uoDv3ltOOKA9Ff3DJvgbgrxEAx8FvN/SJQgDj0sJYIvEMiBB
         0LnTFqnbElc0MeyBBYW6+v+angPRza+IUinDJIiHs7cFHF+RAdKspnxopXZeIkeInQJr
         v9o8pNJB+DtB0q/4g6aceivClTjOpGfOmZy6WWSt5StJH8+2cTH8b6O1EBM9PybUk/Dg
         NPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788571103; x=1789175903;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MC2O83yQA370xxba7M3dBk2YHStIU44lILC32r6Jnrk=;
        b=mntr/KnK5tB2QWjCzHGKbi9wYGP9eDHTKz9vdtiYFMKvmJVxzt8q26f+oQeR85DgYo
         ZlzV2bUgMSxrHmMimJD5Ohnyc15MYnI0K60u1PR5QvnBhDQbyI16Ln5Ri3tN5odkDt14
         wVzy4uGOZGBBPzYWKC7iX4k2OeDSTSlICq3hqXsuGWyj9OHF5xlBsMbRsqcgqe+FPNda
         iTWu7wqo69WKAXegMEmP0b48S9B4m7ojS5pLakY7VBmzdVbCbjKWaWo8xbAccb1fDp2W
         xnlFpD2kcV2Fltu6xYxuUevqwTkUmZM+4GgmIk5MEwM5wmSzqjsA6CwqfmCPpkQSsmVu
         xR+w==
X-Forwarded-Encrypted: i=1; AKwUvBwI6qImoaXZJQUvTahdNxaAg6WoKx3wPBCaBaF8+FIdT9Nw41ov4jo56X0z+9d3jEPt2UyGc1EcJ1E3@vger.kernel.org
X-Gm-Message-State: AFuF++luo6Z3Go5xgsyKcFY2GccwrncWXMa7bQUD0mcF+fVws/6FDPbA
	3uuNuZdYXvTXkDPz+HjW4Tm0x9MUIa9HNTXGvIbbYMz6to4NpFAesfIyd226STq3h6l5Sme0+Zg
	oM6STbhsG8h2NVhlbWXBwpLgiPNLJfjgPQ2wnDHWtWScgfh7YB0T/uUo=
X-Gm-Gg: AYBFou0FtEm8slthgy+WkYLWo2Qtq9udbH3+J18f7RgSpmfMc4t814oRhzyIjX7MIBA
	WhZwglUV0dIWVLIKl9thoB3L2CKlDB5Xf0aRITX2f4wgnKub2MnBNOyoaVbQcH9ZjIf6VTnCSUQ
	jaLB9cjdVJI2dJVS+8OTOrfSfAxZOLTZdefORCTNZk85GykxZ7jHyhka9jRYuDHqlPyR6kgnkut
	hKxvqQfRLKhRI2E//gEl9K67+PWzLGMVhZnjOcrWTHAD+btYGlHA9tC3OzX+pKpmRScotysbHhb
	FK4B9s1T37IiZXvPE/ORYX8PtJiqYDI+4bkHjWU7iEzhHA==
X-Received: by 2002:a17:907:9709:b0:c26:2a5:819 with SMTP id
 a640c23a62f3a-c260ca1f474mr642465966b.18.1788571103585; Fri, 04 Sep 2026
 18:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904103351.15357-1-max.kellermann@ionos.com>
In-Reply-To: <20260904103351.15357-1-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 4 Sep 2026 18:18:12 -0700
X-Gm-Features: AcwNN1VahgJIxFl-EEQrkp0gkp8R3dSoW-hNCnMZLa2sVOL76dxy0sOlZpB3OjE
Message-ID: <CAOJNxRLfDHmW_+jtUQogRcHCGKAyQJKBkQKQRM1i0Bvj2vkLVw@mail.gmail.com>
Subject: Re: [PATCH] ceph: avoid pending truncate during nonblocking cap acquire
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

On Fri, 4 Sept 2026 at 03:33, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> Readahead acquires caps while the folios are locked.  This can
> deadlock when processing a pending truncate; truncate_pagecache() can
> then attempt to a folio that is already locked.
>
> Return -EAGAIN instead when `NON_BLOCKING` is set, causing the
> readahead to be abandoned.
>
> Fixes: 49870056005c ("ceph: convert ceph_readpages to ceph_readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/caps.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index bcb04c6cb92c..86e195c5fd32 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2889,6 +2889,10 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
>         }
>
>         /* finish pending truncate */
> +       if (ci->i_truncate_pending && (flags & NON_BLOCKING)) {
> +               ret = -EAGAIN;
> +               goto out_unlock;
> +       }
>         while (ci->i_truncate_pending) {
>                 spin_unlock(&ci->i_ceph_lock);
>                 if (snap_rwsem_locked) {
> --
> 2.47.3
>
