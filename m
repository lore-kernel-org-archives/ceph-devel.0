Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C4F35C193
	for <ceph-devel@vger.kernel.org>; Fri,  3 Apr 2026 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775199152; cv=pass; b=pcBG+sZzmEhXw5UNsaTzSHsOIAoP6++s9ZBhLxUox9Pk302SAesQ40vQ7+NBi8naaxZBJLeZBYnaqfrlf8iPtaVuSZZUeZ9Wxwze7xiD3Cnn3BkCTjSF9Rw5C8xh4yk3wqwb3uzudYrKCLKn+UXuSU+OAqRQFqyo4jEVn00p4FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775199152; c=relaxed/simple;
	bh=bS9Dm9mhURUVbT1hegVPADxmmEiYALh89sOuz/kJvow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKOM66v1rbp1ZOQbjlpJZLSa0TnP8NgMISpn0Mwqf57OfVhF4kWqEb4RqNVQ3dVCHM/qcvUrlVI56MfcDLxTDZ1tALPrVelTKM9XYmUePJb9Pu2xraNbWXQF/if+2I3kfkWru8FqwgTz3NnXbNStjyrDp2yzQ4/7L0pk6ulAyQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Mp5vOqTO; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Mp5vOqTO"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8d7f22d405so247230266b.0
        for <ceph-devel@vger.kernel.org>; Thu, 02 Apr 2026 23:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775199147; cv=none;
        d=google.com; s=arc-20240605;
        b=NklIek4V0D4SzCKAKRgYEiO6hXqarjW5slUqTlWb38kYC+C8hW6G28R0tzrMSZp5QN
         FfaASZ2+H3LgNXzvaXKxRdOlaIrqZmoSw4Hw1WnzfMd7LWabCQXd6NCsZdXd85ZM1+1M
         e7vpOxeoylLBEfUTDXVX/SJQl/is8gtj0KMkP63ewQaC5DrOIQdLVLQvIRu6by+XKlO1
         H8zSQ27xmoopUu3JvXdGiVAyx6J5W+79Tb5Cw/Nseb8cupikvtZXwvCKErMAbMD22cYl
         O0bZKv/SXGJ/vUY1y7Xhb7djxhDfb8TCLYqxed7abMQmBhoy4fTXKo8UbFUZrfrAVwHR
         CwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ju9ObbxxlTtmCQnctGQWBR1tyuAT12uiexHbbrJ0zf8=;
        fh=O0Wsr1QXCLsX+9awyhnAkxvF/HIvivAuW50gfTvm64A=;
        b=F50dqIoXp09/s7FzMMHU0ANFziY1pnCoqYInbYAqxFpNCOIl8O9gbAUe7rC5FsbUJc
         tM3Yx4ynOvz7WY3Wv49BgzbPZds7lQXWcfKgeMee4EOE8RGgTavucut0rNqPtPbnSYMH
         0Y1IQTFzp2rkRvh6kQ48cKABQ5e2sWOsoLmDmVrZ4y6Xy2HnR+01mqMX7SsLczC+l1Pb
         i3H74k8YkZk54uj9ojxlfust4oqM1gI+dTVjPkUa1B5FcRX2d7MsMtugzTS1Ida8u8v/
         0X4u+k1Ck+IZAaUoDzXcpNPO3VjKPB9dzq3p1M7adNHPnchMfyVE+kIxM4/Jp7E7lk2w
         SM/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1775199147; x=1775803947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju9ObbxxlTtmCQnctGQWBR1tyuAT12uiexHbbrJ0zf8=;
        b=Mp5vOqTOyiVT2m5bItVFj7s8qfyonWlgwwALepzTddEVQR8UjCd+zIbbFiNqmnNUEY
         o1AcpIlNdqHhzNUZbQG78E3lYrZ6KvEmcBB7/iXwIF5MOGpaeOVrGRgQjOZGsRpBS13k
         7DpBJT6zpna+qUXpziTReEXXyGjaHFH0XgKq1oQ6MfYS75EyJWzwCfqVoo122lXJV7pE
         fccczniEtPAA7Cj2Xud8Gbd4rjd58AFFSw8nzRDev2MRg9NVWkg8czD3QjYZvsD/yTIe
         iI1DgFQLFfmmR0YLxigQf4n0B7zdCwFCzAyKz7GG9w0Z3FtZ/e4H41qX9YBiXXpBWObR
         rN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775199147; x=1775803947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ju9ObbxxlTtmCQnctGQWBR1tyuAT12uiexHbbrJ0zf8=;
        b=CXUBmb5w1XMsyUk77BlNb3Cezf/Ht/2TiFbUf/5bTjU+OQfl2kdU+pDjjwLLk7IFl1
         2lgXwHR0YCfDI44lMA6qPEWwfVT+3YSb3H6w9ISspRIdQ+bi1CmJNBtFxdnKVNBVDfFr
         lxYAP6/uRv/b0o4EHOLAycmNBH1jVHw9SPhOHWun5d76fpx166jvtKg42N6T15YX6KSI
         zlVP/9BcAEqVG9pl6Nz8ihxBFd6/ZMSRGP8MU29QYMGnDMwpvw5/wwyXF953YwPqxCGZ
         ieTDYsGuYBFHmSy5Pq16WNG31RPfb/iqK+JB5jHjMeaxNPtEI9YsutXN3CCSdueqGrYP
         WtWg==
X-Forwarded-Encrypted: i=1; AJvYcCUYtf4H+OroBTqOEGM3Yj8UuByZSZMdj3n4nUDEbwp8KUapO/vfd8dAeV3WruBeNw6zz31ihQ0r55vA@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHNLInqh34/ZYMaucovQuM4m8R9qebEU0H0IY39BUqqMy1cLf
	gHNlOGz2J06fbbPr3pMIFGCdIcKwLLvuTUrpn+cZU8S1HQivgzRwGwtkIa5Zpe3ztg3Q+4vxpTh
	HfDxfGVLpIy1amCgp20OqL2V4763MaJzqwTozElnzzA==
X-Gm-Gg: ATEYQzxDv7CacsAs0epTouE+guADdHfWdNeKnCnZVX478oni0B5ok8I4J1mEmUaBuY4
	ETl9qJWbXkdN0UTKW6XVsNuCrfrP3ynihKbo2cVal11RZj/q3caNWgb90tSij8ZJtiTjFLiwQ2H
	8rodAq20pPmZJC5aCs/ICOKoE1hhVyHQvuuov7UU2tIPlPkEWI7Ah+pZ6kWIYuRMcCvCA7G/50g
	9zLWkEJxmoKZypUF0xz9N+krEpDw6QMz9R/ufwtv/LeFJu8xGThBHO8yvVsd246sZDG9sBYl3Qp
	0tZkDeW7WmNkl04IlH9RUVzVSgY6aQYNOf95
X-Received: by 2002:a17:907:9705:b0:b98:13de:a16 with SMTP id
 a640c23a62f3a-b9c67a10a98mr105360466b.39.1775199147467; Thu, 02 Apr 2026
 23:52:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401205613.2095623-1-max.kellermann@ionos.com> <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
In-Reply-To: <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 3 Apr 2026 08:52:15 +0200
X-Gm-Features: AQROBzAb2FJMqz47kp_fUlVSscz-fuNH21mTcT0GdyVezs8Qc3TsiivUaE4x7DA
Message-ID: <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com>
Subject: Re: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 9:44=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redhat.=
com> wrote:
> The Ceph write_begin path calls netfs_write_begin() but does not pass
> IOCB_DONTCACHE through to trigger __folio_set_dropbehind. So,
> folio_test_dropbehind() would never be true on the Ceph write path right =
now.
> Does it make sense?

Yes, see:

> > ---
> > Note: this is an additional feature on top of my Ceph-DONTCACHE patch,
> > see https://lore.kernel.org/ceph-devel/20260401053109.1861724-1-max.kel=
lermann@ionos.com/

The code in this patch is not reachable until my RWF_DONTCACHE patch
is merged as well.

> Are you sure that caching should be always true? All other calls checks t=
hat
> ceph_is_cache_enabled():
>
> bool caching =3D ceph_is_cache_enabled(inode);

This function is only called if caching is enabled.

>
> > +     *len =3D 0;
> > +}
>
>
> The ceph_folio_is_cacheable() and ceph_flush_fscache_write() are out of
> CONFIG_CEPH_FSCACHE. It doesn't look right.

All of the old code is out of CONFIG_CEPH_FSCACHE, too. Does the old
code look right?

> > @@ -1412,11 +1427,14 @@ int ceph_submit_write(struct address_space *map=
ping,
> >       bool caching =3D ceph_is_cache_enabled(inode);
> >       u64 offset;
> >       u64 len;
> > +     u64 cache_offset, cache_len;
>
> Why do you need to introduce the cache_offset and cache_len? We already h=
ave
> offset and len.

These keep track of the region that should be submitted to fscache.
Folios without "dropbehind" need to be excluded from that.

> >  new_request:
> >       offset =3D ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
> >       len =3D ceph_wbc->wsize;
> > +     cache_offset =3D 0;
>
> Is it correct initialization? Frankly speaking, I don't quite follow why =
we need
> such initialization.

Technically, cache_offset does not need to be initialized as long as
cache_len is zero because then its value is never used. Would you feel
more comfortable if I remove the unnecessary initializer? I wasn't
sure which approach would raise fewer eyebrows.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
