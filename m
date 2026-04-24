Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4D93264E6
	for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050677; cv=pass; b=kHw8VhnW81MdRFgvJVCdUknWqBTHvixZwqOrIAtW6zT2FrL1JpToiZpdS8KRu9KxrbDTg0oI2QA7dDhcpkGH41sBUmK26vsUg7diX81r1T/hOUVtfl4b2QGWvCVqQ0PDSxRADyD39BcRdmF94KaX7DJlJNRiW/0XYSpe3zQJn5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050677; c=relaxed/simple;
	bh=aLp/QV9zzX+5lPcG3IDuFG75xwtWKQmWNcXCX7P0kEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXJRmztYtAAhXRxrdqjauBlngZC90AQxoR6+CqyQ/FHCPnc/cTZQOQzsL2OhzET6SgZrSAIKcBpeTa5a0+8H4me01s7G7L3h98Fv2yiPG2/NblS/G6NJ8T4shFTXb3zqkW5SzeF+7jm0MD8WgZoaGVtWb4fA6pxUZwSJXDJ00Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1XmbTtk; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1XmbTtk"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c6df0b9bbso4957395c88.1
        for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 10:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777050675; cv=none;
        d=google.com; s=arc-20240605;
        b=NffjOeZixR78PF09xDzm3WJhFhfbujwGdUljjSIuajn1/sTHXomZ4NXnyzKDrn47TU
         YkWbm0eAZOLW2lq55fENwTyzstZfks7WhHzY/ycwF5r0A5/xCUR1AYn1drDCAAvLE/cY
         N5RsrVskvXvDKR0PJTZTiYfHtQgODyvRwwP9f2LEdfU/rZ/A3Cg9KzfnCX4ni8EMgad+
         hGRh+Y2Tgwo6GL8w1++1p2e70NCgKWPFizGqX48gSaFeQ01/sRtlFu0k3tbaoHzyhKPP
         r80qWHiD2b9u3fOZbPjeVwNzvJsAV0UulLD+hkeajX8HYzDSjuqokQFM+qx1TYTOcoIY
         +oRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EyaUdfakUh81Tvsf+/PxjP1Vifs5onlW0ghq3T6Niak=;
        fh=Mn+KGZjD/yS1iOlvedZktro5epQosSjSuA/zMP4ZSKM=;
        b=UYIG59ox5r198QjfeDuSv+RIOBB54+d3CoZ+ie9PJBN4lYjvSLD1vCuEa6KAKocgnz
         rYP+MINZUp4Ka6NlHaUy2WPr95b4Q44vahFoPkB3D/rDC4THcvvAcxkIGiIDHOtyYa3S
         ayh9ehqe/VY1h6odPXLJqxraas1dHmrD4nl6I3/cV3dWUguhGYepdosuNl+IcTzzQ8ry
         AVo/qHMVdJ576gPmL03LVQ0j5FJqUrV0WM3j7qfG+3ZBHIpMTMDF1pf4oqves1Ku7rhm
         JJzpTv6r68tDvmjHMJGHpzhvuq4QkW1TIWzeTpLKpo5s7KwrJHLVPuzoGkJ1kafcjLxm
         7pdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050675; x=1777655475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyaUdfakUh81Tvsf+/PxjP1Vifs5onlW0ghq3T6Niak=;
        b=p1XmbTtkuuUE0epi1TTI1sUNFTg1+splKa5HjN+/JnXHxNCZgRvk1kkrnnKm2LVwjV
         LWiZikZsf9euXA9ANo8LE4geIlp913b3HqpxtArN7DisgR24NGCYr3w5d2DxA0+zVeaA
         GnsrsFvVVOFjKZ63osgH7HWK/s1imGqCMizuH2kOzMgHCdJr4olFNFgMEg8Un21s/4cd
         AqIuRJ5Fu2bHnko1hBz8xLk3tLvmxCJMtX1Z7HWgZuDZ/mgEU/ubmECYAasGTLW91Sok
         KsZkBySyIEHCzMhLc9iwtD18ojqfu6nFgYj2hCUW+fwzESnYnT2fFLJ7dZzr4LjGNHy1
         PWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050675; x=1777655475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EyaUdfakUh81Tvsf+/PxjP1Vifs5onlW0ghq3T6Niak=;
        b=VEPnwmuhie6PMIGAUBj/XriduYlUgE6BvO59Gu5G4oDC7nbw7yhyL3U1vu2owcYtiy
         Nh4DXRoVf3ugOWwE+Hv9jrsm4Gnpomp6jb/47E7bS0T0Vqm5xdGV5QwKL/AUdiKqflYE
         axBnUgTZiLCF2J6gvQamzRiWC6Sk/GFoLbAjsn34eBmOUMaVeJN10m8IwfEv+FFqe1U4
         saPXk/kMehYn8lXWSGQ1y7z1sPVqV6SglgGCLDzd4sYMADnGLmi2+kCFNS10uSxgmfNK
         ue7fJug89MFv0tUY09z5oX5I4BBElo8dQvpZbAOY4dVmAP+kcf3VLLvmM9DUsk++pma5
         kEtw==
X-Forwarded-Encrypted: i=1; AFNElJ9o+0FDRFvthgAvsiZ8BCbxXmDJnBF7iVHBw2WsvNDJivCxH4cUOiA8/3dwkwsrHFGyNXdWm0by9AS5@vger.kernel.org
X-Gm-Message-State: AOJu0YxjvbTxRm/xvgNndRMLJ1DGP+l/Zv/tRP9Z5fPslCv8TG254GKX
	reek4lBRT2VtFFuPnkZAKXaYcGL0QBpr35YqsIL41/fhsZCAPjon86dKclri39hkEl9tV6BumW0
	uvl4tUl7BBkkn0FUF8GcINoqwtNThdps=
X-Gm-Gg: AeBDietXL6sA1NBexDqtGD8PkT13ob1rWltFLqDb682JlyZR1sMCA9LTXr+tBfEFmtx
	cET2CJBh3L0vv4lAyZEysVVr6rrA4Bv+6k4+m5K+/QzC/hmEYlcCrE5Au3RNSOikgkDaMg2OT1L
	VF+jZX5L36CDI94gXpDAFpO8KMtHII9dYcfsFxXvm3q6yCZi3/w0Kptp81IJfcPsKhvQZkxboJW
	4gNY+BOVhgWCRaovr/IvbsWxgDhPLRs1ME6AGVfNuDlzgRGjNUHPgt6K7y1X5I930MCNAM7U7KW
	aRCentfRyA+ZYMNtIf8a8VwdOz9H
X-Received: by 2002:a05:7022:388f:b0:128:d5f1:d594 with SMTP id
 a92af1059eb24-12c73f72832mr19947560c88.10.1777050674631; Fri, 24 Apr 2026
 10:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424133737.921463-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260424133737.921463-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 24 Apr 2026 19:11:02 +0200
X-Gm-Features: AQROBzCycSJPctCW6Jqwzn7V00kenYmWp7lGl_Qe4zSK7afPBsXL1EQwWmOC9As
Message-ID: <CAOi1vP9UyAxfWz4jsw5t3Ui2JXx-xgVXVhQ96FP31q=33zmTyQ@mail.gmail.com>
Subject: Re: [PATCH] libceph: Fix unnecessarily high ceph_decode_need() for
 uniform bucket
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 3:38=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> In crush_decode_uniform_bucket(), the item_weight field of the bucket
> is set. This is a single field of type u32 since the uniform bucket uses
> the same weight for all items. The value in ceph_decode_need() is set to
> (1+b->h.size) * sizeof(u32), which is higher than actually needed.
>
> This patch removes the call to ceph_decode_need() with the unnecessarily
> high value and switches the subsequent operation from ceph_decode_32()
> to ceph_decode_32_safe(), which already includes the correct bounds
> check.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/osdmap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index a87268058e61..669348d883f0 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -72,8 +72,7 @@ static int crush_decode_uniform_bucket(void **p, void *=
end,
>                                        struct crush_bucket_uniform *b)
>  {
>         dout("crush_decode_uniform_bucket %p to %p\n", *p, end);
> -       ceph_decode_need(p, end, (1+b->h.size) * sizeof(u32), bad);
> -       b->item_weight =3D ceph_decode_32(p);
> +       ceph_decode_32_safe(p, end, b->item_weight, bad);
>         return 0;
>  bad:
>         return -EINVAL;
> --
> 2.47.3
>

Applied.

Thanks,

                Ilya
