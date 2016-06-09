From: Somnath Roy <Somnath.Roy@sandisk.com>
Subject: RE: RocksDB tuning
Date: Thu, 9 Jun 2016 01:20:43 +0000
Message-ID: <BL2PR02MB21154F454C61D9FD034FCF9AF45F0@BL2PR02MB2115.namprd02.prod.outlook.com>
References: <D37DE46C.5743E%manavalan.krishnan@sandisk.com>
 <BLUPR0201MB1524D8A9D42F7C50646D0AE8E85E0@BLUPR0201MB1524.namprd02.prod.outlook.com>
 <3F3468645DC82146857A5E1C91E23F4B1BCCC4BA@SSIEXCH-MB3.ssi.samsung.com>
 <BL2PR02MB21150FE5E2B2EDDF4DD04C8FF45F0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <3F3468645DC82146857A5E1C91E23F4B1BCCC561@SSIEXCH-MB3.ssi.samsung.com>
 <BL2PR02MB2115B76585B71F1363B541B6F45F0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <0c174666-de02-36ae-fcb9-196ffa824330@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1bon0063.outbound.protection.outlook.com ([157.56.111.63]:22608
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1161097AbcFIBUr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jun 2016 21:20:47 -0400
In-Reply-To: <0c174666-de02-36ae-fcb9-196ffa824330@redhat.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, Jianjian Huo <jianjian.huo@samsung.com>, Allen Samuels <Allen.Samuels@sandisk.com>, Manavalan Krishnan <Manavalan.Krishnan@sandisk.com>, Ceph Development <ceph-devel@vger.kernel.org>

Mark,
I think increasing compact_threads/flusher_threads should work as we are handling that from our code.
But, the option added in config file with bluestore_rocksdb_options is not setting probably (I will double check with some debug print).
Here is what IncreaseParallelism does..

DBOptions* DBOptions::IncreaseParallelism(int total_threads) {
  max_background_compactions = total_threads - 1;
  max_background_flushes = 1;
  env->SetBackgroundThreads(total_threads, Env::LOW);
  env->SetBackgroundThreads(1, Env::HIGH);
  return this;
}
We need to increase max*_background_compactions as well it seems. Only increasing threads is not sufficient. Additionally, I am seeing bunch of other compaction options, will try those as well and update.
I think as Jianjian said, everything could be done through conf option if it is working properly. I will check and prepare a patch if options are not working properly.

Thanks & Regards
Somnath

-----Original Message-----
From: Mark Nelson [mailto:mnelson@redhat.com] 
Sent: Wednesday, June 08, 2016 6:12 PM
To: Somnath Roy; Jianjian Huo; Allen Samuels; Manavalan Krishnan; Ceph Development
Subject: Re: RocksDB tuning

ugh, that might explain why increasing the rocksdb compaction threads and max concurrent compactions didn't help me at all today.

I'll try to take a look at:

rocksdb::DB::Open in RocksDBStore::do_open opt.IncreaseParallelism(16);
opt.OptimizeLevelStyleCompaction(512 * 1024 * 1024);

Thanks,
Mark

On 06/08/2016 08:08 PM, Somnath Roy wrote:
> Great, thanks..I was checking rocksdb tree..
> Also, one thing I observed that rocksdb::GetOptionsFromString is expecting options to be separated by ';' and not by ',' like we are doing in bluestore_rocksdb_options.
>
> https://github.com/facebook/rocksdb/blob/533cda90cec8588fe13832833cd2c
> 288f3ae786f/util/options_test.cc#L601
> https://github.com/facebook/rocksdb/blob/533cda90cec8588fe13832833cd2c
> 288f3ae786f/util/options_helper.cc#L709
>
> It seems none of the options we are passing is setting correctly in rocksdb ?
> I will add some print to verify.
>
> Thanks & Regards
> Somnath
>
> -----Original Message-----
> From: Jianjian Huo [mailto:jianjian.huo@samsung.com]
> Sent: Wednesday, June 08, 2016 5:50 PM
> To: Somnath Roy; Allen Samuels; Manavalan Krishnan; Mark Nelson; Ceph 
> Development
> Subject: RE: RocksDB tuning
>
>
> On Wed, Jun 8, 2016 at 5:47 PM, Jianjian Huo <jianjian.huo@samsung.com> wrote:
>>
>>
>> -----Original Message-----
>> From: Somnath Roy [mailto:Somnath.Roy@sandisk.com]
>> Sent: Wednesday, June 08, 2016 5:39 PM
>> To: Jianjian Huo; Allen Samuels; Manavalan Krishnan; Mark Nelson; 
>> Ceph Development
>> Subject: RE: RocksDB tuning
>>
>> Jianjian,
>> Couldn't find options like compaction_threads/flusher_threads in rocksdb tree. Max_* option can be done by options.
>> It seems it is increasing through env->SetBackgroundThreads(). Am I missing anything ?
>
> It's handled by Ceph kv and then passed to rocksdb. See below
> https://github.com/ceph/ceph/blob/master/src/kv/RocksDBStore.cc#L148
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org 
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Jianjian Huo
>> Sent: Wednesday, June 08, 2016 5:31 PM
>> To: Allen Samuels; Manavalan Krishnan; Mark Nelson; Ceph Development
>> Subject: RE: RocksDB tuning
>>
>> To just increase compaction and flusher threads, I think we can also configure rocksdb with below settings as well?
>>
>> bluestore_rocksdb_options =
>> "...compaction_threads=, flusher_threads=, max_background_compactions=, max_background_flushes=..."
>>
>> Regards,
>> Jianjian
>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org 
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Allen Samuels
>>> Sent: Wednesday, June 08, 2016 4:53 PM
>>> To: Manavalan Krishnan; Mark Nelson; Ceph Development
>>> Subject: RE: RocksDB tuning
>>>
>>> Let's make a patch that creates actual Ceph parameters for these things so that we don't have to edit the source code in the future.
>>>
>>>
>>> Allen Samuels
>>> SanDisk |a Western Digital brand
>>> 2880 Junction Avenue, San Jose, CA 95134
>>> T: +1 408 801 7030| M: +1 408 780 6416 allen.samuels@SanDisk.com
>>>
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel- 
>>> owner@vger.kernel.org] On Behalf Of Manavalan Krishnan
>>> Sent: Wednesday, June 08, 2016 3:10 PM
>>> To: Mark Nelson <mnelson@redhat.com>; Ceph Development <ceph- 
>>> devel@vger.kernel.org>
>>> Subject: RocksDB tuning
>>>
>>> Hi Mark
>>>
>>> Here are the tunings that we used to avoid the IOPs choppiness 
>>> caused by rocksdb compaction.
>>>
>>> We need to add the following options in src/kv/RocksDBStore.cc 
>>> before rocksdb::DB::Open in RocksDBStore::do_open opt.IncreaseParallelism(16);
>>>   opt.OptimizeLevelStyleCompaction(512 * 1024 * 1024);
>>>
>>>
>>>
>>> Thanks
>>> Mana
>>>
>>>
>>>>
>>>
>>> PLEASE NOTE: The information contained in this electronic mail 
>>> message is intended only for the use of the designated recipient(s) 
>>> named above. If the reader of this message is not the intended 
>>> recipient, you are hereby notified that you have received this 
>>> message in error and that any review, dissemination, distribution, 
>>> or copying of this message is strictly prohibited. If you have 
>>> received this communication in error, please notify the sender by 
>>> telephone or e-mail (as shown above) immediately and destroy any and 
>>> all copies of this message in your possession (whether hard copies or electronically stored copies).
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>>> info at http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo 
>> info at  http://vger.kernel.org/majordomo-info.html
>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>
