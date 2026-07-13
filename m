Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64A03859EF
	for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 22:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980644; cv=none; b=uWQCelmLaFqGJcXveLOJ5KqWgrVtkdudY2kTmfujo6GL1mjQph70mgV9djUtsxfC6faR4oaNBUTi5GYIBqFLA69cYQfIURKMbjtSK1ibgaCcXx2AehXu0Of4T6uReFE/C3rlSotrJtpDFT2hlw9QeHx90thmDVZSjktuUdy5y88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980644; c=relaxed/simple;
	bh=CwJTMYygCv/JaRgNbe10GD8Vt7eNgAwHwBZ/hvnXZmE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BkMZnAKvVzaztg3J/tQ6snxGCN8C24/HWVGSjqV84wWett9eSOn/bKWelDKfup+ry8KajqNE5tESSr4MTdMcpDSqEe4EQiOyZSPBljuFkxo/Of1VsR++puPWEOGzZbICLhnW5vjjsuR2eNxNsTqbj+lkMczwcRyZU9u8xrSBM2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=P5JZShzl; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="P5JZShzl"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c95d0a54ea5so2576911a12.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2026 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783980642; x=1784585442; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+EqwXaLTzrQ7/tg8kgTdNias/PrMpv3hWIhbdY8WmeI=;
        b=P5JZShzlp7tywwlY0U/oBfszKHCgMOw5rC9Rm3a0SS8/OS/quHu52QABQPu7u3+c1g
         wW56PCIcIy5XgE9fmrWlyMUiKN+tdPsq7ng62Ev3fh2gv7oMymJaKtYC7HjNG5RNGpXh
         KH8XGRU9C5BOVt8Dyr67bMe4Q//VhEJRnUnoEfVyY9IDLqN/3alDR4+oJ0SKHsuO88VW
         y4OsYkGP3V6OMcadGnrIKzs8/5ge0YsY8tNcSBA04j35lAHshvmu0SsSL+FEmxms61cK
         lqL4zJ6ssqTtW4aD6m4bQHYsCylRhnRIOINxyl0qNbEM2glVNkBmADw8zn+2dFjITAek
         mU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980642; x=1784585442;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+EqwXaLTzrQ7/tg8kgTdNias/PrMpv3hWIhbdY8WmeI=;
        b=jWm2y6BF5fFwyoVg0Tuimoch/neE6KdEaHQx+TmKvASOzPNluR4qxEuEOApbrp0KIv
         9T35rFU4SqEMvwnbZ8Rq3+wXVaOiIofBs3FUnr+DH1o5t6w+1264Oli+LaB3nNcSqhJc
         pVjsb9Ji4lAQybqhfskS8Beft0nhhhNLNO3N/cHu2Wgv8RL+ZTpMQ3D+BH0k5o3c6+ce
         EZjO6Z40DOhZIw2vqkwH06QWzB+4NAbDIWDg3t37Gai4S0MEExmwPCQ7CG9EQTijus5D
         7fl3FSk4CmQ1ZbLPusuu8oj/Hx6Ya3o27DB1MWxoxbl+PPALlVovM6o3hAM5NheTE4dB
         gzZQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGB6NaDd20AikMpyYy2Fuma8tIt5WsiakdAJwe4BNRNZSS2nvxAxAkvO0nKYdh7VHfZE+AKErC1SY8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6MBGanststpbmv306Xo0IhbLdaSB5WZKAtGaY9UeMYuPZX34c
	9lTvNJ1Z+YQO07jjBc7kWCNyjaX08EQk575XquzcHV5xTCXePzU35xDpHcxRS9Zm+Gb6j9GdT1m
	jbfq8uto2Mw==
X-Gm-Gg: AfdE7clfRgt8DZXx4SCJIdWTSh9vVPdCRuJHrHwEdYG4cdVhYpQxMhN1eXWkqMS7s1+
	ju4sOSRBLCBVJhzmKDEduUS4lndyvEIjMa2aqoGu4AB87TdL5xXYNH9Gf/AD3425erQM8ocMZ69
	muMby++ixteYh4xabBth48fVM9fh9uA+gEUZSckxlx9yzUAySEfX47r34eUkrFTRB9xnPRDooSn
	XkhkIKvaP3wWU+KfEdX2PnMrtgZG1bfOacWaCNpK5hb33PxsyrS9qjvXPxJ3db77pok7/njHhVg
	mwdBb6Ld6LJWexCIYBB9Q2ZsNksh30PQRWA0BsrYGyCF4CjyWEKht2cuTevDXBeNK/8+ge9Qbt5
	VxIuaI5WGcJ7Jc8vgUKvn2Hes4RirxDhLS19XZuraPBGJjod/Qe67/Ztc+RJ3zQkb1o8MwtrV5K
	2PezSDuGmMPACJJkubU5gxYQClFIqLMaG/u0ux0qaA9FcJu8ndDodFR6WIzdfQca1MGbQFmQoMU
	XE2Yr9p/37RTtGeh1QOznPLQHWDihFP/P5UD0wdT+8Jxe0AYu4r0Oa+39vm0AMuHIf++JDoFV9x
	nb7HaA==
X-Received: by 2002:a05:6a20:c6cb:b0:3c1:a0c:ab85 with SMTP id adf61e73a8af0-3c34d8dfee4mr1014343637.76.1783980642064;
        Mon, 13 Jul 2026 15:10:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:e472:ff2d:20b0:742d? ([2600:1700:6476:1430:e472:ff2d:20b0:742d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm73171868eec.18.2026.07.13.15.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 15:10:41 -0700 (PDT)
Message-ID: <bd15b4d5ccdcf01a8730380c4d974afaab2c782a.camel@dubeyko.com>
Subject: Re: [PATCH] ceph: Move a variable assignment behind a condition
 check in __ceph_remove_cap()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Markus Elfring <Markus.Elfring@web.de>, ceph-devel@vger.kernel.org, Alex
 Markuze <amarkuze@redhat.com>, Helge Deller <deller@gmx.de>, Ilya Dryomov
 <idryomov@gmail.com>,  Kees Cook <kees@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Date: Mon, 13 Jul 2026 15:10:40 -0700
In-Reply-To: <5010d7d4-e321-4999-aca6-1caa040f3037@web.de>
References: <5010d7d4-e321-4999-aca6-1caa040f3037@web.de>
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

On Mon, 2026-07-13 at 13:35 +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 13 Jul 2026 13:21:29 +0200
>=20
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9C__ceph_remove_cap=E2=80=9D.
>=20
> Thus avoid the risk for undefined behaviour by moving the assignment
> for the variable =E2=80=9Cinode=E2=80=9D behind a condition check.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Fixes: 38d46409c4639a1d659ebfa70e27a8bed6b8ee1d ("ceph: print cluster
> fsid and client global_id in all debug logs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> =C2=A0fs/ceph/caps.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index 4b37d9ffdf7f..5b6640707949 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -1124,7 +1124,7 @@ void __ceph_remove_cap(struct ceph_cap *cap,
> bool queue_release)
> =C2=A0	struct ceph_mds_session *session =3D cap->session;
> =C2=A0	struct ceph_client *cl =3D session->s_mdsc->fsc->client;
> =C2=A0	struct ceph_inode_info *ci =3D cap->ci;
> -	struct inode *inode =3D &ci->netfs.inode;
> +	struct inode *inode;
> =C2=A0	struct ceph_mds_client *mdsc;
> =C2=A0	int removed =3D 0;
> =C2=A0
> @@ -1135,7 +1135,7 @@ void __ceph_remove_cap(struct ceph_cap *cap,
> bool queue_release)
> =C2=A0	}
> =C2=A0
> =C2=A0	lockdep_assert_held(&ci->i_ceph_lock);
> -
> +	inode =3D &ci->netfs.inode;
> =C2=A0	doutc(cl, "%p from %p %llx.%llx\n", cap, inode,
> ceph_vinop(inode));
> =C2=A0
> =C2=A0	mdsc =3D ceph_inode_to_fs_client(&ci->netfs.inode)->mdsc;

Makes sense.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
