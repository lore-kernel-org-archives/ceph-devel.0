From: Igor Fedotov <ifedotov@mirantis.com>
Subject: Re: BlueStore in-memory Onode footprint
Date: Mon, 19 Dec 2016 17:45:45 +0300
Message-ID: <b0c715a3-9577-93cf-d634-499eb52cb87c@mirantis.com>
References: <34ee2613-8db3-646e-4470-b3e8fa8855e0@mirantis.com>
 <alpine.DEB.2.11.1612161518570.10615@piezo.novalocal>
 <EB02EE10422E4A40A1EE787A4AC27FBE0321CB@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f180.google.com ([209.85.213.180]:34243 "EHLO
        mail-yb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755767AbcLSOps (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Dec 2016 09:45:48 -0500
Received: by mail-yb0-f180.google.com with SMTP id d59so57745485ybi.1
        for <ceph-devel@vger.kernel.org>; Mon, 19 Dec 2016 06:45:48 -0800 (PST)
In-Reply-To: <EB02EE10422E4A40A1EE787A4AC27FBE0321CB@ULS-OP-MBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 17.12.2016 1:08, Allen Samuels wrote:
> I'm not sure what the conclusion from this is.
IMHO the numbers I shared are pretty high and we should consider some 
ways to reduce them.
>
> The point of the sharding exercise was to eliminate the need to serialize/deserialize all 1024 Extents/Blobs/SharedBlobs on each I/O transaction.
>
> This shows that a fully populated oNode with ALL of the shards present is a large number. But that ought to be a rare occurrence.
Actually we have pretty high number for each Blob entry. And this means 
that  cache effectiveness is badly affected in general case since we're 
able to cache less entries in total.
>
> This test shows that each Blob is 248 bytes and that each SharedBlob is 216 bytes. That matches the sizeof(...), so the MemPool logic got the right answer! Yay!
>
> Looking at the Blob I see:
>
> Bluestore_blob_t 72 bytes
> Bufferlist 88 bytes
> Extentrefmap 64 bytes
>
> That's most the 248. I suspect that trying to fix this will require a new strategy, etc.
>
> Allen Samuels
> SanDisk |a Western Digital brand
> 2880 Junction Avenue, San Jose, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>
>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Sage Weil
>> Sent: Friday, December 16, 2016 7:20 AM
>> To: Igor Fedotov <ifedotov@mirantis.com>
>> Cc: ceph-devel <ceph-devel@vger.kernel.org>
>> Subject: Re: BlueStore in-memory Onode footprint
>>
>> On Fri, 16 Dec 2016, Igor Fedotov wrote:
>>> Hey All!
>>>
>>> Recently I realized that I'm unable to fit all my onodes ( 32768
>>> objects/4Mb each/4K alloc unit/no csum) in 15G RAM cache.
>>>
>>> Hence decided to estimate Onode in-memory size.
>>>
>>> At first I filled 4Mb object with a single 4M write - mempools
>>> indicate ~5K mem usage for total onode metadata. Good enough.
>>>
>>> Secondly I refill that object with 4K writes. Resulting memusage = 574K!!!
>>> Onode itself 704 bytes in 1 object.  And 4120 other metadata items
>>> occupies all other space.
>>>
>>> Then I removed SharedBlob from mempools. Resulting mem usage = 355K.
>>> The same Onode size. And 3096 other metadata objects. Hence we had
>>> 1024 SharedBlob instances thata took ~ 220K.
>>>
>>>
>>> And finally I removed Blob instances from measurements. Resulting mem
>>> usage = 99K. And 2072 other objects. Hence Blob instances take another
>>> ~250K
>> Yikes!
>>
>> BTW you can get a full breakdown by type with 'mempool debug = true' in
>> ceph.conf (-o 'mempool debug = true' on vstart.sh command line) without
>> having to recompile.  Do you mind repeating the test and including the full
>> breakdown?
>>
>>> Yeah, that's the worst case( actually csum enable will give even more
>>> mem use) but shouldn't we revisit some Onode internals due to such
>> numbers?
>>
>> Yep!
>>
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html

