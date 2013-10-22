From: Jeff Liu <jeff.liu@oracle.com>
Subject: Re: xfs Warnings in syslog
Date: Tue, 22 Oct 2013 20:29:28 +0800
Message-ID: <52666FA8.4050101@oracle.com>
References: <049e1508cbb35ecf7b38ea2dadddc6ec@niklasgoerke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:25726 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab3JVM2e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Oct 2013 08:28:34 -0400
In-Reply-To: <049e1508cbb35ecf7b38ea2dadddc6ec@niklasgoerke.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Niklas Goerke <niklas@niklasgoerke.de>
Cc: ceph-devel@vger.kernel.org, "xfs@oss.sgi.com" <xfs@oss.sgi.com>

Hello,

So It's better to add XFS mailing list to the CC-list. :)

I think this issue has been fixed by upstream commits:

=46rom ff9a28f6c25d18a635abcab1f49db68108203dfb
=46rom: Jan Kara <jack@suse.cz>
Date: Thu, 14 Mar 2013 14:30:54 +0100
Subject: [PATCH 1/1] xfs: Fix WARN_ON(delalloc) in xfs_vm_releasepage()


Thanks,
-Jeff

On 10/22/2013 07:46 PM, Niklas Goerke wrote:

> Hi
>=20
> My syslog and dmesg are being filled with the Warnings attached.
> Looking at todays syslog I got up to 1101 of these warnings in the ti=
me
> from 10:50 to 11:13 (and only in that time, else the log was clean). =
I
> found them on all four of my OSD hosts, all at about the same time.
> I'm running kernel 3.2.0-4-amd64 on a debian 7.0. Ceph is on version
> 0.67.4. I have got 15 OSDs per OSD Host.
>=20
> Ceph does not really seem to care about this, so I'm not sure what it=
 is
> all about=E2=80=A6
> Still they are warnings in syslog and I hope you guys can tell me wha=
t
> went wrong here and what I can do about it?
>=20
> Thank you
> Niklas
>=20
>=20
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388018] ------------[ c=
ut
> here ]------------
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388030] WARNING: at
> /build/linux-s5x2oE/linux-3.2.46/fs/xfs/xfs_aops.c:1091
> xfs_vm_releasepage+0x76/0x8e [xfs]()
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388034] Hardware name:
> X9DR3-F
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388036] Modules linked =
in:
> xfs autofs4 nfsd nfs nfs_acl auth_rpcgss fscache lockd sunrpc ext3 jb=
d
> loop acpi_cpufreq mperf coretemp crc32c_intel ghash_clmulni_intel
> snd_pcm aesni_intel snd_page_alloc aes_x86_64 snd_timer aes_generic s
> nd cryptd soundcore pcspkr sb_edac joydev evdev edac_core iTCO_wdt
> i2c_i801 iTCO_vendor_support i2c_core ioatdma processor thermal_sys
> container button ext4 crc16 jbd2 mbcache usbhid hid ses enclosure sg
> sd_mod crc_t10dif megaraid_sas ehci_hcd usbcore isci libsas usb_commo=
n liba
> ta ixgbe mdio scsi_transport_sas scsi_mod igb dca [last unloaded:
> scsi_wait_scan]
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388093] Pid: 3459605,
> comm: ceph-osd Tainted: G        W    3.2.0-4-amd64 #1 Debian 3.2.46-=
1
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388096] Call Trace:
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388102]=20
> [<ffffffff81046b75>] ? warn_slowpath_common+0x78/0x8c
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388115]=20
> [<ffffffffa048b98c>] ? xfs_vm_releasepage+0x76/0x8e [xfs]
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388122]=20
> [<ffffffff810bedc5>] ? invalidate_inode_page+0x5e/0x80
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388129]=20
> [<ffffffff810bee5d>] ? invalidate_mapping_pages+0x76/0x102
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388135]=20
> [<ffffffff810b7b83>] ? sys_fadvise64_64+0x19f/0x1e2
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388140]=20
> [<ffffffff81353b52>] ? system_call_fastpath+0x16/0x1b
> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388144] ---[ end trace
> e9640ed6f82f066d ]---
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
