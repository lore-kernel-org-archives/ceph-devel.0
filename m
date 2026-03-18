Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5331E89C
	for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852690; cv=pass; b=pvNRp+MKJoV1umVnMmr9oVxsuqOagoL8Pink66kfl+3hz8lf0qiKl33TNdRHURkARCyP6PHCzi5wrxbdpdzW9IxZJJ8Ks0EhkKxlvFiLM5u5mygLu7uIkwzv1Sjs3GvQy4nT9ZfIB3UExr4i4D7vu0hZXcZ/+TyMwqOPiRvZCso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852690; c=relaxed/simple;
	bh=JzwQI4ZyWe7YoKxHcB10TzRpADxXvESYckPoCW9myM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rn7qG4DAlgW4+o2LWEsD9k/Ksnr1Zl2N5MZSxmCelVeEtN/tejrr1fe2ulAy9o+JcL/ji0ubmz03Teq9pwB1TCkTnAyxuqv21CIwbx4QfdQR0O3f+CNYtnNouum+8uAnzBswoqzhBdX44g2CW+8Bb48hYrQ1HZXuhFS6obAWWMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYmQOOjC; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYmQOOjC"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-127380532eeso132585c88.1
        for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2026 09:51:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773852688; cv=none;
        d=google.com; s=arc-20240605;
        b=GgCHCvCW5B95fVKbfigthLn4CnQLLjaOI5PCiGbXjeJpjVVn9iN5lMjic4iOF7vdbV
         LA/VCW3feeyVKntXv8xbs3bI0EXQFGEjPLu8Dc1DQDBkFHsXCZeeBADQVZfpKSLtaqDI
         /p7eicCaZQtKmGcSBkGB48JSrSSkQnvwJbdADusXoetMv6MyrhKuKLGeOHXv7y7yCZOb
         558nQbQbjD+5qLBr9zIeQY37NK8+Pg0PSvwc09GAI66jC7DSBYwVMCPvJbx9Jl3Rifgi
         i97Ftj5oy/KxEqdweGowcRo0RFed6i4IjbbjOwnK7892YLl1t/lORLmqi6h7DHYedNAs
         TdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kEyPBpBFnKMokhWu7Px+aFVfkd/KB2MBUBtT2snz3F0=;
        fh=zdvUWoX1rbTs+6QiUu7W71yQTVe8Tpqns0kpls/9III=;
        b=k8JMJo6E9TOL/O/PmtRYzYItcOLQoIpJcNei9nQBs/zpgLWS5z/Ie+Ju7rEVyOht3f
         tIUVO3MwPk+cQZs3AgSdj0T9kOME1fGtc1SlQIUPGlpJ2yzCp4pvR/dtHQQbs+4KrbU6
         nxmV0Idh5b8wHMr4csuW3IjNryBvZya7te/qi3bQlYA2lebMR3aitOPUAB/GMIgCebpU
         hmdAGzKwqO8PK9eBBFx8RtEtZd4Mp70qbVmevTq+L8mYosq+vkWj8i9rtU5Lrqk6A7Eo
         Rj10gJbvwiCz2dwPWWqcySJfZJNfAfWKMSskFGjOy7+DxlT5PH/N9Xg8PIBLua9Kh3Sy
         OKAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773852688; x=1774457488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kEyPBpBFnKMokhWu7Px+aFVfkd/KB2MBUBtT2snz3F0=;
        b=BYmQOOjCb6NoknxBwBpwxmJvparxqKCwzYjMV6OdBZlBJDmSO+aFkz5eqA/27UAfEK
         gGXnD2q4vnmPDNmD7PTZN1CAvf/A4Mit/EnF4EmMqzqNrltHI4wW2lvlqSd4B1fNGqkr
         ZG8A0L2fLbW6tKkk3qkhx8v1sBWjz2WPwdjVX1Xww52i4o+9U6iif7h1pFK+7XBdwepa
         czZXB8Qqre38E3J/fHHOrrpsmYm1eDvKEMgw7eEtzCe4mm3vxkCOOjXJGkgj8hy6nuvF
         g9l/riag81lOrzOA9KtMxkd4wdOrFoX2AK1V4QfBTrhPIG8+VsQ0szrXqr/WWmeCHrgv
         p0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773852688; x=1774457488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kEyPBpBFnKMokhWu7Px+aFVfkd/KB2MBUBtT2snz3F0=;
        b=nS3CwEPdDLBj7GCbu9X0gBskReM/pmjZ4xU2JETAAynz/0QbEXoL5MDsonZJWHCIRP
         A8Aj3Rbs4fpwAqRaAvo469hCKCFB04EtnRF9W7/ZshrnAJrnTlgRj57MQ/fmoMc2/ico
         MFcIUSwGw3PPuq2r1jXo7xEVuZ5nJfELqYXPWHcORIn0rPHsOWSzg6C6d4E+O7umM/zg
         Y+He6yjDRwz5VAdOqg60jX+Px8D3rFexZbJvVly1WRn+Y1ocuENDTYzwPGTHpAftoGSb
         aTE7oy16KE3/S3H6hJEalzTQ9UWxGMLh+8Mqx00DDdVZq+BuMRZv+HI8FogqysbWcMxO
         wmEg==
X-Forwarded-Encrypted: i=1; AJvYcCXYtORS0ShLLEU+NDpqDhsaLJvpFQuNt7hv4Mx2jaM90eT8AR7Uwee07slFVbyPXtr0d1ndZ399maF+@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+DKR7ocrsAdlUUO2eX5iDVU9YxcWBSY4pOOjsUI4fvw2wn5F
	cl6U1uHwmO8KJ27MexcrwfR9pgu7AcQiZ7XTEW9tXnHMd7ZPcmbRGK3z/2xCH0EZwFoSU3czjk7
	zhqF91yKLULJ6idB5i7f2FkyZj+EhJ48=
X-Gm-Gg: ATEYQzyr5h1v1nmNG7c6Bj9xhQvBC8rB5iyYdFZuveOaExu+FC+XXuBegCbbt6swNXA
	jJcRJUgKftzKQgaXk2Pw5lN/74j5hwf/ICtrwkquKnMVHZefPVc6ZptQzlQEE60ekcP5fs4KkkO
	3CP42Jtj0eHOZo6Br3yghIP1rGE8OJ5/MF+pdMUcAF6ZBIiqaxlId3C8QPFisgQtba8u5VvdbRZ
	UnBy9uJBLUiaJjhLfBb+Klc2lPyzDQcOi9jgv7OL6ljxpYT+fELikEMHcWDapSgYHYZ+B91Fpam
	EfQ55arWYoVivVwKsQ==
X-Received: by 2002:a05:7022:924:b0:11b:bf3f:5240 with SMTP id
 a92af1059eb24-1299ba118c6mr2288859c88.9.1773852688093; Wed, 18 Mar 2026
 09:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318113256.810478-1-raphael.zimmer@tu-ilmenau.de>
 <CAOi1vP-Cpwi7=KnU4UwjOnAYNSWCw3sisM=tCc6UQ2aVxoVsvQ@mail.gmail.com> <15d2c123-888e-4cf6-a242-3d69d98b8a2e@tu-ilmenau.de>
In-Reply-To: <15d2c123-888e-4cf6-a242-3d69d98b8a2e@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 18 Mar 2026 17:51:16 +0100
X-Gm-Features: AaiRm5047CresSArOLddoxpKZ85ryrs4Lju4JnbwJfI2M59-UmtU-429gZQ_dAA
Message-ID: <CAOi1vP86oPGypSJoRjpV9MegQupNhGH2K-=i28hVSuoYk4wdJg@mail.gmail.com>
Subject: Re: [PATCH] libceph: Prevent potential null-ptr-deref in ceph_handle_auth_reply()
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 5:48=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> On 18.03.26 5:13 PM, Ilya Dryomov wrote:
> > On Wed, Mar 18, 2026 at 12:33=E2=80=AFPM Raphael Zimmer
> > <raphael.zimmer@tu-ilmenau.de> wrote:
> >>
> >> If a message of type CEPH_MSG_AUTH_REPLY contains a zero value for bot=
h
> >> protocol and result, this is currently not treated as an error. In cas=
e
> >> of ac->negotiating =3D=3D true and ac->protocol > 0, this leads to set=
ting
> >> ac->protocol =3D 0 and ac->ops =3D NULL. Thereafter, the check for
> >> ac->protocol !=3D protocol returns false, and init_protocol() is not
> >> called. Subsequently, ac->ops->handle_reply() is called, which leads t=
o
> >> a null pointer dereference, because ac->ops is still NULL.
> >>
> >> This patch adds an additional check to the logic for auth protocol
> >> negotiation in ceph_handle_auth_reply(), that treats a
> >> CEPH_MSG_AUTH_REPLY message with protocol set to zero as invalid if th=
e
> >> result code is >=3D 0.
> >>
> >> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> >> ---
> >>  net/ceph/auth.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
> >> index 901b93530b21..d97f50d38022 100644
> >> --- a/net/ceph/auth.c
> >> +++ b/net/ceph/auth.c
> >> @@ -238,6 +238,9 @@ int ceph_handle_auth_reply(struct ceph_auth_client=
 *ac,
> >>                 if (!protocol && result < 0) {
> >>                         ret =3D result;
> >>                         goto out;
> >> +               } else if (!protocol) {
> >> +                       /* protocol unknown, but no error given? */
> >> +                       goto bad;
> >
> > Hi Raphael,
> >
> > Jumping to bad would emit "failed to decode auth msg" error, which
> > seems somewhat misleading since this isn't a classic decoding error
> > like a short buffer or similar.  How about changing
> >
> >     if (ac->protocol !=3D protocol) {
> >
> > to
> >
> >     if (!ac->ops) {
> >
> > instead?  This way "bad auth protocol ..." error would be emitted.
> >
> > Thanks,
> >
> >                 Ilya
>
> Hi Ilya,
> I see the point. Changing the check to "if (!ac->ops)" would work, but
> in my opinion, it isn't obvious what is meant when reading it. I would
> suggest changing this line to
>         if (!ac->protocol) {
> instead. This would lead to the same behavior while making it easier to
> follow the reasoning when reading the code.

Sure, if (!ac->protocol) { is fine with me.

Thanks,

                Ilya
