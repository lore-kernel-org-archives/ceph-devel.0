Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2016722D7B9
	for <ceph-devel@vger.kernel.org>; Thu,  2 Jul 2026 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010567; cv=pass; b=qCwlMJ6CLRc18mmxAHDAb912IqbuNDZjpLBqjwHLf9fIhdYMQDX1RhnQobjP6inG4Z6RmAsK1XX7XfMrTqw1WgTErF4xrEWALxBYtYweF2lvMjmQTRBDGmTvJbwoIvn12DHrjZGxlzJWi5tts5CkkmCTdImVwZiAxY1w1/Jie8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010567; c=relaxed/simple;
	bh=BnnQsVRyb9a/z+tcznI+YiaGwNuPrAO927IOqxFE4UY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TudjJpQBO3tZsek/l1hYYdRlFQ+Beuzez7xuce5xTvG/ztjpMMcF8x7JDB0Ef/8P7GbISFgk0LD9P9hloiPJAm+ogNRHcFhvjZZTHpOzVZ4FNAboz0GHlbIgYC6pmJUdIlGqBxza4ECKCY+59UAbmlMxmXDXkeRwyXw8bkkT9hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hK/jKEzl; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hK/jKEzl"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37f816d01e3so2099819a91.2
        for <ceph-devel@vger.kernel.org>; Thu, 02 Jul 2026 09:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783010565; cv=none;
        d=google.com; s=arc-20260327;
        b=kNmU8M9lHlqy7P5v1uy26YSUuSkvqhfMtVAlG2vF2lcTWDrOu/ZhGYm71r/GoenFBp
         WotJsEs4rrH42nCVfqOaM5e0pPEBzbr66HyZldhpvRturtE5qR4QyDTjy0CsDc5G2nL4
         BoU68HCUO2FVHs6MDwqvcuSi5srMeiPiaERcaMYTmbk1sjCRajGGFjmXG6VDPAI1VxPK
         kHYsWp+/C1WjeUn6+lGDkvsVjzfdbCkv4T9easLGAvnqGO7imuT3+DeJXoW8yU2NOxJY
         Z/RnupaBCaqWY6A89fdzRNkf6d2X0NGUSw2erR4QzQ+czzwaXep3H0CqhN94MB8XLIEM
         T+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gbfwU0Q5cIU3e/SRXEIGYQ5zgpPZx2iu0R7Dp7JqWTI=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=X0/7+zNcJNS3QT/hbCjVf7K6LJsCDNmaqMZqLzh8Ps4kkhTI2YONuhAtcZfJyemFxx
         p5LagMCN6ZJwMvJ9fatpPzdqdXv9xD06lShEJuycY5JjMny2KKRG/OuEnM66/fj2h6nU
         bUNwmJke5MTbFuWp2/eBe3GTbvJgpmgKHRZzfZNCiX1o0oXqxpIvIx+x20xujjK7rzAd
         TEGNs5dGednZuF+BwE9C8zsEv5jYTBecmF4Lk3TvQ8qsQeHD48tt4NYihEtS7L54FdbG
         XonfKLcUq5DTmqeLNr/AN642/8wPQYzdKrgUTQHTLZfPW95qDVllXL9z8s2zt5ZLwe6J
         5BKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010565; x=1783615365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbfwU0Q5cIU3e/SRXEIGYQ5zgpPZx2iu0R7Dp7JqWTI=;
        b=hK/jKEzluSBVbenzwmfy/sYxL3YvE0XSBgQ6vNzIy83M7bZ8m0m8QBhLCBE/monJ8w
         QJtCgixuOzryKcpWeqWYQp8UBsCo7N2nH3Ri7BiVzQQp6guU3lTDG2g+YMU8YZU8kcTZ
         SNq09Ty5vqYHo/ZDefJktZFVqMaLjd9pH6NECNw6ypW/JqznSbkbN5Km+liBpFl++bKT
         tvb1yw5ev45zF7cCSCcyzPLVs4NXJC0IcpRB012wECLmoT8cWaA0/7eiHrDJEeUv9FPK
         EFvKn5/OybEIbUGEemDFqm80dJBPd7Ua+7SQoVRRt3+/z06sIDkq3p9+fo/DCnfmk60D
         NXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010565; x=1783615365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gbfwU0Q5cIU3e/SRXEIGYQ5zgpPZx2iu0R7Dp7JqWTI=;
        b=aIIN6JNMNZvJCgJ/fVrD/ZtclUXKolbbVDHuFgdcjdVQZEonGyFrjOsMvysvxEtfAV
         OZpWbzfm4+Z+MIX85veFpMUajxFVx8gpsL0vyGkZa5w38loEqOYCjejoQmWKXMWAM2sh
         6vJCkOw7cGNYjczBnKlWu/xi+WF4qexu5ohbwZGDkX9dH7EqdRbbXWw0CvP1J6iRG5pl
         ASB7mKKk2Qwf6zYtkEz0hTcjcK/nPjMJwfVnUR3j3s0LInk31fgzq7ox/IeR/WcOfvUA
         iP6KSdFmIVasRKv6Yyupct0nmcLXZrNFk4kQybXj8oBosGky9jqFRhmynKWbMAje/feA
         eFCw==
X-Gm-Message-State: AOJu0Yy12cg669ldd9QvIFSA0Y+StO7G62yi0Eh0NRlsTBnSpL1xAWtd
	4ri9OQ6J7AYtsw85ZcljiCrIU6wqQdXwqQTmvZGAvi3c+in/GlK1ztTzH78ZvwQVgwPzMszMoMc
	8CdFerwAqhnsX+ddyP9T2XeY4e8AXYU9Dz9nWp/E=
X-Gm-Gg: AfdE7cmqR8oP1oWyysT/eQ10fKc6cIYhITkf5WT/QebV2+cybmdyy9wn2ennzhKm4GB
	4eJM7aUAfa2+KgTAw9LRnHGfFApsqlMpS4TWS4kHWDkeR3l8fX25PME0/TlP25Pq32a3ringYaO
	eigFFz1nqBU0/ErbFHRL6rO/1XExooh6lqiDxg8YrGaB+50QiLNVFL3PJxe5Ej4OOX6WRyJuP0N
	+mTEXxQ1+Yod1DvIp2fuJvQ1XgE/rhxyKTyDYfqewzm/SzleE7KGK3jprUwP8mSulgEZlokfuBl
	ZJEqUoMfSs/kC3Gae/VljrBzkeb841gOqjTKUIQ=
X-Received: by 2002:a17:90b:562c:b0:37f:9ce3:ca97 with SMTP id
 98e67ed59e1d1-380aa20e0cemr6623073a91.32.1783010565390; Thu, 02 Jul 2026
 09:42:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415034020.11530-1-CFSworks@gmail.com> <20260702114034.917507-5-amarkuze@redhat.com>
In-Reply-To: <20260702114034.917507-5-amarkuze@redhat.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 2 Jul 2026 09:42:33 -0700
X-Gm-Features: AVVi8CfK_ie6lH4BYMKiKkBuOWpj2tg4EeVJkvQlcUjLyblfdrKAgt6Z-FVxf08
Message-ID: <CAH5Ym4j6GUT2L7tFy63BzsqXV-okfW5GyVYBS+MOxMJsEP49+w@mail.gmail.com>
Subject: Re: [RFC/BUG] Use a bounce buffer for mds client decryption
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 4:40=E2=80=AFAM Alex Markuze <amarkuze@redhat.com> w=
rote:
>
> Hi Sam,
>
> NACK for now. Thanks for the patch, but I have some concerns
> that need a v2:

Hi Alex,

This RFC was only to get feedback on my (ultimately improper) approach
of fixing the issue inside parse_reply_info_readdir(), not intended to
be a kernel-worthy patch.

I see you've already found/reviewed the superseding v2 [1], so I
suspect you later stumbled on this one while working on the backlog in
Patchwork and didn't notice that it can be closed. :)

Cheers,
Sam

[1] https://lore.kernel.org/ceph-devel/20260530030646.85589-1-CFSworks@gmai=
l.com/T/

>
>   1. [major] fs/ceph/mds_client.c:578: BUG_ON on wire-controlled length p=
anics the client
>   2. [major] fs/ceph/mds_client.c:580: Patch may not build against curren=
t tree
>   3. [major] fs/ceph/inode.c: Trace/LOOKUPNAME path has the same vmalloc/=
fscrypt bug
>   4. [minor] fs/ceph/mds_client.c:497: Assignment-in-if and missing brace=
s
>   5. [nit] fs/ceph/mds_client.c:494: Typo: fscript_str =E2=86=92 fscrypt_=
str
>   6. [nit] fs/ceph/mds_client.c:574: Missing unlikely() on inner-loop bou=
nce check
>
>
> --
> Alex Markuze
>
