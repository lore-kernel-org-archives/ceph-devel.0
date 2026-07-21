Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3333E49DD
	for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2026 17:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654596; cv=none; b=JIC9e+Fso3ygvV/hudYv+7UrWYNgxfGxcna0vm7vGMNHpR/Asl57SbzRSvvNzw8JKghtNC/V8APcj/eOQUNEb5C//z7Nb6MnLlEBJgFtlhRWbTrapyPM1tyoVFjvuZtCaCkkhzKQUk346f87hUC6WRSR4Q204ifQ5ip6eeqlJ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654596; c=relaxed/simple;
	bh=xCY7RdkGmz/7YOfZEPN1V5TJT/AotDecIKZHpjl9mec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WELiAmMJXYBMFmio+9m/U+hOM1n3pmjlj163OuM44nLgQDdVxQjDUyXaKjK56Vyb2rGgmBIE3ko94k1kzwQatWTiCOd1f9LyRL9wpr60OybQ4SsK2ThbY+p5MzyGLBaGOmYd/1q2bt7OfECbseDioxy+ViCXnm1UJ87QMEtcoU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=QOdawNcl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="QOdawNcl"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8143daf89c7so77622757b3.1
        for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2026 10:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784654594; x=1785259394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FSfSaZ9zYASJ5znKp7p/iQY//eJoBkZaYnyT66BRJaM=;
        b=QOdawNclwEx+6P0FurwEAeXUWXb3qB7hZj2NIXWebH1fL6JAicXvlPCQ9qtwLfr1dB
         QqFfZiRYSN0ZI2Pctq0D5bnprvGx08LWgMeQL1cpW0J84UkV9rC66LqWjc6WtA7T3dLl
         8W9ZGJ8ELaG8Ihw/gCVZaIwD9IWTDLur/MEIcnLj3hi0c1ViabBYbgKtMGtzrx9dAvKf
         +7GhqpFCvV+8WLM9FuwcB/pYg31Zxxwa6XgfZHJlyAaMjegf6Ozw1mVabmxnvYQAx0tK
         3WfZOnwJxQ+Ni/p6j0204daB8bDzHzADaaifJF7gLQGlk9j6kI7FPQe167Uq3vdBXQSs
         PV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784654594; x=1785259394;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FSfSaZ9zYASJ5znKp7p/iQY//eJoBkZaYnyT66BRJaM=;
        b=RMyGf68jnWwf5ou9HgOxwIW6gOKQEV00O3vmIwR5o275A4mZZUylPdJFL2ZC5SQ4sH
         bGaE2ppOnkIZpbOP8JOMqE184OGwyNSKCniSQZ0yXWVbFJ01f42mHODcJcL3lTUpbW2I
         diVAIYhuvybEuT4aRKzklAv3Dw8gcT4TIY9PodMzFzZEB8XMq/BU1Y4qlQ94SYEMnpys
         npDGOZPxEN4Y8cXqf8X7wEJ7t5S3jXWqWs3SisYfJlF7woNScpyNRMtC/iIzmF5HZoQv
         RV8iu5J8isHmYfLKatDdoBeYzpTr0AB2PhzECivsDqLjKAudcDDZyPlmYXaRIPKJSdBZ
         seYQ==
X-Forwarded-Encrypted: i=1; AHgh+RoUJ8KGETBKJh38TlDAtA1kM5KgFPmKWQD8BgPDLJwtuRzxJvQmsr9XB3b4FQmSmsM2xSQWkUsEtD9L@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfBA+qvfTbLuVkEfO96htaDuetlOJlPKjA9UlTU48V5LeMosv
	iSG1ITcA/UjKCRbYm10lInln5h7vuEx0k1ych1V/3FStwN7OnK62tZc4PWdOOX/r+dg=
X-Gm-Gg: AR+sD11W4N1AxKlVAWlsRKa+EGcEZXr02ySsed6ryS661k0lnS967Z2Q40CtrOFIY3s
	MRrp5GVvAM4f8NnwiCU6rMwx/TiOki6nTgf/sTPTm2UDAP9DeNeh2VZCJv56Farpz/6i342oRol
	9y3URPmVg7c9PoWlkiYq6BVq/pOLipw7XLaCfiX/ZXw+fmOjC/SrgbWJ0S1X8QggRWrNdovBdqt
	NPnQqp4/jztAIfejNg3Nef7MSOH2zZ7qpKUf5PTgdygns+unBLFdHCusIPSZ+Us27dvrZZ373kx
	sOkUSpY97K55jiIcQKCpSCI8OJ4KELqzhv9B+mWxnXa8v10WAm28wewKPQ4MqsRpyVRmfhj6VbU
	WFtBC8fr5veC05PlkFs4K0lJXJMwDZmbbcWvtbuoGR9SZzcL0UfEF+h2ECHXvlPO3vhIgen29J+
	PjMcDjAnk32xgxeiW9xmlz+L21ZFwA4uDYLLRjXAL3ZuxsjCQJovpMlB09TheyiBis3KbjVP1z3
	RtaM+iFpIpRkzP5dE/O6pftOVCA2/RcMau4wOlUcgg357OaSTQM5PVZj+JHVCUmN+FACHw=
X-Received: by 2002:a05:690c:64c2:b0:81e:e29a:adea with SMTP id 00721157ae682-81ef2603a9bmr63843687b3.59.1784654593797;
        Tue, 21 Jul 2026 10:23:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:a8f1:2b12:6b6e:7196? ([2600:1700:6476:1430:a8f1:2b12:6b6e:7196])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c6432csm1417047b3.20.2026.07.21.10.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 10:23:13 -0700 (PDT)
Message-ID: <c3e7be316a957f5363322991529c0c4a69937beb.camel@dubeyko.com>
Subject: Re: [PATCH v3] ceph: revalidate ki_pos for O_APPEND writes after
 cap acquisition
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 21 Jul 2026 10:23:11 -0700
In-Reply-To: <20260721-ceph-append-fix-v3-1-403d1b5204d3@clyso.com>
References: <20260721-ceph-append-fix-v3-1-403d1b5204d3@clyso.com>
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

On Tue, 2026-07-21 at 13:06 +0800, Xiubo Li via B4 Relay wrote:
> From: Xiubo Li <xiubo.li@clyso.com>
>=20
> For O_APPEND writes, ki_pos is set to the current EOF via
> generic_write_checks() after fetching i_size from the MDS.=C2=A0 However,
> ceph_get_caps() may need to wait for Fwx exclusive caps if the write
> extends the file (endoff > i_max_size).=C2=A0 While waiting for Fwx, the
> previous Fwx holder (another client) may have already extended the
> file.=C2=A0 When the MDS grants us Fwx, the cap grant message updates the
> local i_size, but ki_pos remains at the old EOF, causing the append
> write to land at a stale offset and overwrite data from the other
> client.
>=20
> Fix by re-reading i_size_read(inode) after ceph_get_caps() returns.
> At this point we hold Fwx exclusive caps, no other client can modify
> the file, and i_size reflects the true EOF from the MDS cap grant.
> No extra MDS round-trip is needed.=C2=A0 Only adjust ki_pos when the EOF
> has actually changed.
>=20
> After adjusting ki_pos forward, the write range [pos, pos+count) may
> now exceed the i_max_size that was validated by ceph_get_caps() for
> the old range.=C2=A0 Re-check against i_max_size and truncate the write
> if necessary to stay within the MDS-granted limit.
>=20
> Fixes: 8e4473bb50a1 ("ceph: do not execute direct write in parallel
> if O_APPEND is specified")
> Link: https://tracker.ceph.com/issues/7333
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> Changes in v3:
> - Protect ci->i_max_size access with i_ceph_lock to avoid data race
> with handle_cap_grant() which updates i_max_size from the messenger
> thread.(Viacheslav Dubeyko)
> - Link to v2:
> https://patch.msgid.link/20260718-ceph-append-fix-v2-1-88dcc4f8371f@clyso=
.com
>=20
> Changes in v2:
> - Re-check write range against i_max_size after adjusting ki_pos
> forward, and truncate if it exceeds the MDS-granted limit.(Viacheslav
> Dubeyko)
> - Link to v1:
> https://patch.msgid.link/20260717-ceph-append-fix-v1-1-c51907ac8e36@clyso=
.com
> ---
> =C2=A0fs/ceph/file.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++=
+
> =C2=A01 file changed, 48 insertions(+)
>=20
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 3823671ab95a..c26bd4fef7d3 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -2489,6 +2489,54 @@ static ssize_t ceph_write_iter(struct kiocb
> *iocb, struct iov_iter *from)
> =C2=A0	if (err < 0)
> =C2=A0		goto out;
> =C2=A0
> +	/*
> +	 * For O_APPEND writes we may have waited for Fwx exclusive
> caps
> +	 * while the previous Fwx holder (another client) extended
> the
> +	 * file.=C2=A0 i_size has been updated via the cap grant message
> from
> +	 * the MDS, but ki_pos is still the old EOF.=C2=A0 Re-read i_size
> here
> +	 * (no extra MDS round-trip needed) and adjust ki_pos to the
> true
> +	 * EOF.=C2=A0 Since we hold Fwx, no other client can change the
> file.
> +	 */
> +	if (iocb->ki_flags & IOCB_APPEND) {
> +		loff_t cur_eof =3D i_size_read(inode);
> +
> +		if (cur_eof !=3D pos) {
> +			doutc(cl,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "%p %llx.%llx O_APPEND: pos adjusted
> %lld -> %lld\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inode, ceph_vinop(inode), pos,
> cur_eof);
> +			iocb->ki_pos =3D cur_eof;
> +			pos =3D cur_eof;
> +			if (pos >=3D limit) {
> +				err =3D -EFBIG;
> +				goto out_caps;
> +			}
> +			iov_iter_truncate(from, limit - pos);
> +			count =3D iov_iter_count(from);
> +
> +			/*
> +			 * ceph_get_caps() validated the old endoff
> +			 * against i_max_size; adjusting ki_pos
> forward
> +			 * may have shifted the write range beyond
> the
> +			 * granted max_size.=C2=A0 Re-check and truncate
> if
> +			 * necessary.
> +			 */
> +			spin_lock(&ci->i_ceph_lock);
> +			if (pos + count > (loff_t)ci->i_max_size) {
> +				loff_t max_size =3D ci->i_max_size;
> +
> +				spin_unlock(&ci->i_ceph_lock);
> +				if (pos >=3D max_size) {
> +					err =3D -EFBIG;
> +					goto out_caps;
> +				}
> +				iov_iter_truncate(from, max_size -
> pos);
> +				count =3D iov_iter_count(from);
> +			} else {
> +				spin_unlock(&ci->i_ceph_lock);
> +			}
> +		}
> +	}

Just comment... :) For my taste, it is better to take the i_max_size
under the lock and then to use it:

spin_lock(&ci->i_ceph_lock);
loff_t max_size =3D ci->i_max_size;
spin_unlock(&ci->i_ceph_lock);

But it is not critical remarks and I don't see any issue with the
current implementation.

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

> +
> =C2=A0	err =3D file_update_time(file);
> =C2=A0	if (err)
> =C2=A0		goto out_caps;
>=20
> ---
> base-commit: afffcd98d2d22f2e7ebe42f71231d52d4eed8ef7
> change-id: 20260717-ceph-append-fix-9820e3b1a78c
>=20
> Best regards,
> --=C2=A0=20
> Xiubo Li <xiubo.li@clyso.com>
>=20
