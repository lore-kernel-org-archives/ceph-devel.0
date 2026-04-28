Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3F03AF643
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777376445; cv=pass; b=MuUPh4xDi/u1+Ol4ro9Wl7MLsRWf73QADwEST6Ft8rQmY/f5l7bRLuv44T0yAF4yuBl4s2B0TRQH7XJTBBaagteuNaiYu1zRVv0E98Ib2gJZPZZurFp7TregyLcrzv7sKRTLifhaZoCQMlOQ1z/7Oda+36l65beA6Zhq3D36BCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777376445; c=relaxed/simple;
	bh=ZCxQTYQJ0sjA5HRl+DtYi/XjwzgA1tfQiGznfrLJ4Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmgwwPlEBsJYTWHEmvSp3dRTs+h/tG4LQXj87fQUJWupBK+5wxw2/TJyi3uAtdAQro95sgN5jWfI0+uEAaKxtlU9TzatKpxOpsp2UOhvyCPezJLfmRR9XoBJhJV8QWVlp+Xm+vMW5BxtHb6+jBfLR4UPGz92xXOUCbPEO3IZnP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGf3LXr7; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGf3LXr7"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12dca45ca21so4557372c88.1
        for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 04:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777376443; cv=none;
        d=google.com; s=arc-20240605;
        b=Oq+P8rjSkFuSzeZIwBmOvVtuV5k4QFa+rjZrfNhnc1mjOYFrRsI9hcthjCAT90nQke
         9GBV7MwYhvkndlmPG0+a2+25CvBTZuFdoIn4hKsi7tP9MSSVwrAlpXikdD96CCSOCIfL
         PnpMieN9Vwb5V1okLDr6P152lb353p/7nwN2GeVUIySi29PlaHgUruT2Lp9oHpJjVwTv
         hnzDXFZeZSNlMtxmryHPCRlnXusEu5HTzyscmaQehd/CQEtldCGsdvonj7bZCI4TTuoI
         iNIjMijq9iX80Tdzx6wgZXy/1legNAuUYPhZeVPtidIwPu+eFzadcNgDJi4Cg8Z6XbnO
         7Cgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z3mLgkrc7Js72OLwnJGUn5YTSTJDHH+qEqRyANwNdCQ=;
        fh=rhkr/b9IkvN86iCZJ91kUaVZzkVttbPeLoNVqXaDp2Q=;
        b=SDkQZbW7tSLlC3Fl3pHtFTw/4ijoQHz3YDifEV7vzR1YNkL1FN5kz41vzvvCYLk59/
         zvJyYYip+22JwGcK/H8LxdFYjtoLghglq8tbm4UEPae6bpb2xVlLi7xttc9jkobWsav9
         yqIohWC+3TOcqGCwjxmB6hXV4p9yHEY5ZyR0jpE96GECTemtpTLbtBIzDJ86mvy7LyQz
         uDTXCqV4alFTC6ks2eZRMvKiXPHSJVze7piGTvHcm57VmnGhoORuipnZD+Nm6ok4HM80
         fkssfSTwic0vO1jiaib9k5MbAgvSeOR4EXZlJMuBP9oqsFXhKxSkRJqEBFX4oYPCg3O2
         HVRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777376443; x=1777981243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3mLgkrc7Js72OLwnJGUn5YTSTJDHH+qEqRyANwNdCQ=;
        b=CGf3LXr7LkJlGwc0U5H6DK7RVvgrES/E8Oaykd94KA1XL3Z269/NWkc9iTmLICJUUW
         FO4rpdp02oEYNguYfUHK1xWEdyApM8kFAla5IUP7V5saRhhDB5otKwNJCjIoZSIFb0SR
         gdF23PT4TbKgFYNUgVHtvIL+YhBz1fpB/595vdGPTh6D49tzhbDc0Kbhz9VyVKutBJAS
         HV/Pj6sptx+d3GTS6z7+D9QZz4nX+uhnG1H4PAmng6sZ1NVOeVAOsdr37HePTFeD/lwv
         5oQP1KnjZvLWcbfDiHE5e7SujmIC/icWWVbQLsk2ZQzjtSGIKWOCmZcq42s0xYYfm8nR
         pnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777376443; x=1777981243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z3mLgkrc7Js72OLwnJGUn5YTSTJDHH+qEqRyANwNdCQ=;
        b=tNdvFb1BKokPmhWjGvtkJVuxtHU7yY2ot6E4msCRicTLVDfprBmc9W2NiND1qyVeM+
         YVNKKwpE3S1oavAqlTWhVq83dIkZlpRNSW/nbdwTC4qJ1817Q43CIk3lE+7GF44xRhHU
         6ApX8wzu0UUIjTq0o7tH2a9riOf+kaJiEV/ZU+pWEdUlWhB+O4Xa/42x1BXJ0t3OM52j
         yfoKMZwVA+C+Mb5AwWNCdTn6IKfbewGKPY8PqIcEQw7OCr3QLAKTLxaWlKBAuN3SI6e5
         BCr9kbWb+vt0XVizJBuDxibkdwHJNpHjavP7R09XlJbjOB/O54GxNjsSBcZyPa7PnGbU
         hKhg==
X-Forwarded-Encrypted: i=1; AFNElJ8UaP89AxhbszKE42GCIG/fa2+iP5omDMyYk3JIDd6wGD1YeNwLVjYv9bH+09T7Umna+9YsgkRReXBS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4PHiiLOF0wdz73OHhzp/2RDRx8qNpOmQbZ1Bedadff0tHtHT2
	pUAVTjTZI94CpCTUBhcqIFwfz1UlLARv0N7CAEk54CRnXqU7gQ7GPBKKH8esL5OSczZ0h4jEmlw
	JsRUiXMpc+8osGlnss/+21jHDfSvpuX4=
X-Gm-Gg: AeBDiesB3cUToLLx9N6dGUsJk+Ypy+ms+9hhtv+FQgOZQVKsNH5rJ1GTpsxszq4/WTU
	5IqMlltiZlR+BUbBGhsN+cW/b2Fu5ewcdg/4TOkq9Vz558T7CiPuwdlou1guixgrsTM/TZwJo77
	7Pht3eMz2Nf1Yj7MZZ8FqLzx4kU+u8FeTTRBTAvn5JRppjL6wRJqAwmJ+aBhdixI+m5otrUZzPR
	nLbUKwaL21ebbk1oJXSIxiXFozo49tW0eiHqu29T0LgN3svWGbCtRf6w6uT3yFimGs0gaCmLlUb
	hlQ85aA2G0T76FL2fiWVOkENY3Za
X-Received: by 2002:a05:7022:2583:b0:127:33e0:ea40 with SMTP id
 a92af1059eb24-12ddd9a1aacmr1189903c88.15.1777376443075; Tue, 28 Apr 2026
 04:40:43 -0700 (PDT)
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
 <52241308ec39916b0e703e4a8d3d6d1c29d52244.camel@ibm.com> <CAOi1vP8AC3eKeW7rbNmmZdt8aPAhf9AuCEBxbzYDkfn4Mq76gg@mail.gmail.com>
 <87qzo0keit.fsf@igalia.com>
In-Reply-To: <87qzo0keit.fsf@igalia.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Tue, 28 Apr 2026 13:40:30 +0200
X-Gm-Features: AVHnY4IOCu_2jZ3K3f5O74fuz9geRPeSVqUDiZ-EA16QuT9xiCFbi77lcfSgKng
Message-ID: <CAOi1vP9MnCv0Vx7bYQwKXVgRVd=dNyo0SG8p_9Vp+S+bBWwQ-Q@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: bound encrypted snapshot suffix formatting
To: Luis Henriques <luis@igalia.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Xiubo Li <xiubli@redhat.com>, 
	"pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	Alex Markuze <amarkuze@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Christopher Hoffman <choffman@redhat.com>, 
	Venky Shankar <vshankar@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:12=E2=80=AFAM Luis Henriques <luis@igalia.com> w=
rote:
>
> On Fri, Apr 24 2026, Ilya Dryomov wrote:
>
> > On Fri, Apr 24, 2026 at 8:31=E2=80=AFPM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> >>
> >> On Fri, 2026-04-24 at 11:27 +0200, Ilya Dryomov wrote:
> >> > On Thu, Apr 23, 2026 at 8:04=E2=80=AFPM Viacheslav Dubeyko
> >> > <Slava.Dubeyko@ibm.com> wrote:
> >> > >
> >> > > On Wed, 2026-04-22 at 11:53 +0200, Ilya Dryomov wrote:
> >> > > > On Fri, Apr 10, 2026 at 10:46=E2=80=AFPM Viacheslav Dubeyko
> >> > > > <Slava.Dubeyko@ibm.com> wrote:
> >> > > > >
> >> > > > > On Fri, 2026-04-10 at 20:40 +0000, Viacheslav Dubeyko wrote:
> >> > > > > > On Thu, 2026-04-09 at 18:09 +0000, Viacheslav Dubeyko wrote:
> >> > > > > > > On Thu, 2026-04-09 at 10:39 +0800, Pengpeng Hou wrote:
> >> > > > > > > > ceph_encode_encrypted_dname() base64-encodes the encrypt=
ed snapshot
> >> > > > > > > > name into the caller buffer and then, for long snapshot =
names, appends
> >> > > > > > > > _<ino> with sprintf(p + elen, ...).
> >> > > > > > > >
> >> > > > > > > > Some callers only provide NAME_MAX bytes. For long snaps=
hot names, a
> >> > > > > > > > large inode suffix can push the final encoded name past =
NAME_MAX even
> >> > > > > > > > though the encrypted prefix stayed within the documented=
 240-byte
> >> > > > > > > > budget.
> >> > > > > > > >
> >> > > > > > > > Format the suffix into a small local buffer first and re=
ject names
> >> > > > > > > > whose suffix would exceed the caller's NAME_MAX output b=
uffer.
> >> > > > > > > >
> >> > > > > > > > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> >> > > > > > > > ---
> >> > > > > > > > Changes since v3:
> >> > > > > > > > - reject `elen > 240` explicitly instead of relying only=
 on the earlier
> >> > > > > > > >   `WARN_ON()`
> >> > > > > > > > - rewrite the NAME_MAX bound check in terms of the final=
 total length
> >> > > > > > > >   instead of `NAME_MAX - prefix_len - elen`
> >> > > > > > > >
> >> > > > > > > >  fs/ceph/crypto.c | 31 +++++++++++++++++++++++++++++--
> >> > > > > > > >  1 file changed, 29 insertions(+), 2 deletions(-)
> >> > > > > > > >
> >> > > > > > > > diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
> >> > > > > > > > index f3de43ccb470..42e3fff34697 100644
> >> > > > > > > > --- a/fs/ceph/crypto.c
> >> > > > > > > > +++ b/fs/ceph/crypto.c
> >> > > > > > > > @@ -15,6 +15,12 @@
> >> > > > > > > >  #include "mds_client.h"
> >> > > > > > > >  #include "crypto.h"
> >> > > > > > > >
> >> > > > > > > > +/*
> >> > > > > > > > + * Reserve room for '_' + decimal 64-bit inode number +=
 trailing NUL.
> >> > > > > > > > + * ceph_encode_encrypted_dname() copies only the visibl=
e suffix bytes.
> >> > > > > > > > + */
> >> > > > > > > > +#define CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX       sizeof=
("_18446744073709551615")
> >> > > > > > > > +
> >> > > > > > > >  static int ceph_crypt_get_context(struct inode *inode, =
void *ctx, size_t len)
> >> > > > > > > >  {
> >> > > > > > > >   struct ceph_inode_info *ci =3D ceph_inode(inode);
> >> > > > > > > > @@ -209,6 +215,7 @@ int ceph_encode_encrypted_dname(stru=
ct inode *parent, char *buf, int elen)
> >> > > > > > > >   struct inode *dir =3D parent;
> >> > > > > > > >   char *p =3D buf;
> >> > > > > > > >   u32 len;
> >> > > > > > > > + int prefix_len =3D 0;
> >> > > > > > > >   int name_len =3D elen;
> >> > > > > > > >   int ret;
> >> > > > > > > >   u8 *cryptbuf =3D NULL;
> >> > > > > > > > @@ -219,6 +226,7 @@ int ceph_encode_encrypted_dname(stru=
ct inode *parent, char *buf, int elen)
> >> > > > > > > >           if (IS_ERR(dir))
> >> > > > > > > >                   return PTR_ERR(dir);
> >> > > > > > > >           p++; /* skip initial '_' */
> >> > > > > > > > +         prefix_len =3D 1;
> >> > > > > > > >   }
> >> > > > > > > >
> >> > > > > > > >   if (!fscrypt_has_encryption_key(dir))
> >> > > > > > > > @@ -271,8 +279,27 @@ int ceph_encode_encrypted_dname(str=
uct inode *parent, char *buf, int elen)
> >> > > > > > > >
> >> > > > > > > >   /* To understand the 240 limit, see CEPH_NOHASH_NAME_M=
AX comments */
> >> > > > > > > >   WARN_ON(elen > 240);
> >> > > > > > > > - if (dir !=3D parent) // leading _ is already there; ap=
pend _<inum>
> >> > > > > > > > -         elen +=3D 1 + sprintf(p + elen, "_%ld", dir->i=
_ino);
> >> > > > > > > > + if (elen > 240) {
> >> > > > > > > > +         elen =3D -ENAMETOOLONG;
> >> > > > > > > > +         goto out;
> >> > > > > > > > + }
> >> > > > > > > > +
> >> > > > > > > > + if (dir !=3D parent) {
> >> > > > > > > > +         int total_len;
> >> > > > > > > > +         /* leading '_' is already there; append _<inum=
> */
> >> > > > > > > > +         char suffix[CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX=
];
> >> > > > > > > > +
> >> > > > > > > > +         ret =3D snprintf(suffix, sizeof(suffix), "_%lu=
", dir->i_ino);
> >> > > > > > > > +         total_len =3D prefix_len + elen + ret;
> >> > > > > > > > +         if (total_len > NAME_MAX) {
> >> > > > > > > > +                 elen =3D -ENAMETOOLONG;
> >> > > > > > > > +                 goto out;
> >> > > > > > > > +         }
> >> > > > > > > > +
> >> > > > > > > > +         memcpy(p + elen, suffix, ret);
> >> > > > > > > > +         /* Include the leading '_' skipped by p. */
> >> > > > > > > > +         elen =3D total_len;
> >> > > > > > > > + }
> >> > > > > > > >
> >> > > > > > > >  out:
> >> > > > > > > >   kfree(cryptbuf);
> >> > > > > > >
> >> > > > > > > Looks good.
> >> > > > > > >
> >> > > > > > > Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >> > > > > > >
> >> > > > > > > Let me run xfstests for the patch to double check that eve=
rything is OK. I'll
> >> > > > > > > share the result ASAP.
> >> > > > > > >
> >> > > > > >
> >> > > > > > The xfstests run was successful. I don't see any issues with=
 the patch.
> >> > > > > >
> >> > > > > > Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> >> > > > > >
> >> > > > > >
> >> > > > >
> >> > > > > Applied on testing branch of CephFS kernel client git tree.
> >> > > >
> >> > > > Hi Pengpeng, Slava,
> >> > > >
> >> > > > This patch raised my attention because my understanding was that=
 the
> >> > > > entire CEPH_NOHASH_NAME_MAX + sha256() was put in place precisel=
y to
> >> > > > handle longer names nicely and make them fit into NAME_MAX-sized=
 buffer.
> >> > > > Simply rejecting longer names seemed to be in direct contradicti=
on with
> >> > > > that and yet the patch on its own was clearly merited given
> >> > > >
> >> > > >  * (240 bytes is the maximum size allowed for snapshot names to =
take into
> >> > > >  *  account the format: '_<SNAPSHOT-NAME>_<INODE-NUMBER>'.)
> >> > > >
> >> > > > comment on CEPH_NOHASH_NAME_MAX definition.
> >> > > >
> >> > > > I dug a bit deeper and started a discussion in [1].  The prelimi=
nary
> >> > > > conclusion is that the 240 bytes assumption was a mistake -- som=
ehow
> >> > > > the minimum number of characters needed for <inum> ended up bein=
g used
> >> > > > instead of the maximum.  CEPH_NOHASH_NAME_MAX value is likely in=
correct
> >> > > > and should have been smaller -- something along the lines of 174=
 -
> >> > > > SHA256_DIGEST_SIZE instead of 180 - SHA256_DIGEST_SIZE.
> >> > > >
> >> > >
> >> > > The limitation could be 240 or bigger one, but anyway we need to p=
rocess this
> >> > > limitation in proper way. And this patch has exactly this goal. Is=
 240 bytes
> >> > > limitation your concern? As far as I can see, this patch doesn't i=
ntroduce this
> >> > > limitation. It was there before this modification. We can extend t=
his limitation
> >> > > anytime.
> >> >
> >> > Hi Slava,
> >> >
> >> > My take on this is that there shouldn't be a limitation to begin wit=
h
> >> > (other than NAME_MAX which is natural and applies universally, not j=
ust
> >> > to snapshot names).  This function has a bunch of code that is there
> >> > specifically to handle longer names and avoid any artificial limits:
> >> > the part of the name that spills over CEPH_NOHASH_NAME_MAX is hashed
> >> > and the whole thing is set up in such a way that the end result is
> >> > never bigger than 240 bytes.  240 isn't a random number -- it was
> >> > picked on purpose to leave room for _ prefix and _<INODE-NUMBER> suf=
fix
> >> > (255 1 - 1 - 13) but a mistake appears to have crept in.  Instead of
> >> > accounting for the maximum possible <INODE-NUMBER> length (which is =
20
> >> > in decimal encoding), it accounted only for 13 (likely because it
> >> > happens to be the maximum possible length in a single-MDS setup?).
> >> >
> >> > IMO the right course of action here would be to see if the hashing
> >> > parameters can be adjusted, not introduce new ENAMETOOLONG errors.
> >> >
> >> >
> >>
> >> Hi Pengpeng,
> >>
> >> Could you please rework the patch taking into account the shared remar=
ks?
> >
> > I would hold on until the discussion in [1] comes to conclusion.  It
> > turns out that the userspace client doesn't encrypt snapshot names
> > anymore, so another (much worse, at least IMO) route would be to drop
> > this bit of functionality from the kernel client as well [2].
>
> OK, let me see if I understood this correctly:
>
> - The user-space client implementation leaks metadata (the snaphsot names=
)
> - The kernel client doesn't leak the snapshots names, thought there are
>   bugs to be fixed (including on the MDS side)
> - The proposed solution is to drop the kernel snapshot names encryption.
>
> So, currently snapshots created on the kernel client can't be accessed
> from the user-space client, and vice-versa?

Hi Luis,

I _hope_ not -- since the inode that corresponds to the snapshot
created on the kernel client would have the fscrypt context (i.e.
fscrypt_auth_len > 0), the userspace client should be able to process
it generically.

>
> Also, won't dropping the encryption from the kernel client effectively
> make old snapshots created using a kernel client unusable?

I don't think so but it looks like these scenarios haven't been tested
when the change [1] went in.  Personally, I'm not convinced that taking
away the ability to encrypt snapshot names completely (as opposed to
at least allowing snapshot names to be either encrypted or unencrypted
depending on whether the client that created the snapshot had the key)
was the right move.  In fact, I would have seriously considered going
in the opposite direction of disallowing creating snapshots inside of
encrypted directories without a key the same way creating or linking in
files or directories is disallowed in that case.

I'm adding Chris, Venky and Patrick to this thread to avoid split
discussion.

[1] https://github.com/ceph/ceph/commit/73a8b2fda1976f553ec474027a3a73a5f6c=
eb441

Thanks,

                Ilya
