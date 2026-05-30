Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0F72147E5
	for <ceph-devel@vger.kernel.org>; Sat, 30 May 2026 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780130652; cv=pass; b=b1U8/yN9Lc4YbJU1ubYSycZgjmrKcCBHmcLpe6YUdzeuMUJh+PSmHdVRm3g1IZmJ2AWdBHKBI9FrRzscLRe5ZJEvMu48GAei9Cy1TNC8XeTGbUL+Uf/zG8EKCC0FI8MeGyQql8yUEcX77hpZ2ROL9XzIQvnbafwu4DnCHaPqHOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780130652; c=relaxed/simple;
	bh=TtjqVg+t7+jZd5EpEQZryjCRTaoD/2HCpShEKyZ8ozU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mp7aqb3cFXP3YF/1LQT1WHSOah56AdelcUeh4Vboi4qr4EE7CrnFJwZtECwvFqn9YpXprTdz5GwCRFoofyOuy1LGM1U6msncTPhM+p2G7bsxI1mvL2A81E1+tfzPDzNril02kbANg/0wJG+Vj9IaVaI3rw804qUvWQc/Aa69PQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNXAafs3; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNXAafs3"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5102582e23eso118173311cf.1
        for <ceph-devel@vger.kernel.org>; Sat, 30 May 2026 01:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780130650; cv=none;
        d=google.com; s=arc-20240605;
        b=Fn/M6HT9f4L+STGrBHjJO+F1f+xHiU3mnmakDjs/BLQlxaxsi9GlV0yCESbKratsNL
         VCbMixEa49eXxvGWhppti5R6HP2OQHwEERVBOFHpWH2C5EcyDCy5TOwV0ZBf86xphN+r
         +LFvPuDXqJO+oNREVYlWKeSVbNP1JXVEScGceg8LItT0m3sYQOleanSvFai7DoPQUdLZ
         E1ec/nOEayocfk+OZbylqjEmeF8oKJjjzeR6Cxio7/KOwC4QiM2Ut67ogPoBphcW8zFM
         xFUnEOBSGXO2UU2BYKpuIXMkJyh9ni3lZdiW3N+w/1dQYeeSG9hpxAuIBBpJ7t99sY3l
         +eog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eoSIRBsQ6mX4skycm85ySkNyyRi8BhFDv72ue7aCFn0=;
        fh=3wvYS1BVFmqq6mb59H9VHM/+YIMjmR4fKJglXVHPJgo=;
        b=avJaPcCcymUNj0ormoAns7iwjROyqPm76tGaYk5pb7osu3yNLwQBzdCiTKVI2oGmhS
         zDrAemyo3VzX9l2m7t7nn6AqUPfhQPBzGMRmbehY/3tDKmtmk2EFknx3Vt9O2Gfrz5HL
         JRrVTkLMHHf3x3MPNm9hLAdrmI1IcuHF/fJeVvt7lB3ZPFq+XGHUhnZw3PJ4U7yGrS78
         U0iQgujn2FtKzIY8/OuzEywo0qIkVWFN/jpodjAQNsDObXl0PgJN/62BLJ0927OyxAoo
         NYUYJI00xyzRbqPrEriRWv8c+9SvdTX2rNxJgU0UooG0/NI5VIMrXdkNbfhMeEyvDLYY
         dd5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780130650; x=1780735450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoSIRBsQ6mX4skycm85ySkNyyRi8BhFDv72ue7aCFn0=;
        b=FNXAafs3HPOj0+xdF4KGKDky2odTsQ0dn2idZx7RX8iBwXscOUlyofQ8A+lWJoRZ35
         71PcxYDaQ2NSljGq+/izpTMiJo5gL/cUZjpXtSS0M+TdTq1vGr9kZWAeqwZcvPdYzbKj
         m0FX+9OqFWw8at51CeFWvEUgkfb+8lu8V7r0Wdjw7lkKhpGQ4NpAGBmkWPaC1gEGFR71
         sRpS35Ncu3URikVbfS6AjwQwqcpKFQOUSmSQZ93TbQ+sarHGyU8vhuX+AUZKk5qqD4S7
         rus5gaaV4jCKFLkb90QEOAIcZqtB83Xv4lhTHqdN+XeChmlLg6u37GV3d3gzo+MaO7mW
         XK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780130650; x=1780735450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eoSIRBsQ6mX4skycm85ySkNyyRi8BhFDv72ue7aCFn0=;
        b=NWyPUKfMBofuAyJLf0/G7DgDHK9Xfg9kL+bP1dNs4GoFAU8Uv9HnI6FUhQPUx94tVj
         ufyukMJIZ2Vy8wag6xxB/Hv/K4hstUsqhhtSKVN5CvbPyQWhtF+u+oLJu2pQ/V2Jhlgp
         abxhewpxyK/cUaOknbXSpSgxcwFPpfonQ8dPinAy87JvRJdjwaMl2Srg2+x99wmVSO+Y
         YBHkRwlBTSEgQv25/dF1NSlo68mEEtsUQ5m3NuVM0kcAnM5zRTlRiXLwBxK3PATb9ADQ
         Ap9bo0Kqlu3mdIEs2TrRZ/a3Fl6ZumM5VbeVlrOl9ealyllb/Fx9PE7MGZiyBZpBuBJa
         96wQ==
X-Forwarded-Encrypted: i=1; AFNElJ8T8LPgdhoBH0MDTLv3BBrf97SiiBxo1YL9zRIi9g+orXn4OcKrkOb8cZN+BImevqdx9sp1qDNiE9V7@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMkmFRahK1RY26pGvRsT+mPllvdg9zr3XkkDL3MTSV7IQ9zXg
	nCyxWoWgkJ2pJD4ejkOOoErfUsspPsHWGgWz3E71rZmodx11CyDqLw1P8a30NVpFv4O3qA/pfif
	FezAblHUPcFAMs9lXs37SXVi9WkITXKI=
X-Gm-Gg: Acq92OH/FUE+TMce8BRV8BtEeRB2F4GyEv+9INyKaQ+IIpR5PhB1D5bcD7hpvn0INac
	E1K83lNVVZa+fV/7AokMOSDTycqJMg41Chx3bXPmOi632gakDNyupNatphj0ekAr0DDkvsaBUk9
	dABV0a4mZYBsDHMLD8Vdz6hGHaY0FeSm4fFK2ix0QYnwyzYDN1EyrRKh23myBYM4jzDEpUpOZzZ
	9zfRDliGrOe/iMHQbpz5s9afV4kT7jo4qME29keKd2iEb+IT07mRiOwBKVxFtUwket8m5xn1/Z5
	HRWlkQuch0Xirx2aaTbwqSTniG98vFxegTeEbaIoiMTjwxqBbEE=
X-Received: by 2002:a05:620a:d87:b0:914:a054:c5fd with SMTP id
 af79cd13be357-9153dc833b4mr460701785a.52.1780130650183; Sat, 30 May 2026
 01:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779949116.git.ldy3087146292@gmail.com> <4ad15b49fbbae00d86dfe12348bf94d45aa60ac2.1779949116.git.ldy3087146292@gmail.com>
 <1cab97763b0564d03a583deb7eed485b68be6182.camel@redhat.com>
In-Reply-To: <1cab97763b0564d03a583deb7eed485b68be6182.camel@redhat.com>
From: Yuan Tan <yuantan098@gmail.com>
Date: Sat, 30 May 2026 01:43:59 -0700
X-Gm-Features: AVHnY4LYWH5G0XW0XKAiXpRsBL3MYmpJ567MD8I54TgxBufZ2rvq9V7ElSJca7M
Message-ID: <CAPuPA7+n-pDuN5-y_QOd635-uZLrMkaxn=n-EHamJ9jDo1NDmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] libceph: reject zero bucket types in crush_decode
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, sage@newdream.net, 
	zcliangcn@gmail.com, bird@lzu.edu.cn, ldy3087146292@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 1:35=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat=
.com> wrote:
>
> On Fri, 2026-05-29 at 16:11 +0800, Ren Wei wrote:
> > From: Douya Le <ldy3087146292@gmail.com>
> >
> > CRUSH bucket type 0 is reserved for devices.  The mapper relies on
> > that invariant and uses type 0 to identify leaf devices.
> >
> > If crush_decode() accepts a bucket with type 0, a malformed CRUSH map
> > can make the mapper treat a negative bucket ID as a device and pass it
> > to is_out(), which then indexes the OSD weight array with a negative
> > value.
> >
> > Reject zero bucket types while decoding the CRUSH map so the invalid
> > state never reaches the mapper.
> >
> > Fixes: f24e9980eb86 ("ceph: OSD client")
> > Cc: stable@kernel.org
>
> If I am not wrong, the correct email is stable@vger.kernel.org.

In our previous patches submitted this way worked fine, and stable
maintainers would help backport them.

To be honest, I was also debating whether I should use
stable@vger.kernel.org. My main concern was accidentally sending an
unreviewed patch to stable@ and spamming their inbox.
If you feel stable@vger.kernel.org is more appropriate, we will switch
to it in the next version.

>
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Assisted-by: Codex:GPT-5.4
>
> I am not sure that it's correct to mention it. But, maybe, my opinion is
> slightly outdated.

We added Assisted-by: Codex:GPT-5.4 based on.
https://www.kernel.org/doc/html/latest/process/coding-assistants.html#attri=
bution
Please correct us if there's something wrong with our understanding :)

>
> > Signed-off-by: Douya Le <ldy3087146292@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> >  net/ceph/osdmap.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> > index 8b5b0587a0cf..226c9e0b7821 100644
> > --- a/net/ceph/osdmap.c
> > +++ b/net/ceph/osdmap.c
> > @@ -518,6 +518,8 @@ static struct crush_map *crush_decode(void *pbyval,=
 void *end)
> >               ceph_decode_need(p, end, 4*sizeof(u32), bad);
> >               b->id =3D ceph_decode_32(p);
> >               b->type =3D ceph_decode_16(p);
> > +             if (b->type =3D=3D 0)
>
> I don't like of hardcoding the constant. Do we have named constant for de=
vices
> type? If we do not have, maybe, do we need to introduce some?

I'll defer to Douya Le on this point.

>
> Thanks,
> Slava.
>
> > +                     goto bad;
> >               b->alg =3D ceph_decode_8(p);
> >               if (b->alg !=3D alg) {
> >                       b->alg =3D 0;
>
