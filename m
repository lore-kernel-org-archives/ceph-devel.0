Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9763815DF
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2026 04:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784174658; cv=pass; b=dpP7T/OpARnGwvDllfMD02hZ3Xy7UbIkcSZbvqkFQXgoIgLhMjI+2yXMOC5IgtJQm03JKoZGQ6YL6VWsGMYNN8lvpKXkSZlCzTc5j1bGHWmzsLYmZPmYndz9ect97T7KaRoL5yGDaPg6kyq5ml/NfEb5s1U7Gd8YpaypgDksX9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784174658; c=relaxed/simple;
	bh=nXnVjFBmmqjh11uJ/V7bu/MUSyAKhDygOivrFFzl7ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9tNCzljTyDtKsny7884QJH/UVLBCCSykMtfMmptDQJqdeiX5OlhEDu8AlYJTwVwole/AvcxKEk8yPXA4ejGz9mXRLWxGMqMehbfECZm3hCzB8fIXhgg8RoH3gnzJdghUIFahP1bYK9SSzEDL3QJNm5LHC7DuJxdYnOlKERbm5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=KfhYX/02; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="KfhYX/02"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so5081736a12.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 21:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784174654; cv=none;
        d=google.com; s=arc-20260327;
        b=V7USAC+lhC3IU5GCnqn/rNYCvgRpGi5MbDbzAsuInTyhpbP/OqfBhtJqaM5+fqKwTa
         GE+utYuTlJKASkAsU97hmAlOQhhvwPapyk7x8ccFCoZ+t15E3aHtP6lesgJ8OSiWf8bm
         i0/AJEtKtEGlECDjmKdzDNAcz16z3VllzobD6/edsxywqiFfdKnpYyIL5kL71oymfTOB
         5C+HvDit68TgbKZd0xp99mWP1T/gd7cMv/B0E5Et8/SBx2OmNTQStBXdSdnPoxz+5e8v
         seGC3aJ/4T9jhmV57Is2cPpX8d6OAMwkUoncezxlyqFAwM45+DHKwbQAaFH2m0USQaA6
         Y+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1uTmgAFTd0PK9xAkwdlD7y3fzUNJQUjhIq6twHYNqvg=;
        fh=GDI9fjahwvIymLJQTyw0nz83Iws1H28el/HStL8JOtM=;
        b=juINbtBZcscr+ClZQ67WpwqMHhCVuNC5TXibdxfOiKUczt2FnrKeLD7XiU8RV/CNIy
         cg0JodnH/xj+MV21H67u20ohz+2u/Bkkkjrec8cgg5sJGK/sYckjPElHxOpWeKJZclgf
         6n6YW9Hpd7pmQVedTxvZ3XaMSMhuYBzkbFfrIGjV2LLmaDPuKz8gfR0kue78vbdF2jOy
         MhP65jfi05Ft+QOs9JUSgYE/bhw2IwZZCb9f3qCH6MN9T+N8RBzS0YrrcrRuWyb3+7Hg
         Vi+xlflCFVzzDJbfbBly0KUcVq5CnJXmr/Em3LMeYLZ8xz97dqWACdr/t5NzbDaawpG3
         pEeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784174654; x=1784779454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1uTmgAFTd0PK9xAkwdlD7y3fzUNJQUjhIq6twHYNqvg=;
        b=KfhYX/02UTVR6WY/jXThB4QGFDhYUI8/xg1xIE+F4ZqYehW7mfUDZlq0wrp6k0LTUH
         ti73EWnmz8QS/Fr6NTBb3Hxgwsr3ZETii6D5G+ajM2nmyDkhxesDQyZmqdIc42hAywpa
         fhdTZ9XqMfv9J9eTHjWKQAKqerVLbb+8yc41PkP0YrqL56O7vDL0vxi0gTq4b9rpYmL0
         b6aJlqNfHusbkvNBjoeoXWMGPK7UnTRyF88U4/OqtmAamvp6QOGUcMld1y2b6m/v0Mlu
         Y04w+JPpbtLOisHFKHsNZwmiC+4hsqEhEwbEWaVGtcx1IPWX+wHH6NTqcHr99CM79SN3
         X1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784174654; x=1784779454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uTmgAFTd0PK9xAkwdlD7y3fzUNJQUjhIq6twHYNqvg=;
        b=hHr61JA8Rg7nBY0aupkX4llhIG76yjuSaPHoyKRZayz0YyWJCEcMYPgKhfHsOGkJmC
         5MyjwCdCRRTNQrXaQPXXZeqIDOt/JFIgtPOBIdfuCHYX+aEWYmnfp9n+gGuSrYaW0ONt
         pchnvhAFUE/gJAgj9NoLjH0VwWfs+TdM9I2i8YKDfNp0fcdaPIhU1bMOxcgtmwufJWzC
         PZJ692O0QF/V/mjhD0kZVAOzTvcqvOiKTkc/ALB7hxBTOuKRe35Er7Fxcnxqcry9/8Tf
         KXA9Gidj38s380haGAhZi8kc3X02Xm6A6EwKT+YUzH+juhpmsqrYGx7b0h5KHpQln+el
         jl8g==
X-Forwarded-Encrypted: i=1; AHgh+Roq3O1zf8UDHc4OrC2DZQAxoD6uq7c9EwazNrJspvnjeg5b6JGDQMyClnL9/Jh8NlVs8ZfQPQpzco51@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGH4f218R/h/ur6AQIGDF8UitHLTZVxMVDNeFE3VyPqrziff7
	YoiLVy9n4mRdS8bAK2yGDXDPeINnsXw8digAJZZqcSUHWx+b4/D9VDtLmpdBKzvXNSVPaUwwx19
	67LOi73rNjB+V1zx3A2gqKNb945y01JIzsS7Z9APK3g==
X-Gm-Gg: AfdE7ckARzvRbHhi55LX6PBeytFZ+VIFtmkYsrylsplH/Gbfqsjz9RZj1yjgvNg9qoS
	tA0Up1ulG8EVZvTCoPeutkq4rjMj/VKiYfQDcSB9ZHBzqGrNx/WnvSZhlbgZ0hz9VOUP5sMgXKO
	i+BlwYgRc2ULad29BtiTG/gWYiACM5hyP5jz9KwPIFdwY7vERJIJ1Y2GXI6Fmlae5EAl2vPj63/
	TeIMWlW/R/h2BmeGcOrth5HsxyvtLANbCpQ/dMdrowl4BzNg+tCQWQaPZM=
X-Received: by 2002:a17:907:c084:b0:c16:1901:6b8a with SMTP id
 a640c23a62f3a-c161f41f5efmr1068551666b.53.1784174654028; Wed, 15 Jul 2026
 21:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
 <20260713-ceph-mdsc-mutex-optimization-v1-1-9ae5ac135c34@clyso.com> <20260715105543.1e58cc13@pumpkin>
In-Reply-To: <20260715105543.1e58cc13@pumpkin>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 16 Jul 2026 12:04:02 +0800
X-Gm-Features: AUfX_mwA9Ka4-56ILnFEB_FmA_s3mBAJQGMenHIzPHYfQc9x1S3lf3ynECw0xoU
Message-ID: <CAOJNxRJzwSE5ocET1FRqhJ1nZA+5WtuFhDAkVSmu079x8PCXSw@mail.gmail.com>
Subject: Re: [PATCH 1/5] ceph: convert oldest_tid to atomic64_t
To: David Laight <david.laight.linux@gmail.com>
Cc: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jul 2026 at 17:55, David Laight <david.laight.linux@gmail.com> w=
rote:
>
> On Mon, 13 Jul 2026 17:46:07 +0800
> Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org> wrote:
>
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
> > The oldest_client_tid sent in the MDS request header is advisory:
> > a stale value is harmless -- at worst the MDS may resend a reply
> > we already have, or skip one we still need (which will just be
> > retried).  With the plain u64 read, however, the compiler is free
> > to split or cache the load, which is undefined behaviour when the
> > write side runs under mdsc->mutex on a different CPU.
> >
> > Convert mdsc->oldest_tid from u64 to atomic64_t so that reads
> > are guaranteed to be single-copy atomic on all architectures.
> > This removes the one remaining reason __prepare_send_request()
> > and __send_request() needed to be called under mdsc->mutex, so
> > drop those comments as well.
> >
> > All write sites (__register_request, __unregister_request) still
> > run under mdsc->mutex, so use atomic64_set() for clarity.
>
> If the read side doesn't hold the lock then it makes little difference
> whether the write side holds it.
> It the write is split (eg on 32bit) then even an atomic read could
> get an invalid value.
>
> On 64bit this change probably has no effect.
> But some 32bit architectures cannot do atomic 64bit read/write so
> they are expensive operations.
> x86-32 now requires the 64bit 'compare exchange' that can be used
> for 64bit load/store so they are only moderately expensive not
> stupidly expensive.
>

Agreed =E2=80=94 atomic64_read is unnecessarily expensive on 32-bit for
an advisory value, and on 64-bit a plain u64 load/store is already
single-instruction atomic.  Let me dropped the atomic64_t conversion
in v3.

The read side will use READ_ONCE() and the write side WRITE_ONCE(),
which prevents the compiler from splitting or caching the access.
The value is monotonic and advisory: on 32-bit a torn read is
harmless because at worst the MDS trims its completed_requests
table slightly earlier or later than optimal, which the replay
journal rectifies.

Thanks
Xiubo

>         David
>
> >
> > Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
> > ---
> >  fs/ceph/mds_client.c | 21 ++++++++-------------
> >  fs/ceph/mds_client.h |  2 +-
> >  2 files changed, 9 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 9f84ef2ac6e4..98d0a5baff70 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -1235,8 +1235,9 @@ static void __register_request(struct ceph_mds_cl=
ient *mdsc,
> >       if (!req->r_mnt_idmap)
> >               req->r_mnt_idmap =3D &nop_mnt_idmap;
> >
> > -     if (mdsc->oldest_tid =3D=3D 0 && req->r_op !=3D CEPH_MDS_OP_SETFI=
LELOCK)
> > -             mdsc->oldest_tid =3D req->r_tid;
> > +     if (atomic64_read(&mdsc->oldest_tid) =3D=3D 0 &&
> > +         req->r_op !=3D CEPH_MDS_OP_SETFILELOCK)
> > +             atomic64_set(&mdsc->oldest_tid, req->r_tid);
> >
> >       if (dir) {
> >               struct ceph_inode_info *ci =3D ceph_inode(dir);
> > @@ -1257,14 +1258,14 @@ static void __unregister_request(struct ceph_md=
s_client *mdsc,
> >       /* Never leave an unregistered request on an unsafe list! */
> >       list_del_init(&req->r_unsafe_item);
> >
> > -     if (req->r_tid =3D=3D mdsc->oldest_tid) {
> > +     if (req->r_tid =3D=3D atomic64_read(&mdsc->oldest_tid)) {
> >               struct rb_node *p =3D rb_next(&req->r_node);
> > -             mdsc->oldest_tid =3D 0;
> > +             atomic64_set(&mdsc->oldest_tid, 0);
> >               while (p) {
> >                       struct ceph_mds_request *next_req =3D
> >                               rb_entry(p, struct ceph_mds_request, r_no=
de);
> >                       if (next_req->r_op !=3D CEPH_MDS_OP_SETFILELOCK) =
{
> > -                             mdsc->oldest_tid =3D next_req->r_tid;
> > +                             atomic64_set(&mdsc->oldest_tid, next_req-=
>r_tid);
> >                               break;
> >                       }
> >                       p =3D rb_next(p);
> > @@ -1693,7 +1694,7 @@ create_session_full_msg(struct ceph_mds_client *m=
dsc, int op, u64 seq)
> >       ceph_encode_32(&p, 0);
> >
> >       /* version =3D=3D 7, oldest_client_tid */
> > -     ceph_encode_64(&p, mdsc->oldest_tid);
> > +     ceph_encode_64(&p, atomic64_read(&mdsc->oldest_tid));
> >
> >       msg->front.iov_len =3D p - msg->front.iov_base;
> >       msg->hdr.front_len =3D cpu_to_le32(msg->front.iov_len);
> > @@ -2759,7 +2760,7 @@ static struct ceph_mds_request *__get_oldest_req(=
struct ceph_mds_client *mdsc)
> >
> >  static inline  u64 __get_oldest_tid(struct ceph_mds_client *mdsc)
> >  {
> > -     return mdsc->oldest_tid;
> > +     return atomic64_read(&mdsc->oldest_tid);
> >  }
> >
> >  #if IS_ENABLED(CONFIG_FS_ENCRYPTION)
> > @@ -3438,9 +3439,6 @@ static void complete_request(struct ceph_mds_clie=
nt *mdsc,
> >       complete_all(&req->r_completion);
> >  }
> >
> > -/*
> > - * called under mdsc->mutex
> > - */
> >  static int __prepare_send_request(struct ceph_mds_session *session,
> >                                 struct ceph_mds_request *req,
> >                                 bool drop_cap_releases)
> > @@ -3555,9 +3553,6 @@ static int __prepare_send_request(struct ceph_mds=
_session *session,
> >       return 0;
> >  }
> >
> > -/*
> > - * called under mdsc->mutex
> > - */
> >  static int __send_request(struct ceph_mds_session *session,
> >                         struct ceph_mds_request *req,
> >                         bool drop_cap_releases)
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index 731d6ad04956..3b614b5df18c 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -532,7 +532,7 @@ struct ceph_mds_client {
> >       spinlock_t              snap_empty_lock;  /* protect snap_empty *=
/
> >
> >       u64                    last_tid;      /* most recent mds request =
*/
> > -     u64                    oldest_tid;    /* oldest incomplete mds re=
quest,
> > +     atomic64_t             oldest_tid;    /* oldest incomplete mds re=
quest,
> >                                                excluding setfilelock re=
quests */
> >       struct rb_root         request_tree;  /* pending mds requests */
> >       struct delayed_work    delayed_work;  /* delayed work */
> >
>
