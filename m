From: Sage Weil <sage@newdream.net>
Subject: Re: [ceph-users] ceph zstd not for bluestor due to performance
 reasons
Date: Wed, 25 Oct 2017 19:54:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710251940520.22592@piezo.us.to>
References: <BD0427BB-F720-4746-82F9-E082D2396F56@profihost.ag>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tragedy.dreamhost.com ([66.33.205.236]:57871 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdJYTy3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 25 Oct 2017 15:54:29 -0400
In-Reply-To: <BD0427BB-F720-4746-82F9-E082D2396F56@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: ceph-users@lists.ceph.com, ceph-devel@vger.kernel.org

On Wed, 25 Oct 2017, Stefan Priebe - Profihost AG wrote:
> Hello,
> 
> in the lumious release notes is stated that zstd is not supported by
> bluestor due to performance reason. I'm wondering why btrfs instead
> states that zstd is as fast as lz4 but compresses as good as zlib.
> 
> Why is zlib than supported by bluestor? And why does btrfs / facebook
> behave different?
> 
> "BlueStore supports inline compression using zlib, snappy, or LZ4. (Ceph
> also supports zstd for RGW compression but zstd is not recommended for
> BlueStore for performance reasons.)"

zstd will work but in our testing the performance wasn't great for 
bluestore in particular.  The problem was that for each compression run 
there is a relatively high start-up cost initializing the zstd 
context/state (IIRC a memset of a huge memory buffer) that dominated the 
execution time... primarily because bluestore is generally compressing 
pretty small chunks of data at a time, not big buffers or streams.

Take a look at unittest_compression timings on compressing 16KB buffers 
(smaller than bluestore needs usually, but illustrated of the problem):

[ RUN      ] Compressor/CompressorTest.compress_16384/0
[plugin zlib (zlib/isal)]
[       OK ] Compressor/CompressorTest.compress_16384/0 (294 ms)
[ RUN      ] Compressor/CompressorTest.compress_16384/1
[plugin zlib (zlib/noisal)]
[       OK ] Compressor/CompressorTest.compress_16384/1 (1755 ms)
[ RUN      ] Compressor/CompressorTest.compress_16384/2
[plugin snappy (snappy)]
[       OK ] Compressor/CompressorTest.compress_16384/2 (169 ms)
[ RUN      ] Compressor/CompressorTest.compress_16384/3
[plugin zstd (zstd)]
[       OK ] Compressor/CompressorTest.compress_16384/3 (4528 ms)

It's an order of magnitude slower than zlib or snappy, which probably 
isn't acceptable--even if it is a bit smaller.

We just updated to a newer zstd the other day but I haven't been paying 
attention to the zstd code changes.  When I was working on this the plugin 
was initially also misusing the zstd API, but it was also pointed out 
that the size of the memset is dependent on the compression level.  
Maybe a different (default) choice there woudl help.

https://github.com/facebook/zstd/issues/408#issuecomment-252163241

sage
