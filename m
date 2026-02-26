Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6623AE6E5
	for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2026 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114200; cv=pass; b=aC4ktcZb0C+EH0FN+sD+ILwAqRWbLIpSW31hoPT+e/XhfUCfuuq2R27fIuZs0wCA2VN+bdcobbsvuBYBVuGcIY48mhI9tQmcCFZbnfW3k9f0fcOOC+qmK2TB9rzIMoBwFF3HiSqaIQx9kan3VaZZIbIVj5aAVsRK1TM15OxTjz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114200; c=relaxed/simple;
	bh=1y9G44eykZXCRMbqWo4Gbo0Fu3X9DE/FOzp00Uhpy6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VL1SdaO5b4fcOCqj84xKaWmiU1E4MYoUIYytlhtBygiW4VH87K/lRcazX3AwaFVrLBg+LdICwY+TyjTZ2vsg1ULOysBt6wK369CW8vXCQZpv62l0yHDk6shj9YE2MRvDbtI0uAGnVA7UmxfjS/2luyTvXrIJ2R9aK8lpAPkfrS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiToQ7vX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6AMp2V5; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiToQ7vX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6AMp2V5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772114193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pa40UGOtLEf+lUXJi+W2eAsZrpePRgbKwxqj2/6a6JM=;
	b=SiToQ7vXGoBXC77t76Rjevwkqo6gKLxzJ3y2eS1Ji2V+qfvg4z4eiL3lnyDpRQtTTduWWM
	xq7SGxPkK6f6w2Yx4E1s+Q+5hd6NKBdw+fNTRmsbivAETW5cK86tvoUhSjEkIr4gfga36T
	C4uKaJlVArDObLcLXffWhy5bL6vAbv0=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-FC_9ezu0NAunEEsK5jG3Sw-1; Thu, 26 Feb 2026 08:56:32 -0500
X-MC-Unique: FC_9ezu0NAunEEsK5jG3Sw-1
X-Mimecast-MFC-AGG-ID: FC_9ezu0NAunEEsK5jG3Sw_1772114191
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-5ff0eb3ff4cso1008093137.3
        for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2026 05:56:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772114191; cv=none;
        d=google.com; s=arc-20240605;
        b=CtKeM4C9nF+J5vamaNRcZMkaWiJbZmS/j8jFaGm9kpQtMONJ3xfQqVIsZZT/v0Ew6j
         RTHkvySxWP40bAEcGdJvEmtfVdXQbGdVT2RLuiqfqZEbYSnulkHL2jGfsguzZInNU14f
         vvjIjmBIMdfqqR0xyHCxbSOMH/EbdfgHzaTc1tciVj7vVXnYJfQRrh/rMZT+tVtOLiNe
         l4U/PiDKO6nPJYBTYaqQ+gsMM97e++JvHDS/mKiIaOSYdClDPoUDW9ONYHGVV3Nz4n8T
         pXZX17tAC1hQujDU2rAY1Vh7o/IGNsMEhLzEW8O+TF1XYVslqTlztetg+5vSPA/CyxBL
         51OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pa40UGOtLEf+lUXJi+W2eAsZrpePRgbKwxqj2/6a6JM=;
        fh=8l0u/IMevTe27ybXs5OlkEsvMOknoS1EIIe0cqMmo1Y=;
        b=OxS67En+JShBElKQYPayh6fJ7ASMvERWZl6KBf96GsYW//Zj7XNoA4qxitIloN5s8V
         tOmrgfyLQxVPpKhKjAj+n8/IMHYlYkfmrQdA2p0Rjcmo/vO2xpmqPl/TY8ll2PZELxy+
         HkBFV6tUHEcrqz+xHf9kGNln4YKbIbVALKZdA2EAfk8B0+PEQiyDxSxge0WsntWo9jLL
         yU6xB0ByoOa8XsOtLfRRRkzOFrfudDyO0xRKBHxbaig2FhV/HQwyG2gpaQjvE/KX4exG
         MF3J9HRGFkHzoaQkuxBS45DMYFOYuo906IlfTeTZmeYzax7xbIhLvSrG3s160chk4DFX
         yqNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772114191; x=1772718991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pa40UGOtLEf+lUXJi+W2eAsZrpePRgbKwxqj2/6a6JM=;
        b=S6AMp2V5pKKAKZtEwUynfZQ8zn3wFGhPrHl8vU68pmwPdpRDyzHREtQfB/t2jtuc41
         mTUitO2wHhOkhN7Kqr4GA+Uk0plS1SskrbZNIemBsHrX3s9nXeKuP63ymmF6nxbgu7dj
         Yly8inJ3mkwzagpvIA+bV+awnCzCjRz6dxXD1mywGjUrrfTlOmZtPfi7JOZhC95A9+lQ
         CVFZY9XX6H6K4Ham0aS66SwZFdpJBiQMTn4U+XN9Iq1Gdf9my6EyTlu3YxjQDgUsvEfM
         A/+H2ufomE7lFl5AxHHYvwzbS51Op85zKJKqN8IHfMho7x4IJbm6Mc7ovtyhm2tmCChG
         X2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772114191; x=1772718991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pa40UGOtLEf+lUXJi+W2eAsZrpePRgbKwxqj2/6a6JM=;
        b=wgGNk3rrt/8LxN/hphnRa72+d4i24fIlNRJHmdzh/Wzty8MPG0gogdgRbGuFINuCMG
         dR2H295DW+3drOFppuoeflt+14bQDRRcXub9EnQDUX+rHzdfsfRkBgtAPhCdUIu4hwS7
         beGVDk3vrMI90Dq+6kHzW4HpvK+9cFbKTYGfr+0uhRghF893sg2+P9nLyg9jc+dl+0ky
         +hhZuopxj1zxwqfSMhKdYxGwhTlinuX9FRLPJFmfxAclnUuMEG7gEwMk1PVNMrLFcZND
         4MGUIaavmfFLIpuAr2IxPh48E5l4tWQavwpPzAd0rBbXxuvCDFROpf29Hp5glyogesH0
         yRdw==
X-Gm-Message-State: AOJu0YxzA6cje9I5WVSJydqLfw7Rp0dGCuXW0zgLd7QDXrI7nEkwdGJO
	lQmjZoflVhLkIDdETAr3DKSVrhxZGGlL1LD7uT1g5tHdYOjOsbX8mjKmvGp1dlPuKRhqOKsTBwY
	IoawYhCY2zt+5HQ3C9Q0uKtgcjhEYH9vU7l06Bfgrp6yYw2kimzQQsgnqpbg8seCCACaxk8SPiV
	MbDJ79A0gpQvyB1XK4PtDkEQdXFwcaXBwZwl044g==
X-Gm-Gg: ATEYQzzBl22BCBsoVqyoMkibf5/akk9aSDiR8+hMQlrrq1hYCZ+wbJ9DyHjRSp0m8PT
	dRL3gCvgx+A2RANuo7/yvVyBUEx/8h0BHbDl8D3kFrlkbMkfE4EB6pK7N2+zCrrrRrdOyJSeRQr
	Xkp0xy41OVgAFWe1uxryplBne8kkm+h8ONOMq6HAAuUefMxtcG6o0wMnwczx1oqX5zBzSTN48/o
	RFMvQT+DCLW3YtTfbTxbzti
X-Received: by 2002:a05:6102:3a09:b0:5ff:20c5:cd6 with SMTP id ada2fe7eead31-5ff20c51797mr830109137.18.1772114191184;
        Thu, 26 Feb 2026 05:56:31 -0800 (PST)
X-Received: by 2002:a05:6102:3a09:b0:5ff:20c5:cd6 with SMTP id
 ada2fe7eead31-5ff20c51797mr830098137.18.1772114190749; Thu, 26 Feb 2026
 05:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225125907.53851-1-amarkuze@redhat.com> <20260225125907.53851-2-amarkuze@redhat.com>
 <9687495100c02050c09c503fad1b840ddbfa313c.camel@redhat.com>
In-Reply-To: <9687495100c02050c09c503fad1b840ddbfa313c.camel@redhat.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 26 Feb 2026 15:56:20 +0200
X-Gm-Features: AaiRm50aLyjCETwKDojvUJBPiNoCYBibDGxffgYMF-j2AYy83taMK9QDUr26TaE
Message-ID: <CAO8a2SinY_+Ysn4Sx30x_mntLOCTLot0x3psU=DdEJCJ=VNJug@mail.gmail.com>
Subject: Re: [EXTERNAL] [RFC PATCH v1 1/4] ceph: convert inode flags to named
 bit positions
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: ceph-devel@vger.kernel.org, idryomov@gmail.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think I remember reviewing it, now that you mention it.
Let's discuss offline, I'll set up a 1x1.

On Wed, Feb 25, 2026 at 10:56=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redha=
t.com> wrote:
>
> On Wed, 2026-02-25 at 12:59 +0000, Alex Markuze wrote:
> > Define all CEPH_I_* flags as named bit positions with derived
> > bitmask values, making them usable with test_bit/set_bit/clear_bit.
> > Previously only CEPH_I_ODIRECT_BIT and CEPH_ASYNC_CREATE_BIT had
> > named bit positions; the rest were bare bitmask constants.
> >
>
> As I remember, I've reworked all constants for having name for every bit.
> Probably, this patch has ignored and it has never been sent to upstream. =
And I
> converted pretty everything for using test_bit/set_bit/clear_bit. :) You =
did
> this work again. :)
>
> Thanks,
> Slava.
>
> > Convert CEPH_I_ERROR_WRITE and CEPH_I_ERROR_FILELOCK usage sites
> > to use atomic bit operations (test_bit, set_bit, clear_bit) via
> > the new _BIT constants.
> >
> > This is preparation for the client reset feature which needs
> > test_bit() on CEPH_I_ERROR_FILELOCK_BIT in reconnect paths.
> >
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> > ---
> >  fs/ceph/locks.c      |  8 +++----
> >  fs/ceph/mds_client.c |  3 ++-
> >  fs/ceph/super.h      | 54 +++++++++++++++++++++++++++-----------------
> >  3 files changed, 38 insertions(+), 27 deletions(-)
> >
> > diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> > index dd764f9c64b9..2f21574dfb99 100644
> > --- a/fs/ceph/locks.c
> > +++ b/fs/ceph/locks.c
> > @@ -58,7 +58,7 @@ static void ceph_fl_release_lock(struct file_lock *fl=
)
> >       if (atomic_dec_and_test(&ci->i_filelock_ref)) {
> >               /* clear error when all locks are released */
> >               spin_lock(&ci->i_ceph_lock);
> > -             ci->i_ceph_flags &=3D ~CEPH_I_ERROR_FILELOCK;
> > +             clear_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
> >               spin_unlock(&ci->i_ceph_lock);
> >       }
> >       fl->fl_u.ceph.inode =3D NULL;
> > @@ -272,9 +272,8 @@ int ceph_lock(struct file *file, int cmd, struct fi=
le_lock *fl)
> >               wait =3D 1;
> >
> >       spin_lock(&ci->i_ceph_lock);
> > -     if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> > +     if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
> >               err =3D -EIO;
> > -     }
> >       spin_unlock(&ci->i_ceph_lock);
> >       if (err < 0) {
> >               if (op =3D=3D CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(f=
l))
> > @@ -332,9 +331,8 @@ int ceph_flock(struct file *file, int cmd, struct f=
ile_lock *fl)
> >       doutc(cl, "fl_file: %p\n", fl->c.flc_file);
> >
> >       spin_lock(&ci->i_ceph_lock);
> > -     if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> > +     if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags))
> >               err =3D -EIO;
> > -     }
> >       spin_unlock(&ci->i_ceph_lock);
> >       if (err < 0) {
> >               if (lock_is_unlock(fl))
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 23b6d00643c9..28bb27b09b40 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -3610,7 +3610,8 @@ static void __do_request(struct ceph_mds_client *=
mdsc,
> >
> >               spin_lock(&ci->i_ceph_lock);
> >               cap =3D ci->i_auth_cap;
> > -             if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds !=3D ca=
p->mds) {
> > +             if (test_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_flags) &&
> > +                 mds !=3D cap->mds) {
> >                       doutc(cl, "session changed for auth cap %d -> %d\=
n",
> >                             cap->session->s_mds, session->s_mds);
> >
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index 29a980e22dc2..69a71848240f 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -655,23 +655,35 @@ static inline struct inode *ceph_find_inode(struc=
t super_block *sb,
> >  /*
> >   * Ceph inode.
> >   */
> > -#define CEPH_I_DIR_ORDERED   (1 << 0)  /* dentries in dir are ordered =
*/
> > -#define CEPH_I_FLUSH         (1 << 2)  /* do not delay flush of dirty =
metadata */
> > -#define CEPH_I_POOL_PERM     (1 << 3)  /* pool rd/wr bits are valid */
> > -#define CEPH_I_POOL_RD               (1 << 4)  /* can read from pool *=
/
> > -#define CEPH_I_POOL_WR               (1 << 5)  /* can write to pool */
> > -#define CEPH_I_SEC_INITED    (1 << 6)  /* security initialized */
> > -#define CEPH_I_KICK_FLUSH    (1 << 7)  /* kick flushing caps */
> > -#define CEPH_I_FLUSH_SNAPS   (1 << 8)  /* need flush snapss */
> > -#define CEPH_I_ERROR_WRITE   (1 << 9) /* have seen write errors */
> > -#define CEPH_I_ERROR_FILELOCK        (1 << 10) /* have seen file lock =
errors */
> > -#define CEPH_I_ODIRECT_BIT   (11) /* inode in direct I/O mode */
> > -#define CEPH_I_ODIRECT               (1 << CEPH_I_ODIRECT_BIT)
> > -#define CEPH_ASYNC_CREATE_BIT        (12)      /* async create in flig=
ht for this */
> > -#define CEPH_I_ASYNC_CREATE  (1 << CEPH_ASYNC_CREATE_BIT)
> > -#define CEPH_I_SHUTDOWN              (1 << 13) /* inode is no longer u=
sable */
> > -#define CEPH_I_ASYNC_CHECK_CAPS      (1 << 14) /* check caps immediate=
ly after async
> > -                                          creating finishes */
> > +#define CEPH_I_DIR_ORDERED_BIT               (0)  /* dentries in dir a=
re ordered */
> > +#define CEPH_I_FLUSH_BIT             (2)  /* do not delay flush of dir=
ty metadata */
> > +#define CEPH_I_POOL_PERM_BIT         (3)  /* pool rd/wr bits are valid=
 */
> > +#define CEPH_I_POOL_RD_BIT           (4)  /* can read from pool */
> > +#define CEPH_I_POOL_WR_BIT           (5)  /* can write to pool */
> > +#define CEPH_I_SEC_INITED_BIT                (6)  /* security initiali=
zed */
> > +#define CEPH_I_KICK_FLUSH_BIT                (7)  /* kick flushing cap=
s */
> > +#define CEPH_I_FLUSH_SNAPS_BIT               (8)  /* need flush snapss=
 */
> > +#define CEPH_I_ERROR_WRITE_BIT               (9)  /* have seen write e=
rrors */
> > +#define CEPH_I_ERROR_FILELOCK_BIT    (10) /* have seen file lock error=
s */
> > +#define CEPH_I_ODIRECT_BIT           (11) /* inode in direct I/O mode =
*/
> > +#define CEPH_ASYNC_CREATE_BIT                (12) /* async create in f=
light for this */
> > +#define CEPH_I_SHUTDOWN_BIT          (13) /* inode is no longer usable=
 */
> > +#define CEPH_I_ASYNC_CHECK_CAPS_BIT  (14) /* check caps after async cr=
eating finishes */
> > +
> > +#define CEPH_I_DIR_ORDERED           (1 << CEPH_I_DIR_ORDERED_BIT)
> > +#define CEPH_I_FLUSH                 (1 << CEPH_I_FLUSH_BIT)
> > +#define CEPH_I_POOL_PERM             (1 << CEPH_I_POOL_PERM_BIT)
> > +#define CEPH_I_POOL_RD                       (1 << CEPH_I_POOL_RD_BIT)
> > +#define CEPH_I_POOL_WR                       (1 << CEPH_I_POOL_WR_BIT)
> > +#define CEPH_I_SEC_INITED            (1 << CEPH_I_SEC_INITED_BIT)
> > +#define CEPH_I_KICK_FLUSH            (1 << CEPH_I_KICK_FLUSH_BIT)
> > +#define CEPH_I_FLUSH_SNAPS           (1 << CEPH_I_FLUSH_SNAPS_BIT)
> > +#define CEPH_I_ERROR_WRITE           (1 << CEPH_I_ERROR_WRITE_BIT)
> > +#define CEPH_I_ERROR_FILELOCK                (1 << CEPH_I_ERROR_FILELO=
CK_BIT)
> > +#define CEPH_I_ODIRECT                       (1 << CEPH_I_ODIRECT_BIT)
> > +#define CEPH_I_ASYNC_CREATE          (1 << CEPH_ASYNC_CREATE_BIT)
> > +#define CEPH_I_SHUTDOWN                      (1 << CEPH_I_SHUTDOWN_BIT=
)
> > +#define CEPH_I_ASYNC_CHECK_CAPS              (1 << CEPH_I_ASYNC_CHECK_=
CAPS_BIT)
> >
> >  /*
> >   * Masks of ceph inode work.
> > @@ -691,18 +703,18 @@ static inline struct inode *ceph_find_inode(struc=
t super_block *sb,
> >   */
> >  static inline void ceph_set_error_write(struct ceph_inode_info *ci)
> >  {
> > -     if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE)) {
> > +     if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
> >               spin_lock(&ci->i_ceph_lock);
> > -             ci->i_ceph_flags |=3D CEPH_I_ERROR_WRITE;
> > +             set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
> >               spin_unlock(&ci->i_ceph_lock);
> >       }
> >  }
> >
> >  static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
> >  {
> > -     if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE) {
> > +     if (test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
> >               spin_lock(&ci->i_ceph_lock);
> > -             ci->i_ceph_flags &=3D ~CEPH_I_ERROR_WRITE;
> > +             clear_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
> >               spin_unlock(&ci->i_ceph_lock);
> >       }
> >  }
>

