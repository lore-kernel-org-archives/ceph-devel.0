Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795860012;
	b=OrNEqzygWoRyghFPGJLuXNIfWsErTalC5rMbjY4vzKWgTLMt7t0d1xdDfLO182Zwk8/n
	 aoi8Fc71jNldSkz2AJuvuCi0soXYaWX3jyAgC/tE4dHTY7QLA3PkT8+JgbHZPcEm1TTrJ
	 omzJR07vvLPCKROeyeReShtGdnDlZL5w+WlH/36+bbwZUO0p7UhUBm3svRztQ2bK0YkNm
	 WAmt3od82Vb8HbWhorhti6SjTtuNA3Xjt91JhVO+unF7b3fZIssOhKk3a22Y/B3TlgBH8
	 WIsktsQzS/Eh5hQOm4iKAdnjCf+7y2D+gr4lThoyUAO1PIH4OnEfSDp9F04yLddasDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795860012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=nPGTcETShmdbQK/a9ONMG6S8iEGM6qMpv4f91QkL/kw=;
	b=vetRgHCp7RLJrBt54SMvlZQoDpZtZ+R6tZygecC6e0ks+uZsNmXyebH2J8Z4+032GQCf
	 1jbL6fTK3zN61ioNN8iIISAnSahjdFh1inO5mHGxbunej1x2Xku/Ofx//SZd4MIKydIss
	 UdoeKt8NyM5OZW0O8iDhvCEaSqjyW1rfK1mJsJA1K9eMLIVr/udza/BDbXwkUFTKFp4UX
	 cWOEjkFQqNTAF672o6HiH55+XztT1I9aXeMqU4xxQgjKdmpxUp1EsnFu1bHP4n/yeIg62
	 dw7X+gDAYFF1my2Lt1PeM+YbtnEe2sNobs19SFFXRb7OrBWuknxRyZkO9Jnlb6kxGWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=KSngFPbK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE97606A31C
	for <ceph-devel@vger.kernel.org>; Sat, 28 Nov 2026 10:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE97606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=KSngFPbK
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c516a1623d0so1037056766b.2
        for <ceph-devel@vger.kernel.org>; Sat, 28 Nov 2026 02:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795860009; cv=none;
        d=google.com; s=arc-20260327;
        b=ftPEaE8jiYFV/MAqsXMiQE1mg0ZQrNyUzk6Cd0ErrBNzzm9N0OZ0pqZhesdKsj2tVV
         CENwMcFOY14A8LtEOUzd/1oLCBlvf9aWkdYtDrEjlGjoiahHMjKtNgQg2neH79r5hovJ
         gZVDokNDi06S2MY86dT4o2jtcln4/kmUpZIzmKZV4ZRxF+x0uSoGXH5dcS0pjL9cFnye
         +ZoGKkMY06BY63T7oVa/m5D5Qt1sAfuTe5kb7CTfXceT4UQ00pB0hqRLSY4GNd73+x+C
         j1+1sfE0908P2mpzgX2P6O027UlEQZ2DAVfA/RIxN4cJkC9YgyHXDV2EuycKZCmfKmRA
         gkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nPGTcETShmdbQK/a9ONMG6S8iEGM6qMpv4f91QkL/kw=;
        fh=TYm8EgtcUZXWBpzTrwCAVE1IQ8dTIM2TTebAh871id4=;
        b=rmM6SgyIA3+lHJ+tbBDX16zRVxTo/k/kiA6+5qsquxJdHVaEFh7ZnnQx9GbYo+uUdk
         31IqmXcWZhYV8YGYle8fmAKXDTya/6fkDbI+tggi2cy2mfl7M47qI+fpNdw3RuLA9B34
         l+EqYFX8YYLnQ7CYY0/vDIlO3nLEiZr6ZC/5UPtKV/i1IIB78W7qrBiIVGkVW8zRgG0U
         rbO5TICadzH6Sdvdaz3ghi2LpoHM/sVf3yM8N4xYihjHTRy47EMFrpHa1RC+NIXrYCtj
         IdhtLtDkMaP5evq1cuzHadGbimqb9HtT3eR+hnj1SldO2nH3bjyL8EsLq/62vVjkZQh9
         bJYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1795860009; x=1796464809; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nPGTcETShmdbQK/a9ONMG6S8iEGM6qMpv4f91QkL/kw=;
        b=KSngFPbKWi+NEKnywjWBBMBnqg/G/GRSomY+ybttrguOH0VJotJPjRpYrKLORWco3l
         NvO0elzu4Z2sYtF66PGoF2/vZOHjoxVXn1+qcpeZ+RycSF5WAmKvfs0xTY95tiRv7FWi
         cLzPbRcm1hh+dR7N+xtzK7j4kwuLPZlIusG4vL7aUNpVtu+vj9qH9Cst4o+wsCgluVyQ
         HBbwngETUj/IbwkGbMcJ5Uq63FzIsplwz/WnmBPp3Rn4TxwAxU6fNe2jBea1E/NdE6l/
         BNwhHVo6oRLzNSdK5i3ur7/w3XQ2e1fqu7pzucelCmCOPO+lE1zVoayeg2dr6eSP6hOw
         t9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795860009; x=1796464809;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nPGTcETShmdbQK/a9ONMG6S8iEGM6qMpv4f91QkL/kw=;
        b=Vv2XHQ+0k6T+WWiWgIUJPs+hoX8LaK17jK41PsIEflDHsQhk88a/B2luGluaqBoNZe
         h0tBxDeTRZJSo8vDOXom13V4mtB/EmdZHgIKNMv4TbFihQsFJOEC8nyMvqay2ro2i6aq
         TsmdyGSWmi7xpy8/upYmgUsVO7bw7UFeVu/HE6kAQ3gtBC+m00BdVi+rBvC7+aoc1Fz0
         0RuyJwSCMqA6/v4k+bN36rR2zKzpVttkxJCqBppyOIuXxWJYTI8q54AwlDWo01Nx9OaG
         azlAEpW2nfi9ctZd+RNSm991Z5Fj6Yc12F+XHyG/M342lNiIjSTHTGccyPNgk4MFiSkk
         Bo1A==
X-Forwarded-Encrypted: i=1; AL+hErEO44Qmltc76mGU3N8JSoV5JEWqURRsAWMP9cP71xua5MFtn/5SUGnKKtlm8DXNY5Kwg6QaZid9Gmru@vger.kernel.org
X-Gm-Message-State: APuU4Z/g35BNByXNiAOSD4F8/hKjk98CBifn7Ofbnw+8FT+notn8DDup
	gEEZub57407gom0MWEKtkcYeYPzUGacyRZUeQPNFFLF9wsXrXcadsTqJYAeH0LYM9n1SSlCQaAF
	XuVqXwH80q2IpBkkQcrxp60X1tjRM37WHax8oS39v4Q==
X-Gm-Gg: AZFdTZdOxnNUu87pA1nQ77lSNKKze9dxqbuj40kN8/O0Zy26uHERhNrLPApmTJiBFLc
	lX0kFcnPnEE4il0/ZO1jxkbyMJViMCpSIg2OGJ+sPz5GumDxJ0NPqU4GzRbK2IlPwV9QnPb9ScG
	lOtjgrvCA3aQx6PDP8dj8NXXDs/mrzkio+RHPucQ+/cRWaW6s357QQhCpns7Qd3q6FDegtB+Qg/
	AL8k8q48T2gehcYjUQqIo/p79yGdOPwv9Z7gt+10EPFvpO4WMibwwF2K7kZpoV82m1WI1esrbjF
	IaQdJC+TjpkIVWeN7wZhU9We2CiKyOiWoVGX9oWt2bhYPvu7QTEwv5GHhFvWeiSqb/XSFTG6zdC
	6LiFQhEVAechk+T4Ht+pP7Brm7DVkqK4R+3/7A5MdTa2Xiw==
X-Received: by 2002:a17:907:940a:b0:c33:dbe8:291c with SMTP id
 a640c23a62f3a-c513a807be9mr2587339666b.20.1795860008890; Sat, 28 Nov 2026
 02:00:08 -0800 (PST)
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d56a5a0796c14ef68a178d7a010373c2.1@linux-foundation.org>
In-Reply-To: <d56a5a0796c14ef68a178d7a010373c2.1@linux-foundation.org>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Sat, 28 Nov 2026 11:59:57 +0200
X-Gm-Features: Aa3M54qf3w15eEC_k2xyF2VkCvSc2LV6UiPJIsJeDJBWtfhLRETPjuyTSWgsmlE
Message-ID: <CAOJNxRKucb3PY_EdKmvk9DQmZ1ksQKzxHLaooG2oChyEj0Xp2Q@mail.gmail.com>
Subject: Re: [PATCH] ceph: preserve data writeback errors in fsync()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

Good catch, thanks.

This came in with the async create wait, so I think it should carry:

Fixes: 891f3f5a6a06 ("ceph: add infrastructure for waiting for async
create to complete")
Cc: stable@vger.kernel.org

I reproduced it on the ceph-client testing branch (3f90412e989c), with a
KASAN + lockdep kernel against a vstart cluster, in two ways: a dirty
page-cache page poisoned with MADV_HWPOISON, and an ordinary writeback
failure (data pool quota full, so the OSD writes fail with -ENOSPC).
Return values of the first and second call on the same fd:

                            without patch    with patch
  fsync()      hwpoison     0, 0             -EIO, 0
  fsync()      pool full    0, 0             -ENOSPC, 0
  fdatasync()  hwpoison     -EIO, 0          -EIO, 0
  fdatasync()  pool full    -ENOSPC, 0       -ENOSPC, 0

Without the patch fsync() returns 0 and the error is lost, while
fdatasync() on the same setup reports it.  With the patch both report it
once.  An error-free fsync() still returns 0, and a short fsstress run
with fsync/fdatasync ops was clean.

Feel free to add:

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
Tested-by: Xiubo Li <xiubo.li@clyso.com>

Thanks,
- Xiubo

On Sat, 28 Nov 2026 at 07:25, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: ceph: preserve data writeback errors in fsync()
> Date: Mon, 23 Nov 2026 13:28:28 -0800
>
> file_write_and_wait_range() can return -EIO for failed data writeback and
> advances the file's writeback error cursor.  ceph_fsync() then overwrites
> that return value with the result of ceph_wait_on_async_create(), which is
> normally zero.  The later file_check_and_advance_wb_err() cannot recover
> the error because the cursor has already advanced.  As a result, fsync()
> can report success after an ordinary writeback I/O failure or after a
> memory failure poisons a dirty page-cache page.
>
> Keep the data writeback result when the async create wait succeeds, while
> still returning an error from that wait if it fails.
>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Alex Markuze <amarkuze@redhat.com>
> Cc: Xiubo Li <xiubo.li@clyso.com>
> Cc: Viacheslav Dubeyko <slava@dubeyko.com>
>
>  fs/ceph/caps.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --- a/fs/ceph/caps.c~ceph-preserve-data-writeback-errors-in-fsync
> +++ a/fs/ceph/caps.c
> @@ -2651,9 +2651,11 @@ int ceph_fsync(struct file *file, loff_t
>         if (datasync)
>                 goto out;
>
> -       ret = ceph_wait_on_async_create(inode);
> -       if (ret)
> +       err = ceph_wait_on_async_create(inode);
> +       if (err) {
> +               ret = err;
>                 goto out;
> +       }
>
>         dirty = try_flush_caps(inode, &flush_tid);
>         doutc(cl, "dirty caps are %s\n", ceph_cap_string(dirty));
> _
