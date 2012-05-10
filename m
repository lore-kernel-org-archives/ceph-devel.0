From: Giorgos Kappes <geokapp@gmail.com>
Subject: Re: Ceph kernel client - kernel craches
Date: Thu, 10 May 2012 21:00:39 +0300
Message-ID: <CAHcbcZdKj8H1=Q8Dvu17tyjafzH=0UFJ-1zxaAgLvTTtWC6Q+A@mail.gmail.com>
References: <CAHcbcZe2NSJhveSKq7tSazKcfB4b8ZUX89RtknXc==cQ59vDjQ@mail.gmail.com>
	<CADvuQRG2EJSC90GR+qkJN-tzi1d3VxxnZV_gMt_JdAcL2fEx4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50150 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab2EJSAk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 14:00:40 -0400
Received: by yenm10 with SMTP id m10so1753173yen.19
        for <ceph-devel@vger.kernel.org>; Thu, 10 May 2012 11:00:40 -0700 (PDT)
In-Reply-To: <CADvuQRG2EJSC90GR+qkJN-tzi1d3VxxnZV_gMt_JdAcL2fEx4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

Sorry for my late response. I reproduced the above bug with the Linux
kernel 3.3.4 and without using XEN:

uname -a
Linux node33 3.3.4 #1 SMP Wed May 9 13:00:07 EEST 2012 x86_64 GNU/Linux

The trace is shown below:

----------------------------------------------------
[ =A0763.984023] kernel tried to execute NX-protected page - exploit
attempt? (uid: 0)
[ =A0763.984177] BUG: unable to handle kernel paging request at ffff880=
037bd0800
[ =A0763.984402] IP: [<ffff880037bd0800>] 0xffff880037bd07ff
[ =A0763.984568] PGD 1806063 PUD 180a063 PMD 8000000037a001e3
[ =A0763.984845] Oops: 0011 [#1] SMP
[ =A0763.985058] CPU 3
[ =A0763.985124] Modules linked in: cbc netconsole loop snd_pcm
snd_timer snd soundcore snd_page_alloc processor tpm_tis i5400_edac
tpm edac_core tpm_bios evdev pcspkr i5k_amb rng_core thermal_sys
button shpchp pci_hotplug sd_mod crc_t10dif usbhid hid ide_cd_mod
cdrom ata_generic uhci_hcd ehci_hcd ata_piix libata piix ide_core
usbcore usb_common tg3 libphy mptsas mptscsih mptbase
scsi_transport_sas scsi_mod [last unloaded: scsi_wait_scan]
[ =A0763.988002]
[ =A0763.988002] Pid: 0, comm: swapper/3 Not tainted 3.3.4 #1 HP ProLia=
nt DL160 G5
[ =A0763.988002] RIP: 0010:[<ffff880037bd0800>] =A0[<ffff880037bd0800>]
0xffff880037bd07ff
[ =A0763.988002] RSP: 0018:ffff8800bfcc3e78 =A0EFLAGS: 00010292
[ =A0763.988002] RAX: ffff8800b97745b0 RBX: ffff8800bfcce770 RCX: ffff8=
80037bd0800
[ =A0763.988002] RDX: ffff880037bd1600 RSI: 00000000b9b6a040 RDI: ffff8=
80037bd1600
[ =A0763.988002] RBP: ffffffff81820080 R08: ffff8800b9dd0b00 R09: 00000=
0018020001c
[ =A0763.988002] R10: 000000008020001c R11: ffffffff816075c0 R12: ffff8=
800bfcce7a0
[ =A0763.988002] R13: ffff8800b97745b0 R14: 0000000000000003 R15: 00000=
0000000000a
[ =A0763.988002] FS: =A00000000000000000(0000) GS:ffff8800bfcc0000(0000=
)
knlGS:0000000000000000
[ =A0763.988002] CS: =A00010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ =A0763.988002] CR2: ffff880037bd0800 CR3: 00000000b895b000 CR4: 00000=
000000006e0
[ =A0763.988002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
[ =A0763.988002] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
[ =A0763.988002] Process swapper/3 (pid: 0, threadinfo ffff8800bbae0000=
,
task ffff8800bbad8000)
[ =A0763.988002] Stack:
[ =A0763.988002] =A0ffffffff8109b44d ffff8800bbacd820 ffff8800b97745b0
ffff8800bbae0010
[ =A0763.988002] =A0ffff8800bbad8000 ffff8800bfcc3ea0 0000000000000048
ffff8800bbae1fd8
[ =A0763.988002] =A00000000000000100 0000000000000001 0000000000000009
ffff8800bbae1fd8
[ =A0763.988002] Call Trace:
[ =A0763.988002] =A0<IRQ>
[ =A0763.988002] =A0[<ffffffff8109b44d>] ? __rcu_process_callbacks+0x1e=
9/0x335
[ =A0763.988002] =A0[<ffffffff8109b8fb>] ? rcu_process_callbacks+0x2c/0=
x56
[ =A0763.988002] =A0[<ffffffff8103e3b1>] ? __do_softirq+0xc4/0x1a0
[ =A0763.988002] =A0[<ffffffff8102515b>] ? lapic_next_event+0x18/0x1d
[ =A0763.988002] =A0[<ffffffff815d3b1c>] ? call_softirq+0x1c/0x30
[ =A0763.988002] =A0[<ffffffff8100fba3>] ? do_softirq+0x3f/0x79
[ =A0763.988002] =A0[<ffffffff8103e186>] ? irq_exit+0x44/0xb1
[ =A0763.988002] =A0[<ffffffff81025c61>] ? smp_apic_timer_interrupt+0x8=
5/0x93
[ =A0763.988002] =A0[<ffffffff815d311e>] ? apic_timer_interrupt+0x6e/0x=
80
[ =A0763.988002] =A0<EOI>
[ =A0763.988002] =A0[<ffffffff810145e1>] ? native_sched_clock+0x28/0x33
[ =A0763.988002] =A0[<ffffffff810152f6>] ? mwait_idle+0x8c/0xbc
[ =A0763.988002] =A0[<ffffffff810152ae>] ? mwait_idle+0x44/0xbc
[ =A0763.988002] =A0[<ffffffff8100de94>] ? cpu_idle+0xb9/0xf7
[ =A0763.988002] =A0[<ffffffff815c43c6>] ? start_secondary+0x270/0x275
[ =A0763.988002] Code: 00 00 00 00 04 8a b8 00 88 ff ff 00 04 8a b8 00
88 ff ff 00 03 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 <00> 16 bd 37 00 88 ff ff 40 ab cd bf 00 88 ff ff 20 15 42
b9 00
[ =A0763.988002] RIP =A0[<ffff880037bd0800>] 0xffff880037bd07ff
[ =A0763.988002] =A0RSP <ffff8800bfcc3e78>
[ =A0763.988002] CR2: ffff880037bd0800
[ =A0763.988002] ---[ end trace 614049dc850267ac ]---
[ =A0763.988002] Kernel panic - not syncing: Fatal exception in interru=
pt
[ =A0763.997833] ------------[ cut here ]------------
[ =A0763.997936] WARNING: at arch/x86/kernel/smp.c:120
update_process_times+0x57/0x63()
[ =A0763.998072] Hardware name: ProLiant DL160 G5
[ =A0763.998171] Modules linked in: cbc netconsole loop snd_pcm
snd_timer snd soundcore snd_page_alloc processor tpm_tis i5400_edac
tpm edac_core tpm_bios evdev pcspkr i5k_amb rng_core thermal_sys
button shpchp pci_hotplug sd_mod crc_t10dif usbhid hid ide_cd_mod
cdrom ata_generic uhci_hcd ehci_hcd ata_piix libata piix ide_core
usbcore usb_common tg3 libphy mptsas mptscsih mptbase
scsi_transport_sas scsi_mod [last unloaded: scsi_wait_scan]
[ =A0764.001205] Pid: 0, comm: swapper/3 Tainted: G =A0 =A0 =A0D =A0 =A0=
 =A03.3.4 #1
[ =A0764.001311] Call Trace:
[ =A0764.001404] =A0<IRQ> =A0[<ffffffff81038bb0>] ? warn_slowpath_commo=
n+0x78/0x8c
[ =A0764.001573] =A0[<ffffffff81044937>] ? update_process_times+0x57/0x=
63
[ =A0764.001681] =A0[<ffffffff81075dbe>] ? tick_sched_timer+0x65/0x8b
[ =A0764.001788] =A0[<ffffffff810561bd>] ? __run_hrtimer+0xb2/0x13d
[ =A0764.001832] =A0[<ffffffff81013ca9>] ? read_tsc+0x5/0x16
[ =A0764.001832] =A0[<ffffffff81056482>] ? hrtimer_interrupt+0xd8/0x1a7
[ =A0764.001832] =A0[<ffffffff81025c5c>] ? smp_apic_timer_interrupt+0x8=
0/0x93
[ =A0764.001832] =A0[<ffffffff81025c89>] ? native_safe_apic_wait_icr_id=
le+0x1a/0x49
[ =A0764.001832] =A0[<ffffffff815d311e>] ? apic_timer_interrupt+0x6e/0x=
80
[ =A0764.001832] =A0[<ffffffff81056eaa>] ? up+0xe/0x36
[ =A0764.001832] =A0[<ffffffff815ca3ec>] ? panic+0x189/0x1c9
[ =A0764.001832] =A0[<ffffffff815ca353>] ? panic+0xf0/0x1c9
[ =A0764.001832] =A0[<ffffffff810390ee>] ? kmsg_dump+0x53/0xef
[ =A0764.001832] =A0[<ffffffff815cd05e>] ? oops_end+0xaa/0xb7
[ =A0764.001832] =A0[<ffffffff8102eaca>] ? no_context+0x254/0x263
[ =A0764.001832] =A0[<ffffffff815cf187>] ? do_page_fault+0x1ad/0x34c
[ =A0764.001832] =A0[<ffffffff814c6b67>] ? __netif_receive_skb+0x44d/0x=
491
[ =A0764.001832] =A0[<ffffffff81013ca9>] ? read_tsc+0x5/0x16
[ =A0764.001832] =A0[<ffffffff814c6f4f>] ? netif_receive_skb+0x71/0x77
[ =A0764.001832] =A0[<ffffffff814c74bd>] ? napi_gro_receive+0x1f/0x2c
[ =A0764.001832] =A0[<ffffffff814c7029>] ? napi_skb_finish+0x1c/0x31
[ =A0764.001832] =A0[<ffffffffa008cc74>] ? tg3_poll_work+0x8f9/0xb66 [t=
g3]
[ =A0764.001832] =A0[<ffffffff815cc5f5>] ? page_fault+0x25/0x30
[ =A0764.001832] =A0[<ffffffff8109b44d>] ? __rcu_process_callbacks+0x1e=
9/0x335
[ =A0764.001832] =A0[<ffffffff8109b8fb>] ? rcu_process_callbacks+0x2c/0=
x56
[ =A0764.001832] =A0[<ffffffff8103e3b1>] ? __do_softirq+0xc4/0x1a0
[ =A0764.001832] =A0[<ffffffff8102515b>] ? lapic_next_event+0x18/0x1d
[ =A0764.001832] =A0[<ffffffff815d3b1c>] ? call_softirq+0x1c/0x30
[ =A0764.001832] =A0[<ffffffff8100fba3>] ? do_softirq+0x3f/0x79
[ =A0764.001832] =A0[<ffffffff8103e186>] ? irq_exit+0x44/0xb1
[ =A0764.001832] =A0[<ffffffff81025c61>] ? smp_apic_timer_interrupt+0x8=
5/0x93
[ =A0764.001832] =A0[<ffffffff815d311e>] ? apic_timer_interrupt+0x6e/0x=
80
[ =A0764.001832] =A0<EOI> =A0[<ffffffff810145e1>] ? native_sched_clock+=
0x28/0x33
[ =A0764.001832] =A0[<ffffffff810152f6>] ? mwait_idle+0x8c/0xbc
[ =A0764.001832] =A0[<ffffffff810152ae>] ? mwait_idle+0x44/0xbc
[ =A0764.001832] =A0[<ffffffff8100de94>] ? cpu_idle+0xb9/0xf7
[ =A0764.001832] =A0[<ffffffff815c43c6>] ? start_secondary+0x270/0x275
[ =A0764.001832] ---[ end trace 614049dc850267ad ]---

----------------------------------------------------

Also, as you noted, I disabled the NX bit by passing "noexec=3Doff" to
the kernel.
Unfortunately, the bug is still happening:

----------------------------------------------------
[ =A0703.168022] BUG: unable to handle kernel paging request at ffff87f=
fbfa0e22b
[ =A0703.168293] IP: [<ffff8800b9767200>] 0xffff8800b97671ff
[ =A0703.168457] PGD 0
[ =A0703.168613] Oops: 0002 [#1] SMP
[ =A0703.168831] CPU 0
[ =A0703.168896] Modules linked in: cbc netconsole loop tpm_tis snd_pcm
snd_timer snd soundcore shpchp pci_hotplug snd_page_alloc tpm
i5400_edac rng_core tpm_bios edac_core i5k_amb processor pcspkr
thermal_sys evdev button sd_mod crc_t10dif usbhid hid sg sr_mod cdrom
ata_generic uhci_hcd piix ide_core ehci_hcd ata_piix tg3 libphy
usbcore usb_common libata mptsas mptscsih mptbase scsi_transport_sas
scsi_mod [last unloaded: scsi_wait_scan]
[ =A0703.172001]
[ =A0703.172001] Pid: 0, comm: swapper/0 Not tainted 3.3.4 #1 HP ProLia=
nt DL160 G5
[ =A0703.172001] RIP: 0010:[<ffff8800b9767200>] =A0[<ffff8800b9767200>]
0xffff8800b97671ff
[ =A0703.172001] RSP: 0018:ffff8800bfc03e78 =A0EFLAGS: 00010292
[ =A0703.172001] RAX: ffff880037a02900 RBX: ffff8800bfc0e770 RCX: ffff8=
800b9767200
[ =A0703.172001] RDX: ffff8800b92b9000 RSI: ffff8800b8901800 RDI: ffff8=
800b92b9000
[ =A0703.172001] RBP: ffffffff81820080 R08: ffff8800b8f77f00 R09: 00000=
0018020000a
[ =A0703.172001] R10: 000000008020000a R11: ffff8800bfc0e600 R12: ffff8=
800bfc0e7a0
[ =A0703.172001] R13: ffff8800ba177370 R14: 0000000000000005 R15: 00000=
0000000000a
[ =A0703.172001] FS: =A00000000000000000(0000) GS:ffff8800bfc00000(0000=
)
knlGS:0000000000000000
[ =A0703.172001] CS: =A00010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ =A0703.172001] CR2: ffff87ffbfa0e22b CR3: 0000000001805000 CR4: 00000=
000000006f0
[ =A0703.172001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
[ =A0703.172001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
[ =A0703.172001] Process swapper/0 (pid: 0, threadinfo ffffffff81800000=
,
task ffffffff8180d020)
[ =A0703.172001] Stack:
[ =A0703.172001] =A0ffffffff8109b44d 0000000000000000 ffff880037a02900
ffffffff81800010
[ =A0703.172001] =A0ffffffff8180d020 ffffffff81801fd8 0000000000000048
ffffffff81801fd8
[ =A0703.172001] =A00000000000000100 0000000000000001 0000000000000009
ffffffff81801fd8
[ =A0703.172001] Call Trace:
[ =A0703.172001] =A0<IRQ>
[ =A0703.172001] =A0[<ffffffff8109b44d>] ? __rcu_process_callbacks+0x1e=
9/0x335
[ =A0703.172001] =A0[<ffffffff8109b8fb>] ? rcu_process_callbacks+0x2c/0=
x56
[ =A0703.172001] =A0[<ffffffff8103e3b1>] ? __do_softirq+0xc4/0x1a0
[ =A0703.172001] =A0[<ffffffff8102515b>] ? lapic_next_event+0x18/0x1d
[ =A0703.172001] =A0[<ffffffff815d3b1c>] ? call_softirq+0x1c/0x30
[ =A0703.172001] =A0[<ffffffff8100fba3>] ? do_softirq+0x3f/0x79
[ =A0703.172001] =A0[<ffffffff8103e186>] ? irq_exit+0x44/0xb1
[ =A0703.172001] =A0[<ffffffff81025c61>] ? smp_apic_timer_interrupt+0x8=
5/0x93
[ =A0703.172001] =A0[<ffffffff815d311e>] ? apic_timer_interrupt+0x6e/0x=
80
[ =A0703.172001] =A0<EOI>
[ =A0703.172001] =A0[<ffffffff810145e1>] ? native_sched_clock+0x28/0x33
[ =A0703.172001] =A0[<ffffffff810152f6>] ? mwait_idle+0x8c/0xbc
[ =A0703.172001] =A0[<ffffffff810152ae>] ? mwait_idle+0x44/0xbc
[ =A0703.172001] =A0[<ffffffff8100de94>] ? cpu_idle+0xb9/0xf7
[ =A0703.172001] =A0[<ffffffff818c1c06>] ? start_kernel+0x395/0x3a0
[ =A0703.172001] =A0[<ffffffff818c13d1>] ? x86_64_start_kernel+0x102/0x=
10f
[ =A0703.172001] Code: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
00 00 00 00 <00> 90 2b b9 00 88 ff ff 20 ac c1 bf 00 88 ff ff 20 98 a7
b8 00
[ =A0703.172001] RIP =A0[<ffff8800b9767200>] 0xffff8800b97671ff
[ =A0703.172001] =A0RSP <ffff8800bfc03e78>
[ =A0703.172001] CR2: ffff87ffbfa0e22b
[ =A0703.172001] ---[ end trace 15e08c2db2033830 ]---
[ =A0703.172001] Kernel panic - not syncing: Fatal exception in interru=
pt
----------------------------------------------------

The strange thing is that the crash traces does not contain any calls
related to Ceph.
However, this bug only happens when running debootstrap to install a
base Debian system
into a Ceph directory. Debootstrap completes successfully when the
target directory is
under NFS or on a local file system.

=46urthermore, a different crash occurs when trying to remove a
non-empty Ceph directory:
******************************************************
root@node33:/mnt# rm debian -r
rm: cannot remove `debian/etc': Directory not empty
Write failed: Broken pipe
******************************************************
The crash trace is shown below:

----------------------------------------------------

[74576.543412] libceph: client0 fsid 9b3222ac-fce2-44eb-8599-d39da02d23=
93
[74576.651197] libceph: mon0 192.168.2.254:6789 session established
[75143.963663] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000030
[75143.963771] IP: [<ffffffff811061cd>] path_init+0x218/0x2cc
[75143.963827] PGD 37a63067 PUD 37b4b067 PMD 0
[75143.963880] Oops: 0000 [#1] SMP
[75143.963928] CPU 3
[75143.963935] Modules linked in: cbc netconsole loop i5400_edac
snd_pcm edac_core i5k_amb snd_timer snd soundcore evdev snd_page_alloc
tpm_tis tpm processor rng_core thermal_sys pcspkr tpm_bios shpchp
pci_hotplug button sd_mod crc_t10dif usbhid hid ide_cd_mod cdrom
ata_generic uhci_hcd ata_piix libata piix ide_core ehci_hcd usbcore
usb_common tg3 libphy mptsas mptscsih mptbase scsi_transport_sas
scsi_mod [last unloaded: netconsole]
[75143.964390]
[75143.964426] Pid: 3861, comm: rm Not tainted 3.3.4 #1 HP ProLiant DL1=
60 G5
[75143.964485] RIP: 0010:[<ffffffff811061cd>] =A0[<ffffffff811061cd>]
path_init+0x218/0x2cc
[75143.964570] RSP: 0018:ffff880037b45d58 =A0EFLAGS: 00010202
[75143.964618] RAX: 0000000000000000 RBX: ffff8800b8975000 RCX: ffff880=
037b45ea8
[75143.964672] RDX: ffff8800b929a900 RSI: ffff880037b45d74 RDI: ffff880=
0b9d0e830
[75143.964727] RBP: 0000000000000050 R08: ffff880037b45de0 R09: 0000000=
000000000
[75143.964781] R10: 0000006e7265746c R11: 0000000001406d90 R12: ffff880=
037b45ea8
[75143.964835] R13: ffff8800b929a900 R14: ffff880037b45de0 R15: 0000000=
000000003
[75143.964890] FS: =A000007fb7a9b47700(0000) GS:ffff8800bfcc0000(0000)
knlGS:0000000000000000
[75143.964974] CS: =A00010 DS: 0000 ES: 0000 CR0: 000000008005003b
[75143.965023] CR2: 0000000000000030 CR3: 00000000379d5000 CR4: 0000000=
0000006e0
[75143.965078] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[75143.965132] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[75143.965187] Process rm (pid: 3861, threadinfo ffff880037b44000,
task ffff8800b91fed00)
[75143.965269] Stack:
[75143.965306] =A000000000b9f76000 000000005088218e ffff8800b9f76280
00000000b9f76280
[75143.965397] =A0ffff880037b45ea8 0000000000000050 ffff8800b8975000
0000000000000010
[75143.965489] =A000000000013f2030 ffffffff811072b4 ffffffff81060362
dead000000100100
[75143.965581] Call Trace:
[75143.965622] =A0[<ffffffff811072b4>] ? path_lookupat+0x2c/0x30b
[75143.965674] =A0[<ffffffff81060362>] ? try_to_wake_up+0x1a5/0x1a5
[75143.965725] =A0[<ffffffff811075b1>] ? do_path_lookup+0x1e/0x9a
[75143.965775] =A0[<ffffffff81107bf1>] ? user_path_parent+0x3a/0x5f
[75143.965826] =A0[<ffffffff810f3484>] ? virt_to_head_page+0x9/0x2c
[75143.965877] =A0[<ffffffff81107e96>] ? do_unlinkat+0x1d/0x15e
[75143.965927] =A0[<ffffffff81109e94>] ? vfs_readdir+0x91/0xa7
[75143.965977] =A0[<ffffffff8112a9a5>] ? fsnotify_find_inode_mark+0x23/=
0x2f
[75143.966031] =A0[<ffffffff810fa97e>] ? filp_close+0x64/0x6c
[75143.966082] =A0[<ffffffff815d2679>] ? system_call_fastpath+0x16/0x1b
[75143.966133] Code: 04 01 e9 a1 00 00 00 48 8d 74 24 1c e8 ae 6f ff
ff 49 89 c5 b8 f7 ff ff ff 4d 85 ed 0f 84 b0 00 00 00 49 8b 45 18 80
3b 00 74 28 <48> 8b 78 30 b8 ec ff ff ff 0f b7 17 81 e2 00 f0 00 00 81
fa 00
[75143.966507] RIP =A0[<ffffffff811061cd>] path_init+0x218/0x2cc
[75143.966558] =A0RSP <ffff880037b45d58>
[75143.966600] CR2: 0000000000000030
[75143.967124] ---[ end trace 18e2f523c5af9a38 ]---
[75143.967322] general protection fault: 0000 [#2] SMP
[75143.967542] CPU 3
[75143.967607] Modules linked in: cbc netconsole loop i5400_edac
snd_pcm edac_core i5k_amb snd_timer snd soundcore evdev snd_page_alloc
tpm_tis tpm processor rng_core thermal_sys pcspkr tpm_bios shpchp
pci_hotplug button sd_mod crc_t10dif usbhid hid ide_cd_mod cdrom
ata_generic uhci_hcd ata_piix libata piix ide_core ehci_hcd usbcore
usb_common tg3 libphy mptsas mptscsih mptbase scsi_transport_sas
scsi_mod [last unloaded: netconsole]
[75143.970715]
[75143.970805] Pid: 3861, comm: rm Tainted: G =A0 =A0 =A0D =A0 =A0 =A03=
=2E3.4 #1 HP
ProLiant DL160 G5
[75143.971058] RIP: 0010:[<ffffffff810fa947>] =A0[<ffffffff810fa947>]
filp_close+0x2d/0x6c
[75143.971085] RSP: 0018:ffff880037b45a48 =A0EFLAGS: 00010206
[75143.971085] RAX: 0012080800000000 RBX: ffff8800b910d300 RCX: 0000000=
000000000
[75143.971085] RDX: 0000000000000000 RSI: ffff8800b9712c00 RDI: ffff880=
0b910d300
[75143.971085] RBP: ffff8800b9712c00 R08: 0000000000016870 R09: 00007ff=
f71600000
[75143.971085] R10: 0000000000000001 R11: ffff880037b459a8 R12: 0000000=
000000000
[75143.971085] R13: ffff8800bb51f6c0 R14: 0000000000000004 R15: 0000000=
000000000
[75143.971085] FS: =A00000000000000000(0000) GS:ffff8800bfcc0000(0000)
knlGS:0000000000000000
[75143.971085] CS: =A00010 DS: 0000 ES: 0000 CR0: 000000008005003b
[75143.971085] CR2: 0000000000000030 CR3: 0000000001805000 CR4: 0000000=
0000006e0
[75143.971085] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[75143.971085] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[75143.971085] Process rm (pid: 3861, threadinfo ffff880037b44000,
task ffff8800b91fed00)
[75143.971085] Stack:
[75143.971085] =A0ffff8800b9712c00 0000000000000007 0000000000000000
ffffffff8103aaad
[75143.971085] =A00000000000000009 ffff8800b91fed00 ffff8800b91ff218
0000000000000009
[75143.971085] =A0ffff8800b8ca0700 ffff8800b92c0880 0000000000000001
ffffffff8103bfe4
[75143.971085] Call Trace:
[75143.971085] =A0[<ffffffff8103aaad>] ? put_files_struct+0x67/0xbf
[75143.971085] =A0[<ffffffff8103bfe4>] ? do_exit+0x2aa/0x7e1
[75143.971085] =A0[<ffffffff810390ee>] ? kmsg_dump+0x53/0xef
[75143.971085] =A0[<ffffffff815cd01a>] ? oops_end+0x66/0xb7
[75143.971085] =A0[<ffffffff815cd066>] ? oops_end+0xb2/0xb7
[75143.971085] =A0[<ffffffff8102eaca>] ? no_context+0x254/0x263
[75143.971085] =A0[<ffffffff81368f16>] ? ceph_writepages_start+0xbb4/0x=
bee
[75143.971085] =A0[<ffffffff815cf1ef>] ? do_page_fault+0x215/0x34c
[75143.971085] =A0[<ffffffff8136a1e5>] ? __cap_is_valid+0x19/0x9a
[75143.971085] =A0[<ffffffff8136ba47>] ? ceph_encode_inode_release+0xed=
/0x2b2
[75143.971085] =A0[<ffffffff81063c10>] ? update_curr+0xfb/0x130
[75143.971085] =A0[<ffffffff8100d6fe>] ? __switch_to+0x20b/0x35f
[75143.971085] =A0[<ffffffff81063c10>] ? update_curr+0xfb/0x130
[75143.971085] =A0[<ffffffff815cc5f5>] ? page_fault+0x25/0x30
[75143.971085] =A0[<ffffffff811061cd>] ? path_init+0x218/0x2cc
[75143.971085] =A0[<ffffffff811061b3>] ? path_init+0x1fe/0x2cc
[75143.971085] =A0[<ffffffff811072b4>] ? path_lookupat+0x2c/0x30b
[75143.971085] =A0[<ffffffff81060362>] ? try_to_wake_up+0x1a5/0x1a5
[75143.971085] =A0[<ffffffff811075b1>] ? do_path_lookup+0x1e/0x9a
[75143.971085] =A0[<ffffffff81107bf1>] ? user_path_parent+0x3a/0x5f
[75143.971085] =A0[<ffffffff810f3484>] ? virt_to_head_page+0x9/0x2c
[75143.971085] =A0[<ffffffff81107e96>] ? do_unlinkat+0x1d/0x15e
[75143.971085] =A0[<ffffffff81109e94>] ? vfs_readdir+0x91/0xa7
[75143.971085] =A0[<ffffffff8112a9a5>] ? fsnotify_find_inode_mark+0x23/=
0x2f
[75143.971085] =A0[<ffffffff810fa97e>] ? filp_close+0x64/0x6c
[75143.971085] =A0[<ffffffff815d2679>] ? system_call_fastpath+0x16/0x1b
[75143.971085] Code: 55 48 89 f5 53 48 89 fb 48 8b 47 30 48 85 c0 75
11 48 c7 c7 6e d5 72 81 45 31 e4 e8 f0 fa 4c 00 eb 40 48 8b 47 20 48
85 c0 74 10 <48> 8b 40 60 48 85 c0 74 07 ff d0 41 89 c4 eb 03 45 31 e4
f6 43
[75143.971085] RIP =A0[<ffffffff810fa947>] filp_close+0x2d/0x6c
[75143.971085] =A0RSP <ffff880037b45a48>
[75143.988721] ---[ end trace 18e2f523c5af9a39 ]---
[75143.988826] Fixing recursive fault but reboot is needed!
[75146.018276] ------------[ cut here ]------------
[75146.018399] kernel BUG at mm/slub.c:3442!
[75146.018498] invalid opcode: 0000 [#3] SMP
[75146.018718] CPU 1
[75146.018789] Modules linked in: cbc netconsole loop i5400_edac
snd_pcm edac_core i5k_amb snd_timer snd soundcore evdev snd_page_alloc
tpm_tis tpm processor rng_core thermal_sys pcspkr tpm_bios shpchp
pci_hotplug button sd_mod crc_t10dif usbhid hid ide_cd_mod cdrom
ata_generic uhci_hcd ata_piix libata piix ide_core ehci_hcd usbcore
usb_common tg3 libphy mptsas mptscsih mptbase scsi_transport_sas
scsi_mod [last unloaded: netconsole]
[75146.021908]
[75146.021999] Pid: 1137, comm: kworker/1:0 Tainted: G =A0 =A0 =A0D
3.3.4 #1 HP ProLiant DL160 G5
[75146.022236] RIP: 0010:[<ffffffff810f55df>] =A0[<ffffffff810f55df>]
kfree+0x59/0xc2
[75146.022236] RSP: 0018:ffff8800bbb35b90 =A0EFLAGS: 00010246
[75146.022236] RAX: 0100000000000400 RBX: ffff8800bfcdab70 RCX: ffff880=
0b9f762c8
[75146.022236] RDX: ffff8800bfc4e550 RSI: 0000000000000000 RDI: ffffea0=
002ff3680
[75146.022236] RBP: ffffffff815a2a50 R08: 0000000000000000 R09: fffffff=
f814f9620
[75146.022236] R10: 000000000000000d R11: ffff8800b9d0d000 R12: fffffff=
f815a2a47
[75146.022236] R13: ffff8800ba15d400 R14: ffff8800b9d0d271 R15: ffff880=
0b9d0d000
[75146.022236] FS: =A00000000000000000(0000) GS:ffff8800bfc40000(0000)
knlGS:0000000000000000
[75146.022236] CS: =A00010 DS: 0000 ES: 0000 CR0: 000000008005003b
[75146.022236] CR2: ffffffffff600400 CR3: 0000000037b13000 CR4: 0000000=
0000006e0
[75146.022236] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[75146.022236] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[75146.022236] Process kworker/1:0 (pid: 1137, threadinfo
ffff8800bbb34000, task ffff8800b90b0000)
[75146.022236] Stack:
[75146.022236] =A0ffff8800b8fde500 ffffffff815a2a50 ffff8800b9f72800
ffffffff815a2a47
[75146.022236] =A0ffff8800b8fde588 ffffffff81372b8e 0000001b00004040
ffff8800b9f72a68
[75146.022236] =A0ffff8800b9f72800 ffffffff8137513d ffff8800ba15d400
ffff8800b9f72a68
[75146.022236] Call Trace:
[75146.022236] =A0[<ffffffff815a2a50>] ? ceph_msg_kfree+0x47/0x47
[75146.022236] =A0[<ffffffff815a2a47>] ? ceph_msg_kfree+0x3e/0x47
[75146.022236] =A0[<ffffffff81372b8e>] ? kref_put+0x34/0x3e
[75146.022236] =A0[<ffffffff8137513d>] ? ceph_mdsc_release_request+0x2f=
/0x145
[75146.022236] =A0[<ffffffff8137510e>] ? encode_caps_cb+0x2f9/0x2f9
[75146.022236] =A0[<ffffffff81372b8e>] ? kref_put+0x34/0x3e
[75146.022236] =A0[<ffffffff813778d3>] ? dispatch+0xe05/0x132c
[75146.022236] =A0[<ffffffff814b3d5e>] ? kernel_recvmsg+0x34/0x3f
[75146.022236] =A0[<ffffffff813dce42>] ? crc32c+0x56/0x7c
[75146.022236] =A0[<ffffffff815a39c7>] ? ceph_tcp_recvmsg+0x43/0x4f
[75146.022236] =A0[<ffffffff815a658b>] ? con_work+0x15ac/0x17a8
[75146.022236] =A0[<ffffffff8104483f>] ? lock_timer_base+0x25/0x49
[75146.022236] =A0[<ffffffff815a4fdf>] ? ceph_fault+0x2b4/0x2b4
[75146.022236] =A0[<ffffffff8104ef8a>] ? process_one_work+0x1cd/0x2eb
[75146.022236] =A0[<ffffffff8104f1d6>] ? worker_thread+0x12e/0x249
[75146.022236] =A0[<ffffffff8104f0a8>] ? process_one_work+0x2eb/0x2eb
[75146.022236] =A0[<ffffffff8104f0a8>] ? process_one_work+0x2eb/0x2eb
[75146.022236] =A0[<ffffffff81052b82>] ? kthread+0x81/0x89
[75146.022236] =A0[<ffffffff815d3a24>] ? kernel_thread_helper+0x4/0x10
[75146.022236] =A0[<ffffffff81052b01>] ? kthread_freezable_should_stop+=
0x53/0x53
[75146.022236] =A0[<ffffffff815d3a20>] ? gs_change+0x13/0x13
[75146.022236] Code: 00 48 83 c5 10 48 83 7d 00 00 eb e6 48 83 fb 10
76 7d 48 89 df e8 ad de ff ff 48 89 c7 48 8b 00 84 c0 78 14 66 f7 07
00 c0 75 04 <0f> 0b eb fe 5b 5d 41 5c e9 e8 03 fd ff 4c 8b 54 24 18 4c
8b 4f
[75146.022236] RIP =A0[<ffffffff810f55df>] kfree+0x59/0xc2
[75146.022236] =A0RSP <ffff8800bbb35b90>
[75146.031675] ---[ end trace 18e2f523c5af9a3a ]---
[75146.031809] BUG: unable to handle kernel paging request at fffffffff=
ffffff8
[75146.032058] IP: [<ffffffff81052783>] kthread_data+0x7/0xc
[75146.032221] PGD 1807067 PUD 1808067 PMD 0
[75146.032494] Oops: 0000 [#4] SMP
[75146.032706] CPU 1
[75146.032771] Modules linked in: cbc netconsole loop i5400_edac
snd_pcm edac_core i5k_amb snd_timer snd soundcore evdev snd_page_alloc
tpm_tis tpm processor rng_core thermal_sys pcspkr tpm_bios shpchp
pci_hotplug button sd_mod crc_t10dif usbhid hid ide_cd_mod cdrom
ata_generic uhci_hcd ata_piix libata piix ide_core ehci_hcd usbcore
usb_common tg3 libphy mptsas mptscsih mptbase scsi_transport_sas
scsi_mod [last unloaded: netconsole]
[75146.035616]
[75146.035616] Pid: 1137, comm: kworker/1:0 Tainted: G =A0 =A0 =A0D
3.3.4 #1 HP ProLiant DL160 G5
[75146.035616] RIP: 0010:[<ffffffff81052783>] =A0[<ffffffff81052783>]
kthread_data+0x7/0xc
[75146.035616] RSP: 0018:ffff8800bbb35900 =A0EFLAGS: 00010002
[75146.035616] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000=
000000001
[75146.035616] RDX: ffffffff819a87b0 RSI: 0000000000000001 RDI: ffff880=
0b90b0000
[75146.035616] RBP: ffff8800b90b0000 R08: 0000000000000400 R09: fffffff=
f81013c7c
[75146.035616] R10: ffff8800b90b0000 R11: ffff8800b90b0518 R12: ffff880=
0b90b02f8
[75146.035616] R13: ffff8800bbb359c8 R14: 0000000000000001 R15: 0000000=
000000001
[75146.035616] FS: =A00000000000000000(0000) GS:ffff8800bfc40000(0000)
knlGS:0000000000000000
[75146.035616] CS: =A00010 DS: 0000 ES: 0000 CR0: 000000008005003b
[75146.035616] CR2: fffffffffffffff8 CR3: 0000000037b13000 CR4: 0000000=
0000006e0
[75146.035616] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[75146.035616] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[75146.035616] Process kworker/1:0 (pid: 1137, threadinfo
ffff8800bbb34000, task ffff8800b90b0000)
[75146.035616] Stack:
[75146.035616] =A0ffffffff8104e2a2 ffff8800bfc53340 ffffffff815cb1d1
0000000000000001
[75146.035616] =A00000000000000296 0000000000013340 ffff8800bbb35fd8
0000000000013340
[75146.035616] =A0ffff8800bbb35fd8 0000000000013340 ffff8800b90b0000
0000000000013340
[75146.035616] Call Trace:
[75146.035616] =A0[<ffffffff8104e2a2>] ? wq_worker_sleeping+0x8/0x82
[75146.035616] =A0[<ffffffff815cb1d1>] ? __schedule+0x166/0x4fc
[75146.035616] =A0[<ffffffff8103c517>] ? do_exit+0x7dd/0x7e1
[75146.035616] =A0[<ffffffff815ca46c>] ? printk+0x40/0x4c
[75146.035616] =A0[<ffffffff815cd01a>] ? oops_end+0x66/0xb7
[75146.035616] =A0[<ffffffff815cd066>] ? oops_end+0xb2/0xb7
[75146.035616] =A0[<ffffffff815a2a47>] ? ceph_msg_kfree+0x3e/0x47
[75146.035616] =A0[<ffffffff8100ef69>] ? do_invalid_op+0x8b/0x95
[75146.035616] =A0[<ffffffff810f55df>] ? kfree+0x59/0xc2
[75146.035616] =A0[<ffffffff81515b94>] ? inet_recvmsg+0x64/0x75
[75146.035616] =A0[<ffffffff815a2a50>] ? ceph_msg_kfree+0x47/0x47
[75146.035616] =A0[<ffffffff815d389b>] ? invalid_op+0x1b/0x20
[75146.035616] =A0[<ffffffff815a2a47>] ? ceph_msg_kfree+0x3e/0x47
[75146.035616] =A0[<ffffffff815a2a50>] ? ceph_msg_kfree+0x47/0x47
[75146.035616] =A0[<ffffffff814f9620>] ? tcp_recvmsg+0x773/0x95e
[75146.035616] =A0[<ffffffff810f55df>] ? kfree+0x59/0xc2
[75146.035616] =A0[<ffffffff815a2a50>] ? ceph_msg_kfree+0x47/0x47
[75146.035616] =A0[<ffffffff815a2a47>] ? ceph_msg_kfree+0x3e/0x47
[75146.035616] =A0[<ffffffff81372b8e>] ? kref_put+0x34/0x3e
[75146.035616] =A0[<ffffffff8137513d>] ? ceph_mdsc_release_request+0x2f=
/0x145
[75146.035616] =A0[<ffffffff8137510e>] ? encode_caps_cb+0x2f9/0x2f9
[75146.035616] =A0[<ffffffff81372b8e>] ? kref_put+0x34/0x3e
[75146.035616] =A0[<ffffffff813778d3>] ? dispatch+0xe05/0x132c
[75146.035616] =A0[<ffffffff814b3d5e>] ? kernel_recvmsg+0x34/0x3f
[75146.035616] =A0[<ffffffff813dce42>] ? crc32c+0x56/0x7c
[75146.035616] =A0[<ffffffff815a39c7>] ? ceph_tcp_recvmsg+0x43/0x4f
[75146.035616] =A0[<ffffffff815a658b>] ? con_work+0x15ac/0x17a8
[75146.035616] =A0[<ffffffff8104483f>] ? lock_timer_base+0x25/0x49
[75146.035616] =A0[<ffffffff815a4fdf>] ? ceph_fault+0x2b4/0x2b4
[75146.035616] =A0[<ffffffff8104ef8a>] ? process_one_work+0x1cd/0x2eb
[75146.035616] =A0[<ffffffff8104f1d6>] ? worker_thread+0x12e/0x249
[75146.035616] =A0[<ffffffff8104f0a8>] ? process_one_work+0x2eb/0x2eb
[75146.035616] =A0[<ffffffff8104f0a8>] ? process_one_work+0x2eb/0x2eb
[75146.035616] =A0[<ffffffff81052b82>] ? kthread+0x81/0x89
[75146.035616] =A0[<ffffffff815d3a24>] ? kernel_thread_helper+0x4/0x10
[75146.035616] =A0[<ffffffff81052b01>] ? kthread_freezable_should_stop+=
0x53/0x53
[75146.035616] =A0[<ffffffff815d3a20>] ? gs_change+0x13/0x13
[75146.035616] Code: 41 5e 41 5f c3 41 bf ea ff ff ff eb 97 90 90 90
65 48 8b 04 25 c0 c6 00 00 48 8b 80 a0 02 00 00 8b 40 f0 c3 48 8b 87
a0 02 00 00 <48> 8b 40 f8 c3 48 3b 3d 51 5f 95 00 75 08 0f bf 87 6a 06
00 00
[75146.035616] RIP =A0[<ffffffff81052783>] kthread_data+0x7/0xc
[75146.035616] =A0RSP <ffff8800bbb35900>
[75146.035616] CR2: fffffffffffffff8
[75146.035616] ---[ end trace 18e2f523c5af9a3b ]---
[75146.035616] Fixing recursive fault but reboot is needed!
[75206.036002] INFO: rcu_sched detected stalls on CPUs/tasks: { 1}
(detected by 3, t=3D15002 jiffies)
[75206.036265] Pid: 0, comm: swapper/3 Tainted: G =A0 =A0 =A0D =A0 =A0 =
=A03.3.4 #1
[75206.036371] Call Trace:
[75206.036464] =A0<IRQ> =A0[<ffffffff8109b7b3>] ? __rcu_pending+0x21a/0=
x336
[75206.036635] =A0[<ffffffff81075d59>] ? tick_nohz_handler+0xcb/0xcb
[75206.036740] =A0[<ffffffff8109b9cc>] ? rcu_check_callbacks+0xa7/0xe7
[75206.036846] =A0[<ffffffff81075d59>] ? tick_nohz_handler+0xcb/0xcb
[75206.036951] =A0[<ffffffff81044911>] ? update_process_times+0x31/0x63

----------------------------------------------------

Thanks a lot,
Giorgos Kappes

On Tue, May 8, 2012 at 10:18 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Tue, May 8, 2012 at 8:43 AM, Giorgos Kappes <geokapp@gmail.com> wr=
ote:
>> When I am running deboostrap to install a base Debian Squeeze system
>> on a Ceph directory the client's kernel crashes with the following
>> message:
>>
>> I: Extracting zlib1g...
>> W: Failure trying to run: chroot /mnt/debian mount -t proc proc /pro=
c
>> [ =A0759.776151] kernel tried to execute NX-protected page - exploit
>> attempt? (uid: 0)
>> [ =A0759.776169] BUG: unable to handle kernel paging request at ffff=
e8fffffe4ab0
> ...
>> [ =A0759.776438] =A0[<ffffffff81099405>] ? __rcu_process_callbacks+0=
x1c7/0x2f8
>> [ =A0759.776447] =A0[<ffffffff81099898>] ? rcu_process_callbacks+0x2=
c/0x56
>> [ =A0759.776457] =A0[<ffffffff8104cb72>] ? __do_softirq+0xc4/0x1a0
>> [ =A0759.776465] =A0[<ffffffff81096875>] ? handle_percpu_irq+0x3d/0x=
54
>> [ =A0759.776475] =A0[<ffffffff8150efb6>] ? __xen_evtchn_do_upcall+0x=
1c7/0x205
>> [ =A0759.776484] =A0[<ffffffff8176e52c>] ? call_softirq+0x1c/0x30
>> [ =A0759.776493] =A0[<ffffffff8100fa47>] ? do_softirq+0x3f/0x79
>> [ =A0759.776501] =A0[<ffffffff8104c942>] ? irq_exit+0x44/0xb5
>> [ =A0759.776508] =A0[<ffffffff8150ffc6>] ? xen_evtchn_do_upcall+0x27=
/0x32
>> [ =A0759.776516] =A0[<ffffffff8176e57e>] ? xen_do_hypervisor_callbac=
k+0x1e/0x30
> ...
>> My simple cluster consists of 3 nodes in total. Each node is a Xen
>> domU guest running the Linux kernel 3.2.6 and ceph 0.43. For
>> reference, here is my configuration:
> ...
>> My Ceph kernel client is another Xen domU node running the Linux
>> kernel 3.2.11. I have also tried a native client with the same resul=
t.
>> Please note that this bug happens only in the client side.
>> Your help would be greatly appreciated.
>
> Your backtrace includes Xen code in it -- can you reproduce this bug
> with a mainline kernel, without Xen at all?
>
> Also, the error encountered is from the NX security subsystem. It
> would be nice to know what would happen without NX.



-----------------------------------------------------------
Giorgos Kappes
Website:=A0http://www.cs.uoi.gr/~gkappes
email:=A0geokapp@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
