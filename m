From: Stefan Priebe - Profihost AG <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Subject: Re: ceph zstd not for bluestor due to performance
 reasons
Date: Thu, 26 Oct 2017 08:06:29 +0200
Message-ID: <5cf6f721-05ea-4e38-a6b9-04cff5d6aad3@profihost.ag>
References: <BD0427BB-F720-4746-82F9-E082D2396F56@profihost.ag>
 <alpine.DEB.2.11.1710251940520.22592@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1710251940520.22592-ie3vfNGmdjePKud3HExfWg@public.gmane.org>
Content-Language: de-DE
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi Sage,

Am 25.10.2017 um 21:54 schrieb Sage Weil:
> On Wed, 25 Oct 2017, Stefan Priebe - Profihost AG wrote:
>> Hello,
>>
>> in the lumious release notes is stated that zstd is not supported by
>> bluestor due to performance reason. I'm wondering why btrfs instead
>> states that zstd is as fast as lz4 but compresses as good as zlib.
>>
>> Why is zlib than supported by bluestor? And why does btrfs / facebook
>> behave different?
>>
>> "BlueStore supports inline compression using zlib, snappy, or LZ4. (Ceph
>> also supports zstd for RGW compression but zstd is not recommended for
>> BlueStore for performance reasons.)"
> 
> zstd will work but in our testing the performance wasn't great for 
> bluestore in particular.  The problem was that for each compression run 
> there is a relatively high start-up cost initializing the zstd 
> context/state (IIRC a memset of a huge memory buffer) that dominated the 
> execution time... primarily because bluestore is generally compressing 
> pretty small chunks of data at a time, not big buffers or streams.
> 
> Take a look at unittest_compression timings on compressing 16KB buffers 
> (smaller than bluestore needs usually, but illustrated of the problem):
> 
> [ RUN      ] Compressor/CompressorTest.compress_16384/0
> [plugin zlib (zlib/isal)]
> [       OK ] Compressor/CompressorTest.compress_16384/0 (294 ms)
> [ RUN      ] Compressor/CompressorTest.compress_16384/1
> [plugin zlib (zlib/noisal)]
> [       OK ] Compressor/CompressorTest.compress_16384/1 (1755 ms)
> [ RUN      ] Compressor/CompressorTest.compress_16384/2
> [plugin snappy (snappy)]
> [       OK ] Compressor/CompressorTest.compress_16384/2 (169 ms)
> [ RUN      ] Compressor/CompressorTest.compress_16384/3
> [plugin zstd (zstd)]
> [       OK ] Compressor/CompressorTest.compress_16384/3 (4528 ms)
> 
> It's an order of magnitude slower than zlib or snappy, which probably 
> isn't acceptable--even if it is a bit smaller.
> 
> We just updated to a newer zstd the other day but I haven't been paying 
> attention to the zstd code changes.  When I was working on this the plugin 
> was initially also misusing the zstd API, but it was also pointed out 
> that the size of the memset is dependent on the compression level.  
> Maybe a different (default) choice there woudl help.
> 
> https://github.com/facebook/zstd/issues/408#issuecomment-252163241

thanks for the fast reply. Btrfs uses a default compression level of 3
but i think this is the default anyway.

Does the zstd plugin of ceph already uses the mentioned
ZSTD_resetCStream instead of creating and initializing a new one every time?

So if performance matters ceph would recommand snappy?

Greets,
Stefan
