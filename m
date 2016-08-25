From: Varada Kari <Varada.Kari@sandisk.com>
Subject: Re: parallel transaction submit
Date: Thu, 25 Aug 2016 14:26:18 +0000
Message-ID: <BLUPR0201MB19083965C2FB9F3357BF3961E2ED0@BLUPR0201MB1908.namprd02.prod.outlook.com>
References: <FC753468179C1C4EB15768F212C46AF266329D@shsmsx102.ccr.corp.intel.com>
 <CACJqLyY7YZ=O_do0OD8d28cmNiknDcMm957qYidA_zGoQ5O+gw@mail.gmail.com>
 <BLUPR0201MB1908C3583D12C047DD0542E3E2ED0@BLUPR0201MB1908.namprd02.prod.outlook.com>
 <alpine.DEB.2.11.1608251404580.10979@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0058.outbound.protection.outlook.com ([104.47.40.58]:23336
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754945AbcHYOm2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 25 Aug 2016 10:42:28 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Haomai Wang <haomai@xsky.com>, "Tang, Haodong" <haodong.tang@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thursday 25 August 2016 07:41 PM, Sage Weil wrote:=0A=
> On Thu, 25 Aug 2016, Varada Kari wrote:=0A=
>> Hi,=0A=
>>=0A=
>> Increasing the number of the kv_sync_threads is not giving much of=0A=
>> performance. In the current threading model, shard_worker submits the IO=
=0A=
>> to the block device which are handled by aio_callback thread(which is=0A=
>> one) and submits to the kv_sync thread, which batches the requests and=
=0A=
>> submits to the rocksdb. Because kv_sync batches the requests and submits=
=0A=
>> the requests, we might observe more time spent on kv_sync_thread=0A=
>> routine. And i haven't observed much of an improvement by adding more=0A=
>> threads here.=0A=
>>=0A=
>> But when increased the number of callbacks thread from aio(still needs=
=0A=
>> some refinements in polling for the request completions) and completing=
=0A=
>> the write completion in the same thread context increased some=0A=
>> performance. I don't have the numbers to say how much, but that is=0A=
>> better than having multiple kv_sync threads, adding one more queue and=
=0A=
>> lock. You can refer to=0A=
>> https://github.com/varadakari/ceph/commits/wip-parallel-aiocb (ignore=0A=
>> the first commit, was trying to do sync transaction in the same thread=
=0A=
>> context of sharded worker to measure the latency).=0A=
> Yeah, I think this is right.  I see two avenues of attack:=0A=
>=0A=
> - Try to eliminate the handoff to _kv_sync_thread by having the =0A=
> transaction submitted to rocksdb in the calling thread.  This will =0A=
> require a bit of refactoring but I think it's possible. We don't actually=
 =0A=
> want to block, though, so it'll be an async submission, and we'll still =
=0A=
> need kv_sync_thread just telling rocksdb to commit in a loop and =0A=
> triggering callbacks.  A recent PR sharded the completion finishers so I'=
m =0A=
> guessing the final step would be some affinity thing that pins the =0A=
> finishers to the same cores as the submitters?=0A=
I kind of copied what kv_sync_thread does and was able to run multiple=0A=
callbacks at the same time.=0A=
If we can complete the write ack in the same aio_cb thread not handing=0A=
off to finisher thread, we can eliminate=0A=
one thread switch and we can have same number of threads as shards. We=0A=
can use the same logic to handle the finishers=0A=
(not sure if we can process the request by reading the osr here) for the=0A=
callback threads.=0A=
=0A=
Varada=0A=
> - Shard the io completion (before we submit the kv transaction).  Not sur=
e =0A=
> if we want a thread per shard, or polls at opportunistic/strategic points=
 =0A=
> in code.  The goal would be keeping the processing local to the =0A=
> core/socket (vs the current strategy of a single thread waiting/polling =
=0A=
> for completions and doing the next phase of work).=0A=
>=0A=
>> was exploring a way to have the aio callback thread matached/reserved at=
=0A=
>> the time of io submission, so that we don't need to do io_getevents(),=
=0A=
>> kind of a async callback to the specified thread so that we can avoid=0A=
>> some waiting logic in io_getevents() and process the request in the same=
=0A=
>> thread context. You can refer to=0A=
>> http://manpages.ubuntu.com/manpages/wily/man3/io_set_callback.3.html. I=
=0A=
>> don't have the working code ready for this. FWIW, that is worth=0A=
>> experimenting and see if it reduces any latency.=0A=
> I don't think this will help--it just means you're using a layer of the =
=0A=
> library that's calling getevents for you and calling your callback.=0A=
>=0A=
> Thanks!=0A=
> sage=0A=
>=0A=
>=0A=
>> Varada=0A=
>>=0A=
>> On Thursday 25 August 2016 01:25 PM, Haomai Wang wrote:=0A=
>>> looks very litlle improvements. rocksdb result meet my expectation=0A=
>>> because rocksdb internal has lock for multi sync write. But memdb=0A=
>>> improments is a little confusing.=0A=
>>>=0A=
>>> On Thu, Aug 25, 2016 at 3:45 PM, Tang, Haodong <haodong.tang@intel.com>=
 wrote:=0A=
>>>> Hi Sage, Varada=0A=
>>>>=0A=
>>>> Noticed you are making parallel transaction submits, we also worked ou=
t a prototype that looks similar, here is the link for the implementation: =
https://github.com/ceph/ceph/pull/10856=0A=
>>>>=0A=
>>>> Background:=0A=
>>>> From the perf counter we added, found it spent a lot time in kv_queue,=
 that is, single thread transaction submits is not competent to handle the =
transaction from OSD.=0A=
>>>>=0A=
>>>> Implementation:=0A=
>>>> The key thought is to use multiple thread and assign each TransContext=
 to one of the processing threads. In order to parallelize transaction subm=
it, add different kv_locks and kv_conds for each thread.=0A=
>>>>=0A=
>>>> Performance evaluation:=0A=
>>>> Test ENV:=0A=
>>>>         4 x server, 4 x client, 16 x Intel S3700 as block device, and =
4 x Intel P3600 as Rocksdb/WAL device.=0A=
>>>> Performance:=0A=
>>>> We also did several quick tests to verify the performance benefit, the=
 results showed that parallel transaction submission will brought 10% perfo=
rmance improvement if using memdb, but little performance improvement with =
rocksdb.=0A=
>>>>=0A=
>>>> What's more, without parallel transaction submits, we also see perform=
ance boost if just changing to MemDB, but a little.=0A=
>>>>=0A=
>>>> Test summary:=0A=
>>>> QD Scaling Test - 4k Random Write:=0A=
>>>>                                                                       =
            QD =3D 1      QD =3D 16     QD =3D 32      QD =3D 64      QD =
=3D 128=0A=
>>>> With rocksdb (IOPS)                                              682  =
          173000       190000        203000       204000=0A=
>>>> With memdb (IOPS)                                              704    =
        180000       194000        206000       218000=0A=
>>>> With rocksdb+multiple_kv_thread(IOPS)          /                164243=
        167037        180961      201752=0A=
>>>> With memdb+multiple_kv_thread(IOPS)          /                 176000 =
      200000        221000      227000=0A=
>>>>=0A=
>>>>=0A=
>>>> It seems single thread of transaction submits will be a bottleneck if =
using MemDB.=0A=
>>>> --=0A=
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in=0A=
>>>> the body of a message to majordomo@vger.kernel.org=0A=
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
>> PLEASE NOTE: The information contained in this electronic mail message i=
s intended only for the use of the designated recipient(s) named above. If =
the reader of this message is not the intended recipient, you are hereby no=
tified that you have received this message in error and that any review, di=
ssemination, distribution, or copying of this message is strictly prohibite=
d. If you have received this communication in error, please notify the send=
er by telephone or e-mail (as shown above) immediately and destroy any and =
all copies of this message in your possession (whether hard copies or elect=
ronically stored copies).=0A=
>> --=0A=
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in=
=0A=
>> the body of a message to majordomo@vger.kernel.org=0A=
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html=0A=
>>=0A=
>>=0A=
=0A=
