From: Christian Brunner <chb@muc.de>
Subject: Re: AW: ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd))
Date: Fri, 5 Nov 2010 13:40:39 +0100
Message-ID: <AANLkTi=2=oaobOtwacs8EZRGnBRzctShTFPs_2E-_gcq@mail.gmail.com>
References: <AANLkTikqk0KDAKRt=ED4-HCzKiUw9jhew+tyaZe1TGOM@mail.gmail.com>
	<vmime.4cc726f3.18e0.7333b92e48c27b02@lvps80-237-162-219.dedicated.hosteurope.de>
	<Pine.LNX.4.64.1011032332300.32503@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58295 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754246Ab0KEMkk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Nov 2010 08:40:40 -0400
Received: by gxk23 with SMTP id 23so2112025gxk.19
        for <ceph-devel@vger.kernel.org>; Fri, 05 Nov 2010 05:40:40 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1011032332300.32503@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Christian Brunner <christian@brunner-muc.de>, ceph-devel@vger.kernel.org

Hi Sage,

I'm sorry, I was busy with some other things, but I was able to look
at this now:

Now I can confirm that the problem is related to a missing osd, as I
had to stop one of the osds to reproduce it. When I split up the two
asserts, the error occurs in:

=2E/osd/OSDMap.h:460: FAILED assert(exists(osd))

and here is the gdb backtrace:

#0  0x0000003c0c0329b5 in raise () from /lib64/libc.so.6
#1  0x0000003c0c034195 in abort () from /lib64/libc.so.6
#2  0x0000003c110beaad in __gnu_cxx::__verbose_terminate_handler() ()
   from /usr/lib64/libstdc++.so.6
#3  0x0000003c110bcc36 in ?? () from /usr/lib64/libstdc++.so.6
#4  0x0000003c110bcc63 in std::terminate() () from /usr/lib64/libstdc++=
=2Eso.6
#5  0x0000003c110bcd5e in __cxa_throw () from /usr/lib64/libstdc++.so.6
#6  0x00007ffc36df6136 in ceph::__ceph_assert_fail (
    assertion=3D0x7ffc36e22c59 "exists(osd)", file=3D<value optimized o=
ut>,
    line=3D460, func=3D<value optimized out>) at common/assert.cc:30
#7  0x00007ffc36d8014f in OSDMap::get_inst (this=3D<value optimized out=
>,
    osd=3D<value optimized out>) at osd/OSDMap.h:460
#8  0x00007ffc36d7b4c2 in Objecter::op_submit (this=3D0x159a4a0,
    op=3D0x7ffb29e264c0) at osdc/Objecter.cc:461
#9  0x00007ffc36d4bdc9 in Objecter::write (this=3D0x159a4a0, oid=3D...,=
 ol=3D...,
    off=3D<value optimized out>, len=3D1638400, snapc=3D..., bl=3D..., =
mtime=3D...,
    onack=3D0x7ffc00811d20, oncommit=3D0x7ffc000461a0, flags=3D0)
    at osdc/Objecter.h:606
#10 0x00007ffc36d4d24b in RadosClient::aio_write (this=3D0x15916e0, poo=
l=3D...,
    oid=3D..., off=3D917504, bl=3D..., len=3D1638400, c=3D0x7ffc03d4c01=
0)
    at librados.cc:949
#11 0x00007ffc36d4d41a in rados_aio_write (pool=3D0x159a000,
    o=3D<value optimized out>, off=3D917504, buf=3D<value optimized out=
>,
    len=3D1638400, completion=3D0x7ffc03d4c010) at librados.cc:2119
#12 0x000000000045a305 in rbd_aio_rw_vector (bs=3D<value optimized out>=
,
    sector_num=3D<value optimized out>, qiov=3D<value optimized out>,
    nb_sectors=3D917504, cb=3D<value optimized out>, opaque=3D<value op=
timized out>,
    write=3D1) at block/rbd.c:769
#13 0x000000000045a430 in rbd_aio_writev (bs=3D<value optimized out>,
    sector_num=3D<value optimized out>, qiov=3D<value optimized out>,
    nb_sectors=3D<value optimized out>, cb=3D<value optimized out>,
    opaque=3D<value optimized out>) at block/rbd.c:802
#14 0x000000000043bb73 in bdrv_aio_writev (bs=3D0x159dd20, sector_num=3D=
2279168,
    qiov=3D0x7ffb29e26480, nb_sectors=3D3200, cb=3D<value optimized out=
>,
    opaque=3D<value optimized out>) at block.c:2019
#15 0x000000000043bb73 in bdrv_aio_writev (bs=3D0x159d3f0, sector_num=3D=
2279168,
    qiov=3D0x7ffb29e26480, nb_sectors=3D3200, cb=3D<value optimized out=
>,
    opaque=3D<value optimized out>) at block.c:2019
#16 0x000000000043ca2c in bdrv_aio_multiwrite (bs=3D0x159d3f0,
    reqs=3D0x7ffc0f5fd690, num_reqs=3D<value optimized out>) at block.c=
:2228
#17 0x000000000041cca5 in virtio_submit_multiwrite (bs=3D<value optimiz=
ed out>,
    mrb=3D0x7ffc0f5fd690) at /usr/src/debug/qemu-kvm-0.13.0/hw/virtio-b=
lk.c:241
#18 0x000000000041d30c in virtio_blk_handle_output (vdev=3D0x1e56c30,
    vq=3D<value optimized out>)
    at /usr/src/debug/qemu-kvm-0.13.0/hw/virtio-blk.c:359
#19 0x000000000042dc5d in kvm_handle_io (env=3D0x15c4b20)
    at /usr/src/debug/qemu-kvm-0.13.0/kvm-all.c:763
#20 kvm_run (env=3D0x15c4b20) at /usr/src/debug/qemu-kvm-0.13.0/qemu-kv=
m.c:645
#21 0x000000000042dd89 in kvm_cpu_exec (env=3D<value optimized out>)
    at /usr/src/debug/qemu-kvm-0.13.0/qemu-kvm.c:1238
#22 0x000000000042f181 in kvm_main_loop_cpu (_env=3D0x15c4b20)
    at /usr/src/debug/qemu-kvm-0.13.0/qemu-kvm.c:1495
#23 ap_main_loop (_env=3D0x15c4b20)
    at /usr/src/debug/qemu-kvm-0.13.0/qemu-kvm.c:1541
#24 0x0000003c0c4077e1 in start_thread () from /lib64/libpthread.so.0
#25 0x0000003c0c0e151d in clone () from /lib64/libc.so.6

I hope this helps.

Regards,
Christian


2010/11/4 Sage Weil <sage@newdream.net>:
> Hi Christian,
>
> On Tue, 26 Oct 2010, Christian Brunner wrote:
>> I can't promise this for tomorrow, but I think I can do this on Thur=
sday.
>
> Have you had a chance to look into this one at all?
>
> Thanks-
> sage
>
>
>>
>> Christian
>>
>> -----Urspr=FCngliche Nachricht-----
>> Von: Sage Weil [mailto:sage@newdream.net]
>> Gesendet: Dienstag, 26. Oktober 2010 21:09
>> An: Christian Brunner
>> Cc: ceph-devel@vger.kernel.org
>> Betreff: Re: ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(=
osd))
>>
>> On Tue, 26 Oct 2010, Christian Brunner wrote:
>> > When accessing multiple RBD-Volumes from one VM in parallel, we ar=
e
>> > receiving an assertion:
>> >
>> > ./osd/OSDMap.h: In function 'entity_inst_t OSDMap::get_inst(int)':
>> > ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd))
>>
>> Can you change that into two asserts so we can see which it is?
>>
>> And/or can you gdb this and see what the value of osd is here?
>>
>> Thanks!
>> sage
>>
>>
>> > ceph version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee70142=
79)
>> > 1: (Objecter::op_submit(Objecter::Op*)+0x6c2) [0x38658854c2]
>> > 2: /usr/lib64/librados.so.1() [0x3865855dc9]
>> > 3: (RadosClient::aio_write(RadosClient::PoolCtx&, object_t, long,
>> > ceph::buffer::list const&, unsigned long,
>> > RadosClient::AioCompletion*)+0x24b) [0x386585724b]
>> > 4: (rados_aio_write()+0x9a) [0x386585741a]
>> > 5: /usr/bin/qemu-kvm() [0x45a305]
>> > 6: /usr/bin/qemu-kvm() [0x45a430]
>> > 7: /usr/bin/qemu-kvm() [0x43bb73]
>> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> > needed to interpret this.
>> > ./osd/OSDMap.h: In function 'entity_inst_t OSDMap::get_inst(int)':
>> > ./osd/OSDMap.h:460: FAILED assert(exists(osd) && is_up(osd)) ceph
>> > version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee7014279)
>> > 1: (Objecter::op_submit(Objecter::Op*)+0x6c2) [0x38658854c2]
>> > 2: /usr/lib64/librados.so.1() [0x3865855dc9]
>> > 3: (RadosClient::aio_write(RadosClient::PoolCtx&, object_t, long,
>> > ceph::buffer::list const&, unsigned long,
>> > RadosClient::AioCompletion*)+0x24b) [0x386585724b]
>> > 4: (rados_aio_write()+0x9a) [0x386585741a]
>> > 5: /usr/bin/qemu-kvm() [0x45a305]
>> > 6: /usr/bin/qemu-kvm() [0x45a430]
>> > 7: /usr/bin/qemu-kvm() [0x43bb73]
>> > NOTE: a copy of the executable, or `objdump -rdS <executable>` is
>> > needed to interpret this.
>> > terminate called after throwing an instance of 'ceph::FailedAssert=
ion'
>> > *** Caught signal (ABRT) ***
>> > ceph version 0.22.1 (commit:c6f403a6f441184956e00659ce713eaee70142=
79)
>> > 1: (sigabrt_handler(int)+0x91) [0x3865922b91]
>> > 2: /lib64/libc.so.6() [0x3c0c032a30]
>> > 3: (gsignal()+0x35) [0x3c0c0329b5]
>> > 4: (abort()+0x175) [0x3c0c034195]
>> > 5: (__gnu_cxx::__verbose_terminate_handler()+0x12d) [0x3c110beaad]
>> >
>> > This is reproducible by doing the following inside a VM:
>> >
>> > # mkfs.btrfs /dev/vdb /dev/vdc /dev/vdd /dev/vde # mount /dev/vdb =
/mnt
>> > # cd /mnt # bonnie++ -u root -d /mnt -f
>> >
>> > Any hints are welcome...
>> >
>> > Thanks,
>> >
>> > Christian
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>> > in the body of a message to majordomo@vger.kernel.org More majordo=
mo
>> > info at =A0http://vger.kernel.org/majordomo-info.html
>> >
>> >
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
