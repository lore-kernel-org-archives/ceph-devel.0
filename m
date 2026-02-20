Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD232EDD52
	for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2026 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771609772; cv=pass; b=pPu+CjZOXgNE2ykr/Do5ECyvxmax/m3NESN0RPOmcyzhT6LKiLTYV8Bzmyz5HDXxgGm55HN29+6mkhBOcip50FcfjpaYujr8cqiLi0O076kniCx/f0vOG95GuHzwVHfSGzjoCiPFwhzPv0QfYrtz1KHS2oTeh0fz51vYAaXK0vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771609772; c=relaxed/simple;
	bh=KNRU0MIsVgfjbbtE752ijxiCBicfJWRRpZ7ssF2mzCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P0AmI5ngJ63bIocvfQ+sfLtEdku06W478eU7ALkTwPmWXbVTU7d9Z7vaQJBowxEc1clOjhIxETQ2+L8GwyGhQNVNcIOAwQ1gnLFIHm+Nm2b6pNrJztejC1sK/XwA9b/ftZOwfmjJgQmWMoo/g/bLsJ2SkSIuO2lUoA8v425VYFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw8l+soL; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw8l+soL"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12713e56abdso1664725c88.1
        for <ceph-devel@vger.kernel.org>; Fri, 20 Feb 2026 09:49:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771609770; cv=none;
        d=google.com; s=arc-20240605;
        b=WHgr20htfg3vlZm5ruRUK71TtkRWA37YZVEimgMyc9v00rBhCqQo8ARqCzsq3e/tgx
         BnDv4m/AeAVvPh/x0rpcDn7MWd2k6tcxl4Sezpmcrw5AxPPMJLVs9QiB2kqWJiHR3L1J
         bXdWMPcBdW07bfYrki/Q+prE7vLQ27QvzPMzfsjOPSBF32ZwjwdlrANlSp79b49ZycAS
         pabXIYAAB6x5tMKq7YJ1zU5saJwFHelO+Lh5N2SICeLRFIrwb4RTHrURxpQpyqNKrd/N
         5CHeahpdPCJLMA2izGhMPD2GnIIGHE8n4v9oBH2MrqB3D9k7w3GwyjkCm1zYVdphqPye
         Up2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OrZrWNtQPeYeihdF1+XT6FCPoPWNGXYpMlrbILHvr6c=;
        fh=OIe3ObWcFqsYd9CPWDaW+vNgjvd+NsU2OfXcQUDEWh4=;
        b=ZmFBBVQA+5WH3gw9lu3n+iKCnJH1NXxATjMB4Q6QRIlX31gzY6KvKaCPkYQlYzYD2W
         Rqj1WVAWIVWUc/6rGopnl+SR38p6hqyx32Eji3xFRzbVPHtRuTiKjVZHpPynOVfoEIGZ
         2KqyffakxwQiI6dPXRRK/uGA1kBITT4vsvcpgbDsuHb3r/Oi6oXPVkUTxm9vSlQFmCBp
         zjPTE4yhAgzCFn6EHXr4eLymmNRjmXmRHPqYnVvEXXLkqciJfU9WPXLWC9U8VawiaK0W
         aHCi2AYtPJW8+HM9EBOCFU9TeKMJuQ6gcAsCA1nvyKB3Mn+jphwVeDEvJJqudnfvCzYh
         m/BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771609770; x=1772214570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrZrWNtQPeYeihdF1+XT6FCPoPWNGXYpMlrbILHvr6c=;
        b=Hw8l+soLvuotA1yDiDihRKAcDi+7BHaXoPi1hg83Ldh0OpvoguxFRRZ5oshPO0d8ml
         oH+csqOSvkk+WJkABYoASwvEYl4yHKXTjuOik3OBKSaNkecKdAsk7+GVDGdTUpf4V+VC
         l0bW9hcu6XV4A7+W5NiYAewUCiKQW4JgLEWbnIrgDQBZyF7CNH4L+MaoUq0VfpnsjEpO
         VUClU4ctUjXMFADma5at43B/pZ3vAqeYEuZjFof9Pgy1GtJo85f/d0eCcGeHtQaVs+mo
         IeHzUDI43Do8rjxbnpv3A1GaoVjOTeqdQ0y0vKMPHDZ5V7uy8n2BC3lT4K9n/1CtaQZB
         TxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771609770; x=1772214570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OrZrWNtQPeYeihdF1+XT6FCPoPWNGXYpMlrbILHvr6c=;
        b=Ot1pr9KQ4AJvtNr7WuuPdqFOkOh+n5satC2soV1ra8f4Km8KFcRHaO0zqDqcwY35qw
         Jo9B8v6jeWdOFxrRj4MKiODCXMBbCVh2ZTECV3HN/i+S+vfoiH6/YKJqmI5kEKgL3v+h
         a4tZDUos8doGW8hAuYvuLGvlQSGvQ8DfKvaTgpyfFcHllg3B75+AisNZNG36H+s6iAFQ
         dZAAL7FnKv4aJxAgLhtzzXpD4LBD0Kob4EzuqyolfAHqY9T4KRBT5ePjOXS+lXTG5vq2
         MSsvk0Dr3mWJuOcX0DZ5wMxaLfTLUw2xDRn8scN2l9he06ic5jk3pn1sv51h37Uy5jaj
         gFWw==
X-Forwarded-Encrypted: i=1; AJvYcCU3cy+iDBsWAvVruQa/SF3DT4dCY5v430YLMYBzZir75Z8wIp+uUesH3BQBTjaSQ08ulfa/IUumALGw@vger.kernel.org
X-Gm-Message-State: AOJu0YxqbS5InYtWFG2moG+vQZ2jNnAcjtec+BZ2KgWxNQyLTkGvPysI
	3MU164deVo6ggpxEO6eB/Z0SQso5txX7aBerq5x3vA6RbP1xjZEmrqMRRghnEVOslC4gYujS4YL
	8dL117DCVYJZIBvPlc8Wv6uiGo28zSrw=
X-Gm-Gg: AZuq6aLoXI81348cSdNunUbFbro1lGXubeyyaVeNfVXiqDH1vnzqpRdx0uHN6FadOJu
	2WA516RPS/p92/VFttTsDOhMtG+M17tbVvJElCfPPJ8rbB1YLXUBSUfkJNS5E6QUymha+2ehhH4
	QmxMBH8kMHaJaEkdGsR62TbRIPZTqfg10mCxrbR4zb1NYF42H+gyBtFtysxfLdB2xLr/1cFbRjD
	8hEYMpnqw2jzG/5uxcRaW6bhXLapINJdzCE4FSvJiVp5MxUG79PcdEbdLIfQ0nV/ZJWTwcEcR8t
	3tNPFZ0=
X-Received: by 2002:a05:7022:61a8:b0:124:4d0d:6921 with SMTP id
 a92af1059eb24-1275fa5c202mr2569447c88.6.1771609769646; Fri, 20 Feb 2026
 09:49:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <775f9e1d-ab5c-4965-a8fc-bebebf3d1b0a@tu-ilmenau.de>
In-Reply-To: <775f9e1d-ab5c-4965-a8fc-bebebf3d1b0a@tu-ilmenau.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Fri, 20 Feb 2026 18:49:18 +0100
X-Gm-Features: AaiRm52cZHT1h4MOsrMhvgQoB4LfDywrE4bmOLjmc_W7fiAT0mdztI6PLPPzWyA
Message-ID: <CAOi1vP8+P7x4X28qV9kzVX0D8FVA8ZX3BRFrDDXJ3rnfmQgjmA@mail.gmail.com>
Subject: Re: [bug report] libceph: slab-out-of-bounds memory access in messenger_v2
To: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Cc: amarkuze@redhat.com, slava@dubeyko.com, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 5:32=E2=80=AFPM Raphael Zimmer
<raphael.zimmer@tu-ilmenau.de> wrote:
>
> Hello,
>
> I encountered a bug in the kernel Ceph client (specifically in the
> messenger_v2 implementation). I have two slightly different stack traces
> that point to the same issue: [1],[2].
>
> The bug realizes as an out-of-bounds memory access in the function
> process_message_header() in net/ceph/messenger_v2.c:2843.
>
>  From my perspective, the following happens:
> Prerequisite: Messenger_v2 connection that isn't in ms_mode secure.
> The bug can be triggered in states CEPH_CON_S_V2_HELLO (stack trace [1])
> and CEPH_CON_S_V2_AUTH (stack trace [2]), by a message with tag
> FRAME_TAG_MESSAGE and a small value for ctrl_len. This message leads to
> the following behavior when received from ceph_con_v2_try_read()
> (net/ceph/messenger_v2.c:3128):
> - First iteration in ceph_con_v2_try_read(): populate_in_iter() ->
> handle_preamble() -> prepare_read_control(). In line 1780, ctrl_len is
> read from the incoming message and in lines 1787/1788 a buffer is
> allocated with a size calculated using crtl_len. In line 1795,
> add_in_kvec() is called using a part of this buffer.
> - Second iteration in ceph_con_v2_try_read(): populate_in_iter() ->
> handle_control() -> __handle_control().
>    - Case CEPH_CON_S_V2_HELLO: __handle_control() is called with the
> previously added kvec (line 2991).
>    - Case CEPH_CON_S_V2_AUTH: A new buffer with length ctrl_len is
> allocated and __handle_control() is called with this one (line 2988).
>    In __handle_control(), process_message_header() is called (line
> 2901). In this function, the pointer to the allocated buffer is
> reinterpreted as a ceph_msg_header2*, which is possibly larger than the
> allocated buffer and therefore causes the overflow.
>
> The bug can be triggered deterministically over the network and could
> therefore potentially be exploited.
>
> Note: I also created a corresponding issue at
> https://tracker.ceph.com/issues/75054.
>
> Best regards,
> Raphael
>
>
> [1]
> BUG: KASAN: slab-out-of-bounds in __handle_control+0x200c/0x51d0 [libceph=
]
> [  368.183535] Read of size 8 at addr ffff8881015a6aa0 by task
> kworker/22:1/293
>
> [  368.185184] CPU: 22 UID: 0 PID: 293 Comm: kworker/22:1 Not tainted
> 6.19.2 #1 PREEMPT(voluntary)
> [  368.185188] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  368.185189] Workqueue: ceph-msgr ceph_con_workfn [libceph]
> [  368.185215] Call Trace:
> [  368.185217]  <TASK>
> [  368.185218]  dump_stack_lvl+0x76/0xa0
> [  368.185222]  print_report+0xd1/0x620
> [  368.185226]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  368.185229]  ? kasan_complete_mode_report_info+0x26/0x210
> [  368.185231]  kasan_report+0xe7/0x130
> [  368.185233]  ? __handle_control+0x200c/0x51d0 [libceph]
> [  368.185257]  ? __handle_control+0x200c/0x51d0 [libceph]
> [  368.185280]  __asan_report_load_n_noabort+0xf/0x20
> [  368.185282]  __handle_control+0x200c/0x51d0 [libceph]
> [  368.185304]  ? inet_recvmsg+0xfc/0x4e0
> [  368.185308]  ? __pfx___handle_control+0x10/0x10 [libceph]
> [  368.185330]  ? apparmor_socket_recvmsg+0x6b/0xa0
> [  368.185334]  ? __pfx_inet_recvmsg+0x10/0x10
> [  368.185336]  ? do_recvmsg+0x17c/0x250 [libceph]
> [  368.185359]  ? __pfx_do_recvmsg+0x10/0x10 [libceph]
> [  368.185382]  ? __kasan_kmalloc+0xc3/0xd0
> [  368.185385]  ceph_con_v2_try_read+0x445/0x6c80 [libceph]
> [  368.185409]  ? __pfx_ceph_con_v2_try_read+0x10/0x10 [libceph]
> [  368.185431]  ? save_fpregs_to_fpstate+0xb0/0x230
> [  368.185434]  ? raw_spin_rq_unlock+0x17/0xa0
> [  368.185438]  ? finish_task_switch.isra.0+0x13b/0x760
> [  368.185440]  ? __switch_to+0x385/0xda0
> [  368.185443]  ? __kasan_check_write+0x14/0x30
> [  368.185445]  ? mutex_lock+0x8d/0xe0
> [  368.185448]  ? __pfx_mutex_lock+0x10/0x10
> [  368.185451]  ceph_con_workfn+0x248/0x10c0 [libceph]
> [  368.185473]  process_one_work+0x629/0xf80
> [  368.185477]  ? __kasan_check_write+0x14/0x30
> [  368.185479]  worker_thread+0x87f/0x1570
> [  368.185481]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  368.185483]  ? __pfx_try_to_wake_up+0x10/0x10
> [  368.185486]  ? kasan_print_address_stack_frame+0x1f7/0x280
> [  368.185488]  ? __pfx_worker_thread+0x10/0x10
> [  368.185491]  kthread+0x396/0x830
> [  368.185493]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  368.185495]  ? __pfx_kthread+0x10/0x10
> [  368.185497]  ? __kasan_check_write+0x14/0x30
> [  368.185499]  ? recalc_sigpending+0x180/0x210
> [  368.185502]  ? __pfx_kthread+0x10/0x10
> [  368.185504]  ret_from_fork+0x3f7/0x610
> [  368.185507]  ? __pfx_ret_from_fork+0x10/0x10
> [  368.185509]  ? __switch_to+0x385/0xda0
> [  368.185511]  ? __pfx_kthread+0x10/0x10
> [  368.185513]  ret_from_fork_asm+0x1a/0x30
> [  368.185517]  </TASK>
>
> [  368.230973] Allocated by task 293 on cpu 22 at 368.180643s:
> [  368.232245]  kasan_save_stack+0x39/0x70
> [  368.232250]  kasan_save_track+0x18/0x70
> [  368.232252]  kasan_save_alloc_info+0x37/0x60
> [  368.232255]  __kasan_kmalloc+0xc3/0xd0
> [  368.232257]  __kvmalloc_node_noprof+0x274/0x8d0
> [  368.232260]  alloc_conn_buf+0x6c/0x1a0 [libceph]
> [  368.232285]  ceph_con_v2_try_read+0x41b5/0x6c80 [libceph]
> [  368.232308]  ceph_con_workfn+0x248/0x10c0 [libceph]
> [  368.232332]  process_one_work+0x629/0xf80
> [  368.232334]  worker_thread+0x87f/0x1570
> [  368.232337]  kthread+0x396/0x830
> [  368.232339]  ret_from_fork+0x3f7/0x610
> [  368.232342]  ret_from_fork_asm+0x1a/0x30
>
> [  368.232874] The buggy address belongs to the object at ffff8881015a6a8=
0
>                  which belongs to the cache kmalloc-rnd-03-64 of size 64
> [  368.235730] The buggy address is located 32 bytes inside of
>                  allocated 38-byte region [ffff8881015a6a80,
> ffff8881015a6aa6)
>
> [  368.239115] The buggy address belongs to the physical page:
> [  368.240404] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x1015a6
> [  368.240408] flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0x1=
fffff)
> [  368.240412] page_type: f5(slab)
> [  368.240415] raw: 0017ffffc0000000 ffff88810004b980 dead000000000122
> 0000000000000000
> [  368.240418] raw: 0000000000000000 0000000080200020 00000000f5000000
> 0000000000000000
> [  368.240419] page dumped because: kasan: bad access detected
>
> [  368.241053] Memory state around the buggy address:
> [  368.242303]  ffff8881015a6980: fc fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc
> [  368.243891]  ffff8881015a6a00: fc fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc
> [  368.245482] >ffff8881015a6a80: 00 00 00 00 06 fc fc fc fc fc fc fc fc
> fc fc fc
> [  368.247056]                                ^
> [  368.248114]  ffff8881015a6b00: fc fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc
> [  368.249706]  ffff8881015a6b80: fc fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc
> [  368.251297]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> [2]
> [  262.128999] BUG: KASAN: slab-out-of-bounds in
> __handle_control+0x200c/0x51d0 [libceph]
> [  262.130770] Read of size 8 at addr ffff8881a47c83f0 by task
> kworker/22:1/279
>
> [  262.132487] CPU: 22 UID: 0 PID: 279 Comm: kworker/22:1 Tainted: G
>     W           6.19.2 #1 PREEMPT(voluntary)
> [  262.132491] Tainted: [W]=3DWARN
> [  262.132492] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [  262.132494] Workqueue: ceph-msgr ceph_con_workfn [libceph]
> [  262.132518] Call Trace:
> [  262.132519]  <TASK>
> [  262.132520]  dump_stack_lvl+0x76/0xa0
> [  262.132524]  print_report+0xd1/0x620
> [  262.132526]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  262.132528]  ? kasan_save_stack+0x39/0x70
> [  262.132531]  ? kasan_complete_mode_report_info+0x26/0x210
> [  262.132533]  kasan_report+0xe7/0x130
> [  262.132535]  ? __handle_control+0x200c/0x51d0 [libceph]
> [  262.132558]  ? __handle_control+0x200c/0x51d0 [libceph]
> [  262.132581]  __asan_report_load_n_noabort+0xf/0x20
> [  262.132583]  __handle_control+0x200c/0x51d0 [libceph]
> [  262.132607]  ? __pfx___handle_control+0x10/0x10 [libceph]
> [  262.132629]  ? kvm_sched_clock_read+0x11/0x20
> [  262.132632]  ? sched_clock_noinstr+0x9/0x10
> [  262.132634]  ? kasan_save_track+0x27/0x70
> [  262.132637]  ? kasan_save_alloc_info+0x37/0x60
> [  262.132638]  ? __kasan_kmalloc+0xc3/0xd0
> [  262.132641]  ? __kvmalloc_node_noprof+0x288/0x8e0
> [  262.132644]  ? alloc_conn_buf+0xd3/0x2b0 [libceph]
> [  262.132667]  ceph_con_v2_try_read+0x357d/0x6c80 [libceph]
> [  262.132691]  ? __pfx_ceph_con_v2_try_read+0x10/0x10 [libceph]
> [  262.132713]  ? save_fpregs_to_fpstate+0xb0/0x230
> [  262.132715]  ? raw_spin_rq_unlock+0x17/0xa0
> [  262.132718]  ? finish_task_switch.isra.0+0x13b/0x760
> [  262.132720]  ? __switch_to+0x385/0xda0
> [  262.132722]  ? __kasan_check_write+0x14/0x30
> [  262.132724]  ? mutex_lock+0x8d/0xe0
> [  262.132726]  ? __pfx_mutex_lock+0x10/0x10
> [  262.132729]  ceph_con_workfn+0x248/0x10c0 [libceph]
> [  262.132752]  process_one_work+0x629/0xf80
> [  262.132754]  ? __kasan_check_write+0x14/0x30
> [  262.132757]  worker_thread+0x87f/0x1570
> [  262.132759]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  262.132761]  ? __pfx_try_to_wake_up+0x10/0x10
> [  262.132764]  ? kasan_print_address_stack_frame+0x1b7/0x280
> [  262.132766]  ? __pfx_worker_thread+0x10/0x10
> [  262.132769]  kthread+0x396/0x830
> [  262.132771]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  262.132773]  ? __pfx_kthread+0x10/0x10
> [  262.132775]  ? __kasan_check_write+0x14/0x30
> [  262.132776]  ? recalc_sigpending+0x180/0x210
> [  262.132779]  ? __pfx_kthread+0x10/0x10
> [  262.132781]  ret_from_fork+0x3f7/0x610
> [  262.132784]  ? __pfx_ret_from_fork+0x10/0x10
> [  262.132786]  ? __switch_to+0x385/0xda0
> [  262.132788]  ? __pfx_kthread+0x10/0x10
> [  262.132790]  ret_from_fork_asm+0x1a/0x30
> [  262.132793]  </TASK>
>
> [  262.181727] Allocated by task 279 on cpu 22 at 262.127486s:
> [  262.183055]  kasan_save_stack+0x39/0x70
> [  262.183062]  kasan_save_track+0x18/0x70
> [  262.183065]  kasan_save_alloc_info+0x37/0x60
> [  262.183068]  __kasan_kmalloc+0xc3/0xd0
> [  262.183070]  __kvmalloc_node_noprof+0x288/0x8e0
> [  262.183074]  alloc_conn_buf+0xd3/0x2b0 [libceph]
> [  262.183103]  ceph_con_v2_try_read+0x3535/0x6c80 [libceph]
> [  262.183127]  ceph_con_workfn+0x248/0x10c0 [libceph]
> [  262.183152]  process_one_work+0x629/0xf80
> [  262.183156]  worker_thread+0x87f/0x1570
> [  262.183159]  kthread+0x396/0x830
> [  262.183162]  ret_from_fork+0x3f7/0x610
> [  262.183165]  ret_from_fork_asm+0x1a/0x30
>
> [  262.183719] The buggy address belongs to the object at ffff8881a47c83f=
0
>                  which belongs to the cache kmalloc-rnd-15-8 of size 8
> [  262.186670] The buggy address is located 0 bytes inside of
>                  allocated 2-byte region [ffff8881a47c83f0,
> ffff8881a47c83f2)
>
> [  262.190210] The buggy address belongs to the physical page:
> [  262.191489] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x1a47c8
> [  262.191494] memcg:ffff88811cfe6001
> [  262.191495] flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0x1=
fffff)
> [  262.191499] page_type: f5(slab)
> [  262.191502] raw: 0017ffffc0000000 ffff88810005b980 dead000000000122
> 0000000000000000
> [  262.191505] raw: 0000000000000000 0000000080550055 00000000f5000000
> ffff88811cfe6001
> [  262.191507] page dumped because: kasan: bad access detected
>
> [  262.192067] Memory state around the buggy address:
> [  262.193215]  ffff8881a47c8280: fc fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc
> [  262.194795]  ffff8881a47c8300: fc fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc
> [  262.196608] >ffff8881a47c8380: fc fc fc fc fc fc fc fc fc fc fc fc fc
> fc 02 fc
> [  262.198301]
>     ^
> [  262.199832]  ffff8881a47c8400: fc fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc
> [  262.201432]  ffff8881a47c8480: fc fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc
> [  262.203017]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Hi Raphael,

Thanks for the report, I'll get this patched.

                Ilya
