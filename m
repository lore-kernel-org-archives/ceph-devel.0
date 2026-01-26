Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77126B755
	for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769461410; cv=none; b=T4r8f7FA5WEuui8nJiNo4mBZZdGax+QSlUcygUuByN95Xu4XiINbqVn/rbnEp5NBWRi1zoDWJJCiduMkNr1dwrufWbGp6YG0YVP2icavJUXaLQF9xCavE63JRIXiWewTeGQjASDUOHQY0JoKljcmAdmqgNHwa7J74rY9+QSgZHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769461410; c=relaxed/simple;
	bh=6Vuo+/WWgw6D7+YTy8t1gKRCIqKv02pGmqfSCpDxKjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO3LO40uMTwPUElahh/q0OY90WtfmBZxFVahth+AKVx1fs8aAvecPsnM2fGpCUhnr/vO0ZJls3VHwn2Vag26Fcb7mhqJ/co72x50QCiRghgKujfF/X520ifTgeyYwKk6kY2gZSjnuX979Ski5/xBqInHhqil1MZrAPHrCutGDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrHEViwJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrHEViwJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48049955f7fso42554065e9.0
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jan 2026 13:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769461406; x=1770066206; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ZbA1TCeSebZcAGci/xc0bq+Ttgq9beeBxy8eztDU8w=;
        b=LrHEViwJ4k2HXqc59hVbjc7bk+t42Usbl1aSUjFO3dJ834TLrhxN4fFsB/vw4jPb8G
         0lfvC1an9PcX9p8Sf+wYBsxviiCy1KtOzUJG3+y1BJayJF0KL3t+/g5wS/jNQ4fwNtqV
         8UVTWrYxG1z/32pnEOsP0wWPq71jbI2JzwdORoF1AkjqT6hxNXNpR57KaKQa20zU/r9P
         YHpzL05tLHH+r+E9Jpg5gR69FzRT4vzwsGVnVFwjYIky8Rju8KlUaq0aqtl1JCxXhLq3
         /DqHHyOsbzS0jZgxzFftYEIlOIkitIH2HpnQpF42JOP9f7aEEnlnWNV4+xBkoUVrWH2c
         3CMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769461406; x=1770066206;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZbA1TCeSebZcAGci/xc0bq+Ttgq9beeBxy8eztDU8w=;
        b=pBUo2F4nWGj46eUGkG0921KUmyaE9sKKpYoI1Aqh5tvWavaeIg571GgKT6nCR+Wpfx
         jUvIeMEXIWhw8ffiikegoi7WzdLTCCqzbaXG3Ul+IswgWw0uDL95W+PUUf8wgDvNo3uY
         OnH7pEZant+Hse+SfiixC0jd0hG/HvfxK/0MAV2yzg9dJG223w1k5V8kLoAnAIpILpNv
         /txUEZsyDtwUcjuI4rZvnDOcWKf/XLj1upT5SL2szG5EMtQJFf03QTRx18HLFDjl86mH
         QzU7+d7zlfDVf0NOWyGqlCIfH+i5ce1ZJHkqZrtHk22w3DuOcoTenY+Mj8gUpK6+ke1L
         gtjw==
X-Forwarded-Encrypted: i=1; AJvYcCUgr6cTLlQMpD3vMPFPBjqP5AdoKLwEhI4xo7eMX4+FuWbj5ZOUPz+Zm8icl+YhPfW4SaZL0L8ANIhW@vger.kernel.org
X-Gm-Message-State: AOJu0YxFsvQ3AbuGAohlqT8aJkltaW3/8f5In+Z/7yfnqXMCKr/yAW64
	nct7ypXyhmApRQq6Wv0tAdP6klwJLbzomjU/bRq5C/5xn3gsIvPokPjt
X-Gm-Gg: AZuq6aLNGKKm+loYbvDJs6UjD5CDW2vTnsDxa1mYb7CbYdXNttB/hiGVrN8IzxIu3FE
	AzeQYVZ7PEiLp6QKs1l/g4WUZ0SQaXMKWyoHouqtrX7KZGd+mjVN8J1j98DgpxT18eVNGbwbR49
	J+XrcLKDHwIjFAqY6uygx2znSO8Wf2ZcvSgVrPcUFn4adhmyQyjPjPE0AKRpdky8ZKVLmV0KvpH
	eqy7tBqL3L5n64+lIPs1T6Vrhvt8pJcl2aOkSF/KZ5E9DuE5+cxJH9tAXVNbxClWcDddJsoQCi0
	WP5ahzWdDShEgIt7nJaVR1M2QQU66GF4yI4JnQLKPsP0ZCDtUI8vAhkxtVkM9bwnf7Vn8TjOlWw
	5oEyD2WQ1YmaSpD83nalMNPezHgTOLwC88lxfU/eshYyP509/P8HLFt+m9u8twCynmnwar4VhvU
	Gn4ij9zWYwiLMKFwnXTQWrlJifHH9keVffbNycOrvspg59
X-Received: by 2002:a05:6000:1446:b0:431:656:c726 with SMTP id ffacd0b85a97d-435ca124817mr8247020f8f.3.1769461405127;
        Mon, 26 Jan 2026 13:03:25 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e7156dsm33430252f8f.20.2026.01.26.13.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 13:03:23 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id BF1ECBE2EE7; Mon, 26 Jan 2026 22:03:22 +0100 (CET)
Date: Mon, 26 Jan 2026 22:03:22 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Viacheslav Dubeyko <vdubeyko@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org,
	pdonnell@redhat.com, linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com, khiremat@redhat.com, Pavan.Rallabhandi@ibm.com,
	1125405@bugs.debian.org,
	Reinhard Eilmsteiner <reinhard.eilmsteiner@eilm.at>
Subject: Re: [PATCH v5] ceph: fix kernel crash in ceph_open()
Message-ID: <aXfWmlvvy03c7kja@eldamar.lan>
References: <20260114195524.1025067-2-slava@dubeyko.com>
 <CAOi1vP8CwX5T_R4gdZ0egg2oxCwFGAvoi6Us2k4=QFKmtqHmjQ@mail.gmail.com>
 <3e4c420c7dd63ac3ecd0c9c21aea4f75784eada4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e4c420c7dd63ac3ecd0c9c21aea4f75784eada4.camel@redhat.com>

Hi,

On Mon, Jan 26, 2026 at 12:18:29PM -0800, Viacheslav Dubeyko wrote:
> On Mon, 2026-01-26 at 13:35 +0100, Ilya Dryomov wrote:
> > On Wed, Jan 14, 2026 at 8:56 PM Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> > > 
> > > From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > 
> > > The CephFS kernel client has regression starting from 6.18-rc1.
> > > 
> > > sudo ./check -g quick
> > > FSTYP         -- ceph
> > > PLATFORM      -- Linux/x86_64 ceph-0005 6.18.0-rc5+ #52 SMP PREEMPT_DYNAMIC Fri
> > > Nov 14 11:26:14 PST 2025
> > > MKFS_OPTIONS  -- 192.168.1.213:3300:/scratch
> > > MOUNT_OPTIONS -- -o name=admin,ms_mode=secure 192.168.1.213:3300:/scratch
> > > /mnt/cephfs/scratch
> > > 
> > > Killed
> > > 
> > > Nov 14 11:48:10 ceph-0005 kernel: [  154.723902] libceph: mon0
> > > (2)192.168.1.213:3300 session established
> > > Nov 14 11:48:10 ceph-0005 kernel: [  154.727225] libceph: client167616
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087260] BUG: kernel NULL pointer
> > > dereference, address: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.087756] #PF: supervisor read access in
> > > kernel mode
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088043] #PF: error_code(0x0000) - not-
> > > present page
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088302] PGD 0 P4D 0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.088688] Oops: Oops: 0000 [#1] SMP KASAN
> > > NOPTI
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.090080] CPU: 4 UID: 0 PID: 3453 Comm:
> > > xfs_io Not tainted 6.18.0-rc5+ #52 PREEMPT(voluntary)
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.091245] Hardware name: QEMU Standard PC
> > > (i440FX + PIIX, 1996), BIOS 1.17.0-5.fc42 04/01/2014
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092103] RIP: 0010:strcmp+0x1c/0x40
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.092493] Code: 90 90 90 90 90 90 90 90
> > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c0 01 84
> > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3 cc cc
> > > cc cc 31
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094057] RSP: 0018:ffff8881536875c0
> > > EFLAGS: 00010246
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.094522] RAX: 0000000000000000 RBX:
> > > ffff888116003200 RCX: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095114] RDX: 0000000000000063 RSI:
> > > 0000000000000000 RDI: ffff88810126c900
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.095714] RBP: ffff8881536876a8 R08:
> > > 0000000000000000 R09: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096297] R10: 0000000000000000 R11:
> > > 0000000000000000 R12: dffffc0000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.096889] R13: ffff8881061d0000 R14:
> > > 0000000000000000 R15: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.097490] FS:  000074a85c082840(0000)
> > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098146] CS:  0010 DS: 0000 ES: 0000
> > > CR0: 0000000080050033
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.098630] CR2: 0000000000000000 CR3:
> > > 0000000110ebd001 CR4: 0000000000772ef0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099219] PKRU: 55555554
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099476] Call Trace:
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099686]  <TASK>
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.099873]  ?
> > > ceph_mds_check_access+0x348/0x1760
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100267]  ?
> > > __kasan_check_write+0x14/0x30
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100671]  ? lockref_get+0xb1/0x170
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.100979]  ?
> > > __pfx__raw_spin_lock+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101372]  ceph_open+0x322/0xef0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101669]  ? __pfx_ceph_open+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.101996]  ?
> > > __pfx_apparmor_file_open+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102434]  ?
> > > __ceph_caps_issued_mask_metric+0xd6/0x180
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.102911]  do_dentry_open+0x7bf/0x10e0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103249]  ? __pfx_ceph_open+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103508]  vfs_open+0x6d/0x450
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103697]  ? may_open+0xec/0x370
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.103893]  path_openat+0x2017/0x50a0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104110]  ? __pfx_path_openat+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104345]  ?
> > > __pfx_stack_trace_save+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104599]  ?
> > > stack_depot_save_flags+0x28/0x8f0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.104865]  ? stack_depot_save+0xe/0x20
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105063]  do_filp_open+0x1b4/0x450
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105253]  ?
> > > __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105538]  ? __pfx_do_filp_open+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105748]  ? __link_object+0x13d/0x2b0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.105949]  ?
> > > __pfx__raw_spin_lock+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106169]  ?
> > > __check_object_size+0x453/0x600
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106428]  ? _raw_spin_unlock+0xe/0x40
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106635]  do_sys_openat2+0xe6/0x180
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.106827]  ?
> > > __pfx_do_sys_openat2+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107052]  __x64_sys_openat+0x108/0x240
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107258]  ?
> > > __pfx___x64_sys_openat+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107529]  ?
> > > __pfx___handle_mm_fault+0x10/0x10
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.107783]  x64_sys_call+0x134f/0x2350
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108007]  do_syscall_64+0x82/0xd50
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108201]  ?
> > > fpregs_assert_state_consistent+0x5c/0x100
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108467]  ? do_syscall_64+0xba/0xd50
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108626]  ? __kasan_check_read+0x11/0x20
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.108801]  ?
> > > count_memcg_events+0x25b/0x400
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109013]  ? handle_mm_fault+0x38b/0x6a0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109216]  ? __kasan_check_read+0x11/0x20
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109457]  ?
> > > fpregs_assert_state_consistent+0x5c/0x100
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109724]  ?
> > > irqentry_exit_to_user_mode+0x2e/0x2a0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.109991]  ? irqentry_exit+0x43/0x50
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110180]  ? exc_page_fault+0x95/0x100
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110389]
> > > entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110638] RIP: 0033:0x74a85bf145ab
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.110821] Code: 25 00 00 41 00 3d 00 00
> > > 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff
> > > b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48
> > > 2b 14 25
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.111724] RSP: 002b:00007ffc77d316d0
> > > EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112080] RAX: ffffffffffffffda RBX:
> > > 0000000000000002 RCX: 000074a85bf145ab
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112442] RDX: 0000000000000000 RSI:
> > > 00007ffc77d32789 RDI: 00000000ffffff9c
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.112790] RBP: 00007ffc77d32789 R08:
> > > 00007ffc77d31980 R09: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113125] R10: 0000000000000000 R11:
> > > 0000000000000246 R12: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113502] R13: 00000000ffffffff R14:
> > > 0000000000000180 R15: 0000000000000001
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113838]  </TASK>
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.113957] Modules linked in:
> > > intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core
> > > pmt_telemetry pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec
> > > kvm_intel kvm joydev irqbypass polyval_clmulni ghash_clmulni_intel aesni_intel
> > > rapl floppy input_leds psmouse i2c_piix4 vga16fb mac_hid i2c_smbus vgastate
> > > serio_raw bochs qemu_fw_cfg pata_acpi sch_fq_codel rbd msr parport_pc ppdev lp
> > > parport efi_pstore
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116339] CR2: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116574] ---[ end trace 0000000000000000
> > > ]---
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.116826] RIP: 0010:strcmp+0x1c/0x40
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.117058] Code: 90 90 90 90 90 90 90 90
> > > 90 90 90 90 90 90 31 c0 eb 14 66 66 2e 0f 1f 84 00 00 00 00 00 90 48 83 c0 01 84
> > > d2 74 19 0f b6 14 07 <3a> 14 06 74 ef 19 c0 83 c8 01 31 d2 31 f6 31 ff c3 cc cc
> > > cc cc 31
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118070] RSP: 0018:ffff8881536875c0
> > > EFLAGS: 00010246
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118362] RAX: 0000000000000000 RBX:
> > > ffff888116003200 RCX: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.118748] RDX: 0000000000000063 RSI:
> > > 0000000000000000 RDI: ffff88810126c900
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119116] RBP: ffff8881536876a8 R08:
> > > 0000000000000000 R09: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119492] R10: 0000000000000000 R11:
> > > 0000000000000000 R12: dffffc0000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.119865] R13: ffff8881061d0000 R14:
> > > 0000000000000000 R15: 0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120242] FS:  000074a85c082840(0000)
> > > GS:ffff8882401a4000(0000) knlGS:0000000000000000
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.120704] CS:  0010 DS: 0000 ES: 0000
> > > CR0: 0000000080050033
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121008] CR2: 0000000000000000 CR3:
> > > 0000000110ebd001 CR4: 0000000000772ef0
> > > Nov 14 11:48:11 ceph-0005 kernel: [  155.121409] PKRU: 55555554
> > > 
> > > We have issue here [1] if fs_name == NULL:
> > > 
> > > const char fs_name = mdsc->fsc->mount_options->mds_namespace;
> > >     ...
> > >     if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
> > >             / fsname mismatch, try next one */
> > >             return 0;
> > >     }
> > > 
> > > v2
> > > Patrick Donnelly suggested that: In summary, we should definitely start
> > > decoding `fs_name` from the MDSMap and do strict authorizations checks
> > > against it. Note that the `--mds_namespace` should only be used for
> > > selecting the file system to mount and nothing else. It's possible
> > > no mds_namespace is specified but the kernel will mount the only
> > > file system that exists which may have name "foo".
> > > 
> > > v3
> > > The namespace_equals() logic has been generalized into
> > > __namespace_equals() with the goal of using it in
> > > ceph_mdsc_handle_fsmap() and ceph_mds_auth_match().
> > > The misspelling of CEPH_NAMESPACE_WILDCARD has been corrected.
> > > 
> > > v4
> > > The __namespace_equals() now supports wildcard check.
> > > 
> > > v5
> > > Patrick Donnelly suggested to add the sanity check of
> > > kstrdup() returned pointer in ceph_mdsmap_decode()
> > > added logic. Also, he suggested much simpler logic of
> > > namespace strings comparison in the form of
> > > ceph_namespace_match() logic.
> > > 
> > > This patch reworks ceph_mdsmap_decode() and namespace_equals() with
> > > the goal of supporting the suggested concept. Now struct ceph_mdsmap
> > > contains m_fs_name field that receives copy of extracted FS name
> > > by ceph_extract_encoded_string(). For the case of "old" CephFS file systems,
> > > it is used "cephfs" name. Also, namespace_equals() method has been
> > > reworked with the goal of proper names comparison.
> > > 
> > > [1] https://elixir.bootlin.com/linux/v6.18-rc4/source/fs/ceph/mds_client.c#L5666
> > > [2] https://tracker.ceph.com/issues/73886
> > > 
> > > Fixes: 22c73d52a6d0 ("ceph: fix multifs mds auth caps issue")
> > > Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> > > cc: Kotresh Hiremath Ravishankar <khiremat@redhat.com>
> > > cc: Alex Markuze <amarkuze@redhat.com>
> > > cc: Ilya Dryomov <idryomov@gmail.com>
> > > cc: Patrick Donnelly <pdonnell@redhat.com>
> > > cc: Ceph Development <ceph-devel@vger.kernel.org>
> > > ---
> > >  fs/ceph/mds_client.c         | 11 +++++------
> > >  fs/ceph/mdsmap.c             | 24 ++++++++++++++++++------
> > >  fs/ceph/mdsmap.h             |  1 +
> > >  fs/ceph/super.h              | 24 +++++++++++++++++++-----
> > >  include/linux/ceph/ceph_fs.h |  6 ++++++
> > >  5 files changed, 49 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > > index 7e4eab824dae..703c14bc3c95 100644
> > > --- a/fs/ceph/mds_client.c
> > > +++ b/fs/ceph/mds_client.c
> > > @@ -5671,7 +5671,7 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
> > >         u32 caller_uid = from_kuid(&init_user_ns, cred->fsuid);
> > >         u32 caller_gid = from_kgid(&init_user_ns, cred->fsgid);
> > >         struct ceph_client *cl = mdsc->fsc->client;
> > > -       const char *fs_name = mdsc->fsc->mount_options->mds_namespace;
> > > +       const char *fs_name = mdsc->mdsmap->m_fs_name;
> > >         const char *spath = mdsc->fsc->mount_options->server_path;
> > >         bool gid_matched = false;
> > >         u32 gid, tlen, len;
> > > @@ -5679,7 +5679,8 @@ static int ceph_mds_auth_match(struct ceph_mds_client *mdsc,
> > > 
> > >         doutc(cl, "fsname check fs_name=%s  match.fs_name=%s\n",
> > >               fs_name, auth->match.fs_name ? auth->match.fs_name : "");
> > > -       if (auth->match.fs_name && strcmp(auth->match.fs_name, fs_name)) {
> > > +
> > > +       if (!ceph_namespace_match(auth->match.fs_name, fs_name, NAME_MAX)) {
> > 
> > Hi Slava,
> > 
> > How was this tested?  In particular, do you have a test case covering
> > an MDS auth cap that specifies a particular fs_name (i.e. one where
> > auth->match.fs_name wouldn't be NULL or CEPH_NAMESPACE_WILDCARD)?
> > 
> > I'm asking because it looks like ceph_namespace_match() would always
> > declare a mismatch in that scenario due to the fact that NAME_MAX is
> > passed for target_len and
> > 
> >     if (strlen(pattern) != target_len)
> >             return false;
> > 
> > condition inside of ceph_namespace_match().  This in turn means that
> > ceph_mds_check_access() would disregard the respective cap and might
> > allow access where it's supposed to be denied.
> > 
> > 
> 
> I have run the xfstests (quick group) with the patch applied. I didn't see any
> unusual behavior. If we believe that these tests are not enough, then, maybe, we
> need to introduce the additional Ceph specialized tests.

FWIW, the regression has been reported in Debian as well as
https://bugs.debian.org/1125405 and Reinhard confirmed that the patch
seems to resolve the observed regression.

Regards,
Salvatore
