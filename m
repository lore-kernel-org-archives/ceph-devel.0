Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737AA3749EB
	for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625450; cv=pass; b=s3ZwdshgBQ5KrtTnFB0k7RmY4tWj+p+FycTms8/NHilh2Zwe80s3MOVLjiAUW7CBKx0EBD4JZW9pVemulXRSq/nrvv3rPft72ZJV/WY+lxekSBoSNZf4Zaj2UlwzS2jn1kj7fiTXtHWfBjxuRgGz+o+NzaWUm6y31F73UX7OCtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625450; c=relaxed/simple;
	bh=R8NlmLemcCqxXWV/7ThOHjvK10RSWn23VoIu6O83JhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pR1/bLmZEY1/8y1c8TgUDkNX4CmqHf2qKUXkhX/t2AsUx2/iBbHvkn/Wmz477yLSrCC4G0B25b2MnL3EckH7a4MaxFZAxbNAgM/HA3kSgmxs4GUEIElRe6/T96MGxNAcLm85uYu99iHIyU/Rsz4nUDcoZ26y85X2ep0VsK3YNdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iO1+DHsl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7YC+djD; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iO1+DHsl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7YC+djD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786625447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8NlmLemcCqxXWV/7ThOHjvK10RSWn23VoIu6O83JhU=;
	b=iO1+DHslDz3z9JEpLAUrNiUaSz9qFSiC/KeV/Pe5PUkjQg7BiwSnuBbcu4hlRj+eSi0JbW
	LdImlbDRVGlJ9/RI8a+s+O9UL1MJJOdXiumPaq56tqhELBAQ+0chijlDONdMYGEod0Nsvz
	jvmy+NboZtEdhlBNUGQkjIy3tcGm0Rc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-RNS9A2NMMnGLsrmVucDOeA-1; Thu, 13 Aug 2026 08:50:45 -0400
X-MC-Unique: RNS9A2NMMnGLsrmVucDOeA-1
X-Mimecast-MFC-AGG-ID: RNS9A2NMMnGLsrmVucDOeA_1786625444
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-74ac10b9862so360539137.1
        for <ceph-devel@vger.kernel.org>; Thu, 13 Aug 2026 05:50:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786625444; cv=none;
        d=google.com; s=arc-20260327;
        b=Yh1MvYNNRKfJWuj0JGopL8PXTg6V3QWvg2RhRZmFjdVAcjTgKx4Zq2RiI99oIGiVc2
         I0xDHwQPTphTb2jg6CMHisMojxERalfa4Umg4q1LPTy9wlhKQofvOJ6f/N96otsEwtiD
         r1/sjHdjaoDC75RePDliBQgEyj3TSPNJ6ezIHvHHsLiHwbnsFgvL4T2/dnf3z/MeiBo+
         JqjVnkLOVQ9aTgDHhNK+xKR8pY1Rsw+mYCE9ZbKrBHeOQYCKtk1DvR1mfR6OWlQGnAEk
         Ok4gyMxNtmst0gJ6ZRuyoFl0moQT3PYdaCjzaqGRPNwv5k88d9MbWGFV9p3AHgY51LGq
         +MrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R8NlmLemcCqxXWV/7ThOHjvK10RSWn23VoIu6O83JhU=;
        fh=ND5jKzeHt9h/dXLOoVdfWtXdF40HWmEGaqbNDH/FHQ8=;
        b=B58jxX2+evlxqhBZVwxfqQAS1BxqKncnZda7hJGrr9zDvqkQ2ustzHoQs1Q5ZSHcvA
         TiR1m1sS+zVFvC0UWxngd1qYR3n2DAvwBaHzCEOawZJHTw8M9vxk7a6yZgNiHvk65Nrk
         NXfpHkTXFCaM5DZG2JY8Qga00pHTpjcayKbNWTH/e038r6vlISCnebkOXBFZaV2kWqDL
         3ybDzG/BTNuPIFBGmf+eWvlMfeoh3/BiRs8AekTobI3IfJ3LDDKXxoMXIbYL3YrI1f6Y
         2MOsvhB69MTyJFsfU/7oC6VlJs1RoYfABHqGz+5QRS2K8vdkCYwV9zaf3SC7OHAG34Rh
         9LoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786625444; x=1787230244; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R8NlmLemcCqxXWV/7ThOHjvK10RSWn23VoIu6O83JhU=;
        b=i7YC+djDEcTOhvyG3qHjmRZA8pzPmhVGsNU5diNMNoaN94xBzbVZ9/v9a0wA3NALUX
         ePndBWxLUqBRyB6ik/6X57DO76PmxXXxJBVhNSDKr7KjAWZnAcw47q9DmkHkbXyZ++6I
         PZT2u+iWMviUD6+u7DY7jZ7fNIQ4COOw2BetmNOsP4N5P2DMi2ODdgPIQwwrbHdSDrhv
         iVFmtRrZ17y4ve5epqz7DRM7FZ85fP43gzKu6VJGa4e13X4W/6eCNh7eWZN9+wK5ohRP
         NUE0yCogNeUuGCa93KdH/03aUYoPvMxKDgIvUag64h9XI5JJ5lE7DkncbLbWXN5zSobR
         D2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786625444; x=1787230244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R8NlmLemcCqxXWV/7ThOHjvK10RSWn23VoIu6O83JhU=;
        b=nY3XYxGVUTmZD2DUEqPpYqtF5g0JOVhQJuLZmnHDzKT5OfQ0KLMQEqSBrHAZpvI3ch
         OPp9LJypFQQ/IG+CrFNaepfHGP0nayutohXdOHR/EFnbvoPxHPbUKe8J5L73Vz4vadwH
         9yaJ0gE8MJfXaZeqap4RgoczrO80tI9fnMd2t4+J+32DSIXQI+DscWRFOO1eU2bvtjZ4
         4LAt2TLHIIPT8+GfrtChdaDEbGYls6XGUKHtWR1+l5/zwDQGv3NmeaKyaCJYx2vVJkvB
         XPmKW/pqj+QiVWrEkUoNPlRywetlZGD6axschLHzCaPRoSmkhL9iT8647xrtMxi2ig7l
         PJUw==
X-Gm-Message-State: AOJu0YwX3lwWd8UawrXjPOiY6xQ+cpKJqc3kEnjBosspeM5IisO64UyL
	J2fnB7wyiO68ViGUxDEFh8knwwjBh1zUuuVNj/bjoxBIPLIIrqtfuab4qFNCjaKzPkxjE/3tqeG
	IxeXBSmitNVwtQunIaVXV7z5QMPWqxP4BoQU1x8Shz+ihExG84OXZ4PZp+DeqlgHsl7ypmlA1V8
	rX/thyqTViJEdc/xrVB3uiZuNhhlzbjLSYvrQr6XVH4X3a7wbm
X-Gm-Gg: AR+sD11zPQbN99VnYWztDC5bylZFn1Vps06NLkfvFVihQvzjQeGqbKotKiO26icSLc7
	ZKqk/IAIY4vqL3obAj8p2uVX+1RLPFR5xHtLVB6nHYQ7VxmTEm0spTD3WQbQ2MOKDZK+qWcPQ7f
	CqbFsxwGUnOl8spg5B72AsxhYboETAh8Mm5h9sAT5R+DcJPA/fKCQ+Isg=
X-Received: by 2002:a05:6102:5f0c:b0:738:84c:6b3 with SMTP id ada2fe7eead31-76db5175bd8mr1433048137.3.1786625443758;
        Thu, 13 Aug 2026 05:50:43 -0700 (PDT)
X-Received: by 2002:a05:6102:5f0c:b0:738:84c:6b3 with SMTP id
 ada2fe7eead31-76db5175bd8mr1433030137.3.1786625443237; Thu, 13 Aug 2026
 05:50:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812204920.1805545-1-max.kellermann@ionos.com>
 <20260813123137.4005275-1-amarkuze@redhat.com> <CAKPOu+8aW59jU81H6ky=9k_M4XRWegiN8x6ZmFzvvS5ek_M0wA@mail.gmail.com>
In-Reply-To: <CAKPOu+8aW59jU81H6ky=9k_M4XRWegiN8x6ZmFzvvS5ek_M0wA@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 13 Aug 2026 15:50:31 +0300
X-Gm-Features: AUfX_mxcLfPULQo5N8NMRGwvc4qz-VnmirCNXCACBL9wh3UVsdymHU-G1ViOyoU
Message-ID: <CAO8a2SgwxkC99EPEJtDqsveFiCL4hp+pe6MUy6B=3m17pmrckw@mail.gmail.com>
Subject: Re: [v2] fs/ceph/super: document struct ceph_dentry_info and its flags
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yeah Ok, LRU reque is not the same as last touch, you should keep it,
thats actually ok.

On Thu, Aug 13, 2026 at 3:43=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> On Thu, Aug 13, 2026 at 2:31=E2=80=AFPM Alex Markuze <amarkuze@redhat.com=
> wrote:
> > The dir-lease time field description still says "last touched" =E2=80=
=94 that's
> > still wrong from v1. It's the insert/requeue timestamp used for aging
> > against dir_lease_ttl, not a last-touch time.
>
> I replied to that part of your last email here:
> https://lore.kernel.org/ceph-devel/CAKPOu+946t8E6b6U0UtyqddoU869-tNg96Bky=
tCa2MOsB6QsuA@mail.gmail.com/
>
> --
> Max Kellermann
> Principal Architect
> Hosting Technology
>
> cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
> General information about the company can be found here:
> https://www.cm4all.com/impressum
> A member of the IONOS Group
>

