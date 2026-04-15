Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82A384242
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280515; cv=pass; b=YDso2lsy09gGktzjeMVT9FSX18aIF7yLJ3KSTnWMqUKL47NLj1WnzQ82Vcwiz2sEC5nhdlXPMuc2pmP2Za8slAKNS052deWes7J9S6kQJCOz/AYaueeGhhlyBtqDk7T/0rddDIDPY4h7vT3v1CJfAJYdet6O1nJwWA1xkfhiGCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280515; c=relaxed/simple;
	bh=fJopFsVo9vfewrG+OmnMAv7VbJo08Lr7FiPlXMy+GsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OI0EwZwUEDQ7ygvGwZ8fd/7BFaiwBK9Lif0WlbbzKxo/drHO3xNrE3YdP/AC5CZJUZBZABlKHaGiFZFmE4lXFDeeU3tNVpSyYTEtTqqG6SREUN8jLDuprmcIU8UythXTGlDAcFUkYRMKG3mtE6X3g3rBEXiayeYwL8Qebm6UccA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSAA5HXv; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSAA5HXv"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d7605ec91so3373450f8f.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 12:15:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776280512; cv=none;
        d=google.com; s=arc-20240605;
        b=LgzXPGgoxweCzWPvNihG4rqv2SKqw2IrQ6eHYhF9e5oO1+InnKd0/oK0wUXhWw4j6i
         I2oTc5AbxwArQ+5uS5onZkruAUoPzdBQ80hwlb+M+M2oOuX1tql6czPJ+zn4+OoXPw8b
         z9fTUbOwKouh+Mc6TCUzHIInu5qUceZBUYv9fiHLBjnGTkq22xHj0df5yS/+mnj1267u
         eAbSGrfJXa+xo8SF82zIPb8jtY2LhFBeI3q8jQCM8kuIEO+RLW7KszySD2fy0gJqoKHC
         AqslFcLzExuETxL7rpamBrHf0UZw7fzENGrhg0U7pP6ouHv4b+Ma6JppHy2u4oX9T7fF
         oY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KeKsh3k9QfEfy4yC/je1RberIJCck1pqYeGQa4k21l8=;
        fh=gYNrYhcGW5xgqxIqqmoSWIoIEeWbawSGZkU0MsEReqM=;
        b=FxbJGzSZwSMnDfUhwFITXpTj5Cacn8E6Y/Q0QZTtItIskoL4hAp+MLoLuSaM9OuFTo
         CFw5HMPUJdxCb1MqtD1XSNCKOyx//nlQssDgm32gMKn6OQ76/gR7+7hKrVYxWwnCYdpM
         UL83hM9eMeXJEr6vAJ91de7vvyTJgIjnqhPtQvG+smfk+Vl36vK2ek2E6LKPClrlKAyU
         h3E0fbyKWJrsWXWPLuB+ef+m9jstU8FW/WKF+FusDhXSByb5jfT3zjpsAbogLWEnct8F
         FyANH87OFKFFH4oyx66r/HrLSpTsvB2cBFaewNE7a9Ep5fBzVSV9thC2KSTt0efLc6Xc
         ywkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776280512; x=1776885312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeKsh3k9QfEfy4yC/je1RberIJCck1pqYeGQa4k21l8=;
        b=XSAA5HXvl1B6MSzLGsIOmg+H7t/VaN3n5N4m+dPQr6hPYa10GBmcjfwFfONHmcexU8
         7iVNF/uQo/aUPndelEkRKxgOUt0blJ0wvd69Z2Nn0p/q/yEvBbmbM12EFMeguiGEETeu
         z0+6ZVWEgKSHVHmb83ABy5VE22uz63ksRyu54Sn239WvSW/2xUzNkn6+tdW6ZASz8S0/
         +18R4JUV/Mk/8yyiYdOAWojeSHVW08fHvUMcmv2Y4DBQKj81DuyGq+9i4FGG6YaD+qfu
         0vyZKPkfmb4XciKQl1cJQ5OVQI+UlXnHBezHEjzs7rUETQLSPTOBHSUdm6YYq47JtZ0O
         6gTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776280512; x=1776885312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KeKsh3k9QfEfy4yC/je1RberIJCck1pqYeGQa4k21l8=;
        b=dC+/Yd3PQ1BFV6KIHwswoqcojZ52RVFiG9ajrpPsD70nSs1cQJLQOu4mv+HNPmTkHw
         iGVfVQfX11EfAXnM4gVMi+5JMrLo3ETp7I7yuISTUv5/jAsXKMyTgO3LsQJoRO5J+Ud6
         vXocR1zgj85hxIJ8/GYCJW+zomRU6e48vDd7P5bnAjSmCxNX96pMWDb+NT0xtKucMVg2
         vgq1i4dYx47fo7nFxbEyJZvd+bZ4ReKbR5aJFWAMTlpPzKoZrIxso8lM75jZMevh5N2m
         n8txubhlPRW/HWeavrklnGouMCuT/E2HPvyoNF9j3qGrcJR2khTE1fe9BFD1WyFytdEp
         AQlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FvazGdmeQfSQSaTKbwUo0HjfbHD/JfVMarHHdkiLysib41Q3Vnz5fytLu37ey3OtfN1hYRID8rT2U@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6T/YZBctQP0u7wnyfpQWOAyCI0Uk3kjZGfdrxRQU8Y6nElVsG
	vTn2t7+asVMXFCbAjh6rvvG4QVlcaIUkt4ELV3Grt8aADGCK2GuJKCXlK3QcOTqvxJWM5F/NQYq
	Rxn1HdxfmC2GcCTvmKC7sTGufRT2wtOI=
X-Gm-Gg: AeBDieuHkOP/G0ylfL5atH5jU2RGoTvoFoRl5Yvg7oYH5fvtpuSSq8aYc5ww9c90VTW
	dXoImDH9JngMlaBOhJiPgSULW5ZqbyjDVl7pEnYkR28seWKD1dVyhnfGtl244XlvjfafTU4ALoC
	PXoBSTYslZXY8aO9tXttRLFg6HtrOl933jPV9JEbQNvwUEhw7T3Z60S4TV61UtUloGdQHzDR5mF
	+9b4scsAj1LvfR18nqrD7ginx33bIPz9K7snrtzyZvEWpmYDjCOYRrM6k9w/5Dzi54mHYEf+62z
	uQI2Ab01NDqUjoqpDKc3Ku9zAJGuwOBmDS0YQwZhJEycXtt4f3o=
X-Received: by 2002:a5d:5d85:0:b0:43d:73de:abd2 with SMTP id
 ffacd0b85a97d-43d73dead51mr22571783f8f.26.1776280512071; Wed, 15 Apr 2026
 12:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415034020.11530-1-CFSworks@gmail.com> <CAO8a2SjHobzPFQYe2YSx119pcepKm_ECUkYQ6=t_i_ZcCbRu1g@mail.gmail.com>
In-Reply-To: <CAO8a2SjHobzPFQYe2YSx119pcepKm_ECUkYQ6=t_i_ZcCbRu1g@mail.gmail.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 15 Apr 2026 12:15:00 -0700
X-Gm-Features: AQROBzDFoVbUFUM6zzar4HH6q256xj6PX37U-Y2tDFTF6eja0sUyL-h0GBxER5w
Message-ID: <CAH5Ym4i3Zr_XCPMHhDWo9WEEJQ=1a3K5UiyQy8ci9WcKAaTK5Q@mail.gmail.com>
Subject: Re: [RFC/BUG] Use a bounce buffer for mds client decryption
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 10:16=E2=80=AFAM Alex Markuze <amarkuze@redhat.com>=
 wrote:
>
> Hi Sam,
>
> Nice find. The diagnosis is correct and I like the bounce buffer approach=
.
>
> A few things for v2:
>
> 1. Typo in the comment: "fscript_str" should be "fscrypt_str".
>
> 2. The assignment-in-if is nice but limits readability:
>
> ```c
> if ((err =3D ceph_fname_alloc_buffer(inode, &bname)))
> ```
>
> Split it:
>
> ```c
> err =3D ceph_fname_alloc_buffer(inode, &bname);
> if (err)
>         goto out_bad;
> ```
>
> 3. The `BUG_ON(oname.len > bname.len)` should be a `WARN_ON_ONCE` with
> an error return instead. New `BUG_ON`s in data-dependent paths are
> unlikely to pass review.
>
> 4. The copy-back block is correct but not obvious at a glance. A short
> comment explaining why you need to copy back out of the bounce buffer
> (rde->name must point into the long-lived front buffer) would help.

Hi Alex,

ACK to all of the above. Which return code is best for the
WARN_ON_ONCE violation?

> 5. `parse_reply_info_trace()` has the same latent bug. It stores
> `info->dname` and `info->altname` as raw pointers into the front
> buffer. When the LOOKUPNAME path in `ceph_fill_inode()` later passes
> `fname.ctext =3D rinfo->altname` to `ceph_fname_to_usr()`, that pointer
> hits `sg_init_one()` in `fname_decrypt()` as the source scatterlist.
> The output buffer is separately allocated so it's fine, but the input is =
not.

I'm happy to bundle a fix for this other problem, but I'd need a way
to observe+validate it. Do you have a reproducer, bug report, or at
least a call trace for this?

The callers of ceph_fill_inode() that I can see are
ceph_finish_async_create(), ceph_fill_trace(), and
ceph_readdir_prepopulate(), none of which are (callees of)
parse_reply_info_trace(). Is the culprit handle_reply() calling
parse_reply_info_trace(), then ceph_fill_trace() while passing the bad
buffer inside `req`? If so, is handle_reply() responsible for the
bounce buffer's lifetime, or should it be handled by
ceph_fill_trace()?

> 6. Also, let's add an `unlikely` on the is_vmalloc_addr

Did you mean `if (bname.name)`?

Thank you greatly,
Sam
