Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E14426689
	for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 07:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311054; cv=pass; b=K7eTdTCyhIzW06P+MZUexnSb8sO4GkT/vfKFL/2nsaxNpGN39ZKwzIUn6F0kWOTeomu4qHX3lLXVmpwNy+QctH6bXk4JthOiDt/b8oomy2ESIncr+NqYRPC60Ip43slpRWn58WTT9FY7yA4fK5zBX2R1z6ZYLCB2L4DAHNMKFNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311054; c=relaxed/simple;
	bh=EgbBzmlkQIcoPCNoI3SemkOF3CHyvRau8onlFXnnfac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbJ8KXD4CDmHEzGLWISh/gk2Cy5HpbYH97Qu2nIv3S2dYGp6KoZvhM91bDDrrCKNAS8C9Ac+Ex2tl0KwMxg9lJrV6o5avjOumr6nK1xuezsZYOaEnpCG3tar6T0/HrvYl3hK0+9EQql+BULU6h/TrFQiMdSTVQtz6qQv2NshDWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p93zaxYW; arc=pass smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p93zaxYW"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-745659c70ccso185845137.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 00:44:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785311043; cv=none;
        d=google.com; s=arc-20260327;
        b=GAsKc+H+U/EERnDCrj32h2wOXgNWjeeGCdAKoL/6ImS9zBboqVX6Q0MkQbyUXdHDOm
         Wd5sYb94Sam9G3mAvatY+HxLonooLWJOttpLasRBZLtqCLgakmzJUjkIUmaZ0Nf7OsgQ
         0AtCo/1YevlRiO9w4rb0XWvHozwLOjY2JdH+3JZ2KLU7DvyenTJ0mtH/qUI1qvJ38VZ9
         WNJJF+6bBhD2hVLYOtPiDRAk9fxkXY7kuyn/xMn8PVigmaOQG3gEJRggnFfG3wi7iVg5
         KJRjengIwxSRe/VY4omaJKZAAzIj+knaxKN9guM43+xA9dvqrvyl6IWzxSgHlU9BNjkN
         1NJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U7AS2nUO6gYD6YXoROPg+SkLuQODHw4iM8B1o8jWpwQ=;
        fh=gWu0bWvlUE/jXiklbVbeqLRuMfQexPxMcQCjOml5rQI=;
        b=MJvZGWyrFM5KikBEDmq+NkB8JQzw3jhfjxGejFeX0haUvsP55848CEZ3DQWeVdvAyU
         t63kQzqyaUEK/eoij/iRMRd4iZ6X8WwULzNmnGHVCA0lXSbR2j3kkz7+yRNbCpUhHcr/
         OOP1XGmpOCIBB/R1aFe5+LdE8eRSALhwNVMjAxk0TcMP00oqGym6JFniFcaul/EZgSsD
         xgTXjk1wVni5rH1eoAcQuaN6URTwYoMal8i9+n5ZREktNhMq5jAbw5m7zZfKGao1PnlL
         UnxkVVkbII534ZIAmPN+pebUuLNDwxRLxwCcBk/xQeH7wZsEGixkQUs3MhziKraEaYGl
         OmFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311043; x=1785915843; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U7AS2nUO6gYD6YXoROPg+SkLuQODHw4iM8B1o8jWpwQ=;
        b=p93zaxYWCkU2W7UO9DYkzL+hWDkYd0tl8AynXIK5C03Kpn8wWm2p1PHk5wrt6TTPCh
         9NGOdNZkIRhfK6+Uy1iZ2L/9AxxCEQpDOzmbl4sY56gsqsv3s9OCCauKZOOIk+pOdfpV
         ktFFl+tUo2sQBjJEEO/SAxVYfoIX6H/Lg9HmNuU/7gR3YdEeSRPwguTRSLd4L3V1tNNZ
         4HMXfXYnZUHQN58uaTnRrC1dg/SukCn9/i3gB8U4awQ7ndnyfca+fjlgazW55uz9qHiP
         77HpB6ePa1fqpab2r5JUPW3ANeaDWhdc0Fl6Q8ari/MvNbX1I97x+t0pvWtJNTN9BfbQ
         GI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311043; x=1785915843;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U7AS2nUO6gYD6YXoROPg+SkLuQODHw4iM8B1o8jWpwQ=;
        b=PaPHvbtpaedsvhYjVkkT508z8EIhyUTTV8PJsO6hHsc7q8QxVi+WODms8RA0++gUIB
         rMYzvsY42rhpZ03QvPYTgiLEo4pqUi729dD9Vlp/GhUF6kas2Pkyl3M7W+4rkWM5VXMz
         EkncaHpa+oaIchHyQ9DW4S8eHLeq6pkSj21t1BRGzqm4KPeXmerPp5pSFkP2PmNQM8Q4
         08+2CnNxs8HJ/GAOcZ5kPEerIFl1T8uuyXFptenSYBfUQwXW/mjqAYD+mO0MkcgVWzvW
         20PR3hijDKaeGAGvVmMquIYLAGLMk3npfILf2HhAgHOm7Ssl6fVhEjZll8+39MU1s+UV
         N4Ag==
X-Forwarded-Encrypted: i=1; AHgh+RrIcuYPCgjW9UEeB5TH4xckGMyiqG797XyzdSLJBnd33JCKl6qnuRl0Ogz8bbRyWeGX+Tbjzt5LG87o@vger.kernel.org
X-Gm-Message-State: AOJu0YwDjTQH285QdaIeE3X9U6v3TC6vaXOebBC7qIDmsWwhC9DjrOFR
	SMAPDARgJ8RmLEdsKTuafhu6GytrF8BXz6rTNSeNgeS7IjhR5PU999NYZao0TLELjOZWTMnpIP7
	sGqz3UvhEKDeOx09qeQsOZ+NWN8Wd0FE=
X-Gm-Gg: AR+sD13ZAcbyXfT7aov1grbCZf9U3ikV5ypOtg/QoFKcuZiu+llNh2pyf6wgRjqfnrD
	fMF6vM9ZF8ITAj8Hx/1tWbu2N7SQhgKdL4V1PXM0vPaMcYhR0xtly4/O9+nbP2d4Zcs7EMEmo4c
	Y+0coc3GbDwXSJ4ulvGmaCrp9f4u8yR+lmecY3YRmmrfr5OjpMSMrQl4pAJ6JZLOnahxM17IS+N
	bZMQvGDMkrnd/ElIZqGY6/0AOA8vC6ivGPHfi8pnTYhhytHgEi5ohnJ7+P1AYXG2PnvbNFWj1rD
	XkQRoaxMynMlx/vtDigQqxQSTmvYBLLiWrR+lWiQIuNL7ZDa1jRD2XTrF7ohe1paET0raV6GHrC
	zVlV94Gn5/vM/Ig==
X-Received: by 2002:a05:6102:3ec2:b0:738:9abd:9eba with SMTP id
 ada2fe7eead31-7549f251fa7mr2405579137.4.1785311042559; Wed, 29 Jul 2026
 00:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728084340.45222-1-raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <20260728084340.45222-1-raphael.zimmer@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 29 Jul 2026 09:43:50 +0200
X-Gm-Features: AUfX_mwRGz64rQE5yBiKPXR3cxKLv68z-CQq45yH9fe7wzAePOLGfznhCKQtP0M
Message-ID: <CAOi1vP_f4xpgu2AKoVCQ48RZH7Aj9VqehUsuUMs0tuW-iqDFwQ@mail.gmail.com>
Subject: Re: [PATCH v3] libceph: Avoid using invalid osd indices from primary_temp
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 10:44=E2=80=AFAM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> A corrupted osdmap received from a Ceph monitor or OSD may contain osd
> indices in its pg_temp, primary_temp, pg_upmap, and pg_upmap_items parts
> that don't exist, i.e., that are greater than max_osd or smaller than
> CEPH_HOMELESS_OSD (-1). These indices are used to create the up and
> acting set in ceph_pg_to_up_acting_osds(), called from calc_target().
> While most of these osd indices are checked, the one from primary_temp
> is not. Subsequently, this may lead to calc_target() returning this
> (potentially invalid) index as target osd for a (linger) request.
> Because the osd_state, osd_weight, and osd_addr arrays only contain
> max_osd entries (with indices 0 to max_osd -1), this leads to
> out-of-bounds accesses when trying to read values from these arrays.
>
> This patch fixes the issue by adding a check to get_temp_osds(), so that
> only valid osd indices from primary_temp are used, and it falls back to
> using the primary from pg_temp if it is invalid.

Hi Raphael,

pg_temp and primary_temp are orthogonal -- it's valid for the PG to
have a primary_temp entry but not a pg_temp entry so it would be more
precise to say "... the primary from pg_temp or the up set ..." here.

>
> Fixes: 63244fa123a7 ("libceph: introduce ceph_osd_request_target, calc_ta=
rget()")

Even though the backport that far wouldn't be clean (and wouldn't
happen regardless), the potential for a bogus primary_temp entry to be
enacted came with support for primary_temp in commit 5e8d4d36bf23
("libceph: add support for primary_temp mappings").

> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> ---
>  net/ceph/osdmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index ed58a03b2f5d..5565de128bce 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -2815,9 +2815,10 @@ static void get_temp_osds(struct ceph_osdmap *osdm=
ap,
>                 }
>         }
>
> -       /* primary_temp? */
> +       /* primary_temp? (shouldn't ever be a nonexistent or down OSD) */
>         pg =3D lookup_pg_mapping(&osdmap->primary_temp, pgid);
> -       if (pg)
> +       if (pg && !WARN_ON_ONCE(ceph_osd_is_down(osdmap,
> +                                                pg->primary_temp.osd)))
>                 temp->primary =3D pg->primary_temp.osd;
>  }
>
> --
> 2.47.3
>

Applied with the above fixups to the changelog.

Thanks,

                Ilya
