From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: oops in rbd module (con_work in libceph)
Date: Fri, 06 Jul 2012 10:31:55 +0200
Message-ID: <4FF6A27B.7020808@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtptls2-lmb.cpub.univ-nantes.fr ([193.52.103.111]:58096 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933011Ab2GFK1v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 06:27:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by smtp-tls.univ-nantes.fr (Postfix) with ESMTP id CEB64400976
	for <ceph-devel@vger.kernel.org>; Fri,  6 Jul 2012 10:31:58 +0200 (CEST)
Received: from smtp-tls.univ-nantes.fr ([127.0.0.1])
	by localhost (smtptls2-lmb.cpub.univ-nantes.fr [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BE7-TCUTJBQ5 for <ceph-devel@vger.kernel.org>;
	Fri,  6 Jul 2012 10:31:55 +0200 (CEST)
Received: from [IPv6:2001:660:7220:0:9c59:a660:cf26:912b] (unknown [IPv6:2001:660:7220:0:9c59:a660:cf26:912b])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-tls.univ-nantes.fr (Postfix) with ESMTPSA id 9EE6F403AA1
	for <ceph-devel@vger.kernel.org>; Fri,  6 Jul 2012 10:31:55 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello.

Bug happens in rbd client, at least in Kernel 3.4.4 . I have a=20
completely reproductible bug.

here is the oops :


Jul  6 10:16:52 label5.u14.univ-nantes.prive kernel: [  329.456285]=20
EXT4-fs (rbd1): mounted filesystem with ordered data mode. Opts: (null)
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.709145]=20
libceph: osd1 172.20.14.131:6801 socket closed
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.715245] BUG=
:=20
unable to handle kernel NULL pointer dereference at 0000000000000048
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.715430] IP:=
=20
[<ffffffffa08488f0>] con_work+0xfb0/0x20b0 [libceph]
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.715554] PGD=
=20
a094cb067 PUD a0a7a7067 PMD 0
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.715758]=20
Oops: 0000 [#1] SMP
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.715914] CPU=
 0
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.715963]=20
Modules linked in: ext4 jbd2 crc16 rbd libceph drbd lru_cache cn=20
ip6table_filter ip6_tables iptable_filt
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.720338]
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.720406] Pid=
:=20
1007, comm: kworker/0:2 Not tainted 3.4.4-dsiun-120521 #111 Dell Inc.=20
PowerEdge M610/0V56FN
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.720637] RIP=
:=20
0010:[<ffffffffa08488f0>]  [<ffffffffa08488f0>] con_work+0xfb0/0x20b0=20
[libceph]
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.720779] RSP=
:=20
0000:ffff880a1036dd50  EFLAGS: 00010246
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.720851] RAX=
:=20
0000000000000000 RBX: 0000000000000000 RCX: 0000000000031000
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.720925] RDX=
:=20
0000000000000000 RSI: ffff880a1092c5a0 RDI: ffff880a1092c598
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.721002] RBP=
:=20
000000000004f000 R08: 0000000000000020 R09: 0000000000000000
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.721100] R10=
:=20
0000000000000010 R11: ffff880a122e0f08 R12: 0000000000000001
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.721173] R13=
:=20
ffff880a1092c500 R14: ffffea001430e300 R15: ffff880a0990f030
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.721247] FS:=
 =20
0000000000000000(0000) GS:ffff880a2fc00000(0000) knlGS:0000000000000000
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.721337] CS:=
 =20
0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.721409] CR2=
:=20
0000000000000048 CR3: 0000000a10823000 CR4: 00000000000007f0
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.721483] DR0=
:=20
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.721557] DR3=
:=20
0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.721632]=20
Process kworker/0:2 (pid: 1007, threadinfo ffff880a1036c000, task=20
ffff880a10b2f2c0)
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.721721] Sta=
ck:
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.721784]=20
0000000200000000 ffff880a1036ddfc 0000000000000400 ffff880a00000000
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.722050]=20
ffff880a1036ddd8 000000000004f000 ffff880a0004f000 ffff880a00000000
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.722315]=20
ffff880a0990f420 ffff880a1092c5a0 ffff880a0990f308 ffff880a0990f1a8
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.722581] Cal=
l=20
Trace:
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.722653]=20
[<ffffffff810534d2>] ? process_one_work+0x122/0x3f0
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.722728]=20
[<ffffffffa0847940>] ? ceph_con_revoke_message+0xc0/0xc0 [libceph]
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.722819]=20
[<ffffffff81054c65>] ? worker_thread+0x125/0x2e0
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.722892]=20
[<ffffffff81054b40>] ? manage_workers.isra.25+0x1f0/0x1f0
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.722969]=20
[<ffffffff81059b85>] ? kthread+0x85/0x90
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.723042]=20
[<ffffffff813baee4>] ? kernel_thread_helper+0x4/0x10
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.723116]=20
[<ffffffff81059b00>] ? flush_kthread_worker+0x80/0x80
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.723189]=20
[<ffffffff813baee0>] ? gs_change+0x13/0x13
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.723258]=20
Code: ea f4 ff ff 0f 1f 80 00 00 00 00 49 83 bd 90 00 00 00 00 0f 84 ca=
=20
03 00 00 49 63 85 a0 00 00 00 49
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.727478] RIP=
 =20
[<ffffffffa08488f0>] con_work+0xfb0/0x20b0 [libceph]
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.727599] RSP=
=20
<ffff880a1036dd50>
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.727664] CR2=
:=20
0000000000000048
Jul  6 10:18:38 label5.u14.univ-nantes.prive kernel: [  434.727846] ---=
[=20
end trace 100f342b55356819 ]---
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.728031] BUG=
:=20
unable to handle kernel paging request at fffffffffffffff8
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.728192] IP:=
=20
[<ffffffff81059d27>] kthread_data+0x7/0x10
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.728313] PGD=
=20
14fe067 PUD 14ff067 PMD 0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.728517]=20
Oops: 0000 [#2] SMP
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.728676] CPU=
 0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.728725]=20
Modules linked in: ext4 jbd2 crc16 rbd libceph drbd lru_cache cn=20
ip6table_filter ip6_tables iptable_filt
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.733034]
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.733100] Pid=
:=20
1007, comm: kworker/0:2 Tainted: G      D 3.4.4-dsiun-120521 #111 Dell=20
Inc. PowerEdge M610/0V5
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.733330] RIP=
:=20
0010:[<ffffffff81059d27>]  [<ffffffff81059d27>] kthread_data+0x7/0x10
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.733470] RSP=
:=20
0000:ffff880a1036da30  EFLAGS: 00010002
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.733539] RAX=
:=20
0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.733612] RDX=
:=20
ffffffff8164a380 RSI: 0000000000000000 RDI: ffff880a10b2f2c0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.733686] RBP=
:=20
ffff880a10b2f2c0 R08: 0000000000989680 R09: ffffffff8164a380
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.733758] R10=
:=20
0000000000000800 R11: 000000000000fff8 R12: ffff880a2fc120c0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.733830] R13=
:=20
0000000000000000 R14: ffff880a10b2f2b0 R15: ffff880a10b2f2c0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.733904] FS:=
 =20
0000000000000000(0000) GS:ffff880a2fc00000(0000) knlGS:0000000000000000
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.733993] CS:=
 =20
0010 DS: 0000 ES: 0000 CR0: 000000008005003b
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.734064] CR2=
:=20
fffffffffffffff8 CR3: 0000000a10823000 CR4: 00000000000007f0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.734138] DR0=
:=20
0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.734211] DR3=
:=20
0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.734284]=20
Process kworker/0:2 (pid: 1007, threadinfo ffff880a1036c000, task=20
ffff880a10b2f2c0)
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.734375] Sta=
ck:
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.734439]=20
ffffffff81055ae8 ffff880a10b2f590 ffffffff813b807d ffff880a10b2f2c0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.734706]=20
ffff880a10b2f2c0 ffff880a1036dfd8 ffff880a1036dfd8 ffff880a1036dfd8
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.734971]=20
ffff880a10b2f2c0 0000000000000001 ffff880a10b2f7a4 0000000000000000
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.735237] Cal=
l=20
Trace:
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.735309]=20
[<ffffffff81055ae8>] ? wq_worker_sleeping+0x8/0x90
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.735386]=20
[<ffffffff813b807d>] ? __schedule+0x41d/0x6c0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.735463]=20
[<ffffffff8103e2a2>] ? do_exit+0x592/0x8c0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.735537]=20
[<ffffffff81006068>] ? oops_end+0x98/0xe0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.735611]=20
[<ffffffff813b0f96>] ? no_context+0x24e/0x279
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.735685]=20
[<ffffffff8102e31b>] ? do_page_fault+0x3ab/0x460
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.735760]=20
[<ffffffff8135677b>] ? tcp_established_options+0x3b/0xd0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.735833]=20
[<ffffffff813589aa>] ? tcp_write_xmit+0x15a/0xac0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.735907]=20
[<ffffffff813b9179>] ? _raw_spin_lock_bh+0x9/0x30
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.735984]=20
[<ffffffff812f9a79>] ? release_sock+0x19/0x100
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736056]=20
[<ffffffff8134af43>] ? tcp_sendpage+0xf3/0x700
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736131]=20
[<ffffffff813b94f5>] ? page_fault+0x25/0x30
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736206]=20
[<ffffffffa08488f0>] ? con_work+0xfb0/0x20b0 [libceph]
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736280]=20
[<ffffffff810534d2>] ? process_one_work+0x122/0x3f0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736355]=20
[<ffffffffa0847940>] ? ceph_con_revoke_message+0xc0/0xc0 [libceph]
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736446]=20
[<ffffffff81054c65>] ? worker_thread+0x125/0x2e0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736518]=20
[<ffffffff81054b40>] ? manage_workers.isra.25+0x1f0/0x1f0
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736593]=20
[<ffffffff81059b85>] ? kthread+0x85/0x90
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736664]=20
[<ffffffff813baee4>] ? kernel_thread_helper+0x4/0x10
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736739]=20
[<ffffffff81059b00>] ? flush_kthread_worker+0x80/0x80
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736813]=20
[<ffffffff813baee0>] ? gs_change+0x13/0x13
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.736883]=20
Code: fe ff ff 90 eb 90 be 57 01 00 00 48 c7 c7 9b 70 47 81 e8 cd 00 fe=
=20
ff e9 94 fe ff ff 0f 1f 84 00 00
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.739914] RIP=
 =20
[<ffffffff81059d27>] kthread_data+0x7/0x10
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.740036] RSP=
=20
<ffff880a1036da30>
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.740103] CR2=
:=20
fffffffffffffff8
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.740170] ---=
[=20
end trace 100f342b5535681a ]---
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  434.740250]=20
=46ixing recursive fault but reboot is needed!
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  494.699770]=20
INFO: rcu_sched detected stalls on CPUs/tasks: { 0} (detected by 16,=20
t=3D6002 jiffies)
Jul  6 10:19:38 label5.u14.univ-nantes.prive kernel: [  494.700039]=20
INFO: Stall ended before state dump start




Step (for me) to reproduce :

the volume is on my freshly re-created ceph with 8 osd nodes (xfs=20
formatted osd). I created an rbd volume (yd-bench) on it.
this rbd volume is ext4 formatted.

It only contains copy of the git trunk linux-stable

Then, on a client (running nothing ceph-related)

modprobe rbd
rbd map yd-bench
mount
cd linux-stable
make -j24 bzImage modules

is sufficient to lead to the crash. The machine has 32GB of ram, 64=20
bits, and the same works on localdisk.

kernel is vanilla 3.4.4.

Any ideas ?

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
