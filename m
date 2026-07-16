Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816361A6813
	for <ceph-devel@vger.kernel.org>; Thu, 16 Jul 2026 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784170067; cv=pass; b=OMcjhD5YZhBUv5szfwe1LmTB6j+GXGRBgnOjIxV8Wucl2LidTCdjzTiUEe4IORQ8wJviCCkUeCsFtCH499BdiZLYKOclh3OfJD5acAWhjbHo1Z5AuPGqueLOJwgwgxSst95PDHwpmGBrWvFWMsjZpbk/eG3F7PWhxVOduLRHxuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784170067; c=relaxed/simple;
	bh=+GvCT+kwq3LQeFexyvCgASsvJzlAh/qAiY3NYLiMi8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lI0eL51uxKC0tAnas9NwcaJP7jabSfDo2/9kfmFcseG0ofmRRR+hCNec+ApJsFuCD5lbksn6gzJQ56lFN/EubSWhSu2P40eV4eINqG554QEk9N1vqO4FYc+wvx2ryErNVcZqXBOFGOLu5pKTewPo/HLQ9iz3ffHeyGSTokj0++4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=DOe7Kbig; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="DOe7Kbig"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c1600d040e4so18843566b.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 19:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784170062; cv=none;
        d=google.com; s=arc-20260327;
        b=OD2YwBny65bh6etqT8CijQ40h8qplGfus2X1VBoBbuHf+zQQ5ZPw11SSxMkGbVIHWf
         LZU0vt8XUR7/KD1ELy6v7rg37oYlmdBQCJxXY6QuL24xWT6H7N1AJSNmKf1ERFjc0FFi
         8s4uLX7mnFHjgqQpx8fbqbPnf7UY455snmp0z0AeSN5crZIyTWrsr/PFHEaDBpXgjKBN
         ueIfz7Rz26DjWpU3jib0YYLmUXnXJ0jIoBopez/nc65odwTdLlrB0eYLjpriwr9Q6SOp
         ZccqrfpeQ/erYQ+THo5YxqdqiHBmQCWLa7MHkzBqHKqAtMb2Vo2/GbQS2qTjX/kKUyb8
         I5ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6O4okIHBYN1WPis62bcdExMm46SGpa4Brayk0jbwlSY=;
        fh=X9iy8EBNEsCqCRXYEf6QhUfU+f20vvI5NiHxilMzvmg=;
        b=srNqgZpQdIgpEDpffrcdpowaPYOeWw7+HpRiqsWhkrdwPVhjfsfOpkYgWkR4cI9Blo
         7Ln1MLjW7dcxJCPfoDlgxtoga2VQclZ15dsFJC7rDFOrsIffVzLwVLigArEwbccLLNq9
         UpcKo8qY1sm1E0LpjnD8n9qBnjJOePR2CvTkCdiYcGt+KACklkYFYY4NONyp5ffxx1p7
         kGXZrJDLFiylSf2pA5CTgXhpZaTbaRuuEl/FvUlKXHKEFbIbP/M3Hon/HvaqVZxPgPhp
         kVrkxdthjDP8DG2JmKFoQvSZ3EabModgtzNOSqCBM3zSaxWy0uw8n7eloHmjyUcpa5K2
         AzVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784170062; x=1784774862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6O4okIHBYN1WPis62bcdExMm46SGpa4Brayk0jbwlSY=;
        b=DOe7KbigGtiw03oqRvUdHXBxB0DklwRhpmLNMEIBrmoFLz4eINk0HboWZ90kwsx6GN
         jKdR3ZQovH/OkaD2/UBgSMD5ET8jCyMn5MfVYs2PbERPQlCQ/GDhfshzcDMO8RpbfBoc
         sW97JUODoT42wxYbO0UHIYeyoLKd7yW8rXQvx9k60uPTmkNh6tAxd6hbZ/jma1kw+Sih
         thFzmL1y/dMstSbbhEC3BonP1SVIdSFpricQmu7ooLIE5WYnwg7qBJ7NoeJmPk9EYejJ
         3/vXnfKNFSE0nBairKLI1u13+Je2d378It5vaCyBkdiYoim8lPzfrl6BTaSuwK63Xq4N
         osNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784170062; x=1784774862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6O4okIHBYN1WPis62bcdExMm46SGpa4Brayk0jbwlSY=;
        b=kZQ59o4VWJX0+pCZSaB2YW3dVq6x2FJZJX3Gqog4N8TTGVGJMczx0R0oVEWf3fIrdt
         Q+Ze8MT3jrw7rXAcyakNQ0UWJtmmSGiJUpofGu4yJ4UJZkxr7gNLN1jjTDe3uE78vB00
         8I8NPNaAn+KqdITU4eoY/iXjJJHEANBLeU6CK2LwZeV7G7/LxC7nLui3O8JhI/3eJW1g
         5zIF3MTMFZQHQJdpnn57pFZrHZXA9HHh8UKWQv61S5g8bDTBb0USwWqFV+VibueGI5bP
         xsmwKVN/hpPAlGfFhNZULC9/EPMY5d/jV5vQxh8satETjkFpWS1GIqK9+vNa4M+4TPn7
         cXjA==
X-Forwarded-Encrypted: i=1; AHgh+RrQL4w+V+SVqbPFFoJ3U7sfz6DiCd9oKjEetZxCEWsp1+NSRZcyyZRJBImZjlvs6hNfZAqdGW0LutOu@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1xu1c9m4zbX4HMwNIPWKRm4VKqjKMCvQuI/LfBCi9AczJMTl
	Uqs5+vfv1i58p4r+6URTCQcnAAuTT7+yv2TwiHHh/Aimt4G10Jm8Yu7XsW2aHB918yUEgVucMqE
	5djHLaj7fFp1H0iF/RvLWvZvbawygZCejRDEoQ4+Iv9Ixo20/Z9fuxds=
X-Gm-Gg: AfdE7ckHja6dRwIEXrXIoeXcfwCOCgm3Y/r5w0wBy8BsbxKWBZZMBrTiEcDncU6KgI2
	AIlQz3e8qKnrFCORyEP9/oI3JOkNSXgv6VScfMa9U/YjHib6XlT/DAGlRSta56KGTFzCOSBed6y
	scmWtObWjvbkzCTdvoOYeLVSrWkeXz7YCAS95WzbTsUOJFzHi6JqngKc5Pc78UoegJJFmO/9A1w
	4Axbnhlc3HhtusphMTZ6bT8xZFy4l9vJMvvaGOcXGBYVL+6e0dVfXoRgw4=
X-Received: by 2002:a17:907:7b9c:b0:c15:f55d:f0d8 with SMTP id
 a640c23a62f3a-c16920827f1mr29870166b.4.1784170062566; Wed, 15 Jul 2026
 19:47:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
 <20260713-ceph-mdsc-mutex-optimization-v1-2-9ae5ac135c34@clyso.com>
 <4e8172e54217e10625a81e40ec0f6c253a568f04.camel@dubeyko.com>
 <CAOJNxR+cyR-BJx_39MDnTH_AOLckxLgSPDezAswpbpHeWVjjwg@mail.gmail.com> <884864acb978e1ec8b4aead973f2295531b20c57.camel@dubeyko.com>
In-Reply-To: <884864acb978e1ec8b4aead973f2295531b20c57.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 16 Jul 2026 10:47:30 +0800
X-Gm-Features: AUfX_mw1Fu31ETf7g5MRnEiRJQabAhUfM2GBhdLusWjFVg4iU-uaxsoTHR9rTXs
Message-ID: <CAOJNxR+ki=F_J5G+FOiP8-y_vqvjp++iSk0khiQxiJUUs7K2MQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] ceph: replace the request_tree rbtree with an xarray
 keyed by r_tid.
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As I know there is no. Yeah, with this option it will quit simple and
easier to maintain then.

Thanks
Xiubo

On Thu, 16 Jul 2026 at 01:56, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Wed, 2026-07-15 at 10:21 +0800, Xiubo Li wrote:
> > Hi Slava,
> >
> > On Wed, 15 Jul 2026 at 02:35, Viacheslav Dubeyko <slava@dubeyko.com>
> > wrote:
> > >
> > > On Mon, 2026-07-13 at 17:46 +0800, Xiubo Li via B4 Relay wrote:
> > > > From: Xiubo Li <xiubo.li@clyso.com>
> > > >
> > [......]
> > > > --- a/fs/ceph/mds_client.c
> > > > +++ b/fs/ceph/mds_client.c
> > > > @@ -1183,7 +1183,6 @@ void ceph_mdsc_release_request(struct kref
> > > > *kref)
> > > >       kmem_cache_free(ceph_mds_request_cachep, req);
> > > >  }
> > > >
> > > > -DEFINE_RB_FUNCS(request, struct ceph_mds_request, r_tid, r_node)
> > > >
> > > >  /*
> > > >   * lookup session, bump ref if found.
> > > > @@ -1195,7 +1194,7 @@ lookup_get_request(struct ceph_mds_client
> > > > *mdsc, u64 tid)
> > > >  {
> > > >       struct ceph_mds_request *req;
> > > >
> > > > -     req =3D lookup_request(&mdsc->request_tree, tid);
> > > > +     req =3D xa_load(&mdsc->request_tree, tid);
> > > >       if (req)
> > > >               ceph_mdsc_get_request(req);
> > > >
> > > > @@ -1229,7 +1228,7 @@ static void __register_request(struct
> > > > ceph_mds_client *mdsc,
> > > >       }
> > > >       doutc(cl, "%p tid %lld\n", req, req->r_tid);
> > > >       ceph_mdsc_get_request(req);
> > > > -     insert_request(&mdsc->request_tree, req);
> > > > +     xa_store(&mdsc->request_tree, req->r_tid, req, GFP_NOFS);
> > >
> > > Should we check the return value of xa_store()? What about this?
> > >
> > >         err =3D xa_err(xa_store(&mdsc->request_tree, req->r_tid, req,
> > > GFP_NOFS));
> > >         if (err) {
> > >                 ceph_mdsc_put_request(req);
> > >                 return err;
> > >         }
> > >
> >
> > Good Catch. Let me fix it.
> >
> > > >
> > > >       req->r_cred =3D get_current_cred();
> > > >       if (!req->r_mnt_idmap)
> > > > @@ -1259,20 +1258,20 @@ static void __unregister_request(struct
> > > > ceph_mds_client *mdsc,
> > > >       list_del_init(&req->r_unsafe_item);
> > > >
> >
> > [......]
> >
> > > > @@ -534,7 +533,7 @@ struct ceph_mds_client {
> > > >       u64                    last_tid;      /* most recent mds
> > > > request */
> > > >       atomic64_t             oldest_tid;    /* oldest incomplete
> > > > mds request,
> > > >                                                excluding
> > > > setfilelock requests */
> > > > -     struct rb_root         request_tree;  /* pending mds
> > > > requests */
> > > > +     struct xarray           request_tree;  /* pending mds
> > > > requests */
> > >
> > > Transaction IDs are u64; xarray indices are unsigned long. req-
> > > >r_tid,
> > > mdsc->last_tid, and want_tid/last_tid in the drain paths are all
> > > u64,
> > > but xa_store(), xa_load(), xa_erase(), and xa_find()'s max
> > > parameter
> > > all take unsigned long. CEPH_FS in fs/ceph/Kconfig only depends on
> > > INET
> > > =E2=80=94 it's not gated on 64BIT =E2=80=94 so this driver still buil=
ds for 32-bit
> > > targets, where unsigned long truncates r_tid to 32 bits. Are we
> > > safe
> > > here?
> > >
> >
> > Yeah, you are right. We have two options to fix it. Just add
> > "depends on 64BIT" in Kconfig or fall back to the rbtree code on
> > 32-bit with an #if BITS_PER_LONG =3D=3D 64 guard, similar to what we
> > already do for s_delegated_inos. I went with the #if guard in v2
> > because it keeps the driver buildable on 32-bit without introducing
> > a regression =E2=80=94 the rbtree handles u64 keys correctly there. The
> > downside is a few extra #if/#else/#endif blocks, but they are
> > mostly confined to the iteration headers; the loop bodies are
> > shared. Only flush_mdlog_and_wait_mdsc_unsafe_requests() needs a
> > full alternate implementation because the two control flows are
> > fundamentally different.
> >
> > What do you prefer?
> >
> >
>
> Do we know any customer that uses 32-bit builds? If there is no such
> users, then we can restrict the builds by "depends on 64BIT" in
> Kconfig. Otherwise, we have to provide opportunity to execute 32-bit
> builds by proper supporting rbtree for this case. But, frankly
> speaking, I would like to prefer simple solution like "depends on
> 64BIT".
>
> Thanks,
> Slava.
