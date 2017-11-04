From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: [ceph-users] ceph zstd not for bluestor due to performance
 reasons
Date: Sat, 4 Nov 2017 21:23:37 +0100
Message-ID: <1f9ee617-433c-156f-8d66-0a268b7acaa3@profihost.ag>
References: <BD0427BB-F720-4746-82F9-E082D2396F56@profihost.ag>
 <alpine.DEB.2.11.1710251940520.22592@piezo.us.to>
 <5cf6f721-05ea-4e38-a6b9-04cff5d6aad3@profihost.ag>
 <alpine.DEB.2.11.1710261158070.22592@piezo.us.to>
 <e66d020b-2fba-92a3-fb0a-28236108d1bb@profihost.ag>
 <alpine.DEB.2.11.1711042010330.23234@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:62936 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752394AbdKDUXk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Nov 2017 16:23:40 -0400
In-Reply-To: <alpine.DEB.2.11.1711042010330.23234@piezo.novalocal>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

Thanks - not a C++ guy what's wrong with it?

/build/ceph/src/compressor/zstd/ZstdCompressor.h: In member function
'virtual int ZstdCompressor::compress(const bufferlist&,
ceph::bufferlist&)':
/build/ceph/src/compressor/zstd/ZstdCompressor.h:48:28: error:
'ZSTD_resetCStream' was not declared in this scope
     ZSTD_resetCStream(cs, 0);
                            ^
/build/ceph/src/compressor/zstd/ZstdCompressor.h: In member function
'virtual int ZstdCompressor::decompress(ceph::buffer::list::iterator&,
size_t, ceph::bufferlist&)':
/build/ceph/src/compressor/zstd/ZstdCompressor.h:89:28: error:
'ZSTD_resetDStream' was not declared in this scope
     ZSTD_resetDStream(ds, 0);


zstd.h which is included has the function:

src/zstd/lib/zstd.h:ZSTDLIB_API size_t ZSTD_resetCStream(ZSTD_CStream*
zcs, unsigned long long pledgedSrcSize);  /**< re-use compression
parameters from previous init; skip dictionary loading stage; zcs must
be init at least once before */

Stefan

Am 04.11.2017 um 21:10 schrieb Sage Weil:
> On Sat, 4 Nov 2017, Stefan Priebe - Profihost AG wrote:
>> Hi Sage,
>>
>> Am 26.10.2017 um 13:58 schrieb Sage Weil:
>>> On Thu, 26 Oct 2017, Stefan Priebe - Profihost AG wrote:
>>>> Hi Sage,
>>>>
>>>> Am 25.10.2017 um 21:54 schrieb Sage Weil:
>>>>> On Wed, 25 Oct 2017, Stefan Priebe - Profihost AG wrote:
>>>>>> Hello,
>>>>>>
>>>>>> in the lumious release notes is stated that zstd is not supported by
>>>>>> bluestor due to performance reason. I'm wondering why btrfs instead
>>>>>> states that zstd is as fast as lz4 but compresses as good as zlib.
>>>>>>
>>>>>> Why is zlib than supported by bluestor? And why does btrfs / facebook
>>>>>> behave different?
>>>>>>
>>>>>> "BlueStore supports inline compression using zlib, snappy, or LZ4. (Ceph
>>>>>> also supports zstd for RGW compression but zstd is not recommended for
>>>>>> BlueStore for performance reasons.)"
>>>>>
>>>>> zstd will work but in our testing the performance wasn't great for 
>>>>> bluestore in particular.  The problem was that for each compression run 
>>>>> there is a relatively high start-up cost initializing the zstd 
>>>>> context/state (IIRC a memset of a huge memory buffer) that dominated the 
>>>>> execution time... primarily because bluestore is generally compressing 
>>>>> pretty small chunks of data at a time, not big buffers or streams.
>>>>>
>>>>> Take a look at unittest_compression timings on compressing 16KB buffers 
>>>>> (smaller than bluestore needs usually, but illustrated of the problem):
>>>>>
>>>>> [ RUN      ] Compressor/CompressorTest.compress_16384/0
>>>>> [plugin zlib (zlib/isal)]
>>>>> [       OK ] Compressor/CompressorTest.compress_16384/0 (294 ms)
>>>>> [ RUN      ] Compressor/CompressorTest.compress_16384/1
>>>>> [plugin zlib (zlib/noisal)]
>>>>> [       OK ] Compressor/CompressorTest.compress_16384/1 (1755 ms)
>>>>> [ RUN      ] Compressor/CompressorTest.compress_16384/2
>>>>> [plugin snappy (snappy)]
>>>>> [       OK ] Compressor/CompressorTest.compress_16384/2 (169 ms)
>>>>> [ RUN      ] Compressor/CompressorTest.compress_16384/3
>>>>> [plugin zstd (zstd)]
>>>>> [       OK ] Compressor/CompressorTest.compress_16384/3 (4528 ms)
>>>>>
>>>>> It's an order of magnitude slower than zlib or snappy, which probably 
>>>>> isn't acceptable--even if it is a bit smaller.
>>
>> i've fixed the zstd compression plugin to use reset stream instead of
>> initializing new objects.
>>
>> What's needed to run only / just the unittest_compression test?
> 
> make unittest_compression && bin/unittest_compression
> 
> should do it!
> 
> sage
> 
