From: Niklas Goerke <niklas@niklasgoerke.de>
Subject: Re: xfs Warnings in syslog
Date: Fri, 08 Nov 2013 13:47:40 +0100
Message-ID: <5c1ac60220546b99bf67bfed8f200fff@niklasgoerke.de>
References: <049e1508cbb35ecf7b38ea2dadddc6ec@niklasgoerke.de>
 <52666FA8.4050101@oracle.com>
 <CABYiri8CThqQ-E0MvB4=XbOt7jrQG_nw_2Sc7vt0VD_zbr_Ycw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from niklasgoerke.de ([46.38.232.61]:51345 "EHLO niklasgoerke.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126Ab3KHMro (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 8 Nov 2013 07:47:44 -0500
In-Reply-To: <CABYiri8CThqQ-E0MvB4=XbOt7jrQG_nw_2Sc7vt0VD_zbr_Ycw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Jeff Liu <jeff.liu@oracle.com>, ceph-devel <ceph-devel@vger.kernel.org>, xfs@oss.sgi.com

I'm sorry for reporting back only now, but I did not get to try it out=20
earlier.
I upgraded one of my nodes to kernel 3.10 and the messages did not come=
=20
up yet. It seems the kernel upgrade did the job.

Thank you very much for your help!

On Tue, 22 Oct 2013 13:36:56 +0100, Andrey Korolyov wrote:
> Just my two cents:
>
> XFS is a quite unstable with Ceph especially along with heavy CPU
> usage up to 3.7(primarily soft lockups). I used 3.7 for eight months
> before upgrade on production system and it performs just perfectly.
>
> On Tue, Oct 22, 2013 at 1:29 PM, Jeff Liu <jeff.liu@oracle.com>=20
> wrote:
>> Hello,
>>
>> So It's better to add XFS mailing list to the CC-list. :)
>>
>> I think this issue has been fixed by upstream commits:
>>
>> From ff9a28f6c25d18a635abcab1f49db68108203dfb
>> From: Jan Kara <jack@suse.cz>
>> Date: Thu, 14 Mar 2013 14:30:54 +0100
>> Subject: [PATCH 1/1] xfs: Fix WARN_ON(delalloc) in=20
>> xfs_vm_releasepage()
>>
>>
>> Thanks,
>> -Jeff
>>
>> On 10/22/2013 07:46 PM, Niklas Goerke wrote:
>>
>>> Hi
>>>
>>> My syslog and dmesg are being filled with the Warnings attached.
>>> Looking at todays syslog I got up to 1101 of these warnings in the=20
>>> time
>>> from 10:50 to 11:13 (and only in that time, else the log was=20
>>> clean). I
>>> found them on all four of my OSD hosts, all at about the same time.
>>> I'm running kernel 3.2.0-4-amd64 on a debian 7.0. Ceph is on=20
>>> version
>>> 0.67.4. I have got 15 OSDs per OSD Host.
>>>
>>> Ceph does not really seem to care about this, so I'm not sure what=20
>>> it is
>>> all about=E2=80=A6
>>> Still they are warnings in syslog and I hope you guys can tell me=20
>>> what
>>> went wrong here and what I can do about it?
>>>
>>> Thank you
>>> Niklas
>>>
>>>
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388018] ------------[=
=20
>>> cut
>>> here ]------------
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388030] WARNING: at
>>> /build/linux-s5x2oE/linux-3.2.46/fs/xfs/xfs_aops.c:1091
>>> xfs_vm_releasepage+0x76/0x8e [xfs]()
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388034] Hardware=20
>>> name:
>>> X9DR3-F
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388036] Modules=20
>>> linked in:
>>> xfs autofs4 nfsd nfs nfs_acl auth_rpcgss fscache lockd sunrpc ext3=20
>>> jbd
>>> loop acpi_cpufreq mperf coretemp crc32c_intel ghash_clmulni_intel
>>> snd_pcm aesni_intel snd_page_alloc aes_x86_64 snd_timer aes_generic=
=20
>>> s
>>> nd cryptd soundcore pcspkr sb_edac joydev evdev edac_core iTCO_wdt
>>> i2c_i801 iTCO_vendor_support i2c_core ioatdma processor thermal_sys
>>> container button ext4 crc16 jbd2 mbcache usbhid hid ses enclosure=20
>>> sg
>>> sd_mod crc_t10dif megaraid_sas ehci_hcd usbcore isci libsas=20
>>> usb_common liba
>>> ta ixgbe mdio scsi_transport_sas scsi_mod igb dca [last unloaded:
>>> scsi_wait_scan]
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388093] Pid: 3459605,
>>> comm: ceph-osd Tainted: G        W    3.2.0-4-amd64 #1 Debian=20
>>> 3.2.46-1
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388096] Call Trace:
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388102]
>>> [<ffffffff81046b75>] ? warn_slowpath_common+0x78/0x8c
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388115]
>>> [<ffffffffa048b98c>] ? xfs_vm_releasepage+0x76/0x8e [xfs]
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388122]
>>> [<ffffffff810bedc5>] ? invalidate_inode_page+0x5e/0x80
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388129]
>>> [<ffffffff810bee5d>] ? invalidate_mapping_pages+0x76/0x102
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388135]
>>> [<ffffffff810b7b83>] ? sys_fadvise64_64+0x19f/0x1e2
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388140]
>>> [<ffffffff81353b52>] ? system_call_fastpath+0x16/0x1b
>>> Oct 22 11:11:19 cs-bigfoot06 kernel: [9744648.388144] ---[ end=20
>>> trace
>>> e9640ed6f82f066d ]---
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe=20
>>> ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe=20
>> ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
=20
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
