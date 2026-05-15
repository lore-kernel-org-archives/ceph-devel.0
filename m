Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F62146AF06
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846749; cv=pass; b=sr6p82ixR5CyUVFmFGPDv+/LLs50zFGTm7kPkGSf7tWrSM+GONtYwIWj6ULzTEdLZmFSkqHnohiGfdz3FIN3Tg/q1irCbIz5d8l1CoJvPSQZDDjncq2CSwQV1rjlMljSztAXrHSNPTqSznoAcdNUKhG1Oi8z1WZb/wfEvnBL66A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846749; c=relaxed/simple;
	bh=kW/9C30akUjzDwJkUoDa2H1DV7Pw0sHZs6bPnj1YUMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXeq89DNQLHi9UOSPcJRfZDa4pgD+jyocE13sivZmhTjZv0DFAqOK5XuNDkPr4UAm/L8XB/mUElPStljZQwEgFvYO5lv63XJ8IwbY3/MaZ3vrdk5Slw4oq8a/O3LE2RXrJAhIcy+XcvWZVM143vhqzaB0DFWt9+/cwgE0gQXKZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObRWGohN; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObRWGohN"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6587cee8b57so11857133d50.2
        for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 05:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778846747; cv=none;
        d=google.com; s=arc-20240605;
        b=a92TEcjKmywrpoFBOz598Ybddgt042h579HnYomnCqFSBCSNUwdPTuH7mk/8+GotZ9
         IlA7p2iOUTUYbMpdzUVFbnX4a4LxKRk6zvZzKvkXFZraE1OqlqSaQ1t4RU+aQOMsOGzl
         L1Ct3+kTsperAv7suaakiiEbHPbR0v9Xe0UeRIqziZGnFUnFPxBoHVkShaVNM7t1RPmR
         s8dgwmtxsQgSTnQdwy2hx7Va/hKKJwqq//YIxG+LYNpHjncREqfqPsoa+i4xhi0UOnhZ
         4THDJyw8uySM6Nlt+e0eQ5TOSya+VSWVZVEaez0gLNSlDDDyyRtpgkGnScG10eLPbZgw
         qfYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5kVosTkW8SNhxTSi2C8qw8i0G8BjP9k3uqUmOQ8n5rQ=;
        fh=F43wxyOinMFWZUp7o0C8pmY0gLhO1GG+ZdCJcYfbvfQ=;
        b=RLCsBL0s5GV2Vu8atpDTLhHQcsjXBPak3eWb6ZFaqq8WF1MnKbFLb7I7MJchZu2fuG
         PcrMi8qnOVVN5C1bN6o8Bz4UjxfhlWU/pv1chPOI2LvH8GcwusXg/QhHWfUJ4YhH4kyf
         mxWxXoYvSGYW7suP0wLv5IdLUox4SuJcFJbKE07+xXPMx2QKIwDi9X4QUoZrV3Dp1IMl
         Avo9NUR8a08G8gDSiacVjs0jt7tnXx9sdMnwGcybDSzCTsqvOQPzaBkSvvnyX6EncG/j
         yq44LTfZIJdU/xMh0Zp19QP+mcIgG9pzyMa1Dq256owinqvuAfcxqK6lMi50tix7rs5q
         n4Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778846747; x=1779451547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kVosTkW8SNhxTSi2C8qw8i0G8BjP9k3uqUmOQ8n5rQ=;
        b=ObRWGohNPKlEIwNYMDzlGOfDGrfA0/ChbEswY1kRthJJGcNomAK0xpDMuew4l0iLhr
         +MGUgLRQhLOGdUXc7C2xZ34+D0oC5mTRS14fw/8q+yWwoVLpzoZZZRdQrUSkn3xg8D7B
         SdCtX0BU4KJ4PlWy0Y7q73GXg/LsTukEJd2c2eiD6Y3CxdHMg3dQPz0hy1qiPSCZ7461
         0GwxtKhYgSYuWTQBy5dlc8BzBY71LPkuea4d9z/4jRKxP6knqbINdSx4Ui9MZrVz9isL
         WiPegBHtAO/W5c1jWEUzDyWwqmvnFCzcCRXFpm545Dl9b8dIRfUw2vJFph/4roNXxywC
         uA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778846747; x=1779451547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5kVosTkW8SNhxTSi2C8qw8i0G8BjP9k3uqUmOQ8n5rQ=;
        b=iMU/Eq+Fh83V5MHwciR5KfVeUWE9Lqcafonv8ExrhJNM7ioqXOlFKy6AtHLKwVfECc
         YLbtAGVsXFNZ9KLHQHUl8sJqFYKp8uJP4EMIYjLLvC0U7ubdF/FWDjQwRjOWmhNGYtH2
         YUPJWU+d8+BZ1rnA9TFtokSsvoCuK0lq48rHYgmjAo/Fys83hvGM7jY2mk3YkITVqieV
         QMAtbNXbIr3mALnED2FE7iWRBcAeuxSHb62f23PBed/+1gWs+9Q504ySeOfuzmQxV/VO
         8jz2PeJwWCGiQQgaS62dSO2haNN+FdbdmC9vh/iTDzdTyQhunX7/5/YMbrMF6teIMafR
         2p1g==
X-Forwarded-Encrypted: i=1; AFNElJ/1gSruAsEHWkkGp5JqcM3G+3K0YDvMCiQ48H05n/IQUdMOZBLF6iDiTUwEa5Hbj693sCTyz2sxJjwm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz05cSAr0rX0/e7b9gKx5nNSTWWSRsYPubT3CKR7yjSTJNS6aV6
	zZZ/OOyFhaCSk0m91VS30xZLKwCqAfRLe2sx9JlZgi+DSLzWJrAmj7XAA4M0wHB6an2L+RkCbU3
	MoW3bh0Swn0F01HWkahh2EGvPEUU1GhI=
X-Gm-Gg: Acq92OG0vR34TOBa83YQYa+nOrcf3+eXvK6P8P7Xf2GSAtJoU25uIAauGQTjPxhGALJ
	TLWGoR/S27Z4UodvQvIv9EoxMCGNF5ida8gufy6ljNa77zuhoaoSkuXk5v0IQj109oyiolu1Dy/
	UY8qFNTxB8zzbOPKufSJJBsHJrLly/PNoHTulyvLxm4aCZHf/8suslYQ9ezUOtxxhD1dcXGXlwV
	XZX3ZpVdGkuyp0IeOCYiUuBr4slu5Z50xTxPNWRQ+P4a45iC1FjpvlWqveV/hib9LSFGhfRlxTW
	DA53g1lCZLNAtjHDtnPEq//f4BA7d5hHuN++
X-Received: by 2002:a05:690e:686:b0:65c:5bfd:b205 with SMTP id
 956f58d0204a3-65e2290ca0amr2685003d50.62.1778846746950; Fri, 15 May 2026
 05:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502132506.1936358-1-michael.bommarito@gmail.com>
 <20260510232455.2245650-1-michael.bommarito@gmail.com> <2632015.1778845625@warthog.procyon.org.uk>
In-Reply-To: <2632015.1778845625@warthog.procyon.org.uk>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Fri, 15 May 2026 08:05:33 -0400
X-Gm-Features: AVHnY4I29IMk4pfB2O_u4c2IAaqwMg7WHsEKDsh2DM4cK4qrbnRcwgxc05ExzdQ
Message-ID: <CAJJ9bXy2Kor7mn=KYGvN0UnAwN2=oibsyrqLZ9Aq9rTRV-fukg@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: krb5 - filter out async aead implementations
 at alloc
To: David Howells <dhowells@redhat.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, 
	Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 7:47=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Michael Bommarito <michael.bommarito@gmail.com> wrote:
>
> > -     ci =3D crypto_alloc_aead(krb5->encrypt_name, 0, 0);
> > +     ci =3D crypto_alloc_aead(krb5->encrypt_name, 0, CRYPTO_ALG_ASYNC)=
;
>
> Apologies, but doesn't that do the opposite of what we want?
>
> Documentation/crypto/architecture.rst says:
>
>         The mask flag restricts the type of cipher. The only allowed flag=
 is
>         CRYPTO_ALG_ASYNC to restrict the cipher lookup function to
>         asynchronous ciphers. Usually, a caller provides a 0 for the mask
>         flag.
>
> Don't we want only synchronous ciphers?

This suggestion originally came from Herbert, but when I checked it, I
missed that note and just looked at the code at crypto/api.c:71:

71         if ((q->cra_flags ^ type) & mask)
  1             continue;

crypto_alloc_sync_aead does the same thing at L212 in aead.c.

So the bit mask should filter the way we want, despite the
documentation's implication.  Perhaps we should separately update that
line in the docs to be more clear about filter and how to properly use
it.

Thanks,
Mike
