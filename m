From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: Bug in mempool::map?
Date: Tue, 20 Dec 2016 20:08:25 +0300
Message-ID: <3117e8a5-e8dd-f323-25ef-dc6756ebb8f0@mirantis.com>
References: <36219e00-6114-7b9e-f7ca-5190cb545c93@mirantis.com>
 <alpine.DEB.2.11.1612201524400.10615@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34120 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937351AbcLTRI3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Dec 2016 12:08:29 -0500
Received: by mail-yw0-f177.google.com with SMTP id t125so85141665ywc.1
        for <ceph-devel@vger.kernel.org>; Tue, 20 Dec 2016 09:08:28 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1612201524400.10615@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

Some update on map<uint64_t, uint32_t> mem usage.

It looks like single entry map takes 48 bytes. And 40 bytes for 
map<uint32_t,uint32_t>.

Hence 1024 trivial ref_maps for 1024 blobs takes >48K!

These are my results taken from mempools. And they look pretty similar 
to what's been said in the following article:

http://lemire.me/blog/2016/09/15/the-memory-usage-of-stl-containers-can-be-surprising/


Sage, you mentioned that you're planning to do something with ref maps 
during the standup but I missed the details. Is that something about 
their mem use or anything else?


Thanks,

Igor



On 20.12.2016 18:25, Sage Weil wrote:
> On Tue, 20 Dec 2016, Igor Fedotov wrote:
>> Hi Allen,
>>
>> It looks like mempools don't measure maps allocations properly.
>>
>> I extended unittest_mempool in the following way but corresponding output is
>> always 0 for both 'before' and 'after' values:
>>
>>
>> diff --git a/src/test/test_mempool.cc b/src/test/test_mempool.cc
>> index 4113c53..b38a356 100644
>> --- a/src/test/test_mempool.cc
>> +++ b/src/test/test_mempool.cc
>> @@ -232,9 +232,19 @@ TEST(mempool, set)
>>   TEST(mempool, map)
>>   {
>>     {
>> -    mempool::unittest_1::map<int,int> v;
>> -    v[1] = 2;
>> -    v[3] = 4;
>> +    size_t before = mempool::buffer_data::allocated_bytes();
> I think it's just that you're measuring the buffer_data pool...
>
>> +    mempool::unittest_1::map<int,int>* v = new mempool::unittest_1::map<int,int>;
> but the map is in the unittest_1 pool?
>
>> +    (*v)[1] = 2;
>> +    (*v)[3] = 4;
>> +    size_t after = mempool::buffer_data::allocated_bytes();
>> +    cout << "before " << before << " after " << after << std::endl;
>> +    delete v;
>> +    before = after;
>> +    mempool::unittest_1::map<int64_t,int64_t> v2;
>> +    v2[1] = 2;
>> +    v2[3] = 4;
>> +    after = mempool::buffer_data::allocated_bytes();
>> +    cout << " before " << before << " after " << after << std::endl;
>>     }
>>     {
>>       mempool::unittest_2::map<int,obj> v;
>>
>>
>> Output:
>>
>> [ RUN      ] mempool.map
>> before 0 after 0
>>   before 0 after 0
>> [       OK ] mempool.map (0 ms)
>>
>> It looks like we do not measure ref_map for BlueStore Blob and SharedBlob
>> classes too.
>>
>> Any ideas?
>>
>> Thanks,
>>
>> Igor
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

