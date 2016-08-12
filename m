From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: potential issue with Bluestore collection_list
Date: Fri, 12 Aug 2016 15:27:56 +0300
Message-ID: <79464bf5-5ad6-7121-de4a-0f7978ad218e@mirantis.com>
References: <8231b124-5e67-aa5a-98c3-e8a5c5ddaac7@mirantis.com>
 <alpine.DEB.2.11.1608111943090.17762@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38096 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbcHLM17 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Aug 2016 08:27:59 -0400
Received: by mail-wm0-f52.google.com with SMTP id o80so30177423wme.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Aug 2016 05:27:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1608111943090.17762@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Yep, that's it. Thanks a lot!



On 11.08.2016 22:44, Sage Weil wrote:
> On Thu, 11 Aug 2016, Igor Fedotov wrote:
>> Looks like BlueStore::collection_list method makes my day today :)
>>
>> While playing with new objectstore fio plugin (see
>> https://github.com/ceph/ceph/pull/10267) I observed BlueStore fsck reports
>> errors on restart. And completion if properly configured.
>>
>> After significant test case simplification it appeared that BlueStore::fsck
>> detects duplicate nid at the storage. More analysis showed that in fact it's
>> Bluestore::collection_list who returned duplicate entities.
>>
>> I have some gaps in my collection/object naming scheme understanding hence I
>> can't say definitely if fio assigns collection names properly. IMHO it's
>> rather an issue in BlueStore::collection_list.
>>
>> Here is pretty simple (hopefully) log (2 collections and 2 objects total) each
>> showing the case.
>>
>> IMHO the issue somewhere below the following line:
>>
>> 2016-08-11 18:30:44.595101 7fbe78f39780  1 bluestore(./fio-bluestore) fsck
>> collection 281474976710656.0_head
>>
>> where both object keys are reported.
>>
>> Sage, could you please take a look and comment.
> I think this is the problem:
>
> 2016-08-11 18:30:44.595104 7fbe78f39780 20 bluestore(./fio-bluestore) collection_list range '--'0x7ffefffffffffffe00000000'.' to '--'0x7ffefffffffffffeffffffff':' and '--'0x800100000000000000000000'.' to '--'0x8001000000000000ffffffff':' start GHMIN
>
> for the .0 collection it is scanning the hash range that includes the
> .1 collection.  That's because create_collection is being passed a bit
> 'bits' value:
>
> 2016-08-11 18:30:43.697022 7fbe78f39780 15 bluestore(./fio-bluestore) _create_collection 281474976710656.0_head bits 0
> 2016-08-11 18:30:43.697037 7fbe78f39780 10 bluestore(./fio-bluestore) _create_collection 281474976710656.0_head bits 0 = 0
> 2016-08-11 18:30:43.697038 7fbe78f39780 15 bluestore(./fio-bluestore) _create_collection 281474976710656.1_head bits 0
> 2016-08-11 18:30:43.697042 7fbe78f39780 10 bluestore(./fio-bluestore) _create_collection 281474976710656.1_head bits 0 = 0
>
> Since there are 2 collections, we need (at least) 1 significant bit.
>
> sage

