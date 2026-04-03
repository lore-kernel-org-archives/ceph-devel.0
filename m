Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386F3CE48B
	for <ceph-devel@vger.kernel.org>; Fri,  3 Apr 2026 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775236710; cv=none; b=ijccwIBPn8Z6fu6QXovBUbqXYz9AlzEgWmkZN+2NjV0Qs2EI2JMA1WUFzcL3AQ3DpYKFelsKkMUxaa0fWhrkTd5+d+8dvWLzq1irJVdsGx16WBBz7vhLpUnygymXL4TsPttXwOYd3qgueJjQkSiaTKLmmarB++p0c2KiJ4hwa1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775236710; c=relaxed/simple;
	bh=Cvq5tuLj5ZY1DMhHPFEu+lE7/fw/C+ofjPzqyp3q+wU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DVkotZNDW8266F5xfBl6vI3t/d64GzM9mtiRiyTvlfQ/AGxMKpI8k2wmKhevjaquBs7FKEbNd7R0LXtJdPVPzyFs4m6R2bSvkLT24vX3wOot9uy4nPa+TvGZtu1iS80KTTbjjPgKelTkaxEVRpvmtsEwI4+QdjEswWPXp+REWxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNGGs2Ul; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TtGG9Fuc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNGGs2Ul";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtGG9Fuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775236707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QTtM7wHX05jakm5x7iALH4OzPfU5pZiWtOLbV28TT+g=;
	b=fNGGs2UlN5izdB9OhYDKL3ltSU7qV+ANEljaxcJ0f1FBJg12J1Qxd3PbV1BuF/yKfPWOS2
	O1d2BHaRB0ytPJUurBRHzaaOchd7gI65+1YQazfMZD12Rpv0EH5ZBahzDGZIE9MR5I++VN
	U60miAeQ8HoGNKO4gJwPFikOQwY3CCo=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-JmBTY-pGPEmWfcJfzyyGIA-1; Fri, 03 Apr 2026 13:18:25 -0400
X-MC-Unique: JmBTY-pGPEmWfcJfzyyGIA-1
X-Mimecast-MFC-AGG-ID: JmBTY-pGPEmWfcJfzyyGIA_1775236705
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-464bbea2120so3819787b6e.3
        for <ceph-devel@vger.kernel.org>; Fri, 03 Apr 2026 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775236705; x=1775841505; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QTtM7wHX05jakm5x7iALH4OzPfU5pZiWtOLbV28TT+g=;
        b=TtGG9Fucx42gRq8YjpM3ui2Nst/fsorIKywH60Rh4WbYVx96mVVhI/HT4BZD+3wZdn
         IB6AHTkwQUePPRMnemvnTRKs9jIfqMOm6HMnx7DXoAMXCfgBEWvb+RpDZ0uWIq8mLONC
         ZkuP2VmOFbzEc54BTqb4sxvcovtYLpPdm1OWQsfEmRo2YCMAmhKh8IWsLUXypYE1J+KM
         SoEm304HAzVibXjVzd9dQjCfhR/3Qmse0JY5KGT8x26wOOgbdvvLum2hQp+ZsbIVCZQj
         K/Nw8FKvPMNA4oTwsY09s5LNAiBi9zq0zQGcBzBwKdH0S0YpujaXqif6YaOBlB3SLqUM
         R8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775236705; x=1775841505;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTtM7wHX05jakm5x7iALH4OzPfU5pZiWtOLbV28TT+g=;
        b=lsRNTcsn5Q69dz3GE4/eoYm1BIyVoD9ufW3hcVXgIhEWdivZNp2UqLeIDHXh6glt8t
         dAkDVRt2n2dJfvdyO2OcgnjrGRBVAVRCD3cqtArGHdR2OiA30le15tbtvZRL0+kNnfcV
         T4h441VHFJBxszZhH8q8E5uyPEj9ZJE1JDCTBkw7TTvBKxf6ldjAmZqjF39rU0DcGJUy
         b82r0y+J4+376xYnpcPNd+hhRyMFCQjFukFlOy1lDLRDHsawy2WOSP2dZo8+M+0gQ+fs
         MQAFpNpKlxlaklgmW4qiDgT3ieQDnlhBISki8slDsb/Jflu3dLjouq1R9LzRUY9KMWd/
         cKBA==
X-Forwarded-Encrypted: i=1; AJvYcCV01GU1/KQ8SBx9qI9FUcA3qKRuwFE9kF9eNHJuchlRt0BeivqsxSlmIlEgedqnIROXh2/Rp0zT8hyA@vger.kernel.org
X-Gm-Message-State: AOJu0YzADIKwivvvQB7/tEjyDc51RtA6XMekJk5eXQT0JeS3arIKpAad
	Cniy4QSZPelLHwT3qXqKdKzNhyCzqVUWp2QFQ8PSye90YNpvWIa1ELplz7+FTqBcWNtVOVsL3/k
	HI+/l3MkIDs8W3O55Mc4vWGOSt1crEZRmzvpxSYRqYj9OoRo2MuqcWiMF2hgLdw8=
X-Gm-Gg: ATEYQzzm7woBtDjumWZWrxIryDe5wiv+wFoYXtJknojhafW7KYYjHclmdTjryiuw9WD
	1jy/IWgpD/t36iqaR8fdARnNW46QVUn1tFfb2mQEXUEyz5qBRnb97P5Ur0gPU5MhBucTZosSYS4
	5oRiHi7VLOC9GyBuVM1Mn4s+eD2MgNrm6UgaWrq4pMnsgm0bR6YaEiKb7G5VqTuwvje0EDEqKon
	18iPRZiV67pDcuSwHORJ0BpmJYtjvLjmrssxwoWLLbDDihoIIyCguLNZtw8R0gQuJKY1tbK/gkD
	Ga3LlIEtfeZNu0mc4hAOMmBqL9lsZekxXttUM4jsmGKPLBPgDeMth6b8fVjIqbdUR6T4VfSkf3D
	MZLgcRNy4b0H20wYRhsn8MymL2KoWV7qM8zpQa6eY6E8JuS4wgDne
X-Received: by 2002:a05:6808:6503:b0:467:46e7:e6dd with SMTP id 5614622812f47-46ef5fed372mr1930304b6e.16.1775236705057;
        Fri, 03 Apr 2026 10:18:25 -0700 (PDT)
X-Received: by 2002:a05:6808:6503:b0:467:46e7:e6dd with SMTP id 5614622812f47-46ef5fed372mr1930282b6e.16.1775236704582;
        Fri, 03 Apr 2026 10:18:24 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-46f0f4e16a9sm1611319b6e.4.2026.04.03.10.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 10:18:23 -0700 (PDT)
Message-ID: <ff8929f3cc1ceb1fef43f292c9c5926a25d8336a.camel@redhat.com>
Subject: Re: [PATCH] ceph: do not fill fscache for RWF_DONTCACHE writeback
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	dhowells@redhat.com, pc@manguebit.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 03 Apr 2026 10:18:21 -0700
In-Reply-To: <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com>
References: <20260401205613.2095623-1-max.kellermann@ionos.com>
	 <dc807d60a59d18dca7a14256285b1cfdeb13d907.camel@redhat.com>
	 <CAKPOu+9FvR-ZdhcQc-+KzVMgobCkrJpzEsJis2ekuz0zwC_qZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-04-03 at 08:52 +0200, Max Kellermann wrote:
> On Thu, Apr 2, 2026 at 9:44=E2=80=AFPM Viacheslav Dubeyko <vdubeyko@redha=
t.com> wrote:
> > The Ceph write_begin path calls netfs_write_begin() but does not pass
> > IOCB_DONTCACHE through to trigger __folio_set_dropbehind. So,
> > folio_test_dropbehind() would never be true on the Ceph write path righ=
t now.
> > Does it make sense?
>=20
> Yes, see:
>=20
> > > ---
> > > Note: this is an additional feature on top of my Ceph-DONTCACHE patch=
,
> > > see https://lore.kernel.org/ceph-devel/20260401053109.1861724-1-max.k=
ellermann@ionos.com/
>=20
> The code in this patch is not reachable until my RWF_DONTCACHE patch
> is merged as well.
>=20
> > Are you sure that caching should be always true? All other calls checks=
 that
> > ceph_is_cache_enabled():
> >=20
> > bool caching =3D ceph_is_cache_enabled(inode);
>=20
> This function is only called if caching is enabled.

I think that such interface will be more clean and safe:

static inline void ceph_flush_fscache_write(struct inode *inode, u64 off, u=
64
*len, bool caching)

>=20
> >=20
> > > +     *len =3D 0;
> > > +}
> >=20
> >=20
> > The ceph_folio_is_cacheable() and ceph_flush_fscache_write() are out of
> > CONFIG_CEPH_FSCACHE. It doesn't look right.
>=20
> All of the old code is out of CONFIG_CEPH_FSCACHE, too. Does the old
> code look right?

As far as I can see, all fscache code is under CONFIG_CEPH_FSCACHE compilat=
ion
option. If we have some issues with old code, then it makes sense to fix it=
. But
this code is fscache related and it should be under CONFIG_CEPH_FSCACHE
protection, from my point of view. Moreover, other fscache related code is =
under
CONFIG_CEPH_FSCACHE protection pretty above the code of these functions.

>=20
> > > @@ -1412,11 +1427,14 @@ int ceph_submit_write(struct address_space *m=
apping,
> > >       bool caching =3D ceph_is_cache_enabled(inode);
> > >       u64 offset;
> > >       u64 len;
> > > +     u64 cache_offset, cache_len;
> >=20
> > Why do you need to introduce the cache_offset and cache_len? We already=
 have
> > offset and len.
>=20
> These keep track of the region that should be submitted to fscache.
> Folios without "dropbehind" need to be excluded from that.
>=20
> > >  new_request:
> > >       offset =3D ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
> > >       len =3D ceph_wbc->wsize;
> > > +     cache_offset =3D 0;
> >=20
> > Is it correct initialization? Frankly speaking, I don't quite follow wh=
y we need
> > such initialization.
>=20
> Technically, cache_offset does not need to be initialized as long as
> cache_len is zero because then its value is never used. Would you feel
> more comfortable if I remove the unnecessary initializer? I wasn't
> sure which approach would raise fewer eyebrows.

I am simply trying to follow why we need in cache_offset. We are using the
offset currently:

/* Kick off an fscache write with what we have so far. */
ceph_fscache_write_to_cache(inode, offset, len, caching);


Why the offset is not good enough?

Thanks,
Slava.

