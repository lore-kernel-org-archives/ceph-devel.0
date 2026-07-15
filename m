Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D64A1399
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137897; cv=none; b=m+FF7ZOjFF3zg/CUyRURwuvn+i6LQf6ouHDOt9mC1JeevDzzY/cQ7dsdQnueNohV2Xfwe1NfYT29yDTaABAF7mLPNB/qStb1M35iZnAWYgB9jgHHkVnlPmIZj3msAGVt32TRt7V2BHLW7XlLqoxRka7NmAkgRBlLF/0Dv8OuSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137897; c=relaxed/simple;
	bh=3WB6DNf1xk14Xxosd3dsF2oSQXuZN3ym9c54bVMqS/Y=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jFSKqm2Q0LQnLxjqJTK/O0bTlDdeA2kWNnR8aIO4gGxbXopt8WHJRaslXJP5XgTWxifO2EsKj7w1a0+yY1zWnfx2BAfecYRoOAFcRasnBUUNJijhi7Rummq446ZgACv9Ji6HM8Geeg6RUigliqwJaUGZK52PWLan1PGA3PZ88yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=cHLG6lWm; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="cHLG6lWm"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-80cebd41372so56308107b3.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 10:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784137894; x=1784742694; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gV9UHv1FVMFJV/mrKWANR8uUYmepHxhDQGReXLFTg6M=;
        b=cHLG6lWm3P6hsjYdk5elw0PKxWVBxl1Xh+lhU4tAORP8NEV8Upda4Hkn2YNuzabXoV
         KeiGnjT1hfBSHAx8kNs3ercHCzoml6YYEE8Rgb8LPTIRmHC30PU+u1yNcbftG4oMSLG4
         4CxEAkGYZ0b1vxlLE8PcOWBKM7nE+TqEXQLWapE0dnfVfZ75/BHx31s3fKDJqUzWoBt3
         Fnq0gJ3XP8qiWN/+Sr+MsQsDbMEyNUZuYQb88TB6Hj5fJbw71c4WGxPC6zYQkzJhtqVw
         eEkTJ9XjtqiYl8biZfK16AQC4UxtZtRIxBYVnVoOgiTPwKpgtCtqWS15kHNUIKhzsHaj
         ni+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784137894; x=1784742694;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gV9UHv1FVMFJV/mrKWANR8uUYmepHxhDQGReXLFTg6M=;
        b=DabLvw8nO5pa0vg9mI/MD4Sha53JqydH12zs6uceGie/KVW5ZuYG09FTAYGJebDl6c
         GRBV1jckDN/gn/C6Im3NZHGSQQ3+bq3cIgpv6oHle/7wRwk4Wz7KxQ2B+9sM+fW2xe/Q
         3P/m5rw32wVIIHRZFbAXvFILQzw5Q6BxELUrrMOyLjlcw1ZZ60YjcQz/jzOgFXO3a/h2
         GsospMh+R1fLnEguhHZfrBJ4rqVcfAfvoG6sYWsv2XHyYM4DtnxdIDWGEB39v0r+nzUQ
         KcmLQIS7QDZ+HNqBAe98KW24QWa01lDyIDt65F3ohKmRI0sf7Gnog2tedL1OR0Ykhyj8
         80+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqd94AjYcMCjQKD+r91OF4zQ+s4qBlB8dxTlyz9DjpmeINM+H5sOglIJrpSiUDOLHU1/XMBCcM//mjm@vger.kernel.org
X-Gm-Message-State: AOJu0YyHjPwm2haeSIk/Mo6zp9t3Ym1KxZgsfBVIuIDY9hWhq55GA2+X
	9muOUCcIGHg6DCEIABHvIRszOlnkZJxSN4TwVDG+HrO5v27eYsT3UB4RfD71qWC47MIYr4maHQN
	YuB1HN001XQ==
X-Gm-Gg: AfdE7clDHSuNCgbrJ1OKorbaAAkZNh5/8gTUTj4MysehsTtW+Ntm1IYHlXoFJ96M6Ht
	UboRbYFOvY5OVOzoTx47dH7ECxpgp0+/WNtOG3Iiv+84T9fI4prCOJdpHiEjjtVwwpVCSzA9BT8
	vkE0x/B/0t70oI8O3zw4IBEGTrwzRlxGeQab6RTBrboaHd1nuIqAZoYHKL7n/1abUwrSUViKUoT
	HqhlLwHRPjWT3Ot739m6cybaYV1DuNz5ecKYlbexEpMOmEyVvwKwgYZ+tuypSR/9XlykwBAhFm+
	GC4Hpo5+T1zhK9w/785kXC7Mj1upSeeDm3446G+N0XyzgNfCcxHNgzjkKtI+EWn+kMM8+iaC3F9
	joMHO10/VEL8A8pK1otyzGXUeP1BUAqqIM5nXn+ARQd1a0RHqXs/tG/JbI0+G72iOkHohCQ/ABa
	VbgSY6aTax0l0D2OrK+pCnwtY9y1Ya6ZvXBJ4wftKd16Q0hiWxf5bbvP4y8HdMPcrlYxXcsG9sW
	w6UNr4RoAsIKENMHgsbDZX5+RfLKSs2bGzSI4t165S5sUDEYFr8ORns2BCmeUbjAbPvhW0nlK05
	cPpAp2jJPz7JZ8XZ
X-Received: by 2002:a05:690c:6888:b0:80e:1ad2:afc3 with SMTP id 00721157ae682-81ecf7af68amr28483067b3.15.1784137893807;
        Wed, 15 Jul 2026 10:51:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:3705:6d89:7b16:2a59? ([2600:1700:6476:1430:3705:6d89:7b16:2a59])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ebe67d857sm49978237b3.28.2026.07.15.10.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:51:33 -0700 (PDT)
Message-ID: <00fbda82bd63f3c7560898531b97a1b061fa6e2b.camel@dubeyko.com>
Subject: Re: [PATCH 4/4] ceph: release unused cap reservation on readdir
 error
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: deepakraog <gaikwad.dcg@gmail.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 15 Jul 2026 10:51:31 -0700
In-Reply-To: <20260715143646.15828-4-gaikwad.dcg@gmail.com>
References: <20260715143646.15828-1-gaikwad.dcg@gmail.com>
	 <20260715143646.15828-4-gaikwad.dcg@gmail.com>
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

On Wed, 2026-07-15 at 20:06 +0530, deepakraog wrote:
> ceph_readdir_prepopulate() can exit with an error after partially
> consuming the request's cap reservation. Return unused reserved caps
> to
> the MDS client pool on the error path so they are not held until
> request
> teardown.

The ceph-devel list has received only 4/4 patch. Is it some patchset?
If so, then why we haven't received the rest patches in series?

Do you have any issue related to the fix? How have you encountered the
issue? Could you please explain more about the issue?

Thanks,
Slava.

>=20
> Signed-off-by: deepakraog <gaikwad.dcg@gmail.com>
> ---
> =C2=A0fs/ceph/inode.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> index 61d7c0b81..2d6a80054 100644
> --- a/fs/ceph/inode.c
> +++ b/fs/ceph/inode.c
> @@ -2188,6 +2188,8 @@ int ceph_readdir_prepopulate(struct
> ceph_mds_request *req,
> =C2=A0		dput(dn);
> =C2=A0	}
> =C2=A0out:
> +	if (err)
> +		ceph_unreserve_caps(req->r_mdsc, &req-
> >r_caps_reservation);
> =C2=A0	if (err =3D=3D 0 && skipped =3D=3D 0) {
> =C2=A0		set_bit(CEPH_MDS_R_DID_PREPOPULATE, &req-
> >r_req_flags);
> =C2=A0		req->r_readdir_cache_idx =3D cache_ctl.index;
