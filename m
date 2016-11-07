From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: mounting manila share with 4.8 kernel
Date: Mon, 7 Nov 2016 16:05:47 +0800
Message-ID: <3D900A86-68BD-49C3-A676-1E9AD6C65C29@redhat.com>
References: <CABZ+qqk8ucZodD=H=BAp4RySRLdNtD=+eneCWUO8xOYBYfupOg@mail.gmail.com>
 <CAOi1vP-N+5-5jFmqvbhY-VTfvG2=5ykiuEjD3EDGqnaPObrgsA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55616 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbcKGIFy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 7 Nov 2016 03:05:54 -0500
In-Reply-To: <CAOi1vP-N+5-5jFmqvbhY-VTfvG2=5ykiuEjD3EDGqnaPObrgsA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


> On 3 Nov 2016, at 18:02, Ilya Dryomov <idryomov@gmail.com> wrote:
> 
> On Wed, Nov 2, 2016 at 6:16 PM, Dan van der Ster <dan@vanderster.com> wrote:
>> Hi,
>> 
>> I'm not able to mount a manila created share with the 4.8.6 kernel.
>> AFAICT rados namespaces support was added in 4.8, but still I get a
>> weird error mounting:
>> 
>> # mount -t ceph
>> 188.184.80.24:6789:/volumes/_nogroup/bf476d31-32fa-444a-9f75-eb1da8039641
>> /mnt -o name=ricardo02,secret=xxxx==
>> mount: 188.184.80.24:6789:/volumes/_nogroup/bf476d31-32fa-444a-9f75-eb1da8039641
>> is write-protected, mounting read-only
>> mount: cannot mount
>> 188.184.80.24:6789:/volumes/_nogroup/bf476d31-32fa-444a-9f75-eb1da8039641
>> read-only
>> 
>> That user ricardo02 has namespace scoped caps:
>> 
>> client.ricardo02
>> key: xxx==
>> caps: [mds] allow rw path=/volumes/_nogroup/bf476d31-32fa-444a-9f75-eb1da8039641
>> caps: [mon] allow r
>> caps: [osd] allow rw pool=cephfs_data
>> namespace=fsvolumens_bf476d31-32fa-444a-9f75-eb1da8039641
>> 
>> I confirmed that I can mount with the super manila user:
>> 
>> # mount -t ceph 188.184.80.24:6789:/ /mnt -o name=manila,secret=xxx==
>> # ls /mnt/
>> volumes
>> 
>> Is there something I'm doing wrong with the kernel client, or are
>> these manila-created shares still not accessible with 4.8.6 ?
>> 
>> 
>> And BTW, randomly I tried mounting with the limited cap ricard02 user
>> at prefix / and got a kernel oops:
>> 
>> # mount -t ceph 188.184.80.24:6789:/ /mnt -o name=ricardo02,secret=xxx==
>> <hangs...>
>> 
>> [ 1119.856805] ------------[ cut here ]------------
>> [ 1119.857254] WARNING: CPU: 2 PID: 55 at fs/ceph/mds_client.c:2657
>> dispatch+0x5d4/0xa60 [ceph]
>> [ 1119.858058] Modules linked in: ceph libceph fscache
>> crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel lrw
>> gf128mul glue_helper ablk_helper cryptd ppdev cirrus ttm
>> drm_kms_helper joydev input_leds virtio_balloon drm parport_pc
>> syscopyarea sysfillrect parport sysimgblt fb_sys_fops i2c_piix4 pcspkr
>> acpi_cpufreq nfsd auth_rpcgss nfs_acl lockd grace ip_tables xfs
>> libcrc32c ata_generic pata_acpi virtio_blk virtio_net crc32c_intel
>> ata_piix virtio_pci virtio_ring virtio serio_raw libata floppy sunrpc
>> [ 1119.863023] CPU: 2 PID: 55 Comm: kworker/2:1 Not tainted
>> 4.8.6-1.el7.elrepo.x86_64 #1
>> [ 1119.863750] Hardware name: Fedora Project OpenStack Nova, BIOS
>> seabios-1.7.5-11.el7 04/01/2014
>> [ 1119.864552] Workqueue: ceph-msgr ceph_con_workfn [libceph]
>> [ 1119.865098]  0000000000000286 000000004eba1f8d ffff880208f57c30
>> ffffffff8135409f
>> [ 1119.865847]  0000000000000000 0000000000000000 ffff880208f57c70
>> ffffffff810817b1
>> [ 1119.866586]  00000a6108f57c50 ffff8802041ee100 000000000000000b
>> ffff880205b5a400
>> [ 1119.867359] Call Trace:
>> [ 1119.867589]  [<ffffffff8135409f>] dump_stack+0x63/0x84
>> [ 1119.868077]  [<ffffffff810817b1>] __warn+0xd1/0xf0
>> [ 1119.868518]  [<ffffffff810818ed>] warn_slowpath_null+0x1d/0x20
>> [ 1119.869078]  [<ffffffffa0487a74>] dispatch+0x5d4/0xa60 [ceph]
>> [ 1119.869610]  [<ffffffffa0408e3e>] try_read+0x9be/0x11a0 [libceph]
>> [ 1119.870207]  [<ffffffff810ba515>] ? put_prev_entity+0x35/0x730
>> [ 1119.872062]  [<ffffffffa04096ca>] ceph_con_workfn+0xaa/0x5d0 [libceph]
>> [ 1119.874021]  [<ffffffff8109ad82>] process_one_work+0x152/0x400
>> [ 1119.875888]  [<ffffffff8109b675>] worker_thread+0x125/0x4b0
>> [ 1119.877743]  [<ffffffff8109b550>] ? rescuer_thread+0x380/0x380
>> [ 1119.879552]  [<ffffffff810a1168>] kthread+0xd8/0xf0
>> [ 1119.881294]  [<ffffffff8173ad7f>] ret_from_fork+0x1f/0x40
>> [ 1119.883113]  [<ffffffff810a1090>] ? kthread_park+0x60/0x60
>> [ 1119.884960] ---[ end trace a512b13698936699 ]---
> 
> This is not an oops, just a warning.  I think it's fixed in 4.9 with
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=fcff415c9421b417ef91d48f546f3c4566ddc358.
> Can't try the caps right now though - Zheng?

Yes, the bug should be fixed by this commit

Regards
Yan, Zheng


> 
> Thanks,
> 
>                Ilya

