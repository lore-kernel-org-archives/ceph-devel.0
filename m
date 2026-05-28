Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECDF3546C4
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780002309; cv=none; b=bYPkIO2+wlHsgmoMVhus075kTyzC5XUVKdminx7PeVrd0odwwha/ewKyrbkP8wDhwHKURCYEewSEOdW3w0LMKavVLchAXrAYPk5BEXKOPSOEiyJo8d/4O1U+qBJOySZeqZ0B2zJIzwYjaBt7+4kHn9GkdgrCCI59EmjJxA5361A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780002309; c=relaxed/simple;
	bh=tk1c7rnwuBHS2uRZ5SwD0NGJn2M8Eb6GDVhRgrEKGj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pkdSjzX3yNPT0lrL0BHCq0VRNlO0p3VNHOhJxteAjMtFkYzYKf+zK1x11mts6XdT5oHv4sEd2WyAVCvBGuWZEHX6UAuu66tvYNn+EGsx2XcQVx3pNy9ZIZbet3J/kdvZV/dKo4Dk3ynfI9kqzUk1nGYait/FRYrYuZJty8h3Q20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/VqoU+R; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/VqoU+R"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso75683935e9.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780002307; x=1780607107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4mg5HNDrZSCCvclWVXl2PaKa8JuKCMeM5HAnfez5H0=;
        b=J/VqoU+RzIZentEDsQSC0t35GnF9EqBfogi0y7anugMWf0LbAfQFbRd1gJTprc9iqG
         6AZWYpjvc6Cafgf2E8BAlkStJsRb5DvVrZKkiPML55E5Ky2VUXU9qt1ud8xsxsb8Lhi1
         vFAB3d5a8K+kM5/AJA/qC/UJb2Hpa60+1QTbTtpXqdxT3D8dEJl6lI2SZDBLDA4FWqHo
         BGwNXmLFftYqj5vVlsPacGvV4xByRCwURvuD/DzEHhVmt22GH4Pgdw2p9ytNS8dVmDUr
         cp44IJap8Y5kyGPXfT1L6skcl26LYM1X4ff+JKUAdrixPRuqCwSXl+hWGwmKZLJMcI61
         yEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780002307; x=1780607107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K4mg5HNDrZSCCvclWVXl2PaKa8JuKCMeM5HAnfez5H0=;
        b=niyzGq8+/917n12swP4PV6g3/9Yp0ZH0eJvL0ppTmr/slfb759ve/x+FYBZFH6KFxB
         X7L4JkV0yuraC8RpLCcI9kO3HXxmHmduPyqWhHrHh/x7jNyZBGw/fTV9oSVfalbAQ7bC
         KsrrDQtmLsF5nQwYquONv5rcmnnrt77gWvtT0DNcbwRrdYibUjTZ5/EsyiWUcztFYs27
         o3r4+SiQxyy46C6pInZLAF4OIMOCQtIL0ZeXH9gSBLy+7wy7vo0MFcsJ4WxpFb7qjghb
         M1+Yzmw1QMNVxdtP9tOXCo+aMSx7ESMkq+gAj0y/u/El9ZL5LOY7EqjyrGAVUTdztuRv
         8nJw==
X-Forwarded-Encrypted: i=1; AFNElJ+h/W6lF9JvNw54Ct/aLoBpyBtjsXlWl0vCcrzD8Y7RA5lvIfQpx0IjFC1NTS+x/+9R5M5vmAJEReN9@vger.kernel.org
X-Gm-Message-State: AOJu0YyM4lvkNFB0XCy+ogE3D+MYFqwgvKhRTxj5Qim9RbEiSxH5OHWe
	fnMuhWB5NIjmO35wnjjKRKQZjhs81HKhgqX7n0ERtMT0csqPujmBgmtm
X-Gm-Gg: Acq92OFyNGijhsF1IZc6vcQM4SiL1u+ZV3+AuHJtLlP57uj83TI5HQ+I0eLpULnJDhG
	k15wGNOJKe4VpGLRxGEF0blMlZhL8OHd42R5MbBYTc51PIdP7IB1OT/NGkKLJCy57Kio2/1kkfo
	lnIOgILkKjTj0p2Yb0/0jm3tF4fzOsWkJc4IREiM7jLRbJc3YpwBz5B9tx210lai/uui6txGlpb
	eeDjd6DcENvZScsnASDYwNa3bDn0RIc7KV4fRajJOLUIfxZOxxJaIzNWLJu+Gz260WmejqivICa
	jK8kfCRfHjMbq6rFHaSt1UVhQtOu0KGO/d3MCjkNQYf0lCGnmyRMv4gqb7LfqN3RLeTPHH/5/Mm
	IycV5r7u6mxY7OlMczzQWMTea9tl/85sSf+bkhiBudPdAwNVwjcscV/W+K+zGOGFmTGAZ2MpwPj
	A7NuvLvE1M4osxyjb7OWbaMHu+3rkroNLVTYpMGQy05ZUHlDONak8uyfXz0yEwqiUp+8J+bSc=
X-Received: by 2002:a05:600c:c059:20b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-4909c0e421emr1387775e9.22.1780002306931;
        Thu, 28 May 2026 14:05:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092654e10sm56452765e9.7.2026.05.28.14.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 14:05:06 -0700 (PDT)
Date: Thu, 28 May 2026 22:05:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-block@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt <justinstitt@google.com>, ceph-devel@vger.kernel.org (open list:RADOS
 BLOCK DEVICE (RBD)), linux-kernel@vger.kernel.org (open list),
 llvm@lists.linux.dev (open list:CLANG/LLVM BUILD
 SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: Re: [PATCH] rbd: cast snap_count to size_t to avoid tautological
 comparison warning
Message-ID: <20260528220505.73eac71a@pumpkin>
In-Reply-To: <20260528202151.136274-1-rosenp@gmail.com>
References: <20260528202151.136274-1-rosenp@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 13:21:51 -0700
Rosen Penev <rosenp@gmail.com> wrote:

> snap_count is u32 but the comparison is against a SIZE_MAX-derived value
> (~2^61 on 64-bit), which clang flags as always false with
> -Wtautological-constant-out-of-range-compare. Cast to size_t so the
> comparison is done in the correct width.

If that warning makes any sense then the cast shouldn't make any difference.

Why not check against RBD_MAX_SNAP_COUNT - the buffer isn't big enough
to hold any more than that.

-- David

> 
> Assisted-by: Opencode:Big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/block/rbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 94709466ad19..b4ba51db9a28 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -6079,7 +6079,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
>  	 * make sure the computed size of the snapshot context we
>  	 * allocate is representable in a size_t.
>  	 */
> -	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
> +	if ((size_t)snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
>  				 / sizeof (u64)) {
>  		ret = -EINVAL;
>  		goto out;

