Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB82367D9
	for <ceph-devel@vger.kernel.org>; Wed, 18 Feb 2026 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771407749; cv=pass; b=Q++FylR2U1sGBfgiMPgkZMP7yiPOee9rOz35Y0cpBJ9BM0MaYN3XI6ktQ9UT5hexZwR9snaNopzHbZjyPxFcuZzALHPquUvI6Qwx/3DteZz59Q/tkbx1hJw1GYF+X5r06N9GVE9xCsda0wE/y7ClOYTj6AJEPC0NZYWDuzP+O9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771407749; c=relaxed/simple;
	bh=ACEYpDuEc9B5/dgKTa54VZBUrNXpjXxdvKEc2lNfX5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3akBWf6nyeMUQ741rZ+02IC1rTXa4EkDD6uykTEyEr4giz82VSOzIh8FIeKkTSIKl4K8zLq/zl+PlD414D/KGuq4LyywYu4s1W4CnD8kiZMA1Ni09sHGAdRNS7Vy3O2sgBWXJkWTlFYCTyUSfR9xPAScMJL20v8d0RCgBSry98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gCLXjpav; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1n+REMY; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCLXjpav";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1n+REMY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771407746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JgaakukZ7gDnV3PG7p8sbXuknlO9vsb0kMNos7Dar+E=;
	b=gCLXjpavbwDiJVnWAs6cHJXovwgXBbZIPZgb1k0ekkIJAx4+FMpSxaUV8fDdtOAsX4URK6
	TuUq6GGGUHRcPb1cPMDXCS4vOrt1cf2Nf0/fNTWptCFqc7Cd7XSzBFmjWApTin+cyJmo78
	p76KcJtxh/FxgU7JpsTQGi9Vu6j2aXk=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-RCpTErppNLCjIzmuUxVUKA-1; Wed, 18 Feb 2026 04:42:25 -0500
X-MC-Unique: RCpTErppNLCjIzmuUxVUKA-1
X-Mimecast-MFC-AGG-ID: RCpTErppNLCjIzmuUxVUKA_1771407744
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5fcce5db266so44325406137.3
        for <ceph-devel@vger.kernel.org>; Wed, 18 Feb 2026 01:42:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771407744; cv=none;
        d=google.com; s=arc-20240605;
        b=UGSRkA17L9TuW7x3rI7joRv5PLOAIlUMbQarzpO8+YjxBY50DPvlJ6XTUgCA1xJUlZ
         ZN1K60OKA9G3T5wUTyR/xX0QL/dTYxeOei3hH3wBVLOwXwHXhJfkcu/SbsYCCYICYCWN
         +oYkRG+fVr+KjQoYEzLYTSOqgcdyAcNQ2YFTwv0phmOXxF39XfvGy4Dq66aQrfQjIlvM
         wq2/1d1nQ2/Cz8rPjpkzRWEYT+/ybJCw8JU08hKILdNl0RlMy1COU2r2koUyLexs87ow
         PWuOAE6fe2oLJO/J2HdwwQDbVLYimLU0y2X2Z4V/WXF/d2EISommLaxXG7i9SPZX9irR
         MHAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JgaakukZ7gDnV3PG7p8sbXuknlO9vsb0kMNos7Dar+E=;
        fh=RzL1fhONJ5JVHEPS+7TDbRnEgCHtrchBSmec9q+EMVA=;
        b=KmhyTpQlkD3590MHSMBwQuFmYIAXxySOPxm50GQhyZu+uBWyyFF20dF0VIKPDk4KPY
         rwV4Et37zbpwEuO7sCIh9P0lbAkDkAc3yvzYwa6zRLg5HtlzHYE3hV+lWfdq4lRPEdlj
         qcWspO56ABF/I1hfyeDEsqiBl3ofaRGR7jq72pZYj/H0vcS2qHX8ajIjzy2wbrbMMUp9
         0iJVcocDGjuCfQWGnhYbxfANstghBYxOTrNMeyIdgZQdd6XGdnRTjVS5bpi4XdVcuE9r
         RzfSih3vPOc2D8ZHb8nLuUV5cxu7PJ+PliY1ELMoKkSEXETPEC+sBIPTrSGNsoEJSBN2
         EAig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771407744; x=1772012544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgaakukZ7gDnV3PG7p8sbXuknlO9vsb0kMNos7Dar+E=;
        b=M1n+REMYan1EUogFXeTy5mTkAm8O5wzMtebG7i8mghMC7F/gnpjdyY3paA4BLtdBb1
         d8iQ7doqbTSpBnLGOLXoBnLhEOwMXxkP+lVl2mVG4q+hJxJgkNrZ9Ng11EOlvO1LKUM0
         fUnU/wITYijW7UmiKrOaC1XYpCtUEZ4D78KvqBh7gu+r8TzfCfyaeEKvbLXGwiel1zhk
         RnVjXO4UuS1UUMHylL3uyQbIyNbFEBVCb3/phLfKUetfWXmUfJ1QWQ71r9c84UiHeKdx
         SNElecJyPThjntzqbjRTBxDs0IihnL7vURxq7qH0gc1tX//Di1T+cY2+G6Kvr6fjCH5Y
         X3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771407744; x=1772012544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgaakukZ7gDnV3PG7p8sbXuknlO9vsb0kMNos7Dar+E=;
        b=Vxy9aRBx+6Dhv9clCXHKCq/XjZK6ghHcg2Si/4DaF2noTG5ZCfocrOT/UdhbXuWpZT
         3E5U2heHpNk+YI5mvORpnwBD2KOQOnGFGg7tgnBsVhDPBao1vzK2L7+pJ/cSg5R34bEX
         feTtalO9MokHMrOChUJ1yDW/AKXPrUtSByMgNTirB/aZhGk5BQktBr0YKwg3QVsgPb+t
         k+B+tyONUD0p1aK3I9Om1PiKkjHtlp0cZvMRx5ykeZi59z9TuqCCPNqs9fhqSI2FmBOf
         EsCtNIzY6URxRJGJoRpfcNzYL2KENFr7Dk8Za+DlowZcOvsDDWkoMITtw5qfU9GxpE4L
         jtjA==
X-Gm-Message-State: AOJu0YwZeSKmbdrN2oZpnNy3ljsO/b7I6eWtirLOWC7QforwDme2tWty
	zt7c8zepqPXf3NAULexVfifN3Yc8hkRrO6GxJVpno4E/QHQfBkkYV66u/qJf1ddI8Wpa57EO/v4
	ih9jHGJJq2EVg/yJ0ANkprfOIIwVIF9nup+yRfhHufMrt9cTnNr9uFVsYcnAsvWTjdJ51fGMBN4
	Xdj4/jRpFnn8vASMzsMfQK+GD9lW2OG2+dCkY6stcjgR7RQdhh1Os=
X-Gm-Gg: AZuq6aI6zokR6aCQ5dCBRk+fAqBD1WuibiBwDMa5++jrg0IcpMyKqfDwW6/b9TXi3Te
	b83VhQ53B4/ItRhfajWJaw73stWsWsi2brmNbydjFlklP3BhysVTariRBiX/CzFOccAllC4MojR
	yeUiwMLxDS1Vy1VWIHRY/YvadCoQrWpn+fVv2ytcC4kUdBOq8Kg+HCnvxhcilPEHbj+i8Z7fFvi
	PIJuC5WhbCZoDCMoKM8P7Y=
X-Received: by 2002:a05:6102:3f43:b0:5ef:6550:e9f0 with SMTP id ada2fe7eead31-5fe7fd1a657mr612147137.36.1771407744205;
        Wed, 18 Feb 2026 01:42:24 -0800 (PST)
X-Received: by 2002:a05:6102:3f43:b0:5ef:6550:e9f0 with SMTP id
 ada2fe7eead31-5fe7fd1a657mr612137137.36.1771407743627; Wed, 18 Feb 2026
 01:42:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6f899da1123ab08df9a29abce69bc951d2e42939.camel@ibm.com>
 <CAO8a2SgfAoQb+4HvLBU_Yxjqs697pp27+N_kfcNO11rYmZ+z0g@mail.gmail.com> <dcdce6aa213eef5a933da5b1999e854c8fd1f8c0.camel@ibm.com>
In-Reply-To: <dcdce6aa213eef5a933da5b1999e854c8fd1f8c0.camel@ibm.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Wed, 18 Feb 2026 11:42:11 +0200
X-Gm-Features: AaiRm50uDfIdk2zzWbls47bJgkpQw2jfzI19Nl2rgVjCyPjaupUVcYgXQWUaM3o
Message-ID: <CAO8a2ShQSguooTnfjupiF3BO5dmbBVK-+F4wRxGzsHBbfuMqrQ@mail.gmail.com>
Subject: Re: Potential regression in 6.19 kernel version
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, 
	Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, this sure looks like a regression

On Tue, Feb 17, 2026 at 10:05=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Mon, 2026-02-16 at 22:46 +0200, Alex Markuze wrote:
> > Some tree wide API changes were introduced for 6.19.
> > I will try to reproduce and git bisect the issue, tomorrow.
> >
>
> I've compiled 6.19.0-rc8+ Linux kernel. And I've used this script:
>
> #!/bin/bash
>
> while true; do
>   sudo ./check generic/013
> done
>
> First of all, I had this after several iterations:
>
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.346895] INFO: task fsstress:1446=
6
> blocked for more than 122 seconds.
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.347995]       Not tainted 6.19.0=
-rc8+
> #10
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.348530] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349426] task:fsstress        sta=
te:D
> stack:0     pid:14466 tgid:14466 ppid:14464  task
> _flags:0x400140 flags:0x00080800
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349438] Call Trace:
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349441]  <TASK>
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349445]  __schedule+0xe8a/0x57f0
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349457]  ? kasan_save_stack+0x39=
/0x60
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349466]  ? kasan_save_stack+0x26=
/0x60
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349471]  ? kasan_save_track+0x14=
/0x40
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349475]  ?
> kasan_save_free_info+0x3b/0x60
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349485]  ? __kasan_slab_free+0x7=
a/0xb0
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349489]  ?
> ceph_mdsc_release_request+0x6a3/0x880
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349497]  ?
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349502]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349507]  ?
> __pv_queued_spin_lock_slowpath+0xb04/0xf80
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349514]  ? __pfx___schedule+0x10=
/0x10
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349520]  ? __kasan_check_read+0x=
11/0x20
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349525]  ?
> __call_rcu_common+0x386/0x14b0
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349532]  schedule+0x75/0x2f0
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349538]  schedule_timeout+0x16d/=
0x210
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349542]  ?
> __pfx_schedule_timeout+0x10/0x10
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349548]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349553]  ?
> _raw_spin_lock_irq+0x8b/0x100
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349559]  ?
> __pfx__raw_spin_lock_irq+0x10/0x10
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349565]  ? kasan_save_track+0x14=
/0x40
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349569]
> wait_for_completion+0x14a/0x340
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349573]  ?
> __pfx_wait_for_completion+0x10/0x10
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349577]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349582]  ? __pfx_mutex_unlock+0x=
10/0x10
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349587]  ceph_mdsc_sync+0x4b4/0x=
e80
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349593]  ?
> __pfx_ceph_mdsc_sync+0x10/0x10
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349597]  ?
> ceph_osdc_put_request+0x38/0x770
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349603]  ? ceph_osdc_sync+0x1cb/=
0x350
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349608]  ceph_sync_fs+0xa0/0x4c0
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349612]  sync_filesystem+0x182/0=
x240
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349618]  __x64_sys_syncfs+0xac/0=
x160
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349623]  x64_sys_call+0x746/0x23=
60
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349629]  do_syscall_64+0x82/0x5d=
0
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349635]  ? __x64_sys_openat+0x10=
8/0x240
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349641]  ? __kasan_check_read+0x=
11/0x20
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349647]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349655]  ?
> __pfx___x64_sys_openat+0x10/0x10
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349661]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349667]  ? ksys_write+0x1a3/0x23=
0
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349672]  ? __kasan_check_read+0x=
11/0x20
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349677]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349682]  ? do_syscall_64+0xbf/0x=
5d0
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349687]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349692]  ? __kasan_check_read+0x=
11/0x20
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349705]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349709]  ? do_syscall_64+0xbf/0x=
5d0
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349715]  ? __kasan_check_read+0x=
11/0x20
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349720]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349724]  ? irqentry_exit+0xa5/0x=
600
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349730]  ? exc_page_fault+0x95/0=
x100
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349736]
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349740] RIP: 0033:0x792fb1d1ba4b
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349745] RSP: 002b:00007ffc3844eb=
58
> EFLAGS: 00000246 ORIG_RAX: 0000000000000132
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349752] RAX: ffffffffffffffda RB=
X:
> 0000000000000000 RCX: 0000792fb1d1ba4b
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349756] RDX: 0000000000000000 RS=
I:
> 000059045610b440 RDI: 0000000000000004
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349759] RBP: 0000000000000004 R0=
8:
> 0000000000000026 R09: 00007ffc3844e986
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349762] R10: 0000000000000000 R1=
1:
> 0000000000000246 R12: 0000000000000149
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349765] R13: 00007ffc3844eba0 R1=
4:
> 000059042de9d0b3 R15: 0000000000000149
> Feb 16 15:46:30 ceph-0005 kernel: [ 1845.349771]  </TASK>
>
> And this message was emitted multiple times. Then, I had another issue:
>
> Feb 16 20:18:40 ceph-0005 kernel: [18175.057146] usercopy: Kernel memory
> exposure attempt detected from SLUB object 'kmalloc-rn
> d-06-4k' (offset 4370, size 4096)!
> Feb 16 20:18:40 ceph-0005 kernel: [18175.061760] ------------[ cut here ]=
-------
> -----
> Feb 16 20:18:40 ceph-0005 kernel: [18175.061768] kernel BUG at
> mm/usercopy.c:102!
> Feb 16 20:18:40 ceph-0005 kernel: [18175.063545] Oops: invalid opcode: 00=
00 [#1]
> SMP KASAN NOPTI
> Feb 16 20:18:40 ceph-0005 kernel: [18175.065108] CPU: 0 UID: 0 PID: 15297=
6 Comm:
> fsstress Not tainted 6.19.0-rc8+ #10 PREEMPT(v
> oluntary)
> Feb 16 20:18:40 ceph-0005 kernel: [18175.067805] Hardware name: QEMU Stan=
dard PC
> (i440FX + PIIX, 1996), BIOS 1.17.0-9.fc43 06/1
> 0/2025
> Feb 16 20:18:40 ceph-0005 kernel: [18175.069611] RIP:
> 0010:usercopy_abort+0x7a/0x7c
> Feb 16 20:18:40 ceph-0005 kernel: [18175.070552] Code: 48 c7 c6 c0 03 7c =
87 eb
> 0e 48 c7 c7 00 04 7c 87 48 c7 c6 40 04 7c 87 52
> 48 89 fa 48 c7 c7 80 04 7c 87 50 41 52 e8 46 e1 fb ff <0f> 0b e8 2f 12 ef=
 00 4d
> 89 e0 31 c9 44 89 f2 48 c7 c6 00 06 7c 87
> Feb 16 20:18:40 ceph-0005 kernel: [18175.074536] RSP: 0018:ffff888110d870=
70
> EFLAGS: 00010246
> Feb 16 20:18:40 ceph-0005 kernel: [18175.076072] RAX: 0000000000000070 RB=
X:
> ffff8881205cb112 RCX: 0000000000000000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.076790] RDX: 0000000000000000 RS=
I:
> 0000000000000000 RDI: 0000000000000000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.077445] RBP: ffff888110d87088 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.077935] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: 0000000000001000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.078397] R13: ffff8881205cc112 R1=
4:
> 0000000000000001 R15: 000000000014e000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.078874] FS:  000076e062f93740(00=
00)
> GS:ffff88826cb7d000(0000) knlGS:0000000000000000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.079406] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Feb 16 20:18:40 ceph-0005 kernel: [18175.079777] CR2: 000076e0627ff000 CR=
3:
> 00000001076ab006 CR4: 0000000000772ef0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.080258] PKRU: 55555554
> Feb 16 20:18:40 ceph-0005 kernel: [18175.080445] Call Trace:
> Feb 16 20:18:40 ceph-0005 kernel: [18175.080617]  <TASK>
> Feb 16 20:18:40 ceph-0005 kernel: [18175.080765]  __check_heap_object+0xf=
1/0x130
> Feb 16 20:18:40 ceph-0005 kernel: [18175.080966]  ?
> ceph_mdsc_wait_request+0x15b/0x590
> Feb 16 20:18:40 ceph-0005 kernel: [18175.081176]  ? ktime_get+0x63/0x170
> Feb 16 20:18:40 ceph-0005 kernel: [18175.081340]
> __check_object_size+0x401/0x700
> Feb 16 20:18:40 ceph-0005 kernel: [18175.081531]  ?
> ceph_mdsc_do_request+0x1f0/0x270
> Feb 16 20:18:40 ceph-0005 kernel: [18175.081729]
> ceph_netfs_issue_read+0x790/0x2060
> Feb 16 20:18:40 ceph-0005 kernel: [18175.082019]  ? mempool_alloc_slab+0x=
40/0x70
> Feb 16 20:18:40 ceph-0005 kernel: [18175.082247]  ?
> __pfx_ceph_netfs_issue_read+0x10/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.082525]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 20:18:40 ceph-0005 kernel: [18175.082759]  ? _raw_spin_lock+0x82/0=
xf0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.082994]  ?
> __pfx__raw_spin_lock+0x10/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.083228]
> netfs_read_to_pagecache+0x3d3/0xf70
> Feb 16 20:18:40 ceph-0005 kernel: [18175.083480]  ?
> netfs_read_to_pagecache+0x3d3/0xf70
> Feb 16 20:18:40 ceph-0005 kernel: [18175.083738]  netfs_write_begin+0x551=
/0xf10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.083969]  ?
> ceph_get_xattr_handler+0x39/0x60
> Feb 16 20:18:40 ceph-0005 kernel: [18175.084211]  ?
> __pfx_netfs_write_begin+0x10/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.084461]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 20:18:40 ceph-0005 kernel: [18175.084697]  ? _raw_spin_lock+0x82/0=
xf0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.084925]  ceph_write_begin+0x8c/0=
x1c0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.085137]
> generic_perform_write+0x37f/0x8e0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.085377]  ?
> __pfx_generic_perform_write+0x10/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.085639]  ?
> generic_update_time+0x88/0xd0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.085885]  ?
> file_update_time_flags+0x278/0x4e0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.086132]  ? ceph_get_caps+0x63/0x=
f0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.086340]  ceph_write_iter+0xe79/0=
x1ae0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.086560]  ?
> __pfx_ceph_write_iter+0x10/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.086798]  ? kasan_save_track+0x14=
/0x40
> Feb 16 20:18:40 ceph-0005 kernel: [18175.087021]  ?
> kasan_save_alloc_info+0x39/0x60
> Feb 16 20:18:40 ceph-0005 kernel: [18175.087262]  ? __kasan_kmalloc+0xa9/=
0xd0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.087473]
> do_iter_readv_writev+0x40a/0xbb0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.087706]  ?
> __pfx_common_file_perm+0x10/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.087965]  ? iovec_from_user+0xd1/=
0x110
> Feb 16 20:18:40 ceph-0005 kernel: [18175.088185]  ?
> __pfx_do_iter_readv_writev+0x10/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.088447]  ?
> security_file_permission+0x53/0x150
> Feb 16 20:18:40 ceph-0005 kernel: [18175.088707]  ? rw_verify_area+0x70/0=
x4a0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.088941]  vfs_writev+0x28a/0xa90
> Feb 16 20:18:40 ceph-0005 kernel: [18175.089132]  ? __pfx_vfs_writev+0x10=
/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.089350]  ?
> stack_depot_save_flags+0x28/0x8d0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.089598]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 20:18:40 ceph-0005 kernel: [18175.089840]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 20:18:40 ceph-0005 kernel: [18175.090070]  ? _raw_spin_lock+0x82/0=
xf0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.090277]  ?
> __pfx__raw_spin_lock+0x10/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.090513]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 20:18:40 ceph-0005 kernel: [18175.090744]  ? mutex_lock+0x84/0xe0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.090954]  ? __pfx_mutex_lock+0x10=
/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.091167]  ? _raw_spin_unlock+0xe/=
0x40
> Feb 16 20:18:40 ceph-0005 kernel: [18175.091377]  ? __touch_cap+0x106/0x6=
00
> Feb 16 20:18:40 ceph-0005 kernel: [18175.091581]  do_writev+0x121/0x310
> Feb 16 20:18:40 ceph-0005 kernel: [18175.091766]  ? do_writev+0x121/0x310
> Feb 16 20:18:40 ceph-0005 kernel: [18175.091978]  ? __pfx_do_writev+0x10/=
0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.092188]  ? __kasan_check_read+0x=
11/0x20
> Feb 16 20:18:40 ceph-0005 kernel: [18175.092411]  ? _copy_to_user+0x38/0x=
70
> Feb 16 20:18:40 ceph-0005 kernel: [18175.092616]  ? cp_new_stat+0x46e/0x5=
b0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.092831]  __x64_sys_writev+0x75/0=
xd0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.093032]  x64_sys_call+0x219a/0x2=
360
> Feb 16 20:18:40 ceph-0005 kernel: [18175.093237]  do_syscall_64+0x82/0x5d=
0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.093434]  ? fput+0x27/0xa0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.093593]  ? vfs_fstat+0x94/0xb0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.093776]  ?__do_sys_newfstatat+0x=
89/0xd0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.094032]  ?
> __pfx___do_sys_newfstatat+0x10/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.094286]  ? call_rcu+0x31/0x50
> Feb 16 20:18:40 ceph-0005 kernel: [18175.094468]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 20:18:40 ceph-0005 kernel: [18175.094691]  ? mutex_lock+0x84/0xe0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.094907]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 20:18:40 ceph-0005 kernel: [18175.095132]  ? mutex_unlock+0x83/0xe=
0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.095331]  ? __pfx_mutex_unlock+0x=
10/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.095549]  ?
> generic_file_llseek+0xc1/0x1b0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.095781]  ?
> __kasan_check_write+0x14/0x30
> Feb 16 20:18:40 ceph-0005 kernel: [18175.096026]  ? fput+0x27/0xa0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.096190]  ? ksys_lseek+0x104/0x1b=
0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.096389]  ?
> __pfx_fput_close_sync+0x10/0x10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.096627]  ? __kasan_check_read+0x=
11/0x20
> Feb 16 20:18:40 ceph-0005 kernel: [18175.096868]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Feb 16 20:18:40 ceph-0005 kernel: [18175.097158]  ? do_syscall_64+0xbf/0x=
5d0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.097363]  ? __kasan_check_read+0x=
11/0x20
> Feb 16 20:18:40 ceph-0005 kernel: [18175.097583]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Feb 16 20:18:40 ceph-0005 kernel: [18175.097876]  ? do_syscall_64+0xbf/0x=
5d0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.098078]  ? exc_page_fault+0x95/0=
x100
> Feb 16 20:18:40 ceph-0005 kernel: [18175.098291]
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Feb 16 20:18:40 ceph-0005 kernel: [18175.098557] RIP: 0033:0x76e062d1aad7
> Feb 16 20:18:40 ceph-0005 kernel: [18175.098753] Code: 0f 00 f7 d8 64 89 =
02 48
> c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c=
0 75 10
> b8 14 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c=
 48 89
> 74 24 10
> Feb 16 20:18:40 ceph-0005 kernel: [18175.099722] RSP: 002b:00007ffedc4cd0=
88
> EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> Feb 16 20:18:40 ceph-0005 kernel: [18175.100486] RAX: ffffffffffffffda RB=
X:
> 0000000000000103 RCX: 000076e062d1aad7
> Feb 16 20:18:40 ceph-0005 kernel: [18175.101279] RDX: 000000000000019c RS=
I:
> 00005b1e21925050 RDI: 0000000000000004
> Feb 16 20:18:40 ceph-0005 kernel: [18175.102042] RBP: 0000000000000004 R0=
8:
> 00005b1e2190af00 R09: 00005b1e21925050
> Feb 16 20:18:40 ceph-0005 kernel: [18175.102842] R10: 0000000000000077 R1=
1:
> 0000000000000246 R12: 0000000000000103
> Feb 16 20:18:40 ceph-0005 kernel: [18175.103603] R13: 000000000000019c R1=
4:
> 00005b1e21925050 R15: 000000000001a146
> Feb 16 20:18:40 ceph-0005 kernel: [18175.104376]  </TASK>
> Feb 16 20:18:40 ceph-0005 kernel: [18175.104536] Modules linked in:
> intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_=
core
> pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vse=
c
> kvm_intel kvm joydev irqbypass ghash_clmulni_intel aesni_intel rapl flopp=
y
> input_leds vga16fb mac_hid psmouse vgastate i2c_piix4 bochs pata_acpi ser=
io_raw
> i2c_smbus qemu_fw_cfg sch_fq_codel rbd msr parport_pc ppdev lp parport
> efi_pstore
> Feb 16 20:18:40 ceph-0005 kernel: [18175.106483] ---[ end trace 000000000=
0000000
> ]---
> Feb 16 20:18:40 ceph-0005 kernel: [18175.106733] RIP:
> 0010:usercopy_abort+0x7a/0x7c
> Feb 16 20:18:40 ceph-0005 kernel: [18175.107408] Code: 48 c7 c6 c0 03 7c =
87 eb
> 0e 48 c7 c7 00 04 7c 87 48 c7 c6 40 04 7c 87 52 48 89 fa 48 c7 c7 80 04 7=
c 87 50
> 41 52 e8 46 e1 fb ff <0f> 0b e8 2f 12 ef 00 4d 89 e0 31 c9 44 89 f2 48 c7=
 c6 00
> 06 7c 87
> Feb 16 20:18:40 ceph-0005 kernel: [18175.109354] RSP: 0018:ffff888110d870=
70
> EFLAGS: 00010246
> Feb 16 20:18:40 ceph-0005 kernel: [18175.109920] RAX: 0000000000000070 RB=
X:
> ffff8881205cb112 RCX: 0000000000000000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.110547] RDX: 0000000000000000 RS=
I:
> 0000000000000000 RDI: 0000000000000000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.111103] RBP: ffff888110d87088 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.111533] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: 0000000000001000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.112004] R13: ffff8881205cc112 R1=
4:
> 0000000000000001 R15: 000000000014e000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.112387] FS:  000076e062f93740(00=
00)
> GS:ffff88826cb7d000(0000) knlGS:0000000000000000
> Feb 16 20:18:40 ceph-0005 kernel: [18175.112827] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Feb 16 20:18:40 ceph-0005 kernel: [18175.113200] CR2: 000076e0627ff000 CR=
3:
> 00000001076ab006 CR4: 0000000000772ef0
> Feb 16 20:18:40 ceph-0005 kernel: [18175.113603] PKRU: 55555554
>
> So, I don't think that we have fixes for these issues. Am I right here?
>
> I am going to create tickets for these two issues.
>
> Thanks,
> Slava.

