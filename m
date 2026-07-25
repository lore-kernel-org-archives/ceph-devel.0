Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C72571D7
	for <ceph-devel@vger.kernel.org>; Sat, 25 Jul 2026 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784971686; cv=pass; b=G8I/1e3yyzhZUtOD2gjktDLvlTEht78hqWprXUqCJqa0dYjFMlec862DDeYUHmcdEq+xQ2/amCTGS/c7qxTKNokBRC8jpOEwe/R0BOyfDzJc/+7IG4fkgt3dM+EuKMe8pGvwk5Z6tWlo6elwiDqi66Z4ySMDLIynQoCTAYLR0fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784971686; c=relaxed/simple;
	bh=kVdCELYJP1msR+VP15BvQsE4a1FCQkY9RBBlSKLePzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERRGS+9+Wb7VhezgrLsBgaGLC+//K0wwsiYI04P+yMjDOmSdeoezw7Gdjn30wfMUvg34UehnD4fb4O9Is8K3uEXtO5FvluHfMwpmCWB3qFuh2DC0gv0BK1ktSoh+LSbSw5/Bulz0hpou9im77XEx4+LjR8HO1YumIY2Rodsq4WE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALKEaofn; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALKEaofn"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-746d77537f8so628840137.0
        for <ceph-devel@vger.kernel.org>; Sat, 25 Jul 2026 02:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784971684; cv=none;
        d=google.com; s=arc-20260327;
        b=L3mwrJT2xr4aBupsebw4rzEnI1u2aZMZrSfiytc7ZENSOycNybMWbq2RWfVzsJ663b
         hUG2c5axYdB50hYZkGrAfNlzBj2vyzMD5K1y7BuTJDzxrb6frA3RZKzYU9ScP6Pqt5/G
         rBtpUT7YidNAYRcK0mmR6xgOBLsPlJl4GEy593sMcGiLs0gQQDVKEGgJdK+1pc4Qn+SP
         1iIvId6Ox8PuA1H8UWLBQgtucsEWzdlhQjcyukfkPi4aoK/Uo0TF96DcmVzoJEn9cJ/m
         Nwld5bHu1YIuZ9Gdr1gY0t2BckND52vuspGTMFYbUoHBs1EmN3CK0UTyQS4t6JK8+QAd
         oEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aM9s/dD1ClDjMhFdGbWeCMicnGNYIJbtkNG9Jl0ztho=;
        fh=isLb0e0dLTLXjrtW3hrJKOWkyDb1LP1fwtFS4a4gfsk=;
        b=hmuKRhJ0kTCzCYdWPKK2OhlVi+4rMDmMX0Svvqm4pj4nydU4j4ZKmcLiSofITd1Bty
         S5nOdhcanV32qyDOWb0mKOkY93q8QgESId0sdgRcpQg9EeGANvkIP2jMZuv1bGraSxWR
         ePyGardra9bVFwFYEw90faCvKXNehKrngYrCkoNW5nwkHh8P+Pzxs1POSamkjd5zyee1
         hf4dZPYvAiHSG2+aniYqqVLAOd0FAxubKXqXIg9Wlnn2mPpMz0ldiTqbd3TIjoPE5CP+
         ySNO7dVme7fmttVezY5DUm84PRKIF14HcNKDlCvqRlvS9j5aVlmnh3BXwqFxdKXDd9OJ
         3qhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784971684; x=1785576484; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aM9s/dD1ClDjMhFdGbWeCMicnGNYIJbtkNG9Jl0ztho=;
        b=ALKEaofnSLTraOQVWTI9rnOISnZa4rKGz1drVZZvClx0HlOxo/CZvrNa5E2TKl5XC9
         R5hbC09j/KFGaKMaXSHQwQaZflO8r3YULCp94n1eanxdFpxzV7IBj/fD+LqjOxIxl+XP
         lV92Bb1O77i0raSL3yTz3YIX0HWww8FwJZHrryokY/Xl929VywQfIhtI6tOALWRXd+cY
         DpuCrylX9wIkusFR2JrzT2a3JkJYZmOhqHJPTnpGO7DfH8RyTWoo2SQVWrvgx4gCcTom
         ve/pZznETu3yKXCFPuk3DTNpFMEIpZXcO2SHBcCxjJkYtEDLdpfvfD0mlGjuMczOPEpg
         aQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784971684; x=1785576484;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aM9s/dD1ClDjMhFdGbWeCMicnGNYIJbtkNG9Jl0ztho=;
        b=W0q60Zwhfi6vQcndEnlGVAFJswrl22H9yhW0U9HF+Q35HIwV0OtoUhZ/kw/T8M+d2p
         yAB1pAtBjKt8gd89U1cxLeYFiyoOxBDYe+fqTZuksM9Dutup1j4F/DQCYIjeTkuqNQfJ
         0MeSXuOvGgQB9W40gpNbM2J7g4paZnpD4WPMGALB+CfH4rdtiCn2CEQYBCh5ku+Z4PEG
         iUDXixC8LDm8VGJsb4s2VzJA1OHY74s4lCYQdf0oftOs6o7tNANlfvz4DDd494CRli7O
         p9K+JLQmPjcagompJZvgbH/a+RH25KBTfhvOvbskikzRF/Ji/CEgHuQIBfaVsosfkhCz
         aULA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3zEPmB+dQX3ieWkLNa0sfuZBq+RJReRas549SXTO5T26mDPDqm0fKRfR2eCpInk07An2rI3CAzXp3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlz2i+6ZPunTJlXbVvN4NdnorxAt+R2X1ojnB3a3ruHfgZY79x
	TAkCIiXjAumTkylsi5R36e/YVbjTK7i/FkmZ0FdJNM4cgJz2FWbNwya+RKrgXma7b1rD+EM1Pgc
	jhCTVQgW42og4/0IFjS55vRT56lBJeC4=
X-Gm-Gg: AR+sD12iNwIQidus9gqstWcDUAX9LJf2yXZ1pyQ9v7ENgJaXZS4X3OFfpywfHBKxgFW
	3JylcFH62NzJOPSNdQjhLzaUj+atdGqDb6HV0uM/Bmcw/6g+zhvpLkSv/uwQcC6BWGK0CKoEStm
	eoYvcm/rR6ToS1jR3K2LVvnX9lXtMxXHc1mmY+4mY3oUz6vwMRh1aWoMFQaw/Z368Rjv2fX3UDs
	rMz2d1kLhUGp03a6+m7PEWsn3dp8EVNzk9RaXRrGUEdHWEuFkkYGNwZ5xD5fhGNqKzMqECoxbea
	LYRMGBIFPFH7Cc+WSG4=
X-Received: by 2002:a05:6102:3a09:b0:737:5c42:858b with SMTP id
 ada2fe7eead31-7503e976ba2mr1363935137.11.1784971683895; Sat, 25 Jul 2026
 02:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALhuxzfVV=O7z_at9wf0HeU1Mk8fvi_1OHhH1M3Conv9ae6sJw@mail.gmail.com>
 <89b78fe1d23d6a05567e51f83efae1258ac0ad97.camel@dubeyko.com>
 <CAEM_DMHARz62F-Ow0vM6PdKnGcShhY3HjHOZFgSV34QM9VH5gw@mail.gmail.com>
 <CAEM_DMEY7LqEA5a_YM+58HkHBnWfCk1BfAnzZ9XZzqOmbuCxTw@mail.gmail.com>
 <588302e854ade46991dc0516b9832ea7669f3aa8.camel@dubeyko.com> <CAEM_DMENYmLuHaRyh4PBQG1_7D6LG8Gq7RzkrgwvU6MUH-xvLQ@mail.gmail.com>
In-Reply-To: <CAEM_DMENYmLuHaRyh4PBQG1_7D6LG8Gq7RzkrgwvU6MUH-xvLQ@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Sat, 25 Jul 2026 11:27:52 +0200
X-Gm-Features: AUfX_mzxwx3zcvXXDL4oC00uyag-HlR7vJAME2fxycbccW5NmbtAC0NAXS08e08
Message-ID: <CAOi1vP-180-2L6LxR7X3s=MJJ+rBRZCi0ZjFqg9OS8t=wbK0RA@mail.gmail.com>
Subject: Re: [Security][Ceph] OSDMap new_state decode overflow causes
 out-of-bounds read in kernel client
To: Baul Lee <baul.lee@xbow.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, Federico Kirschbaum <federico.kirschbaum@xbow.com>, 
	ceph-devel@vger.kernel.org, Alex Markuze <amarkuze@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 11:19=E2=80=AFAM Baul Lee <baul.lee@xbow.com> wrote=
:
>
> [PATCH] libceph: fix out-of-bounds read in decode_new_up_state_weight()
>
> decode_new_up_state_weight() parses the new_up_client, new_state and
> new_weight arrays of an incremental OSDMap received from the monitor.
>
> The new_weight loop validates every entry with ceph_decode_need()
> before consuming the 2 * sizeof(u32) it reads.  The new_state loop does
> not: it relies solely on the earlier
>
> ceph_decode_32_safe(p, end, len, e_inval);
> len *=3D sizeof(u32) + (struct_v >=3D 5 ? sizeof(u32) : sizeof(u8));
> ceph_decode_need(p, end, len, e_inval);
>
> pre-check.  That product is computed in 32-bit arithmetic, so a large
> entry count overflows u32 and wraps to a small value; ceph_decode_need()
> then succeeds for the truncated size while the loop still iterates the
> full, attacker-controlled count, decoding an osd id (u32) plus an
> xorstate (u32 or u8) per entry past the end of the map buffer.
>
> A malicious or compromised monitor can thus make a client read out of
> bounds while applying an incremental OSDMap.
>
> Validate each new_state entry against the buffer end before decoding it,
> mirroring the existing new_weight loop.
>
> Fixes: 930c53286977 ("libceph: apply new_state before new_up_client on in=
crementals")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> ---
>  net/ceph/osdmap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 8b5b0587a0cf..f09a1c99690e 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1902,6 +1902,9 @@ static int decode_new_up_state_weight(void **p, voi=
d *end, u8 struct_v,
>   s32 osd;
>   u32 xorstate;
>
> + ceph_decode_need(p, end, sizeof(u32) +
> + (struct_v >=3D 5 ? sizeof(u32) : sizeof(u8)),
> + e_inval);
>   osd =3D ceph_decode_32(p);
>   if (osd >=3D map->max_osd)
>   goto e_inval;
> --

Hi Federico, Baul,

I believe this is already fixed by a patch that prevents the
"first-pass truncation" (as it's referred to in the previous messages)
from happening in the first place:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D98917a499ec7064c14fc56d180a4fd636fc2784c

Thanks,

                Ilya
