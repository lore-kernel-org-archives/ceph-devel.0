From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: [ceph-users] kernel BUG at fs/ceph/inode.c:1197
Date: Thu, 4 May 2017 09:27:19 +1000
Message-ID: <CAF-wwdFCVC2yiWi_3RG0K8KTB5ykc6cheLk=sCCiUNZWB27NdQ@mail.gmail.com>
References: <7f55f708-0d47-0203-96df-5880bda43e8f@fasthosts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:37582 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdECX1V (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 May 2017 19:27:21 -0400
Received: by mail-it0-f44.google.com with SMTP id x188so2453898itb.0
        for <ceph-devel@vger.kernel.org>; Wed, 03 May 2017 16:27:20 -0700 (PDT)
In-Reply-To: <7f55f708-0d47-0203-96df-5880bda43e8f@fasthosts.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Ceph Users <ceph-users@lists.ceph.com>

+ceph-devel

On Thu, May 4, 2017 at 12:51 AM, James Poole <james.poole@fasthosts.com> wrote:
> Hello,
>
> We currently have a ceph cluster supporting an Openshift cluster using
> cephfs and dynamic rbd provisioning. The client nodes appear to be
> triggering a kernel bug and are rebooting unexpectedly with the same message
> each time. Clients are running CentOS 7:
>
>       KERNEL: /usr/lib/debug/lib/modules/3.10.0-514.10.2.el7.x86_64/vmlinux
>     DUMPFILE: /var/crash/127.0.0.1-2017-05-02-09:06:17/vmcore  [PARTIAL
> DUMP]
>         CPUS: 16
>         DATE: Tue May  2 09:06:15 2017
>       UPTIME: 00:43:14
> LOAD AVERAGE: 1.52, 1.40, 1.48
>        TASKS: 7408
>     NODENAME: [redacted]
>      RELEASE: 3.10.0-514.10.2.el7.x86_64
>      VERSION: #1 SMP Fri Mar 3 00:04:05 UTC 2017
>      MACHINE: x86_64  (1997 Mhz)
>       MEMORY: 32 GB
>        PANIC: "kernel BUG at fs/ceph/inode.c:1197!"
>          PID: 133
>      COMMAND: "kworker/1:1"
>         TASK: ffff8801399bde20  [THREAD_INFO: ffff880138d0c000]
>          CPU: 1
>        STATE: TASK_RUNNING (PANIC)
>
> [ 2596.061470] ------------[ cut here ]------------
> [ 2596.061499] kernel BUG at fs/ceph/inode.c:1197!
> [ 2596.061516] invalid opcode: 0000 [#1] SMP
> [ 2596.061535] Modules linked in: cfg80211 rfkill binfmt_misc veth ext4
> mbcache jbd2 rbd xt_statistic xt_nat xt_recent ipt_REJECT nf_reject_ipv4
> xt_mark ipt_MASQUERADE nf_nat_masquerad
> e_ipv4 xt_addrtype br_netfilter bridge stp llc dm_thin_pool
> dm_persistent_data dm_bio_prison dm_bufio loop fuse ceph libceph
> dns_resolver vport_vxlan vxlan ip6_udp_tunnel udp_tunnel op
> envswitch nf_conntrack_ipv6 nf_nat_ipv6 nf_defrag_ipv6 iptable_nat
> nf_nat_ipv4 nf_nat xt_limit nf_log_ipv4 vmw_vsock_vmci_transport
> nf_log_common xt_LOG vsock nf_conntrack_ipv4 nf_defr
> ag_ipv4 xt_comment xt_multiport xt_conntrack nf_conntrack iptable_filter
> intel_powerclamp coretemp iosf_mbi crc32_pclmul ghash_clmulni_intel
> aesni_intel lrw gf128mul glue_helper ablk_h
> elper cryptd ppdev vmw_balloon pcspkr sg vmw_vmci shpchp i2c_piix4
> parport_pc
> [ 2596.061875]  parport nfsd nfs_acl lockd auth_rpcgss grace sunrpc
> ip_tables xfs libcrc32c sr_mod cdrom sd_mod crc_t10dif crct10dif_generic
> ata_generic pata_acpi vmwgfx drm_kms_helper
>  syscopyarea sysfillrect sysimgblt fb_sys_fops ttm crct10dif_pclmul
> crct10dif_common mptspi crc32c_intel drm ata_piix scsi_transport_spi
> serio_raw mptscsih libata mptbase vmxnet3 i2c_c
> ore fjes dm_mirror dm_region_hash dm_log dm_mod
> [ 2596.062042] CPU: 1 PID: 133 Comm: kworker/1:1 Not tainted
> 3.10.0-514.10.2.el7.x86_64 #1
> [ 2596.062070] Hardware name: VMware, Inc. VMware Virtual Platform/440BX
> Desktop Reference Platform, BIOS 6.00 09/17/2015
> [ 2596.062118] Workqueue: ceph-msgr ceph_con_workfn [libceph]
> [ 2596.062140] task: fffdf8801399be20 ti: ffff880138d0c000 task.ti:
> ffff880138d0c000
> [ 2596.062166] RIP: 0010:[<ffffffffa05d96c3>]  [<ffffffffa05d96c3>]
> ceph_fill_trace+0x893/0xa00 [ceph]
> [ 2596.062209] RSP: 0000:ffff880138d0fb80  EFLAGS: 00010287
> [ 2596.062230] RAX: ffff88083b079680 RBX: ffff8801efe86760 RCX:
> ffff880095e26c00
> [ 2596.062257] RDX: ffff880003e8f2c0 RSI: ffff88053b4c0a08 RDI:
> ffff88053b4c0a00
> [ 2596.062288] RBP: ffff880138d0fbf8 R08: ffff880003e8f2c0 R09:
> 0000000000000000
> [ 2596.062320] R10: 0000000000000001 R11: ffff8804256f3ac0 R12:
> ffff880121d15400
> [ 2596.062351] R13: ffff880138dd4000 R14: ffff88007053f280 R15:
> ffff8807ee10f2c0
> [ 2596.062379] FS:  0000000000000000(0000) GS:ffff88013b840000(0000)
> knlGS:0000000000000000
> [ 2596.062413] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [ 2596.062436] CR2: 00007fe3bab2dcd0 CR3: 000000042ebe0000 CR4:
> 00000000001407e0
> [ 2596.062498] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [ 2596.062540] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
> 0000000000000400
> [ 2596.062567] Stack:
> [ 2596.062578]  ffff880121d15778 ffff880121d15718 ffff880138d0fc50
> ffff880095e26e7a
> [ 2596.062612]  ffff880035c12400 ffff88053b4c7800 000000003b4c0800
> ffff880138d0fbb8
> [ 2596.062645]  ffff880138d0fbb8 00000000a5446715 ffff88053b4c0800
> ffff88008238ee10
> [ 2596.062681] Call Trace:
> [ 2596.062703]  [<ffffffffa05f96a8>] handle_reply+0x3e8/0xc80 [ceph]
> [ 2596.062736]  [<ffffffffa05fbd39>] dispatch+0xd9/0xaf0 [ceph]
> [ 2596.062762]  [<ffffffff815559ca>] ? kernel_recvmsg+0x3a/0x50
> [ 2596.062790]  [<ffffffffa057ceff>] try_read+0x4bf/0x1220 [libceph]
> [ 2596.062819]  [<ffffffffa057b743>] ? try_write+0xa13/0xe60 [libceph]
> [ 2596.062851]  [<ffffffffa057dd19>] ceph_con_workfn+0xb9/0x650 [libceph]
> [ 2596.062878]  [<ffffffff810a810b>] process_one_work+0x17b/0x470
> [ 2596.062902]  [<ffffffff810a8f46>] worker_thread+0x126/0x410
> [ 2596.062925]  [<ffffffff810a8e20>] ? rescuer_thread+0x460/0x460
> [ 2596.062949]  [<ffffffff810b06ff>] kthread+0xcf/0xe0
> [ 2596.064014]  [<ffffffff810b0630>] ? kthread_create_on_node+0x140/0x140
> [ 2596.065010]  [<ffffffff81696a58>] ret_from_fork+0x58/0x90
> [ 2596.065955]  [<ffffffff810b0630>] ? kthread_create_on_node+0x140/0x140
> [ 2596.066945] Code: e8 c3 2b d6 e0 e9 ca fa ff ff 4c 89 fa 48 c7 c6 07 d0
> 60 a0 48 c7 c7 50 24 61 a0 31 c0 e8 a6 2b d6 e0 e9 cd fa ff ff 0f 0b 0f 0b
> <0f> 0b 0f 0b 48 8b 83 c8 fc ff ff
>  4c 8b 89 c8 fc ff ff 4c 89 fa
> [ 2596.069127] RIP  [<ffffffffa05d96c3>] ceph_fill_trace+0x893/0xa00 [ceph]
> [ 2596.070120]  RSP <ffff880138d0fb80>
>
>
> Just before the above there are lots of messages similar to this from all
> ceph node ips:
> [  933.282441] [IPTABLES:INPUT] dropped IN=eno33557248 OUT=
> MAC=00:50:56:0f:9a:47:00:50:56:35:28:f1:08:00 SRC=192.168.5.6
> DST=192.168.3.2 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=20778 DF P
> ROTO=TCP SPT=6816 DPT=47140 WINDOW=2406 RES=0x00 ACK FIN URGP=0
> [  933.922440] [IPTABLES:INPUT] dropped IN=eno33557248 OUT=
> MAC=00:50:56:0f:9a:47:00:50:56:35:28:f1:08:00 SRC=192.168.5.6
> DST=192.168.3.2 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=1440 DF PR
> OTO=TCP SPT=6800 DPT=56290 WINDOW=2889 RES=0x00 ACK FIN URGP=0
> [  934.031555] [IPTABLES:INPUT] dropped IN=eno33557248 OUT=
> MAC=00:50:56:0f:9a:47:00:50:56:26:f3:39:08:00 SRC=192.168.5.7
> DST=192.168.3.2 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=58232 DF P
> ROTO=TCP SPT=6812 DPT=59564 WINDOW=8433 RES=0x00 ACK FIN URGP=0
> [  934.031579] [IPTABLES:INPUT] dropped IN=eno33557248 OUT=
> MAC=00:50:56:0f:9a:47:00:50:56:26:f3:39:08:00 SRC=192.168.5.7
> DST=192.168.3.2 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=20084 DF P
> ROTO=TCP SPT=6816 DPT=55574 WINDOW=2925 RES=0x00 ACK FIN URGP=0
> [  934.105440] [IPTABLES:INPUT] dropped IN=eno33557248 OUT=
> MAC=00:50:56:0f:9a:47:00:50:56:37:f8:4c:08:00 SRC=192.168.5.4
> DST=192.168.3.2 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=48428 DF P
> ROTO=TCP SPT=6804 DPT=59156 WINDOW=6422 RES=0x00 ACK FIN URGP=0
> [  935.133060] [IPTABLES:INPUT] dropped IN=eno33557248 OUT=
> MAC=00:50:56:0f:9a:47:00:50:56:0d:13:27:08:00 SRC=192.168.5.3
> DST=192.168.3.2 LEN=52 TOS=0x00 PREC=0x00 TTL=64 ID=35384 DF P
> ROTO=TCP SPT=6817 DPT=52674 WINDOW=24576 RES=0x00 ACK FIN URGP=0
>
> Many thanks
>
> James
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
Cheers,
Brad
