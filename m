From: Marov Aleksey <Marov.A@raidix.com>
Subject: HA: ceph issue
Date: Wed, 7 Dec 2016 08:57:13 +0000
Message-ID: <FEC85B105C5F644CA51BDB90657EEA98316068DD@DDSM-MBX2.digdes.com>
References: <FEC85B105C5F644CA51BDB90657EEA9828425083@ddsm-mbx01.digdes.com>
 <alpine.DEB.2.11.1611171448450.15311@piezo.us.to>
 <CACJqLybjnFedWh+TdN4W6u2+VKWBsJAtVi0A8VjbJ2mGX8aZxA@mail.gmail.com>
 <FEC85B105C5F644CA51BDB90657EEA98284250E8@ddsm-mbx01.digdes.com>
 <CACJqLyZRDpinsMZtDbM_zZHfi87FzC1HrCP0KRFEgAxgzGpjYQ@mail.gmail.com>
 <DB3PR05MB0793F7194A5C64F018E61012A9B20@DB3PR05MB0793.eurprd05.prod.outlook.com>
 <CACJqLyaCJdK+G6V3_Cm36PRYrwQCoRZ02MyJCnDudSUmC=O4Tg@mail.gmail.com>
 <FEC85B105C5F644CA51BDB90657EEA982DC9E133@DDSM-MBX2.digdes.com>
 <DB3PR05MB0793FB50C98346C4983E3ABBA9B40@DB3PR05MB0793.eurprd05.prod.outlook.com>
 <FEC85B105C5F644CA51BDB90657EEA982DC9F1CC@DDSM-MBX2.digdes.com>
 <DB3PR05MB079316AC35562CC422E44DC0A9B70@DB3PR05MB0793.eurprd05.prod.outlook.com>
 <CACJqLyaw8Oag6XN-HSyrRPonMhMxqpbXuQei6cFE0LdBaNxUqw@mail.gmail.com>
 <DB3PR05MB07934D1948253BC4C19CC558A9830@DB3PR05MB0793.eurprd05.prod.outlook.com>
 <FEC85B105C5F644CA51BDB90657EEA98316058A7@DDSM-MBX2.digdes.com>,<CACJqLyY7702E6pLmAraLn=i9e==23rWZaLZ532dPRKwDFvW3GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digdes.com ([85.114.5.13]:30374 "EHLO smtp.digdes.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751631AbcLGI6h (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 7 Dec 2016 03:58:37 -0500
In-Reply-To: <CACJqLyY7702E6pLmAraLn=i9e==23rWZaLZ532dPRKwDFvW3GQ@mail.gmail.com>
Content-Language: ru-RU
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: Avner Ben Hanoch <avnerb@mellanox.com>, Sage Weil <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

You were right. Increasing of fd limits helped me. Thank you Haomai for great work done with rdma async messenger. 
________________________________________
От: Haomai Wang [haomai@xsky.com]
Отправлено: 6 декабря 2016 г. 20:15
Кому: Marov Aleksey
Копия: Avner Ben Hanoch; Sage Weil; ceph-devel@vger.kernel.org
Тема: Re: ceph issue

you need to increase system fd limits, rdma backend will uses double
fd than before, one is tcp socket fd, another is linux eventfd

On Tue, Dec 6, 2016 at 11:36 PM, Marov Aleksey <Marov.A@raidix.com> wrote:
> I have tried the latest changes.  It works fine for any blocksize and for small number of fio jobs. But if I set numjobs >=16 it crushes with the assert::
> /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-2234-g19ca696/src/msg/async/rdma/RDMAStack.h: In function 'int RDMADispatcher::register_qp(RDMADispatcher::QueuePair*, RDMAConnectedSocketImpl*)' thread 7f3d64ff9700 time 2016-12-06 18:32:33.517932
> /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-2234-g19ca696/src/msg/async/rdma/RDMAStack.h: 102: FAILED assert(fd >= 0)
>
> core dump showed me this:
> Thread 1 (Thread 0x7f6aeb7fe700 (LWP 15151)):
> #0  0x00007f6c3d68d5f7 in raise () from /lib64/libc.so.6
> #1  0x00007f6c3d68ece8 in abort () from /lib64/libc.so.6
> #2  0x00007f6c3eef95e7 in ceph::__ceph_assert_fail (assertion=assertion@entry=0x7f6c3f1c8722 "fd >= 0",
>     file=file@entry=0x7f6c3f1cd100 "/mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-2234-g19ca696/src/msg/async/rdma/RDMAStack.h", line=line@entry=102,
>     func=func@entry=0x7f6c3f1cd8c0 <RDMADispatcher::register_qp(Infiniband::QueuePair*, RDMAConnectedSocketImpl*)::__PRETTY_FUNCTION__> "int RDMADispatcher::register_qp(RDMADispatcher::QueuePair*, RDMAConnectedSocketImpl*)") at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-2234-g19ca696/src/common/assert.cc:78
> #3  0x00007f6c3efb443e in register_qp (csi=0x7f6ac83e00d0, qp=0x7f6ac83e0650, this=0x7f6bec145560)
>     at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-2234-g19ca696/src/msg/async/rdma/RDMAStack.h:102
> #4  RDMAConnectedSocketImpl (w=0x7f6bec0bee50, s=0x7f6bec145560, ib=<optimized out>, cct=0x7f6bec0b30f0,
>     this=0x7f6ac83e00d0)
>     at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-2234-g19ca696/src/msg/async/rdma/RDMAStack.h:297
> ---Type <return> to continue, or q <return> to quit---
> #5  RDMAWorker::connect (this=0x7f6bec0bee50, addr=..., opts=..., socket=0x7f69b409fef0)
>     at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-2234-g19ca696/src/msg/async/rdma/RDMAStack.cc:49
> #6  0x00007f6c3f13bb03 in AsyncConnection::_process_connection (this=this@entry=0x7f69b409fd90)
>     at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-2234-g19ca696/src/msg/async/AsyncConnection.cc:864
> #7  0x00007f6c3f1423b8 in AsyncConnection::process (this=0x7f69b409fd90)
>     at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-2234-g19ca696/src/msg/async/AsyncConnection.cc:812
> #8  0x00007f6c3ef9b53c in EventCenter::process_events (this=this@entry=0x7f6bec0beed0,
>     timeout_microseconds=<optimized out>, timeout_microseconds@entry=30000000)
>     at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-2234-g19ca696/src/msg/async/Event.cc:430
> #9  0x00007f6c3ef9da4a in NetworkStack::__lambda1::operator() (__closure=0x7f6bec146030)
>     at /mnt/ceph_src/rpmbuild/BUILD/ceph-11.0.2-2234-g19ca696/src/msg/async/Stack.cc:46
> #10 0x00007f6c3bd51220 in ?? () from /lib64/libstdc++.so.6
> #11 0x00007f6c3dc25dc5 in start_thread () from /lib64/libpthread.so.0
> #12 0x00007f6c3d74eced in clone () from /lib64/libc.so.6
>
> my fio config looks like this :
> [global]
> #logging
> #write_iops_log=write_iops_log
> #write_bw_log=write_bw_log
> #write_lat_log=write_lat_log
> ioengine=rbd
> direct=1
> #clustername=ceph
> clientname=admin
> pool=rbd
> rbdname=test_img1
> invalidate=0    # mandatory
> rw=randwrite
> bs=4K
> runtime=10m
> time_based
> randrepeat=0
>
> [rbd_iodepth32]
> iodepth=128
> numjobs=16 # 16 dosent work
>
>
> But it works perfect with 8 numjobs. If it is only me who got this problem then may be I have some problems with th ib drivers or settings ?
>
> Best regards
> Aleksei Marov
> ________________________________________
> От: Avner Ben Hanoch [avnerb@mellanox.com]
> Отправлено: 5 декабря 2016 г. 12:37
> Кому: Haomai Wang
> Копия: Marov Aleksey; Sage Weil; ceph-devel@vger.kernel.org
> Тема: RE: ceph issue
>
> Hi Haomai, Alexey
>
> With latest async/rdma code I don't see the fio errors (not for multiple fio instances neither to big block size) - thanks for your work Haomai.
>
> Alexey - do you still see any issue with fio?
>
> Regards,
>   Avner
>
>> -----Original Message-----
>> From: Haomai Wang [mailto:haomai@xsky.com]
>> Sent: Friday, December 02, 2016 05:12
>> To: Avner Ben Hanoch <avnerb@mellanox.com>
>> Cc: Marov Aleksey <Marov.A@raidix.com>; Sage Weil <sweil@redhat.com>;
>> ceph-devel@vger.kernel.org
>> Subject: Re: ceph issue
>>
>> On Wed, Nov 23, 2016 at 5:30 PM, Avner Ben Hanoch
>> <avnerb@mellanox.com> wrote:
>> >
>> > I guess that like the rest of ceph, the new rdma code must also support
>> multiple applications in parallel.
>> >
>> > I am also reproducing your error => 2 instances of fio can't run in parallel
>> with ceph rdma.
>> >
>> > * with ceph -s shows HEALTH_WARN (with "9 requests are blocked > 32
>> > sec")
>> >
>> > * and with all osds printing messages like " heartbeat_check: no reply from
>> ..."
>> >
>> > * And with log files contains errors:
>> >   $ grep error ceph-osd.0.log
>> >   2016-11-23 09:20:46.988154 7f9b26260700 -1 Fail to open '/proc/0/cmdline'
>> error = (2) No such file or directory
>> >   2016-11-23 09:20:54.090388 7f9b43951700  1 -- 36.0.0.2:6802/10634 >>
>> 36.0.0.4:0/19587 conn(0x7f9b256a8000 :6802 s=STATE_OPEN pgs=1 cs=1
>> l=1).read_bulk reading from fd=139 : Unknown error -104
>> >   2016-11-23 09:20:58.411912 7f9b44953700  1 RDMAStack polling work
>> request returned error for buffer(0x7f9b1fee21b0) status(12:RETRY_EXC_ERR
>> >   2016-11-23 09:20:58.411934 7f9b44953700  1 RDMAStack polling work
>> > request returned error for buffer(0x7f9b553d20d0)
>> > status(12:RETRY_EXC_ERR
>>
>> error is "IBV_WC_RETRY_EXC_ERR (12) - Transport Retry Counter
>> Exceeded: The local transport timeout retry counter was exceeded while
>> trying to send this message. This means that the remote side didn't send any
>> Ack or Nack. If this happens when sending the first message, usually this mean
>> that the connection attributes are wrong or the remote side isn't in a state
>> that it can respond to messages. If this happens after sending the first
>> message, usually it means that the remote QP isn't available anymore.
>> Relevant for RC QPs."
>>
>> we set qp retry_cnt to 7 and timeout is 14
>>
>>   // How long to wait before retrying if packet lost or server dead.
>>   // Supposedly the timeout is 4.096us*2^timeout.  However, the actual
>>   // timeout appears to be 4.096us*2^(timeout+1), so the setting
>>   // below creates a 135ms timeout.
>>   qpa.timeout = 14;
>>
>>   // How many times to retry after timeouts before giving up.
>>   qpa.retry_cnt = 7;
>>
>> is this means the receiver side lack of memory or not polling work request
>> ASAP?
>>
>> >
>> >
>> >
>> > Command lines that I used:
>> >   ./fio --ioengine=rbd --invalidate=0 --rw=write --bs=128K --numjobs=1 --
>> clientname=admin --pool=rbd --iodepth=128 --rbdname=img2g --name=1
>> >   ./fio --ioengine=rbd --invalidate=0 --rw=write --bs=128K --numjobs=1
>> > --clientname=admin --pool=rbd --iodepth=128 --rbdname=img2g2 --name=1
>> >
>> > > -----Original Message-----
>> > > From: Marov Aleksey
>> > > Sent: Tuesday, November 22, 2016 17:59
>> > >
>> > > I didn't try this blocksize. But in my case fio crushed if I use
>> > > more than one job. With one job everything works fine. Is it worth more
>> deep investigating?
