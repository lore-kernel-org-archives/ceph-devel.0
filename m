Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794312826;
	b=Tahz6V6m3ZCMW5s7qc2zRv6Y9DKnDRZnOmmplFSNIoZWgkIedLU13e2pLV2+9Tmgr2HK
	 htcGRmXMvXd/LOgVjWYNouiKZE8JlJ9V0EJQsMgpixpjk1gGqXkMtYmVmcUxU3WuzI9H8
	 XIocNfIPoNdv/DnSvedO0GpbfxnoOgWDVX8YifR+35iJCY2IH7gOvxBUIz397SUGK5Oq4
	 /f6H9dWv6EpZJLcT54/DZiG2akz6lcF+dcsQl67DIg1ZnJZoTtl4zeQGO+YrVw8w2BBIO
	 QQwfGCVWnoR2i/m1tfjw8jNeMfo6DzD70km5mEPuJwNA1Q52QTNY249wQ7rq75VY5mA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312826;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=t31sN60p8JglLP4rRIVrVQ+OXQ0CDI0f5Uv1sh0jU08=;
	b=yAWdpEFQMcveCyKmsC1CK2chshiumuOhy0IIHxTAw47OuGHq6ScacdSuLuMM/dzY30bB
	 sb3uuYGywxAscZgCOW6eF2lGEBX/PNcmkl2nQNu+HPry8ADpnD2QJ3YYiNrl1DLduZ7J7
	 TJ+y1PHhv0EOtwNYZdD8qBDjtwVaq1Mvnq1mZbpmHQ70ALWcxW36kr5I7XtUns+O83vVQ
	 /9tfBK6JB14Ar5coShf0WpAkHQY6+cR9QvdBaG/BWLGLW8MJrVeSs/+iZY8hXcAZ6M+uL
	 tNJHvaVLyNahSaUFAk/sZpG/F9jINbfjLm7Y4N+fIJ7tR3INX69CVgff54BLSFzHjVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=Gxm7uzCF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6091E606A31C
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 12:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6091E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=Gxm7uzCF
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so2983640a12.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 04:13:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794312823; cv=none;
        d=google.com; s=arc-20260327;
        b=kU4OU/5aYq9FuKkguxPb6ufiUKon5eqAgDjnpsiAYysQ6Yn01hpqQ9NrezM82wtfS1
         fZ+3wzu/AsHbmJqtxE6CwIEPg7C/PBNz5isseFS4Ivhvm38qo1zCmlM1Gqev1LkVSlav
         E4aQk3e2t0ADDxM0QYA0HBaB9oQEGdiF+z/dJX9InY4GJx/GenQxXwzkvvH1pHRhEILy
         I3Ed1Q26xvE24Rbfkj93XHXR0V/h3FWQEoiB03GzLe5c2riFMF5/O+5rsm8xYhRWBCxV
         kiGLSIpYuguPyPdaiX2Je+jDQYN1Eyvze1QmS0icm36lkUIw7zzJ8UgnP//wAwjf6s74
         JECg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t31sN60p8JglLP4rRIVrVQ+OXQ0CDI0f5Uv1sh0jU08=;
        fh=qmD2qf71wgkdDvmSV8Api1alOOZ0LJiXrah1hj/rA6Q=;
        b=o5M11hudGdZ5IqN87GuAL0XFO3h6wNOl/PiGSS5zfJg1BqGQc4ktST+95WlezKuB5f
         IwsEt5BjvfANqlnP5sX/Mo9PxhaVuRKb4NhF4tOwXyWxbwyPKF4hP3NlQ71sbPAUYcuk
         1v/Ij56uK0VOXh6Eb48xJJY2fnp7FlIYa8wJxUr3abgvrqHlvfHjhnQmx/+pykNMqagA
         kUnI0PMQXExCbcMvIvVHm4nKeC6i2PTY54owEKSnkn2khselJ/HVY+dYfh6ZiDfQJ3dC
         K2mqUvqlPXzO3qy2bfIF2plhIa5PZu0Xi41EwYkM7VCnWKhDcFn3N9aNF4UzWnNMvgmX
         rcMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1794312823; x=1794917623; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t31sN60p8JglLP4rRIVrVQ+OXQ0CDI0f5Uv1sh0jU08=;
        b=Gxm7uzCF2M+eLkxI2KJ1ryn/OZsljWWnpNAN+zsiEcIv2c6nJ0/VxRuFTWtbq8HLb7
         6/rFRPekB7anFkxjD6SVDJqojspEZJkOkDiox7SOQZDOfkjFg32FNsPplANQfBr9hkMD
         bBK/vPOlgdEwBNVFLGwaRuoi6Pe5sEmwf3zavw3aFRJDhYqUnS3rqw7gVkopyvU8fG2p
         3CKjXwB/g94oD17EL8FAqiOVhMccharEuWM3bx7aIFdbdHSrzS4abWXmAK1F8DnKQW5v
         99pjpbThMeAshpR/xQ6PtHal87EBF1dSLCuQjeAGssCzd+ZfaTFK6sKp8uuJCMPOGS5m
         08mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312823; x=1794917623;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t31sN60p8JglLP4rRIVrVQ+OXQ0CDI0f5Uv1sh0jU08=;
        b=JlTN3HKqJtUAUVt1QPelf4ax4qT/GSLoyPuvfK6GpLJ9h7wJIgjXPgOmK6mC5Fz68W
         5Xdsklciucm2kvFeck5yhmZjFBDqyAQPR50Kjknv3evugnh+0mQ1dCYvT07MECE91+8a
         cugaIwKi8grwH1JriSwSbyRtn+xDqMy/diqtBj2nHuFLXSYk5dcifk7YSumT2B3ZbZxy
         YBo+vBVEpfuF4YBz1dRMAiRHgQg1DjFyEjm9XdIzlp2gNUDepDoHBMxJclZXU67jFnmr
         KoaIQTFlVX60kRBEwuZOJV3JKBbNtklkJFmgcMmGtGoxFPys46Fthrt0ZN+u14nPCoGH
         blfQ==
X-Gm-Message-State: APuU4Z9GlelRwnXJ7sWapVchCl05PuXwwNw1juq8XFaktz3dAqqhLJjT
	YPhahXdKorwKF7lPnD4cpEipE/gWYSM8r0Qh7TNwrL3zG8AtTCct7yJ8pACQsyn7E43QQ4ScQ1R
	kr/jt8FS9tLo1LUD11/AjIrPQUsNj2AaTGlUiD0ZN4nyFc4jgYNdBWt0=
X-Gm-Gg: AYBFou3jUSMfU1Nfc9wuTVpx0fNcMJVKzF8i4j//M2y6L6yRLR2VsgDUxlWovPUE7Ye
	GvC8O+uuFRewfcHUMCboH/Zu7CaGU1ini3XbZEKemuSoFJQKCyyxsqwV33k6QjOG53rPdVZpbli
	u16BtJk3AuNf46fFr+ZQl3nW+uxKY/A9eMc7Gx9OtVL3ZFR4YYxnzU/2D5jvbnGHdHXBc+Uzk+B
	c/mokLY4/DmuZ8nyRHUKVAPBkHu5SKk+l0fo7Ysn5h44FaZW6EWnnKIqmFuq3r3wYzSwG/0EPLT
	PsTNY9ESCcwGtzfGL1TmrUY34R0mhLHI16CCN5GqtdUaeIuxxh2IzYhVe4WKxujZoq2AGlm9YDZ
	FAXwj+/QqoE5Omd5Ear0Sy2Txlo/WnZIhFXVBCgs=
X-Received: by 2002:a05:6402:2350:b0:6b4:583b:daf5 with SMTP id
 4fb4d7f45d1cf-6b756b1d555mr2154263a12.43.1794312823251; Tue, 10 Nov 2026
 04:13:43 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107-ceph-lazyio-noread-v1-0-d04369c70ab7@clyso.com> <179430930932.3260974.10127961697716262149.ceph-lazyio-noread-nack@redhat.com>
In-Reply-To: <179430930932.3260974.10127961697716262149.ceph-lazyio-noread-nack@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Tue, 10 Nov 2026 13:13:30 +0100
X-Gm-Features: AclHuK9qKAfUTfVE7pQu-UIFP9Y1SK_tC2_IEPpJwJ63-usPR2rlndAkqOy80vM
Message-ID: <CAOJNxRJ80C8vPLB9EfwbhW3HSYYfK-2T7Qj5SnLjKUcPRdRdWA@mail.gmail.com>
Subject: Re: [PATCH 0/2] ceph: lazy I/O write and LAZYIO revoke fixes
To: Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

Thanks for the detailed review. You are right, those paths look
problematic. I have reproduced these two cases and I've sent a fix.

Thanks,
Xiubo

On Tue, 10 Nov 2026 at 12:16, Alex Markuze <amarkuze@redhat.com> wrote:
>
> Hi Xiubo,
>
> I can't give the series a Reviewed-by yet. In 1/2, two paths through
> ceph_write_end() in fs/ceph/addr.c can corrupt data:
>
> 1. With encryption and fscache disabled, pwrite() 16 bytes at offset 128
>    of an existing, uncached 4 KiB page through a lazy descriptor. While
>    ceph_write_begin_noread() holds the new order-0 folio locked, concurrent
>    mmap faults waiting on that lock can retain 1024 ordinary references.
>    That makes folio_maybe_dma_pinned() return a false positive, without
>    any GUP pin. ceph_write_end() then sets lazy=false and skips installing
>    the dirty range, but leaves the folio not uptodate. The warning does
>    not stop the write.
>
>    ceph_folio_dirty_range() treats the missing range as whole-folio dirty,
>    so ceph_writepages_start() sends unread bytes outside [128,144) to the
>    OSD, overwriting existing file data after a successful partial write.
>    The old read-before-write path made those bytes valid.
>
> 2. First leave [100,200) dirty and not uptodate with a successful lazy
>    write inside an existing page. Then pwritev() 100 bytes at offset 100,
>    with a resident 20-byte first iovec and a valid but nonresident second
>    iovec. The atomic copy can replace [100,120) before stopping short.
>    ceph_write_end() returns zero without restoring the old dirty bytes.
>
>    If range preallocation fails on the generic retry, the netfs fallback
>    flushes the old [100,200) range, including those unaccepted bytes.
>    Failure of the subsequent netfs read-request allocation then returns
>    -ENOMEM with no bytes reported for the new write, although it has
>    already replaced part of the earlier successful write on the OSD.
>    Neither user buffer needs to change during the call. On the old
>    uptodate folio, the copied prefix was accepted and reported instead.
>
> For clean pages with CACHE still issued on the cap being revoked, 2/2
> removes the phantom LAZYIO use as intended. But 1/2 needs to preserve byte
> validity and short-copy accounting before the series can go in.
>
> Thanks,
> Alex
>
