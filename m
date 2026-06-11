Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B71F31F9A5
	for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2026 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781151267; cv=none; b=IkqOcOTO+8oqgKQwBnvV3HPSjVvMHWnsds4h8U91qfINgN6sGdm95T1H8PyNeKccZOedAMYLHatmluTlCirusz2X8qX4y5pvTiWlNWdiP6HMyDKSfqanISLssVxJWDSZdpu6W8Od3yVsUdXNljhHMiypuCfoupzpN60PxpYwRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781151267; c=relaxed/simple;
	bh=AlILG7hDo4x9qsgX/3Ze/Z9mt4+FRHGMMiaXAwJtK1o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZAfDieZM+ajVFp+KMp0uXpWfS3NP0wEY2XMseyJ6GTT7lpU359olM0pd9g81E/b1r79Vlx/CKeXtWfbjViRY9nZpSURIFmVkgg718ZOwrKGXnMJ0u8bNdyjbBfEdExPVoAs/z04DwUlIeVxcnbvAHHGGb67Sm9XX+OYHog6kKio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=zS/aoNdb; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="zS/aoNdb"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa69131836so6796910e87.3
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jun 2026 21:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781151264; x=1781756064; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vpWqbWCMK2L6lHOMnME/whb/Mz1SphfymfCrr6hXvAo=;
        b=zS/aoNdbN7EOUGQFnXOqYWwa2TOecP3So9MYag7UFLBIG0hquUbJUPkneaAMVdAeN/
         DTQoJOq7JgAgznb4shHbU4gaaNr7Qk85drXEy0A/npGWj9eKGHOtLLbM8GUwB2I0e8m6
         dXGtTQ1RS9ht5SBo+LEnEwO+jRyGZ2ySk08njJG7GevnK0M3IUei390jWyWAPlXbx80D
         o4uUm8u7Rka+KgPUdTr+B9X0yvButBwGCJ4LRqDfon0Ssxqmpo/AUUEjFEgFFInNFPDI
         SPq2e2LVClka2yNS2nVOTBQOvdvmGiez6y2lZcAUphRNoe/qdvNiHQpRwmZuYyB6ETeH
         96Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781151264; x=1781756064;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vpWqbWCMK2L6lHOMnME/whb/Mz1SphfymfCrr6hXvAo=;
        b=p7O9649aQwYJX8y/DvqsEPQdREedC3ZR837zLQe8lQzC3WQhJMY4byK4/GEWrq//Zo
         XiQqVDyiYu9SATo1eWf+O9Ipziarq79BX9Pz8Q+krPtvRnPZhELDda6jd3mjlHo6XHq/
         MIqtRezo1y8anTHWbM7BpcRxnpSfIW/A5giLfIEyoP0NCSWY7qXtpCLVjW8HYhShN+/m
         5u/lk4CQItaPqhD+EUzoefj8Y9GLIoHTk4vaXB/xAM4s1BYeUPhGzgSG8pQHvdkzGzpz
         jSDQyiXEPPgz4/CVkPqwLwlQ4Zfpu5fdiTmbKQ7VawDSlxKMM1YvyUd2h+zvZ/wqevAh
         PNMg==
X-Forwarded-Encrypted: i=1; AFNElJ9LmqeEHmncRmODI0O1LXapIZbmTk3w1EMa9Q750NqDHr+/1e2d5XOvzTQeFoBvIeeV9Mkg3rWROgai@vger.kernel.org
X-Gm-Message-State: AOJu0YzOsRcarw9VTDyWpBRTF1QQPDSFq710p1pTgjxBLzBzuJFxcV86
	K5YUOLXGvoeRc2ZkY1waMLk5ebN3axU8cSjMBQP9LSViFxz5nJaz94SGdwbauDhFScr/67lOUZa
	J1WAomLTLwg==
X-Gm-Gg: Acq92OEm0ktApY+1gI9Y1/rAz4sfcN01zdLF1xhVkYh7QQMIDdXpozmEspGAOkLwNnB
	/NQ362rxPQvc3WW3pNNukqyjMnUtkY9ZQRbBNf4gnuSxATMPPWgstFUfuVC4WKXbxnh2x7wjloW
	zaxfnmbmLe9WKEBf1OwTthDLh7sMj3xVKQdU7W7qw4nVRLp7fd837vfA0ZoHpotK1aETshm4gdv
	Iq+ZCIulSWNWaGJwXdcr9Hkzcr3dcjwbOuNUdTofQZkXgGvklvSHmg1N8ByVmsDpRHBxbaP3xSm
	9DDQq36/XXIblOPwS68lARbbEe2/ER5vRFFatCrWtEhaPFBYZBk0LaXpMKDToFuJtTe1JQPYyKP
	QAX/Y/TdzluoyBCx3wgoHhp6qO5DU4fZTw2BDxEMV6ryzvJRvSWXcnrFteTigKbWSjZUCM5HTUB
	41kEhYq3nd1JRVLU5HV36FkSGVeyX6swmS6QqUVKrkAB6+1hZOyK9oWdiyr5Au9f8QjpvIDetcJ
	WwZTgIDmZ/mwD3wvGa6WA3pc+st9HqyBuqzlIryAAoq1pqTIOCPHzy6NZVTO/FuTxw=
X-Received: by 2002:ac2:4f10:0:b0:5aa:6c7c:65e8 with SMTP id 2adb3069b0e04-5ad27fb34damr322498e87.23.1781151263614;
        Wed, 10 Jun 2026 21:14:23 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3991adab7f8sm1012871fa.34.2026.06.10.21.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 21:14:23 -0700 (PDT)
Message-ID: <f8104e5ce9b824994bbb08b56326bb1bb23ff1c9.camel@dubeyko.com>
Subject: Re: [PATCH v3] ceph: fix OOB read in ceph_osdc_list_watchers via
 uncapped outdata_len
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Pavitra Jha <jhapavitra98@gmail.com>, idryomov@gmail.com
Cc: Slava.Dubeyko@ibm.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 10 Jun 2026 21:14:22 -0700
In-Reply-To: <20260609050042.1436568-1-jhapavitra98@gmail.com>
References: <27e15cffb5d346a19a45efc88a722a3d6abd5c7a.camel@dubeyko.com>
	 <20260609050042.1436568-1-jhapavitra98@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-09 at 01:00 -0400, Pavitra Jha wrote:
> The OSD reply header field op->payload_len is wire-controlled and is
> copied directly into m->outdata_len[i] without any bounds check:
>=20
> =C2=A0 m->outdata_len[i] =3D le32_to_cpu(op->payload_len);
>=20
> This value propagates unchecked to req->r_ops[0].outdata_len and is
> then used to set the decode boundary in ceph_osdc_list_watchers():
>=20
> =C2=A0 void *const end =3D p + req->r_ops[0].outdata_len;
>=20
> The actual data allocation is always exactly one page:
> =C2=A0 ceph_alloc_page_vector(1, GFP_NOIO)
> =C2=A0 ceph_osd_data_pages_init(..., PAGE_SIZE, ...)
>=20
> The messenger caps the copy to PAGE_SIZE bytes, but the decode window
> end is set from the uncapped wire value. A malicious OSD can send
> outdata_len=3D0x10000, causing _safe decoder boundary checks to pass
> while the physical reads cross the slab allocation boundary.
>=20
> KASAN report (kernel 7.0.0-rc7, QEMU/x86_64, KASLR disabled):
>=20
> =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0 BUG: KASAN: slab-out-of-bounds in ceph_oob2_init+0x23d/0xff0
> [ceph_oob2_poc]
> =C2=A0 Read of size 4 at addr ffff88800a229f9e by task insmod/57
>=20
> =C2=A0 CPU: 0 UID: 0 PID: 57 Comm: insmod Tainted: G=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 O=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0
> 7.0.0-rc7-g9c2abf69da83-dirty #15 PREEMPT(lazy)
> =C2=A0 Tainted: [O]=3DOOT_MODULE
> =C2=A0 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0=
-
> debian-1.17.0-1 04/01/2014
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 <TASK>
> =C2=A0=C2=A0 dump_stack_lvl+0x4d/0x70
> =C2=A0=C2=A0 print_report+0x170/0x4f3
> =C2=A0=C2=A0 ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> =C2=A0=C2=A0 kasan_report+0xda/0x110
> =C2=A0=C2=A0 ? ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
> =C2=A0=C2=A0 ? ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
> =C2=A0=C2=A0 ? __pfx_ceph_oob2_init+0x10/0x10 [ceph_oob2_poc]
> =C2=A0=C2=A0 ceph_oob2_init+0x23d/0xff0 [ceph_oob2_poc]
> =C2=A0=C2=A0 do_one_initcall+0x9a/0x3a0
> =C2=A0=C2=A0 ? __pfx_do_one_initcall+0x10/0x10
> =C2=A0=C2=A0 ? kasan_unpoison+0x44/0x70
> =C2=A0=C2=A0 do_init_module+0x27c/0x790
> =C2=A0=C2=A0 ? __pfx_do_init_module+0x10/0x10
> =C2=A0=C2=A0 ? __kasan_slab_free+0x47/0x70
> =C2=A0=C2=A0 ? kfree+0x15f/0x3b0
> =C2=A0=C2=A0 load_module+0x4a9a/0x6350
> =C2=A0=C2=A0 ? __pfx_load_module+0x10/0x10
> =C2=A0=C2=A0 ? security_file_permission+0x24/0x50
> =C2=A0=C2=A0 ? kernel_read_file+0x2ed/0x770
> =C2=A0=C2=A0 ? init_module_from_file+0x15c/0x180
> =C2=A0=C2=A0 init_module_from_file+0x15c/0x180
> =C2=A0=C2=A0 ? __pfx_init_module_from_file+0x10/0x10
> =C2=A0=C2=A0 ? tick_nohz_handler+0x2a3/0x640
> =C2=A0=C2=A0 ? _raw_spin_lock+0x7e/0xd0
> =C2=A0=C2=A0 idempotent_init_module+0x21f/0x750
> =C2=A0=C2=A0 ? __pfx_idempotent_init_module+0x10/0x10
> =C2=A0=C2=A0 ? fdget+0x4e/0x4a0
> =C2=A0=C2=A0 ? fdget+0x4e/0x4a0
> =C2=A0=C2=A0 __x64_sys_finit_module+0xba/0x120
> =C2=A0=C2=A0 do_syscall_64+0xe2/0x570
> =C2=A0=C2=A0 ? exc_page_fault+0x66/0xb0
> =C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> =C2=A0 Allocated by task 57:
> =C2=A0=C2=A0 kasan_save_stack+0x30/0x50
> =C2=A0=C2=A0 kasan_save_track+0x14/0x30
> =C2=A0=C2=A0 __kasan_kmalloc+0x7f/0x90
> =C2=A0=C2=A0 ceph_oob2_init+0x44/0xff0 [ceph_oob2_poc]
> =C2=A0=C2=A0 do_one_initcall+0x9a/0x3a0
> =C2=A0=C2=A0 do_init_module+0x27c/0x790
> =C2=A0=C2=A0 load_module+0x4a9a/0x6350
> =C2=A0=C2=A0 init_module_from_file+0x15c/0x180
> =C2=A0=C2=A0 idempotent_init_module+0x21f/0x750
> =C2=A0=C2=A0 __x64_sys_finit_module+0xba/0x120
> =C2=A0=C2=A0 do_syscall_64+0xe2/0x570
> =C2=A0=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> =C2=A0 The buggy address belongs to the object at ffff88800a229000
> =C2=A0=C2=A0 which belongs to the cache kmalloc-4k of size 4096
> =C2=A0 The buggy address is located 3998 bytes inside of
> =C2=A0=C2=A0 allocated 4000-byte region [ffff88800a229000, ffff88800a229f=
a0)
>=20
> =C2=A0 Memory state around the buggy address:
> =C2=A0=C2=A0 ffff88800a229e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00
> =C2=A0=C2=A0 ffff88800a229f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 =
00 00
> =C2=A0 >ffff88800a229f80: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0 ffff88800a22a000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc
> =C2=A0=C2=A0 ffff88800a22a080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc
> =C2=A0 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> =C2=A0 val=3D0xccccaaaa (OOB garbage from KASAN redzone)
>=20
> Fix by introducing buf_len to hold the allocation size, using it in
> both ceph_osd_data_pages_init() and the min_t() decode boundary cap,
> so the two are guaranteed to stay in sync if the buffer size changes.
> buf_len is declared as u32 to match the type of outdata_len used in
> the min_t() expression.
>=20
> Attacker model: a malicious or compromised OSD in a multi-tenant
> Ceph deployment can trigger this against any client issuing
> CEPH_OSD_OP_LIST_WATCHERS without further privileges beyond OSD
> session establishment.
>=20
> Fixes: a4ed38d7a180 ("libceph: support for
> CEPH_OSD_OP_LIST_WATCHERS")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
> ---
> v3: Change buf_len type from size_t to u32 to match outdata_len type
> =C2=A0=C2=A0=C2=A0 in min_t(), per Viacheslav Dubeyko's review.
> v2: Introduce buf_len variable instead of hardcoding PAGE_SIZE
> =C2=A0=C2=A0=C2=A0 independently in ceph_osd_data_pages_init() and the mi=
n_t() cap,
> =C2=A0=C2=A0=C2=A0 per Viacheslav Dubeyko's review.
> ---
> =C2=A0net/ceph/osd_client.c | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index a67093cf4..5ad47d932 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -5063,6 +5063,7 @@ int ceph_osdc_list_watchers(struct
> ceph_osd_client *osdc,
> =C2=A0	struct ceph_osd_request *req;
> =C2=A0	struct page **pages;
> =C2=A0	int ret;
> +	const u32 buf_len =3D PAGE_SIZE;
> =C2=A0
> =C2=A0	req =3D ceph_osdc_alloc_request(osdc, NULL, 1, false,
> GFP_NOIO);
> =C2=A0	if (!req)
> @@ -5081,7 +5082,7 @@ int ceph_osdc_list_watchers(struct
> ceph_osd_client *osdc,
> =C2=A0	osd_req_op_init(req, 0, CEPH_OSD_OP_LIST_WATCHERS, 0);
> =C2=A0	ceph_osd_data_pages_init(osd_req_op_data(req, 0,
> list_watchers,
> =C2=A0						 response_data),
> -				 pages, PAGE_SIZE, 0, false, true);
> +				 pages, buf_len, 0, false, true);
> =C2=A0
> =C2=A0	ret =3D ceph_osdc_alloc_messages(req, GFP_NOIO);
> =C2=A0	if (ret)
> @@ -5091,7 +5092,8 @@ int ceph_osdc_list_watchers(struct
> ceph_osd_client *osdc,
> =C2=A0	ret =3D ceph_osdc_wait_request(osdc, req);
> =C2=A0	if (ret >=3D 0) {
> =C2=A0		void *p =3D page_address(pages[0]);
> -		void *const end =3D p + min_t(u32, req-
> >r_ops[0].outdata_len, PAGE_SIZE);
> +		void *const end =3D p +
> +			min_t(u32, req->r_ops[0].outdata_len,
> buf_len);
> =C2=A0
> =C2=A0		ret =3D decode_watchers(&p, end, watchers,
> num_watchers);
> =C2=A0	}

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
