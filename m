Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7BC3FCB05
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148530; cv=pass; b=AP+4EBN+XELAH636fflti3YAlif95Mi+EP7ED7GJ7ux1i99TDIPI+Q4gCSs3sVzBPwbTzGRDydBCq96JWMnGD9PVknIOgnM2M55kNThuHQO1SqsJq47KcjDsEGNqSJwn2zdIkodpS65LkqTIAS5oTCQXB0sK7YgfgCrN+kXk3wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148530; c=relaxed/simple;
	bh=U6MW0woUaYUT4Vr+jmMxbz4RsrTAy7ygYATr4KvCFM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+bAC3qu3OUzovjsmJeF7Dn3LUAolRH7ReM6tjKpXH10GCnCRL9BtVd9JcgJtdAVdBO68sWWlbNMMmI/gfa3NQN7SIZpYHatiBplanegt5rLShznh9l7Ur2f3OVlMnS+Bm3XDKAu5eucBFsWLcXIQrKKSnkvABt2+Rs7XaP/bOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+vR7CjW; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+vR7CjW"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-97622cc1f40so1323967241.3
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 03:35:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785148523; cv=none;
        d=google.com; s=arc-20260327;
        b=S8GEVxA5f8GN3MF8peYpry9/a5Tfl3rUlUksRodbUyT3teG9QwdDWTCQbQ5ZESgJEa
         kdRX0M4xyt9mmk3RSRvdRAO6Pqrimb6kZQ4nTTQVeXELUG0nPqyz56sPGcEwGC3babg4
         zMU+27t/Xj54iOGRMAdryfeGxbC2ZRVv0ggQWYWzRItlhONNVtKNuPQ/uYo4XuYH0SnR
         glUmmzQID2R3V22sYKqEDVzWAozNDpfQ3g0OcNbTcJzRAKp3kq4/gAuVa2uR97oIEFHA
         u21K9ZSuaQ/tKWriMpiAYBaYHdB0SYWbG1gd+RpzfHVTueCHUDpc9MGh2BCLYyj5uT9u
         X8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=08Cum230FWm+ws1onsBj2zOtrxUuhmtl1o+m2ImiGR8=;
        fh=Re+svtJu1VpiuTWjU5U2y67y2Gy8lkQo3w3lList6BM=;
        b=hg9wmjpH2Egv0UOAMHryatPo2iWw/kGjzQro2BiWslNJho8WPLF6IUOMxoEH4CK6bV
         f6KM7KFsKuiR69LStQxBkgIJCyHgW/b8H5zexvzbGZHQ4bqtLd9KSJIPJuZ7X0k17pl+
         k+mRWU1r9T3Sszp4pRx5KYArMtYmrIt4Pt3u1Co5IrfZxewuhPKKrUvQt5QTXN0dmWin
         1CBDVLlcTokIEYVuOo5PyBiLAmNQRNgltvFO5qErMbdypDxhe2ruAKrAMLRrSByIhS1o
         scr3Ubo0XuSKYCtMMJ9k0uc0FIyxUisoh+9xf1TVWfSdHCI81FMBy2gHRsD+XE/7rKvI
         vzuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785148523; x=1785753323; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=08Cum230FWm+ws1onsBj2zOtrxUuhmtl1o+m2ImiGR8=;
        b=j+vR7CjW0471qaEKE8iNe13vijGMmc/cTYZkUPDwA04DMD0IJC+AyiIIywAkmINAMC
         PZ+Mp1FEGLfXutePfKE00zvD0YEBSQEbpJd6qZHSdwFjfs+ieqF/QSY96hbF8VAjq8mu
         3iPbVMA1pFIHyr16CDLGxOAnEFflDia0XIS2n43knZZgRj6X11cjTvj/rhjC9OLUpez0
         ytzw8ZgKisRnDQTkbd4/Z/fjJzCCSGWKNHvFEDGaHm0bshNI6z+Ns/a1xaiulW04pFUG
         CaqWSeOuz8EwDnj8wkxmqII7MKcu3sk+CL5XtJlvbIuXs1wAYOYXssJIzc7epv3eTbsJ
         y2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785148523; x=1785753323;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08Cum230FWm+ws1onsBj2zOtrxUuhmtl1o+m2ImiGR8=;
        b=NWpc1xWTT5Aq7mz7bZFdGje5ZgpqDysDuklow7zYxUzB9k2GdM+2xmtPi81E77tSD5
         A0XDnqC/NV1J2UrY2s4cxb3EOmSR+KTteBFcO45lKkOu1X4CnLXshz6iBtmTQTcTHVri
         ddBSbhTXEAhfkJ8ohepobP4lMZUznWrpasMQQ2NEtuq7xTZVE8b1k4MF+QOQefykl5wc
         ioa6QimkISQy9lxT3P3BePf9S/PxLrOllycSv6Ee7I7hHMfI5u9E9PpxcRIuKzaD7+W1
         HpXFKvjyu0fRiBeNqp3OmZqwNpyoSnLnpOFaG8U+SW25/lgVwVOlzEp7rcjyPfHSarXs
         7bVA==
X-Forwarded-Encrypted: i=1; AHgh+Rpqs4NU3Gbuir8/ONuTfe15/UcZjm6E1ZdoivgPzxK5xW0r7bIxc1UKF03adO3ry189G/7zRiArAk9Q@vger.kernel.org
X-Gm-Message-State: AOJu0YymBJUulPhut2ukYo/P6ItU8XaTnl58VoYdB5/aGz0bQ42hkSFz
	4r3qsfoj0WeRZ+JBfZtsNPbVRHTwq7Cvq+Lf8jUecMYtEEhizTCRMuy7jYGuHoaVL57h23aGGBm
	BvzMSLOngC32D8mSqYbLtsslc0M0Hix4=
X-Gm-Gg: AR+sD10o42D3QogjZig4Cr5JOblKigkbjFGl7+9GGwf73xYNscyYqSLWZPST37i/Tq2
	SSivPiXSOmOiJnh31AZkPWK5RvgGUA+yAHv9qkfPsFCRVBdkbnNSYYBOtc74eITL1SPsp7YIWWm
	BVzFDs1lEk0UQPHk8HSEcAWqtMA/j9RiKhOgX0DAa2yqwngAf0tnk1k6H/hfZVF46plTX+kI1/v
	TqwMun56gJ4GeTuZ45pZ8g87e7tzNeqgY9X3IoEvLVXmZWKTbjGqXo3aCygbLLBrSxERdqx0t0M
	q8H5EhDGRype/ZFdzws=
X-Received: by 2002:a05:6102:5684:b0:737:bfe6:3b03 with SMTP id
 ada2fe7eead31-7503ec717fbmr3838894137.7.1785148522787; Mon, 27 Jul 2026
 03:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701155610.3133868-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260701155610.3133868-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 27 Jul 2026 12:35:11 +0200
X-Gm-Features: AUfX_mwPEFzwX8ns76NtjEshyHFoKLdRFvsYQ-EMw2goV2KyNmPl18v6gBf_2nI
Message-ID: <CAOi1vP9jaHW2Eixk6i0gemBnWUgcybciFv025sXykPxk19ojpw@mail.gmail.com>
Subject: Re: [PATCH v2] libceph: Assign requests to homeless osd if calculated
 osd exceeds max_osd
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 5:56=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> A corrupted osdmap received from a Ceph monitor or OSD may contain
> placement groups with osd indices that don't exist, i.e., that are
> greater than max_osd or smaller than CEPH_HOMELESS_OSD (-1).

Hi Raphael,

The osdmap doesn't contain all placement group mappings -- they are
produced on demand by CRUSH based off of the crushmap that is embedded
in the osdmap but doesn't contain any OSD indices.  There are a few
(usually small or empty) exception tables in the form of pg_temp,
primary_temp, pg_upmap and pg_upmap_items where the "override" OSD
indices are stored.  Are those what you have in mind wrt. osdmap
corruption?

If so, I'd suggest adding map->max_osd checks to the corresponding
decode routines.  Munging ct_res to CALC_TARGET_NEED_RESEND as done in
this patch doesn't make much sense -- you are asking the OSD client to
arrange for the OSD request to be resent when there is no valid OSD to
send it to (and no expectation whatsoever that the resend's invocation
of calc_target() would produce a different result).

Thanks,

                Ilya

> Subsequently, this may lead to calc_target() returning such an index as
> target osd for a (linger) request. Because the osd_state, osd_weight,
> and osd_addr arrays only contain max_osd entries (with indices 0 to
> max_osd -1), this leads to out-of-bounds accesses when trying to read
> values from these arrays.
>
> This patch fixes the issue by adding a check to calc_target() assigning
> the request to the homeless osd if the target osd index read from the
> osdmap falls outside the valid osd index range.
>
> Fixes: 63244fa123a7 ("libceph: introduce ceph_osd_request_target, calc_ta=
rget()")
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/osd_client.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index a4d3cbfd27a3..3d13226a5d1f 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1707,6 +1707,12 @@ static enum calc_target_result calc_target(struct =
ceph_osd_client *osdc,
>                 }
>         }
>
> +       if (t->osd !=3D CEPH_HOMELESS_OSD && (u32)t->osd >=3D osdc->osdma=
p->max_osd) {
> +               t->osd =3D CEPH_HOMELESS_OSD;
> +               ct_res =3D CALC_TARGET_NEED_RESEND;
> +               goto out;
> +       }
> +
>         if (unpaused || legacy_change || force_resend || split)
>                 ct_res =3D CALC_TARGET_NEED_RESEND;
>         else
> --
> 2.47.3
>
