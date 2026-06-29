Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6568331ECA
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757372; cv=none; b=lOAs93G8uP7qwQw2ysP1A4rVHJo02a2xLHZb3uu6yaLGzsmUy4xgSqPY6BBOphsftArUe9Yx9vFP0IfLQMkuNJsLEXYZz6msA1wgS/9vQqZIV1dwQyA3zzeEXGX+q9QtCQB5g3C2ghWGmMm5lGyqXR52z+CbX+qatXWBB+XSQZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757372; c=relaxed/simple;
	bh=U1Ii/BOygCCDmK4G0SEQcD6DNhs4kJDy/IYjuVjkYjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AN2JuvgL32lXgM5vwd2rMTQmSGEImOVm1MhvLP2eJRXoDLq0Ql3w9A9/tidQQQwAPj2WZm5p3MaQkHRUkZDe31/FCPS23IhaOW30mkmouhCj4PBTckntFWqiFoRdKhBGQaSzT+PvhL9tuSrzaPIJr8JQKM4fRo9FHtQR04TIkVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=FYvY78lR; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="FYvY78lR"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8000e21f014so40480317b3.2
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782757370; x=1783362170; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TJwXHrHWhP8qWwlI/K16wZG+0ueoKGg16GAH4dZN9z8=;
        b=FYvY78lRF7eKp9D7BQgpSP9LWRgmOFXjwKOHpbBiW3oC8Nq/XkeC6NY04kaj8lAGua
         twjZHkQxP1fV3RtKLU7XMIcGP0TFGBJEHH8VG9ji/jCUECbqNzhrrCm7inum3TD0Kulf
         HKPtTIvKjY9+0TSZSKMI+ORGDHW6+uRRbWJDZphCPN/U47YGJ+Fq453btwhAHXtAlXwg
         WttrL3SZvh/OnZr/LjiuS1c+pxCSeBDa8bPe6muFqms86RFdNshICs05KOB3Ppny4A8A
         reuWTuqIk5LR6Lmrmy2wIIG1KHhiUIUBRxxyeD+u1qCtqH+dUkmOPP0CbayYYGy4KhLG
         F2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757370; x=1783362170;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJwXHrHWhP8qWwlI/K16wZG+0ueoKGg16GAH4dZN9z8=;
        b=sDzlAW+aQGQ7rdRXQRtCtzCykLq2dipqUpzCH9bJhLd+EitwUSPWYtAJpJadA6pNa4
         P+9YO3aaBj5sMOcSf3Gi3jPA97zxSGB9nw2YK/M3RD8grOH6x8SRmv4QOJnQNf3pLfy8
         Xq3z+YvCVN6sK8p+aemziMrzKSHTCkX7CZeCqiAx+x68nsOusAZv3OebVa22QAEcgsKo
         iczsd7lcO+Ol4FP8LI3SRtUqF73vfmfz64WXG5jS85aI6YRycMZgX3GwHVaQiASbP4XE
         LXohfqai0I+7oEBnjAPmlqk+dfYx3+VAvaque7ouPzfIA64Q+fRgIyatorogQA39hBMH
         ZJ7A==
X-Forwarded-Encrypted: i=1; AHgh+Rox7F5j5PGeKpoFO/wd0VqM+xvT0uKcu1cLxez5Ri2mSvn6IOX8NMWvq4JZfzN5nIy6lQhAhlht2nU+@vger.kernel.org
X-Gm-Message-State: AOJu0YwCuqV3Dh39GWV6sgMhgnicd9DsweCb3EP5UaFVN6nyiq1sq/y8
	Mb4ob5euc3UWx98yMvrqFvrO3oCskXlO8Bb0lU1R61pFYxVDHNVZ7C0+r7j378ES/2Q=
X-Gm-Gg: AfdE7cmYZlqV6tA+gY00YyVQntwKKNjEBhC9XsTsVzpQMu56GyLGWcOgdqr7uTTGYtd
	iG/hFulQ/BuLlQ3UzyzP8DNyx7wPHiyopJp0PJvvkLX0y4x21K2cfM5tOwK5LDFakBCbOJo5p0Q
	5mDFItsOls/KtCBSwJ0OOE20hUmXeH/j5nB5/8ZfUW063dkFxiW7UIiBXKGvAVbpSvAaUoeGuk2
	zPYydC7bNxkzbqZvoHxcho8GfbCWxm5dyKYYgsi6nfvHfspu50IpVqcSmzDoDfVe6mdI+GRg2T5
	5/boaxI/8FeHWcQpGApesytViZaDVpJ9o8W82wMtY898NDScZzOgSf2K80ANbj5AQ82QKqCnaDM
	Mk8lFoGZyumj6T4/UYHstTMaeXUehGdDsFvGwWkuTIlTYCENOZTQmsJL109mVsdrNDXWxa4zdRU
	BP+PbQuG7Db6dV62YAf97vdyIhmtuMdr9aRK4FfBjowwClenHlsjqyau2vAp4ksDIndEU9R4M0w
	UvX19q3NS83ryWrUkkSjfI3Ln9tAp0Sh//P9tpcLuHPyyaQ+08JcQh8n+hD5gFK2ypQUyGXw/3I
	3VfOzw0=
X-Received: by 2002:a05:690c:680e:b0:80d:c2cc:f685 with SMTP id 00721157ae682-810d7fd9d0cmr6615897b3.6.1782757369796;
        Mon, 29 Jun 2026 11:22:49 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-810e7a722ddsm1206787b3.18.2026.06.29.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:22:49 -0700 (PDT)
Message-ID: <04b77462d62f7c28de25dee9e09b254798611ef8.camel@dubeyko.com>
Subject: Re: [PATCH 1/1] libceph: mon_client: bound get_version reply decode
 to front len
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ren Wei <n05ec@lzu.edu.cn>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, amarkuze@redhat.com, sage@inktank.com, 
	yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	ldy3087146292@gmail.com
Date: Mon, 29 Jun 2026 11:22:46 -0700
In-Reply-To: <51227a76810cc04846bff23bb891bb216fc55a57.1780374480.git.ldy3087146292@gmail.com>
References: <cover.1780374480.git.ldy3087146292@gmail.com>
	 <51227a76810cc04846bff23bb891bb216fc55a57.1780374480.git.ldy3087146292@gmail.com>
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

On Sun, 2026-06-07 at 17:35 +0800, Ren Wei wrote:
> From: Douya Le <ldy3087146292@gmail.com>
>=20
> handle_get_version_reply() uses msg->front_alloc_len as the decode
> boundary for MON_GET_VERSION_REPLY.=C2=A0 That is the size of the reused
> reply buffer, not the number of bytes actually received.
>=20
> A truncated reply can therefore pass ceph_decode_need() and decode
> the
> second u64 from stale tail bytes left in the buffer by an earlier
> message, causing an uninitialized memory read.
>=20
> Use msg->front.iov_len as the receive-side decode boundary, matching
> other libceph reply handlers and limiting decoding to the bytes that
> were actually read from the wire.
>=20
> Fixes: 513a8243d67f ("libceph: mon_get_version request
> infrastructure")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Douya Le <ldy3087146292@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> =C2=A0net/ceph/mon_client.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index d2cdc8ee3155..fd3ebebe5f4c 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -821,7 +821,7 @@ static void handle_get_version_reply(struct
> ceph_mon_client *monc,
> =C2=A0	struct ceph_mon_generic_request *req;
> =C2=A0	u64 tid =3D le64_to_cpu(msg->hdr.tid);
> =C2=A0	void *p =3D msg->front.iov_base;
> -	void *end =3D p + msg->front_alloc_len;
> +	void *const end =3D p + msg->front.iov_len;
> =C2=A0	u64 handle;
> =C2=A0
> =C2=A0	dout("%s msg %p tid %llu\n", __func__, msg, tid);

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
