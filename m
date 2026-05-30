Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4F1A5B9D
	for <ceph-devel@vger.kernel.org>; Sat, 30 May 2026 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102810; cv=pass; b=U/TcFNnWDxkEnqlKxHGwFPxnDDqVJ5tTdUoSOUDKlGcOC+YVLZTDoD13JZ1Ubkj/dP0ZMRz5ZPInFNyHOJn/q5vYBLW5X4henX1mAB4pzffz2q6uexQ44M5VEF+G622HI2xpfHgfxRGtWxUASG5O22HyT/kUeFzAGjRNg109NKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102810; c=relaxed/simple;
	bh=Xsapng4XUGHRM1lGFdQHa7kxf//aFyx+bzo2X+mRqmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IxDWjQVlqhWIOi14gjwSk4aZOCD/1+aQYQTmh7M8TXcXUur/9fPLG0/VLRuIpg7HFe/5ZDgxPOYlIqs4CIs3OmKDFZWwYY/EyHZsuf7k4OF5YxBLMNaNk01tsZFewdQdA0QRU8LOr4aDp3SiasLbj1qtj0VX4dof3UiHn06xS2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdIpuyKL; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdIpuyKL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf008a99d4so26541205ad.2
        for <ceph-devel@vger.kernel.org>; Fri, 29 May 2026 18:00:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780102808; cv=none;
        d=google.com; s=arc-20240605;
        b=BQG10f1q40rMyoeWqS3Jj6buDCrSV3Jn66TiDVDiXq2jlJ6jcyZEMAcUUkjr1AHuVv
         23Z43IJ1d63CN0YQGRQIck/nUqc6O8A5wD83BpMyOCcvU9iy7TmeXIzCKoQREnBm9OXj
         jDm7WGm5sHU5fwgypzmy/IhVzFs2tuCrB+qBjdJz/ZTVRV00Af8LpJdjh7hYFgrt5umn
         gx6HVhsuR34sm74dpHLDh7g4d2yT7MA4baxlV81iwP951UwtuvcRcdUi9mTGDDPC2+kF
         re+5+Xrh554JHk7GEe+kg1YA8ZW6yMZy2JtqENkUexhJWffcGXtds9VwrbSnLtvp2kSA
         XmJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iE1aJeMU3UqlHpiGOyDbSFLyOWGjGVM7dI7S8hJTB6c=;
        fh=Hs8yjIdEs9MjZDEbJrq8POi+r981XfWg4cvNimvTvEM=;
        b=HrUuFmLFP2t/yc6IvnONc4eS33tYNeqbY2SWVoLvIganF5IiOC41ShuzAlxik8Ht/T
         wQJ3cNUADg3I0LTjnA9BsRXoG4+PyL4KRTSr280t6GrWchdAZTwqV1ivzENVGwrBDvfG
         nngzF2RwiF5iSYZdvBmchZoze899n4reA6HRjRcdJ6DufvoO0qUrk+mQPACjXhvF6oNu
         O/TT7PlDTPytQD4p7OlPEDv7fAVZ1kjQlkR96G181rn9q9isZLXwD/r+i7w4hdubusLA
         w19UvTApEvPfn1/JjBeGsA79+wsiHBMUUJTtkDXoEEt0QRwTw8/DNo/oGuIwyHOE0FJQ
         yHeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780102808; x=1780707608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iE1aJeMU3UqlHpiGOyDbSFLyOWGjGVM7dI7S8hJTB6c=;
        b=gdIpuyKLbBYecXA7CfdjBbbng7Bz2c2nC2kGzxDcR8vR+nweOhixhxGezseTLFvx3V
         Lf8IzGiJlmhcK0kZE2Zk/J1kUGKFUksYhLuBTCDV7aygFPTtP8LFPk9yJmU+iR2/f+xU
         4JZ9jqq/djtMn0SUlF2HEOhfqL3bJxcR04yOUETyMSJQuDqSmRL+G9WlVjXlWZuS2U5N
         vqJb/6/YXBB3U6pctqdgZT6qCDcMN2LpIIcmm/+cbPsjH3I2E5dJ/zUhCmA3zKJZBBPU
         90wvo1B53NWIcl0WK6IrGkBqC4I3bzzZKOGsKn39Ubcdw0m60BC4Zt4dYQgDTRHAp+0l
         uFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780102808; x=1780707608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iE1aJeMU3UqlHpiGOyDbSFLyOWGjGVM7dI7S8hJTB6c=;
        b=QsVH2f8whu7M/CCuKg6zBUEU0rBNJxFdWDR2Mai3bUP7mRAstQxoyASAujmb82ljfk
         m/ADasY9sldrfzsSN2jRdSuvqPQLRYWXswFzqh30NfRfXW5NyuC7AgzMVpu+IPRsJFNw
         NVx2vbSHfZJ9ZEJlFlX2IxmJZ3ikw3bB1Uk+DrN06r25ic1CmCDElJqACt6XJ0IyRzwf
         vttMCLfyvPEUgFN9tFMXkqsI9BO57Ldg9vHOz11pEHjO1CN3eijFvZr6Boaa1Efcbr3f
         idPcCupV4gBQ9/KV89dOVN4uF859UUVQwekziVr3O43X1Xay6z5ZjoaByiNX4psv2Gx3
         0OEA==
X-Forwarded-Encrypted: i=1; AFNElJ9CqmQDQgbT7Ze50J9XYXnvq3+GuIqy6+6RavZ+a/EnZK+Gbw9gssk5BL4CGfMjhXVoot/rA/MrCqtZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzBXvh8zGoyaG4fBL7Ozf8NVNxJbA0b4LayHUuN3HWqHUSqplS3
	ECVVkboj3Uc3kQ0nmGqwRy/bwtblE6Ek5qIap56oWnOY927imzr/CwYI1Jclf9k2L5n/57vIA4B
	99rki53lV5GP548xyeTPgoHY3o+Yg2uI=
X-Gm-Gg: Acq92OGqkWEK762ZF4qwBSI90lfx+/o9oNj8B3HoAYadLFM0rDAMfWPzgst8IV/3LEt
	2kwAHLRIk9PZNrIn7Gq0hGRlilTgszHMPcFaArWeC+4OJXgrEnfNXvNOdDBuWeu8pcGwEXWlr/R
	PDOTcFSxbRnsbgUTyOA6JNJRib7GZKy6C34KVj0xyGpNjNubABlWkIZLfQQsLoN6EJDLzQEYhWm
	OCQGeuV7a/NtRbUu5Cs+3BRJfshR5Cj/Ix6mQP/Tr354p5dJoyU/7ILAlDn0ZutQnaIlri2LHzw
	rHXLOKJ5Yrdim+wVM1mUe0QCqPXO
X-Received: by 2002:a17:903:1905:b0:2bf:281f:19ec with SMTP id
 d9443c01a7336-2bf36803dccmr26075455ad.24.1780102808384; Fri, 29 May 2026
 18:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527025828.5966-1-CFSworks@gmail.com> <20260527025828.5966-3-CFSworks@gmail.com>
 <937c1dbbb0300a8113d62ca1dbaffe1493bd10e5.camel@ibm.com>
In-Reply-To: <937c1dbbb0300a8113d62ca1dbaffe1493bd10e5.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Fri, 29 May 2026 17:59:55 -0700
X-Gm-Features: AVHnY4KJ4IvzZHDaQ3pli8MLHryBbTX5TlcoaSBDM-uXok6d9w24L6k1pShHh_U
Message-ID: <CAH5Ym4gJYT1WNY-s_bVjaRYQqu3bgAN0SRBnj0A5vttGUb4Uyw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ceph: properly decrypt filenames in vmalloc() buffers
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, "mchangir@redhat.com" <mchangir@redhat.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 1:50=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Tue, 2026-05-26 at 19:58 -0700, Sam Edwards wrote:
> > The fscrypt subsystem uses the scatterlist crypto API, inheriting its
> > requirement that any buffers are in the linear mapping region. However,
> > the messenger client uses kvmalloc() to create buffers for messages,
> > which will occasionally place those buffers in the vmalloc() region whe=
n
> > physical memory fragmentation doesn't permit a large enough kmalloc().
> > The various callers of ceph_fname_to_usr() directly pass (slices of) ra=
w
> > messages from the MDS without considering that the messages may be in
> > vmalloc() buffers, resulting in oopses especially on non-x86 platforms
> > (see 'Closes:' for more details and a reproducer).
> >
> > Make ceph_fname_to_usr() explicitly tolerant of vmalloc()-allocated
> > fname->ctext, fname->name, and/or oname->name buffers, using `tname`
> > (which, when non-null, must be a linear address; when null, is briefly
> > allocated as necessary) as a bounce buffer to avoid passing any
> > inappropriate addresses to fscrypt_fname_disk_to_usr().
> >
> > Additionally change parse_reply_info_readdir() -- the only function to
> > supply its own `tname` -- to follow the new "tname must never come from
> > vmalloc()" rule by passing NULL when the message is not in the linear
> > region. Though this causes a per-dentry kmalloc()+kfree(), this overhea=
d
> > exists only when processing the minority of messages that spill into
> > vmalloc(). My (crude) testing puts this at only about 1 in 8,000 readdi=
r
> > messages. Still, if the overhead proves unreasonable in the future, it
> > is easy enough to mitigate: a future change could allocate a bounce
> > buffer in parse_reply_info_readdir() and use that as `tname` instead.
> >
> > Fixes: 457117f077c67 ("ceph: add helpers for converting names for userl=
and presentation")
> > Closes: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.ker=
nel.org_ceph-2Ddevel_CAH5Ym4ga7miUQE0K-2DcJA93Ya7w62P69MAN27R5cBiYnudoOHdA-=
40mail.gmail.com_T_&d=3DDwIDAg&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8N=
Ju1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=3DbcX0FhBD6jzWXGOsw2LoJOl_TqgobmwNBmqNIhj2=
K0qBn2krB8IUrIhcUs8LmJWM&s=3D2uInY5Ys7xQ_57Ifo4uovP7_e8SN0Q_wnzBDX-uj0hE&e=
=3D
> > Cc: stable@vger.kernel.org # v6.6+
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  fs/ceph/crypto.c     | 37 +++++++++++++++++++++++++++++--------
> >  fs/ceph/mds_client.c |  8 ++++++--
> >  2 files changed, 35 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > index 7515cb251226..61d6830d16bc 100644
> > --- a/fs/ceph/crypto.c
> > +++ b/fs/ceph/crypto.c
> > @@ -298,6 +298,10 @@ int ceph_encode_encrypted_dname(struct inode *pare=
nt, char *buf, int elen)
> >   * Otherwise, base64 decode the string, and then ask fscrypt to format=
 it
> >   * for userland presentation.
> >   *
> > + * Though the fscrypt/crypto subsystems broadly expect all buffers to =
be in the
> > + * linear-mapped region, this function slightly relaxes those requirem=
ents:
> > + * fname->ctext, fname->name, and oname->name may be vmalloc(), but no=
t tname.
> > + *
> >   * Returns 0 on success or negative error code on error.
> >   */
> >  int ceph_fname_to_usr(const struct ceph_fname *fname, unsigned char *t=
name,
> > @@ -305,11 +309,15 @@ int ceph_fname_to_usr(const struct ceph_fname *fn=
ame, unsigned char *tname,
> >  {
> >       struct inode *dir =3D fname->dir;
> >       struct fscrypt_str _tname =3D FSTR_INIT(NULL, 0);
> > +     struct fscrypt_str _oname;
> >       struct fscrypt_str iname;
> >       char *name =3D fname->name;
> >       int name_len =3D fname->name_len;
> >       int ret;
> >
> > +     if (WARN_ON_ONCE(tname && is_vmalloc_addr(tname)))
> > +             return -EIO;
> > +
> >       /* Sanity check that the resulting name will fit in the buffer */
> >       if (fname->name_len > NAME_MAX || fname->ctext_len > NAME_MAX)
> >               return -EIO;
> > @@ -350,16 +358,18 @@ int ceph_fname_to_usr(const struct ceph_fname *fn=
ame, unsigned char *tname,
> >               goto out_inode;
> >       }
> >
> > +     if (!tname && (fname->ctext_len =3D=3D 0 ||
> > +                    unlikely(is_vmalloc_addr(fname->ctext)) ||
> > +                    unlikely(is_vmalloc_addr(oname->name)))) {
> > +             ret =3D fscrypt_fname_alloc_buffer(NAME_MAX, &_tname);
> > +             if (ret)
> > +                     goto out_inode;
> > +             tname =3D _tname.name;
> > +     }
> > +
> >       if (fname->ctext_len =3D=3D 0) {
> >               int declen;
> >
> > -             if (!tname) {
> > -                     ret =3D fscrypt_fname_alloc_buffer(NAME_MAX, &_tn=
ame);
> > -                     if (ret)
> > -                             goto out_inode;
> > -                     tname =3D _tname.name;
> > -             }
> > -
> >               declen =3D base64_decode(name, name_len, tname, false,
> >                                      BASE64_IMAP);
> >               if (declen <=3D 0) {
> > @@ -368,12 +378,21 @@ int ceph_fname_to_usr(const struct ceph_fname *fn=
ame, unsigned char *tname,
> >               }
> >               iname.name =3D tname;
> >               iname.len =3D declen;
> > +     } else if (unlikely(is_vmalloc_addr(fname->ctext))) {
> > +             memcpy(tname, fname->ctext, fname->ctext_len);
> > +
> > +             iname.name =3D tname;
> > +             iname.len =3D fname->ctext_len;
> >       } else {
> >               iname.name =3D fname->ctext;
> >               iname.len =3D fname->ctext_len;
> >       }
> >
> > -     ret =3D fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
> > +     _oname.name =3D unlikely(is_vmalloc_addr(oname->name)) ?
> > +             tname : oname->name;
> > +     _oname.len =3D oname->len;
> > +     ret =3D fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, &_oname);
> > +     oname->len =3D _oname.len;
> >       if (!ret && (dir !=3D fname->dir)) {
> >               char tmp_buf[BASE64_CHARS(NAME_MAX)];
> >
> > @@ -381,6 +400,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fnam=
e, unsigned char *tname,
> >                                   oname->len, oname->name, dir->i_ino);
> >               memcpy(oname->name, tmp_buf, name_len);
> >               oname->len =3D name_len;
> > +     } else if (!ret && unlikely(is_vmalloc_addr(oname->name))) {
> > +             memcpy(oname->name, _oname.name, _oname.len);
> >       }
>
> When both dir !=3D fname->dir (longname snapshot) and is_vmalloc_addr(ona=
me->name)
> are true:
>
> (1) The if branch is taken =E2=80=94 NOT the else if.
> (2) _oname.name =3D tname holds the decrypted result (fscrypt wrote there=
).
> (3) oname->name is the stale vmalloc buffer =E2=80=94 the copy-back in th=
e else if was
> never executed.
> (4) The snprintf reads oname->name and formats a snapshot name from garba=
ge.
>
> Am I right?

Hi Slava,

Indeed you are. Well spotted, I should have examined that snprintf a
little more closely.

> This part of logic needs to be reworked carefully. This if - else constru=
ction
> becomes really complicated to understand.

ACK - I was originally just going to amend the patch with that fixed:

                char tmp_buf[BASE64_CHARS(NAME_MAX)];

                name_len =3D snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%llu=
",
-                                   oname->len, oname->name, dir->i_ino);
+                                   _oname.len, _oname.name, dir->i_ino);
                memcpy(oname->name, tmp_buf, name_len);
                oname->len =3D name_len;

...but, looking at the if/else-if block more carefully, I realized we
only care about ensuring `!ret`, so I'll simplify the control flow for
v2.

Thank you for the feedback,
Sam

> Thanks,
> Slava.
>
> >
> >  out:
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index aa6730b48e97..8fcf185e3a82 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -538,9 +538,13 @@ static int parse_reply_info_readdir(void **p, void=
 *end,
> >                        * to do the base64_decode in-place. It's
> >                        * safe because the decoded string should
> >                        * always be shorter, which is 3/4 of origin
> > -                      * string.
> > +                      * string. If this message was allocated with
> > +                      * vmalloc() (happens, but rarely), leave it
> > +                      * NULL and let ceph_fname_to_usr() allocate
> > +                      * suitable temporary working space instead.
> >                        */
> > -                     tname =3D _name;
> > +                     if (likely(!is_vmalloc_addr(_name)))
> > +                             tname =3D _name;
> >
> >                       /*
> >                        * Set oname to _name too, and this will be
