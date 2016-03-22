From: Huan Zhang <huan.zhang.jn@gmail.com>
Subject: Re: rbd_aio_flush cause guestos sync wirte poor iops?
Date: Tue, 22 Mar 2016 14:53:41 +0800
Message-ID: <CAFU9ComfUV+h3ZTp8oK1gZFejAuo9B4c+-RwVK5==SSQEkTAcQ@mail.gmail.com>
References: <CAFU9Co=d-CstfhbiP3ztdpNTFp03SMGy8ciRw8xxBXkxw7TjRw@mail.gmail.com>
	<578851288.38782223.1458135450823.JavaMail.zimbra@redhat.com>
	<CAFU9Con=_qXF37XSre1Ep7Ji5MFKcVstQ9MfQPTk=+mvojcLvw@mail.gmail.com>
	<1216780323.39858060.1458302557470.JavaMail.zimbra@redhat.com>
	<CAFU9Co=c3osqqogjFurtZAReEN_QXmV9n00QGJ5y+R_=jh27aQ@mail.gmail.com>
	<630315434.41021364.1458564978169.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33786 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbcCVGxn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Mar 2016 02:53:43 -0400
Received: by mail-lb0-f181.google.com with SMTP id oe12so148529513lbc.0
        for <ceph-devel@vger.kernel.org>; Mon, 21 Mar 2016 23:53:42 -0700 (PDT)
In-Reply-To: <630315434.41021364.1458564978169.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel@vger.kernel.org

2016-03-21 20:56 GMT+08:00 Jason Dillaman <dillaman@redhat.com>:
>> Let's take fsync in guestos as an example.
>> scenario 1: write(buf) fsync()
>> buf will be writted to page cache after write call return
>> fsync will flush buf in page cache to disk cache(just like O_DIRECT) ,
>> and then issue [sync cache] to guarantee data has been written to
>> persisted disk medium
>>
>>
>> scenario 2: write(buf, O_DIRECT) fsync()
>> buf will be writted to disk cache, and then issue [sync cache] to
>> guarantee data has been written to persisted disk medium
>>
>>
>> For Ceph, it use sync write to journal, so there is no disk cache in
>> ceph[rbd cache off],  if write return to guestos, all data will be
>> persisted.
>
> This is not entirely correct.  While it's true that the FileStore OSD backend first writes the transaction to its journal before applying it to the backing disk, this is a design choice of that engine.  The forthcoming BlueStore, for example, doesn't suffer from the same double-write penalty as FileStore.
>
> Using your disk medium analogy, for RBD the guest OS writes the data to the RBD disk and than issues a write barrier (as instructed by the guest OS application) to ensure that all in-flight writes are safely committed before proceeding.  Therefore, regardless of what the OSDs are doing, RBD still needs to respect the barrier (flush) the guest OS issued.  In the case of RBD, the flush just waits for the proceeding writes to complete (as ACKed by the OSDs).  If RBD ignored the barriers, your data would no longer be crash consistent since the data might not have even been transmitted to the OSDs yet, might have only hit one OSD (and if that OSD crashes, your data is lost since it hadn't been replicated to the other OSDs), etc.

Very appreciated for explanation,.
https://docs.fedoraproject.org/en-US/Fedora/14/html/Storage_Administration_Guide/writebarr.html#writebarrierswhyneed
according to the redhat's explanation, writebarriers introduced by
disk cache, os can not guarantee the write order if power loss. as my
understand, looks like this:
step0, fsync
step1, write(O_Direct) to disk cache
step2 , fsync() [sync cahce command for scsi]
step3, write(O_Driect) to disk cache
without step2, and power loss before the data of step1&step3 write
back to persisted medium, the order of step1 and step3 are not
guaranteed, no longer be crash consistent.

As my understand, RBD processing [rbd cache=off] is not a disk cache
from the guestos's perspective, because write(O_Direct) will not
return if data has not been persistent in ceph backend store.
fsync has no need to guarantee the flight-io in os kernel to be
persistent but not disk cache. (except the data in page cache)

In short, ceph has no disk cache[rbd cache=off], so we don't need
wirte barrier here.

Very happy to adjust me here!

>
>> sync cache in guestos issued by fsync can be safely ignored since
>> write(O_DIRECT) or fsync can guarantee all data has been wirtten to
>> persisted disk medium
>> in ceph without rbd cache, right?
>
> The flush call in RBD is completes as soon as the OSDs acknowledge that the data is safe.  If it takes 2.5 milliseconds for the OSDs to ACK that the write is safe, you will only be able to achieve ~400 sync'ed IOPS.
>
> As discussed in the previous chain, there are ways some users have improved RBD to better accommodate database workloads.  Additionally, the forthcoming BlueStore engine already shows improvement for write-intensive applications.
>
>>
>> BTW, rbd_aio_flush iops has significance impact to database
>> workloads.(many sync cache calls in guestos),  that's why i'm asking
>> for help.
>
> Yes -- write barriers will definitely slow down IO but they are a necessary evil to ensure crash consistency.

rbd block device kernel module has no performance issue for sync
wirte. test both with fio ioengine=rbd fsync=1 and fio ioengine=libaio
sync=1, hard to explain if rbd need flush.

For BlueStore, if the write data is not persistent, we should add some
rados api to flush backend cache to guarantee fsync semantics or we
already has now?
so if not, seems it's not the a design choice of that engine, the
backend must guarantee the persistence?

>
>>
>> Thanks.
>>
>>
>> 2016-03-18 20:02 GMT+08:00 Jason Dillaman <dillaman@redhat.com>:
>> > There isn't anything slow about the flush -- the flush will complete when
>> > your previous writes complete.  If it takes 2.5 ms for your OSDs to ACK a
>> > write as safely written to disk, you will only be able to issue ~400 sync
>> > writes per second.
>> >
>> > The flush issues by your guest OS / QEMU to librbd is to designed to ensure
>> > that your previous write operations are safely committed to disk.  If
>> > flushes were ignored, your data would no longer be crash consistent.  This
>> > is nothing unique to RBD -- you would have the safe effect with a local
>> > disk as well.
>> >
>> > --
>> >
>> > Jason Dillaman
>> >
>> > ----- Original Message -----
>> >> From: "Huan Zhang" <huan.zhang.jn@gmail.com>
>> >> To: "Jason Dillaman" <dillaman@redhat.com>
>> >> Cc: ceph-devel@vger.kernel.org, haomaiwang@gmail.com
>> >> Sent: Thursday, March 17, 2016 12:58:59 AM
>> >> Subject: Re: rbd_aio_flush cause guestos sync wirte poor iops?
>> >>
>> >> Hi Jason & Haomai,
>> >>     Thanks for reply  and explanation.
>> >>     fio with ioengine=rbd fsync=1 within physical compute onde
>> >> performance is ok. similar to normal wirte(direct=1)
>> >>     ceph --admin-daemon /var/run/ceph/rbd-41837.asok config show |
>> >> grep rbd_cache
>> >>     "rbd_cache": "false"
>> >>
>> >>     As you mentioned, sync=1 within guestos will issue rbd_aio_flush.
>> >> so my question is:
>> >>     1. why rbd_aio_flush is so poor even if rbd cache is off?
>> >>     2. could we ignore the sync cache(rbd_aio_flush) instructed by the
>> >> guest OS if rbd cache is off?
>> >>
>> >>
>> >>
>> >> 2016-03-16 21:37 GMT+08:00 Jason Dillaman <dillaman@redhat.com>:
>> >> > As previously mentioned [1], the fio rbd engine ignores the "sync"
>> >> > option.
>> >> > You need to use "fsync=1" to issue a flush after each write to simulate
>> >> > what "sync=1" is doing.  When running fio within a VM against an RBD
>> >> > image, QEMU is not issuing sync writes to RBD -- it's issuing AIO writes
>> >> > and a AIO flush (as instructed by the guest OS).  Looking at the man
>> >> > page
>> >> > for O_SYNC [2], which is what that fio option enables in supported
>> >> > engines, that flag will act "as though each write(2) was followed by a
>> >> > call to fsync(2)".
>> >> >
>> >> > [1]
>> >> > http://lists.ceph.com/pipermail/ceph-users-ceph.com/2016-February/007780.html
>> >> > [2] http://man7.org/linux/man-pages/man2/open.2.html
>> >> >
>> >> > --
>> >> >
>> >> > Jason Dillaman
>> >> >
>> >> >
>> >> > ----- Original Message -----
>> >> >> From: "Huan Zhang" <huan.zhang.jn@gmail.com>
>> >> >> To: ceph-devel@vger.kernel.org
>> >> >> Sent: Wednesday, March 16, 2016 12:52:33 AM
>> >> >> Subject: rbd_aio_flush cause guestos sync wirte poor iops?
>> >> >>
>> >> >> Hi,
>> >> >>    We test sync iops with fio sync=1 for database workloads in VM,
>> >> >> the backend is librbd and ceph (all SSD setup).'
>> >> >>    The result is sad to me. we only get ~400 IOPS sync randwrite with
>> >> >>    iodepth=1
>> >> >> to iodepth=32.
>> >> >>     But test in physical machine with fio ioengine=rbd sync=1, we can
>> >> >> reache ~35K IOPS.
>> >> >> seems the qemu rbd is the bottleneck.
>> >> >>
>> >> >>     qemu version is 2.1.2 with rbd_aio_flush patched.
>> >> >>     rbd cache is off, qemu cache=none.
>> >> >>
>> >> >>     IMHO, ceph use sync write for every write to disk, so
>> >> >> rbd_aio_flush can ignore the sync
>> >> >> cache command if rbd cache is off so that we can get higher
>> >> >> iops(similar to direct=1 write)
>> >> >> for sync=1 iops, right?
>> >> >>
>> >> >>    Very appreciated to get your reply!
>> >> >> --
>> >> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> >> >> in
>> >> >> the body of a message to majordomo@vger.kernel.org
>> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >> >>
>> >>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
>
> Jason Dillaman
