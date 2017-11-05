From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: [ceph-users] ceph zstd not for bluestor due to performance
 reasons
Date: Sun, 5 Nov 2017 09:18:48 +0100
Message-ID: <1b92a9b5-23a2-bd1b-2701-6439a3c2f701@profihost.ag>
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
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:41867 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750932AbdKEISu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Nov 2017 03:18:50 -0500
In-Reply-To: <alpine.DEB.2.11.1711042010330.23234@piezo.novalocal>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

Hi,

ok got it running by using:

 bin/unittest_compression --compression-dir=lib --plugin-dir=lib

Results:
[----------] 64 tests from Compressor/CompressorTest
[ RUN      ] Compressor/CompressorTest.load_plugin/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.load_plugin/0 (3 ms)
[ RUN      ] Compressor/CompressorTest.load_plugin/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.load_plugin/1 (2 ms)
[ RUN      ] Compressor/CompressorTest.load_plugin/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.load_plugin/2 (2 ms)
[ RUN      ] Compressor/CompressorTest.load_plugin/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.load_plugin/3 (3 ms)
[ RUN      ] Compressor/CompressorTest.small_round_trip/0
[plugin zlib (zlib/isal)]
orig 77 compressed 168 with zlib/isal
[       OK ] Compressor/CompressorTest.small_round_trip/0 (3 ms)
[ RUN      ] Compressor/CompressorTest.small_round_trip/1
[plugin zlib (zlib/noisal)]
orig 77 compressed 66 with zlib/noisal
[       OK ] Compressor/CompressorTest.small_round_trip/1 (2 ms)
[ RUN      ] Compressor/CompressorTest.small_round_trip/2
[plugin snappy (snappy)]
orig 77 compressed 74 with snappy
[       OK ] Compressor/CompressorTest.small_round_trip/2 (2 ms)
[ RUN      ] Compressor/CompressorTest.small_round_trip/3
[plugin zstd (zstd)]
orig 77 compressed 79 with zstd
[       OK ] Compressor/CompressorTest.small_round_trip/3 (2 ms)
[ RUN      ] Compressor/CompressorTest.big_round_trip_repeated/0
[plugin zlib (zlib/isal)]
orig 4194344 compressed 54878 with zlib/isal
[       OK ] Compressor/CompressorTest.big_round_trip_repeated/0 (41 ms)
[ RUN      ] Compressor/CompressorTest.big_round_trip_repeated/1
[plugin zlib (zlib/noisal)]
orig 4194344 compressed 14306 with zlib/noisal
[       OK ] Compressor/CompressorTest.big_round_trip_repeated/1 (64 ms)
[ RUN      ] Compressor/CompressorTest.big_round_trip_repeated/2
[plugin snappy (snappy)]
orig 4194344 compressed 201194 with snappy
[       OK ] Compressor/CompressorTest.big_round_trip_repeated/2 (22 ms)
[ RUN      ] Compressor/CompressorTest.big_round_trip_repeated/3
[plugin zstd (zstd)]
orig 4194344 compressed 472 with zstd
[       OK ] Compressor/CompressorTest.big_round_trip_repeated/3 (21 ms)
[ RUN      ] Compressor/CompressorTest.big_round_trip_randomish/0
[plugin zlib (zlib/isal)]
orig 10485760 compressed 5989211 with zlib/isal
[       OK ] Compressor/CompressorTest.big_round_trip_randomish/0 (415 ms)
[ RUN      ] Compressor/CompressorTest.big_round_trip_randomish/1
[plugin zlib (zlib/noisal)]
orig 10485760 compressed 4928804 with zlib/noisal
[       OK ] Compressor/CompressorTest.big_round_trip_randomish/1 (1151 ms)
[ RUN      ] Compressor/CompressorTest.big_round_trip_randomish/2
[plugin snappy (snappy)]
orig 10485760 compressed 8683058 with snappy
[       OK ] Compressor/CompressorTest.big_round_trip_randomish/2 (300 ms)
[ RUN      ] Compressor/CompressorTest.big_round_trip_randomish/3
[plugin zstd (zstd)]
orig 10485760 compressed 4829428 with zstd
[       OK ] Compressor/CompressorTest.big_round_trip_randomish/3 (1444 ms)
[ RUN      ] Compressor/CompressorTest.compress_decompress/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.compress_decompress/0 (3 ms)
[ RUN      ] Compressor/CompressorTest.compress_decompress/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.compress_decompress/1 (2 ms)
[ RUN      ] Compressor/CompressorTest.compress_decompress/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.compress_decompress/2 (1 ms)
[ RUN      ] Compressor/CompressorTest.compress_decompress/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.compress_decompress/3 (1 ms)
[ RUN      ] Compressor/CompressorTest.sharded_input_decompress/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.sharded_input_decompress/0 (3 ms)
[ RUN      ] Compressor/CompressorTest.sharded_input_decompress/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.sharded_input_decompress/1 (3 ms)
[ RUN      ] Compressor/CompressorTest.sharded_input_decompress/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.sharded_input_decompress/2 (2 ms)
[ RUN      ] Compressor/CompressorTest.sharded_input_decompress/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.sharded_input_decompress/3 (1 ms)
[ RUN      ] Compressor/CompressorTest.compress_1024/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.compress_1024/0 (73 ms)
[ RUN      ] Compressor/CompressorTest.compress_1024/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.compress_1024/1 (614 ms)
[ RUN      ] Compressor/CompressorTest.compress_1024/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.compress_1024/2 (15 ms)
[ RUN      ] Compressor/CompressorTest.compress_1024/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.compress_1024/3 (566 ms)
[ RUN      ] Compressor/CompressorTest.compress_2048/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.compress_2048/0 (102 ms)
[ RUN      ] Compressor/CompressorTest.compress_2048/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.compress_2048/1 (819 ms)
[ RUN      ] Compressor/CompressorTest.compress_2048/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.compress_2048/2 (18 ms)
[ RUN      ] Compressor/CompressorTest.compress_2048/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.compress_2048/3 (1721 ms)
[ RUN      ] Compressor/CompressorTest.compress_4096/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.compress_4096/0 (150 ms)
[ RUN      ] Compressor/CompressorTest.compress_4096/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.compress_4096/1 (1103 ms)
[ RUN      ] Compressor/CompressorTest.compress_4096/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.compress_4096/2 (61 ms)
[ RUN      ] Compressor/CompressorTest.compress_4096/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.compress_4096/3 (2206 ms)
[ RUN      ] Compressor/CompressorTest.compress_8192/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.compress_8192/0 (193 ms)
[ RUN      ] Compressor/CompressorTest.compress_8192/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.compress_8192/1 (1457 ms)
[ RUN      ] Compressor/CompressorTest.compress_8192/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.compress_8192/2 (114 ms)
[ RUN      ] Compressor/CompressorTest.compress_8192/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.compress_8192/3 (3121 ms)
[ RUN      ] Compressor/CompressorTest.compress_16384/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.compress_16384/0 (288 ms)
[ RUN      ] Compressor/CompressorTest.compress_16384/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.compress_16384/1 (2090 ms)
[ RUN      ] Compressor/CompressorTest.compress_16384/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.compress_16384/2 (202 ms)
[ RUN      ] Compressor/CompressorTest.compress_16384/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.compress_16384/3 (4561 ms)
[ RUN      ] Compressor/CompressorTest.decompress_1024/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.decompress_1024/0 (176 ms)
[ RUN      ] Compressor/CompressorTest.decompress_1024/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.decompress_1024/1 (108 ms)
[ RUN      ] Compressor/CompressorTest.decompress_1024/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.decompress_1024/2 (7 ms)
[ RUN      ] Compressor/CompressorTest.decompress_1024/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.decompress_1024/3 (12 ms)
[ RUN      ] Compressor/CompressorTest.decompress_2048/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.decompress_2048/0 (220 ms)
[ RUN      ] Compressor/CompressorTest.decompress_2048/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.decompress_2048/1 (145 ms)
[ RUN      ] Compressor/CompressorTest.decompress_2048/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.decompress_2048/2 (9 ms)
[ RUN      ] Compressor/CompressorTest.decompress_2048/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.decompress_2048/3 (133 ms)
[ RUN      ] Compressor/CompressorTest.decompress_4096/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.decompress_4096/0 (287 ms)
[ RUN      ] Compressor/CompressorTest.decompress_4096/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.decompress_4096/1 (195 ms)
[ RUN      ] Compressor/CompressorTest.decompress_4096/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.decompress_4096/2 (28 ms)
[ RUN      ] Compressor/CompressorTest.decompress_4096/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.decompress_4096/3 (577 ms)
[ RUN      ] Compressor/CompressorTest.decompress_8192/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.decompress_8192/0 (384 ms)
[ RUN      ] Compressor/CompressorTest.decompress_8192/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.decompress_8192/1 (266 ms)
[ RUN      ] Compressor/CompressorTest.decompress_8192/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.decompress_8192/2 (59 ms)
[ RUN      ] Compressor/CompressorTest.decompress_8192/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.decompress_8192/3 (1024 ms)
[ RUN      ] Compressor/CompressorTest.decompress_16384/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.decompress_16384/0 (552 ms)
[ RUN      ] Compressor/CompressorTest.decompress_16384/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.decompress_16384/1 (396 ms)
[ RUN      ] Compressor/CompressorTest.decompress_16384/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.decompress_16384/2 (132 ms)
[ RUN      ] Compressor/CompressorTest.decompress_16384/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.decompress_16384/3 (1449 ms)
[----------] 64 tests from Compressor/CompressorTest (29128 ms total)


Greets,
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
