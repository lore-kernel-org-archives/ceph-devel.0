From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: [ceph-users] rocksdb Seen today - replacement for leveldb?
Date: Wed, 27 Nov 2013 08:54:20 -0600
Message-ID: <5296079C.3060101@inktank.com>
References: <5295CF96.6040708@profihost.ag> <5295CFE2.8070603@profihost.ag> <CACJqLybC1n9ywRdrzG5cd2aWunJb5S2x9sLF_eEREJgu-hpOTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:52554 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab3K0OyQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 09:54:16 -0500
Received: by mail-ie0-f177.google.com with SMTP id tp5so11986397ieb.36
        for <ceph-devel@vger.kernel.org>; Wed, 27 Nov 2013 06:54:15 -0800 (PST)
In-Reply-To: <CACJqLybC1n9ywRdrzG5cd2aWunJb5S2x9sLF_eEREJgu-hpOTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Very interesting guys!  I'm also interested in sync reads/writes. 
That's where leveldb really seemed to fall over in the testing I did. 
On my laptop with an SSD I was getting 200 iops no matter if I was doing 
random or sequential sync writes (using a single thread) with stock 
leveldb, hyperdex, or basho's version.  It would be interesting to try 
rocksdb.

Nisha Talagala of Fusion IO also did a presentation at PDSW comparing 
their OpenNVM key-value layer to leveldb for sync reads/writes here 
(slide 24):

http://www.pdsw.org/pdsw13/slides/talagala-Flash_datacenter-pdsw13.pdf

Mark

On 11/27/2013 05:52 AM, Haomai Wang wrote:
> Yes, we have related bp for rocksdb backend.
> wiki.ceph.com/index.php?title=01Planning/02Blueprints/Firefly/osd:_new_key%2F%2Fvalue_backend
>
> On Wed, Nov 27, 2013 at 6:56 PM, Stefan Priebe - Profihost AG
> <s.priebe@profihost.ag> wrote:
>> the performance comparisions are very impressive:
>>
>> https://github.com/facebook/rocksdb/wiki/Performance-Benchmarks
>>
>> Stefan
>>
>> Am 27.11.2013 11:55, schrieb Stefan Priebe - Profihost AG:
>>> Hi,
>>>
>>> while googles leveldb was too slow for facebook they created rocksdb
>>> (http://rocksdb.org/) may be interesting for Ceph? It's already
>>> production quality.
>>>
>>> Greets,
>>> Stefan
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>

