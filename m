Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA7386559
	for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776282690; cv=pass; b=uKSuY1bSD7sgo/NPOACwuY3O8uY/9PS1hLteNl4njapewEMALPWalvU0+CrG4KkzaKmzh6IpLTGWpvNUaI8psmk3qRWBy43SfH5F+wcJhHIqlThbsoAjksVwtIYbApys89dvvlmtSQ80didM3P9yEBztduFBBo0aSQt5+34UMaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776282690; c=relaxed/simple;
	bh=/nVx6E3gg497Nv9/bQfpHUeVKSvCCRpK8bgPYmvfo0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EVyQUx5rXYv3b80gtftErrcRdlKHrPYczkUHp2XKykyEZurfoujg2G95aJozrsnALmOkgA+3JJyTzuv2FLqZjgjmTfJ5pmN3EyRVLmplPBwakzNDPnNjrakmBaxrS6V6xBF8pkyp+QXhLtNedzzi414tN8w6u/r0bcIOgf7isbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W58hKclA; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W58hKclA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso73353235e9.2
        for <ceph-devel@vger.kernel.org>; Wed, 15 Apr 2026 12:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776282686; cv=none;
        d=google.com; s=arc-20240605;
        b=AVS21CIGKVRIA94ArPMbKK7UTVf2zN+Px5Xf8DCY7AQlnJvvVYctX1NlWO4YSFJiID
         tHVQU0uk5miPyT5bSPgHPyPjE2NgRTa9bVXQX9eGAp/DBsroPwbhzbUYdUY2bqVxEJ+V
         Kk1jXCLhKrc6T7i9s2DZLQ4BEU7Q75xROm+nyRRz8LQHnFZ8JMtUGb5qOo3jGI2nYAj+
         QoOTFYTMNsEGnuqN3cuxdcIAaINDAI5uhPvnt91je/QFlcYTTHXUDg6y0D6ZLtneT7jK
         lSnHk9fD44AE3Gpqmi+/Rgi6/3ISkZROtXVDutNI8gj+ufb/Y61YCUvZkV001cpwNiez
         JyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DQbkgHnlwMLLwvpzR2KdPsBGobn/4w3Uypex23aCZPo=;
        fh=b2h/Z84pV1C8PoP8+y2Zhuu1VMobMLq2EGF6EV5nrpg=;
        b=dZNz2XGoVBOtg1vsle9z+z/iWAnhxJPdRksM6oNxSzXPsUCxSIWymF4bWBvTijDWJM
         8Vars7zH8Mi+STWzidO79Zp0vxtIlqJdhhIoFEuShVndtFvCVHRvwuVZLQ/X39XQK609
         1byi/fX1y5uCqSCKDxuuxPfyjAEyh/mXg21qIcdpiJYj3XM3BypPBKiXolCQ2hfaRVag
         nZSUdSJ1basWvVRITlPnTeFKUgmhU0XZVrvHpcCK8YC8FN7sOzUZ90MupR0dP9Qd8tSq
         H0Z7eMUk8xN5RWewK8ySsq9IimAI0TRXjHvBVEEUIgvoeor3FZFQCO1j1sgBpL4wSSHr
         eV0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776282686; x=1776887486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQbkgHnlwMLLwvpzR2KdPsBGobn/4w3Uypex23aCZPo=;
        b=W58hKclAjQCGtzyyu5seD10BU0Og0lfjWqmwVBc1OyLYv7S4U+gGZvwfckdIFyBH7W
         aqvSyJ/U3mFVSPO4VuQx5/3asbAQJ00r6yLjeFkQDdzoQ/obYScYBWFzowbpz/klQEnj
         +/leCcaKOmgKhIFyvwyJ/xPDP7PgWfErE30Jh30g6+N7vU/b7cl6VXE43I67+olN9kR9
         msJn+THRFdd2a+L2GhQJrCK14d9bvy141WzbZg/sDmkX+/cSMxqeEMsb9DuRKooAxTWX
         fcnSfYOair/wBFKyeowEloif+qkOn4+gQXwt3E9vD5bG1Y3wDOWmGrM+SYkdKFImjxOZ
         ZTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776282686; x=1776887486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DQbkgHnlwMLLwvpzR2KdPsBGobn/4w3Uypex23aCZPo=;
        b=Us++1JZUT8OC836QL2MJyMxJIZRiqP6UFwf123fpk0/jizkbvxoryfcLuvcgKKcv2P
         ernOSgCvwOBQpV1odMZLBwazKGltwGIFTAALnzdp/eZA++zhzdYc/Wohm8gEv/LNWIuU
         2axW1eh1662KFiDe4C2th+rnR9HGCPJ/4KSFz7wb2EpRuILd2QT6h3U/nXIHcmnoSOQO
         JEHbTBLj4jiO7eWYrmQoAvEiFRBXamLqkz4QjWiAIEq6Yf7fetwog8gxu4teh7ZPUSzj
         QHUFzIgbg3khzZMr+GOzwGk7AaahsO5Lflgay/7QMR3mUKCaXzWLm3cCi7iPGFp4DpcP
         AVjA==
X-Forwarded-Encrypted: i=1; AFNElJ/4Zyum9SIaOvlmesfI5hxkuKLxFrupR55aKhO95q9Y3txJyYzqehrEEhcAGK/ElW2QW+GhBYNZQz1r@vger.kernel.org
X-Gm-Message-State: AOJu0YzJG7rOlfDICXH66eSbb5e2Ku6NGAARaNVZZY/n+MKjFRuuFEr1
	vhmwP6YHCGHoMaFWQT6kwHvD3/tGOSppTr5N5q9euoFDQpYpqwU5+u2ORJ3O5cO6kakEJFmgDsh
	5RTGCr1tJDk9ERMHy/S1joLe6kzLoJeI=
X-Gm-Gg: AeBDieu8TAEgC2ObjffDVq30oj2CRjpyKef03QJ2eBdFA9D1gpD/z3sjKNmh3DKvitZ
	ImUEigTqiGrGzEzKnWqpeKoCkJywbUU5YVsK86f87bv07gfAh6AKtQBzUUDE1idwgSor4/FDDx7
	CRIO5O+MAuoyLFW4sjTbb2MVkrZZ3kOCV5jiBVSLEatxY5P8swwhctCmFCYCP8vo8b+Trk8fKed
	3iQm3vk4R61YUJRmmzaPbHPrqvDpDCPDkub0A9mOvOEryy7Ml/MzRPyvghn8N+KoD7NUuEcW+GX
	2IrbKcBIcEZ9DKZ7KB7ygGkfW6KESjdyiW8+H8XWywfsr6e2vSE=
X-Received: by 2002:a05:600c:a010:b0:486:ffa3:594 with SMTP id
 5b1f17b1804b1-488d68c2ca7mr313448445e9.23.1776282686059; Wed, 15 Apr 2026
 12:51:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415034020.11530-1-CFSworks@gmail.com> <c18a6e57671d339a179202a077130ebf1686f1ff.camel@ibm.com>
In-Reply-To: <c18a6e57671d339a179202a077130ebf1686f1ff.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 15 Apr 2026 12:51:14 -0700
X-Gm-Features: AQROBzD0OKIlw-J5hhn42P-U9J3YVvnGOv3WTYW0HIpS7g2nOSTuxDBJA2EuFAY
Message-ID: <CAH5Ym4ga7miUQE0K-cJA93Ya7w62P69MAN27R5cBiYnudoOHdA@mail.gmail.com>
Subject: Re: [RFC/BUG] Use a bounce buffer for mds client decryption
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 12:14=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Tue, 2026-04-14 at 20:40 -0700, Sam Edwards wrote:
> > Hi Ceph list,
> >
> > This is a combination RFC and bug report. I'm holding off cleaning up t=
he patch
> > until I get confirmation that this is the right approach. There are som=
e edge
> > cases stemming from complexities in ceph_fname_to_usr(), making this pa=
tch into
> > more of a shotgun bugfix than I'd like.
> >

Good day Slava,

> > I have thoroughly tested this patch:
> >
>
> Even really good testing cannot guarantee from potential bugs. :) Have yo=
u run
> xfststes/fstests regression testing suite for the patch? Without this run=
 you
> cannot say that you tested your patch good enough. :)

Not the kind of testing I meant: the next paragraph describes thorough
*soak* testing. Since this is only an RFC (lacking my Signed-off-by
and the usual QA that it implies), I'm clarifying that I have at least
made the bug go away. I do not promise an absence of regressions.

> > In my live (AArch64) environment, certain
> > workloads would trigger this particular oops->panic 3-5 times per day. =
Since I
> > applied this patch ~2 weeks ago, I get no further panics. I do not thin=
k my MDS
> > contains any base64-only dentries, however.
> >
> > ---
> >  fs/ceph/mds_client.c | 30 ++++++++++++++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index b1746273f186..a583032c0041 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -414,6 +414,9 @@ static int parse_reply_info_readdir(void **p, void =
*end,
> >  {
> >       struct ceph_mds_reply_info_parsed *info =3D &req->r_reply_info;
> >       struct ceph_client *cl =3D req->r_mdsc->fsc->client;
> > +     struct fscrypt_str bname =3D FSTR_INIT(NULL, 0);
>
> Do we really need to introduce another bname variable? Could we use oname=
 for
> the buffer?

NAK: ceph_fname_to_usr() redirects oname.name under certain conditions
(e.g. no key available), so we risk leaking the bounce buffer if we do
that.

>
> > +     struct inode *inode =3D d_inode(req->r_dentry);
> > +     struct ceph_inode_info *ci =3D ceph_inode(inode);
> >       u32 num, i =3D 0;
> >       int err;
> >
> > @@ -441,10 +444,18 @@ static int parse_reply_info_readdir(void **p, voi=
d *end,
> >               goto bad;
> >       }
> >
> > +     /*
> > +      * `p` points into the message's `front` buffer, which ceph_msg_n=
ew2()
> > +      * allocates using kvmalloc(), so the buffer may end up outside o=
f the
> > +      * kmalloc() region -- but fscript_str.name must be in that regio=
n, so
> > +      * use a bounce buffer in that case
> > +      */
> > +     if (unlikely(is_vmalloc_addr(*p)))
> > +             if ((err =3D ceph_fname_alloc_buffer(inode, &bname)))
> > +                     goto out_bad;
>
> Kernel style strongly prefers braces around the outer if body. What's abo=
ut
> this?
>
>   if (unlikely(is_vmalloc_addr(*p))) {
>       err =3D ceph_fname_alloc_buffer(inode, &bname);
>       if (err)
>           goto out_bad;
>   }

ACK

>
> > +
> >       info->dir_nr =3D num;
> >       while (num) {
> > -             struct inode *inode =3D d_inode(req->r_dentry);
> > -             struct ceph_inode_info *ci =3D ceph_inode(inode);
> >               struct ceph_mds_reply_dir_entry *rde =3D info->dir_entrie=
s + i;
> >               struct fscrypt_str tname =3D FSTR_INIT(NULL, 0);
> >               struct fscrypt_str oname =3D FSTR_INIT(NULL, 0);
> > @@ -514,6 +525,13 @@ static int parse_reply_info_readdir(void **p, void=
 *end,
> >                       oname.name =3D altname;
> >                       oname.len =3D altname_len;
> >               }
> > +
> > +             if (bname.name) {
>
> Should we have unlikely(bname.name) here?

ACK

>
> > +                     BUG_ON(oname.len > bname.len);
>
> The ceph_decode_need confirms there are enough bytes in the wire buffer, =
but
> there is no NAME_MAX check. A misbehaving or malicious MDS can set altnam=
e_len >
> NAME_MAX, so oname.len > bname.len. I believe we need to process likewise=
 error
> in more calm way. What's about this?
>
>   if (oname.len > bname.len) {
>       err =3D -EIO;
>       goto out_bad;
>   }

ACK -- with a WARN_ON_ONCE() as suggested by Alex.

>
> > +                     memcpy(bname.name, oname.name, oname.len);
> > +                     fname.ctext =3D tname.name =3D oname.name =3D bna=
me.name;
>
> For my taste, the function is complicated enough already. I believe it re=
quires
> some better refactoring.

Well this is an RFC, I'm seeking feedback on that refactoring! I agree
about the complexity. What way of writing the function would be to
your taste?

> Thanks,
> Slava.

Regards,
Sam
