From: Yann Dupont <Yann.Dupont@univ-nantes.fr>
Subject: reproductible kernel oops with kernel 3.2 inside kvm
Date: Thu, 03 May 2012 16:05:53 +0200
Message-ID: <4FA290C1.9080808@univ-nantes.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp-tls1.univ-nantes.fr ([193.52.101.145]:52746 "EHLO
	smtp-tls.univ-nantes.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755948Ab2ECOF4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 May 2012 10:05:56 -0400
Received: from localhost (debian [127.0.0.1])
	by smtp-tls.univ-nantes.fr (Postfix) with ESMTP id B201494E47
	for <ceph-devel@vger.kernel.org>; Thu,  3 May 2012 16:05:53 +0200 (CEST)
Received: from smtp-tls.univ-nantes.fr ([127.0.0.1])
	by localhost (smtp-tls1.d101.univ-nantes.fr [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Ii8AYiuTVvMe for <ceph-devel@vger.kernel.org>;
	Thu,  3 May 2012 16:05:53 +0200 (CEST)
Received: from [172.20.13.9] (tomintoul.cri.univ-nantes.prive [172.20.13.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-tls.univ-nantes.fr (Postfix) with ESMTPSA id 91ED094DB2
	for <ceph-devel@vger.kernel.org>; Thu,  3 May 2012 16:05:53 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello. I'm stress testing ceph since some time now, with quite good=20
results. I really like ceph and will probably use in in some=20
pre-production services.

Anyway I've seen some bugs.

One of them is instability if the kernel is running inside KVM, leading=
=20
to a very fast (and reproductible) kernel oops. On bare metal this=20
particular oops doesn't happen.

The kernel oops itself involve ceph, but it could be a real bug in kvm =
too.

The host machine is runnning 3.2.2
kvm is quite ancien (0.14)
guest OS is ubuntu 12.04 with his standard kernel. Retried with custom=20
3.2 kernel with the same problem.


I'm using ceph using mount -t ceph mon_adress:/ /mnt/temp

A simple recursive copy of /home lead to this kernel oops:

May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675559] BUG:=20
unable to handle kernel NULL pointer dereference at   (null)
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675569] IP:=20
[<f8379d8d>] ceph_d_prune+0x1d/0x30 [ceph]
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675579] *pde =
=3D=20
00000000
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675583] Oops:=
=20
0002 [#1] SMP
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675587]=20
Modules linked in: ceph libceph libcrc32c zram(C) parport_pc rfcomm=20
ppdev bnep lp bluetooth parport dm_crypt binfmt_misc psmouse mac_hid=20
virtio_balloon serio_raw i2c_piix4 nf_conntrack_ipv6 nf_conntrack=20
nf_defrag_ipv6 floppy
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675605]
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675609] Pid:=20
27, comm: kswapd0 Tainted: G S      WC   3.2.0-24-generic #37-Ubuntu=20
Bochs Bochs
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675614] EIP:=20
0060:[<f8379d8d>] EFLAGS: 00010282 CPU: 0
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675618] EIP i=
s=20
at ceph_d_prune+0x1d/0x30 [ceph]
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675621] EAX:=20
00000000 EBX: ed311480 ECX: cdf35a4c EDX: cdf35a00
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675623] ESI:=20
ed3114e0 EDI: c8de4ccc EBP: f3e4bdec ESP: f3e4bdec
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675625]  DS:=20
007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675628]=20
Process kswapd0 (pid: 27, ti=3Df3e4a000 task=3Df3d45860 task.ti=3Df3e4a=
000)
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675630] Stack=
:
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675632]=20
f3e4bdfc c114503e ed311480 cdf35a00 f3e4be28 c1146bdf c8de5764 ed31164c
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675638]=20
cdf35a4c f3e4be44 ed3114cc ed17dbe0 f1b5ac00 f1b5ac80 eafb38e0 f3e4be58
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675644]=20
c114763e eafb38cc 00000000 f3e4be3c f3e4be3c f3e4be3c c91a5e60 ed3114e0
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675685] Call=20
Trace:
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675769]=20
[<c114503e>] dentry_lru_prune+0x6e/0x70
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675774]=20
[<c1146bdf>] shrink_dentry_list+0x14f/0x270
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675777]=20
[<c114763e>] prune_dcache_sb+0x10e/0x130
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675786]=20
[<c113584a>] prune_super+0xfa/0x160
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675790]=20
[<c10f6056>] shrink_slab+0x166/0x2e0
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675793]=20
[<c10f7c47>] ? shrink_zone+0x137/0x190
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675796]=20
[<c10f8074>] balance_pgdat+0x3d4/0x540
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675800]=20
[<c10f82d1>] kswapd+0xf1/0x1b0
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675803]=20
[<c10f81e0>] ? balance_pgdat+0x540/0x540
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675812]=20
[<c1069b8d>] kthread+0x6d/0x80
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675815]=20
[<c1069b20>] ? flush_kthread_worker+0x80/0x80
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675828]=20
[<c157e37e>] kernel_thread_helper+0x6/0x10
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675830] Code:=
=20
e5 3e 8d 74 26 00 b8 01 00 00 00 5d c3 90 55 89 e5 3e 8d 74 26 00 8b 50=
=20
10 85 d2 74 12 39 d0 74 0e 8b 40 0c 85 c0 74 07 8b 42 5c <f0> 80 20 fd=20
5d c3 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55 89
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675861] EIP:=20
[<f8379d8d>] ceph_d_prune+0x1d/0x30 [ceph] SS:ESP 0068:f3e4bdec
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675867] CR2:=20
0000000000000000
May  3 14:26:26 xs1.u13.univ-nantes.prive kernel: [222696.675872] ---[=20
end trace a7919e7f17c0a727 ]---



Retried on another machine with kvm 1.0 :

May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.962997] BUG:=20
unable to handle kernel NULL pointer dereference at   (null)
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963015] IP:=20
[<f882fd8d>] ceph_d_prune+0x1d/0x30 [ceph]
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963038] *pde =3D=
=20
7f686067
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963045] Oops:=20
0002 [#1] SMP
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963057] Module=
s=20
linked in: ceph libceph libcrc32c nfs lockd fscache auth_rpcgss nfs_acl=
=20
sunrpc zram(C) dm_crypt rfcomm bnep parport_pc bluetooth ppdev lp=20
parport mac_hid binfmt_misc psmouse serio_raw virtio_balloon i2c_piix4=20
nf_conntrack_ipv6 nf_conntrack nf_defrag_ipv6 floppy
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963084]
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963091] Pid:=20
27, comm: kswapd0 Tainted: G S      WC   3.2.0-24-generic #37-Ubuntu=20
Bochs Bochs
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963099] EIP:=20
0060:[<f882fd8d>] EFLAGS: 00010282 CPU: 0
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963104] EIP is=
=20
at ceph_d_prune+0x1d/0x30 [ceph]
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963106] EAX:=20
00000000 EBX: eb00cd00 ECX: eb26f4cc EDX: eb26f480
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963108] ESI:=20
eb00cd60 EDI: eb00cd60 EBP: f3e6ddec ESP: f3e6ddec
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963110]  DS:=20
007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963113] Proces=
s=20
kswapd0 (pid: 27, ti=3Df3e6c000 task=3Df3d45860 task.ti=3Df3e6c000)
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963114] Stack:
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963116]=20
f3e6ddfc c114503e eb00cd00 eb00cd4c f3e6de28 c1146c77 eb29a1fc eb26f4cc
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963124]=20
eb26f480 f3e6de44 eb00cd00 eb00cd60 ebdc3400 ebdc3480 e9908060 f3e6de58
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963129]=20
c114763e e990804c 00000000 f3e6de3c f3e6de3c f3e6de3c eb26f1e0 eb00cd60
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963134] Call T=
race:
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963164]=20
[<c114503e>] dentry_lru_prune+0x6e/0x70
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963169]=20
[<c1146c77>] shrink_dentry_list+0x1e7/0x270
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963172]=20
[<c114763e>] prune_dcache_sb+0x10e/0x130
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963179]=20
[<c113584a>] prune_super+0xfa/0x160
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963183]=20
[<c10f6056>] shrink_slab+0x166/0x2e0
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963190]=20
[<c10f7c47>] ? shrink_zone+0x137/0x190
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963193]=20
[<c10f8074>] balance_pgdat+0x3d4/0x540
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963196]=20
[<c10f82d1>] kswapd+0xf1/0x1b0
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963199]=20
[<c10f81e0>] ? balance_pgdat+0x540/0x540
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963207]=20
[<c1069b8d>] kthread+0x6d/0x80
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963210]=20
[<c1069b20>] ? flush_kthread_worker+0x80/0x80
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963223]=20
[<c157e37e>] kernel_thread_helper+0x6/0x10
May  3 15:59:43 xs1.u13.univ-nantes.prive kernel: [  178.963225] Code:=20
e5 3e 8d 74 26 00 b8 01 00 00 00 5d c3 90 55 89 e5 3e 8d 74 26 00 8b 50=
=20
10 85 d2 74 12 39 d0 74 0e 8b 40 0c 85 c0 74 07 8b 42 5c <f0> 80 20 fd=20
5d c3 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55 89
:


Is it something known ?

Cheers,

--=20
Yann Dupont - Service IRTS, DSI Universit=E9 de Nantes
Tel : 02.53.48.49.20 - Mail/Jabber : Yann.Dupont@univ-nantes.fr
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
