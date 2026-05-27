Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D16A4611E8
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 18:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905182; cv=pass; b=FoLmpk+PyG5/KDT88Aqs+USElUw1tmwo0LZ+I2C1H3otsIpm8dl8YO+RGS/Qt0R/pdkmO8q9RH5coSddUHtfkTvLPvrim55r9GuOrnfYWpKDgsL0o5OspicLuaet0XGHUNUCsEMzpkmDk8Ssg6cUU188gKTplAHBBsz4Lex7sBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905182; c=relaxed/simple;
	bh=8EWolTvpkbW4emba1JWwjmRSzclOiH5nf5WKDdePVrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zj88s26Tyd2jfcvVsuHYYZmSOgkY1QRV6eGscyNOxDIYZoPLyjdzCsoMQJpnRkYbaLhuO0BW3aBUoVgGDYoPb5FMTWP276QYD3mD34qRXvvFIGjFjD79jyscJpvyWJu+fy73oRX9jYkrZm/Z2au8v8dUsghRZV2xO5JuFoFKde4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rqOm5eHR; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqOm5eHR"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-366be8040a9so5179819a91.3
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 11:06:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779905179; cv=none;
        d=google.com; s=arc-20240605;
        b=cbnZF0wVzPxltWcy16kJ6/zabtYycKJRoxuX8tuCNsVi8FsiEE1yJTqky7CGeZiTdR
         x5F/5mzKIrT4z5q5XTPoBmohBsURr4/oGQwDk3YbbAW2EG+JUBLG79n9/oIn9SeTeDg2
         eA62xNhi4BjxjF5RaR+LYikrNvWeIaogA/WNYyYQEEx+gPCTOpDHOcTfV2QYL3vgVCZF
         IdXtbrDMEh9RmsqwQnRhq9zEm/8Xu4dldwwXoXadQfKvU9tZ3a5cwfatQ2Z68aLQYl0Y
         dwqnTK5RocGsoQ5Eb1XTlNsNKeaLV9e3D9vrwuWq/lRZC/fnGx/HfJLPASVL9T3ld/Ma
         rxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i213ngpj4PoHIeKKyvNhcxJ2IrKA4FwHa6YqVHFK6M4=;
        fh=ckZEgtcVWDTVMuXDX23Wf8smSqUfTZtoHP8Qq2xNnf0=;
        b=YQFOJyXvjvtlOretKdoU9WpbO5UHGYk1u9JdSKqN9ohC/n/t4oV3eRFQ5kI5YqITX7
         cYE8YY/VxozIyO0kLmKzdFE9v/aaRluWXKMtsHk9mLQ1pljLHYmZdzMY8ItnS+Q8QUBa
         fuY7Jf3CevdVH8sAyLxC4D61YGfH1ZBH8x7MjXO76IRtLpO57qZlW5s14B+9XjqT3sab
         qiYCKC5FMI2qjZhkO3idLDz1DSA7dmrQGzk1Uv0Al/tJxVXOdl2AGvqVtU7gglIu6W4Z
         hBn1fI3ixANe+i1zMjHyuyn+i4bYQV+MYhw5NhhKaxBE3FffUa18y13XYSyrnOW43pge
         kSjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779905179; x=1780509979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i213ngpj4PoHIeKKyvNhcxJ2IrKA4FwHa6YqVHFK6M4=;
        b=rqOm5eHRbH/bARcQR+yYbge+hfuGBVkk4Xw6xaaHQCle4I/5+AkkxkHJyFvaEWVPUl
         Nc8mkKC3fz6HA5Yu2CuiHsPgW6MFnEkren3lZ+uIAUTY//PjNbwm30JmA+cQhH0R298c
         SnBC09XPlHb6RgiIqrzG6WDyAV7ZuTVmFzmBllIOZYtn03l/hJGCrERVS1upNnTsgYto
         W/4oXJpx+h669ytSc45EAQUFzDgqNXtMDv/7zfJcCaOTiCCV3yo9MTxvLtC/R53Xa6+B
         /4KZhf7T9EF+O6OJmesu044+Jd//kgDgwrC0s6DG1Jm4kr8nuRAfHsM3+nuBB/KT06oq
         D4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779905179; x=1780509979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i213ngpj4PoHIeKKyvNhcxJ2IrKA4FwHa6YqVHFK6M4=;
        b=GtlWvYbHkbgLhucDISv0yG7KK7fWVAUWd0cbdRg5KIZjT3IY1iw8UcmlKKZe3r50/g
         /r7s+7+FPBCJhIoT5vhBNtah82566a+ByEsLjNpmSeOAy4HiZpaQiktFTc2+CR0nPJfL
         UElFUAed1t0TnzM1DfDNjYzMVdYYWfX72wIeDlNz5V/fSRvl0CFHfXdCsraEoIVV7pJX
         a2U6uKNtKIT2y6+yijPNLVsYtqRKkIfyi6p7uzlT0ff2fgcPdpZ8HgqvP8O3EUxV/wEQ
         Bj8sdvAXKaQjiep77qCkeP1YRPUF3FEvIkVuGMaoTarSljCAiXIU+Nmh++Jd3FJwhcjO
         SzCQ==
X-Forwarded-Encrypted: i=1; AFNElJ85wtpho15CJBhMXcB9DYNnA7jkfH/LvIZqg6rk2lFUXthvBgrhAnQ/vHk8mvzldrsp0ZfUUgewOEGY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc/fMX9XASyFM2HUpqIfKPO2q+mRd9cZjDRvKeN+BdysJuA8Iw
	qPhnDEmPXjXDsg3otDWu6gz8Azknrze4WGnplpifRnoRMGi5AphcUM/vWcQpCTPs5bdb/OIBXVr
	aipRNW6aZL+JSTE12uwA0xVTi3mt3/AY=
X-Gm-Gg: Acq92OEoxApBBxUL7BezqsHXA0HMv6HLY0blQd6ZUiVv4XcufWw1S3z9MX0LUaQOZ9k
	BVH6Smn979bj9u8PI4Dexd3CmY7PH/fPvmZjKCwNZSwQ/e7QLfLtT1mXSKLNQ6jPxMqLpBz1FIL
	F+WEIuM7a0L5gNpFmmxD+W3o5uLAYojczXdEt5UyiYDo6goKqsJ0qvKM7YseT0jRbovFsf26yNX
	htoTeXLxDTDIlbFobHj4zKfFs6sXFhlhm0SGpkvm/LMUztEPKzHDSHblNRF49BUBTKsh6XcFGIj
	wIeHuStZfiJke0ivc2yAarlIyT6Zh/450dripgmF
X-Received: by 2002:a17:90b:56cd:b0:367:bc89:546e with SMTP id
 98e67ed59e1d1-36a6778bc05mr21324176a91.12.1779905179381; Wed, 27 May 2026
 11:06:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527025828.5966-1-CFSworks@gmail.com> <20260527025828.5966-2-CFSworks@gmail.com>
 <20260527130008.0261fd62@pumpkin>
In-Reply-To: <20260527130008.0261fd62@pumpkin>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 27 May 2026 11:06:08 -0700
X-Gm-Features: AVHnY4Lin6yqtTV1Gw5afcab6aAdsu_ByrbUJKJmj54Z25aQBnR-pBZsLER_MQ8
Message-ID: <CAH5Ym4g--7bQ8aqnbW+0H+z+=Sx1dxGREAnECiKFN9wXEvFE9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ceph: pass fscrypt `tname` buffers directly
To: David Laight <david.laight.linux@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 5:00=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 26 May 2026 19:58:27 -0700
> Sam Edwards <cfsworks@gmail.com> wrote:
>
> > ceph_fname_to_usr() needs a temporary buffer for some operations
> > (currently only base64-decoding ciphertext) and it is convenient to
> > allow the caller to specify this buffer to avoid a heap allocation, so
> > it has a (nullable) `tname` argument. Until now, this argument was a
> > `struct fscrypt_str`; however, this is unnecessary for two reasons:
> >
> > 1. `tname->len` isn't used anywhere: ceph_fname_to_usr() assumes a
> >    buffer large enough to hold the ciphertext, and
> >    parse_reply_info_readdir() -- the only caller to use tname -- doesn'=
t
> >    set it.
> > 2. While the `tname` parameter is documented "may be NULL,"
> >    parse_reply_info_readdir() always passes it but with `tname->name`
> >    sometimes NULL in violation of the contract, indicating that the
> >    unnecessary container creates actual confusion.
> >
> > Therefore, change the type to `unsigned char *` and pass the buffer
> > directly.
> >
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  fs/ceph/crypto.c     | 10 +++++-----
> >  fs/ceph/crypto.h     |  4 ++--
> >  fs/ceph/mds_client.c |  6 +++---
> >  3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > index 64d240759277..7515cb251226 100644
> > --- a/fs/ceph/crypto.c
> > +++ b/fs/ceph/crypto.c
> > @@ -300,7 +300,7 @@ int ceph_encode_encrypted_dname(struct inode *paren=
t, char *buf, int elen)
> >   *
> >   * Returns 0 on success or negative error code on error.
> >   */
> > -int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_s=
tr *tname,
> > +int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *t=
name,
>
> I can't help feeling that the buffer length should also be passed.
> Either explicitly or, if constant, implicitly by embedding the array
> in a structure.

It isn't constant; the specific requirement (unchanged in patch 2) is
that the buffer be at least large enough to hold the ciphertext. The
only caller to pass tname has a comment explaining how it meets the
size requirement, so this is currently safe.

Or is your feeling more about general robustness, ensuring that the
function prototype of ceph_fname_to_usr() makes it hard for future
patches to ignore the length requirement? If so, the issue is
ultimately that the base64_*() functions don't accept a `dstlen` that
ceph_fname_to_usr() could use to (meaningfully) enforce the size
requirement.

Cheers,
Sam

>
> -- David
>
>
> >                     struct fscrypt_str *oname, bool *is_nokey)
> >  {
> >       struct inode *dir =3D fname->dir;
> > @@ -357,16 +357,16 @@ int ceph_fname_to_usr(const struct ceph_fname *fn=
ame, struct fscrypt_str *tname,
> >                       ret =3D fscrypt_fname_alloc_buffer(NAME_MAX, &_tn=
ame);
> >                       if (ret)
> >                               goto out_inode;
> > -                     tname =3D &_tname;
> > +                     tname =3D _tname.name;
> >               }
> >
> > -             declen =3D base64_decode(name, name_len,
> > -                                    tname->name, false, BASE64_IMAP);
> > +             declen =3D base64_decode(name, name_len, tname, false,
> > +                                    BASE64_IMAP);
> >               if (declen <=3D 0) {
> >                       ret =3D -EIO;
> >                       goto out;
> >               }
> > -             iname.name =3D tname->name;
> > +             iname.name =3D tname;
> >               iname.len =3D declen;
> >       } else {
> >               iname.name =3D fname->ctext;
> > diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> > index b748e2060bc9..79cb563fd887 100644
> > --- a/fs/ceph/crypto.h
> > +++ b/fs/ceph/crypto.h
> > @@ -115,7 +115,7 @@ static inline void ceph_fname_free_buffer(struct in=
ode *parent,
> >               fscrypt_fname_free_buffer(fname);
> >  }
> >
> > -int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_s=
tr *tname,
> > +int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *t=
name,
> >                     struct fscrypt_str *oname, bool *is_nokey);
> >  int ceph_fscrypt_prepare_readdir(struct inode *dir);
> >
> > @@ -204,7 +204,7 @@ static inline void ceph_fname_free_buffer(struct in=
ode *parent,
> >  }
> >
> >  static inline int ceph_fname_to_usr(const struct ceph_fname *fname,
> > -                                 struct fscrypt_str *tname,
> > +                                 unsigned char *tname,
> >                                   struct fscrypt_str *oname, bool *is_n=
okey)
> >  {
> >       oname->name =3D fname->name;
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index ed17e0023705..aa6730b48e97 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -488,11 +488,11 @@ static int parse_reply_info_readdir(void **p, voi=
d *end,
> >               struct inode *inode =3D d_inode(req->r_dentry);
> >               struct ceph_inode_info *ci =3D ceph_inode(inode);
> >               struct ceph_mds_reply_dir_entry *rde =3D info->dir_entrie=
s + i;
> > -             struct fscrypt_str tname =3D FSTR_INIT(NULL, 0);
> >               struct fscrypt_str oname =3D FSTR_INIT(NULL, 0);
> >               struct ceph_fname fname;
> >               u32 altname_len, _name_len;
> >               u8 *altname, *_name;
> > +             u8 *tname =3D NULL;
> >
> >               /* dentry */
> >               ceph_decode_32_safe(p, end, _name_len, bad);
> > @@ -540,7 +540,7 @@ static int parse_reply_info_readdir(void **p, void =
*end,
> >                        * always be shorter, which is 3/4 of origin
> >                        * string.
> >                        */
> > -                     tname.name =3D _name;
> > +                     tname =3D _name;
> >
> >                       /*
> >                        * Set oname to _name too, and this will be
> > @@ -557,7 +557,7 @@ static int parse_reply_info_readdir(void **p, void =
*end,
> >                       oname.len =3D altname_len;
> >               }
> >               rde->is_nokey =3D false;
> > -             err =3D ceph_fname_to_usr(&fname, &tname, &oname, &rde->i=
s_nokey);
> > +             err =3D ceph_fname_to_usr(&fname, tname, &oname, &rde->is=
_nokey);
> >               if (err) {
> >                       pr_err_client(cl, "unable to decode %.*s, got %d\=
n",
> >                                     _name_len, _name, err);
>
