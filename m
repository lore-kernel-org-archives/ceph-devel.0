From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: parallel transaction submit
Date: Thu, 25 Aug 2016 08:47:14 +0000
Message-ID: <BLUPR0201MB1908C3583D12C047DD0542E3E2ED0@BLUPR0201MB1908.namprd02.prod.outlook.com>
References: <FC753468179C1C4EB15768F212C46AF266329D@shsmsx102.ccr.corp.intel.com>
 <CACJqLyY7YZ=O_do0OD8d28cmNiknDcMm957qYidA_zGoQ5O+gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam01on0087.outbound.protection.outlook.com ([104.47.32.87]:39088
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754597AbcHYIrS (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 25 Aug 2016 04:47:18 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>, "Tang, Haodong" <haodong.tang@intel.com>
Cc: "sweil@redhat.com" <sweil@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Increasing the number of the kv_sync_threads is not giving much of
performance. In the current threading model, shard_worker submits the IO
to the block device which are handled by aio_callback thread(which is
one) and submits to the kv_sync thread, which batches the requests and
submits to the rocksdb. Because kv_sync batches the requests and submits
the requests, we might observe more time spent on kv_sync_thread
routine. And i haven't observed much of an improvement by adding more
threads here.

But when increased the number of callbacks thread from aio(still needs
some refinements in polling for the request completions) and completing
the write completion in the same thread context increased some
performance. I don't have the numbers to say how much, but that is
better than having multiple kv_sync threads, adding one more queue and
lock. You can refer to
https://github.com/varadakari/ceph/commits/wip-parallel-aiocb (ignore
the first commit, was trying to do sync transaction in the same thread
context of sharded worker to measure the latency).

was exploring a way to have the aio callback thread matached/reserved at
the time of io submission, so that we don't need to do io_getevents(),
kind of a async callback to the specified thread so that we can avoid
some waiting logic in io_getevents() and process the request in the same
thread context. You can refer to
http://manpages.ubuntu.com/manpages/wily/man3/io_set_callback.3.html. I
don't have the working code ready for this. FWIW, that is worth
experimenting and see if it reduces any latency.

Varada

On Thursday 25 August 2016 01:25 PM, Haomai Wang wrote:
> looks very litlle improvements. rocksdb result meet my expectation
> because rocksdb internal has lock for multi sync write. But memdb
> improments is a little confusing.
>
> On Thu, Aug 25, 2016 at 3:45 PM, Tang, Haodong <haodong.tang@intel.com> w=
rote:
>> Hi Sage, Varada
>>
>> Noticed you are making parallel transaction submits, we also worked out =
a prototype that looks similar, here is the link for the implementation: ht=
tps://github.com/ceph/ceph/pull/10856
>>
>> Background:
>> From the perf counter we added, found it spent a lot time in kv_queue, t=
hat is, single thread transaction submits is not competent to handle the tr=
ansaction from OSD.
>>
>> Implementation:
>> The key thought is to use multiple thread and assign each TransContext t=
o one of the processing threads. In order to parallelize transaction submit=
, add different kv_locks and kv_conds for each thread.
>>
>> Performance evaluation:
>> Test ENV:
>>         4 x server, 4 x client, 16 x Intel S3700 as block device, and 4 =
x Intel P3600 as Rocksdb/WAL device.
>> Performance:
>> We also did several quick tests to verify the performance benefit, the r=
esults showed that parallel transaction submission will brought 10% perform=
ance improvement if using memdb, but little performance improvement with ro=
cksdb.
>>
>> What's more, without parallel transaction submits, we also see performan=
ce boost if just changing to MemDB, but a little.
>>
>> Test summary:
>> QD Scaling Test - 4k Random Write:
>>                                                                         =
          QD =3D 1      QD =3D 16     QD =3D 32      QD =3D 64      QD =3D =
128
>> With rocksdb (IOPS)                                              682    =
        173000       190000        203000       204000
>> With memdb (IOPS)                                              704      =
      180000       194000        206000       218000
>> With rocksdb+multiple_kv_thread(IOPS)          /                164243  =
      167037        180961      201752
>> With memdb+multiple_kv_thread(IOPS)          /                 176000   =
    200000        221000      227000
>>
>>
>> It seems single thread of transaction submits will be a bottleneck if us=
ing MemDB.
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

PLEASE NOTE: The information contained in this electronic mail message is i=
ntended only for the use of the designated recipient(s) named above. If the=
 reader of this message is not the intended recipient, you are hereby notif=
ied that you have received this message in error and that any review, disse=
mination, distribution, or copying of this message is strictly prohibited. =
If you have received this communication in error, please notify the sender =
by telephone or e-mail (as shown above) immediately and destroy any and all=
 copies of this message in your possession (whether hard copies or electron=
ically stored copies).
