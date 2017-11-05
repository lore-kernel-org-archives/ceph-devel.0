From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: [ceph-users] ceph zstd not for bluestor due to performance
 reasons
Date: Sun, 5 Nov 2017 09:07:10 +0100
Message-ID: <5f013ee9-3587-f04c-0005-fa25201a4ecc@profihost.ag>
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
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:21922 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751048AbdKEIHN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Nov 2017 03:07:13 -0500
In-Reply-To: <alpine.DEB.2.11.1711042010330.23234@piezo.novalocal>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

The compression unit test does not work for me:
 bin/unittest_compression
2017-11-05 08:05:36.734567 7f7e8322c180 -1 did not load config file,
using default settings.
2017-11-05 08:05:36.735744 7f7e8322c180 -1 Errors while parsing config file!
2017-11-05 08:05:36.735760 7f7e8322c180 -1 parse_file: cannot open
/etc/ceph/ceph.conf: (2) No such file or directory
2017-11-05 08:05:36.735761 7f7e8322c180 -1 parse_file: cannot open
~/.ceph/ceph.conf: (2) No such file or directory
2017-11-05 08:05:36.735762 7f7e8322c180 -1 parse_file: cannot open
ceph.conf: (2) No such file or directory
2017-11-05 08:05:36.737096 7f7e8322c180 -1 Errors while parsing config file!
2017-11-05 08:05:36.737109 7f7e8322c180 -1 parse_file: cannot open
/etc/ceph/ceph.conf: (2) No such file or directory
2017-11-05 08:05:36.737110 7f7e8322c180 -1 parse_file: cannot open
~/.ceph/ceph.conf: (2) No such file or directory
2017-11-05 08:05:36.737110 7f7e8322c180 -1 parse_file: cannot open
ceph.conf: (2) No such file or directory
[==========] Running 68 tests from 3 test cases.
[----------] Global test environment set-up.
[----------] 3 tests from ZlibCompressor
[ RUN      ] ZlibCompressor.zlib_isal_compatibility
[       OK ] ZlibCompressor.zlib_isal_compatibility (3 ms)
[ RUN      ] ZlibCompressor.isal_compress_zlib_decompress_random
[       OK ] ZlibCompressor.isal_compress_zlib_decompress_random (76 ms)
[ RUN      ] ZlibCompressor.isal_compress_zlib_decompress_walk
[       OK ] ZlibCompressor.isal_compress_zlib_decompress_walk (65 ms)
[----------] 3 tests from ZlibCompressor (144 ms total)

[----------] 1 test from CompressionPlugin
[ RUN      ] CompressionPlugin.all
/build/ceph/src/test/compressor/test_compression.cc:389: Failure
Value of: factory
  Actual: false
Expected: true
2017-11-05 08:05:36.884467 7f7e8322c180 -1 load failed dlopen():
"/usr/lib/ceph/compressor/libceph_invalid.so: cannot open shared object
file: No such file or directory" or "/usr/lib/ceph/libceph_invalid.so:
cannot open shared object file: No such file or directory"
2017-11-05 08:05:36.884528 7f7e8322c180 -1 load failed dlopen():
"/usr/lib/ceph/compressor/libceph_example.so: cannot open shared object
file: No such file or directory" or "/usr/lib/ceph/libceph_example.so:
cannot open shared object file: No such file or directory"
*** Caught signal (Segmentation fault) **

i've no idea why it tries to use libceph_invalid and libceph_example

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
