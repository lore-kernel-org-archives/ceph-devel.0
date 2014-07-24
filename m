From: "Shu, Xinxin" <xinxin.shu@intel.com>
Subject: RE: First attempt at rocksdb monitor store stress testing
Date: Thu, 24 Jul 2014 05:08:30 +0000
Message-ID: <75674D092A819E4189E91166C74CB90D013F2ACA@shsmsx102.ccr.corp.intel.com>
References: <53D041D3.3080203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:60067 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934058AbaGXFJB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 01:09:01 -0400
In-Reply-To: <53D041D3.3080203@inktank.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi mark,

I think this maybe related to 'verify_checksums' config option ,when ReadOptions is initialized, default this option is  true , all data read from underlying storage will be verified against corresponding checksums,  however,  this option cannot be configured in wip-rocksdb branch. I will modify code to make this option configurable .

Cheers,
xinxin

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Mark Nelson
Sent: Thursday, July 24, 2014 7:14 AM
To: ceph-devel@vger.kernel.org
Subject: First attempt at rocksdb monitor store stress testing

Hi Guys,

So I've been interested lately in leveldb 99th percentile latency (and the amount of write amplification we are seeing) with leveldb. Joao mentioned he has written a tool called mon-store-stress in wip-leveldb-misc to try to provide a means to roughly guess at what's happening on the mons under heavy load.  I cherry-picked it over to wip-rocksdb and after a couple of hacks was able to get everything built and running with some basic tests.  There was little tuning done and I don't know how realistic this workload is, so don't assume this means anything yet, but some initial results are here:

http://nhm.ceph.com/mon-store-stress/First%20Attempt.pdf

Command that was used to run the tests:

./ceph-test-mon-store-stress --mon-keyvaluedb <leveldb|rocksdb> --write-min-size 50K --write-max-size 2M --percent-write 70 --percent-read 30 --keep-state --test-seed 1406137270 --stop-at 5000 foo

The most interesting bit right now is that rocksdb seems to be hanging in the middle of the test (left it running for several hours).  CPU usage on one core was quite high during the hang.  Profiling using perf with dwarf symbols I see:

-  49.14%  ceph-test-mon-s  ceph-test-mon-store-stress  [.] unsigned int rocksdb::crc32c::ExtendImpl<&rocksdb::crc32c::Fast_CRC32>(unsigned int, char const*, unsigned long)
    - unsigned int
rocksdb::crc32c::ExtendImpl<&rocksdb::crc32c::Fast_CRC32>(unsigned int, char const*, unsigned long)
         51.70% rocksdb::ReadBlockContents(rocksdb::RandomAccessFile*,
rocksdb::Footer const&, rocksdb::ReadOptions const&, rocksdb::BlockHandle const&, rocksdb::BlockContents*, rocksdb::Env*, bool)
         48.30%
rocksdb::BlockBasedTableBuilder::WriteRawBlock(rocksdb::Slice const&, rocksdb::CompressionType, rocksdb::BlockHandle*)

Not sure what's going on yet, may need to try to enable logging/debugging in rocksdb.  Thoughts/Suggestions welcome. :)

Mark
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
