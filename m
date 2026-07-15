Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5921F7575
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784082110; cv=pass; b=enY8Vd226P5QqyTtSmzLiAFV3j5nRFKqIv7kp1vOcfkFFqwrOW8uqeMXbiDBKOBPtUgojgG+vfd8jYl5zFH4/PRsgFX65r5IZlra2M+XdsCD1MrQ18V5WT842z35RZVkmv7HasP+41gfcbGAQi32DHlLmsKgCUdKveeSPnBY9Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784082110; c=relaxed/simple;
	bh=NCiGfVDS6pvBGTjOIdwamfMM4ga8JCARvuugPkplNPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PO7pQdbHDqGspvAQyZRpXkOBtIxGtQ3z5b0QD8osWvInIfr5lw81VoZokSHGC+CRsxDzkTiDsjlLg9E5k+Ejx1/hto/Yh8qaseIFxZAc8mlGj9czNIf9GXH1nmneXe1C/w6/4E+rYWq1UwIvFQoNQPNVLe3UHZI123h9GYoTUp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=hDx26xzc; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="hDx26xzc"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6986287534eso8950772a12.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Jul 2026 19:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784082105; cv=none;
        d=google.com; s=arc-20260327;
        b=eBrm9aEeuff6qGk2G1eVnLaNL4Nbc72XZi73cNxMHGIgG0WJr+I7UQ+2ygBOFbGvDj
         FcWLfk0gUCZcifaje0U+6SwDX0I7iXlg8FpHM/cKbqBoN4fH0W3SIEC3c7CFfeuv2XQe
         W3eeIMbemMoYv07aiLr9H058dQzlBpOEIAMUzP9NTZM+ILXDK3D41hzwktFMtGydiPyn
         skhS5rNq2MIcgMHI4VNGcZuiFInILOD0g7pjxW0zR31qIadjl4Gk/eIOSO+NyuZi+WPt
         8mzVefYJaq6v3Ugs9OC9Wbom/xMDe5u6U1MdQ/phqqyUhxxAcfdL7TRdecAQk9CoLtB8
         ez/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QqqsiFuaK8omIfDpNHXXhL8DgywuOH9j/rRt/KN1DeE=;
        fh=535rcQQf6MOeOPN0kevVpKDg+N4JnpCRrofTdq/DC68=;
        b=KJYjry+xsYfujTxmnJY06B5/xlF/jIoWYAIiN1UAOZBMjZ5HttgDQ7AyN/Q7sWslhQ
         sreTJRK8Ze2o1tQCKfltJFGWg+csCqz0OMbVt/Sv1KcaJS1ZDWac0oBvtjYEKqtyHmEO
         Rxre69VahcwR0Eyw5BCGy5qvinn2vDhw/zltGsmBp3ogTcKzVYju+YS/meYZL/d2pcow
         zYBibfWDxCW8NeJEw0BSQTwvpVN6BmfRC53kQ6eafwIXqH5H7584A4Lgyo580/0OlECi
         0cu0xgJHEZ7RwVLwFAi3zjL8Pj7XWgFx9zt5jSxQvxjkuvwfRCjprjKg397+eOt2LrlI
         eE6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1784082105; x=1784686905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QqqsiFuaK8omIfDpNHXXhL8DgywuOH9j/rRt/KN1DeE=;
        b=hDx26xzcjUC0STPsIKyj90edYcLgDke9yrviXHuQYIZ/2N30Nh+TZXHh+O5y48QKdE
         M+JD45EkSQf8LnK4eTfYaO7xhHAhUiP3c2btifaJ8UMtOHq9x0pCxJBmjHheZwValq8G
         +xwVIA7RShFwVhVIdcClJ4D3FhGbRrlwYM+/1XLT74XX0J2vJLdl6UA1a0XNgz6z2yBS
         zDJA49ilR67Cv0rE1FMigr0eJ5jk+Pf4md3rjZF+00VyOTVQHIjpe41GDIfo00AMfU9Y
         aAUa7R/HyVsmqxMA9/lj3Ue4qWh/Feune0FkydnxEzle0xLDKGiyavS5O2p4b+9ViXFN
         Zesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784082105; x=1784686905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QqqsiFuaK8omIfDpNHXXhL8DgywuOH9j/rRt/KN1DeE=;
        b=e72JDpxB3H+B8CSiRCfO5IHr1vzQ67UkFFOGBBh2yFAoEHfo8XXWZTE09oPWBIm189
         XPlChhG51CO20Xt2iOUM1scTLBJHHg+jCU3kZziankG5MaU5R/6b0ip66DzEiJxb6+YL
         c9nymrYdU6USIdnTIqWuHYLwjYLKrrXJ0srX4csVmZoJUvsJcwffsWeilW6o+Zt+TkvJ
         kU9DdcZ/5qr1v3owltUbOUK3qai2F3Dielfus/TMKoE3rNoM4IXk8/B4jikx+T/s9S7a
         6crlylySm7POdu57PqNJeFL6w5fTXj/5YFmPokR3Nc4qF9AllEl0JwFSuOE5plxF3dhG
         yFHw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7rZJ/vhQX7RRmJlwW+pF/RNjzy0/WRHxunzoiomMy0GsOHsaqZq6Ma/AALnXKaLUHr4X/TEJirgxA@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0ibJlhxBoMWZRxx/pFPE9x/AaLhHkPnkIPF/3PcphqndwTGZ
	FrPe2O7FY489dQZ2SE89rPnwbuzGdFiQhrZgO08QH0oq79w8vCl6Nxh5EkFFP9XAFYj+2Nk9rNx
	sB+N8kbwUBlnqpXqIYTyz1LQ4tdJxV6/m7X3sgBZoxQ==
X-Gm-Gg: AfdE7ckc75zlhXzwm3do57kTVdKqMT2jtkUsf5Qpa+BbSk1FTqxmuDVKROi5OJ3gTFa
	WkgeA64EbP6PwmoaE7Z28F9yr7ls7z9c90RI7afpYS9ZvX3tbaFe8eGEqmAcasouZ0I/mLHOxW2
	er7oumruPsPLdkvAJoQa4cP1/emwLNrySMnxQRQ/REtx+N+B6ZaxrkEa8lZay7EOXRnao+Mx46k
	Vo4RLexw2dmxRk7bINdEl9sr03jo5bsFZ0VD/07SoDByDWnC1lixn2PBdeJdcenDRB+Kg==
X-Received: by 2002:a17:907:7b81:b0:c12:62d7:e74c with SMTP id
 a640c23a62f3a-c166161af3cmr334637066b.8.1784082105178; Tue, 14 Jul 2026
 19:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
 <20260713-ceph-mdsc-mutex-optimization-v1-2-9ae5ac135c34@clyso.com> <4e8172e54217e10625a81e40ec0f6c253a568f04.camel@dubeyko.com>
In-Reply-To: <4e8172e54217e10625a81e40ec0f6c253a568f04.camel@dubeyko.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Wed, 15 Jul 2026 10:21:31 +0800
X-Gm-Features: AUfX_mztf_E9YZdH0dU3ivZbq7IoFCIzSnFRufvaUEfCzEsdeUKWyiJjw7TK6qc
Message-ID: <CAOJNxR+cyR-BJx_39MDnTH_AOLckxLgSPDezAswpbpHeWVjjwg@mail.gmail.com>
Subject: Re: [PATCH 2/5] ceph: replace the request_tree rbtree with an xarray
 keyed by r_tid.
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On Wed, 15 Jul 2026 at 02:35, Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>
> On Mon, 2026-07-13 at 17:46 +0800, Xiubo Li via B4 Relay wrote:
> > From: Xiubo Li <xiubo.li@clyso.com>
> >
[......]
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -1183,7 +1183,6 @@ void ceph_mdsc_release_request(struct kref
> > *kref)
> >       kmem_cache_free(ceph_mds_request_cachep, req);
> >  }
> >
> > -DEFINE_RB_FUNCS(request, struct ceph_mds_request, r_tid, r_node)
> >
> >  /*
> >   * lookup session, bump ref if found.
> > @@ -1195,7 +1194,7 @@ lookup_get_request(struct ceph_mds_client
> > *mdsc, u64 tid)
> >  {
> >       struct ceph_mds_request *req;
> >
> > -     req =3D lookup_request(&mdsc->request_tree, tid);
> > +     req =3D xa_load(&mdsc->request_tree, tid);
> >       if (req)
> >               ceph_mdsc_get_request(req);
> >
> > @@ -1229,7 +1228,7 @@ static void __register_request(struct
> > ceph_mds_client *mdsc,
> >       }
> >       doutc(cl, "%p tid %lld\n", req, req->r_tid);
> >       ceph_mdsc_get_request(req);
> > -     insert_request(&mdsc->request_tree, req);
> > +     xa_store(&mdsc->request_tree, req->r_tid, req, GFP_NOFS);
>
> Should we check the return value of xa_store()? What about this?
>
>         err =3D xa_err(xa_store(&mdsc->request_tree, req->r_tid, req,
> GFP_NOFS));
>         if (err) {
>                 ceph_mdsc_put_request(req);
>                 return err;
>         }
>

Good Catch. Let me fix it.

> >
> >       req->r_cred =3D get_current_cred();
> >       if (!req->r_mnt_idmap)
> > @@ -1259,20 +1258,20 @@ static void __unregister_request(struct
> > ceph_mds_client *mdsc,
> >       list_del_init(&req->r_unsafe_item);
> >

[......]

> > @@ -534,7 +533,7 @@ struct ceph_mds_client {
> >       u64                    last_tid;      /* most recent mds
> > request */
> >       atomic64_t             oldest_tid;    /* oldest incomplete
> > mds request,
> >                                                excluding
> > setfilelock requests */
> > -     struct rb_root         request_tree;  /* pending mds
> > requests */
> > +     struct xarray           request_tree;  /* pending mds
> > requests */
>
> Transaction IDs are u64; xarray indices are unsigned long. req->r_tid,
> mdsc->last_tid, and want_tid/last_tid in the drain paths are all u64,
> but xa_store(), xa_load(), xa_erase(), and xa_find()'s max parameter
> all take unsigned long. CEPH_FS in fs/ceph/Kconfig only depends on INET
> =E2=80=94 it's not gated on 64BIT =E2=80=94 so this driver still builds f=
or 32-bit
> targets, where unsigned long truncates r_tid to 32 bits. Are we safe
> here?
>

Yeah, you are right. We have two options to fix it. Just add
"depends on 64BIT" in Kconfig or fall back to the rbtree code on
32-bit with an #if BITS_PER_LONG =3D=3D 64 guard, similar to what we
already do for s_delegated_inos. I went with the #if guard in v2
because it keeps the driver buildable on 32-bit without introducing
a regression =E2=80=94 the rbtree handles u64 keys correctly there. The
downside is a few extra #if/#else/#endif blocks, but they are
mostly confined to the iteration headers; the loop bodies are
shared. Only flush_mdlog_and_wait_mdsc_unsafe_requests() needs a
full alternate implementation because the two control flows are
fundamentally different.

What do you prefer?

Thanks
Xiubo Li
