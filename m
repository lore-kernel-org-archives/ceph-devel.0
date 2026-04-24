Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C137F8A1
	for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777022883; cv=pass; b=YWKz0FvHyfTtY7l4LAAjCGBUyoDyNwjoN2v/VJI0KdQeaRQ42uGIFiOZtyCAaI323TpJE6YDZugCgf6HADVRgQvWDsW9wXj1RiGlIson9xbt4yOjLSusLXyUBCeMf8PaltfTh0CizynfY7oznjr3fmrcLoXIpd2YPa7ocYCBPYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777022883; c=relaxed/simple;
	bh=vHcYlm0AvTMpIqkO7oT83uYBOPDUHf6wkwiESChnSXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XW8eHh0iodo9agUY+BKGY3BVJWKz/l98zpBgcaxXy01ZJkVpp/HWSWORyWbnrqhJ9Ny8IRnF5mZEl2qysJsWNMAJdApu7yVS/Ro7y0/m0kkOmo4t0WCePSRxihXcSepCsRZGzA2r0IkkzeogO8i2nKMqGoJv/AF+/4ZE+mgU09Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY8K/96z; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY8K/96z"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c565476d7so3006297c88.1
        for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 02:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777022881; cv=none;
        d=google.com; s=arc-20240605;
        b=LGGTXscQUfSDsRE/hYLayQM0YvkFoBrf0jLA5AwryP7BoHtQPifY0QTlc6A2SodYxS
         u0Xi4vxFANvja2PZiUxHgJR/FgKYrLIaU1L/LzhdlOU8k0ZWi+n7lBjyAkk4rgTm+Qoz
         /OrWJnukCv+OnEUjmvAengdQsBDgUXaswSGzc0MR9Kw7HlnvvfgKx1AYrVgY69pkS/Qu
         xpU3AyXnx3MlUUbA0T0+IUlsFDoGY7AsUVxJnFo4wvmLMFLW+X42XmyyvDjDWWPDYhO7
         aUir4OgbN+TmEqg+GSJhNHpE9t/NBZU9PSDqgnFCDeB0O1s/d6rYonHqx+smQViuNTvf
         A6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x/A2ESAbp5gO8Txlh0Zsosd96FxKrQzmMkH+TJ7b6kA=;
        fh=bbSLu/cDq1uxuOErBCxC9CDswKXP0znJrrQ7bN27Ak8=;
        b=jtitKhftZ/iPdZrX8ty1b+YTWVA4FRLsC6jAvg90Pd5y6nz8PuDBL0pPgUKAbuXCqt
         Nj/CNjXcZaKS8w38YyFn0XHPvQpsntd+J4gD7NqiKCtJqSHr+64kAg0e+kaZOIKH1Ep3
         /k8/+DsG1iEx88YxQdjrXEfECHLQ33FmaeJLx5C3nGuGKmeAHucQXsbnRB81br+JxM8s
         iaZYJncyUcj+8j8Y444rhfwqhBvG+CyELRKuq1P9roYgvk2l2na8f818ihlKBZhpk4lQ
         cePxt6LUYIcKJmiw73puVJUTv/mPZQuQwu9zPuvH0XZpFUtjDp8ujb94oCzoLBAQv0yh
         RWBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777022881; x=1777627681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/A2ESAbp5gO8Txlh0Zsosd96FxKrQzmMkH+TJ7b6kA=;
        b=gY8K/96zNTXoS66rERmYPzic9a0Me5GARsyz4CDkW4gg32NE7rrox80Yf0MUyFwQsc
         D2yUth3GFOvPs/RWLMB3nhYiD1qCrNs0vUe3E+Jgqo9+sVmq+LP+BPxKm1zTFphdyOIk
         v/R3qvABdFCfzgjqz+u2IIlqT6iGjewZJgqiiYSP+AN2aXXouPENqyGiyVKrnTb6GYc+
         jVFMUHzjkRnqPT7m80tzybYgKShv2nbVKJPIPtFreF1qOxyMZtWa+NuiHeLnxI+IfaHm
         FN5AumZ11wMyLfSStOKQfcP3g7QuujM30i5qNxzLbAxuVHXXKnYp5zV5srBt8Ybt/aey
         vZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777022881; x=1777627681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x/A2ESAbp5gO8Txlh0Zsosd96FxKrQzmMkH+TJ7b6kA=;
        b=IC4Der1xDLL/R3WY7CfY6WSs7RB5eGIAbxAgWMhhaRkprPGlIXfNpgrOtf4eWRvf9L
         PGoRtXlonEUImSrf3FarKli1WkvZieZLJFrXLbmZXJQRolVE5HawQCwZ893ywKGY5Rqh
         vYVmaQyShRSdKv+Uabdf7ZC0r8e8eLHVhtQZM/r33nnezpdk0Q9efRcvJIJYpT9PbrWT
         LLeROEYk3sV8R6XFfTlKV7avRqkZXzPaDDWEQsTSHlpcR9MLt82cK6ioUyh+XDtjB1Va
         tYgEQJvsFyAMC989bGcV+tyFlF93f0Ro6S9Vz3NvGkBom5V3ZnI/fR+cbdCWvQVFmUtF
         c1JQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IVvIQya9JhtD6TXrSUlIEzuVPxW9MgEUKz6yIaz7Xu+ZKf2IixhsIHXdVZAc7o9Z4EwGVecddZe4l@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+NQo6sbIx5jygBCCuRttUiFwR6Qm5HpLsv2tvkm9TG5p5obt
	YnhAQ+ND50K/t6HCPVAyZfnfBJkd+U67nF5Kb6tkrcPkP8Q3gqyiL/oDw9DnVurtnhi7udp5jbn
	rLx1ojpkgKJuvdE8YmbPujfXYMQwLnRM=
X-Gm-Gg: AeBDieuESJQ0wd7sMj4Po0CQnGRwjHGLA4GvoLhqImGqg/1c18jcMiX/grrYdsp+N6M
	vYtYSy2RwWaMnwpsah+vC/CvkO+tWVhy9NmLQNzAwd/9awqJRCgYZ3chknEF3tLctvOU/qKsjHV
	AuZbVoAfXsSLVWsBkB/lvLe7hxzvJQyCUoENzNvDeJ3d2Dk+cb1anerrLJYbIMc3FTOzLDDmwea
	pL9//fwX3qMdhLd9jFormJv6iYs0r/CyzX77+yBfkSDuj8A+DrVd8reVsrqcOJ0CdumjhnB6FOz
	jTb0wDiie/+QjRCmHg==
X-Received: by 2002:a05:7022:4199:b0:128:ccaf:85d5 with SMTP id
 a92af1059eb24-12c73f83044mr17758442c88.15.1777022881189; Fri, 24 Apr 2026
 02:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn> <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
 <20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn> <20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
 <f957bdf6488b391b4329ff3cc892bfdc93c014fb.camel@ibm.com> <847376cbf4408d12389545142311cb5883045937.camel@ibm.com>
 <7e043aa928f13d043552ca650808c0383209f806.camel@ibm.com> <CAOi1vP96JuBi5BhTdiVeL491ziy_hwJUm79TqOb=iPaxck1eyg@mail.gmail.com>
 <4a2802b9a0c82084f833d5211aa3dd0033553a91.camel@ibm.com>
In-Reply-To: <4a2802b9a0c82084f833d5211aa3dd0033553a91.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 24 Apr 2026 11:27:49 +0200
X-Gm-Features: AQROBzAVSRSv3zazznttD78igweSReOs4wZnjbPH1LIOyZhO2Jn2bsiliRfwEek
Message-ID: <CAOi1vP8PUPzqbp32HqQ=UKoMrepdto7kK3OWue3HAvpzccz_Hw@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: bound encrypted snapshot suffix formatting
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, "luis@igalia.com" <luis@igalia.com>, 
	"pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>, Alex Markuze <amarkuze@redhat.com>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 8:04=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2026-04-22 at 11:53 +0200, Ilya Dryomov wrote:
> > On Fri, Apr 10, 2026 at 10:46=E2=80=AFPM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > > On Fri, 2026-04-10 at 20:40 +0000, Viacheslav Dubeyko wrote:
> > > > On Thu, 2026-04-09 at 18:09 +0000, Viacheslav Dubeyko wrote:
> > > > > On Thu, 2026-04-09 at 10:39 +0800, Pengpeng Hou wrote:
> > > > > > ceph_encode_encrypted_dname() base64-encodes the encrypted snap=
shot
> > > > > > name into the caller buffer and then, for long snapshot names, =
appends
> > > > > > _<ino> with sprintf(p + elen, ...).
> > > > > >
> > > > > > Some callers only provide NAME_MAX bytes. For long snapshot nam=
es, a
> > > > > > large inode suffix can push the final encoded name past NAME_MA=
X even
> > > > > > though the encrypted prefix stayed within the documented 240-by=
te
> > > > > > budget.
> > > > > >
> > > > > > Format the suffix into a small local buffer first and reject na=
mes
> > > > > > whose suffix would exceed the caller's NAME_MAX output buffer.
> > > > > >
> > > > > > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> > > > > > ---
> > > > > > Changes since v3:
> > > > > > - reject `elen > 240` explicitly instead of relying only on the=
 earlier
> > > > > >   `WARN_ON()`
> > > > > > - rewrite the NAME_MAX bound check in terms of the final total =
length
> > > > > >   instead of `NAME_MAX - prefix_len - elen`
> > > > > >
> > > > > >  fs/ceph/crypto.c | 31 +++++++++++++++++++++++++++++--
> > > > > >  1 file changed, 29 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > > > > > index f3de43ccb470..42e3fff34697 100644
> > > > > > --- a/fs/ceph/crypto.c
> > > > > > +++ b/fs/ceph/crypto.c
> > > > > > @@ -15,6 +15,12 @@
> > > > > >  #include "mds_client.h"
> > > > > >  #include "crypto.h"
> > > > > >
> > > > > > +/*
> > > > > > + * Reserve room for '_' + decimal 64-bit inode number + traili=
ng NUL.
> > > > > > + * ceph_encode_encrypted_dname() copies only the visible suffi=
x bytes.
> > > > > > + */
> > > > > > +#define CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX       sizeof("_1844=
6744073709551615")
> > > > > > +
> > > > > >  static int ceph_crypt_get_context(struct inode *inode, void *c=
tx, size_t len)
> > > > > >  {
> > > > > >   struct ceph_inode_info *ci =3D ceph_inode(inode);
> > > > > > @@ -209,6 +215,7 @@ int ceph_encode_encrypted_dname(struct inod=
e *parent, char *buf, int elen)
> > > > > >   struct inode *dir =3D parent;
> > > > > >   char *p =3D buf;
> > > > > >   u32 len;
> > > > > > + int prefix_len =3D 0;
> > > > > >   int name_len =3D elen;
> > > > > >   int ret;
> > > > > >   u8 *cryptbuf =3D NULL;
> > > > > > @@ -219,6 +226,7 @@ int ceph_encode_encrypted_dname(struct inod=
e *parent, char *buf, int elen)
> > > > > >           if (IS_ERR(dir))
> > > > > >                   return PTR_ERR(dir);
> > > > > >           p++; /* skip initial '_' */
> > > > > > +         prefix_len =3D 1;
> > > > > >   }
> > > > > >
> > > > > >   if (!fscrypt_has_encryption_key(dir))
> > > > > > @@ -271,8 +279,27 @@ int ceph_encode_encrypted_dname(struct ino=
de *parent, char *buf, int elen)
> > > > > >
> > > > > >   /* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comm=
ents */
> > > > > >   WARN_ON(elen > 240);
> > > > > > - if (dir !=3D parent) // leading _ is already there; append _<=
inum>
> > > > > > -         elen +=3D 1 + sprintf(p + elen, "_%ld", dir->i_ino);
> > > > > > + if (elen > 240) {
> > > > > > +         elen =3D -ENAMETOOLONG;
> > > > > > +         goto out;
> > > > > > + }
> > > > > > +
> > > > > > + if (dir !=3D parent) {
> > > > > > +         int total_len;
> > > > > > +         /* leading '_' is already there; append _<inum> */
> > > > > > +         char suffix[CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX];
> > > > > > +
> > > > > > +         ret =3D snprintf(suffix, sizeof(suffix), "_%lu", dir-=
>i_ino);
> > > > > > +         total_len =3D prefix_len + elen + ret;
> > > > > > +         if (total_len > NAME_MAX) {
> > > > > > +                 elen =3D -ENAMETOOLONG;
> > > > > > +                 goto out;
> > > > > > +         }
> > > > > > +
> > > > > > +         memcpy(p + elen, suffix, ret);
> > > > > > +         /* Include the leading '_' skipped by p. */
> > > > > > +         elen =3D total_len;
> > > > > > + }
> > > > > >
> > > > > >  out:
> > > > > >   kfree(cryptbuf);
> > > > >
> > > > > Looks good.
> > > > >
> > > > > Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > >
> > > > > Let me run xfstests for the patch to double check that everything=
 is OK. I'll
> > > > > share the result ASAP.
> > > > >
> > > >
> > > > The xfstests run was successful. I don't see any issues with the pa=
tch.
> > > >
> > > > Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > >
> > > >
> > >
> > > Applied on testing branch of CephFS kernel client git tree.
> >
> > Hi Pengpeng, Slava,
> >
> > This patch raised my attention because my understanding was that the
> > entire CEPH_NOHASH_NAME_MAX + sha256() was put in place precisely to
> > handle longer names nicely and make them fit into NAME_MAX-sized buffer=
.
> > Simply rejecting longer names seemed to be in direct contradiction with
> > that and yet the patch on its own was clearly merited given
> >
> >  * (240 bytes is the maximum size allowed for snapshot names to take in=
to
> >  *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>'.)
> >
> > comment on CEPH_NOHASH_NAME_MAX definition.
> >
> > I dug a bit deeper and started a discussion in [1].  The preliminary
> > conclusion is that the 240 bytes assumption was a mistake -- somehow
> > the minimum number of characters needed for <inum> ended up being used
> > instead of the maximum.  CEPH_NOHASH_NAME_MAX value is likely incorrect
> > and should have been smaller -- something along the lines of 174 -
> > SHA256_DIGEST_SIZE instead of 180 - SHA256_DIGEST_SIZE.
> >
>
> The limitation could be 240 or bigger one, but anyway we need to process =
this
> limitation in proper way. And this patch has exactly this goal. Is 240 by=
tes
> limitation your concern? As far as I can see, this patch doesn't introduc=
e this
> limitation. It was there before this modification. We can extend this lim=
itation
> anytime.

Hi Slava,

My take on this is that there shouldn't be a limitation to begin with
(other than NAME_MAX which is natural and applies universally, not just
to snapshot names).  This function has a bunch of code that is there
specifically to handle longer names and avoid any artificial limits:
the part of the name that spills over CEPH_NOHASH_NAME_MAX is hashed
and the whole thing is set up in such a way that the end result is
never bigger than 240 bytes.  240 isn't a random number -- it was
picked on purpose to leave room for _ prefix and _<INODE-NUMBER> suffix
(255 1 - 1 - 13) but a mistake appears to have crept in.  Instead of
accounting for the maximum possible <INODE-NUMBER> length (which is 20
in decimal encoding), it accounted only for 13 (likely because it
happens to be the maximum possible length in a single-MDS setup?).

IMO the right course of action here would be to see if the hashing
parameters can be adjusted, not introduce new ENAMETOOLONG errors.

Thanks,

                Ilya
