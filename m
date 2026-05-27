Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE313C4B64
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919994; cv=none; b=LE1zJIO+gLrFOWlWsiw3RprQI9MQ5uHoK6drkEBQJUuJS1ThLfDaQwhiaeHRwNAtNznP+EETLbL7FpD7jlcF7TAIb1UH44EP6BRoIvfjQDzUeExLBEAmLKU7xskHElbpHpODdQ+YMpRuxxOEplUDqGbVzr983sDvAuYsXsOFDj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919994; c=relaxed/simple;
	bh=IB/4dQSg79fGoGxsHrNq+n3KApKvsbMORsDPj7q+SbM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOqfS7vcZ4GncfDryVnu0FpTQi8V9mdHMO3hN7rwpliKPRMCWGmbXDjpC1Pru0/FZ1FetrgIAGXsmsr1IU4o9vfKtqdmAFbXw1V21deLgv4MNeTdTn3ZR3fRpiZtgEdG6XR2+FfWbwQlQDmSpAx8WzeQhYa0JeHNYuAGyW3tvdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De09T793; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De09T793"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ed9336049so1836795f8f.0
        for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779919990; x=1780524790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=st62aORdkQ+M2/4oqLIixHMwgv8bb9aCMB7TChvDG8I=;
        b=De09T7930pwIp+XoOUbta6xaLIS0TxJsCVI14v0OXAvqh81f8HSWYFYRmX6QEo2fR/
         FdFB+Klq1CDtAORP2GhrLmnQ+MUdaBuA7YipWFIecERcFzqV5AVnb2U1JkND+n5Udeea
         3IFOPTt6etHDLmigfhmaQ+CDidW+jLUGBeD38WBKdHTU9uTo3E4fdczsrXD49dqItc9q
         juwGKxY9oUIPr3Fd3jrY4TLNYfrr7qP4VYqSw/I1+VMtEwVjjn2hKXe01yficWc7S0cY
         lj0VKKLkdJRtnJvMtS35l7UPPu6vdxD6yOpZ0D8aYCNhLEuDy6Q3kjte4e+IkqEp9B/A
         tojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779919990; x=1780524790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=st62aORdkQ+M2/4oqLIixHMwgv8bb9aCMB7TChvDG8I=;
        b=oAZdX/TnC9EB9X6G9vFw7mR9ws68PlhFUoJn0FA8ID99tIRznw2qQzqYQ5gAgbKlOR
         zqfn6oS2ESuHcDgFc7cFXN0A6HOM+faSr9AGOBRHASOf/jX24NcMEmXlHJABb1E+2HK+
         xONgFdKhPDmdDKnUyexGL5kIiVpJ2jwTvU9aV1uyDkSpulWTIMiEsRBDi8RMR4EXmDmu
         AT0MtMej/WnmEoR+0Pm+uMdwgGRByqpqt1BKiMvNk/21rOVQHPvEzDMmh/sSFEW45lVB
         xAZADTjpM37XyJHK3YNktjfhGVaXGyl9Eepv9N59+b83xaLe0cCkILtfdZZ3UpA6k2y4
         Umlw==
X-Forwarded-Encrypted: i=1; AFNElJ+tZ9TJUJeTdzfYOvtfkY/T6GBYc7lkL/Rca6xCVf6gRxW2wfCs9IMZ0sHd0DZ2XtbIbV6WIufQiZCX@vger.kernel.org
X-Gm-Message-State: AOJu0YwuTZql0Huhat+JDJnwXkZNM9tDuj5yI+VvdNpciFHEBnMFuzAz
	cyYenfvQb+5JZeZL8Di3eM8EJpeuh9rAXBE271G7MHC6xBr13q6JmmXd
X-Gm-Gg: Acq92OHvx0bvNaBz7+zqdzeOeuriFASkirY6RY0EcyuSAEMd8KIX5jEXIsi+Ay9QpnE
	uAwe235rSTuHdu9n8e6lmBkleX86xakm9YfP1iNQRqs/RUMewOeQZUBDOdhNLEyaCauF1xWbqAn
	ZfUeJVVBrzjFzrB/+YVVc0F9rh3KrVI/j4kgy00BYcGlIYRuR5w8d584eDKl/krkTWIXFmBRzI8
	7aqahkEm0OugEhXUxBx0jtcn6neaFFmm95Qccog+t6vaXF5L6d3QEEKv3etgpV4rZDs+oH9gLhJ
	A6ggrzHtmrWYyeGyvKVOt6heiFvQyD3AXRAC90F211DncI2CxfkKrqE2f9XNv2tA26e8O4wDOtw
	jVKNFXJKXwXSgIs3DcGM13Hks9az8jmrxAEVSMyPNZTY4fCkrlB1rokDfc+DoohJqMQo8ztKR8Z
	hX+/L/ODhGIGdvw+rx36Usp38awLKdGy30EEBadtHCmHezbsZcpkdhIYVtFfiLxXl/U1/89hXmQ
	G8=
X-Received: by 2002:a05:6000:2688:b0:43d:309b:9c4f with SMTP id ffacd0b85a97d-45eb3670427mr41054139f8f.6.1779919989579;
        Wed, 27 May 2026 15:13:09 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb558f52sm9677890f8f.14.2026.05.27.15.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 15:13:09 -0700 (PDT)
Date: Wed, 27 May 2026 23:13:07 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Jeff Layton <jlayton@kernel.org>,
 Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ceph: pass fscrypt `tname` buffers directly
Message-ID: <20260527231307.289faff2@pumpkin>
In-Reply-To: <CAH5Ym4g--7bQ8aqnbW+0H+z+=Sx1dxGREAnECiKFN9wXEvFE9A@mail.gmail.com>
References: <20260527025828.5966-1-CFSworks@gmail.com>
	<20260527025828.5966-2-CFSworks@gmail.com>
	<20260527130008.0261fd62@pumpkin>
	<CAH5Ym4g--7bQ8aqnbW+0H+z+=Sx1dxGREAnECiKFN9wXEvFE9A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 27 May 2026 11:06:08 -0700
Sam Edwards <cfsworks@gmail.com> wrote:

> On Wed, May 27, 2026 at 5:00=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 26 May 2026 19:58:27 -0700
> > Sam Edwards <cfsworks@gmail.com> wrote:
> > =20
> > > ceph_fname_to_usr() needs a temporary buffer for some operations
> > > (currently only base64-decoding ciphertext) and it is convenient to
> > > allow the caller to specify this buffer to avoid a heap allocation, so
> > > it has a (nullable) `tname` argument. Until now, this argument was a
> > > `struct fscrypt_str`; however, this is unnecessary for two reasons:
> > >
> > > 1. `tname->len` isn't used anywhere: ceph_fname_to_usr() assumes a
> > >    buffer large enough to hold the ciphertext, and
> > >    parse_reply_info_readdir() -- the only caller to use tname -- does=
n't
> > >    set it.
> > > 2. While the `tname` parameter is documented "may be NULL,"
> > >    parse_reply_info_readdir() always passes it but with `tname->name`
> > >    sometimes NULL in violation of the contract, indicating that the
> > >    unnecessary container creates actual confusion.
> > >
> > > Therefore, change the type to `unsigned char *` and pass the buffer
> > > directly.
> > >
> > > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > > ---
> > >  fs/ceph/crypto.c     | 10 +++++-----
> > >  fs/ceph/crypto.h     |  4 ++--
> > >  fs/ceph/mds_client.c |  6 +++---
> > >  3 files changed, 10 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > > index 64d240759277..7515cb251226 100644
> > > --- a/fs/ceph/crypto.c
> > > +++ b/fs/ceph/crypto.c
> > > @@ -300,7 +300,7 @@ int ceph_encode_encrypted_dname(struct inode *par=
ent, char *buf, int elen)
> > >   *
> > >   * Returns 0 on success or negative error code on error.
> > >   */
> > > -int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt=
_str *tname,
> > > +int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char =
*tname, =20
> >
> > I can't help feeling that the buffer length should also be passed.
> > Either explicitly or, if constant, implicitly by embedding the array
> > in a structure. =20
>=20
> It isn't constant; the specific requirement (unchanged in patch 2) is
> that the buffer be at least large enough to hold the ciphertext. The
> only caller to pass tname has a comment explaining how it meets the
> size requirement, so this is currently safe.

Ugg...
That is just an accident waiting to happen.

> Or is your feeling more about general robustness, ensuring that the
> function prototype of ceph_fname_to_usr() makes it hard for future
> patches to ignore the length requirement? If so, the issue is
> ultimately that the base64_*() functions don't accept a `dstlen` that
> ceph_fname_to_usr() could use to (meaningfully) enforce the size
> requirement.

The output for the base64 functions depends only on the size of the
input - so is easy to get right.
And for decode is always shorter.

I've just looked at what happens when tname is NULL - that looks
broken as well - why not just kmalloc() a buffer that is the right
size instead of using a wrapper function that might return a
different length entirely.
Maybe it should be too long, but bugs happen.

There are seem to be random overwrites of buffers of pointers
to buffers - more code that is badly fragile.

-- David

>=20
> Cheers,
> Sam
>=20
> >
> > -- David
> >
> > =20
> > >                     struct fscrypt_str *oname, bool *is_nokey)
> > >  {
> > >       struct inode *dir =3D fname->dir;
> > > @@ -357,16 +357,16 @@ int ceph_fname_to_usr(const struct ceph_fname *=
fname, struct fscrypt_str *tname,
> > >                       ret =3D fscrypt_fname_alloc_buffer(NAME_MAX, &_=
tname);
> > >                       if (ret)
> > >                               goto out_inode;
> > > -                     tname =3D &_tname;
> > > +                     tname =3D _tname.name;
> > >               }
> > >
> > > -             declen =3D base64_decode(name, name_len,
> > > -                                    tname->name, false, BASE64_IMAP);
> > > +             declen =3D base64_decode(name, name_len, tname, false,
> > > +                                    BASE64_IMAP);
> > >               if (declen <=3D 0) {
> > >                       ret =3D -EIO;
> > >                       goto out;
> > >               }
> > > -             iname.name =3D tname->name;
> > > +             iname.name =3D tname;
> > >               iname.len =3D declen;
> > >       } else {
> > >               iname.name =3D fname->ctext;
> > > diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
> > > index b748e2060bc9..79cb563fd887 100644
> > > --- a/fs/ceph/crypto.h
> > > +++ b/fs/ceph/crypto.h
> > > @@ -115,7 +115,7 @@ static inline void ceph_fname_free_buffer(struct =
inode *parent,
> > >               fscrypt_fname_free_buffer(fname);
> > >  }
> > >
> > > -int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt=
_str *tname,
> > > +int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char =
*tname,
> > >                     struct fscrypt_str *oname, bool *is_nokey);
> > >  int ceph_fscrypt_prepare_readdir(struct inode *dir);
> > >
> > > @@ -204,7 +204,7 @@ static inline void ceph_fname_free_buffer(struct =
inode *parent,
> > >  }
> > >
> > >  static inline int ceph_fname_to_usr(const struct ceph_fname *fname,
> > > -                                 struct fscrypt_str *tname,
> > > +                                 unsigned char *tname,
> > >                                   struct fscrypt_str *oname, bool *is=
_nokey)
> > >  {
> > >       oname->name =3D fname->name;
> > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > index ed17e0023705..aa6730b48e97 100644
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -488,11 +488,11 @@ static int parse_reply_info_readdir(void **p, v=
oid *end,
> > >               struct inode *inode =3D d_inode(req->r_dentry);
> > >               struct ceph_inode_info *ci =3D ceph_inode(inode);
> > >               struct ceph_mds_reply_dir_entry *rde =3D info->dir_entr=
ies + i;
> > > -             struct fscrypt_str tname =3D FSTR_INIT(NULL, 0);
> > >               struct fscrypt_str oname =3D FSTR_INIT(NULL, 0);
> > >               struct ceph_fname fname;
> > >               u32 altname_len, _name_len;
> > >               u8 *altname, *_name;
> > > +             u8 *tname =3D NULL;
> > >
> > >               /* dentry */
> > >               ceph_decode_32_safe(p, end, _name_len, bad);
> > > @@ -540,7 +540,7 @@ static int parse_reply_info_readdir(void **p, voi=
d *end,
> > >                        * always be shorter, which is 3/4 of origin
> > >                        * string.
> > >                        */
> > > -                     tname.name =3D _name;
> > > +                     tname =3D _name;
> > >
> > >                       /*
> > >                        * Set oname to _name too, and this will be
> > > @@ -557,7 +557,7 @@ static int parse_reply_info_readdir(void **p, voi=
d *end,
> > >                       oname.len =3D altname_len;
> > >               }
> > >               rde->is_nokey =3D false;
> > > -             err =3D ceph_fname_to_usr(&fname, &tname, &oname, &rde-=
>is_nokey);
> > > +             err =3D ceph_fname_to_usr(&fname, tname, &oname, &rde->=
is_nokey);
> > >               if (err) {
> > >                       pr_err_client(cl, "unable to decode %.*s, got %=
d\n",
> > >                                     _name_len, _name, err); =20
> > =20

