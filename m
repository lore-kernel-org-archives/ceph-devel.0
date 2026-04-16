Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BEF18BC3B
	for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776343582; cv=pass; b=NiUU1lZ4j432VqtWKDcjYpneCCHRqqTQp37R3en1kCCHvde+j5whQUT2XV2sAfKrXfr/99ZJwzxX8gzi3f4DinHWNkfoMyvx/LFURVz1luEW5nMvawhZF41PSDVv7SwvUhr3bgeoCcQ/zXKA3e9lc11dsPjFfi0sEWHqiH6HFHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776343582; c=relaxed/simple;
	bh=1gc2xWM4rCFfwW+22M9oDH34nPiW4yHpXrh4OWFNN4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSHq+Fy5p9lEYa5BFxsmdbodoTzVc6ohJbV7rW7SgGlUeUODD5SNDojXVeoDkq3uxzU51bwN+xURgn/inS0wASIjNinK5A5U+tI+fwnGRsR4WGGIKZuW9OFrzmTwASuy8Ft6m3pWijW3Wx0Q7DvI9vHp6dDhOft7c768OnKu6Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjY/26aC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OLYYIGpB; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjY/26aC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLYYIGpB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776343579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5mGhP5NBnhRHcXUPs5pDjW6soyU5vmyQnwkdgjsrDQ=;
	b=ZjY/26aCbGicENwjp29JTlK1CaMfESSckJ18D7BhOvMTKd6l1X4/K1anj6BUpFQPHPoDZs
	Qw1sRnjRmJVeR4R1lXHNBBADjwDROpckLENkSBpTAZZT+L2HNc2egRmINguwyQin5WeduY
	A8GHssDaNArE18GrJdv3kycyhYtVeuI=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-VIoW11OzO7SBrDif7UwprA-1; Thu, 16 Apr 2026 08:46:18 -0400
X-MC-Unique: VIoW11OzO7SBrDif7UwprA-1
X-Mimecast-MFC-AGG-ID: VIoW11OzO7SBrDif7UwprA_1776343578
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-956a188d7baso605339241.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Apr 2026 05:46:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776343578; cv=none;
        d=google.com; s=arc-20240605;
        b=juN2kCknOaSynnlTS8APMQO7KoAaqYc+P678dyNvlH8WQvqISn74pXyqMpJfLJGk2n
         sYexmkh9uLu21bRBslYSL+VR4gUYs3BuWWKHYWbriqhLRuUxOOGYOlTGjdfQT0+eBmR/
         e7LtmkwFFEKlNptaWXIFSWVo89wUn74VgfsAHtO3MoYUWxapq5iHRml6CZAreQ9503B6
         7oIbdkQFsjEctYEOUEi6otJBNxtS0sDzAkxM6AFyWtRSK/CRxPXkAcD9Vb0DACR+2D6T
         0oWcHWDDvK+xjUGNvU0DZBzBK4rI3b3xRj/E3MvMIMJBjxMZBbhF0+ZPHqg1ubpEnbm5
         r/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5mGhP5NBnhRHcXUPs5pDjW6soyU5vmyQnwkdgjsrDQ=;
        fh=xMFqqtn3nOTgdN7AQgUPD8+FjUga8wgyYxyudv/dmC0=;
        b=D2iL5SEF50tTjLQQsovLEs5kiRbgpboYK10tBgHYeq9xCs4Xxh+sRxyh8sr3utfVH9
         OP8clUoU6ydI+7sULchUv+5UG8x2R2IOqNgnUaN5FJ1VIl9NEqj0DWWST9xFlnK+EhYT
         p8Z7UmTy+hWzZ0nrwwKsYx82M+Vy7spz3o03EaeDXEAotObXbygARJ8Rb07f11BIS9Qn
         kdu+Ju5ISl80ebR4sYKhxIj6g8IhvFkxrWnCiudjOL3LnZqMLgiDixFwR6nqmQSF2HQb
         iSDT/ZlWzKdPpcJYxu9D4Bz/uUY548cw+1fKtdEa0pE8x3OTCUoRF78qkUGN/YXxuIiA
         gNWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776343578; x=1776948378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5mGhP5NBnhRHcXUPs5pDjW6soyU5vmyQnwkdgjsrDQ=;
        b=OLYYIGpB299tWHEn2V0bbnQ1D74qRec59Hfq2K7GpYUBUa9PZgqisKzqX+ci7dBLYs
         sr88OzyTkJyd0aeMVWjAvA84hgkW1NaDOTOUCvLJUN+AHiCb8rZDatiCgpmihz+Uo7aX
         vE7J99fYBQipskD4n0b9cevOQoOYdYF3wFV+5lI/7ypuqGB8ga18h/gZFh/RT5vebTHl
         5MqaM0c5N/fH+JFC+rR5s0sv3+hJq2ItFu1yOSSIUe7OTMlW4PbvrU6THvR37SyOvHeW
         N9MyeWymyI82mz7aDP4GzfisaIXi0LQkRWn5P0p4iIHE3wd0o2noSJyuaMPpTWNZBjHo
         G0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776343578; x=1776948378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5mGhP5NBnhRHcXUPs5pDjW6soyU5vmyQnwkdgjsrDQ=;
        b=bXIRxMea1bmSxJmu+SlJKPQ+OzYrDDQHiB32vKySmakylmjYfZgag7ECqMRqFbCHQF
         wJgqB7Z2WjPG2EOvU2V1SHecOmX4LXgiVq+0+aGk0yCfwjnXesS3hANvmqr4hXrJJvQT
         F03dv+Qg8ID6dIe/AyO5u5WRKseuLpl+P/Izmvmea1uZXjK7E+dO7X/AKoY5JawdyrZo
         2dOiY/d86I7ul2bTEYMtTcvXDq9vElZiy5ATDeRa6YTS1ejkBCEOpg7474f9fGHscWFJ
         wqoDWm70ybwUc9HzS8gLFlXDDUELjyb8rteiLV2LOwsyUK976viecWipOpECQZ0Ia6oq
         vLTw==
X-Gm-Message-State: AOJu0Yx42ITzlBgBj3WEt6vvxFpeQyad+2lkSa0oGGV1ZurnB2WnMNdq
	lWOl3S6vlo7BNoGSUw/wLoba8cyH8NJbN4qYkVryBXc8vt2lumiocoKLFZgz2jDjkV7S/8Y0Rzq
	/1xoooRcg/I0oalfDEJYVk9g2ZSvkD6Qe0KxNqfU7HjdU5k9da7XduR0J74yP9EtV34sHajHiyu
	5TcMaTxgRkMlei4mjxwwrAnFWPEI6RLfwkHJatsg==
X-Gm-Gg: AeBDieu8L1/NO23tBUVS8X8appnq7/we8R9mXfRGaCQFHngHrRbUaZnc/xzYzo/YAwE
	3+//aYw0YAI15QzbmLq/4cS/V2Dg4ChdAg04L7Gg8ZP4EAhnca6eRcD8baXzvp6s6Y4a3gtrmwJ
	jhxBewc4j6MiMfd7O8mVWJ/IwpW2NaQzw2d5rSjWAmrdIkk69AbYikeTtVPYD7mDMa3crCcTiPD
	j1gpTbVw79kaP01
X-Received: by 2002:a67:e709:0:b0:612:db83:aa8 with SMTP id ada2fe7eead31-6146cb4932bmr386150137.6.1776343576962;
        Thu, 16 Apr 2026 05:46:16 -0700 (PDT)
X-Received: by 2002:a67:e709:0:b0:612:db83:aa8 with SMTP id
 ada2fe7eead31-6146cb4932bmr386137137.6.1776343576286; Thu, 16 Apr 2026
 05:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415170043.3882912-1-amarkuze@redhat.com> <20260415170043.3882912-2-amarkuze@redhat.com>
 <d2d748b9cb329c5cc066e8343570f0ca77e81884.camel@redhat.com>
In-Reply-To: <d2d748b9cb329c5cc066e8343570f0ca77e81884.camel@redhat.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 16 Apr 2026 15:46:05 +0300
X-Gm-Features: AQROBzBCT9tIxUQtJds3sQDYbY5gSmFhad22kLsn7IM2f5etHfRWtMSvHeOs3B4
Message-ID: <CAO8a2SgNkwr9YDHo25Mw5duMQkAgU_hYMARVdeqTDtkgd8YaWA@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH v2 1/7] ceph: convert inode flags to named bit
 positions and atomic bitops
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	idryomov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  =E2=96=8E Is it correct removal? It looks like a bug to me. Should we do =
this
  =E2=96=8E inside of spin_lock section but before any operations with flag=
s?
  =E2=96=8E It looks like that ceph_pool_perm_check() can read stale
  =E2=96=8E POOL_RD/POOL_WR bits.

  No stale read.  The old code precomputed flags outside the lock
  and applied it with ci->i_ceph_flags |=3D flags inside.  The new
  code does the individual set_bit() calls inside the lock, and then
  re-reads flags =3D ci->i_ceph_flags at line 2597 -- still under
  the lock -- before jumping to check:.  The check: label tests
  the local flags copy which was loaded under the lock, so it
  always sees the freshly-set bits.

  The old precompute-outside-lock pattern actually had a subtler
  issue: between computing flags and acquiring the spinlock, a
  concurrent clear_bit(POOL_PERM_BIT) from handle_cap_grant()
  could race, and the subsequent |=3D would silently re-set the
  POOL_PERM bit.  The new code avoids that entirely.

  =E2=96=8E I am not sure that it could be a problem but we call
  =E2=96=8E clear_and_wake_up_bit() and only then call test_and_clear_bit()=
.
  =E2=96=8E I think spin_lock() should protect from potential races.

  That's true, both calls are under i_ceph_lock so they are
  serialized.  They operate on different bits (ASYNC_CREATE vs
  ASYNC_CHECK_CAPS).  So there is no race.

  =E2=96=8E Maybe, we need to consider something like this?
  =E2=96=8E
  =E2=96=8E   if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags))
  =E2=96=8E       set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);

  set_bit() on an already-set bit is a hardware no-op on x86
  (lock bts).  Adding a test-before-set branch adds a conditional
  that is redundant since set_bit() already reads the cache line.
  The old READ_ONCE + spinlock guard existed because the non-atomic
  |=3D needed the lock; now that we use atomic set_bit() the guard
  is unnecessary.  This is a hint flag where the comment explicitly
  says "we're not too worried if a few slip through in either
  direction", so the extra branch buys nothing.

  NAK on this one, we should keep it as a plain set_bit().

  =E2=96=8E Why not to use the CEPH_I_SHUTDOWN_BIT here?

  Good catch.  I'll restore the CEPH_I_SHUTDOWN mask define in v3
  so ceph_inode_is_shutdown() can use the named constant instead
  of the inline BIT().  The READ_ONCE snapshot + bitmask test is
  the right pattern for this reader; it just needs the named mask.

  Thanks for the review.

  Alex

On Wed, Apr 15, 2026 at 10:54=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redha=
t.com> wrote:
>
> On Wed, 2026-04-15 at 17:00 +0000, Alex Markuze wrote:
> > Define named bit-position constants for all CEPH_I_* inode flags and
> > derive the bitmask values from them.  This gives every flag a named
> > _BIT constant usable with the test_bit/set_bit/clear_bit family.
> > The intentionally unused bit position 1 is documented inline.
> >
> > Convert all flag modifications to use atomic bitops (set_bit,
> > clear_bit, test_and_clear_bit).  The previous code mixed lockless
> > atomic ops on some flags (ERROR_WRITE, ODIRECT) with non-atomic
> > read-modify-write (|=3D / &=3D ~) on other flags sharing the same
> > unsigned long.  A concurrent non-atomic RMW can clobber an
> > adjacent lockless atomic update -- for example, a lockless
> > clear_bit(ERROR_WRITE) could be silently resurrected by a
> > concurrent ci->i_ceph_flags |=3D CEPH_I_FLUSH under the spinlock.
> > Using atomic bitops for all modifications eliminates this class
> > of race entirely.
> >
> > Flags whose only users are now the _BIT form (ERROR_WRITE,
> > ERROR_FILELOCK, SHUTDOWN, ASYNC_CHECK_CAPS) have their old mask
> > defines removed to document that callers must use the _BIT
> > constant with the set_bit/test_bit family.
> >
> > Flag reads under i_ceph_lock continue to use bitmask tests where
> > the tested flag is only modified under the same lock; this is safe
> > because the lock serialises both the read and the write.  The
> > remaining flags continue to use non-atomic bitmask operations under
> > i_ceph_lock, which is correct and unchanged.
> >
> > The lockless reader ceph_inode_is_shutdown() retains the READ_ONCE()
> > snapshot plus bitmask test pattern -- the single atomic load into a
> > local variable is correct and avoids a second memory access that
> > test_bit() would require.
> >
> > The direct assignment in ceph_finish_async_create() is converted
> > from i_ceph_flags =3D CEPH_I_ASYNC_CREATE to set_bit().  This
> > inode is I_NEW at this point -- still invisible to other threads
> > and guaranteed to have zero flags from alloc_inode -- so either
> > form is safe, but set_bit() keeps the conversion uniform.
> >
> > The only remaining direct assignment (alloc_inode zeroing) operates
> > on an inode that is not yet visible to other threads, so it is safe
> > without atomic ops.
> >
> > The dead precomputed flags variable in ceph_pool_perm_check() is
> > removed; the check: loop re-reads flags from i_ceph_flags after
> > the set_bit() calls, keeping a single source of truth.
> >
> > Co-developed-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
> > Signed-off-by: Viacheslav Dubeyko <vdubeyko@redhat.com>
> > Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> > ---
> >  fs/ceph/addr.c       | 16 +++++------
> >  fs/ceph/caps.c       | 24 ++++++++---------
> >  fs/ceph/file.c       | 12 ++++-----
> >  fs/ceph/inode.c      |  4 +--
> >  fs/ceph/locks.c      | 22 ++++-----------
> >  fs/ceph/mds_client.c |  3 ++-
> >  fs/ceph/mds_client.h |  2 +-
> >  fs/ceph/snap.c       |  2 +-
> >  fs/ceph/super.h      | 64 ++++++++++++++++++++++----------------------
> >  fs/ceph/xattr.c      |  2 +-
> >  10 files changed, 69 insertions(+), 82 deletions(-)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 2090fc78529c..bde9efffa228 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -2583,20 +2583,18 @@ int ceph_pool_perm_check(struct inode *inode, i=
nt need)
> >       if (ret < 0)
> >               return ret;
> >
> > -     flags =3D CEPH_I_POOL_PERM;
> > -     if (ret & POOL_READ)
> > -             flags |=3D CEPH_I_POOL_RD;
> > -     if (ret & POOL_WRITE)
> > -             flags |=3D CEPH_I_POOL_WR;
> > -
>
> Is it correct removal? It looks like a bug to me. Should we do this insid=
e of
> spin_lock section but before any operations with flags? It looks like tha=
t
> ceph_pool_perm_check() can read stale POOL_RD/POOL_WR bits.
>
> >       spin_lock(&ci->i_ceph_lock);
> >       if (pool =3D=3D ci->i_layout.pool_id &&
> >           pool_ns =3D=3D rcu_dereference_raw(ci->i_layout.pool_ns)) {
> > -             ci->i_ceph_flags |=3D flags;
> > -        } else {
> > +             set_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags);
> > +             if (ret & POOL_READ)
> > +                     set_bit(CEPH_I_POOL_RD_BIT, &ci->i_ceph_flags);
> > +             if (ret & POOL_WRITE)
> > +                     set_bit(CEPH_I_POOL_WR_BIT, &ci->i_ceph_flags);
> > +     } else {
> >               pool =3D ci->i_layout.pool_id;
> > -             flags =3D ci->i_ceph_flags;
> >       }
> > +     flags =3D ci->i_ceph_flags;
> >       spin_unlock(&ci->i_ceph_lock);
> >       goto check;
> >  }
> > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > index d51454e995a8..cb9e78b713d9 100644
> > --- a/fs/ceph/caps.c
> > +++ b/fs/ceph/caps.c
> > @@ -549,7 +549,7 @@ static void __cap_delay_requeue_front(struct ceph_m=
ds_client *mdsc,
> >
> >       doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode, ceph_vinop(inod=
e));
> >       spin_lock(&mdsc->cap_delay_lock);
> > -     ci->i_ceph_flags |=3D CEPH_I_FLUSH;
> > +     set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
> >       if (!list_empty(&ci->i_cap_delay_list))
> >               list_del_init(&ci->i_cap_delay_list);
> >       list_add(&ci->i_cap_delay_list, &mdsc->cap_delay_list);
> > @@ -1409,7 +1409,7 @@ static void __prep_cap(struct cap_msg_args *arg, =
struct ceph_cap *cap,
> >             ceph_cap_string(revoking));
> >       BUG_ON((retain & CEPH_CAP_PIN) =3D=3D 0);
> >
> > -     ci->i_ceph_flags &=3D ~CEPH_I_FLUSH;
> > +     clear_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
> >
> >       cap->issued &=3D retain;  /* drop bits we don't want */
> >       /*
> > @@ -1666,7 +1666,7 @@ static void __ceph_flush_snaps(struct ceph_inode_=
info *ci,
> >               last_tid =3D capsnap->cap_flush.tid;
> >       }
> >
> > -     ci->i_ceph_flags &=3D ~CEPH_I_FLUSH_SNAPS;
> > +     clear_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
> >
> >       while (first_tid <=3D last_tid) {
> >               struct ceph_cap *cap =3D ci->i_auth_cap;
> > @@ -2026,7 +2026,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, =
int flags)
> >
> >       spin_lock(&ci->i_ceph_lock);
> >       if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
> > -             ci->i_ceph_flags |=3D CEPH_I_ASYNC_CHECK_CAPS;
> > +             set_bit(CEPH_I_ASYNC_CHECK_CAPS_BIT, &ci->i_ceph_flags);
> >
> >               /* Don't send messages until we get async create reply */
> >               spin_unlock(&ci->i_ceph_lock);
> > @@ -2577,7 +2577,7 @@ static void __kick_flushing_caps(struct ceph_mds_=
client *mdsc,
> >       if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE)
> >               return;
> >
> > -     ci->i_ceph_flags &=3D ~CEPH_I_KICK_FLUSH;
> > +     clear_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags);
> >
> >       list_for_each_entry_reverse(cf, &ci->i_cap_flush_list, i_list) {
> >               if (cf->is_capsnap) {
> > @@ -2686,7 +2686,7 @@ void ceph_early_kick_flushing_caps(struct ceph_md=
s_client *mdsc,
> >                       __kick_flushing_caps(mdsc, session, ci,
> >                                            oldest_flush_tid);
> >               } else {
> > -                     ci->i_ceph_flags |=3D CEPH_I_KICK_FLUSH;
> > +                     set_bit(CEPH_I_KICK_FLUSH_BIT, &ci->i_ceph_flags)=
;
> >               }
> >
> >               spin_unlock(&ci->i_ceph_lock);
> > @@ -2829,7 +2829,7 @@ static int try_get_cap_refs(struct inode *inode, =
int need, int want,
> >       spin_lock(&ci->i_ceph_lock);
> >
> >       if ((flags & CHECK_FILELOCK) &&
> > -         (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK)) {
> > +         test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
> >               doutc(cl, "%p %llx.%llx error filelock\n", inode,
> >                     ceph_vinop(inode));
> >               ret =3D -EIO;
> > @@ -3207,7 +3207,7 @@ static int ceph_try_drop_cap_snap(struct ceph_ino=
de_info *ci,
> >               BUG_ON(capsnap->cap_flush.tid > 0);
> >               ceph_put_snap_context(capsnap->context);
> >               if (!list_is_last(&capsnap->ci_item, &ci->i_cap_snaps))
> > -                     ci->i_ceph_flags |=3D CEPH_I_FLUSH_SNAPS;
> > +                     set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags=
);
> >
> >               list_del(&capsnap->ci_item);
> >               ceph_put_cap_snap(capsnap);
> > @@ -3396,7 +3396,7 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode=
_info *ci, int nr,
> >                               if (ceph_try_drop_cap_snap(ci, capsnap)) =
{
> >                                       put++;
> >                               } else {
> > -                                     ci->i_ceph_flags |=3D CEPH_I_FLUS=
H_SNAPS;
> > +                                     set_bit(CEPH_I_FLUSH_SNAPS_BIT, &=
ci->i_ceph_flags);
> >                                       flush_snaps =3D true;
> >                               }
> >                       }
> > @@ -3648,7 +3648,7 @@ static void handle_cap_grant(struct inode *inode,
> >
> >               if (ci->i_layout.pool_id !=3D old_pool ||
> >                   extra_info->pool_ns !=3D old_ns)
> > -                     ci->i_ceph_flags &=3D ~CEPH_I_POOL_PERM;
> > +                     clear_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags=
);
> >
> >               extra_info->pool_ns =3D old_ns;
> >
> > @@ -4815,7 +4815,7 @@ int ceph_drop_caps_for_unlink(struct inode *inode=
)
> >                       doutc(mdsc->fsc->client, "%p %llx.%llx\n", inode,
> >                             ceph_vinop(inode));
> >                       spin_lock(&mdsc->cap_delay_lock);
> > -                     ci->i_ceph_flags |=3D CEPH_I_FLUSH;
> > +                     set_bit(CEPH_I_FLUSH_BIT, &ci->i_ceph_flags);
> >                       if (!list_empty(&ci->i_cap_delay_list))
> >                               list_del_init(&ci->i_cap_delay_list);
> >                       list_add_tail(&ci->i_cap_delay_list,
> > @@ -5080,7 +5080,7 @@ int ceph_purge_inode_cap(struct inode *inode, str=
uct ceph_cap *cap, bool *invali
> >
> >               if (atomic_read(&ci->i_filelock_ref) > 0) {
> >                       /* make further file lock syscall return -EIO */
> > -                     ci->i_ceph_flags |=3D CEPH_I_ERROR_FILELOCK;
> > +                     set_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_fl=
ags);
> >                       pr_warn_ratelimited_client(cl,
> >                               " dropping file locks for %p %llx.%llx\n"=
,
> >                               inode, ceph_vinop(inode));
> > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > index 5e7c73a29aa3..2b457dab0837 100644
> > --- a/fs/ceph/file.c
> > +++ b/fs/ceph/file.c
> > @@ -579,12 +579,11 @@ static void wake_async_create_waiters(struct inod=
e *inode,
> >
> >       spin_lock(&ci->i_ceph_lock);
> >       if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE) {
> > -             clear_and_wake_up_bit(CEPH_ASYNC_CREATE_BIT, &ci->i_ceph_=
flags);
> > +             clear_and_wake_up_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_cep=
h_flags);
> >
> > -             if (ci->i_ceph_flags & CEPH_I_ASYNC_CHECK_CAPS) {
> > -                     ci->i_ceph_flags &=3D ~CEPH_I_ASYNC_CHECK_CAPS;
> > +             if (test_and_clear_bit(CEPH_I_ASYNC_CHECK_CAPS_BIT,
> > +                                   &ci->i_ceph_flags))
>
> I am not sure that it could be a problem but we call clear_and_wake_up_bi=
t() and
> only then call test_and_clear_bit(). I think spin_lock() should protect f=
rom
> potential races.
>
> >                       check_cap =3D true;
> > -             }
> >       }
> >       ceph_kick_flushing_inode_caps(session, ci);
> >       spin_unlock(&ci->i_ceph_lock);
> > @@ -747,7 +746,8 @@ static int ceph_finish_async_create(struct inode *d=
ir, struct inode *inode,
> >                        * that point and don't worry about setting
> >                        * CEPH_I_ASYNC_CREATE.
> >                        */
> > -                     ceph_inode(inode)->i_ceph_flags =3D CEPH_I_ASYNC_=
CREATE;
> > +                     set_bit(CEPH_I_ASYNC_CREATE_BIT,
> > +                             &ceph_inode(inode)->i_ceph_flags);
> >                       unlock_new_inode(inode);
> >               }
> >               if (d_in_lookup(dentry) || d_really_is_negative(dentry)) =
{
> > @@ -2422,7 +2422,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb=
, struct iov_iter *from)
> >
> >       if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) =3D=3D 0 =
||
> >           (iocb->ki_flags & IOCB_DIRECT) || (fi->flags & CEPH_F_SYNC) |=
|
> > -         (ci->i_ceph_flags & CEPH_I_ERROR_WRITE)) {
> > +         test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags)) {
> >               struct ceph_snap_context *snapc;
> >               struct iov_iter data;
> >
> > diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
> > index d99e12d1100b..f75d66760d54 100644
> > --- a/fs/ceph/inode.c
> > +++ b/fs/ceph/inode.c
> > @@ -1142,7 +1142,7 @@ int ceph_fill_inode(struct inode *inode, struct p=
age *locked_page,
> >               rcu_assign_pointer(ci->i_layout.pool_ns, pool_ns);
> >
> >               if (ci->i_layout.pool_id !=3D old_pool || pool_ns !=3D ol=
d_ns)
> > -                     ci->i_ceph_flags &=3D ~CEPH_I_POOL_PERM;
> > +                     clear_bit(CEPH_I_POOL_PERM_BIT, &ci->i_ceph_flags=
);
> >
> >               pool_ns =3D old_ns;
> >
> > @@ -3199,7 +3199,7 @@ void ceph_inode_shutdown(struct inode *inode)
> >       bool invalidate =3D false;
> >
> >       spin_lock(&ci->i_ceph_lock);
> > -     ci->i_ceph_flags |=3D CEPH_I_SHUTDOWN;
> > +     set_bit(CEPH_I_SHUTDOWN_BIT, &ci->i_ceph_flags);
> >       p =3D rb_first(&ci->i_caps);
> >       while (p) {
> >               struct ceph_cap *cap =3D rb_entry(p, struct ceph_cap, ci_=
node);
> > diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
> > index dd764f9c64b9..c4ff2266bb94 100644
> > --- a/fs/ceph/locks.c
> > +++ b/fs/ceph/locks.c
> > @@ -57,9 +57,7 @@ static void ceph_fl_release_lock(struct file_lock *fl=
)
> >       ci =3D ceph_inode(inode);
> >       if (atomic_dec_and_test(&ci->i_filelock_ref)) {
> >               /* clear error when all locks are released */
> > -             spin_lock(&ci->i_ceph_lock);
> > -             ci->i_ceph_flags &=3D ~CEPH_I_ERROR_FILELOCK;
> > -             spin_unlock(&ci->i_ceph_lock);
> > +             clear_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags);
> >       }
> >       fl->fl_u.ceph.inode =3D NULL;
> >       iput(inode);
> > @@ -271,15 +269,10 @@ int ceph_lock(struct file *file, int cmd, struct =
file_lock *fl)
> >       else if (IS_SETLKW(cmd))
> >               wait =3D 1;
> >
> > -     spin_lock(&ci->i_ceph_lock);
> > -     if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> > -             err =3D -EIO;
> > -     }
> > -     spin_unlock(&ci->i_ceph_lock);
> > -     if (err < 0) {
> > +     if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
> >               if (op =3D=3D CEPH_MDS_OP_SETFILELOCK && lock_is_unlock(f=
l))
> >                       posix_lock_file(file, fl, NULL);
> > -             return err;
> > +             return -EIO;
> >       }
> >
> >       if (lock_is_read(fl))
> > @@ -331,15 +324,10 @@ int ceph_flock(struct file *file, int cmd, struct=
 file_lock *fl)
> >
> >       doutc(cl, "fl_file: %p\n", fl->c.flc_file);
> >
> > -     spin_lock(&ci->i_ceph_lock);
> > -     if (ci->i_ceph_flags & CEPH_I_ERROR_FILELOCK) {
> > -             err =3D -EIO;
> > -     }
> > -     spin_unlock(&ci->i_ceph_lock);
> > -     if (err < 0) {
> > +     if (test_bit(CEPH_I_ERROR_FILELOCK_BIT, &ci->i_ceph_flags)) {
> >               if (lock_is_unlock(fl))
> >                       locks_lock_file_wait(file, fl);
> > -             return err;
> > +             return -EIO;
> >       }
> >
> >       if (IS_SETLKW(cmd))
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index b1746273f186..ccf0d53dde2b 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -3613,7 +3613,8 @@ static void __do_request(struct ceph_mds_client *=
mdsc,
> >
> >               spin_lock(&ci->i_ceph_lock);
> >               cap =3D ci->i_auth_cap;
> > -             if (ci->i_ceph_flags & CEPH_I_ASYNC_CREATE && mds !=3D ca=
p->mds) {
> > +             if (test_bit(CEPH_I_ASYNC_CREATE_BIT, &ci->i_ceph_flags) =
&&
> > +                 mds !=3D cap->mds) {
> >                       doutc(cl, "session changed for auth cap %d -> %d\=
n",
> >                             cap->session->s_mds, session->s_mds);
> >
> > diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
> > index 0428a5eaf28c..e91a199d56fd 100644
> > --- a/fs/ceph/mds_client.h
> > +++ b/fs/ceph/mds_client.h
> > @@ -658,7 +658,7 @@ static inline int ceph_wait_on_async_create(struct =
inode *inode)
> >  {
> >       struct ceph_inode_info *ci =3D ceph_inode(inode);
> >
> > -     return wait_on_bit(&ci->i_ceph_flags, CEPH_ASYNC_CREATE_BIT,
> > +     return wait_on_bit(&ci->i_ceph_flags, CEPH_I_ASYNC_CREATE_BIT,
> >                          TASK_KILLABLE);
> >  }
> >
> > diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
> > index 52b4c2684f92..9b79a5eaca93 100644
> > --- a/fs/ceph/snap.c
> > +++ b/fs/ceph/snap.c
> > @@ -700,7 +700,7 @@ int __ceph_finish_cap_snap(struct ceph_inode_info *=
ci,
> >               return 0;
> >       }
> >
> > -     ci->i_ceph_flags |=3D CEPH_I_FLUSH_SNAPS;
> > +     set_bit(CEPH_I_FLUSH_SNAPS_BIT, &ci->i_ceph_flags);
> >       doutc(cl, "%p %llx.%llx cap_snap %p snapc %p %llu %s s=3D%llu\n",
> >             inode, ceph_vinop(inode), capsnap, capsnap->context,
> >             capsnap->context->seq, ceph_cap_string(capsnap->dirty),
> > diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> > index 29a980e22dc2..c89ad8dcc969 100644
> > --- a/fs/ceph/super.h
> > +++ b/fs/ceph/super.h
> > @@ -655,23 +655,32 @@ static inline struct inode *ceph_find_inode(struc=
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
> > +                                          /* bit 1 historically unused=
 */
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
> > +#define CEPH_I_FLUSH_SNAPS_BIT               (8)  /* need flush snaps =
*/
> > +#define CEPH_I_ERROR_WRITE_BIT               (9)  /* have seen write e=
rrors */
> > +#define CEPH_I_ERROR_FILELOCK_BIT    (10) /* have seen file lock error=
s */
> > +#define CEPH_I_ODIRECT_BIT           (11) /* inode in direct I/O mode =
*/
> > +#define CEPH_I_ASYNC_CREATE_BIT              (12) /* async create in f=
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
> > +#define CEPH_I_ODIRECT                       (1 << CEPH_I_ODIRECT_BIT)
> > +#define CEPH_I_ASYNC_CREATE          (1 << CEPH_I_ASYNC_CREATE_BIT)
> >
> >  /*
> >   * Masks of ceph inode work.
> > @@ -684,27 +693,18 @@ static inline struct inode *ceph_find_inode(struc=
t super_block *sb,
> >
> >  /*
> >   * We set the ERROR_WRITE bit when we start seeing write errors on an =
inode
> > - * and then clear it when they start succeeding. Note that we do a loc=
kless
> > - * check first, and only take the lock if it looks like it needs to be=
 changed.
> > - * The write submission code just takes this as a hint, so we're not t=
oo
> > - * worried if a few slip through in either direction.
> > + * and then clear it when they start succeeding. The write submission =
code
> > + * just takes this as a hint, so we're not too worried if a few slip t=
hrough
> > + * in either direction.
> >   */
> >  static inline void ceph_set_error_write(struct ceph_inode_info *ci)
> >  {
> > -     if (!(READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE)) {
> > -             spin_lock(&ci->i_ceph_lock);
> > -             ci->i_ceph_flags |=3D CEPH_I_ERROR_WRITE;
> > -             spin_unlock(&ci->i_ceph_lock);
> > -     }
> > +     set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
> >  }
>
> Maybe, we need to consider something like this?
>
>   static inline void ceph_set_error_write(struct ceph_inode_info *ci)
>   {
>       if (!test_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags))
>           set_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
>   }
>
> >
> >  static inline void ceph_clear_error_write(struct ceph_inode_info *ci)
> >  {
> > -     if (READ_ONCE(ci->i_ceph_flags) & CEPH_I_ERROR_WRITE) {
> > -             spin_lock(&ci->i_ceph_lock);
> > -             ci->i_ceph_flags &=3D ~CEPH_I_ERROR_WRITE;
> > -             spin_unlock(&ci->i_ceph_lock);
> > -     }
> > +     clear_bit(CEPH_I_ERROR_WRITE_BIT, &ci->i_ceph_flags);
> >  }
> >
> >  static inline void __ceph_dir_set_complete(struct ceph_inode_info *ci,
> > @@ -1142,7 +1142,7 @@ static inline bool ceph_inode_is_shutdown(struct =
inode *inode)
> >       struct ceph_fs_client *fsc =3D ceph_inode_to_fs_client(inode);
> >       int state =3D READ_ONCE(fsc->mount_state);
> >
> > -     return (flags & CEPH_I_SHUTDOWN) || state >=3D CEPH_MOUNT_SHUTDOW=
N;
> > +     return (flags & BIT(CEPH_I_SHUTDOWN_BIT)) || state >=3D CEPH_MOUN=
T_SHUTDOWN;
>
> Why not to use the CEPH_I_SHUTDOWN_BIT here?
>
> Thanks,
> Slava.
>
> >  }
> >
> >  /* xattr.c */
> > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> > index 5f87f62091a1..7cf9e908c2fe 100644
> > --- a/fs/ceph/xattr.c
> > +++ b/fs/ceph/xattr.c
> > @@ -1054,7 +1054,7 @@ ssize_t __ceph_getxattr(struct inode *inode, cons=
t char *name, void *value,
> >       if (current->journal_info &&
> >           !strncmp(name, XATTR_SECURITY_PREFIX, XATTR_SECURITY_PREFIX_L=
EN) &&
> >           security_ismaclabel(name + XATTR_SECURITY_PREFIX_LEN))
> > -             ci->i_ceph_flags |=3D CEPH_I_SEC_INITED;
> > +             set_bit(CEPH_I_SEC_INITED_BIT, &ci->i_ceph_flags);
> >  out:
> >       spin_unlock(&ci->i_ceph_lock);
> >       return err;
>

