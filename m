From: Giorgos Kappes <geokapp@gmail.com>
Subject: Ceph kernel client - kernel craches
Date: Tue, 8 May 2012 18:43:32 +0300
Message-ID: <CAHcbcZe2NSJhveSKq7tSazKcfB4b8ZUX89RtknXc==cQ59vDjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:48459 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755510Ab2EHPne convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 May 2012 11:43:34 -0400
Received: by wibhn19 with SMTP id hn19so291180wib.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 May 2012 08:43:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,

When I am running deboostrap to install a base Debian Squeeze system
on a Ceph directory the client's kernel crashes with the following
message:

I: Retrieving Release
I: Validating Packages
I: Resolving dependencies of required packages...
I: Resolving dependencies of base packages...
I: Found additional required dependencies: insserv libbz2-1.0 libdb4.8 =
libslang2
I: Found additional base dependencies: libnfnetlink0 libsqlite3-0
I: Checking component main on http://ftp.us.debian.org/debian...
I: Validating libacl1
=2E..
I: Extracting xz-utils...
I: Extracting zlib1g...
W: Failure trying to run: chroot /mnt/debian mount -t proc proc /proc
[  759.776151] kernel tried to execute NX-protected page - exploit
attempt? (uid: 0)
[  759.776169] BUG: unable to handle kernel paging request at ffffe8fff=
ffe4ab0
[  759.776182] IP: [<ffffe8fffffe4ab0>] 0xffffe8fffffe4aaf
[  759.776195] PGD c42b067 PUD c42c067 PMD c42d067 PTE 801000000c445067
[  759.776209] Oops: 0011 [#1] SMP
[  759.776219] CPU 0
[  759.776224] Modules linked in: pcspkr [last unloaded: scsi_wait_scan=
]
[  759.776237]
[  759.776244] Pid: 0, comm: swapper/0 Tainted: G        W    3.2.11 #2
[  759.776255] RIP: e030:[<ffffe8fffffe4ab0>]  [<ffffe8fffffe4ab0>]
0xffffe8fffffe4aaf
[  759.776267] RSP: e02b:ffff88001ffaae98  EFLAGS: 00010296
[  759.776274] RAX: ffff880012d7a900 RBX: ffff88001ffb5960 RCX: ffffe8f=
ffffe4ab0
[  759.776302] RDX: ffff88000d1a9b00 RSI: 000000000000000f RDI: ffff880=
00d1a9b00
[  759.776309] RBP: ffffffff81c1fa80 R08: ffff88001eb74000 R09: 0000000=
18010000f
[  759.776317] R10: 000000008010000f R11: ffffffff818055f5 R12: ffff880=
01ffb5990
[  759.776324] R13: ffff88000c5ea880 R14: 0000000000000001 R15: 0000000=
00000000a
[  759.776334] FS:  00007f21095a4740(0000) GS:ffff88001ffa7000(0000)
knlGS:0000000000000000
[  759.776342] CS:  e033 DS: 0000 ES: 0000 CR0: 000000008005003b
[  759.776349] CR2: ffffe8fffffe4ab0 CR3: 0000000012e28000 CR4: 0000000=
000002660
[  759.776356] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
[  759.776364] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000=
000000400
[  759.776372] Process swapper/0 (pid: 0, threadinfo ffffffff81c00000,
task ffffffff81c0d020)
[  759.776379] Stack:
[  759.776384]  ffffffff81099405 0000000000000001 ffff880012d7a900
ffff88001ffaaeb0
[  759.776397]  0000000000000048 ffffffff81c01fd8 0000000000000100
0000000000000001
[  759.776409]  0000000000000009 ffffffff81c01fd8 ffffffff81099898
ffffffff81c01fd8
[  759.776422] Call Trace:
[  759.776427]  <IRQ>
[  759.776438]  [<ffffffff81099405>] ? __rcu_process_callbacks+0x1c7/0x=
2f8
[  759.776447]  [<ffffffff81099898>] ? rcu_process_callbacks+0x2c/0x56
[  759.776457]  [<ffffffff8104cb72>] ? __do_softirq+0xc4/0x1a0
[  759.776465]  [<ffffffff81096875>] ? handle_percpu_irq+0x3d/0x54
[  759.776475]  [<ffffffff8150efb6>] ? __xen_evtchn_do_upcall+0x1c7/0x2=
05
[  759.776484]  [<ffffffff8176e52c>] ? call_softirq+0x1c/0x30
[  759.776493]  [<ffffffff8100fa47>] ? do_softirq+0x3f/0x79
[  759.776501]  [<ffffffff8104c942>] ? irq_exit+0x44/0xb5
[  759.776508]  [<ffffffff8150ffc6>] ? xen_evtchn_do_upcall+0x27/0x32
[  759.776516]  [<ffffffff8176e57e>] ? xen_do_hypervisor_callback+0x1e/=
0x30
[  759.776523]  <EOI>
[  759.776531]  [<ffffffff81006f3f>] ? xen_restore_fl_direct_reloc+0x4/=
0x4
[  759.776539]  [<ffffffff810013aa>] ? hypercall_page+0x3aa/0x1000
[  759.776547]  [<ffffffff810013aa>] ? hypercall_page+0x3aa/0x1000
[  759.776556]  [<ffffffff8163969b>] ? cpuidle_idle_call+0x16/0x1af
[  759.776564]  [<ffffffff810068dc>] ? xen_safe_halt+0xc/0x15
[  759.776572]  [<ffffffff810150a6>] ? default_idle+0x4b/0x84
[  759.776580]  [<ffffffff8100ddf6>] ? cpu_idle+0xb9/0xef
[  759.776588]  [<ffffffff81cf7bff>] ? start_kernel+0x395/0x3a0
[  759.776596]  [<ffffffff81cfa536>] ? xen_start_kernel+0x593/0x598
[  759.776602] Code: e8 ff ff 80 4a fe ff ff e8 ff ff 0b 00 00 00 01
00 00 00 fa ff ff ff fa ff ff ff 06 00 00 00 02 00 00 00 05 00 00 00
cc cc cc cc <00> 9b 1a 0d 00 88 ff ff 00 0f b7 1e 00 88 ff ff 01 00 00
00 00
[  759.776699] RIP  [<ffffe8fffffe4ab0>] 0xffffe8fffffe4aaf
[  759.776712]  RSP <ffff88001ffaae98>
[  759.776717] CR2: ffffe8fffffe4ab0
[  759.776725] ---[ end trace 36924001333caa12 ]---
[  759.776731] Kernel panic - not syncing: Fatal exception in interrupt
[  759.776739] Pid: 0, comm: swapper/0 Tainted: G      D W    3.2.11 #2
[  759.776745] Call Trace:
[  759.776749]  <IRQ>  [<ffffffff81764003>] ? panic+0x92/0x1a0
[  759.776771]  [<ffffffff810478c0>] ? kmsg_dump+0x41/0xdd
[  759.776779]  [<ffffffff81766cc1>] ? oops_end+0xa9/0xb6
[  759.776788]  [<ffffffff8102ec7d>] ? no_context+0x1ff/0x20c
[  759.776795]  [<ffffffff81768d9f>] ? do_page_fault+0x1ad/0x34c
[  759.776805]  [<ffffffff8106dfb3>] ? tick_nohz_handler+0xcb/0xcb
[  759.776813]  [<ffffffff8102c12a>] ? pvclock_clocksource_read+0x46/0x=
b4
[  759.776821]  [<ffffffff81006eb3>] ? xen_vcpuop_set_next_event+0x4d/0=
x61
[  759.776829]  [<ffffffff8106cdcc>] ? clockevents_program_event+0x99/0=
xb8
[  759.776837]  [<ffffffff817663b5>] ? page_fault+0x25/0x30
[  759.776845]  [<ffffffff81099405>] ? __rcu_process_callbacks+0x1c7/0x=
2f8
[  759.776853]  [<ffffffff81099898>] ? rcu_process_callbacks+0x2c/0x56
[  759.776861]  [<ffffffff8104cb72>] ? __do_softirq+0xc4/0x1a0
[  759.776868]  [<ffffffff81096875>] ? handle_percpu_irq+0x3d/0x54
[  759.776876]  [<ffffffff8150efb6>] ? __xen_evtchn_do_upcall+0x1c7/0x2=
05
[  759.776883]  [<ffffffff8176e52c>] ? call_softirq+0x1c/0x30
[  759.776891]  [<ffffffff8100fa47>] ? do_softirq+0x3f/0x79
[  759.776898]  [<ffffffff8104c942>] ? irq_exit+0x44/0xb5
[  759.776905]  [<ffffffff8150ffc6>] ? xen_evtchn_do_upcall+0x27/0x32
[  759.776913]  [<ffffffff8176e57e>] ? xen_do_hypervisor_callback+0x1e/=
0x30
[  759.776919]  <EOI>  [<ffffffff81006f3f>] ?
xen_restore_fl_direct_reloc+0x4/0x4
[  759.776931]  [<ffffffff810013aa>] ? hypercall_page+0x3aa/0x1000
[  759.780132]  [<ffffffff810013aa>] ? hypercall_page+0x3aa/0x1000
[  759.780132]  [<ffffffff8163969b>] ? cpuidle_idle_call+0x16/0x1af
[  759.780132]  [<ffffffff810068dc>] ? xen_safe_halt+0xc/0x15
[  759.780132]  [<ffffffff810150a6>] ? default_idle+0x4b/0x84
[  759.780132]  [<ffffffff8100ddf6>] ? cpu_idle+0xb9/0xef
[  759.780132]  [<ffffffff81cf7bff>] ? start_kernel+0x395/0x3a0



My simple cluster consists of 3 nodes in total. Each node is a Xen
domU guest running the Linux kernel 3.2.6 and ceph 0.43. For
reference, here is my configuration:

; ---------------------------------------------------------------------=
----------------------
;
; ceph ceph.conf file.
;
; This file defines cluster membership, the various locations
; that Ceph stores data, and any other runtime options.

[global]
        ; enable secure authentication
        auth supported =3D cephx

        ; keyring placement
        keyring =3D /etc/ceph/$name.keyring
        ; allow ourselves to open a lot of files
        ; max open files =3D 131072

        ; set log file
        ; log file =3D /var/log/ceph/$name.log
        ; log_to_syslog =3D true        ; uncomment this line to log to=
 syslog

        ; set up pid files
        ; pid file =3D /var/run/ceph/$name.pid

        ; If you want to run a IPv6 cluster, set this to true.
Dual-stack isn't possible
        ; ms bind ipv6 =3D true

; monitors
[mon]
        mon data =3D /mnt/store/$name

[mon.a]
        host =3D sm-ceph0
        mon addr =3D 192.168.2.254:6789

[mds]
        ; where the mds keeps it's secret encryption keys
        ;keyring =3D /data/keyring.$name

[mds.a]
        host =3D sm-ceph0

[osd]
        ; This is where the btrfs volume will be mounted.
        osd data =3D /mnt/store/$name

        ; This is a file-based journal.
        osd journal =3D /mnt/store/$name/$name.journal
        osd journal size =3D 1000 ; journal size, in megabytes

        ; You can change the number of recovery operations to speed up =
recovery
        ; or slow it down if your machines can't handle it
        ; osd recovery max active =3D 3

[osd.0]
        host =3D sm-ceph0
        btrfs devs =3D /dev/xvda3

        ; If you want to specify some other mount options, you can do s=
o.
        ; The default values are rw,noatime
        ; btrfs options =3D rw,noatime

[osd.1]
        host =3D sm-ceph1
        btrfs devs =3D /dev/xvda3

[osd.2]
        host =3D sm-ceph2
        btrfs devs =3D /dev/xvda3
; ---------------------------------------------------------------------=
----------------------
My Ceph kernel client is another Xen domU node running the Linux
kernel 3.2.11. I have also tried a native client with the same result.
Please note that this bug happens only in the client side.
Your help would be greatly appreciated.

Thanks,
Giorgos Kappes


-----------------------------------------------------------
Giorgos Kappes
Website:=A0http://www.cs.uoi.gr/~gkappes
email:=A0geokapp@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
