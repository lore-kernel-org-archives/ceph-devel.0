Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FF92DC767
	for <ceph-devel@vger.kernel.org>; Mon, 16 Feb 2026 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771274808; cv=pass; b=Dybhv6hQJDE4NmEIGYDuMsSYgTBvF9GGTAhHDQ7+rvq6I8i/LDbESwFqIR+D/vAL61pdBvVLyBDKv2xLyh3QuBp1AaY7lf9y1gZuO/JM0iG+w8NpwmFZND46RrwvQQNLq6gw0fKZ9ZZhKZgee9XS/tkRd/9on3AsZZ8oEtjBXOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771274808; c=relaxed/simple;
	bh=IdUJDLLND0C397j12LdDofyV1+Qwk9fBD9esOfTNth4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgItFgrcsGAqXLhY8+xFqwWi4bXezz+bgA+lKoXqunXoViurX17XvdxoNpp3Gsz7OpgeZ5+S6TXBOPUrNgLJnqIjANdXX3BWX7Q/EWW7uqr2rxaNJ42cMEKu+XZIprUtm6cuDYAMbkNlS6cSt9YNA+kgRQBprHJPO2KXEHF1eNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LDnr1iYd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oSXt8j5e; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDnr1iYd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oSXt8j5e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771274805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QOwteER5UHcjyzF/ha2AkAQQo1R6y9Wy7Npt1shJY20=;
	b=LDnr1iYdpnzKGvnoEZAPU7Xyv4nL6TzcOfb6i18MDCX+I2leUj1MpF7cdDcLUWB9V0Z1jb
	9eQ2ZGCeKOxDi0O7etnpMG+dapDtpkTi4ZYw80tuBI83JQWo5GeYLoT+a/92I/B4BUyuxY
	jlbjFT9oW2O+WukAi6ADt2xJgSkz0yY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-H_OwJNrYM3idGfrGmLHDXw-1; Mon, 16 Feb 2026 15:46:43 -0500
X-MC-Unique: H_OwJNrYM3idGfrGmLHDXw-1
X-Mimecast-MFC-AGG-ID: H_OwJNrYM3idGfrGmLHDXw_1771274803
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5fb6622ca5dso5322880137.0
        for <ceph-devel@vger.kernel.org>; Mon, 16 Feb 2026 12:46:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771274803; cv=none;
        d=google.com; s=arc-20240605;
        b=CaQPSzJztjnH0Zi/I12pOd3Se0WIgIaz4EGIJHjkjDtrjKd52bHW3q9KfSjyN1vili
         hgQONMv7HjMU4kuNdFW7LoZ+6hjhJqswelKVN1zUlxJUK6KgrniW7eFWXEzjY89m0j06
         lrktXFVH4E0G3DSgF1hviswEvov4fxnT0QQ7GMnaxfiXkZ8vg7BiqmbqZajtuPw9LIzj
         Lvac7TSpmEHshQ9ZXWbWd5D1lnq3aw/LbUerChRRkrlUGlLs+pRZoVdqkyCbglPQBfCs
         kjcvs4XWkHpMkAPiK/1XJJcbEoBVSCrKWzAZYXQAONgfW+IL9M8kO9Am0WasSRqntnjv
         rVKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QOwteER5UHcjyzF/ha2AkAQQo1R6y9Wy7Npt1shJY20=;
        fh=qaAee689+sJoTyUawmQ8K/tdKeN3FUVa656FtBZXjik=;
        b=OlrxrtZWbrX5DaK2Gv7bANT61XupXsATWZ4Lm2qOndGG9MsnqfzxujYtPtFwKT1ZNQ
         i/QRZHsfCwM43rBcsZv2V/5CNLy0q94D8cofovLtoJgKSyn4fn5JWynDQyzhfrAksUPg
         4qAGwlrDuOn7ngThYbPEuuujxDQqM51GKFmUAmjKlaM2vizfPTd5GM5zYgMmUEpc65N1
         k/wXQvQZXnfxL9Qcv7ncx8Sm8yFwdEQiclXH6IjNpTUdsNsVRqH2RWC9q8AHYrX/rcmp
         0JeikfW2w0fB5ytpWwdEwVfvv6n3hU/9LyBaHlr7AMwaVHYPeLEqB6uIHaI2tz0ajbjy
         robQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771274803; x=1771879603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOwteER5UHcjyzF/ha2AkAQQo1R6y9Wy7Npt1shJY20=;
        b=oSXt8j5eD3ARc89M+j7gJL3idgWqWY073k6Su6BwahVQgULnpiqbegMIay9wRNbLBz
         rsW0mLUyYh/8cNSVjlPh+89GD5GEfxUHCGGmu6gWeqDHzkTE8crkZcfbd3bHog0otTH5
         61VJTrBre5tSBENsU1jneIEtZoITtoRWbTYPnn+aQS/2DYHS5Y/kNIrg75CBHuhlyB/D
         q+ILfkB3anvNKcRw6blwDRbhCDghAa8iJjBO7KwDsvzQ3hCQ1j72zxelYo39R+VGkKAi
         BWK2Kac0o/2sFIww7K8vmOdYAl3Dqc9QlXiHWkAzyCjldpridEkFFb9Um29d+KRQ8bmT
         QwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771274803; x=1771879603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QOwteER5UHcjyzF/ha2AkAQQo1R6y9Wy7Npt1shJY20=;
        b=DAuKvHZ++uDvglMR7kNsK7ufyZJ1dFbtJ8GJUSP9Qw6uBOI27RI9OcivQR956varNB
         +IuX2v/epSbqKLB9ihr0pZC1v15VT6ec2f4QOtoRPNVWbgoeCai6k6ZOq2ThNcqEF3rn
         Fxy5UB70T4ip4Befy6/eskPnRaXbepMR+xHYFNxRaG3AGwbsBY621Y9whULxoXTgj3o1
         x3OjA3CD4R8pYe+nC5miDWaI88222ojczLrCGvKq/nbUcHbJDI16Wwd7p0bGXZKtLjkf
         HWHbNw1/0Xgb/2AcT/kX5hZS6Mr0Z8GHWFxW/lP/cOiCD+g3G+sl0EFaB+jCXFR35d1D
         FG9A==
X-Gm-Message-State: AOJu0YxlHA30CsHPJDVcJ7oIlyVXjbcdA/CCrK9TGO1qsQHt2t6mPzr/
	F0UWU69X5wnvIgvJbsL1KHjUS1pj2P/zV4TAShn1VlITvDa4uQq6ZCTZLTm4BjDVileZ/kjlp5G
	GGe1DYkcdI+LxYKzPb0J8kJq6sQHPGFQTM4jzR2Ch7ZPN8sPITaeo0woZLk/PGh1zxMU3Gd+dfE
	SZHl2c/LVWWgOciOGhRBz7BP0eMPHZpmWmnc8oTe+7RxWI/lskr28=
X-Gm-Gg: AZuq6aJgb6yJmcuvYp6Qd4znZ8kXv3Qqi10InjX1yxnOnOfa1+o1bswtMmWzNwlLFKC
	Ycu3umpPYf2oHeDXSFNaG3yO5GWld62A4eVhSuKxyx2/8Xqd4RGB2aSC6Mm4GzopUx0DVLjTaDc
	rhSQVT/2jcHdOmNYRXeH4eLNa0XETGLXCNqrYJJc95Xyt90iNUjhpBZ93APXo4+D5S89XCiq9bI
	mp7udXxKIIexKE2npppvA==
X-Received: by 2002:a05:6102:26d2:b0:5fe:13bc:f13a with SMTP id ada2fe7eead31-5fe1aeaad46mr4019510137.36.1771274802350;
        Mon, 16 Feb 2026 12:46:42 -0800 (PST)
X-Received: by 2002:a05:6102:26d2:b0:5fe:13bc:f13a with SMTP id
 ada2fe7eead31-5fe1aeaad46mr4019502137.36.1771274801626; Mon, 16 Feb 2026
 12:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6f899da1123ab08df9a29abce69bc951d2e42939.camel@ibm.com>
In-Reply-To: <6f899da1123ab08df9a29abce69bc951d2e42939.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Mon, 16 Feb 2026 22:46:30 +0200
X-Gm-Features: AaiRm53wt4muMoDjGXXYZRCFDlTPdRfliEY8g6T81JoDscmkevyvFUMKjnNi5l4
Message-ID: <CAO8a2SgfAoQb+4HvLBU_Yxjqs697pp27+N_kfcNO11rYmZ+z0g@mail.gmail.com>
Subject: Re: Potential regression in 6.19 kernel version
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Some tree wide API changes were introduced for 6.19.
I will try to reproduce and git bisect the issue, tomorrow.

On Mon, Feb 16, 2026 at 10:24=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> Hi guys,
>
> Currently, I am experiencing some issues with running xfstests under 6.19=
 kernel
> version. Frankly speaking, I am not sure that it's CephFS kernel client r=
elated
> issue.
>
> At first, generic/013 has revealed the Call Trace:
>
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.542842]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.544039] BUG: KASAN: slab-out-of-=
bounds
> in sched_mm_cid_exit+0x26e/0x490
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.545020] Write of size 8 at addr
> ffff88811aaa33d0 by task microcephd/18454
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.545905]
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546103] CPU: 4 UID: 0 PID: 18454=
 Comm:
> microcephd Not tainted 6.19.0 #7 PREEMPT(volunt
> ary)
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546110] Hardware name: QEMU Stan=
dard PC
> (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/1
> 0/2025
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546113] Call Trace:
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546115]  <TASK>
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546118]  dump_stack_lvl+0x5c/0x9=
0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546127]  print_report+0x171/0x4d=
c
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546132]  ?
> __pfx__raw_spin_lock_irqsave+0x10/0x10
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546140]  ?
> kasan_complete_mode_report_info+0x2d/0x220
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546147]  kasan_report+0xbd/0x100
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546151]  ?
> sched_mm_cid_exit+0x26e/0x490
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546155]  ?
> sched_mm_cid_exit+0x26e/0x490
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546161]  kasan_check_range+0x13a=
/0x230
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546167]  __kasan_check_write+0x1=
4/0x30
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546173]  sched_mm_cid_exit+0x26e=
/0x490
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546179]  do_exit+0x2f1/0x26a0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546186]  ?
> __pfx_add_device_randomness+0x10/0x10
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546193]  ?
> copy_clone_args_from_user+0x11b/0x770
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546199]  ?
> __pfx_css_rstat_updated+0x10/0x10
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546207]  ? __pfx_do_exit+0x10/0x=
10
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546213]  ?
> __kasan_check_write+0x14/0x30
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546219]  ?
> _raw_spin_lock_irq+0x8b/0x100
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546226]  do_group_exit+0xac/0x33=
0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546232]  ?
> recalc_sigpending+0x160/0x220
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546239]  get_signal+0x1abf/0x1dd=
0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546245]  ?
> lruvec_stat_mod_folio+0x1a1/0x300
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546253]  ? __pfx_get_signal+0x10=
/0x10
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546261]
> arch_do_signal_or_restart+0x82/0x690
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546268]  ?
> __pfx_arch_do_signal_or_restart+0x10/0x10
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546275]  ?
> __kasan_check_write+0x14/0x30
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546283]
> exit_to_user_mode_loop+0x8f/0x500
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546289]  ? __x64_sys_clone3+0x53=
/0x90
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546295]  do_syscall_64+0x237/0x5=
d0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546304]  ?
> __secure_computing+0x19f/0x2e0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546309]  ? __kasan_check_read+0x=
11/0x20
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546315]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546322]  ? do_syscall_64+0xbf/0x=
5d0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546328]  ? __kasan_check_read+0x=
11/0x20
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546333]  ? __kasan_check_read+0x=
11/0x20
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546338]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546342]  ? irqentry_exit+0xa5/0x=
600
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546347]  ? exc_page_fault+0x95/0=
x100
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546352]
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546356] RIP: 0033:0x739dfba4ec5d
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546362] Code: 79 14 0e 00 c3 0f =
1f 84
> 00 00 00 00 00 f3 0f 1e fa b8 ea ff ff ff 48 85 ff 74 28 48 85 d2 74 23 4=
9 89 c8
> b8 b3 01 00 00 0f 05 <48> 85 c0 7c 14 74 01 c3 31 ed 4c 89 c7 ff d2 48 89=
 c7 b8
> 3c 00 00
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546366] RSP: 002b:0000739db44fd8=
18
> EFLAGS: 00000202 ORIG_RAX: 00000000000001b3
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546372] RAX: fffffffffffffffc RB=
X:
> 0000739dfb9c1720 RCX: 0000739dfba4ec5d
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546375] RDX: 0000739dfb9c1720 RS=
I:
> 0000000000000058 RDI: 0000739db44fd870
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546378] RBP: 0000739db44fd850 R0=
8:
> 0000739db14386c0 R09: 0000739db44fd977
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546380] R10: 0000000000000008 R1=
1:
> 0000000000000202 R12: 0000739db14386c0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546383] R13: ffffffffffffff80 R1=
4:
> 0000000000000000 R15: 0000739db44fd870
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546388]  </TASK>
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.546390]
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573482] Allocated by task 1:
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573680]  kasan_save_stack+0x26/0=
x60
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573687]  kasan_save_track+0x14/0=
x40
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573690]
> kasan_save_alloc_info+0x39/0x60
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573693]  __kasan_slab_alloc+0x8b=
/0xb0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573696]
> kmem_cache_alloc_noprof+0x1a1/0x5e0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573700]  __alloc_object+0x36/0x2=
40
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573705]  __create_object+0x29/0x=
c0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573708]  kmemleak_alloc+0xbe/0xe=
0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573713]
> __kmalloc_node_track_caller_noprof+0x50a/0x7d0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573718]  kstrdup+0x48/0xe0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573722]  kstrdup_const+0x23/0x40
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573724]  __kernfs_new_node+0xab/=
0x730
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573728]  kernfs_new_node+0x136/0=
x240
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573731]
> __kernfs_create_file+0x2d/0x2d0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573735]  cgroup_addrm_files+0x39=
9/0x940
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573739]  css_populate_dir+0x3d9/=
0x4f0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573743]  cgroup_mkdir+0x400/0xe6=
0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573746]  kernfs_iop_mkdir+0x1ab/=
0x2a0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573749]  vfs_mkdir+0x623/0x990
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573752]  do_mkdirat+0x3ba/0x540
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573756]  __x64_sys_mkdir+0xd7/0x=
160
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573759]  x64_sys_call+0x15f1/0x2=
360
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573763]  do_syscall_64+0x82/0x5d=
0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573767]
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573770]
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573871] The buggy address belong=
s to
> the object at ffff88811aaa3308
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.573871]  which belongs to the ca=
che
> kmemleak_object of size 168
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.574619] The buggy address is loc=
ated 32
> bytes to the right of
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.574619]  allocated 168-byte regi=
on
> [ffff88811aaa3308, ffff88811aaa33b0)
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575411]
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575511] The buggy address belong=
s to
> the physical page:
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575856] page: refcount:0 mapcoun=
t:0
> mapping:0000000000000000 index:0x0 pfn:0x11aaa2
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575859] head: order:1 mapcount:0
> entire_mapcount:0 nr_pages_mapped:0 pincount:0
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575860] flags:
> 0x17ffffc0000040(head|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575865] page_type: f5(slab)
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575868] raw: 0017ffffc0000040
> ffff88810007e3c0 dead000000000122 0000000000000000
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575871] raw: 0000000000000000
> 0000000000230023 00000000f5000000 0000000000000000
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575872] head: 0017ffffc0000040
> ffff88810007e3c0 dead000000000122 0000000000000000
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575874] head: 0000000000000000
> 0000000000230023 00000000f5000000 0000000000000000
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575876] head: 0017ffffc0000001
> ffffea00046aa881 00000000ffffffff 00000000ffffffff
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575878] head: ffffffffffffffff
> 0000000000000000 00000000ffffffff 0000000000000002
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575879] page dumped because: kas=
an: bad
> access detected
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575881]
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.575985] Memory state around the =
buggy
> address:
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.576283]  ffff88811aaa3280: 00 00=
 00 00
> 00 00 00 00 00 fc fc fc fc fc fc fc
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.576734]  ffff88811aaa3300: fc 00=
 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.577172] >ffff88811aaa3380: 00 00=
 00 00
> 00 00 fc fc fc fc fc fc fc fc 00 00
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.577595]
> ^
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.577942]  ffff88811aaa3400: 00 00=
 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.578379]  ffff88811aaa3480: 00 00=
 00 fc
> fc fc fc fc fc fc fc 00 00 00 00 00
> Feb 13 12:14:44 ceph-0005 kernel: [ 1026.578818]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Finally, the xfstests finished the run:
>
> Failures: generic/013 generic/639
> Failed 2 of 627 tests
>
> I have run the xfstests on Linux kernel 6.19 without any patches applied =
with
> CephFS fixes.
>
> But system started to experience the softlockup issue during the weekend:
>
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618681] watchdog: BUG: soft loc=
kup -
> CPU#0 stuck for 26s! [ksoftirqd/0:14]
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618691] Modules linked in: over=
lay
> hctr2 libpolyval nhpoly1305_avx2 nhpoly1305_sse2 n
> hpoly1305 chacha libchacha adiantum libpoly1305 essiv authenc tls intel_r=
apl_msr
> intel_rapl_common intel_uncore_frequency_commo
> n intel_pmc_core pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_te=
lemetry
> intel_vsec kvm_intel kvm joydev irqbypass ghas
> h_clmulni_intel aesni_intel rapl input_leds psmouse vga16fb serio_raw vga=
state
> floppy mac_hid i2c_piix4 qemu_fw_cfg i2c_smbus b
> ochs pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp parport efi_pstor=
e
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618740] CPU: 0 UID: 0 PID: 14 C=
omm:
> ksoftirqd/0 Tainted: G    B               6.19.0
> #7 PREEMPT(voluntary)
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618744] Tainted: [B]=3DBAD_PAGE
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618745] Hardware name: QEMU Sta=
ndard
> PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/
> 10/2025
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618748] RIP:
> 0010:get_seg_base_limit+0x103/0x8c0
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618759] Code: 83 e1 07 42 0f b6=
 14 2a
> 38 ca 7f 08 84 d2 0f 85 b5 06 00 00 41 0f b6 3c
>  07 40 84 ff 74 61 e8 44 d6 ff ff 83 f8 08 74 54 77 44 <83> f8 06 74 4d 8=
3 f8 07
> 74 48 83 f8 05 0f 85 22 01 00 00 41 bc 03
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618761] RSP: 0018:ffff888100cc7=
758
> EFLAGS: 00000293
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618764] RAX: 0000000000000005 R=
BX:
> 00000000542a3b3e RCX: 0000000000000000
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618765] RDX: 0000000000000000 R=
SI:
> 0000000000000000 RDI: 0000000000000000
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618766] RBP: ffff888100cc7808 R=
08:
> 0000000000000000 R09: 0000000000000000
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618767] R10: 0000000000000000 R=
11:
> 0000000000000000 R12: 0000000000000003
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618768] R13: dffffc0000000000 R=
14:
> ffff888100cc7af8 R15: ffff888100cc7950
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618769] FS:  0000000000000000(0=
000)
> GS:ffff88823d77d000(0000) knlGS:0000000000000000
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618771] CS:  0010 DS: 0000 ES: =
0000
> CR0: 0000000080050033
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618772] CR2: 00007cab29951b50 C=
R3:
> 00000000280a4005 CR4: 0000000000772ef0
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618775] PKRU: 55555554
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618776] Call Trace:
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618777]  <TASK>
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618779]  ?
> __pfx_get_seg_base_limit+0x10/0x10
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618782]  ? get_eff_addr_reg+0x2=
5/0x430
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618784]  insn_get_addr_ref+0x4a=
1/0x910
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618786]  ?
> __pfx_insn_get_addr_ref+0x10/0x10
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618787]  ?
> insn_get_displacement+0x2d6/0xaa0
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618789]  ?
> insn_get_immediate+0x75/0x24a0
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618791]
> get_kernel_gp_address+0x124/0x210
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618797]  ?
> __pfx_get_kernel_gp_address+0x10/0x10
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618799]  ?
> gp_try_fixup_and_notify+0xce/0x160
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618801]
> exc_general_protection+0x1d8/0x280
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618804]  ?
> __kasan_check_read+0x11/0x20
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618809]  ?
> free_frozen_page_commit.isra.0+0x3c1/0x1240
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618814]  ?
> __pfx__raw_spin_trylock+0x10/0x10
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618817]
> asm_exc_general_protection+0x27/0x30
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618820] RIP:
> 0010:rcu_do_batch+0x3d1/0xe70
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618825] Code: 48 8b 72 08 48 85=
 f6 0f
> 84 1d 02 00 00 48 89 c8 48 c1 e8 03 42 80 3c 20 00 0f 85 86 08 00 00 48 c=
7 42 08
> 00 00 00 00 48 89 d7 <2e> 2e 2e ff d6 65 f6 05 83 f1 3d 06 01 0f 85 2d ff=
 ff ff
> be 00 02
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618827] RSP: 0018:ffff888100cc7=
ba8
> EFLAGS: 00010246
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618828] RAX: 1ffff11024882c50 R=
BX:
> 0000000000000003 RCX: ffff888124416280
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618829] RDX: ffff888124416278 R=
SI:
> b39f32800676020b RDI: ffff888124416278
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618830] RBP: ffff888100cc7cc8 R=
08:
> 0000000000000000 R09: 0000000000000000
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618830] R10: 0000000000000000 R=
11:
> 0000000000000000 R12: dffffc0000000000
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618831] R13: ffff888100cb0000 R=
14:
> ffff888100cc7c40 R15: 0000000000000002
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618834]  ? rcu_do_batch+0x3d6/0=
xe70
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618837]  ?
> __pfx_rcu_do_batch+0x10/0x10
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618838]  ?
> __kasan_check_write+0x14/0x30
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618841]  ?
> _raw_spin_unlock_irqrestore+0x11/0x60
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618843]  rcu_core+0x549/0xb50
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618846]  rcu_core_si+0xe/0x20
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618848]  handle_softirqs+0x163/=
0x570
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618851]  run_ksoftirqd+0x3a/0x6=
0
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618853]  smpboot_thread_fn+0x29=
d/0x6e0
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618857]  ?
> __pfx_smpboot_thread_fn+0x10/0x10
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618860]  kthread+0x384/0x7a0
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618862]  ?
> __pfx__raw_spin_lock_irq+0x10/0x10
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618864]  ? _raw_spin_unlock+0xe=
/0x40
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618867]  ? __pfx_kthread+0x10/0=
x10
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618868]  ?
> __kasan_check_write+0x14/0x30
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618870]  ?
> recalc_sigpending+0x160/0x220
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618873]  ?
> _raw_spin_unlock_irq+0xe/0x50
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618875]  ?
> calculate_sigpending+0x78/0xb0
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618877]  ? __pfx_kthread+0x10/0=
x10
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618879]  ret_from_fork+0x3a2/0x=
5c0
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618882]  ?
> __pfx_ret_from_fork+0x10/0x10
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618884]  ?
> __kasan_check_read+0x11/0x20
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618886]  ? __switch_to+0x372/0x=
d50
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618888]  ? __pfx_kthread+0x10/0=
x10
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618890]  ret_from_fork_asm+0x1a=
/0x30
> Feb 15 00:03:54 ceph-0005 kernel: [129973.618894]  </TASK>
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618057] watchdog: BUG: soft loc=
kup -
> CPU#0 stuck for 52s! [ksoftirqd/0:14]
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618067] Modules linked in: over=
lay
> hctr2 libpolyval nhpoly1305_avx2 nhpoly1305_sse2 nhpoly1305 chacha libcha=
cha
> adiantum libpoly1305 essiv authenc tls intel_rapl_msr intel_rapl_common
> intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_discovery
> pmt_class intel_pmc_ssram_telemetry intel_vsec kvm_intel kvm joydev irqby=
pass
> ghash_clmulni_intel aesni_intel rapl input_leds psmouse vga16fb serio_raw
> vgastate floppy mac_hid i2c_piix4 qemu_fw_cfg i2c_smbus bochs pata_acpi
> sch_fq_codel rbd msr parport_pc ppdev lp parport efi_pstore
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618116] CPU: 0 UID: 0 PID: 14 C=
omm:
> ksoftirqd/0 Tainted: G    B        L      6.19.0 #7 PREEMPT(voluntary)
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618121] Tainted: [B]=3DBAD_PAGE=
,
> [L]=3DSOFTLOCKUP
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618122] Hardware name: QEMU Sta=
ndard
> PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618125] RIP:
> 0010:get_seg_base_limit+0xcb/0x8c0
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618136] Code: ff ff ff 70 0f 84=
 e1 02
> 00 00 4c 89 ff 45 31 e4 31 db 49 bd 00 00 00 00 00 fc ff df e8 1e 2f 00 0=
0 49 63
> c4 48 83 f8 04 73 5d <49> 8d 3c 07 48 89 fa 48 89 f9 48 c1 ea 03 83 e1 07=
 42 0f
> b6 14 2a
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618138] RSP: 0018:ffff888100cc7=
758
> EFLAGS: 00000297
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618141] RAX: 0000000000000003 R=
BX:
> 0000000034680534 RCX: 0000000000000000
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618142] RDX: 0000000000000000 R=
SI:
> 0000000000000000 RDI: 0000000000000000
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618143] RBP: ffff888100cc7808 R=
08:
> 0000000000000000 R09: 0000000000000000
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618144] R10: 0000000000000000 R=
11:
> 0000000000000000 R12: 0000000000000003
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618145] R13: dffffc0000000000 R=
14:
> ffff888100cc7af8 R15: ffff888100cc7950
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618146] FS:  0000000000000000(0=
000)
> GS:ffff88823d77d000(0000) knlGS:0000000000000000
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618148] CS:  0010 DS: 0000 ES: =
0000
> CR0: 0000000080050033
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618149] CR2: 00007cab29951b50 C=
R3:
> 00000000280a4005 CR4: 0000000000772ef0
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618153] PKRU: 55555554
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618155] Call Trace:
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618156]  <TASK>
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618158]  ?
> __pfx_get_seg_base_limit+0x10/0x10
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618160]  ? get_eff_addr_reg+0x2=
5/0x430
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618162]  insn_get_addr_ref+0x4a=
1/0x910
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618164]  ?
> __pfx_insn_get_addr_ref+0x10/0x10
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618166]  ?
> insn_get_displacement+0x2d6/0xaa0
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618168]  ?
> insn_get_immediate+0x75/0x24a0
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618170]
> get_kernel_gp_address+0x124/0x210
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618175]  ?
> __pfx_get_kernel_gp_address+0x10/0x10
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618177]  ?
> gp_try_fixup_and_notify+0xce/0x160
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618179]
> exc_general_protection+0x1d8/0x280
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618182]  ?
> __kasan_check_read+0x11/0x20
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618187]  ?
> free_frozen_page_commit.isra.0+0x3c1/0x1240
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618192]  ?
> __pfx__raw_spin_trylock+0x10/0x10
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618195]
> asm_exc_general_protection+0x27/0x30
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618199] RIP:
> 0010:rcu_do_batch+0x3d1/0xe70
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618204] Code: 48 8b 72 08 48 85=
 f6 0f
> 84 1d 02 00 00 48 89 c8 48 c1 e8 03 42 80 3c 20 00 0f 85 86 08 00 00 48 c=
7 42 08
> 00 00 00 00 48 89 d7 <2e> 2e 2e ff d6 65 f6 05 83 f1 3d 06 01 0f 85 2d ff=
 ff ff
> be 00 02
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618205] RSP: 0018:ffff888100cc7=
ba8
> EFLAGS: 00010246
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618207] RAX: 1ffff11024882c50 R=
BX:
> 0000000000000003 RCX: ffff888124416280
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618208] RDX: ffff888124416278 R=
SI:
> b39f32800676020b RDI: ffff888124416278
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618209] RBP: ffff888100cc7cc8 R=
08:
> 0000000000000000 R09: 0000000000000000
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618209] R10: 0000000000000000 R=
11:
> 0000000000000000 R12: dffffc0000000000
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618210] R13: ffff888100cb0000 R=
14:
> ffff888100cc7c40 R15: 0000000000000002
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618213]  ? rcu_do_batch+0x3d6/0=
xe70
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618215]  ?
> __pfx_rcu_do_batch+0x10/0x10
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618217]  ?
> __kasan_check_write+0x14/0x30
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618219]  ?
> _raw_spin_unlock_irqrestore+0x11/0x60
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618222]  rcu_core+0x549/0xb50
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618224]  rcu_core_si+0xe/0x20
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618226]  handle_softirqs+0x163/=
0x570
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618230]  run_ksoftirqd+0x3a/0x6=
0
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618231]  smpboot_thread_fn+0x29=
d/0x6e0
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618237]  ?
> __pfx_smpboot_thread_fn+0x10/0x10
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618241]  kthread+0x384/0x7a0
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618244]  ?
> __pfx__raw_spin_lock_irq+0x10/0x10
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618249]  ? _raw_spin_unlock+0xe=
/0x40
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618254]  ? __pfx_kthread+0x10/0=
x10
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618257]  ?
> __kasan_check_write+0x14/0x30
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618261]  ?
> recalc_sigpending+0x160/0x220
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618266]  ?
> _raw_spin_unlock_irq+0xe/0x50
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618270]  ?
> calculate_sigpending+0x78/0xb0
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618274]  ? __pfx_kthread+0x10/0=
x10
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618278]  ret_from_fork+0x3a2/0x=
5c0
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618282]  ?
> __pfx_ret_from_fork+0x10/0x10
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618286]  ?
> __kasan_check_read+0x11/0x20
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618289]  ? __switch_to+0x372/0x=
d50
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618293]  ? __pfx_kthread+0x10/0=
x10
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618296]  ret_from_fork_asm+0x1a=
/0x30
> Feb 15 00:04:22 ceph-0005 kernel: [130001.618302]  </TASK>
> Feb 15 00:04:30 ceph-0005 kernel: [130009.599270] rcu: INFO: rcu_preempt =
self-
> detected stall on CPU
> Feb 15 00:04:30 ceph-0005 kernel: [130009.599639] rcu:  0-....: (1 GPs be=
hind)
> idle=3D116c/1/0x4000000000000000 softirq=3D6042548/6042603 fqs=3D14030
> Feb 15 00:04:30 ceph-0005 kernel: [130009.600120] rcu:           hardirqs
> softirqs   csw/system
> Feb 15 00:04:30 ceph-0005 kernel: [130009.600448] rcu:   number:    30055
> 0            0
> Feb 15 00:04:30 ceph-0005 kernel: [130009.600741] rcu:  cputime:        0
> 29995            0   =3D=3D> 30001(ms)
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601063] rcu:  (t=3D60002 jiffie=
s
> g=3D16092025 q=3D14362 ncpus=3D8)
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601350] CPU: 0 UID: 0 PID: 14 C=
omm:
> ksoftirqd/0 Tainted: G    B        L      6.19.0 #7 PREEMPT(voluntary)
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601354] Tainted: [B]=3DBAD_PAGE=
,
> [L]=3DSOFTLOCKUP
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601354] Hardware name: QEMU Sta=
ndard
> PC (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/10/2025
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601357] RIP:
> 0010:inat_get_opcode_attribute+0x2c/0x80
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601367] Code: 44 00 00 48 ba 00=
 00 00
> 00 00 fc ff df 40 0f b6 c7 48 8d 3c 85 a0 31 1c b7 48 89 f9 48 c1 e9 03 0=
f b6 0c
> 11 48 89 fa 83 e2 07 <83> c2 03 38 ca 7c 04 84 c9 75 14 8b 04 85 a0 31 1c=
 b7 31
> d2 31 c9
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601369] RSP: 0018:ffff888100cc7=
750
> EFLAGS: 00000246
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601373] RAX: 000000000000002e R=
BX:
> 000000005329d7b0 RCX: 0000000000000000
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601374] RDX: 0000000000000000 R=
SI:
> 0000000000000000 RDI: ffffffffb71c3258
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601375] RBP: ffff888100cc7808 R=
08:
> 0000000000000000 R09: 0000000000000000
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601376] R10: 0000000000000000 R=
11:
> 0000000000000000 R12: 0000000000000003
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601377] R13: dffffc0000000000 R=
14:
> ffff888100cc7af8 R15: ffff888100cc7950
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601378] FS:  0000000000000000(0=
000)
> GS:ffff88823d77d000(0000) knlGS:0000000000000000
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601380] CS:  0010 DS: 0000 ES: =
0000
> CR0: 0000000080050033
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601381] CR2: 00007cab29951b50 C=
R3:
> 00000000280a4005 CR4: 0000000000772ef0
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601384] PKRU: 55555554
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601385] Call Trace:
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601386]  <TASK>
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601387]  ?
> get_seg_base_limit+0xfc/0x8c0
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601389]  ?
> __pfx_get_seg_base_limit+0x10/0x10
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601391]  ? get_eff_addr_reg+0x2=
5/0x430
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601393]  insn_get_addr_ref+0x4a=
1/0x910
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601395]  ?
> __pfx_insn_get_addr_ref+0x10/0x10
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601396]  ?
> insn_get_displacement+0x2d6/0xaa0
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601398]  ?
> insn_get_immediate+0x75/0x24a0
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601400]
> get_kernel_gp_address+0x124/0x210
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601405]  ?
> __pfx_get_kernel_gp_address+0x10/0x10
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601407]  ?
> gp_try_fixup_and_notify+0xce/0x160
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601409]
> exc_general_protection+0x1d8/0x280
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601412]  ?
> __kasan_check_read+0x11/0x20
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601417]  ?
> free_frozen_page_commit.isra.0+0x3c1/0x1240
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601421]  ?
> __pfx__raw_spin_trylock+0x10/0x10
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601425]
> asm_exc_general_protection+0x27/0x30
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601428] RIP:
> 0010:rcu_do_batch+0x3d1/0xe70
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601433] Code: 48 8b 72 08 48 85=
 f6 0f
> 84 1d 02 00 00 48 89 c8 48 c1 e8 03 42 80 3c 20 00 0f 85 86 08 00 00 48 c=
7 42 08
> 00 00 00 00 48 89 d7 <2e> 2e 2e ff d6 65 f6 05 83 f1 3d 06 01 0f 85 2d ff=
 ff ff
> be 00 02
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601434] RSP: 0018:ffff888100cc7=
ba8
> EFLAGS: 00010246
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601435] RAX: 1ffff11024882c50 R=
BX:
> 0000000000000003 RCX: ffff888124416280
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601436] RDX: ffff888124416278 R=
SI:
> b39f32800676020b RDI: ffff888124416278
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601437] RBP: ffff888100cc7cc8 R=
08:
> 0000000000000000 R09: 0000000000000000
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601437] R10: 0000000000000000 R=
11:
> 0000000000000000 R12: dffffc0000000000
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601438] R13: ffff888100cb0000 R=
14:
> ffff888100cc7c40 R15: 0000000000000002
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601441]  ? rcu_do_batch+0x3d6/0=
xe70
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601443]  ?
> __pfx_rcu_do_batch+0x10/0x10
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601445]  ?
> __kasan_check_write+0x14/0x30
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601447]  ?
> _raw_spin_unlock_irqrestore+0x11/0x60
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601449]  rcu_core+0x549/0xb50
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601451]  rcu_core_si+0xe/0x20
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601453]  handle_softirqs+0x163/=
0x570
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601457]  run_ksoftirqd+0x3a/0x6=
0
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601458]  smpboot_thread_fn+0x29=
d/0x6e0
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601462]  ?
> __pfx_smpboot_thread_fn+0x10/0x10
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601465]  kthread+0x384/0x7a0
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601467]  ?
> __pfx__raw_spin_lock_irq+0x10/0x10
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601469]  ? _raw_spin_unlock+0xe=
/0x40
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601471]  ? __pfx_kthread+0x10/0=
x10
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601472]  ?
> __kasan_check_write+0x14/0x30
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601474]  ?
> recalc_sigpending+0x160/0x220
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601477]  ?
> _raw_spin_unlock_irq+0xe/0x50
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601479]  ?
> calculate_sigpending+0x78/0xb0
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601481]  ? __pfx_kthread+0x10/0=
x10
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601482]  ret_from_fork+0x3a2/0x=
5c0
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601486]  ?
> __pfx_ret_from_fork+0x10/0x10
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601488]  ?
> __kasan_check_read+0x11/0x20
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601489]  ? __switch_to+0x372/0x=
d50
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601491]  ? __pfx_kthread+0x10/0=
x10
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601492]  ret_from_fork_asm+0x1a=
/0x30
> Feb 15 00:04:30 ceph-0005 kernel: [130009.601496]  </TASK>
>
> Are you able to reproduce the issue?
>
> I am continuing to take a deeper look into the issue with the goal to und=
erstand
> the reproduction way and the nature of the issue.
>
> Thanks,
> Slava.

