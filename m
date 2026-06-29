Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D12FD69E
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 18:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757051; cv=none; b=qrRRBOupi5Y067FL3jiLNZchc+7+pUWMeYdImYZeyiB+bO71W2BDtdssi17bn93Pupq+J4hIpxAmvwjEuADiuVHjuC0Y00JIkjtE1U9UbPI6b+/xh99G75LpDmgvOXdyVv33hCW7vQrCmSihF9UbkPZokhvkyqvILe2s8LD9N+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757051; c=relaxed/simple;
	bh=nF3zW/vM7R+yqFt3KraOlAiqir33ozR0sP3l8+5uHLg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zafb/l5RmVtMJ3jNBJYYiLtQZNbAPdZYbltJuvo85MvWhrIqXiXHPRLMn3H2+6Rqno/gXXjopdJGxHsZ1fTCDuUxkCJW4KBG7yIlolC38rHJoc72/z0d7QLLk0LRlvN02Do3fcX0Pz6KEct1hmuVI9uIYiW5Hs5WIVJPezNvTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=XECR0wYx; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="XECR0wYx"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-80a1fb0c683so32395457b3.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782757049; x=1783361849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0ruul2XvYScI/bfthC8srUtcHVFwUQjm2hy407QDBUs=;
        b=XECR0wYxu0Scvm9lJtViOTdT71q8V9HlJpoym431HH9gzWrNJZzLJv+5ppNMg8teEG
         SVsa864CJ+Rtm3Q62H0dztJCfJHmcBr1G/V5WxH0VaCOaPQ7IITBZj5DMubM/oiB83Jb
         bqRmNnCTsFQjVa/KH9YwaFAmOvx8879JCwwU+io9iVwT4jdGoweMASQcT/28Qc0POj5I
         AdJptRmQ1NqIGNKjOM8/zDR2Die+CY2QpM+uJdGMXBbN/Q+tDxwhEhiyNTdwdJ70QP4A
         UMhuFZ3g0VhlpUIpNNZbcVhjWUWhVV8+ThtUCsxBOw4DfH566geASIpfM2zIAeQYh18x
         seeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757049; x=1783361849;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ruul2XvYScI/bfthC8srUtcHVFwUQjm2hy407QDBUs=;
        b=Vd3V2SxstdtPdhOfMA+8/Ig7ZJWpfkX4nEaD6gHxeV0kVGQB4naEqw85xVg6gbejF6
         UeJ6zQvGFxQyUZgBuBPDmSes3S5vIoXnziN/tdofhcpsXB7km8CIJky1NXRQTU0r1EVg
         I4UriX/NJpF1lqPe/GTOIbhKkcM/9UMKC4PJDU56+XbP9Ag0vwhjaruXoZEP/fW5v4G5
         uFDTjxR+beOhNhDYCU0Rj3ajPqyBj1jbNesD70aZdxC6xxeqYNhm5WgdDVL9IpcQ79mj
         sSl+fANzFSBN6R5f8nVx2rYr45ZHyKBkXntKHBOuR/M8TgFtrQ9RvpH0LdX2b4+/aGdg
         dS6w==
X-Forwarded-Encrypted: i=1; AHgh+Rpi9PA1mQUlgPKQYEJnssofw7E9s9v4ppyVXpz8MWjQa1NdrMpuZ/HhMjq/4gg4i/ShGXOuN91YDs7s@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8IBta7j9/z76L6rT1plJOBMoTYJqEdJrbQnUHy7KlU52sgZQY
	noSbUwM/D/J7um9+huzoUC9ablXE6wKvXMEJDV/QIe5rCOAAvHYQnSQ00WiJBOpLCo8=
X-Gm-Gg: AfdE7cmOlFOM60jW5Hn6e/qP5AI/FjyA4gNbwABs8VQzOAowWj4Y5hEoF84z39eitxc
	Xju1UQ6ktKOt8biXHOJlZUCrQ9c0Ti5RH5dCTJ+HA8MOQ7dpZRuYVn4iJILAHEhH5pUaS9QqwuV
	HtNVPK079T7yMiiHFZQxPqiT8vVb54EvGKFxkyESoduSF5U6KcvaEkC2ZFBNKQBqrpyFrzawqKf
	X1QarWZO2AzpXZxOfyqwMcr30HRqxlzuHToSVqikNuWh9NA1PwCOHOrU/QC5ZesdqbnNP6OwR2+
	+mJRg2M9D0eJxwnd9Q09GnKLyxFQqkJJb31hrYmTEUS4nsqr98OPrkWQ1u1qJCmdLA53uOa2TjD
	ojlWfwxsH+lJWa25Xsbw9dxhSqmeMnw8LvWdgZIphlD2ksAvOQ6vIPzB2WoRfrvj28Y49kSLVex
	HQ5v0yl6sPMGxCEqqGN0np5K0EDB2fqCF+Kx4jCOiXCpkZREEQk9PFmNdN+GBnMXBWhCRg75qlv
	eGZxCH1SlaE4miRGrnfJPr9G1JWFra2wzyem+H2AjnkaPSTPyKq0OvFJ6/5o+9Ga05MZ3kGru+V
	IChtSQQ=
X-Received: by 2002:a05:690c:490d:b0:7d0:79f:339f with SMTP id 00721157ae682-810d990871cmr7646997b3.34.1782757049137;
        Mon, 29 Jun 2026 11:17:29 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810ea25a12bsm1051587b3.38.2026.06.29.11.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:17:28 -0700 (PDT)
Message-ID: <786d6b74d9a13b84ea0f241c2e7e5abecf7ff9da.camel@dubeyko.com>
Subject: Re: [PATCH ceph 1/1] libceph: osdmap: guard missing CRUSH type name
 lookup
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ren Wei <n05ec@lzu.edu.cn>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, amarkuze@redhat.com, jlayton@kernel.org, 
	yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, zzhan461@ucr.edu
Date: Mon, 29 Jun 2026 11:17:24 -0700
In-Reply-To: <c6e4a1cef523893d420ba622078fb03219d78747.1781808861.git.zzhan461@ucr.edu>
References: <cover.1781808861.git.zzhan461@ucr.edu>
	 <c6e4a1cef523893d420ba622078fb03219d78747.1781808861.git.zzhan461@ucr.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 15:40 +0800, Ren Wei wrote:
> From: Zhao Zhang <zzhan461@ucr.edu>
>=20
> Localized read selection can walk a parent bucket whose name exists
> in
> the CRUSH map while its type has no matching entry in type_names.
> get_immediate_parent() then dereferences a NULL type_cn and passes an
> invalid pointer into strcmp(), causing a null-ptr-deref.
>=20
> Skip such malformed parent buckets unless both the bucket name and
> type
> name metadata are present. This keeps malformed hierarchy data from
> crashing locality lookup and safely falls back to "not local".
>=20
> Fixes: 117d96a04f00 ("libceph: support for balanced and localized
> reads")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> =C2=A0net/ceph/osdmap.c | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 8b5b0587a0cf..5eb50d9c1361 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -3055,8 +3055,11 @@ static int get_immediate_parent(struct
> crush_map *c, int id,
> =C2=A0			if (b->items[j] !=3D id)
> =C2=A0				continue;
> =C2=A0
> -			*parent_type_id =3D b->type;
> =C2=A0			type_cn =3D lookup_crush_name(&c->type_names,
> b->type);
> +			if (!type_cn)
> +				continue;
> +
> +			*parent_type_id =3D b->type;
> =C2=A0			parent_loc->cl_type_name =3D type_cn->cn_name;
> =C2=A0			parent_loc->cl_name =3D cn->cn_name;
> =C2=A0			return b->id;

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
