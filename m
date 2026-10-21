Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792588851;
	b=IDYMaK1sBUoIiJc5oGJG3SWuL2PthysivHAnWVAK0gcwWzONzqCIJgQ6lLHKfJth8/A+
	 DnRgh/chReawJZ1rhjgUd8iJ99/ORZE9eDBjxdH37UBJtfVsjsRUlg2Ydz+7sInpVeeFh
	 WzU7SiwgY5fe0EMax6xDgVxA3ZVOzVkMa5WRjL9IDDKYZ5hhjwDR+uZ2CS9APIAKdEoDA
	 /URW2Vy/DI+0Occiz1tUdvuzAa30zMYtaov1+v58uLldPJgxA7tSR/VAE+S6yxWNSHz6u
	 7SBU0VJ676NdKUSmLGg3bva6H5V1jzB4iQBtbMitZNkQvICozXfIfd8TS6X9hcVNlkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=G0laI3dLJ0QV9Fz739Dic8Wi6qKrKKIFkDkJ/waQe5Q=;
	b=tFV6gs59vgR9rT16qJR8CTFWut7EEQOiJqdheo1ge0/i4CQEvFWZyfBzo7K8gDzfZEBE
	 kVMTaDokKxavrnvBAgJSEfqqyfBzASr+tBrVzom4SUwUcSEluAvEKfn0bvIcBNdiBa4yS
	 qgc9U4J9H4/0QKpUjL/CD0rsHt8dNzHf6hJa8mrHpIdLNWL+4lj5NpQfm3caTKSj0jE+x
	 PEiAGrnimPT34T8sfnpw3Nzee8B2eSEvPc24rivZ1ABR8sRtWCP2Q3ji/Mpr72mkYRnC3
	 Wgjfx/0S3D9WiZ41HMgHJ4JnRUyx/PKBFYjaM+ey+z2uIdQfrhHKUaXxNr5wXV/sAxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=QAXBHBmX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ECA606A320
	for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2026 13:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83ECA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=QAXBHBmX
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so1015929a12.3
        for <ceph-devel@vger.kernel.org>; Wed, 21 Oct 2026 06:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588849; cv=none;
        d=google.com; s=arc-20260327;
        b=CZaLZcE3Zzzs6uq+x231MQkOs43SNPlb0NpcOntLAPnXhAQvaRnSge1gWDNlESLmnP
         MW4TNZrLcqpHD2lqXMBPmdQQuEITtI/INdCugGrGKeJk410FmnYSd5zXpqBHptdB/7az
         3mRlrDKF7UB06wnUuwcx6uBhLprf5WJioIhIagwtaQ10jjpNta6G4ClRu9JTVgeYBs/l
         Nt7fCG+0LB0y77an4vh8UjTqd+WpXWkPPOz9TGse2cVtSJjpcxtWcKwzkZw2IFqfoZ26
         LK1P8OTPMddk5O/OoMTrsnETLsRL4hOGv1P82Uimjp04yy99sKNr9hFp73bDvpfU59pa
         cgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G0laI3dLJ0QV9Fz739Dic8Wi6qKrKKIFkDkJ/waQe5Q=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=iJG9ElMkWYO/QkaxPSB98jBCPEzUvqqv0CUcNewrkUPgIVmv9uPUHMlWlb+d1diqvO
         mVJsZIOjSH02zkd8b7YAacCOQgKLgG72kNYK8Bd6WscMSP1W1hOhqs4W7I+Wla2hLwH/
         YY0/H8+DbCIx716kiYMfwBdKOJGt2nLFDUiQCbLOSc+wE0g7P0/pkIp0xpqQn6egPXhT
         ypV57EQfUGh//z67wYSW/haw0ieCdvNE8QJdl6yrl4Kyso7YQaMzm/qS22wKdeAHbV1h
         EXsspcCGtr5BOPMmknECD+nTnOJU5aAp0+jVxs5xylVwi5RJ/dZlcZdKwEumTAfboBE1
         84yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1792588849; x=1793193649; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G0laI3dLJ0QV9Fz739Dic8Wi6qKrKKIFkDkJ/waQe5Q=;
        b=QAXBHBmXi10oU/ykux/rv3Z2QX7ymp83CwvImhc0p+fx6u6Gx378Z2g3Fr1uFlSXip
         W19q6FnUsQpZ+fibQZofSqFFT8nBFVL0XqOuWbWh0quH9dIQEQ1ybVu3xp6N3CG4b3Li
         FuA5FG54pkTHFl/iK+jv84j6d5+Ucff9/G3SnrhCv+XBIArEVvcpgINvCJyqEjY9mOBK
         ySTtrv5t6LcyyvegNj/XjBDqrG8HkPIeypZCafPbBRWgWXFfYc5eB6Q8Q1q9h3otivoX
         v85I+quoHp5ySLpXrNr7caVXM3G/9pAcOOIHt+sJqueQ6flwcz92JrBBjP4veoPNFhLa
         b6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792588849; x=1793193649;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G0laI3dLJ0QV9Fz739Dic8Wi6qKrKKIFkDkJ/waQe5Q=;
        b=gzWwFyadoBd5G6pqDZGrXa8EfFLLHT8lFW6CYu6HinzeAr6kzrxMsNJQPB+m3L8Pj2
         zeVVy1rdR7PFhxQzQo5KoGEE1CBU6KXdWBB4OJqyDIdhJn8ByaePGX6FhWfTZ2UcTKrS
         3CMz9kRhbZ0UpYZuv8VIEdZEltOdNZeEDjbWCRVU6Ibe6npPPoZTO3OrSSijILJvqjCv
         tfvAsmO2olVYpR87hQUqhLy9nolNf0BlbagAS3R0T0AKEciFUIKjIfdL+ztAtWRGm47U
         7o8TEAZa9ZXsjooAFNF3KCLxpKE85REY6LJfGmtARraU2Kw6wEz7mVE4V/QqcPDL1Qig
         cRGg==
X-Gm-Message-State: AFq9FYKCOEj4nZ/HMH2I9Os/95mdRPyCyrEIb9+3Kr40DSJNvXLAzkUP
	6+9LP4rqOz3gFD735Ihk1pwL90TooI61PeC/7rlz1L6ljYpiAIbnpp/AhFAJsB1sCbTMwgLYerq
	8oZJ03v5mZaM5gk8puwzwUlyMnGIE11E1fBoHaGE8vumUQ0QoQNAe81+pjg==
X-Gm-Gg: AYBFou2Ynb3RxrDrSmC1l+O2ktVjVWCJzMNTW4CpFWNRZPxky2PriF/v667aZmuhd6d
	GdVCM1gy8ZHtBWty0mtiDtMu2rFp5S45dC3q3QKdxv3yPGOGYrSzKLgKeS7YWpVHtJB08olyq2N
	PZ6prg+0SnD5kr6VP6WchuBck8QBGuADgHwGBYylazFLsY+K5hVy0WQ38b/beMwBGHTDRcm6p8s
	7e19FXqodnBczcPnvXgJB4Fk4StHEpNqi0Y36f/73hq21LjuWJG0Wh8IrLxywRHDqaAizlpqYfs
	Iyzu3BbLU1jEPPzWG7RoScgTk7K7dq5QLSpkcGfJwkMSydpTXU/EtXNhSkOuG4eQx5F6uGM+Nh2
	IXg6XHsoGYR/yrVgLOeix0a/Fe0E1HpnBDEImfuc=
X-Received: by 2002:a17:907:7f91:b0:c43:a881:3f4b with SMTP id
 a640c23a62f3a-c4679a3c145mr180203266b.47.1792588848463; Wed, 21 Oct 2026
 06:20:48 -0700 (PDT)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-b4-wip-ceph-ra-stride-v1-1-6314b013d3b8@clyso.com> <20261020095154.1312847-1-amarkuze@redhat.com>
In-Reply-To: <20261020095154.1312847-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 21 Oct 2026 15:19:38 +0200
X-Gm-Features: AclHuK9upe9XQhcccNNiYLN-NJBUPiFYKyhCw_v4qMxO5RMGcbX8wwpKQdjGX-E
Message-ID: <CAOJNxRK0HKWdbA2KkypabACRV81HQg8ap_zCrQeDGVd8mR5FZA@mail.gmail.com>
Subject: Re: ceph: read ahead along the stride of strided record reads
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

On Tue, Oct 20, 2026 at 11:52 AM Alex Markuze wrote:
> NACK. Please respin.
>
>   1. fs/ceph/addr.c:257: pos+stride wrap makes next < isize true for a negative offset
>      `ceph_stride_readahead()` does `end = pos + stride * nr` and `next
>      = pos + stride` with no overflow check, then loops while `next <=
>      end && next < isize`.
>      Bail if `check_add_overflow(pos, stride, &next)` or
>      `check_mul_overflow`/`check_add_overflow` for `end` fails, and keep
>      `next >= 0` in the loop.

You are right, and it is worse than a stray read at a negative offset.
I reproduced it on v1 with strided reads near the end of a sparse file
of almost LLONG_MAX bytes.  When end lands closer to LLONG_MAX than one
stride, next += stride jumps over the exit window and wraps negative,
which still satisfies next <= end && next < isize.  The loop then goes
round the whole 64-bit range, adding folios far beyond EOF under the
invalidate lock and without checking for signals.  The reader spun in
page_cache_ra_unbounded() with SIGKILL pending and the VM had to be
reset.

v2 computes end with check_mul_overflow() and check_add_overflow() and
returns if either overflows.  It also keeps next >= 0 in the loop and
breaks out when next + stride overflows.  I did not add a check for
next = pos + stride itself: by then stride > 0, pos >= 0, nr >= 1 and
pos + stride * nr did not overflow, so pos + stride <= end.  Happy to
add it anyway if you prefer it spelled out.

I also changed the end of each record from min(next + len, isize) to
next + min(len, isize - next), so next + len cannot overflow either.

>   2. fs/ceph/addr.c:256: stride 0 never leaves the readahead loop
>      `window / len` and `next += stride` assume `len > 0` and `stride >
>      0`.
>      Return immediately on `!len || stride <= 0` before the divide and
>      the loop.

Done, and pos < 0 is checked as well.  A single reader cannot get there,
since a file is only marked strided after reads with len > 0 and
stride >= len + PAGE_SIZE.  But every read on the file updates the
stride detection without a lock, so a concurrent read on the same fd
can change fi->ra_stride after another read has seen ra_strided set.
v2 reads the stride once with READ_ONCE() and checks the value it
actually uses.

Tested on a KASAN + lockdep + kmemleak kernel against base, v1 and v2:
ior-hard style strided reads (data verified, OSD reads 1.05x of what is
asked for, as with v1), sequential and random 4K reads (unchanged), 8
threads sharing one fd with 0-byte, repeated and backward reads mixed
in, strided reads and a fuzz near LLONG_MAX, and fsx.  v2 never read
ahead past EOF and dmesg and kmemleak stayed clean.

v2 is coming shortly.

Thanks,
Xiubo

On Tue, 20 Oct 2026 at 11:52, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> NACK. Please respin.
>
>   1. fs/ceph/addr.c:257: pos+stride wrap makes next < isize true for a negative offset
>      `ceph_stride_readahead()` does `end = pos + stride * nr` and `next
>      = pos + stride` with no overflow check, then loops while `next <=
>      end && next < isize`.
>      Bail if `check_add_overflow(pos, stride, &next)` or
>      `check_mul_overflow`/`check_add_overflow` for `end` fails, and keep
>      `next >= 0` in the loop.
>   2. fs/ceph/addr.c:256: stride 0 never leaves the readahead loop
>      `window / len` and `next += stride` assume `len > 0` and `stride >
>      0`.
>      Return immediately on `!len || stride <= 0` before the divide and
>      the loop.
>
> --
> Alex Markuze
>
