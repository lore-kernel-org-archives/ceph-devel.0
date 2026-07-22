Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D053FA5CC
	for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2026 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784753355; cv=pass; b=PR+94AXzSN3GLHrKDkMVPHJ7pYlsvYOHL8IE5z+6uCEWOyMQ8HIKFpOvImA6gP9e8m/TykAefVJTICXunQW3zI75RF92bTM8zTfdqx++3XKVBNHOaiJ/RFyKUP96LZv44eHy66z2csxzskaYPz//RtDN0DGZy12TW2GB46kJPqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784753355; c=relaxed/simple;
	bh=PJme2lLv95Ftg2V8ES9ixno9n1KRIqayvGWyRAKmOwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pibvOqkRtZDYOUAAmmHRxZPLgG6iVs2hPlI4f0xdy2Vy42XQBc56bIdiDwjCS0pxppmVJGFnG3Bwb22wF8rWXbGPZ2W89qgcMaPzGm73r18WONcrL7ICDdIMrs5SMWYPuc2NxEpmgt9jggd54DRhlHnal8NocOocJPxKqptMpKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt400/te; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt400/te"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-7389cff36bdso3345386137.1
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2026 13:49:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784753351; cv=none;
        d=google.com; s=arc-20260327;
        b=gZWKCBNWxyNmhutyZo7P41az6APjv1ao3jPWe2EYusGnfF4ecCCNnWATHCqhDakRxV
         hJdYM/3wNjcgZq6ymu2lAUcLCsLTThmFHJiE9juFhGj5GBJT0qkmO/n/Wmzm6aOIjmhB
         GrWuQuY1iKzuXD4+yr8fbIO5ncHfHwIKL72DpAMYtwstSt1tyg06lxc8VvThIXCF90IP
         MqarezKUaOwSB/W3779aQASAujYNo5jhAJfy+QKlh7krBglMSRy9ioi/olnhsdwuBb0n
         YUDLrAmMwsgTqDh/00oGeTZsYAteyklDkIxTM+aayazDYKsNi+hreLn7cAKAWDL/vUic
         uakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g/ljcjZEOD0T6/4V84cGOIPc/XOazKvCrVewIXSU0is=;
        fh=/wG0XL29D5uCt2M5iiFEskVxq9lvZ5jlB8CkDgVIc3U=;
        b=BKP61MAlo/RcQbJzBg5LMvX79m9dekxySn3WrzkezrNT6CTlZKoYW2SUZ0xtjBvVYJ
         LLNIe3CkRpPF1IlcjFBQx6uwlFI5dWB94DFx5n8o+PPQ+BgK88t2jBH4/N/Zk/1ZPlQs
         E8BWIOyiGTojoC2C8pGv/bTJzE37F07J9S/Vx0FyEBAB/V/uy6/HdLlSHG1a2m8agRiU
         n1ZFSk7GNYIS+3OKFCA6WqEylOc+/ysLHzJhJOKUUE/seDrIgVHmNZuND1kPV+qYjk3F
         u1l8zWT5aP2v4tDhi3kg7MsVdNIg530QdD4CAiieQ/u3C/BoOnAZcf3u9GbHADLua8yM
         gVSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784753351; x=1785358151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=g/ljcjZEOD0T6/4V84cGOIPc/XOazKvCrVewIXSU0is=;
        b=Wt400/tedipDWMh72NN1JonsXM6zev0GG5DWQZB24MVna9FdUphuatD0aIhA7JTSGH
         YLRxLDhQsGtBrStuSy0XGtj/6/uKQRSM32XLp9yUyycZ9/w2ZbMNC2W1qosifA3n2M57
         upoY+vqUk7/1ZlN5zYuyN6vlxggXW2H/VxXhcZoW3dlUNnh0VVLSVOaFPDGNTMVi/Rxl
         G+K5buuAyv5FYOK/7BiVMnacbZfFLhzl+hcw6dttMehLDoL+wrFogiztktoha2MHL1pF
         VhS6q3LhTQLHI0Fra8t2gNzg49sjWaz6G6pRWApB2oFDyT9IbaOEd4C+WwUCPVQ5JKQj
         46uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784753351; x=1785358151;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g/ljcjZEOD0T6/4V84cGOIPc/XOazKvCrVewIXSU0is=;
        b=looxIAegf+a42M5PbbODaR16klG/49ycMjr3noo0aIrNaNovIYcW206FM9z+zPQ8+V
         8sFvmdaDWdQkW4RH/uY+lrhWDvD4mDce+Ujib1zaPczLV4x9SEhrGGKLkmm0dBazIQhq
         cph+MqGO/2xuYFqh6+u90KMTXwoNsB0g7G+o/qKAP05P1N1rEttQHsxw+iSPyCyovYUM
         XfGTpq/3K26aWHZ4J4u9W6LjbJBdURTUDf30db0BD3KXGrULQ1TUlTPbusCn1nA4DYIu
         CkX0CfgWuVhp+A8K0hr4g64n7fJ5K29/cL/WjxZlwxL2z2tNA13K+sramjBrOak/Sw0X
         ty+g==
X-Forwarded-Encrypted: i=1; AHgh+RryuzHeiqvWhu4kohbvHwih63ERXP26Jj4xpNP3L/gccV5n38XXpMddAphcszSerVV8Q2/riVGfp0S6@vger.kernel.org
X-Gm-Message-State: AOJu0YyjhsYIJnFfrQgW/QkB0bD8Z6gBuqg3YUALtrO7sAFUCgV/OUxT
	yN32a4fQrMlftTeqrlum/kJybzTK6D/yUdjvo6pjn0mOENqeqMzXA8ezMFpnSw552KIcc32XeqT
	qF5s8kcmjfS8j3C/Kkq3OqGU3XxwDGPU=
X-Gm-Gg: AR+sD11gCG6pxPr+zcT/p3d/DptClSc1WuCImTY+qb4U7/yAQSFMFjSFjsjCr9i/LAZ
	wlKgRt0hcgQKIyJW0UYvMZAsQ1oWjWSTHW0ldpqXEYqdppEHy5dXteXSLoDDQ8gzSVcXX9VURzV
	ov0jv8+BEMjjo2fTLzF62TBBJf+G2qmOXbIOyBBU2aK5UNsKm97YDZ9lhjVC/qD1Qr5jC5b1S/w
	IdVMrtstom7TcJ1fn9jqBeNo4oJcp//pzXUnaeD4vXypB3nDpuyLgjys0Dzc3osGJkrI7jL1Lip
	ug/xaSBIDFhIDFEzgME=
X-Received: by 2002:a05:6102:4191:b0:737:fce1:3277 with SMTP id
 ada2fe7eead31-74d60a2694amr30494137.26.1784753350742; Wed, 22 Jul 2026
 13:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529074257.3707361-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260529074257.3707361-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 22 Jul 2026 22:48:57 +0200
X-Gm-Features: AUfX_mzzETBS3DBJsmq8U6Fzqlzck--240jisfrUbeT1TvygmVvshxularSVjaw
Message-ID: <CAOi1vP_M=S4ob92+tR9f+9foNPX9rFjZqZJFyzLaF5xRdSq2Gw@mail.gmail.com>
Subject: Re: [PATCH v3] libceph: Reject monmaps advertising zero monitors
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 9:43=E2=80=AFAM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> A message of type CEPH_MSG_MON_MAP contains a monmap that is sent from a
> monitor to the client. This monmap contains information about the
> existing monitors in the cluster. Currently, a monmap indicating that
> there are zero monitors in the cluster is treated as valid. However, it
> is impossible to have zero monitors in the cluster and still receive a
> valid monmap from a monitor. Therefore, such a monmap must be corrupted
> and should be treated as invalid. Furthermore, a monmap with a monitor
> count of zero can subsequently crash the client when attempting to open
> a session with a monitor in __open_session(). This happens because the
> "BUG_ON(monc->monmap->num_mon < 1)" assertion in pick_new_mon() is
> triggered.
>
> This patch extends a check in ceph_monmap_decode() to also reject
> arriving mon_maps with num_mon =3D=3D 0 rather than only with
> num_mon > CEPH_MAX_MON. Additionally, a log output is added for unusual
> values of num_mon.
>
> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/mon_client.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index d2cdc8ee3155..33eb4baa5a10 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -114,9 +114,13 @@ static struct ceph_monmap *ceph_monmap_decode(void *=
*p, void *end, bool msgr2)
>
>         dout("%s fsid %pU epoch %u num_mon %u\n", __func__, &fsid, epoch,
>              num_mon);
> -       if (num_mon > CEPH_MAX_MON)
> +       if (num_mon =3D=3D 0 || num_mon > CEPH_MAX_MON)
>                 goto e_inval;
>
> +       if (num_mon =3D=3D 1 || (num_mon & 1) =3D=3D 0)
> +               pr_notice_ratelimited("received monmap with unusual num_m=
on %u\n",
> +                                     num_mon);
> +
>         monmap =3D kmalloc_flex(*monmap, mon_inst, num_mon, GFP_NOIO);
>         if (!monmap) {
>                 ret =3D -ENOMEM;
> --
> 2.47.3
>

Hi Raphael,

I have staged this patch without the "Additionally, a log output is
added for unusual values of num_mon" bit (so essentially v1 with the
order of num_mon checks reversed as suggested by Slava).  Many toy or
short-lived development setups have just one monitor and in general
I don't think the client has any business second guessing the cluster
operator's decisions as to the number of monitors or anything similar
such as OSD failure domains, etc.  Zero monitors is clearly invalid,
anything else (up to CEPH_MAX_MON) the client can digest.

Thanks,

                Ilya
