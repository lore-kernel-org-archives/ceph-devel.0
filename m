Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB453845AC
	for <ceph-devel@vger.kernel.org>; Wed, 29 Apr 2026 04:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436887; cv=pass; b=bWy4CqKcPRoqtumfQj4O44x3OhvbjvayZIc1u2e3dPqM8lnqu7s08NHa4HnucV5Awb9N2NpZgeayP0pF7J2Ni/o/6nJFBMtfDBIxpE/HuL5YqLWX8v/aHECqXPSgxhxYyu70qXffTTAG6BWE+T0y8bRFEEkC0vIn007j8Z+E8Xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436887; c=relaxed/simple;
	bh=72+7CylRj1EOV6kfHwAZAuBZhDPTYvm9NqEzFA4Av7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MwgNfhS/vSe21wVUdbCTsngRucQ4wKSJcpDV/X358+a9VP7oe6JGNtK1PZZiyITgI6IL9/IyEB+GzZy0qzx4aNTskgQxJwsGh7iDUCCyZdcPhtPqX+TCTyGLl+8l0KVqTTqVGMYO/x9NeGBSZl3NrDYzXHGnxIWwzwnl64cS66Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QPOCbFHL; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QPOCbFHL"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b936331786dso1587679466b.3
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 21:28:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777436884; cv=none;
        d=google.com; s=arc-20240605;
        b=UVWIVhkcryp1boykGCoaHezMZYMFFkb9xc9dDRYYyQPm1SX29szEdIv0qGVZRvIKNd
         RqGtXym1x183exdys1O1XmSA7wAKWSdIcuMu+8Xt4VAT0BUMMyQWJh2jJ6s02V9vOmpW
         T4kz7IGZR+nvZ8m9urdezsirx48q14KqkFg1sy78a+DCGr2A6ZWkdSicX1PkuYl9vFB9
         jO67omeJyj45ae5Kzzg7qggH0Uk1RKfNTKj/YIZKd/Wsjql3HRLzzGU7FKgPi/K+m67G
         hAVkE0r+jK7wT3SiU8jVguMRnWtoOpBeF8Fs96H/Hhsgz2ZzmaLny6nYYzoWZ717RIwm
         X6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tCgZRNaYmJSPykbMYrzfut5EXQOeSzWA5g56k7ae8hM=;
        fh=1Ym4w/+XfwuTABTzL9Sz7FEV6/H+TaCuzGdoOFuIhxY=;
        b=V5PASQGaehBgcJ2I/Mwd5sWFHgg1VM6Jy622DqdqMs1XfBHORWGnaB8Zc2lXPHLBDr
         DMATUDslV+3lmp7JUBAKchUM4ZRrxAl8DZtN4hlVw5XJ8z/QdpxHmTbn3MlmMakSfeWE
         g28eGHEG+PKBUdNo0lq6nozC6j3nMvN918XIxEmQmzXcj5CJzTaT2qnrKTeGd3t6Kqk9
         o7POY/27cy4NChBzsV09VfqO9qMqW/jgak43TiTs4Lj/m9XnRc30J+JqhL+bCzKTFs7Y
         lYHXxKzwmhirQiNgJK8h44wxGHqPkuJMN19k6QwMAjamo28czh56FQ/Hl4mbiMq6oCIy
         Sv/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777436884; x=1778041684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCgZRNaYmJSPykbMYrzfut5EXQOeSzWA5g56k7ae8hM=;
        b=QPOCbFHL+hCKbFJZZzmvsJWBKOQ9HleIL/ikkGKNCELU6xE+PZHvziq9KjcV3LFG2A
         aIG6Q934jpq0WizSVeJ9a7/vrOhlG/9fiXSZlzLgKuYEYdCDiO7yUrnklQd3wdH5uxml
         9d0/idR01MevpqPVgSdwNrZV+vlswZADkUfGivAmjUKiOf2dFHu9i0cFBIobFdbXstE0
         Dm89OB85c1SCGJuKLJi2olsIV819inldUC/uXRKdbWfzdUg44lWciH/zp8f2CNS+4X0V
         IIxddkIi/O/zelAERV1THgyxl7vn5oZXpql2RrIXHmM81KOBE9Dq76vkMkAXT5jiKDzD
         sgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777436884; x=1778041684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tCgZRNaYmJSPykbMYrzfut5EXQOeSzWA5g56k7ae8hM=;
        b=afHlvW1GqMe0hndeZhVxrybN4vJSNOWc7SKk2BY4qWEgRbe0O4O/7xIZQTdJZuSk19
         Stbt9xjgWg/fIQImHDse17oswTU19Oh9G56dSnjiTwr1nuvETvWOy86BN2jtwuyInXUd
         bGaUSMz6ddUUUvizn7o+UfNM4QcVACK25AdHZLKr3VyX8fZYqflJlBiIvep6UpdNcYRk
         dV4+Z8DyU03DbIvBBiFMqkWctv6kpdhzh3QMtXSdWV5bITCe7Z02a5iDy08kaIifGiuF
         q+H6a8KFeyacDXcv2T2fM4w9CZf1h0O93joNdAI0OqWHc8woefkLqtpGQl8vUbbPd1V4
         A4Tg==
X-Forwarded-Encrypted: i=1; AFNElJ8DOUsa7ieCV7pMVPs4B1o0V8wXuID63KY3sdGyPlgxxycrpJ/EOXdx5DxoDK59wxK7nVYe65GBZraC@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCNMx6RFcg3T1pcDPwNdWikkaPNGxtuuhN+y+MkXV6cwRibho
	5n/jt0Mt7Z7IB9aVFGHkD+QuKUDl6j1v4kKAGdEa+NOkrr9Gbj7zJ5gH5lgUO73/+z9/m3jCiba
	8XpRXJLvVARDiiFdFF2u/Nfu4727N37Kyh1e7MeC8hw==
X-Gm-Gg: AeBDietqR2MLrFv6FLVwDrGhuBsWoM32UsWyDnTcHjfOtVeHQd/+y7VC4tVgk0kHIBM
	Xj64Rdzh8BDxYwJzze9+JalpJAKwtgnSh9wB0kNE2p8b8PsbTBV/YO8ZFF2MQmzhAc6CKNTiff8
	Wfw1SQxAE5pKQleMromDNgLhsBCU2GjcIdags+AQ2jySxW/PkCqSjFD24/fSub4t3S299p9lixT
	WgA6l4qItDyE+SOwZT3poa1eydKPHA9Ie0jz2RmHu76dDCcFgG4I355SnJ8D3EnAq9BnsgGPAP/
	jshT3dQMU7KXTXRY5zsa9js/jzxmU4chaWqmrNpfDY666PA=
X-Received: by 2002:a17:907:c012:b0:bb7:47cc:1341 with SMTP id
 a640c23a62f3a-bb8022c2be8mr360275766b.14.1777436883779; Tue, 28 Apr 2026
 21:28:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427155813.2561935-1-max.kellermann@ionos.com> <b7827e38e2e4b87aa92261e1f02a7b7340f8d0e0.camel@ibm.com>
In-Reply-To: <b7827e38e2e4b87aa92261e1f02a7b7340f8d0e0.camel@ibm.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 29 Apr 2026 06:27:52 +0200
X-Gm-Features: AVHnY4ImG3SgvI4nLDqhi9ljovV8DFkO-2VusdikC_-9zaWiQed6HkWfv8K2t2s
Message-ID: <CAKPOu+8Yumexe=Athx_fjtoNbTBgP2ENQrXx=idmkNeUwE9v4w@mail.gmail.com>
Subject: Re: [PATCH] ceph: fix hanging __ceph_get_caps() with stale `mds_wanted`
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 8:46=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> >                       flags |=3D NON_BLOCKING;
> >                       while (!(ret =3D try_get_cap_refs(inode, need, wa=
nt,
> >                                                       endoff, flags, &_=
got))) {
> > +                             static const unsigned long wait_timeout =
=3D 5 * HZ;
>
> Why exactly 5 * HZ? What is the basis for this timeout? Could we re-use a=
ny
> available timeouts in CephFS declarations?

It is an arbitrary timeout, long enough to avoid unnecessary wakeups
in regular situations where we're really waiting for a capability, but
short enough to avoid disrupting the service. If you prefer another
number, say it, and I'll change it.

On our servers, this hang bug occurs very rarely. Sometimes, weeks go
by without a hang, and sometimes twice a day, but no more. When it
happens, I thought it's fine to wait 5 seconds before attempting to
recover.

Note that this is still a minimal workaround, not a proper fix, as I
wrote. The proper fix would be much more intrusive (and of course go
without any hard-coded timeouts and arbitrary wakeups).

> >                       if (ret =3D=3D -EUCLEAN) {
> > -                             /* session was killed, try renew caps */
> > -                             ret =3D ceph_renew_caps(inode, flags);
> > +                             /* session was killed or a waited cap
> > +                              * request needs a retry */
> > +                             ret =3D ceph_renew_caps(inode, flags & CE=
PH_FILE_MODE_MASK);
>
> Frankly speaking, I don't quite follow why do we need to add flags &
> CEPH_FILE_MODE_MASK?

Oh, this is an unrelated fix.  This "flags" variable contains internal
flags that are not understood by ceph_renew_caps() (i.e.
CHECK_FILELOCK and NON_BLOCKING) and shouldn't really be passed there.

I'll remove that change from the patch for v2 because while I believe
it's correct, it has nothing to do with this bug.  I'll post v2 when
we agree on the rest of the patch.

--=20
Max Kellermann
Principal Architect
Hosting Technology

cm4all | Im Mediapark 6a | 50670 K=C3=B6ln | Germany
General information about the company can be found here:
https://www.cm4all.com/impressum
A member of the IONOS Group
