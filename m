Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B2E2236E3
	for <ceph-devel@vger.kernel.org>; Sat, 25 Jul 2026 03:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784949889; cv=none; b=JsdGJUG3eFuDA3V5MAvtrgtPbSqTA53uI3f1ZjPS8ryvdaVvTc8fnnlndKbhYClLcM6ZiOP1ayX+Ur64NgYLUgNIPYCSOF2RgH+/RHsUrGpLVJX61cC9FREwBarTRMvInm1m8Cs9TcSq1vplm5A/idUm29fXut/8YpwqYPoCKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784949889; c=relaxed/simple;
	bh=tsLiIK43y2s0eVjPv8v9ykq+nV0rcEE/UbexcgxIQpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J+ETCB0rnpiwa3G9GiSmddk2Es2UP5NoRCk0/clUYY8jBPgUDZV4v+aO/1jVTPEAH6gLUSy6nZs8vqmuRdiK450p9g7Al0L3ItQTnmyGEQanMUQLnNPCehbkW9w4zJNgOnxtLBwI1WF4REFs7kSlgeR2IHBgkgAbjnQRnG2rdbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=FrxH4oOy; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="FrxH4oOy"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6682259cae6so865197d50.3
        for <ceph-devel@vger.kernel.org>; Fri, 24 Jul 2026 20:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784949886; x=1785554686; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tsLiIK43y2s0eVjPv8v9ykq+nV0rcEE/UbexcgxIQpE=;
        b=FrxH4oOy/r4p9FTAqL7QC6TsuGXugJk9Ex/2VNm8Q8K6wuVDrNDEOPGwQjtFPfNp0a
         MOMfxDkYlW6LhiiIJtz6wT8yMdcT24/NKiGANAkzOhJq9AtxZPT3Y8OTbZ54TL5iJeoZ
         0hXrxWdExh8SZXkphrSGH0QRV9ysn42Z+RcQLpcM6tFIsue2OrAu4Yz19of0u3/te6j5
         LX6Cky3vm9U/irrGjr6OSzNi0iwZXrhFmnCcoRdZiSOGuJGPFZmXZoDzDaeE8FSg7PUv
         LNb7HuhKmFSjcYSLwbn8EghxP8Ln1qs3zCyp22AYXwV9Qu+4Eo1zS9bpRGxa4t5S4zDJ
         67qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784949886; x=1785554686;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tsLiIK43y2s0eVjPv8v9ykq+nV0rcEE/UbexcgxIQpE=;
        b=ABMkIDCkH1OBhzbH5xb2DU4B5TpuKT+YWgN2c4WoAa/83+WRllrOxRtJRN9g4poO5j
         EF3qnAztOnLk2o3raYwwJDt43D8jPCdBlJ8KMqj1RrKbm4MyHsCFYhrsjRlfBefkQH/a
         Mmiotew5KzPYo9mZkaV+j+2Vkl2FAoUjaKw8p1gzSkDQnQ2iJvTeVq5cdEUfc6eoGYym
         ETnYyuupiT1gNDeaSGColJ6hLNLfeIUrM6P1EW2QHPYAUYr5JVE//FSMMZ0EzvYmC2Af
         e9+YJFGejQKjGxjHRa9Fh8j/yweFxH3SY8FdZNCP+bLyoB/Sny5ucftB7dnLLu3fEIlc
         DPvw==
X-Gm-Message-State: AOJu0Yy3djhYXEQttCm/2+QwnK3e1cC9pUl0vyBM719BluAfeQtWaUH+
	p9Ytg9Vy9zFv844TuuVuM3xhqmfQfQALVnImNcOvLVSV/HV9gN3zjMeoP6NWWQwvz1Q=
X-Gm-Gg: AR+sD13Lz9t1SqMdOuhSBRaGokY+2nJRAVGwHkAgXzs3g4jaYazVVHQNZBqOxeR88XA
	fhi3UetPHWZ6bbG+HdKGiQ0oWMWjqzhAMQZAgJJJqjF01gJXaGdjhe+4VbzXs3FbDT7+lMRPVHf
	1VF1pxk1zvriEKr3iSENSTy3JstcjImjGXjoZtkMvsR0AndnsaTLKooKMoGjqlVORx14VxEuSOI
	2VXiNMWZ8lSvv1PPbeVkc8fza0Sm1+tol7XgIdJxlJGrkuSZrdJQ3s3GQGODA7BBpMSTsDEuRTc
	ZtcAeVd9w8IcVyPRvCfob27PP0jyb7ROyLdTnmEL3/30v3acTMSJqCMUfkqZ1wwFg6AdslEKB6T
	3NExhrnIZYTO8dCpWEXdd2U2qfN8iqxIIWp1KqQN/1XQe0GbUJmhzwH1L9iFm10r3RQoLvV7T1g
	eLWtIj4ArPjA8Pu0gmso/qrYSO/80e1opyMHoc9hDjXWfICvzRek+ILH9Qti9iFZbKfei6tJmMk
	K7Ymq6t0sOu5SVYqiek+iE8EvV05qCcVpooPU52Jhkxj64HRWu/WRVsurPAeQmIKW9OlxMItGxj
	42wHnA==
X-Received: by 2002:a05:690e:13cc:b0:667:b314:aeba with SMTP id 956f58d0204a3-668c786f3a7mr259316d50.5.1784949886202;
        Fri, 24 Jul 2026 20:24:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:62ee:74f6:cfbb:28e0? ([2600:1700:6476:1430:62ee:74f6:cfbb:28e0])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c6d3024dsm345583d50.4.2026.07.24.20.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 20:24:44 -0700 (PDT)
Message-ID: <89b78fe1d23d6a05567e51f83efae1258ac0ad97.camel@dubeyko.com>
Subject: Re: [Security][Ceph] OSDMap new_state decode overflow causes
 out-of-bounds read in kernel client
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Federico Kirschbaum <federico.kirschbaum@xbow.com>, Ilya Dryomov
	 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, Baul Lee
	 <baul.lee@xbow.com>
Cc: ceph-devel@vger.kernel.org
Date: Fri, 24 Jul 2026 20:24:43 -0700
In-Reply-To: <CALhuxzfVV=O7z_at9wf0HeU1Mk8fvi_1OHhH1M3Conv9ae6sJw@mail.gmail.com>
References: 
	<CALhuxzfVV=O7z_at9wf0HeU1Mk8fvi_1OHhH1M3Conv9ae6sJw@mail.gmail.com>
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

Hi Federico,

Please, send a formal patch to ceph-devel@vger.kernel.org. I have no
means to review attachments and I never open email's attachment from
the unknown persons. So, please, send the patch in plain text.

Thanks,
Slava.

On Sat, 2026-07-25 at 00:19 -0300, Federico Kirschbaum wrote:
> Hi,
>=20
> We would like to report a remotely triggerable OSDMap decoding issue
> in the Linux Ceph client that can cause an out-of-bounds read when
> processing crafted incremental maps.
>=20
> Summary
> decode_new_up_state_weight() decodes an incremental OSDMap in two
> passes. In the first "skip" pass it multiplies the monitor-supplied
> new_state entry count by the per-entry size and stores the product
> back into a u32, where a count large enough that count * per-entry-
> size overflows u32 truncates the product =E2=80=94 so the ceph_decode_nee=
d()
> length guard is satisfied for a zero-sized region and the pointer is
> never advanced. The second pass then re-reads the true (large) count
> and walks the new_state array with no per-iteration bounds check,
> unlike the sibling new_weight loop directly above it. A kernel client
> that mounts CephFS or maps an rbd image from that monitor receives
> the crafted incremental map over the wire and the decode walks *p off
> the end of the message buffer. Confirmed under a KASAN VM against the
> unmodified decode path.
>=20
> Root Cause Analysis
> net/ceph/osdmap.c =E2=80=94 decode_new_up_state_weight(). The first pass
> reads the new_state count and skips over it:
>=20
> =C2=A0new_state =3D *p;
> =C2=A0ceph_decode_32_safe(p, end, len, e_inval); /* [1] len =3D Ns (u32),
> attacker-controlled */
> =C2=A0len *=3D sizeof(u32) + (struct_v >=3D 5 ? sizeof(u32) : sizeof(u8))=
; /*
> [2] product truncated back into u32 len */
> =C2=A0ceph_decode_need(p, end, len, e_inval); /* [3] guard checks the
> truncated (small) len */
> =C2=A0*p +=3D len;
> [1] len is u32 and comes straight from the message; struct_v >=3D 5
> selects a per-entry size of sizeof(u32) + sizeof(u32) =3D 8.
> [2] sizeof(...) is size_t, so the multiply is evaluated in 64-bit,
> but the result is assigned back into the 32-bit len. A count Ns large
> enough that Ns * 8 exceeds 0xFFFFFFFF truncates the product back to a
> small value (a whole 32-bit multiple truncates to 0) in len.
> [3] ceph_decode_need(p, end, 0) therefore always succeeds and *p +=3D 0
> =E2=80=94 the length guard that is supposed to prove the whole new_state
> array is present in the buffer has been defeated, and the saved
> new_state pointer still refers to the true (huge) count.
> The second pass rewinds to that pointer, re-reads the true count, and
> iterates with no bounds check:
>=20
> =C2=A0/* new_state (up/down) */
> =C2=A0*p =3D new_state;
> =C2=A0len =3D ceph_decode_32(p); /* [4] re-reads the TRUE (large) Ns */
> =C2=A0while (len--) {
> =C2=A0s32 osd;
> =C2=A0u32 xorstate;
>=20
> =C2=A0osd =3D ceph_decode_32(p); /* [5] read osd id ... */
> =C2=A0if (osd >=3D map->max_osd)
> =C2=A0goto e_inval;
>=20
> =C2=A0if (struct_v >=3D 5)
> =C2=A0xorstate =3D ceph_decode_32(p); /* [6] ... then read xorstate =E2=
=80=94 no
> ceph_decode_need */
> =C2=A0else
> =C2=A0xorstate =3D ceph_decode_8(p);
> =C2=A0...
> =C2=A0}
> [4] The loop trip count is the untruncated Ns, so the loop intends to
> consume Ns * 8 bytes that [3] never proved are present.
> [5]/[6] Each iteration advances *p by 8 bytes with no
> ceph_decode_need(p, end, ...). This is the sole difference from the
> new_weight loop immediately above it, which performs
> ceph_decode_need(p, end, 2*sizeof(u32), e_inval) on every iteration
> and is therefore safe. Once *p reaches end, the ceph_decode_32() at
> [5]/[6] reads past the end of the message buffer.
> The osd >=3D map->max_osd check at [5] does not contain the walk: the
> over-read is the next ceph_decode_32() on the same or a following
> iteration, and while the in-buffer trailing bytes decode to small osd
> ids (< max_osd) the loop keeps advancing and reading past end before
> any osd value happens to exceed max_osd.
> KASAN report (VM-confirmed)
> Device: mainline Linux 7.2.0-rc2 (origin/master 0e35b9b6ec0f), arm64,
> built with CONFIG_KASAN_GENERIC=3Dy CONFIG_KASAN_VMALLOC=3Dy
> CONFIG_CEPH_LIB=3Dm, booted under a QEMU virt VM (the running kernel
> reports the module vermagic 7.0.0). The crafted incremental-OSDMap
> bytes are the exact byte stream handle_one_map() decodes off the
> wire; they are delivered to the unmodified osdmap_apply_incremental()
> =E2=86=92 decode_new_up_state_weight() via a small out-of-tree module
> (poc/poc.c). The vulnerable function body is byte-for-byte identical
> to the pristine tree (verified by md5sum of the function); the only
> source edits are three EXPORT_SYMBOL lines added outside the function
> (ceph_osdmap_alloc, ceph_osdmap_destroy, osdmap_apply_incremental) so
> the already header-declared helpers are loadable-module-callable.
> Full log in evidence/kasan_oob.log.
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in
> decode_new_up_state_weight+0x3f8/0x900 [libceph]
> Read of size 4 at addr ffff000019d1b2e4 by task insmod/267
>=20
> CPU: 0 UID: 0 PID: 267 Comm: insmod Tainted: G =C2=A0 =C2=A0B =C2=A0 =C2=
=A0 =C2=A0OE =C2=A0 =C2=A0 =C2=A0
> 7.0.0 #5
> Call trace:
> =C2=A0show_stack+0x24/0x50 (C)
> =C2=A0dump_stack_lvl+0x80/0xc0
> =C2=A0print_report+0x164/0x4e8
> =C2=A0kasan_report+0xb0/0x128
> =C2=A0kasan_check_range+0x114/0x200
> =C2=A0__asan_loadN+0x20/0x48
> =C2=A0decode_new_up_state_weight+0x3f8/0x900 [libceph]
> =C2=A0osdmap_apply_incremental+0x3d4/0xa28 [libceph]
> =C2=A0poc_init+0x270/0xf68 [ceph_osdmap_poc]
> =C2=A0do_one_initcall+0xb4/0x6a0
>=20
> Allocated by task 267:
> =C2=A0__kvmalloc_node_noprof+0x23c/0x7f0
> =C2=A0poc_init+0xd4/0xf68 [ceph_osdmap_poc]
>=20
> The buggy address belongs to the object at ffff000019d1b280
> =C2=A0which belongs to the cache kmalloc-rnd-10-96 of size 96
> The buggy address is located 12 bytes to the right of
> =C2=A0allocated 88-byte region [ffff000019d1b280, ffff000019d1b2d8)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> libceph: corrupt inc osdmap (-22) epoch 1 off 104
> The faulting Read of size 4 at object +88+12 is the xorstate =3D
> ceph_decode_32(p) at [6], reading past end of the 88-byte
> incremental-OSDMap buffer allocated by the harness
> (__kvmalloc_node_noprof from poc_init).
> The PC decode_new_up_state_weight+0x3f8, called from
> osdmap_apply_incremental+0x3d4, is the new_state loop; the trailing
> corrupt inc osdmap (-22) ... off 104 is the loop finally bailing at
> e_inval after it has already over-read the 88-byte region out to
> offset 104.
> Impact
> A sequential kernel-heap out-of-bounds read walking *p past the end
> of the incremental-OSDMap message buffer. Both the read length =E2=80=94 =
the
> untruncated new_state count that drives the loop =E2=80=94 and the
> incremental-OSDMap message buffer size are controlled by the ceph
> monitor, and no per-iteration bound stops the walk. The libceph front
> buffer is kvmalloc'd up to CEPH_MSG_MAX_FRONT_LEN (16 MiB); when a
> large front is backed by vmalloc the over-read crosses adjacent
> kernel memory and a guard page. A single crafted MSG_OSD_MAP over the
> wire reaches this decode in every kernel client that mounts CephFS or
> maps an rbd image from that monitor. This is a monitor-controlled,
> remotely-reachable kernel memory-safety violation (CWE-125) =E2=80=94 an =
out-
> of-bounds read / information-disclosure-class primitive over adjacent
> kernel-heap bytes past the message buffer.
>=20
> Patch
> Add the missing per-iteration bounds check at the top of the
> new_state loop, mirroring the sibling new_weight loop, so each 8-byte
> (struct_v >=3D 5) or 5-byte entry is proven present before it is
> decoded. This directly and minimally closes the walk regardless of
> the first-pass truncation. As a defence in depth the skip-pass length
> should also be accumulated in a type wide enough not to truncate
> (e.g. compute the product as size_t and compare against end - *p), so
> the guard at [3] is not silently satisfied by a wrapped length.
>=20
> =C2=A0/* new_state (up/down) */
> =C2=A0*p =3D new_state;
> =C2=A0len =3D ceph_decode_32(p);
> =C2=A0while (len--) {
> =C2=A0s32 osd;
> =C2=A0u32 xorstate;
>=20
> =C2=A0ceph_decode_need(p, end,
> =C2=A0sizeof(u32) + (struct_v >=3D 5 ? sizeof(u32) : sizeof(u8)),
> =C2=A0e_inval);
> =C2=A0osd =3D ceph_decode_32(p);
> =C2=A0if (osd >=3D map->max_osd)
> =C2=A0goto e_inval;
> =C2=A0...
> =C2=A0}
> Full diff in patch/fix.patch (applies cleanly to origin/master
> 0e35b9b6ec0f). With the per-iteration ceph_decode_need() in place the
> new_state loop can no longer read past end =E2=80=94 exactly like the sib=
ling
> new_weight loop that was already guarded =E2=80=94 so the crafted increme=
ntal
> map is rejected with -EINVAL instead of walking off the buffer.
>=20
> Credit
>=20
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
