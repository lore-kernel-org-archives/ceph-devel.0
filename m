Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE38E450906
	for <ceph-devel@vger.kernel.org>; Mon, 11 May 2026 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778527571; cv=pass; b=en4Gt4Qv8ZPqC+One+KBSF0uc02zxidsdcnSgArheRKb+Iq8CdTLVtIccBQJaoxVqeQTOtbO9q4OqiYqE/3VnIQi3yloy/s246MXs1QyB0PGaGBQZXwNqTHInn1CapBU7KZ4K9ftsZRyZi21hpbmWYYUkpaaUKt8oR7B5mmiq6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778527571; c=relaxed/simple;
	bh=A+yl1Ss0Jy2o7/qGj7Q654nsMY98rYI7uc59+35hLlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KRIXOf1LtWDD0Cy0OjE9C1pmsUHj26sFCYWKJavMLVyC0vSQgvalLws/IvkDejmZfqgRtQ63PHGEJD8PffEm7EXZIbijuWgvhF9VovqfhklnKNOlCStoQVbNJ9B270wuNU94Jz834gAJXCzBO6T+E9euQE6ulkbhKP/WvYTNYqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtA6yOW0; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtA6yOW0"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-95695190911so1149143241.2
        for <ceph-devel@vger.kernel.org>; Mon, 11 May 2026 12:26:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778527565; cv=none;
        d=google.com; s=arc-20240605;
        b=c5ldchRwg5qM1ZhKtL/lvgoHVDHf9+2J4KmHThPIxziGBk3VPcEekU98uJSmGzwqjD
         dk8itO0Gt2/3a/kwDTqpGHPP8zeCEQdBQS0t8mAnsDnUhbWXpIM06j2pEQhqd/bys9zM
         TeVw9EnJ5y2V6cDVVSE4N7s+YnBgSTVQLgogQNgEwD7sHhsw0/5vt1oiCu3oCFcIhxBB
         xA/7MJOOq14c5T5yet49kJM3326oo7HbptFsjTcIN1R+IXF44xvzsg5lDFjk27AzGkKz
         cOLXUkFsKFsb7kFW12s/yCynAY7GdIqc5SexFdRIwsLqxSfIULMsL3YSmetWZhmXwKaJ
         RKZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+Y9DN9ou3xhN5TkTjq8zUSjodrymSeogwQFXoWPv7e4=;
        fh=wCGcmkyqUABwuDHx2ewfVrP0zHyOImC/mTuSC5pz/Rs=;
        b=Fxe62YAB2ht8Y5mOOZixJoMXYYZL9fqUhVgs9JjdT+4fTjLSVUucOOl+9NsqxDop95
         TUDWI6jsn+kJVDDH7XWIbYdg27AVzK4ZYQaQz09cOktixDPif80WCILcim1ly8KwJgQJ
         +aLrxQRdVsLu+mmAtQmUN7NlTjcR5Pwn5xVfkoSVa5bvj9jiemPZXbY8iyS82NoBthCF
         siuv4N1E8ONX+YRXL5aZ4FH5AcNYdNPV4nFO+TqZtUO9UxsTyoTxT2whIRKrLz5nIfJp
         Mm5iIeGKJBmsfCrqctDGzRi+x1bCt0mmzKHDjl+EqgpyF7WLbvf0hPk4IsQg0yCTsGj5
         hLgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778527565; x=1779132365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Y9DN9ou3xhN5TkTjq8zUSjodrymSeogwQFXoWPv7e4=;
        b=DtA6yOW0VabQ+lww+HDs4j2xv91N0Na+b7agTMRR982FPV6M4t+XLLZ5rRDGKgB1q/
         WXXu4iUihuUJn3RZQ6TL4/ulP4x1jnjLOucmE6+/cGSYy6EHGRs+P2OB8GqUSr1s73sP
         V+DRZk/dTSISJS0uz/Qq47dy9vm1r5eQyjkWKUjWt9P8wurUEn8KWioTlTmekOcfxO2z
         PtBGy/iJFVtcgXc1yJxUUO2HgKgPvOt9tHxe3wW6KMZvaKx1IM8Pv1Kzo81EHG0CIbmm
         kzR/GGYXz2d8m8kZAcEXRUhhentJV2Gv1H7wcKU4755GMQzMgvj08OltadSFzAoZxzFm
         2Wqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778527565; x=1779132365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+Y9DN9ou3xhN5TkTjq8zUSjodrymSeogwQFXoWPv7e4=;
        b=LlFxspk+rRsMrENum4HZhyrbDsAz5aYU2bLI5Bwac5wxG8gi7hQ6/8PNgKUpiodjsc
         tWi6mKQ26OX9GY0hVGa35aAZkR2vPGsk3Z9nOZ2Yga32TGNtNn/1xOvjZiedIjq4KocJ
         2NutDBdz3dz+EB9rjU2ik+Jwbs3Aye9KwL6HzyWVe9MZ0v94rdt6G+uxOZiAt2OOOqzc
         EHsA7U4kg26C5WqxlVXd+frEM7zrQF7RexuxlYP2JlQ5/LgCRA6TVkE4Nrtf4Ir3ElFT
         pmtIRhIF9bd5DLiBC1ZfmoZCAUg3sAFGvvS1jx1IUd/KPm2oB2UUSMJ7Om2bVrWpGkxN
         Lgpw==
X-Forwarded-Encrypted: i=1; AFNElJ/Oycwd34/oWOnn2niX2SolzXD8C9zkS/hJDRmrzAJ40/+D21ElaZpYZacJgrZWEe+sBUgmL+1/ETDK@vger.kernel.org
X-Gm-Message-State: AOJu0Yze/nOJ2ljopBbJ/rhH6liWwsGU0UCOy9np7lVx/o2fUwWnHsYa
	tlHiAgoI9tH877PhaFXL2UzEf+Rz4uA6kMyaqAQVVEHGvl0q4+O7QHSAiMGcJA5IXT3q/qcC6B/
	5wAeN7vCdwK+M7gAo9NpaPv6Zyl3Rs30=
X-Gm-Gg: Acq92OGcZUNG9uDpRWDLKqFis9kSEzDKgkrMkp4ipITAuXFoBZT/Zbd+l4GLiBmmenQ
	7e+5WDM2Ra46gQOwIdhkhMubgwdhCm76vSnRRAuJt9LM+rsATRQnCpWmrSxuLjRCwbX+mvvfIEv
	VA19XE2B0sJD1c+xBBbBi9q8hdn7CxnviQOlAZGHMNt+/3zJw0nb8GzExeTkfhIeQLd5X/FXt1R
	ue/0UmMW2KMVKo/1Jtsx8bejb1F2BuWy/LnYREfanuWHfAzSVZTJRyWdapUKPlFHnaWJxVoeakb
	85fNb4c=
X-Received: by 2002:a05:6102:f0d:b0:631:3226:dd8f with SMTP id
 ada2fe7eead31-631dbd7042dmr3919522137.18.1778527564723; Mon, 11 May 2026
 12:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505090812.500588-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260505090812.500588-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 11 May 2026 21:25:52 +0200
X-Gm-Features: AVHnY4IEGHX4aiwpcK3TDs0NrJ3JDVDfr_TzqZiH8_RGkaGgTZpy2ShH4vyGNvY
Message-ID: <CAOi1vP_EnMNXS3+JLzoy2h_48jA-dKgvnfp52G4_d58eE3buyw@mail.gmail.com>
Subject: Re: [PATCH] libceph: Fix potential out-of-bounds access in osdmap_decode()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 11:08=E2=80=AFAM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> When decoding osd_state and osd_weight from an incoming osdmap in
> osdmap_decode(), both are decoded for each osd, i.e., map->max_osd
> times. The ceph_decode_need() check only accounts for
> sizeof(*map->osd_weight) once. This can potentially result in an
> out-of-bounds memory access if the incoming message is corrupted such
> that the max_osd value exceeds the actual content of the osdmap message.
>
> This patch fixes the issue by changing the corresponding part in the
> ceph_decode_need() check to account for
> map->max_osd*sizeof(*map->osd_weight).
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/osdmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index 669348d883f0..2095e73ccf6c 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1705,7 +1705,7 @@ static int osdmap_decode(void **p, void *end, bool =
msgr2,
>         ceph_decode_need(p, end, 3*sizeof(u32) +
>                          map->max_osd*(struct_v >=3D 5 ? sizeof(u32) :
>                                                        sizeof(u8)) +
> -                                      sizeof(*map->osd_weight), e_inval)=
;
> +                        map->max_osd*sizeof(*map->osd_weight), e_inval);
>         if (ceph_decode_32(p) !=3D map->max_osd)
>                 goto e_inval;
>
> --
> 2.47.3
>

Applied.

Thanks,

                Ilya
