Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60788384CC4
	for <ceph-devel@vger.kernel.org>; Thu,  4 Jun 2026 19:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602881; cv=none; b=Ip69LeZdVbkgpZwM+VznIcNDdN+lzjMUevzEQFLxRlAKnd3Z0KcugtaW4UG66dME1I8vhT+uS2vgpDFumAQMbmEWlGXj9Qsiwcm/ksa7lSuhMsYly1rpD2QEZp66LE5GVIiM3CGsRWaTy8Mix9SBGKM2UuJ0iBi7UtEpfB5zDqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602881; c=relaxed/simple;
	bh=T2J9UdFl5+UYsNJKgNGIWMaDjS/XgR+upY97d13y5P8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m/15ZXIfQHP8r0NiFsa/6jEg6m0O0ewszQ2MsbXwautZw61/zpjCe40IRloHTUA49zcwrR5x1ZMZcFF/0+/BRfJygYpXwpmn7yLuUnMmpOOZxcQ+nWP/VvYt/QO/uTPoSJ292f1GWyGne+IZWXQztAVU9M3nNQD9XKiClFFRuH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=CWKuXJfu; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="CWKuXJfu"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7e0fc8ead7eso13589707b3.2
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jun 2026 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780602879; x=1781207679; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GzZH1Dkfdzlf4EgnGV+bkrYd21LbQvr0zwjXA4w950Q=;
        b=CWKuXJfuyRDyN/ylq7o/qolansXbcIrATepyTPn9D++KLYV3YahmguDXPtxu6yy3M8
         TYFExvjh1MQcI3X9/LCrMEpR1+7V8xPRnzy8NwPHF+GMKSgKvMtlasLuk512WbkswqC/
         I5bSQ5noNn1SHsZA6L5T7QhonDsc8IV/PNrX1yqnpV1AgEep2/9F58aWRWQAzsSW4eiL
         nM5D+ysIxKGmcMXWimWh9fsDsm1HdfMQPxu2rEr49n/gGEVB5x2Nnw5bg77SxZ+akcGs
         uI79h6PeZbwnKUdsxTuweTQsCPcopWcZJHag/KOBHtwyVCw5nBykk2vdcsOQDZ7+ksxW
         +R6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780602879; x=1781207679;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzZH1Dkfdzlf4EgnGV+bkrYd21LbQvr0zwjXA4w950Q=;
        b=PEPbUyL5oJW5MK3Y9kpkFHztXhxTBB9VoNSQApqKh1kiSKCA2PcEsRGdHPV1XBgRZa
         0xvjjen4MntdKwP/HCgLvv73+EN1rlEQOnZOEQTRjVjVXTAeGu7goRFUM7xauBKiK/Ny
         cSQnUIC4HwuMWgQjksWmEtqGYFgY6OtG+lGXrZVBhAYPfUQCUYIUx3B2TEehaHjF1qUn
         apGYtX4ajTmUKQYDoskUERLKNGDBUsm4PZ28IeRLG6a7zc9vM1FrLY6rlV5wx3DbNaBA
         0T1vXeQWtAjXa8DphnpKt55RIV7Fwm4R0ZB4zwozX8vyNEJqe5Jp5wW2BL0+QKHp46o+
         OK+A==
X-Gm-Message-State: AOJu0YzYsTTdn4R+IMxvetcFvwg9CBPD+X6y1oNqXg6WqPOItMqkNpiv
	GwBNo8DV4goP4i9KOQK4AOMdS54SwfcLDGTsFy+N7+LlcmKwCYmpZJ2UXBPrx2cYpKw=
X-Gm-Gg: Acq92OFiCbN2Irhde2nbFYuu8d2h4dkHzDaYXNHNM2cOhmQ5jmOWR3M6XBDV2wIRvSq
	NwpuNQr8uq6UtaiGvDSD89CVvJ59QdjHloLJZkVteQuKegJFR+pUQSuPQCZUAixiwH5qWl2wXct
	aKsHY2n52LeH+hAMwj2JPoQIGEI4dqkUL6VB8zry4Vd5oy/4g5q8IYp4LFm6YerLMFA3WT91JHr
	8WOXuGsLuKpclHZzd3nB1xMjnUBxdGC4yece0w0BdWKNl7WsrsF/4lezA41/uFmLD85TygID2aP
	6R8qsVTHFdJNuSxuuV+jB8Z0dKJVHqFYlnrTMLlOX1+PtSmPpXATz3n7pSPzeGLl8681f5q3CY5
	HJ1PuchlE9NXiIh3il4AYCbT8d7BjfJZlQCg+zZqZ6DM8BDLEGLtWycApW2pWVmITfWcQJg75Wo
	pD3tcJmKRtvJu4g4IwOydanIO8r2r2UluLldaazjtXfeMy0r7n0wbZ5M/XzBnXtSsvu5xzbFdeZ
	mllY2qaXIPxRko2kLx7vejeQDCiSYA6XPWcEinlChmhyh13kdKN8E/5KZuvcTi6YUqHvM0=
X-Received: by 2002:a05:690c:450e:b0:7e8:5727:a54d with SMTP id 00721157ae682-7ed0e671647mr4482267b3.38.1780602879525;
        Thu, 04 Jun 2026 12:54:39 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ae19:b6b2:5990:ed2a? ([2600:1700:6476:1430:ae19:b6b2:5990:ed2a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8191sm39278017b3.8.2026.06.04.12.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 12:54:39 -0700 (PDT)
Message-ID: <d948230edc8e7af8faea29af637524afc78c9fae.camel@dubeyko.com>
Subject: Re: [PATCH 2/4] ceph: bound MDSCapAuth path and fs_name decode in
 handle_session()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Michael Bommarito <michael.bommarito@gmail.com>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 04 Jun 2026 12:54:37 -0700
In-Reply-To: <54eb585e03930ade4d11d9a103eff5f737d65251.1780596023.git.michael.bommarito@gmail.com>
References: <cover.1780596023.git.michael.bommarito@gmail.com>
	 <54eb585e03930ade4d11d9a103eff5f737d65251.1780596023.git.michael.bommarito@gmail.com>
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

On Thu, 2026-06-04 at 14:08 -0400, Michael Bommarito wrote:
> handle_session() decodes the MDSCapAuth records carried by a
> CEPH_SESSION_OPEN message (msg_version >=3D 6). For each record the
> match.path and match.fs_name byte strings are read by first decoding
> a
> 32-bit length and then copying that many bytes with the bare
> ceph_decode_copy(). Unlike the surrounding fields, which all use the
> _safe decode variants, these two copies are not preceded by a
> ceph_decode_need() bounds check, and the enclosing MDSCapAuth and
> MDSCapMatch struct_len fields are skipped rather than enforced as an
> upper bound. A length larger than the bytes remaining in the message
> front makes ceph_decode_copy() read past the end of the front buffer.
>=20
> The message front is a dedicated allocation (ceph_msg_new2() ->
> kvmalloc), so the over-read runs off that object. A malicious or
> compromised MDS can trigger this with the first post-connect message
> on
> mount, with no client-side user interaction; under KASAN it is
> reported
> as a slab-out-of-bounds read in handle_session().
>=20
> Impact: a malicious MDS can force the kernel client to read up to 4
> GiB
> past the message front allocation during session setup, crashing the
> client (out-of-bounds read).
>=20
> Switch both copies to ceph_decode_copy_safe(), which performs the
> ceph_decode_need() bounds check before the copy and branches to the
> existing bad label, matching the rest of the decoder and the error
> path
> that frees the partially decoded cap_auths array.
>=20
> Fixes: 1d17de9534cb ("ceph: save cap_auths in MDS client when session
> is opened")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> ---
> =C2=A0fs/ceph/mds_client.c | 8 ++++++--
> =C2=A01 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index ed17e0023705e..4f36ac73305dc 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -4318,7 +4318,9 @@ static void handle_session(struct
> ceph_mds_session *session,
> =C2=A0					pr_err_client(cl, "No memory
> for path\n");
> =C2=A0					goto fail;
> =C2=A0				}
> -				ceph_decode_copy(&p,
> cap_auths[i].match.path, _len);
> +				ceph_decode_copy_safe(&p, end,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> cap_auths[i].match.path,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _len, bad);
> =C2=A0
> =C2=A0				/* Remove the tailing '/' */
> =C2=A0				while (_len &&
> cap_auths[i].match.path[_len - 1] =3D=3D '/') {
> @@ -4335,7 +4337,9 @@ static void handle_session(struct
> ceph_mds_session *session,
> =C2=A0					pr_err_client(cl, "No memory
> for fs_name\n");
> =C2=A0					goto fail;
> =C2=A0				}
> -				ceph_decode_copy(&p,
> cap_auths[i].match.fs_name, _len);
> +				ceph_decode_copy_safe(&p, end,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> cap_auths[i].match.fs_name,
> +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 _len, bad);
> =C2=A0			}
> =C2=A0
> =C2=A0			ceph_decode_8_safe(&p, end,
> cap_auths[i].match.root_squash, bad);

Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.
