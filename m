Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB933EC
	for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 03:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784001117; cv=pass; b=OTZ6BhdrWhwaEalfFn4Lmcf1Z4xIAgEUDUsTNdTN+ZfJHH/NlMKDQGxtonDcmZtookany1n/XRhpQIsL+gyQ99qrLYSAcnXfocUtSDcZWWBs2bdmTwd4F1MGfGLl26OD4sF6fNXcxwI+CZxjVdw2F04M9rb7IMlffzusIFZHTXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784001117; c=relaxed/simple;
	bh=/4vd/ynLVEt73kODiOVbUd9oFRKPKmhd0CMjaZEujjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTFqEr2ZGhCnYsTHtkQAeXUAZSIFZIxMNRKJ0XC8p3wMK+RfU/H1MDJEjJjaiyAokdmWgtFrErbCYX4VOS3nuHoNlyyJ9ZjO2xTuhX7MiEwKzWr0XCGmoBjBiv7tzp0M40k4Q9j2ZZUC6szDtvFutb2vlvK4zFAqwZN2TxOYGz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=eP2uJjfa; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="eP2uJjfa"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c15bf399d3bso74734566b.2
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 20:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784001113; cv=none;
        d=google.com; s=arc-20260327;
        b=bSAyS9jqIBlCTkTCKD4tl+QexeOH06h79gdaCtZc+IBTMcemSWrODm7CWMqVXVLIEF
         tJYZMFCAh0uYOp6TktZxOSgXDynR/C3tfm3ZPjlqDcv38IQK7dY/JQT6jIybkNEkDobq
         aKLKx3xedyrVWyucsWDT7noB3KtzAsDRSK/3hH2WRDBP76HyJ0AaFNG4eD8i0CDd78e+
         jjNupsbQ+xFOvc6q8rQ66dINFOHB/rj7MauI8yz4FgNTe7D+i7BnODbi810IkRvYUJaR
         VBolbyJbegcEPlRFGO2Ke/sROm8b6P+c7DjyBX8mAMD7hzzktzUVOgt9+M0x1d508xFj
         sqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BqhgOXrIRwjzJj/3hydnAR7acV/T/DUa6V0q7Bsse2c=;
        fh=QakNoIeExC3YD1Mwx7BqTBiwNoySi6Sh1/4FibovBYw=;
        b=L+7e4zCd90auKWLPPYl6WqMUYKgkQ5FBSsbgocWLTUwsgnnngz6rSfUYHVPurt6Pw2
         7oS9G95S1LdinGPxb3veN7pw1K0zHAd4uUIr0Ly6m4NBZ46y20ZKIpK6UZqk+3DyLTEf
         dRTsziWfaHWLbudsu687zXexc2z9rSqse/SsyfN75irSsEhZec/OFD7fBHvVcbV3xD7g
         Tcnzn+IV67Qo9E2rMSxjt6hGVHoc9J9r3V0rV1jf41DhD6MSkWW15KYktJ0jMaI+Kc12
         +C8pOCaa1rURTqVdWAJv56SJGKIqBN+8oyXXU65p7hJE0nw/kqRciOf52DqYB3kPasj4
         08PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784001113; x=1784605913; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BqhgOXrIRwjzJj/3hydnAR7acV/T/DUa6V0q7Bsse2c=;
        b=eP2uJjfa8/J51bBvI9N22Uvw34X+EIonQmsaEonzBSO+5cVwlGOUKjkE9tutO40EYd
         Fh0G8fT5XayffAZHmoJ05FA4OfoPbdvpTToc9hsqXhwhuzwYcAb1oUyODvPWIVFdjq92
         oSMW221lDZl3jvCxs9D/xiKQ8Y2tjZlf5jA5qPojTYae79ub76/oHTAXlJ+X/z24m1Wi
         fI+HwGqwMM6LJrZzuX2tfDK/9Zqv8+/u18fUw0uLkwh9E9CsOfcNSGWHQ5rKYQTFcdy4
         y7gDlNoqGdF4qtgVzf9rDgvc3OkndoS/NSa/rAc0tV0ceVpYTrgdhdfaPNTwdw0SfPzb
         DQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784001113; x=1784605913;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BqhgOXrIRwjzJj/3hydnAR7acV/T/DUa6V0q7Bsse2c=;
        b=Z0+55SGwPXiAwH0ng/7sWz7NBL0C4O/ASNPiIDoJ55AYSqe3UfVOfSoQNEW0+1plqI
         TGWPCZ45zhPruHPR09W9gOnwUq8NWJlN0DbfxNrmNwcUHPUJuHHD/J8Q9gsysQLOqSdJ
         cFqzPnT8zwuOxa61MuS8VpgMsW7M1RlrkqA2zc3jb1IfWhPeB6xtAbXiMUKNYtXLdHDK
         T6LgeNesgewm4T+aqE+I7BAr75nfbObCpJXXoyYNSEN3wQIRSHT4ns9YWjd47ftxO7uB
         iEHMMtlOiW/YGnTI6SYwYcSK9z6U1bImYLUf+9TVHDzObQYdI3+C/nLRNHy6OTVN5T+S
         bijw==
X-Gm-Message-State: AOJu0YwnxE0yCEaZpRzYBxNWYkBuxZbPiRBjldGpLurKKxgjvjRZEbfj
	4G9O4hl8r0/4luyXF1wIUt60Uhe04RXuxrMZR27I5g877oopKNnhRite5M1Jj3vosdt/FilJR7n
	kC/Q3vcBXSQ7HfhRm+qkfgf9pf1UanWUg5eIVu8F+5Q==
X-Gm-Gg: AfdE7cmmwRD4h32sNMPCox2M3pILhig4qZzd2ZjYIn9FaT7r3S++miIOKm51cNluASA
	f5MmjfQnO4uMWWUkMGNCqXPkk0krSJLLiLlNFQVt06uUT2eN/j/AarmjJUOQsoK3BphaWpQ7hOC
	sl483UuwBUlAT0XBUVChbRZsFQf1dcdr4zQOUa6XTYEUr+pFSlMY20wWmAtUQw2Kp/KXUCuicSw
	hKGSg177eui6lbnNyrMgpkQT4ZuIKQd7HlXdRnhG5Ly5iozrFLF+KMBr3d1iIALaBnJbA==
X-Received: by 2002:a17:907:7211:b0:c16:2e4f:a372 with SMTP id
 a640c23a62f3a-c162e4fb897mr432711166b.13.1784001113412; Mon, 13 Jul 2026
 20:51:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706143843.1980879-1-amarkuze@redhat.com> <20260706143843.1980879-4-amarkuze@redhat.com>
In-Reply-To: <20260706143843.1980879-4-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 14 Jul 2026 11:51:41 +0800
X-Gm-Features: AUfX_mzXyw7QeRGU696lnvbobSBbRphTHZax9qcKHvvI4jKeGlfx3KXz9F4-n3E
Message-ID: <CAOJNxR+n-496jNQFrOVv+X-nN2_-n-SnLpQ7TYc19-vkmLaqKg@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] ceph: add BLOG page-fragment allocator
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jul 2026 at 22:38, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Add blog_pagefrag.c: lockless page-fragment buffer allocator for
> per-task BLOG contexts.
>
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  fs/ceph/blog_pagefrag.c | 95 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 fs/ceph/blog_pagefrag.c
>
> diff --git a/fs/ceph/blog_pagefrag.c b/fs/ceph/blog_pagefrag.c
> new file mode 100644
> index 000000000000..bae88ea82aec
> --- /dev/null
> +++ b/fs/ceph/blog_pagefrag.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Binary Logging Page Fragment Management
> + */
> +
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +#include <linux/mm.h>
> +#include <linux/module.h>

This file is simple and it seems the three headers above are never used?

I removed them locally and the compile succeeded.


[......]
