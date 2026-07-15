Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112244A33F6
	for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138211; cv=none; b=buFmRfi1RUAMdas94/IfGyfa/t3H5y+FD8x3DQaTAGv0RmYsf6wnPjSbJqOXbAw+CRaoyL1gyNwVug1tFmzBgcUuaFjH5HOi3s44df+3t5UCsifReTUBp6tSyQcFV5q64tAoNG/By9xvazEDYw2F8PUkvSOg/bM8o+DXdJ/6dFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138211; c=relaxed/simple;
	bh=UEQowC5eTNKUqDdm/b4R0DrYY2kHm84+wJvTQB+qfFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XbQfVxwjbh8pmiwMEn0RJMecqLIDiSyi6Hvx9Q/hdyXjSPoi7sSpHl8FJHbub9+2McMuLg7R8NezOZswN3SePa7/DzLOR5au6vI1HFRXZ/effNF6Z9HCQRXg/NOF2nouQ5dspUUYeHyF0x9DZp6guyvapxZaxElgdpgj0p7rN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=aY1Mns0I; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="aY1Mns0I"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664e3ed58bcso1305026d50.1
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jul 2026 10:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784138209; x=1784743009; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UEQowC5eTNKUqDdm/b4R0DrYY2kHm84+wJvTQB+qfFg=;
        b=aY1Mns0IMyROqiR1TVAvtQ3WyPNXRORTLPHifab//Pb6PdhysHxBXvh4ZWmNTugQqg
         3lrbKUuLNTefCFh7ZzRaSxNAPWGc1AfKlHxq27B82QYY4KHVura2HLX26W4VoZiXnIxx
         /nbISYCYUfXuOr2fe6CAzSaJyFWtDIaLR70qLibNPA1FxHngFyhv/qTrxuRnNS4IcdxF
         E1tUjLEZom7KT84pnJZSrSy5EEwhnwqTgZ9LsD0OIftNlsCWz/Mn+CPBjX/IwhCpq258
         OURuCt1ZpmtqbEYnpipZDSdXjnpCxMF6rbzP68v2HFcA25m7WylgRGhCj3cTq5NXyfmc
         rivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784138209; x=1784743009;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UEQowC5eTNKUqDdm/b4R0DrYY2kHm84+wJvTQB+qfFg=;
        b=MqnQxsDW6hRlhRNmdsO9cukKC8xxsPN/JWZ7xfUvcqu5n28RDRH5aHuJmdFXlH7UbJ
         ysXLhK5wap/7PuBSU9wRpIahmnpveQvi4itEnPXtavwL4b1tHMXhjWP/l2LZIkQ9w1ZR
         FuL6kz4IwTZMP3P0sELO7cpT616+/uY6VzS/TeSOPsnfvyfPXPBk/jJ3dwy5H+dWaEno
         8w1x+IHvnlCHmV68e3ELX9xwxSFmykyMxP5LwO/1obxSiPu0++CvThk4Nj8oCISvAbbK
         14Bmyrt1af6uS5j/g8SNjRtCiRp5BwcGQektrnFzcMm/Q5udgyQfC8Y9P4u2KQ0OhjAw
         j4fA==
X-Forwarded-Encrypted: i=1; AHgh+RqKAlytEWPigWBFvT8F1ife1isX4Np8kpuzVui/bVvHhZZXjf5in1TlcLuhw8CVm+BUGU2IoFXU2sHS@vger.kernel.org
X-Gm-Message-State: AOJu0YxmaSCyDOM4EC38s6JEw4uuttSo9cNjDE/7IL3NR0c58SrrQcbx
	8Dtq/xpHEjdkqheMEgpLmvtbkulCwVpcZhFi48WNe4O+/+33sK1tTYyj6zHdHv8CiCQYPkXiOWL
	f7CCR6e5usA==
X-Gm-Gg: AfdE7cnFZbvYSB3rpEAIsN6DwLik5QFhAsuDoTe+crRfqgpKZshWkDMc6KcLMEPIYmO
	8ookvGSLsDoRuoosRlULrL4D8zuFvcflgbB1lFHA63ce+8V7igDOVxODT+I2N7AQD4StpgW25Rv
	KRgAXUzzR8dhC5VQH+coMvkA9Wjj/Rq8RnbG4kDNBACZF+8FqpPZNtM+YQ7qVWicqkKj5e9P9//
	ebUSKIhX7C5ayXfObph5AuE8sHxyIcTYD5oDyO+cWo7QPFxRRmiwaH114uVYQ5NceZ3CVbIjaeS
	0koV0xAdgY4L5ITcfYZh+QiWR+dbc35dyclat75xOcGoGxz/6LSRipV9ewmyb0hijA+CPwZkiCJ
	zKoAeERxoXnd9HQlEjPBYLHgoqTbCcurBjKw812PRFdNG6XM4QhNrbgFI8AT7EfEW2HlQ78EDq/
	1nUhMsbRc07JvfBfbLTwxjY82oyOmbryFVDt+fJQ+mYbSjE/yzhfPKFSskZu6fJSx0541s2YYF6
	/lm754aLFadMyr4533+cbQSAKra5IfiFEHuX/aNJWUcdA==
X-Received: by 2002:a05:690c:ec3:b0:81e:a590:54cd with SMTP id 00721157ae682-81ede3c3c6emr3795077b3.6.1784138208789;
        Wed, 15 Jul 2026 10:56:48 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:3705:6d89:7b16:2a59])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1f11bbsm175425537b3.35.2026.07.15.10.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:56:48 -0700 (PDT)
Message-ID: <884864acb978e1ec8b4aead973f2295531b20c57.camel@dubeyko.com>
Subject: Re: [PATCH 2/5] ceph: replace the request_tree rbtree with an
 xarray keyed by r_tid.
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Xiubo Li <xiubo.li@clyso.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 15 Jul 2026 10:56:46 -0700
In-Reply-To: <CAOJNxR+cyR-BJx_39MDnTH_AOLckxLgSPDezAswpbpHeWVjjwg@mail.gmail.com>
References: 
	<20260713-ceph-mdsc-mutex-optimization-v1-0-9ae5ac135c34@clyso.com>
	 <20260713-ceph-mdsc-mutex-optimization-v1-2-9ae5ac135c34@clyso.com>
	 <4e8172e54217e10625a81e40ec0f6c253a568f04.camel@dubeyko.com>
	 <CAOJNxR+cyR-BJx_39MDnTH_AOLckxLgSPDezAswpbpHeWVjjwg@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-07-15 at 10:21 +0800, Xiubo Li wrote:
> Hi Slava,
>=20
> On Wed, 15 Jul 2026 at 02:35, Viacheslav Dubeyko <slava@dubeyko.com>
> wrote:
> >=20
> > On Mon, 2026-07-13 at 17:46 +0800, Xiubo Li via B4 Relay wrote:
> > > From: Xiubo Li <xiubo.li@clyso.com>
> > >=20
> [......]
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -1183,7 +1183,6 @@ void ceph_mdsc_release_request(struct kref
> > > *kref)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kmem_cache_free(ceph_mds_request_cache=
p, req);
> > > =C2=A0}
> > >=20
> > > -DEFINE_RB_FUNCS(request, struct ceph_mds_request, r_tid, r_node)
> > >=20
> > > =C2=A0/*
> > > =C2=A0 * lookup session, bump ref if found.
> > > @@ -1195,7 +1194,7 @@ lookup_get_request(struct ceph_mds_client
> > > *mdsc, u64 tid)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ceph_mds_request *req;
> > >=20
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 req =3D lookup_request(&mdsc->request_tree,=
 tid);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 req =3D xa_load(&mdsc->request_tree, tid);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (req)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ceph_mdsc_get_request(req);
> > >=20
> > > @@ -1229,7 +1228,7 @@ static void __register_request(struct
> > > ceph_mds_client *mdsc,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 doutc(cl, "%p tid %lld\n", req, req->r=
_tid);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ceph_mdsc_get_request(req);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 insert_request(&mdsc->request_tree, req);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 xa_store(&mdsc->request_tree, req->r_tid, r=
eq, GFP_NOFS);
> >=20
> > Should we check the return value of xa_store()? What about this?
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 err =3D xa_err(xa_store(&mds=
c->request_tree, req->r_tid, req,
> > GFP_NOFS));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (err) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ceph_mdsc_put_request(req);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return err;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
>=20
> Good Catch. Let me fix it.
>=20
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 req->r_cred =3D get_current_cred();
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!req->r_mnt_idmap)
> > > @@ -1259,20 +1258,20 @@ static void __unregister_request(struct
> > > ceph_mds_client *mdsc,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 list_del_init(&req->r_unsafe_item);
> > >=20
>=20
> [......]
>=20
> > > @@ -534,7 +533,7 @@ struct ceph_mds_client {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 last_tid;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* most recent mds
> > > request */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oldest_tid;=C2=A0=C2=A0=C2=A0=
 /* oldest incomplete
> > > mds request,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excluding
> > > setfilelock requests */
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 struct rb_root=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 request_tree;=C2=A0 /* pending mds
> > > requests */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct xarray=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request_tree;=C2=A0 /* pending mds
> > > requests */
> >=20
> > Transaction IDs are u64; xarray indices are unsigned long. req-
> > >r_tid,
> > mdsc->last_tid, and want_tid/last_tid in the drain paths are all
> > u64,
> > but xa_store(), xa_load(), xa_erase(), and xa_find()'s max
> > parameter
> > all take unsigned long. CEPH_FS in fs/ceph/Kconfig only depends on
> > INET
> > =E2=80=94 it's not gated on 64BIT =E2=80=94 so this driver still builds=
 for 32-bit
> > targets, where unsigned long truncates r_tid to 32 bits. Are we
> > safe
> > here?
> >=20
>=20
> Yeah, you are right. We have two options to fix it. Just add
> "depends on 64BIT" in Kconfig or fall back to the rbtree code on
> 32-bit with an #if BITS_PER_LONG =3D=3D 64 guard, similar to what we
> already do for s_delegated_inos. I went with the #if guard in v2
> because it keeps the driver buildable on 32-bit without introducing
> a regression =E2=80=94 the rbtree handles u64 keys correctly there. The
> downside is a few extra #if/#else/#endif blocks, but they are
> mostly confined to the iteration headers; the loop bodies are
> shared. Only flush_mdlog_and_wait_mdsc_unsafe_requests() needs a
> full alternate implementation because the two control flows are
> fundamentally different.
>=20
> What do you prefer?
>=20
>=20

Do we know any customer that uses 32-bit builds? If there is no such
users, then we can restrict the builds by "depends on 64BIT" in
Kconfig. Otherwise, we have to provide opportunity to execute 32-bit
builds by proper supporting rbtree for this case. But, frankly
speaking, I would like to prefer simple solution like "depends on
64BIT".

Thanks,
Slava.
