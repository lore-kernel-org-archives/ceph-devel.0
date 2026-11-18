Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795031377;
	b=GIkGdwnRfgDfbRAIP1yHT9W1CYadRqYTgZ9D5e9K29xfqU6dduOmsFtNMDiRxoGfAhnk
	 y34OraXHZe+wWX990/+d6JglEzOKBTjf6iN2sH4B5MJKPheFLHkpPrJONjGc4GfqmFJRz
	 /iK/ZVtuTYsLED3eFMhXb6UNfsd/MfU2ACtKNkMgo6pyrhMdwv9wO6l/l7+zIUcNa+joA
	 z1WNt2Og6QBB6uncnLBTla++IbDi1gt3Ti9jEj3xx8n6xBtQUXJt3OpItmFPfI9OU0ABj
	 VRle3Cp1XS71NhP4fzQNYHC+v+fYhEC7VbmM9YIAdBT8M9gMlaUfvIj6p7VKO39OpyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2WCYrClAAXGUjEFihZ+Kr3E6PgTTrxBW9jJcNZumwzs=;
	b=QZ2u9Zc4e3W22CcioP4ULfso2ToxocbyAoXvCnab6k+cV6J/CyvXi6ggoZyqDmFbv9Km
	 3M0z4x0muWsZYpTEif62nfg1VFcSEO4T3xdto8uegZT7lfNix0nZAB6uVv+dCZnn2ysJv
	 0HxJh0I5zNobhSauHmyneSABgmS2SoLWfdxxzjUTNK7/nEHfiViHNg//bNiXxXlSQK1K1
	 jJM1lbciwT+Y7Ir9e7IGmUISifGOg5e82Nj4ohUrAbXM74O1mvTV5RD/kYnUhQ9S6a/gm
	 mdS/Hdz4NxLJsV8qER+AAVlgqu2VQ3S071aX5SfokGQg+XqaJItETJzHRxAVdeb/EuQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbDnePoq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E6606A33D
	for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2026 19:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 362E6606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbDnePoq
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eae1276409so571085e0c.3
        for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2026 11:49:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795031376; cv=none;
        d=google.com; s=arc-20260327;
        b=r5XyCv31K4En7/EDBVsHwLCWetFpK/fe7UVoqesWjO0NC/tJkxaICL6T4PUbXsnVOh
         VFYaqUEbPlFdzrsV2jSYAI5TyryxeUMqLKLB17QGA/DdUcg9pCrQOtRSH+t6EkrzymP8
         2XjapNut3PErmweF/urIG61abuoj6cJ/8iUo8s9tSFntegAn02JUONFkSiOhvhwK2RGN
         jUJqx+QM8Lr9quPJTc1yMaRvQZK5fG13uiHpKEByz8TsH8FwxzFTcK8gLwYqf+4J3o8w
         KZuMTV8YjU6TY/g0T/8q6v4Yb6yRIcanipNQDPDp2rO+Su0JrNLovIYNYEr7fg7fGtAG
         okcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2WCYrClAAXGUjEFihZ+Kr3E6PgTTrxBW9jJcNZumwzs=;
        fh=DrzSW30hMO1JkMZHm+aMuB8dIuJZzhEoMM0ygnBksYk=;
        b=KXMSKCC6wnYI0Pzp7nReWYwVtNxZiddDhJdAesWUyvfx3koLA41LNXQQVCUgk2k/i8
         onn7/IqM6nmS6Fj/Qfy+zkyrDmOKBjvWWWEKuxJbHcB9LM0hnRZZN2rp+11WKDolNTgO
         XBzzVTjRrfzVXaH7z+2HYFIrvS80ggXfh7R06pQF20unLkSsZsq1d4lfMi0cKlcqvn0P
         PyTR/5r60LWGtXxTM9/r1vKylcKt85ZqskZSCNB3N+RWpCVVRNVu46gLJXWFIW5F6zGg
         R/wOd6zj0ZqAlcruxkOwh1keHdP3prWnUBcu3apMl6IW7HP2jDE4vxGeAkBgfzQBh8ZO
         EX9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031376; x=1795636176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2WCYrClAAXGUjEFihZ+Kr3E6PgTTrxBW9jJcNZumwzs=;
        b=XbDnePoq6DsByY3QSv8Yqd2N9+SZCm8SypoJX5QTgiR/wvTBm5x77uN/IQHuPqxsV1
         Tq3OdsaRncEDawaGopXT9MkConSZzJ7OTqmZno1fJLy2L1KFQ+czOqyy18eBvEWQDbK4
         q0Esz2XAfkSmB+wIGHhNBxr6Qk44tMfbiEbmO222Y19ZUiCRgH4fEsuTUWcGppBC0RPw
         l1xggxKFWgZ4mR8q7QVh+m+4cWKXj73rxPSOuysgwfwweXkhcg3/I5KgYo3Kot1ruaQr
         8Q7B0fLtz3y9ujiOIMA+QObcnkJcnuTzJlF4zLfSIBSElxpBRIyic/XxyKVARPpJ7Lb6
         5kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031376; x=1795636176;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WCYrClAAXGUjEFihZ+Kr3E6PgTTrxBW9jJcNZumwzs=;
        b=FjAw3mv3jL5myfMRuAwp1uq/TDqSxh2HP0100MuINDqzYSodbTiqGNWxbbgKrTVi0A
         M4UdHfz8ZTrsdRV6nEbPKx5RTSkg2nf2hxxaH7J+G40C+lVvp4NmM0ZGUc7Uq8lsrH09
         UIBleuf505VSAaUH/FCEktFgxIyowBFbuzoaJ/FW45MML6wh9Jz3nPm91mmiL6qhYIhM
         OCy7wbNWU5NBTLyj37jnj87wXZxWE5iXRzh4fwrk2f67JaUEbjEPJ4gn9a0aW5sXZ6ru
         B1NnpuoFjkzy3vRUGdHlM8zIgrUSKjvbsddNZ6842aAzVSLcAhyuLMQm1KksrJjFdrhN
         bxJQ==
X-Forwarded-Encrypted: i=1; AL+hErGwKKn24DB6BgZirlLHYAZ9U6gdRxbFskyQ6pTHZ62PWsKXqzmnAzk0B6K9TC5w5SEtzeDU3LHMeVuO@vger.kernel.org
X-Gm-Message-State: APuU4Z+SQ5OKxTnRNuDM7X60tXxax/LXE06XmzdCEUYrjR267qvj/H9v
	RF4MjibaCcIJnleKDTyvqPvqXQgInbKmdQfZJ4TqBQOeX12riKvWdPEMxqKa6PSWKpHdPprWddf
	TIsVCQTuIHTayjplyenPuvYf7bJ+3vyDS94e5A+c=
X-Gm-Gg: AYBFou0+6GJvf2wrQAwnZvd+koiISCyptv7nhy70QcZfDCd7Jb2BrcCxyImp5IAdcqK
	fPgDiW8XO1Fw3pQu3+g2Hn5GtFxn1ulo0BqV/nqN7A0vMFW5abz1o4SdbqZB5V55Nqij1vcINE2
	aj/tQnD9u0QuFaav+5QSd+nnk+8NU7f/6BX9HmeEiH70CX/GCCrDyjfEt09F+3cQU4hUvUcGFpJ
	hobShwpph3TQru/hdkLuXmdc1khEMbqdDglng0WzO/qlfa0Jl2TAU698JUcCdJNgZiNIzVFHIur
	5ZU8gEz9iKZXnnTY60zzsMpttqHIFGH32JbFZ5xRxNxAMX5HhUSUOMTyizQTuugBvsSUd42kwKB
	9KVYPWQ1pi346Hh1wF4MN4e8rYFK39SOAp6Lz1OV8UNCQd/rGrcMc1dH3QOkj1ugtSZkr25E=
X-Received: by 2002:a05:6122:2904:b0:5ea:c6c1:8dd4 with SMTP id
 71dfb90a1353d-5ee646c5cf3mr1948277e0c.5.1795031376028; Wed, 18 Nov 2026
 11:49:36 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <PR1P264MB1805408F7C4A11E6F4D2F6BE887B2@PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <PR1P264MB1805408F7C4A11E6F4D2F6BE887B2@PR1P264MB1805.FRAP264.PROD.OUTLOOK.COM>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 18 Nov 2026 20:49:23 +0100
X-Gm-Features: Aa3M54prgxEXH0QcaUK7iYZlymmO2L-4ErNwF_OHban9EuEDft3ZnhOlXfVpab8
Message-ID: <CAOi1vP9P71i62s+Lm8zRF+FK-qgaQaZu4YB34--oC5mPLpmj0g@mail.gmail.com>
Subject: Re: Request: backport libceph CEPH_CRYPTO_AES256KRB5 support to 6.18.y
To: =?UTF-8?Q?DESNO=C3=8BS_Jordan?= <jordan.desnoes@francetv.fr>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 2:07=E2=80=AFPM DESNO=C3=8BS Jordan
<jordan.desnoes@francetv.fr> wrote:
>
> Hi,
>
> I'd like to ask whether the following libceph series, merged in v7.0,
> could be considered for 6.18.y:
>
>   0ee8bccf7396 ("libceph: generalize ceph_x_encrypt_offset() and ceph_x_e=
ncrypt_buflen()")
>   6cec0b61aacc ("libceph: introduce ceph_crypto_key_prepare()")
>   b7cc142dbafe ("libceph: add support for CEPH_CRYPTO_AES256KRB5")
>   8356b4b1103b ("libceph: adapt ceph_x_challenge_blob hashing and msgr1 m=
essage signing")
>
> I'm aware this is a new feature rather than a fix. The reason for asking:
> a Ceph cluster can be configured to only accept aes256k cephx keys, and
> the 6.18 in-kernel client (rbd, CephFS) cannot authenticate against it
> at all. As 6.18 is an LTS kernel, users of such clusters are left with
> a userspace client or a downstream backport (Talos Linux carries one [1],
> and one is proposed for Flatcar Container Linux [2]).
>
> All newer stable trees already have the series. It does not cherry-pick
> cleanly onto 6.18.64: 6.18.y already has 821365487aa5 ("libceph: Fix
> potential out-of-bounds access in __ceph_x_decrypt()"), which landed in
> mainline after this series, so patches 1 and 3 conflict in
> __ceph_x_decrypt(). The resolution is trivial and gives the same code as
> mainline. The CRYPTO_KRB5 dependency is already in 6.18.
>
> I tested it on 6.18.58 against a Ceph 20.2.4 cluster restricted to
> aes256k: rbd and CephFS via ceph-csi, map/unmap, reboot, and 24h of
> I/O across ticket renewals.
>
> Ilya, would you be fine with this going to 6.18.y? If so, I'll send the
> backported series.

Hi Jordan,

It's fine with me -- like you saw, a backport to any kernel that has
CRYPTO_KRB5 dependency is going to be trivial.

Thanks,

                Ilya
