From: Mark Nelson <mark.nelson@inktank.com>
Subject: First attempt at rocksdb monitor store stress testing
Date: Wed, 23 Jul 2014 18:14:27 -0500
Message-ID: <53D041D3.3080203@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36352 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbaGWXOZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jul 2014 19:14:25 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so2034447igq.9
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jul 2014 16:14:25 -0700 (PDT)
Received: from [192.168.1.3] (184-97-191-94.mpls.qwest.net. [184.97.191.94])
        by mx.google.com with ESMTPSA id v8sm17145874igh.19.2014.07.23.16.14.23
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jul 2014 16:14:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Guys,

So I've been interested lately in leveldb 99th percentile latency (and 
the amount of write amplification we are seeing) with leveldb. Joao 
mentioned he has written a tool called mon-store-stress in 
wip-leveldb-misc to try to provide a means to roughly guess at what's 
happening on the mons under heavy load.  I cherry-picked it over to 
wip-rocksdb and after a couple of hacks was able to get everything built 
and running with some basic tests.  There was little tuning done and I 
don't know how realistic this workload is, so don't assume this means 
anything yet, but some initial results are here:

http://nhm.ceph.com/mon-store-stress/First%20Attempt.pdf

Command that was used to run the tests:

./ceph-test-mon-store-stress --mon-keyvaluedb <leveldb|rocksdb> 
--write-min-size 50K --write-max-size 2M --percent-write 70 
--percent-read 30 --keep-state --test-seed 1406137270 --stop-at 5000 foo

The most interesting bit right now is that rocksdb seems to be hanging 
in the middle of the test (left it running for several hours).  CPU 
usage on one core was quite high during the hang.  Profiling using perf 
with dwarf symbols I see:

-  49.14%  ceph-test-mon-s  ceph-test-mon-store-stress  [.] unsigned int 
rocksdb::crc32c::ExtendImpl<&rocksdb::crc32c::Fast_CRC32>(unsigned int, 
char const*, unsigned long)
    - unsigned int 
rocksdb::crc32c::ExtendImpl<&rocksdb::crc32c::Fast_CRC32>(unsigned int, 
char const*, unsigned long)
         51.70% rocksdb::ReadBlockContents(rocksdb::RandomAccessFile*, 
rocksdb::Footer const&, rocksdb::ReadOptions const&, 
rocksdb::BlockHandle const&, rocksdb::BlockContents*, rocksdb::Env*, bool)
         48.30% 
rocksdb::BlockBasedTableBuilder::WriteRawBlock(rocksdb::Slice const&, 
rocksdb::CompressionType, rocksdb::BlockHandle*)

Not sure what's going on yet, may need to try to enable 
logging/debugging in rocksdb.  Thoughts/Suggestions welcome. :)

Mark
