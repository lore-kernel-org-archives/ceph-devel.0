Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FD2ECE91
	for <ceph-devel@vger.kernel.org>; Fri, 17 Jul 2026 17:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309732; cv=none; b=fk9sChKXZTF2JcZfRHR7Z2m5FecnJHMQ+cvGCDhagt2d/7wXZB7ER9m1VTV3y/FYnj7E355eDw0r6PgJ44Tm7agxR/VRtHJoERxeuSnXhF9/Z6FxOqZ17uupAd5f3sY5fqnigzYFOd9XFA3DLYXu1KxqelAA8iOxV/E/AmuIaKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309732; c=relaxed/simple;
	bh=wE6dhZz0e3OaZxgXSsaOjFlGum7A2oPww9mgFn9bn/U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lN0V00GJ7EsFaUU4WPDk2ZPoZgC8a50yBdvJesy8uf+FKbmjS4IFVIfgFXFR4nh7c2+NPbJCP7kOvLFQQgNQXBIIjTgzUmN++v77U+nbWvAFhG2qnZOVdZhYcnR8owSG2ElX6j4Fx4/2bz0zIBrHBufbqbGT0VfhgdSt0EQYMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=qhtJVOk4; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="qhtJVOk4"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-668433095c5so524114d50.1
        for <ceph-devel@vger.kernel.org>; Fri, 17 Jul 2026 10:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784309729; x=1784914529; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=R2G5UzftXyUNSdV6AYnydMB+LWFZ9zaptvbDuLUrQvE=;
        b=qhtJVOk4R/1RNYLMkc2vRfPgZGoNMid9zB9VRyOwbzbQlSKqVF0JR9MD0/W2TnPfsu
         jaTYq3KfG1Rp9LX4pG2lPHPITYPSyhmsUCk58pbq4Hrbhq7s/JLWBKGKf05By7WMktHJ
         Q4nhyA4/8Zkh2OEfp7ETMDic16bIX/l1TIdxgOHiTZZsCL5A11EJSZNm3bu/W7LrJcga
         pIGa1XKIJAkWJshlAcO7tC6CfLj0nIzxuhrwkt06bmqTLaRImScSKOhk8YI6Y+mZzZ8H
         5BlY5gj9W6kG5mGSvkL3DcxJQ7wOvCk+HXOej+Dm2Ar2PwnseWaxYAciHBlcRxWFvbQW
         TQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784309729; x=1784914529;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=R2G5UzftXyUNSdV6AYnydMB+LWFZ9zaptvbDuLUrQvE=;
        b=pe1wi+wKkwq3I6lGdfRUEcRwdVguuqWDDOB9GNXC8w4nUf/8TkMX1Mqr9L0Gst+uk+
         WiHI7Z+GagyccQ1+WPwSmo94qgY+WpzqvqJlQV8HdSGuVnXP4kqDE95yke0uQFqgrEzW
         9xhdgkXbkhEDDtDg1gjR3/Jyb8yofhKio+7w5yO7o9VD3qjVVv+7vF4BNAVPpVYS7cwP
         ojC0/g1ufq9lpwQbzUY4sDzqLwOToLPHztJ39o6AqmTexq/tF0eM4lywC7jKQptTY7MH
         7UG0X21+D8goajizEvttXeGa3Zdi2ppw+Dj+MOa598+qPcK8EviQiJ+I1yb1tGwvAFkf
         OgmQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvYmAxDRgTcFM2j7MjG8cjfr4kY9VDLHQ/2CsHwKIOXlPLHhQ1jiqFUcMy1UhvHi931JXglXhqq2eC@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPbS5rjNmrO9/dvmP2IYfEdG0JJzWS1XBETYwc4Bg2D1NJkd+
	l6lWX2wLvH6B1k9yvKO4/HmmMk3fgYO/qHDyeiSBwOSS1tDgPjLaOvDHBOpsvOGxzR5V8FuyP08
	jxzmU5vk=
X-Gm-Gg: AfdE7ckYjnfFVLmjpyuo1HwjOmVepZBgPz4dT2wDM70pbRaeyYJa5s1ON6XehnIDyTT
	0/v5SJgW3eH7A+93mCujc4WhEX8OQ5p+yS9TgCJ4bNsUV8tODynHQFplIRoPcfGDbRHgLAsLJ5K
	zQW1qPkzLjtwPVYltJVYtxKRVyffWWs7kK+4Vr+Y1ssBdqFEAMx7lAJ54r+ocNYQSimacfnE6+K
	o+wPRdaKT76KUF7R6eFhq4+LLyw/HWaaAFGtwhVW056PCTVARAG1c8A+kybJVAURanSpEGX3qH/
	KwAR5JE37OTff8ylJ0X+MqxS/EiM42wvKJlDx+M7jtqZfkZSx/lR8j5rY6t10FGOOkprn2YuUfr
	r7RcbE5Y50aZiyKvIhp8HoMRfsNbwC2/pLd76kwwYuz6lRWpSHT2m3sNdQ/YSUveoOG7Qs5Uvs/
	Op0QDfZdwRlowT93k5Wc66pigf/qF77a9u20NRL5i0Vm5i1er+q48EdGfRSYs9V899Resslgzjm
	YKGbAJlEnJXCApocHWO2XmzRqdHmpVqC2hR5tkjSIzxpu7vLQItscUT3x+RCAsDRnHHOsk=
X-Received: by 2002:a05:690e:1041:b0:667:b72c:8120 with SMTP id 956f58d0204a3-6683bb2ea7amr720465d50.5.1784309729314;
        Fri, 17 Jul 2026 10:35:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9b0a:7ecd:9294:edb1? ([2600:1700:6476:1430:9b0a:7ecd:9294:edb1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6683b513f59sm1980657d50.4.2026.07.17.10.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:35:28 -0700 (PDT)
Message-ID: <b5e05cbd0b7aa6ecd8a66dedb71a58e37dafdc8e.camel@dubeyko.com>
Subject: Re: [PATCH] ceph: revalidate ki_pos for O_APPEND writes after cap
 acquisition
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: xiubo.li@clyso.com, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze
	 <amarkuze@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 17 Jul 2026 10:35:27 -0700
In-Reply-To: <20260717-ceph-append-fix-v1-1-c51907ac8e36@clyso.com>
References: <20260717-ceph-append-fix-v1-1-c51907ac8e36@clyso.com>
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

On Fri, 2026-07-17 at 17:33 +0800, Xiubo Li via B4 Relay wrote:
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
> Link: https://tracker.ceph.com/issues/7333
> Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> ---
> For O_APPEND writes, ki_pos is set to EOF via generic_write_checks()
> after fetching i_size from the MDS via ceph_do_getattr().=C2=A0 However,
> ceph_get_caps() may wait for Fwx exclusive caps (because endoff >
> i_max_size).=C2=A0 During that wait, the previous Fwx holder may have
> already extended the file.=C2=A0 When the MDS grants us Fwx, the local
> i_size is updated via the cap grant message, but ki_pos is still
> the old EOF, resulting in the append write overwriting data.
>=20
> Fix by revalidating ki_pos against i_size_read(inode) after
> ceph_get_caps() returns.=C2=A0 We now hold Fwx =E2=80=94 no other client =
can
> change the file, so i_size is stable and correct.
>=20
> Fixes: 8e4473bb50a1 ("ceph: do not execute direct write in parallel
> if O_APPEND is specified")
> Link: https://tracker.ceph.com/issues/7333

The patch has two --- separators. The Fixes and Link will be finally
dropped.

> ---
> =C2=A0fs/ceph/file.c | 26 ++++++++++++++++++++++++++
> =C2=A01 file changed, 26 insertions(+)
>=20
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 9d89d7fc1095..b35c9aee48dd 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -2491,6 +2491,32 @@ static ssize_t ceph_write_iter(struct kiocb
> *iocb, struct iov_iter *from)
> =C2=A0	if (err < 0)
> =C2=A0		goto out;

ceph_get_caps() validated caps against the old endoff =3D pos + count.
After adjusting pos forward, the real write range is [cur_eof, cur_eof
+ count), which isn't re-validated against i_max_size. Could it be a
potential issue?

Thanks,
Slava.

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
> +		}
> +	}
> +
> =C2=A0	err =3D file_update_time(file);
> =C2=A0	if (err)
> =C2=A0		goto out_caps;
>=20
> ---
> base-commit: df47791ab9f12cd9144aca477ddae195f68072a5
> change-id: 20260717-ceph-append-fix-9820e3b1a78c
>=20
> Best regards,
> --=C2=A0=20
> Xiubo Li <xiubo.li@clyso.com>
>=20
