From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Kernel panic putting zpool on iSCSI LUN using bs_rbd
Date: Mon, 14 Oct 2013 14:25:56 -0700
Message-ID: <525C6164.8010604@inktank.com>
References: <8D091F096319428-1FE8-733B7@webmail-vm007.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43990 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757215Ab3JNV02 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Oct 2013 17:26:28 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld10so8053719pab.36
        for <ceph-devel@vger.kernel.org>; Mon, 14 Oct 2013 14:26:28 -0700 (PDT)
In-Reply-To: <8D091F096319428-1FE8-733B7@webmail-vm007.sysops.aol.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric Eastman <eric0e@aol.com>, ceph-devel@vger.kernel.org

On 10/07/2013 08:49 PM, Eric Eastman wrote:
> I am not sure if this is a bs_rbd, tgt or zfs issue, but I can reliably
> crash my Centos 6.4 system running tgt 1.0.40 using a bs_rbd backstore
> by creating a zpool.  Using tgt with a file backed store does not panic
> the system when creating a zpool.

Thanks for the report! I've added it to the tracker so it doesn't get
lost: http://tracker.ceph.com/issues/6548.

The difference in behavior suggests a bug in bs_rbd, but the fact that
it causes a crash in zfs is a separate problem in zfs imo.

Josh

> ZFS version from dmesg:    ZFS: Loaded module v0.6.2-1, ZFS pool version
> 5000, ZFS filesystem version 5
>
> The Centos system is working as the iSCSI target and initiator via
> localhost.  The ceph version is 0.67.3 on Centos, and all the monitors
> and OSDs are ceph 0.67.4 running on a Ubuntu 13.04 based cluster. I am
> not using the ceph krbd driver, but I am using the bs_rbd backstore from
> tgt-1.0.40
>
> tgtadm mapping commands for creating a rbd backed LUN and a file backed LUN
>
> # dd if=/dev/zero of=/tmp/ifile bs=1G count=10
> # tgtadm --lld iscsi --mode target --op new --tid 1 --targetname
> iqn.2013-10.rbd.keeper.1381182625
> # tgtadm --lld iscsi --op bind --mode target --tid $devicen -I ALL
> # tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1
> --backing-store  iscsi/iscsi-zfs-01 --bstype rbd
> # tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 2
> --bstype=rdwr --device-type=disk --backing-store=/tmp/ifile
>
> iscsi login to localhost
>
> # lsscsi
> [1:0:0:0]    cd/dvd  NECVMWar VMware IDE CDR10 1.00  /dev/sr0
> [2:0:0:0]    disk    VMware   Virtual disk     1.0   /dev/sda
> [3:0:0:0]    storage IET      Controller       0001  -
> [3:0:0:1]    disk    IET      VIRTUAL-DISK     0001  /dev/sdb
> [3:0:0:2]    disk    IET      VIRTUAL-DISK     0001  /dev/sdc
>
> To cause the panic:
>
> # parted -s /dev/sdb mklabel gpt
> # zpool create  test1  /dev/sdb
>
> System panics
>
> Try creating a zpool on an aligned partition:
> # parted --align=optimal -s  /dev/sdb  mklabel gpt mkpart primary --
> 8192s '-1'
> # zpool create test1 /dev/sdb1
>
> System panics
>
> Try XFS:
> # parted --align=optimal -s  /dev/sdb  mklabel gpt mkpart primary --
> 8192s '-1'
> # mkfs.xfs -q /dev/sdb1
> specified blocksize 4096 is less than device physical sector size 4194304
> switching to logical sector size 512
> # mkdir /XFS
> # mount /dev/sdb1 /XFS
>
> Creating a XFS file system, then writing/reading to it does not panic
> the systems
>
> Try ext4
> # umount /XFS
> # parted --align=optimal -s  /dev/sdb  mklabel gpt mkpart primary --
> 8192s '-1'
> #mkfs.ext4 -q /dev/sdb1
>
> # mkdir /EXT4
> # mount /dev/sdb1 /EXT4
>
> Creating a EXT4 file system, then writing/reading to it does not panic
> the systems
>
> Try ZFS on a file backed iSCSI LUN
>
> # parted -s /dev/sdc mklabel gpt
> # zpool create  test1  /dev/sdc
> # zfs create test1/fs1
> # df -h
> Filesystem            Size  Used Avail Use% Mounted on
> /dev/sda2              24G   16G  7.2G  69% /
> tmpfs                 1.7G   72K  1.7G   1% /dev/shm
> /dev/sdb1             241G  279M  228G   1% /EXT4
> test1                 9.8G  128K  9.8G   1% /test1
> test1/fs1             9.8G  128K  9.8G   1% /test1/fs1
>
> $ mount
> /dev/sda2 on / type ext4 (rw)
> proc on /proc type proc (rw)
> sysfs on /sys type sysfs (rw)
> devpts on /dev/pts type devpts (rw,gid=5,mode=620)
> tmpfs on /dev/shm type tmpfs (rw)
> none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
> sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
> /dev/sdb1 on /EXT4 type ext4 (rw)
> test1 on /test1 type zfs (rw,xattr)
> test1/fs1 on /test1/fs1 type zfs (rw,xattr)
>
> Creating a zpool and a zfs file system, on a file backed iSCSI LUN, then
> writing/reading to it, does not panic the system.
>
>
> Panic from zpool create on rbd:
> <6>eth0: NIC Link is Up 10000 Mbps
> <6>microcode: CPU0 sig=0x106a4, pf=0x1, revision=0x70d
> <6>platform microcode: firmware: requesting intel-ucode/06-1a-04
> <6>Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter
> Oruba
> <5>sr 1:0:0:0: Attached scsi generic sg0 type 5
> <5>sd 2:0:0:0: Attached scsi generic sg1 type 0
> <6>parport_pc 00:09: reported by Plug and Play ACPI
> <6>parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
> <6>ppdev: user-space parallel port driver
> <6>tun: Universal TUN/TAP device driver, 1.6
> <6>tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
> <6>Adding 8388600k swap on /dev/sda1.  Priority:-1 extents:1
> across:8388600k
> <5>SPL: Loaded module v0.6.2-1
> <4>zunicode: module license 'CDDL' taints kernel.
> <4>Disabling lock debugging due to kernel taint
> <5>ZFS: Loaded module v0.6.2-1, ZFS pool version 5000, ZFS filesystem
> version 5
> <5>SPL: using hostid 0x00000000
> <6>Loading iSCSI transport class v2.0-870.
> <5>iscsi: registered transport (tcp)
> <6>NET: Registered protocol family 10
> <6>lo: Disabled Privacy Extensions
> <5>iscsi: registered transport (iser)
> <6>libcxgbi:libcxgbi_init_module: tag itt 0x1fff, 13 bits, age 0xf, 4 bits.
> <6>libcxgbi:ddp_setup_host_page_size: system PAGE 4096, ddp idx 0.
> <6>Chelsio T3 iSCSI Driver cxgb3i v2.0.0 (Jun. 2010)
> <5>iscsi: registered transport (cxgb3i)
> <6>Chelsio T4 iSCSI Driver cxgb4i v0.9.1 (Aug. 2010)
> <5>iscsi: registered transport (cxgb4i)
> <6>cnic: Broadcom NetXtreme II CNIC Driver cnic v2.5.13 (Sep 07, 2012)
> <6>Broadcom NetXtreme II iSCSI Driver bnx2i v2.7.2.2 (Apr 26, 2012)
> <5>iscsi: registered transport (bnx2i)
> <5>iscsi: registered transport (be2iscsi)
> <6>In beiscsi_module_init, tt=ffffffffa0591760
> <6>eth0: intr type 3, mode 0, 2 vectors allocated
> <6>eth0: NIC Link is Up 10000 Mbps
> <6>scsi3 : iSCSI Initiator over TCP/IP
> <5>scsi 3:0:0:0: RAID              IET      Controller       0001 PQ: 0
> ANSI: 5
> <5>scsi 3:0:0:0: Attached scsi generic sg2 type 12
> <5>scsi 3:0:0:1: Direct-Access     IET      VIRTUAL-DISK     0001 PQ: 0
> ANSI: 5
> <5>sd 3:0:0:1: Attached scsi generic sg3 type 0
> <5>scsi 3:0:0:2: Direct-Access     IET      VIRTUAL-DISK     0001 PQ: 0
> ANSI: 5
> <5>sd 3:0:0:2: Attached scsi generic sg4 type 0
> <5>sd 3:0:0:1: [sdb] 512000000 512-byte logical blocks: (262 GB/244 GiB)
> <5>sd 3:0:0:1: [sdb] 4194304-byte physical blocks
> <5>sd 3:0:0:1: [sdb] Write Protect is off
> <7>sd 3:0:0:1: [sdb] Mode Sense: 69 00 00 08
> <5>sd 3:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> <6> sdb:
> <5>sd 3:0:0:2: [sdc] 20971520 512-byte logical blocks: (10.7 GB/10.0 GiB)
> <5>sd 3:0:0:2: [sdc] 4096-byte physical blocks
> <5>sd 3:0:0:2: [sdc] Write Protect is off
> <7>sd 3:0:0:2: [sdc] Mode Sense: 69 00 00 08
> <5>sd 3:0:0:2: [sdc] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> <6> sdc: unknown partition table
> <5>sd 3:0:0:2: [sdc] Attached SCSI disk
> <4> sdb1
> <5>sd 3:0:0:1: [sdb] Attached SCSI disk
> <6>802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
> <6>All bugs added by David S. Miller <davem@redhat.com>
> <6>8021q: adding VLAN 0 to HW filter on device eth0
> <6>RPC: Registered named UNIX socket transport module.
> <6>RPC: Registered udp transport module.
> <6>RPC: Registered tcp transport module.
> <6>RPC: Registered tcp NFSv4.1 backchannel transport module.
> <5>Bridge firewalling registered
> <6>device virbr0-nic entered promiscuous mode
> <6>virbr0: starting userspace STP failed, starting kernel STP
> <6>ip_tables: (C) 2000-2006 Netfilter Core Team
> <4>nf_conntrack version 0.5.0 (16384 buckets, 65536 max)
> <6>Ebtables v2.0 registered
> <6>ip6_tables: (C) 2000-2006 Netfilter Core Team
> <6>lo: Disabled Privacy Extensions
> <7>eth0: no IPv6 routers present
> <6> sdb:
> <6> sdb: sdb1 sdb9
> <6> sdb:
> <6> sdb: sdb1 sdb9
> <6> sdb:
> <6> sdb: sdb1 sdb9
> <4>general protection fault: 0000 [#1] SMP
> <4>last sysfs file:
> /sys/devices/platform/host3/session1/target3:0:0/3:0:0:1/block/sdb/dev
> <4>CPU 0
> <4>Modules linked in: ip6table_filter ip6_tables ebtable_nat ebtables
> ipt_MASQUERADE iptable_nat nf_nat nf_conntrack_ipv4 nf_defrag_ipv4
> xt_state nf_conntrack ipt_REJECT xt_CHECKSUM iptable_mangle
> iptable_filter ip_tables bridge autofs4 sunrpc 8021q garp stp llc
> be2iscsi iscsi_boot_sysfs bnx2i cnic uio cxgb4i cxgb4 cxgb3i libcxgbi
> cxgb3 mdio ib_iser rdma_cm ib_cm iw_cm ib_sa ib_mad ib_core ib_addr ipv6
> iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi zfs(P)(U)
> zcommon(P)(U) znvpair(P)(U) zavl(P)(U) zunicode(P)(U) spl(U)
> zlib_deflate vhost_net macvtap macvlan tun uinput ppdev parport_pc
> parport sg microcode vmware_balloon vmxnet3 i2c_piix4 i2c_core shpchp
> ext4 jbd2 mbcache sd_mod crc_t10dif sr_mod cdrom vmw_pvscsi pata_acpi
> ata_generic ata_piix dm_mirror dm_region_hash dm_log dm_mod [last
> unloaded: scsi_wait_scan]
> <4>
> <4>Pid: 4401, comm: vdev_open/0 Tainted: P           ---------------
> 2.6.32-358.18.1.el6.x86_64 #1 VMware, Inc. VMware Virtual Platform/440BX
> Desktop Reference Platform
> <4>RIP: 0010:[<ffffffffa0185f4e>]  [<ffffffffa0185f4e>]
> spl_kmem_cache_alloc+0x4e/0xf90 [spl]
> <4>RSP: 0018:ffff8801263f3b60  EFLAGS: 00010246
> <4>RAX: 0002007400015bfe RBX: 000200740000db9e RCX: 0000000000000016
> <4>RDX: 00000000003fffff RSI: 0000000000000230 RDI: 000200740000db9e
> <4>RBP: ffff8801263f3c70 R08: ffff88013be072f0 R09: 0000000000000000
> <4>R10: ffff8801263f3b70 R11: 0000000000000000 R12: ffff88013c528000
> <4>R13: 0000000000400000 R14: 0000000000000230 R15: ffff8801263f1500
> <4>FS:  0000000000000000(0000) GS:ffff88002c200000(0000)
> knlGS:0000000000000000
> <4>CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> <4>CR2: 0000003a37c221d8 CR3: 0000000139e3b000 CR4: 00000000000007f0
> <4>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> <4>DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> <4>Process vdev_open/0 (pid: 4401, threadinfo ffff8801263f2000, task
> ffff8801263f1500)
> <4>Stack:
> <4> ffff88013ce28040 ffff88013ce28090 0000000000000000 ffff8801263f1500
> <4><d> ffffffff81096da0 ffff8801263f3b88 ffff8801263f3b88 ffff88013a0780b0
> <4><d> ffff88013a078040 ffff88013be07200 ffff8801263f3bd0 ffff88013be07200
> <4>Call Trace:
> <4> [<ffffffff81096da0>] ? autoremove_wake_function+0x0/0x40
> <4> [<ffffffffa030293f>] ? zio_add_child+0xef/0x110 [zfs]
> <4> [<ffffffffa018a8f4>] ? taskq_init_ent+0x34/0x80 [spl]
> <4> [<ffffffff8150f61e>] ? mutex_lock+0x1e/0x50
> <4> [<ffffffffa03004e3>] ? zio_wait_for_children+0x63/0x80 [zfs]
> <4> [<ffffffffa0301de3>] zio_buf_alloc+0x23/0x30 [zfs]
> <4> [<ffffffffa0301fb4>] zio_vdev_io_start+0x144/0x2e0 [zfs]
> <4> [<ffffffffa0302a13>] zio_nowait+0xb3/0x170 [zfs]
> <4> [<ffffffffa02bfe7a>] vdev_probe+0x12a/0x210 [zfs]
> <4> [<ffffffffa02c0f40>] ? vdev_probe_done+0x0/0x250 [zfs]
> <4> [<ffffffffa02dc0c5>] ? zfs_post_state_change+0x15/0x20 [zfs]
> <4> [<ffffffffa02c0200>] vdev_open+0x2a0/0x450 [zfs]
> <4> [<ffffffffa02c0f26>] vdev_open_child+0x26/0x40 [zfs]
> <4> [<ffffffffa018a628>] taskq_thread+0x218/0x4b0 [spl]
> <4> [<ffffffff8150e130>] ? thread_return+0x4e/0x76e
> <4> [<ffffffff81063410>] ? default_wake_function+0x0/0x20
> <4> [<ffffffffa018a410>] ? taskq_thread+0x0/0x4b0 [spl]
> <4> [<ffffffff81096a36>] kthread+0x96/0xa0
> <4> [<ffffffff8100c0ca>] child_rip+0xa/0x20
> <4> [<ffffffff810969a0>] ? kthread+0x0/0xa0
> <4> [<ffffffff8100c0c0>] ? child_rip+0x0/0x20
> <4>Code: 00 f6 05 1d 34 01 00 01 48 89 fb 41 89 f6 74 0d f6 05 07 34 01
> 00 08 0f 85 70 01 00 00 48 8d 83 60 80 00 00 48 89 85 70 ff ff ff <3e>
> ff 83 60 80 00 00 9c 58 0f 1f 44 00 00 49 89 c7 fa 66 0f 1f
> <1>RIP  [<ffffffffa0185f4e>] spl_kmem_cache_alloc+0x4e/0xf90 [spl]
> <4> RSP <ffff8801263f3b60>
>
> Kernel
> # cat /proc/version
> Linux version 2.6.32-358.18.1.el6.x86_64
> (mockbuild@c6b10.bsys.dev.centos.org) (gcc version 4.4.7 20120313 (Red
> Hat 4.4.7-3) (GCC) ) #1 SMP Wed Aug 28 17:19:38 UTC 2013
>
> Regards,
>
> Eric Eastman

