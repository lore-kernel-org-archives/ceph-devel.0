Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3043659FD
	for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 19:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777058437; cv=pass; b=n7Jp2kqClVIoyy74h/eaYbaiItr8QRxc6N6UDwtmnA1pydAJk7oTw2tb0/UeMWwDkgYNm2UXsNpz0OWnOaBGBur3xP2o5IHFeNCbdtQ3+sx3UvL7HNuj4UZuMj8Y41hdxSuySTkyvWAPM0R2jmSHxOgWuTP5mmRhCLGP5ALxPI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777058437; c=relaxed/simple;
	bh=uGQoT6Tt7AUnYoPc7YUCiMIL4/EkpUk6jMRmv5jF6dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S7NGq1T/vbawJScrL/KK3sx65zFIkb2egsL3w4QBsKG5/YD4UMUlvjPVHimRFBPxXAWfoAR1k0EFiFQ9XDHY1JAL3uxperfuyJePO2P3z1mplzXKE073Wr6uPzeA0Xb2REGoH8M4kvl4RWjD4JAN5nSgrjhQ0zHrRQ9WZr/vqTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVkofytU; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVkofytU"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2d8ffdc31d0so1315561eec.0
        for <ceph-devel@vger.kernel.org>; Fri, 24 Apr 2026 12:20:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777058435; cv=none;
        d=google.com; s=arc-20240605;
        b=Fs1UWW3/3j02SLjObwqFHFIWj/RGk/jogwUieOlq2wsJPKJsatMMrj13eNR6CPR0Ho
         qF8AnNeexHcMjpaTiqbC3f4O49EmpdB0jlchIIZp2UNWkiI0iB1uXhSWczbZvYGMOOGU
         BlDxsPYEqqc8PziyDe1n0bGLOn16kJ4cFrYzF6j9bILKjtn7jcbdhGv5X5NQ91Iih2NJ
         qjfmXLzG0r6QvGnVPvKVA/+KlpI+hPwUM0IqE8gadwBQwPptKyHXMPcNgYxEtuGYoaSP
         etmq45g27tC76qG4hxDnLfiBzVkpM4BovK3ZF4hSu+k1ZM7ngYP5KrUHY57aHFhAaJVn
         ONtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=91iUgNyHatvcxmVZGZ9mNALw7LaI8au8M4b+UUSM3+Q=;
        fh=EztNekuzsNMq3qczZWwaWDfYHonR1e633SiZFhG7aSQ=;
        b=idIbADExSyFvAp8ub1/T2BHyTJwXqV9lJt2Ps3ac9IMgfzZtz+asqCnWOEXi/UMXzu
         lMLobTwqyCiUDT9QB6QJyW4oRqCkRv9ZYHGMhSle+55rg6f8VuwvK4G87IHe3IyDhHVs
         l4VPnkSUz72pII9jTRGlWAFeCzvDthETxJh6P1oizHil/LY+pO9jC8G+WIOWZZqGs+ha
         OehHsqTP4HzNbq84L1A6Sq3aZ4kmb63g4t5zL+tNoVr7pJcOJeC7buloDMb8cwDwp+zU
         5GWaYat1RyWi5TyJ6HO6fmM1ddRKl8M531vwRUwOecHKCsSQWuYVk8DQOU0Zq5U21hTb
         tANg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777058435; x=1777663235; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91iUgNyHatvcxmVZGZ9mNALw7LaI8au8M4b+UUSM3+Q=;
        b=UVkofytU2QFlz45UANnw2f9IKqA6sNiJJ/MXFVKUUysD/S+HuwnE3ZQ79iCfBon37S
         ZHFRmJNRagIVxjfuNePP9Og5oozdjVac7BBuZaYxc/BpouwhvBEVvQ10vdPlAwVI1OjD
         STmWPY+tFMVWz97JV82xcIKsac/VyBSCY1knXCjVU9NrwkVaKLRdg2rZvsiNB5j2G60/
         t3zZuRGeEGlB7Inxw48YTecjh5PexNB+X768z2/W938TcifocX7fX6DynvTceT+SaDua
         QBmcdoL+dnn0kp2Cwhm4NgbsxWcCH4rPFTNyMjBYOHiAPlb/eUPbuvhgHoEBoAckBmig
         FmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777058435; x=1777663235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91iUgNyHatvcxmVZGZ9mNALw7LaI8au8M4b+UUSM3+Q=;
        b=ow6nus58UMwIlgXi4/iwh2ZardsPgg5KDs5/LM1o+iPkRFVMvJn75l/dk/kP4YkNga
         AbbbApoxcivT/oc0ZWQoPX0X7z7EKJipSxLHkSDs1zVeV4sGjqZXGuLXSrsMQSX5M07l
         6/NAi3Pi3+6lbKgYCR1863BNZX79Vfc69sPbURckZdHqTVab3+guFQRRtpGlLmeX4VHr
         3luuKxgrQIIzRqf8feXIDiOaenz5V9oyh0efibf0sVJjU8llwdCWCkXBLZnPEuEHHe2r
         eaaLNNH9WVmo5YDTCllcye45mSqRaNDlVXyISY9bUI6wRfRboF6amxtQ8s3Hr4kz19Ee
         2dKg==
X-Gm-Message-State: AOJu0Yyr0DSxhL8Im3WZ8qLVx6OVpUxt9sr0r0Gr+B66L1WJCX3v0g6m
	iJ26LQA+e3VW9truqfUkO5pzT3Q1Bnr2h427ecySGoTGLE3GsUhN5uTO5hnca+l7PDnUACOhb9G
	XyACvoEHrgCyrvlaFLFBtizLlzyg0sXWR4+73
X-Gm-Gg: AeBDietnLlXyq1I655jmOp++jH2AI09XPHMV/MpgOYSYfwluBOgCOHenefJa4wX4+TL
	19JDbF/8MyxcowKN1WHo0u1bRe/5tWnIg02DtWT6eg4WeVu/vuKHVeFJ9R6tr2yTYOmV57AxdGY
	PEvfSN5ip3U/5DttF8EYCfsjRWUMdvJGveaoLiKVaAxKLVO7bLrQGJlaqh7x6B9yox1Fc8+auPm
	NqiSFT0gObFRJDNYXXY98idT8nokSYDtGHYxLzlNJvPTwtcGA6k80998Kpufw1ALRBnzMVu/FmL
	pXhSrtzo5f++Dnj03w==
X-Received: by 2002:a05:7022:6984:b0:12d:b66f:35d7 with SMTP id
 a92af1059eb24-12db66f3983mr9369582c88.10.1777058435286; Fri, 24 Apr 2026
 12:20:35 -0700 (PDT)
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
 <4a2802b9a0c82084f833d5211aa3dd0033553a91.camel@ibm.com> <CAOi1vP8PUPzqbp32HqQ=UKoMrepdto7kK3OWue3HAvpzccz_Hw@mail.gmail.com>
 <52241308ec39916b0e703e4a8d3d6d1c29d52244.camel@ibm.com>
In-Reply-To: <52241308ec39916b0e703e4a8d3d6d1c29d52244.camel@ibm.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 24 Apr 2026 21:20:23 +0200
X-Gm-Features: AQROBzCheOwTKOR3ApX2apqxnlWggrp7WnjoMZ4cgbPG4uVrFQj77jsh4h2KGW0
Message-ID: <CAOi1vP8AC3eKeW7rbNmmZdt8aPAhf9AuCEBxbzYDkfn4Mq76gg@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: bound encrypted snapshot suffix formatting
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "luis@igalia.com" <luis@igalia.com>, 
	Xiubo Li <xiubli@redhat.com>, "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>, 
	"slava@dubeyko.com" <slava@dubeyko.com>, Alex Markuze <amarkuze@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 8:31=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Fri, 2026-04-24 at 11:27 +0200, Ilya Dryomov wrote:
> > On Thu, Apr 23, 2026 at 8:04=E2=80=AFPM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > > On Wed, 2026-04-22 at 11:53 +0200, Ilya Dryomov wrote:
> > > > On Fri, Apr 10, 2026 at 10:46=E2=80=AFPM Viacheslav Dubeyko
> > > > <Slava.Dubeyko@ibm.com> wrote:
> > > > >
> > > > > On Fri, 2026-04-10 at 20:40 +0000, Viacheslav Dubeyko wrote:
> > > > > > On Thu, 2026-04-09 at 18:09 +0000, Viacheslav Dubeyko wrote:
> > > > > > > On Thu, 2026-04-09 at 10:39 +0800, Pengpeng Hou wrote:
> > > > > > > > ceph_encode_encrypted_dname() base64-encodes the encrypted =
snapshot
> > > > > > > > name into the caller buffer and then, for long snapshot nam=
es, appends
> > > > > > > > _<ino> with sprintf(p + elen, ...).
> > > > > > > >
> > > > > > > > Some callers only provide NAME_MAX bytes. For long snapshot=
 names, a
> > > > > > > > large inode suffix can push the final encoded name past NAM=
E_MAX even
> > > > > > > > though the encrypted prefix stayed within the documented 24=
0-byte
> > > > > > > > budget.
> > > > > > > >
> > > > > > > > Format the suffix into a small local buffer first and rejec=
t names
> > > > > > > > whose suffix would exceed the caller's NAME_MAX output buff=
er.
> > > > > > > >
> > > > > > > > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> > > > > > > > ---
> > > > > > > > Changes since v3:
> > > > > > > > - reject `elen > 240` explicitly instead of relying only on=
 the earlier
> > > > > > > >   `WARN_ON()`
> > > > > > > > - rewrite the NAME_MAX bound check in terms of the final to=
tal length
> > > > > > > >   instead of `NAME_MAX - prefix_len - elen`
> > > > > > > >
> > > > > > > >  fs/ceph/crypto.c | 31 +++++++++++++++++++++++++++++--
> > > > > > > >  1 file changed, 29 insertions(+), 2 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> > > > > > > > index f3de43ccb470..42e3fff34697 100644
> > > > > > > > --- a/fs/ceph/crypto.c
> > > > > > > > +++ b/fs/ceph/crypto.c
> > > > > > > > @@ -15,6 +15,12 @@
> > > > > > > >  #include "mds_client.h"
> > > > > > > >  #include "crypto.h"
> > > > > > > >
> > > > > > > > +/*
> > > > > > > > + * Reserve room for '_' + decimal 64-bit inode number + tr=
ailing NUL.
> > > > > > > > + * ceph_encode_encrypted_dname() copies only the visible s=
uffix bytes.
> > > > > > > > + */
> > > > > > > > +#define CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX       sizeof("_=
18446744073709551615")
> > > > > > > > +
> > > > > > > >  static int ceph_crypt_get_context(struct inode *inode, voi=
d *ctx, size_t len)
> > > > > > > >  {
> > > > > > > >   struct ceph_inode_info *ci =3D ceph_inode(inode);
> > > > > > > > @@ -209,6 +215,7 @@ int ceph_encode_encrypted_dname(struct =
inode *parent, char *buf, int elen)
> > > > > > > >   struct inode *dir =3D parent;
> > > > > > > >   char *p =3D buf;
> > > > > > > >   u32 len;
> > > > > > > > + int prefix_len =3D 0;
> > > > > > > >   int name_len =3D elen;
> > > > > > > >   int ret;
> > > > > > > >   u8 *cryptbuf =3D NULL;
> > > > > > > > @@ -219,6 +226,7 @@ int ceph_encode_encrypted_dname(struct =
inode *parent, char *buf, int elen)
> > > > > > > >           if (IS_ERR(dir))
> > > > > > > >                   return PTR_ERR(dir);
> > > > > > > >           p++; /* skip initial '_' */
> > > > > > > > +         prefix_len =3D 1;
> > > > > > > >   }
> > > > > > > >
> > > > > > > >   if (!fscrypt_has_encryption_key(dir))
> > > > > > > > @@ -271,8 +279,27 @@ int ceph_encode_encrypted_dname(struct=
 inode *parent, char *buf, int elen)
> > > > > > > >
> > > > > > > >   /* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX =
comments */
> > > > > > > >   WARN_ON(elen > 240);
> > > > > > > > - if (dir !=3D parent) // leading _ is already there; appen=
d _<inum>
> > > > > > > > -         elen +=3D 1 + sprintf(p + elen, "_%ld", dir->i_in=
o);
> > > > > > > > + if (elen > 240) {
> > > > > > > > +         elen =3D -ENAMETOOLONG;
> > > > > > > > +         goto out;
> > > > > > > > + }
> > > > > > > > +
> > > > > > > > + if (dir !=3D parent) {
> > > > > > > > +         int total_len;
> > > > > > > > +         /* leading '_' is already there; append _<inum> *=
/
> > > > > > > > +         char suffix[CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX];
> > > > > > > > +
> > > > > > > > +         ret =3D snprintf(suffix, sizeof(suffix), "_%lu", =
dir->i_ino);
> > > > > > > > +         total_len =3D prefix_len + elen + ret;
> > > > > > > > +         if (total_len > NAME_MAX) {
> > > > > > > > +                 elen =3D -ENAMETOOLONG;
> > > > > > > > +                 goto out;
> > > > > > > > +         }
> > > > > > > > +
> > > > > > > > +         memcpy(p + elen, suffix, ret);
> > > > > > > > +         /* Include the leading '_' skipped by p. */
> > > > > > > > +         elen =3D total_len;
> > > > > > > > + }
> > > > > > > >
> > > > > > > >  out:
> > > > > > > >   kfree(cryptbuf);
> > > > > > >
> > > > > > > Looks good.
> > > > > > >
> > > > > > > Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > > >
> > > > > > > Let me run xfstests for the patch to double check that everyt=
hing is OK. I'll
> > > > > > > share the result ASAP.
> > > > > > >
> > > > > >
> > > > > > The xfstests run was successful. I don't see any issues with th=
e patch.
> > > > > >
> > > > > > Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > > > >
> > > > > >
> > > > >
> > > > > Applied on testing branch of CephFS kernel client git tree.
> > > >
> > > > Hi Pengpeng, Slava,
> > > >
> > > > This patch raised my attention because my understanding was that th=
e
> > > > entire CEPH_NOHASH_NAME_MAX + sha256() was put in place precisely t=
o
> > > > handle longer names nicely and make them fit into NAME_MAX-sized bu=
ffer.
> > > > Simply rejecting longer names seemed to be in direct contradiction =
with
> > > > that and yet the patch on its own was clearly merited given
> > > >
> > > >  * (240 bytes is the maximum size allowed for snapshot names to tak=
e into
> > > >  *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>'.)
> > > >
> > > > comment on CEPH_NOHASH_NAME_MAX definition.
> > > >
> > > > I dug a bit deeper and started a discussion in [1].  The preliminar=
y
> > > > conclusion is that the 240 bytes assumption was a mistake -- someho=
w
> > > > the minimum number of characters needed for <inum> ended up being u=
sed
> > > > instead of the maximum.  CEPH_NOHASH_NAME_MAX value is likely incor=
rect
> > > > and should have been smaller -- something along the lines of 174 -
> > > > SHA256_DIGEST_SIZE instead of 180 - SHA256_DIGEST_SIZE.
> > > >
> > >
> > > The limitation could be 240 or bigger one, but anyway we need to proc=
ess this
> > > limitation in proper way. And this patch has exactly this goal. Is 24=
0 bytes
> > > limitation your concern? As far as I can see, this patch doesn't intr=
oduce this
> > > limitation. It was there before this modification. We can extend this=
 limitation
> > > anytime.
> >
> > Hi Slava,
> >
> > My take on this is that there shouldn't be a limitation to begin with
> > (other than NAME_MAX which is natural and applies universally, not just
> > to snapshot names).  This function has a bunch of code that is there
> > specifically to handle longer names and avoid any artificial limits:
> > the part of the name that spills over CEPH_NOHASH_NAME_MAX is hashed
> > and the whole thing is set up in such a way that the end result is
> > never bigger than 240 bytes.  240 isn't a random number -- it was
> > picked on purpose to leave room for _ prefix and _<INODE-NUMBER> suffix
> > (255 1 - 1 - 13) but a mistake appears to have crept in.  Instead of
> > accounting for the maximum possible <INODE-NUMBER> length (which is 20
> > in decimal encoding), it accounted only for 13 (likely because it
> > happens to be the maximum possible length in a single-MDS setup?).
> >
> > IMO the right course of action here would be to see if the hashing
> > parameters can be adjusted, not introduce new ENAMETOOLONG errors.
> >
> >
>
> Hi Pengpeng,
>
> Could you please rework the patch taking into account the shared remarks?

I would hold on until the discussion in [1] comes to conclusion.  It
turns out that the userspace client doesn't encrypt snapshot names
anymore, so another (much worse, at least IMO) route would be to drop
this bit of functionality from the kernel client as well [2].

[1] https://github.com/ceph/ceph/pull/45312
[2] https://tracker.ceph.com/issues/76257

Thanks,

                Ilya
