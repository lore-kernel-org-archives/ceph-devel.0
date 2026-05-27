Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDDD39021A
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779921898; cv=pass; b=BcrqV+sYS/AcHZ2WOyuwzaLd1wY9rpOI+VKNLT7I/1O0Bbt3F2uV4AymIV2XZQNPwSDGNs1NxTOhTwfJ5bTzWB1DVpcEnIUcH6MpUkvw286tmqwY9/y3M/5coOzNqecfK3HrBq8H0Ta9VbD6bk8Jg0lI0lD4Qg4SparaZgrvNEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779921898; c=relaxed/simple;
	bh=+a3oJ009yHTQ+mA0CBT0ctAcepdAG+0+4YUi0qroCmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FY7AGRlbHtStOtjdh1ydqEL25S6zyrRexez5ACzdSGv8J7GGeY6QBshE7hSA94Ku9oFQOtUGlRZt4SwCCoveFMPYSDEn/iQHspZHNOaTV4RxeSCQMl/vGFlbHFfs7Bq4m3E8IGwCSYngQWeNWZ3z/GvovxnHRWpPP6bfEq3OLlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ogX7a+dE; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogX7a+dE"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b9e9a6802aso53390895ad.3
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 15:44:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779921895; cv=none;
        d=google.com; s=arc-20240605;
        b=IATOf8o2L84KgStOsZY8LJkR2JQISpLRU0Mg2u5MQi8jPsk0BtD3DWQD3ztGNdCnL7
         BC2N29S8OyKJSoxRzEGa5HwoW/tMPssBzWD144GiodBKKCyDYQQaMbsxPx7ZxJU+N/6t
         4VcCEzoKqmNLNULVp7XbKyQ/lHPztUm8ZEyPgrEaiiE3uammgEOu+AQfcpdrrRJ4sJgI
         fsCoSJzTZDD8SaN8kWmZW3ltQKvXSzF351HZr6tjoHFXZotsq32adTLGdsWUwLSwDwRN
         65qHvb9NqkMc/Axulg85btFdSbE2YJR9A3RNppzyzWv8jIx8N2WP67vpidRBQtBrR21Y
         688g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D5X2NG9ZHgopx8xIr8yZMCajKVV1VXTLyzWGFORps0I=;
        fh=GX9YbDRn9+TE+ozPCPmBNmHfGDlfIGQ5YlPbkqMd7b4=;
        b=ejDRk+iOP0Te85gdavQgKO1lbv0Um+vgWMV5BEwg92OBH5Pb261R2dfIHYcZjla4ZY
         0PrLzbm2PuWKkrO3XwXQPLYkNd1+Fi5VVgYxEwDkAtGKpzYDsrv/j0HxXAVG4DYdKKFr
         ZvTB0/nSn/Ed1CqeJe+sXWjwLyqjfKSgc+o0OjYmtQGgEnmjyZRlQjkUeivmJrEpuArk
         FY4HW2TVttC36bJ75djhzvEr5cK/XCF1aRq+9focyg9mNzXTDewWbUgVW4bR8iGRDKKe
         y6pXs8b5f0XXRmvm77b4WVeYl6F/gyv40B+Gq2KYBd7R8/4bor6bMa62GABNf5XRm7+X
         8HVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779921895; x=1780526695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5X2NG9ZHgopx8xIr8yZMCajKVV1VXTLyzWGFORps0I=;
        b=ogX7a+dEusLIR2u6sxlxXrDDifGmnytLe9Yy0dvMFEpR5naTsLxuPVRKV2kW7URhWn
         a5hPxa77W1toBZ4+rtEZJhqnx5d5RSRp5asS2Lq57djQP+whH/K/fljkKwe88Lpk5d6y
         i0hSLBiC7aai+TyyEN/GGQMJBQZ+ozFsUp3XRRXvejKQmNTjbv0gAahqL3sYsSTC4dB+
         10DrupI0gPcZCJRm5MBugPrES/4/dJaSK6yPndZO9Z9mgLiU9AvcOJv1W94m4OoENApy
         h/tsLGWc1dh8fQBUChRxPf604HAQPdIzhF55wldLHDh9bgXBTJxnFmbSEPjoAN8qg0JX
         UThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779921895; x=1780526695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5X2NG9ZHgopx8xIr8yZMCajKVV1VXTLyzWGFORps0I=;
        b=ra1PjyscgU0IcfoRCiHzucAk67uvcTIex2tYjJy75nIG8v0zT5Jfrr7XkEw0Wl7u8h
         ffzJA6I0G5ky/QGSj6O/IxuOD6GqZTQEzsJHzpieNUIYKTahnfDqzoFCvB00mmgQcxMl
         /OKx9mOHwx//a+5Hmzqb59I3/X7z0hNCZKV8L3vYilq3qqQXISN5aVceCsuYWaVM7sq6
         7MtAOhjV394KeCAfyg2XZSlQoQEP6LGerH/MPSYQ9DKpZZ6CH4QMYY7wPSpGPa8UJ7lF
         PKRkevk/IvbChbG21fgbsPc6J3e06kTmbb2QoLXtTQztj5pKJpzy00Y3z0qbtgE+snc4
         yowg==
X-Forwarded-Encrypted: i=1; AFNElJ/5xdWgdRXfXHKuy2EQToE2AzM1gyJQ0xKu+Fzld3VCuxwzdOpCuoBZCGh8Kh+bBzQYkOxvuRMsnTEy@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4T8JR08SRorDE3zyrsLUFg+bfsRocznLmQ8vxfpc5vqnVO08
	37oqkriIhBruKpkAYgH6zK6Di5O2ir+iNw1o0RK6fxZxPLusmTaSpUWB8HsIT5/fZAHCBVcPDjx
	fVAAetZUiDTHhbwT1XncvlguQ5FyreHdJf+f/lYg=
X-Gm-Gg: Acq92OEFbT/rLvlWzoC6rtqW3kNfPTFsHKWcR9gvrddv5rlJm3fRZ7to5k9hFyhVI4k
	lnZZPrSUzuLbFPzKCqpI/PfioCWcKzc3pyYjhUUX5GDLhX9baDJGDkaTUvygKtfHNhxd1yryPEf
	Tn1uq0rPuK2cPgjiBxcEIcP402hRx7Y6OIPJPGSlrD19gLPJdbVhV9u7VIsFPUeOt6XMVlubGr+
	jc3IXXQml9A0M/DMc1zbD64IkphpskQ8Drr59K136HwtH0EkXryJQ+XFlSG+7A9ebimEfrxZauE
	mc95sdvWdQuljreYxoioaHAzjLBwyAuIsyikhz8LnHoczNIgNkajcnA8gGH8Jw==
X-Received: by 2002:a17:902:f543:b0:2be:1c3c:72bb with SMTP id
 d9443c01a7336-2beb069d332mr258018985ad.33.1779921895120; Wed, 27 May 2026
 15:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527025828.5966-1-CFSworks@gmail.com> <20260527025828.5966-2-CFSworks@gmail.com>
 <20260527130008.0261fd62@pumpkin> <CAH5Ym4g--7bQ8aqnbW+0H+z+=Sx1dxGREAnECiKFN9wXEvFE9A@mail.gmail.com>
 <20260527231307.289faff2@pumpkin>
In-Reply-To: <20260527231307.289faff2@pumpkin>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 27 May 2026 15:44:43 -0700
X-Gm-Features: AVHnY4Jd528gNoZfYtufcNT-mFWv7u-D0qHdfYvmxgOvUHslZNN6xg_3vMZb0cU
Message-ID: <CAH5Ym4iHa3nVv6Lkd-s9HkSvt+PmX2BcUvTY20byh4u7tpTzaQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ceph: pass fscrypt `tname` buffers directly
To: David Laight <david.laight.linux@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Jeff Layton <jlayton@kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 3:13=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 27 May 2026 11:06:08 -0700
> Sam Edwards <cfsworks@gmail.com> wrote:
>
> > On Wed, May 27, 2026 at 5:00=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 26 May 2026 19:58:27 -0700
> > > Sam Edwards <cfsworks@gmail.com> wrote:
> > >
> > > > ceph_fname_to_usr() needs a temporary buffer for some operations
> > > > (currently only base64-decoding ciphertext) and it is convenient to
> > > > allow the caller to specify this buffer to avoid a heap allocation,=
 so
> > > > it has a (nullable) `tname` argument. Until now, this argument was =
a
> > > > `struct fscrypt_str`; however, this is unnecessary for two reasons:
> > > >
> > > > 1. `tname->len` isn't used anywhere: ceph_fname_to_usr() assumes a
> > > >    buffer large enough to hold the ciphertext, and
> > > >    parse_reply_info_readdir() -- the only caller to use tname -- do=
esn't
> > > >    set it.
> > > > 2. While the `tname` parameter is documented "may be NULL,"
> > > >    parse_reply_info_readdir() always passes it but with `tname->nam=
e`
> > > >    sometimes NULL in violation of the contract, indicating that the
> > > >    unnecessary container creates actual confusion.
> > > >
> > > > Therefore, change the type to `unsigned char *` and pass the buffer
> > > > directly.
> > > >
> > > > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > > > ---
> > > >  fs/ceph/crypto.c     | 10 +++++-----
> > > >  fs/ceph/crypto.h     |  4 ++--
> > > >  fs/ceph/mds_client.c |  6 +++---
> > > >  3 files changed, 10 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > > > index 64d240759277..7515cb251226 100644
> > > > --- a/fs/ceph/crypto.c
> > > > +++ b/fs/ceph/crypto.c
> > > > @@ -300,7 +300,7 @@ int ceph_encode_encrypted_dname(struct inode *p=
arent, char *buf, int elen)
> > > >   *
> > > >   * Returns 0 on success or negative error code on error.
> > > >   */
> > > > -int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscry=
pt_str *tname,
> > > > +int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned cha=
r *tname,
> > >
> > > I can't help feeling that the buffer length should also be passed.
> > > Either explicitly or, if constant, implicitly by embedding the array
> > > in a structure.
> >
> > It isn't constant; the specific requirement (unchanged in patch 2) is
> > that the buffer be at least large enough to hold the ciphertext. The
> > only caller to pass tname has a comment explaining how it meets the
> > size requirement, so this is currently safe.
>
> Ugg...
> That is just an accident waiting to happen.
>
> > Or is your feeling more about general robustness, ensuring that the
> > function prototype of ceph_fname_to_usr() makes it hard for future
> > patches to ignore the length requirement? If so, the issue is
> > ultimately that the base64_*() functions don't accept a `dstlen` that
> > ceph_fname_to_usr() could use to (meaningfully) enforce the size
> > requirement.
>
> The output for the base64 functions depends only on the size of the
> input - so is easy to get right.
> And for decode is always shorter.

That's the same brand of "easy to get right" as passing a big-enough
tname buffer. In fact, you just paraphrased the second sentence of the
safety comment in parse_reply_info_readdir().

But my concern is that if tname->len were to be made significant --
which I'm receptive to doing, to be clear -- I need to be able to
enforce that length meaningfully and proactively, which
base64_decode() currently doesn't allow. And something like this is a
non-starter:

declen =3D base64_decode(name, name_len,
                       tname->name, false, BASE64_IMAP);
if (declen <=3D 0 || declen > tname->len) {
    ret =3D -EIO;
    goto out;
}

And I'm firmly against mixing the "explicit buffer bounds check" and
"easy enough to plan the size ahead of time" approaches; that's the
real "accident waiting to happen" territory. Any argument for an
explicit check here is also an argument for an explicit check in
base64_{de,en}code().

> I've just looked at what happens when tname is NULL - that looks
> broken as well - why not just kmalloc() a buffer that is the right
> size instead of using a wrapper function that might return a
> different length entirely.
> Maybe it should be too long, but bugs happen.

The wrapper function guarantees a minimum length, and it's being
called with NAME_MAX, so it's (at least) big enough to hold the
longest possible value it needs to hold. What kind of bug are you
expecting, should the buffer be too long?

> There are seem to be random overwrites of buffers of pointers
> to buffers - more code that is badly fragile.

I need more specificity: Where? Which buffers are being overwritten?
Under which circumstances? Which code?

Best,
Sam

>
> -- David
>
> >
> > Cheers,
> > Sam
> >
> > >
> > > -- David
> > >
> > >
> > > >                     struct fscrypt_str *oname, bool *is_nokey)
> > > >  {
> > > >       struct inode *dir =3D fname->dir;
> > > > @@ -357,16 +357,16 @@ int ceph_fname_to_usr(const struct ceph_fname=
 *fname, struct fscrypt_str *tname,
> > > >                       ret =3D fscrypt_fname_alloc_buffer(NAME_MAX, =
&_tname);
> > > >                       if (ret)
> > > >                               goto out_inode;
> > > > -                     tname =3D &_tname;
> > > > +                     tname =3D _tname.name;
> > > >               }
> > > >
> > > > -             declen =3D base64_decode(name, name_len,
> > > > -                                    tname->name, false, BASE64_IMA=
P);
> > > > +             declen =3D base64_decode(name, name_len, tname, false=
,
> > > > +                                    BASE64_IMAP);
> > > >               if (declen <=3D 0) {
> > > >                       ret =3D -EIO;
> > > >                       goto out;
> > > >               }
> > > > -             iname.name =3D tname->name;
> > > > +             iname.name =3D tname;
> > > >               iname.len =3D declen;
> > > >       } else {
> > > >               iname.name =3D fname->ctext;
> > > > diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> > > > index b748e2060bc9..79cb563fd887 100644
> > > > --- a/fs/ceph/crypto.h
> > > > +++ b/fs/ceph/crypto.h
> > > > @@ -115,7 +115,7 @@ static inline void ceph_fname_free_buffer(struc=
t inode *parent,
> > > >               fscrypt_fname_free_buffer(fname);
> > > >  }
> > > >
> > > > -int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscry=
pt_str *tname,
> > > > +int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned cha=
r *tname,
> > > >                     struct fscrypt_str *oname, bool *is_nokey);
> > > >  int ceph_fscrypt_prepare_readdir(struct inode *dir);
> > > >
> > > > @@ -204,7 +204,7 @@ static inline void ceph_fname_free_buffer(struc=
t inode *parent,
> > > >  }
> > > >
> > > >  static inline int ceph_fname_to_usr(const struct ceph_fname *fname=
,
> > > > -                                 struct fscrypt_str *tname,
> > > > +                                 unsigned char *tname,
> > > >                                   struct fscrypt_str *oname, bool *=
is_nokey)
> > > >  {
> > > >       oname->name =3D fname->name;
> > > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > > index ed17e0023705..aa6730b48e97 100644
> > > > --- a/fs/ceph/mds_client.c
> > > > +++ b/fs/ceph/mds_client.c
> > > > @@ -488,11 +488,11 @@ static int parse_reply_info_readdir(void **p,=
 void *end,
> > > >               struct inode *inode =3D d_inode(req->r_dentry);
> > > >               struct ceph_inode_info *ci =3D ceph_inode(inode);
> > > >               struct ceph_mds_reply_dir_entry *rde =3D info->dir_en=
tries + i;
> > > > -             struct fscrypt_str tname =3D FSTR_INIT(NULL, 0);
> > > >               struct fscrypt_str oname =3D FSTR_INIT(NULL, 0);
> > > >               struct ceph_fname fname;
> > > >               u32 altname_len, _name_len;
> > > >               u8 *altname, *_name;
> > > > +             u8 *tname =3D NULL;
> > > >
> > > >               /* dentry */
> > > >               ceph_decode_32_safe(p, end, _name_len, bad);
> > > > @@ -540,7 +540,7 @@ static int parse_reply_info_readdir(void **p, v=
oid *end,
> > > >                        * always be shorter, which is 3/4 of origin
> > > >                        * string.
> > > >                        */
> > > > -                     tname.name =3D _name;
> > > > +                     tname =3D _name;
> > > >
> > > >                       /*
> > > >                        * Set oname to _name too, and this will be
> > > > @@ -557,7 +557,7 @@ static int parse_reply_info_readdir(void **p, v=
oid *end,
> > > >                       oname.len =3D altname_len;
> > > >               }
> > > >               rde->is_nokey =3D false;
> > > > -             err =3D ceph_fname_to_usr(&fname, &tname, &oname, &rd=
e->is_nokey);
> > > > +             err =3D ceph_fname_to_usr(&fname, tname, &oname, &rde=
->is_nokey);
> > > >               if (err) {
> > > >                       pr_err_client(cl, "unable to decode %.*s, got=
 %d\n",
> > > >                                     _name_len, _name, err);
> > >
>
