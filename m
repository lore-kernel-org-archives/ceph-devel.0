Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DC8F7D
	for <ceph-devel@vger.kernel.org>; Wed,  4 Feb 2026 21:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770241511; cv=pass; b=J8arEg/AVs66g5BFHurUcraW6mKFmMLiepWG1bYItxNGWZBaa6AzQzvnzpllQKwBf/jziUgzxmClNox9ICG65re3lVi/KlU26npMKDqBnRxH2PxID0lsB/icFxXLp5xFKuUfkM0bI3+VPc9X3xlNGdd2I6OYRkZpOpfnQAMaD0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770241511; c=relaxed/simple;
	bh=+t/GVqutPYxd7nOynLan7phgzVMjY6YuI8gcD7yruGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urWBVbCSjhOOogMDJFVDy6+dSb0y5kcdKuy11yQoj4kCeXL4GLs+hPRtUzO2Mlmvmr7ikVVYI6sU0ej0atQ6ZO1gp4bf68lJyD5z7w6j8yVoPnB+UA2PiJcOQdqqMTE+Dk+0WdmHlIkCplHFzurKiP7gsxXzM8ck6khy+hatSWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2v0kiH/; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2v0kiH/"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11f1fb91996so726430c88.1
        for <ceph-devel@vger.kernel.org>; Wed, 04 Feb 2026 13:45:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770241511; cv=none;
        d=google.com; s=arc-20240605;
        b=hEXjBJMyB4uWfJcVaxwXvnl0qQ+NQ5iI8CeICispiynVAswJ/UnZ79UbK25y5BrFhR
         DdPjlR0SNH8piwt1LGkGEjwAPUBjKpAuHz2iSMSLebiy9431xA2Vprl/X5Z1ysfNhEQo
         Q5+dKd3AyHn7PU0e8eBrUDfD3/Kd42/6yU4j47iw9v2+D/Htdyl3OIiqk+YFch0i3TjU
         8ls6r6AH+A90jAGsrndQGi7fUuiQadjjuoIaW/f94v8v8VSYd7uCh0ou3pIre+p1b25B
         PYEdchy+RyxoKUXSAqvWmxdY7X0yIrHdJNxrcY2oebcAOiibXDDZm0nmdPzkUWIEN0fA
         QYTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0OzuH58i35Uu0rViku5KQeKlrMCb/yJIWAVI6ao+pmo=;
        fh=X4Kv9zVXNL0kYZwnzI1rGY3gjOGAhevgZaJ7j1+L5Wg=;
        b=auBlzl9/TjSt5Q3whSLUP5buQK33fPamtzMS+RIPjXWSdj9Ccp6KZnoEh6/TMhJJG7
         c/2zoiI7T1R8NnvyF3CVj3KA6H01RHFhDHhzF942okM+xlzwbtkyVcKjpMl3o4QerEF5
         2Bp/kns7oaoJOpre1lJaSVb+O4SOLnEJgr/NnPZrp7sVfAbdjIHTF7Sy7cLz4Py1sONA
         rjzGcdM4hIGFbnSNsrhvrviL2megUgQhUVcJk4Pt7ERtLsMLKwJW0xNhRK6PnAD/BTdY
         R3xPYkZc58ymye4j3RcvY67CMQQFPPxqvFY9AxuWNnHcTrwEoLBklzerQg/1yJCoPBCN
         UKbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770241510; x=1770846310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OzuH58i35Uu0rViku5KQeKlrMCb/yJIWAVI6ao+pmo=;
        b=L2v0kiH/ddmiJsK/7cN4B2q/CovP1OMVcICdt76d2KCuGUxdsLDzc+0Troy1DSIg5c
         +OOheb6zmnbEDlXjVLDkZrSyzTbwcr08D2tcAqsvU1rXVuezSq/ZysbPjpqtZr2cpjDH
         HWKqHrpBiKvbFqFBTiKL44AMWH4Jk82EoxzBzOP38nS6QCxPUQI4t/cRv5C9MVcILgQ4
         +l1z5KapBED1Qld35WCcePlXQG52/tZqcsXhIJcLnGVJu6bgj9cRLKoI4M62TGSNo5DE
         Vf1SaJKyQQCAOo61gRg/qbSkiD7tXZ0qPP1FwuB/PH7GHJcg108USlWPh/PhzXA4Qkhn
         SHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770241510; x=1770846310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0OzuH58i35Uu0rViku5KQeKlrMCb/yJIWAVI6ao+pmo=;
        b=j1ixTfIneW8N1Wx8YUtKLNZIvTwpYFPTvXe8JaAZlvTPcovTupzmR1bEpHRr2QoFhG
         4OZu2I7elL04MQVJ2JE37JN+Hp4Bg1O6sJlm435awxO309ZqrJvyRfeQmQeQyd8b+QWK
         VW5A2YDk0Dbw7HL8AaUgq+m4ZGgBMEMk6fN5+4lhEGGAu4+aIDDzzeg3qzRY9pRAbkK/
         RxRFx+abFIH5m4QttX+jiRT/7i9+ioJ9Ycb7X9k5W/lfEZbdu69qujJNRKO1uqYav6Dq
         4CgjJd1NXNYeMOF58qHpy8BAXd1YGelN8cjI/wtwSOPD6x9CankDBefEy0hoaQqPAFOA
         30uw==
X-Gm-Message-State: AOJu0YxMjKtCcPamoyHnuCmq1GqTZgU3+4bJCcIvecpp4VO/UTtdoDiS
	8RW7xGT3i2/aKYg5TPhjwBb/tiv3sAD6cfuFKbiOcGRC1PULBXBNgYxZmz8DdAGLW6BSVhT5ksI
	OJxpQ7crohvpSC1hle+2jL8hx49fWI+M=
X-Gm-Gg: AZuq6aI9pjePfcscFEED5r21Tf0cREEBB6pQLXQGQdJXQN9RcB3u6V2pHS5+Pf848fe
	TXBtNGKRa+Zj50tuc7rI/33vN1lCqmJ47M1dryAuwM4hU6ztFtBLac9p1U/14EwKW4Zrabs5LSP
	LzEPYwc4/c8uvS0caXOnerg1f0IRGTQN81Vkv9o5yQXXU9LwUiAi5RgnkZPojD5R9glYxDZjg19
	8oz2HPua643yNtUSzfGKEh3M6IkE2JTtmEUYoTJuPgdEfaD359TS9LcrG3baNOU5BoUdPA=
X-Received: by 2002:a05:7022:90f:b0:11b:bf3f:5251 with SMTP id
 a92af1059eb24-126f478d04emr1725520c88.16.1770241510464; Wed, 04 Feb 2026
 13:45:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204205158.1521777-2-slava@dubeyko.com>
In-Reply-To: <20260204205158.1521777-2-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 4 Feb 2026 22:44:58 +0100
X-Gm-Features: AZwV_QjxmGnKRNArKtQgtIBvTyAD2AqvFbxNI-g4ciAjdArDGjS3_V2a7qDxfLs
Message-ID: <CAOi1vP9P87rvKKU_=UOZ08EiaOjDsg2PieKU5K0pR8tzaN8jGQ@mail.gmail.com>
Subject: Re: [PATCH v7] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, pdonnell@redhat.com, 
	linux-fsdevel@vger.kernel.org, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com, khiremat@redhat.com, Pavan.Rallabhandi@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 4, 2026 at 9:52=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> The CephFS kernel client has regression starting from 6.18-rc1.
>
> sudo ./check -g quick
> FSTYP         -- ceph
> PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYNAM=
IC Fri
> Nov 14 11:26:14 PST 2025
> MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> MOUNT_OPTIONS -- -o name=3Dadmin,ms_mode=3Dsecure 192.168.1.213:3300:/scr=
atch
> /mnt/cephfs/scratch
>
> Killed
>
> Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> (2)192.168.1.213:3300 session established
> Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
> Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL pointer
> dereference, address: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read acc=
ess in
> kernel mode
> Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000) =
- not-
> present page
> Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] SM=
P KASAN
> NOPTI
> Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 3453 =
Comm:
> xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU Stan=
dard PC
> (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/0x=
40
> Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 90 =
90 90
> 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c=
0 01 84
> d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3=
 cc cc
> cc cc 31
> Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff8881536875=
c0
> EFLAGS: 00010246
> Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 RB=
X:
> ffff888116003200 RCX: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 RS=
I:
> 0000000000000000 RDI: ffff88810126c900
> Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: dffffc0000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 R1=
4:
> 0000000000000000 R15: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(00=
00)
> GS:ffff8882401a4000(0000) knlGS:0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 CR=
3:
> 0000000110ebd001 CR4: 0000000000772ef0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> ceph_mds_check_access+0x348/0x1760
> Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> __kasan_check_write+0x14/0x30
> Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x17=
0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> __pfx__raw_spin_lock+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x10/=
0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> __pfx_apparmor_file_open+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> __ceph_caps_issued_mask_metric+0xd6/0x180
> Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/0x=
10e0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x10/=
0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
> Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x50=
a0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0x1=
0/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> __pfx_stack_trace_save+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> stack_depot_save_flags+0x28/0x8f0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0xe/=
0x20
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x45=
0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> __pfx__raw_spin_lock_irqsave+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+0x=
10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d/0=
x2b0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> __pfx__raw_spin_lock+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> __check_object_size+0x453/0x600
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0xe/=
0x40
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0x1=
80
> Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> __pfx_do_sys_openat2+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x108/=
0x240
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> __pfx___x64_sys_openat+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> __pfx___handle_mm_fault+0x10/0x10
> Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0x2=
350
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0xd5=
0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/0x=
d50
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+0x=
11/0x20
> Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> count_memcg_events+0x25b/0x400
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x38b=
/0x6a0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+0x=
11/0x20
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> fpregs_assert_state_consistent+0x5c/0x100
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> irqentry_exit_to_user_mode+0x2e/0x2a0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/0x=
50
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95/0=
x100
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> entry_SYSCALL_64_after_hwframe+0x76/0x7e
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145ab
> Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3d =
00 00
> 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c f=
f ff ff
> b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28=
 64 48
> 2b 14 25
> Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d316=
d0
> EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda RB=
X:
> 0000000000000002 RCX: 000074a85bf145ab
> Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 RS=
I:
> 00007ffc77d32789 RDI: 00000000ffffff9c
> Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 R0=
8:
> 00007ffc77d31980 R09: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 R1=
1:
> 0000000000000246 R12: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff R1=
4:
> 0000000000000180 R15: 0000000000000001
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_=
core
> pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vse=
c
> kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesni_=
intel
> rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgasta=
te
> serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc ppd=
ev lp
> parport efi_pstore
> Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 000000000=
0000000
> ]---
> Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/0x=
40
> Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 90 =
90 90
> 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c=
0 01 84
> d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3=
 cc cc
> cc cc 31
> Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff8881536875=
c0
> EFLAGS: 00010246
> Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 RB=
X:
> ffff888116003200 RCX: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 RS=
I:
> 0000000000000000 RDI: ffff88810126c900
> Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 R0=
8:
> 0000000000000000 R09: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 R1=
1:
> 0000000000000000 R12: dffffc0000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 R1=
4:
> 0000000000000000 R15: 0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(00=
00)
> GS:ffff8882401a4000(0000) knlGS:0000000000000000
> Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES: 0=
000
> CR0: 0000000080050033
> Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 CR=
3:
> 0000000110ebd001 CR4: 0000000000772ef0
> Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
>
> We have issue here [1] if fs_name =3D=3D NULL:
>
> const char fs_name =3D mdsc->fsc->mount_options->mds_namespace;
>     ...
>     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
>             / fsname mismatch, try next one */
>             return 0;
>     }
>
> v2
> Patrick Donnelly suggested that: In summary, we should definitely start
> decoding `fs_name` from the MDSMap and do strict authorizations checks
> against it. Note that the `--mds_namespace` should only be used for
> selecting the file system to mount and nothing else. It's possible
> no mds_namespace is specified but the kernel will mount the only
> file system that exists which may have name "foo".
>
> v3
> The namespace_equals() logic has been generalized into
> __namespace_equals() with the goal of using it in
> ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
>
> v4
> The __namespace_equals() now supports wildcard check.
>
> v5
> Patrick Donnelly suggested to add the sanity check of
> kstrdup() returned pointer in ceph_mdsmap_decode()
> added logic. Also, he suggested much simpler logic of
> namespace strings comparison in the form of
> ceph_namespace_match() logic.
>
> v6
> Only ceph_namespace_match() compares the names
> with CEPH_NAMESPACE_WILDCARD.
>
> v7
> Ilya Dryomov suggested cleanup in ceph_mdsmap_decode(),
> ceph_namespace_match(), and rollback the logic of
> namespace_equals().
>
> This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> the goal of supporting the suggested concept. Now struct ceph_mdsmap
> contains m_fs_name field that receives copy of extracted FS name
> by ceph_extract_encoded_string(). For the case of "old" CephFS file syste=
ms,
> it is used "cephfs" name. Also, namespace_equals() method has been
> reworked with the goal of proper names comparison.
>
> [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_client.=
c#L5666
> [2] https://tracker.ceph.com/issues/73886
>
> Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Patrick Donnelly <pdonnell@redhat.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  fs/ceph/mds_client.c         | 11 +++++------
>  fs/ceph/mdsmap.c             | 26 +++++++++++++++++++-------
>  fs/ceph/mdsmap.h             |  1 +
>  fs/ceph/super.h              | 16 ++++++++++++++--
>  include/linux/ceph/ceph_fs.h |  6 ++++++
>  5 files changed, 45 insertions(+), 15 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 7e4eab824dae..a4b9254b74a5 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_clie=
nt *mdsc,
>         u32 caller_uid =3D from_kuid(&init_user_ns, cred->fsuid);
>         u32 caller_gid =3D from_kgid(&init_user_ns, cred->fsgid);
>         struct ceph_client *cl =3D mdsc->fsc->client;
> -       const char *fs_name =3D mdsc->fsc->mount_options->mds_namespace;
> +       const char *fs_name =3D mdsc->mdsmap->m_fs_name;
>         const char *spath =3D mdsc->fsc->mount_options->server_path;
>         bool gid_matched =3D false;
>         u32 gid, tlen, len;
> @@ -5679,7 +5679,8 @@ static int ceph_mds_auth_match(struct ceph_mds_clie=
nt *mdsc,
>
>         doutc(cl, "fsname check fs_name=3D%s  match.fs_name=3D%s\n",
>               fs_name, auth->match.fs_name ? auth->match.fs_name : "");
> -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) =
{
> +
> +       if (!ceph_namespace_match(auth->match.fs_name, fs_name)) {
>                 /* fsname mismatch, try next one */
>                 return 0;
>         }
> @@ -6122,7 +6123,6 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client =
*mdsc, struct ceph_msg *msg)
>  {
>         struct ceph_fs_client *fsc =3D mdsc->fsc;
>         struct ceph_client *cl =3D fsc->client;
> -       const char *mds_namespace =3D fsc->mount_options->mds_namespace;
>         void *p =3D msg->front.iov_base;
>         void *end =3D p + msg->front.iov_len;
>         u32 epoch;
> @@ -6157,9 +6157,8 @@ void ceph_mdsc_handle_fsmap(struct ceph_mds_client =
*mdsc, struct ceph_msg *msg)
>                 namelen =3D ceph_decode_32(&info_p);
>                 ceph_decode_need(&info_p, info_end, namelen, bad);
>
> -               if (mds_namespace &&
> -                   strlen(mds_namespace) =3D=3D namelen &&
> -                   !strncmp(mds_namespace, (char *)info_p, namelen)) {
> +               if (namespace_equals(fsc->mount_options,
> +                                    (char *)info_p, namelen)) {

Hi Slava,

This transformation isn't related to the fix (the fix is confined to
ceph_mds_auth_match() and decoding mdsmap->m_fs_name as a dependency)
and is incorrect.  You have effectively replaced

    if (mds_namespace &&
        strlen(mds_namespace) =3D=3D namelen &&
        !strncmp(mds_namespace, (char *)info_p, namelen)) {

with

    if (!mds_namespace ||
        (strlen(mds_namespace) =3D=3D namelen &&
        !strncmp(mds_namespace, (char *)info_p, namelen))) {

That is

    if (mds_namespace && <mds_namespace string equality check>)

with

    if (!mds_namespace || <mds_namespace string equality check>) {

which isn't an equivalent substitution.  The loop in question is
searching for an fscid which corresponds to a given mds_namespace.
If no mds_namespace is given, the existing code finds nothing and
ENOENT is returned -- quite naturally.  This change makes it land
on the first fscid that is encountered and return success/found...

I have already applied the patch with this bit reverted.

Thanks,

                Ilya
