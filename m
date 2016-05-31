From: Mark Nelson <mnelson@redhat.com>
Subject: Re: RocksDB Incorrect API Usage
Date: Tue, 31 May 2016 11:56:20 -0500
Message-ID: <0282d904-1213-00cd-caee-c84d6b88492f@redhat.com>
References: <CACJqLyYtHkeQ+jSNi7JPJzRb6wfCcNAuCSr_YyTwdqA_kzzP_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51645 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730AbcEaQ4X (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 May 2016 12:56:23 -0400
In-Reply-To: <CACJqLyYtHkeQ+jSNi7JPJzRb6wfCcNAuCSr_YyTwdqA_kzzP_g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/31/2016 11:49 AM, Haomai Wang wrote:
> Hi Sage and Mark,
>
> As mentioned in BlueStore standup, I found rocksdb iterator *Seek*
> won't use bloom filter like *Get*.
>
> *Get* impl: it will look at filter firstly
> https://github.com/facebook/rocksdb/blob/master/table/block_based_table_reader.cc#L1369
>
> Iterator *Seek*: it will do binary search, by default we don't specify
> prefix feature(https://github.com/facebook/rocksdb/wiki/Prefix-Seek-API-Changes).
> https://github.com/facebook/rocksdb/blob/master/table/block.cc#L94
>
> So I use a simple tests:
>
> ./db_bench -num 10000000  -benchmarks fillbatch
> fill the db firstly with 1000w records.
>
> ./db_bench -use_existing_db  -benchmarks readrandomfast
> readrandomfast case will use *Get* API to retrive data
>
> [root@hunter-node2 rocksdb]# ./db_bench -use_existing_db  -benchmarks
> readrandomfast
>
> LevelDB:    version 4.3
> Date:       Wed Jun  1 00:29:16 2016
> CPU:        32 * Intel(R) Xeon(R) CPU E5-2680 0 @ 2.70GHz
> CPUCache:   20480 KB
> Keys:       16 bytes each
> Values:     100 bytes each (50 bytes after compression)
> Entries:    1000000
> Prefix:    0 bytes
> Keys per prefix:    0
> RawSize:    110.6 MB (estimated)
> FileSize:   62.9 MB (estimated)
> Writes per second: 0
> Compression: Snappy
> Memtablerep: skip_list
> Perf Level: 0
> WARNING: Assertions are enabled; benchmarks unnecessarily slow
> ------------------------------------------------
> DB path: [/tmp/rocksdbtest-0/dbbench]
> readrandomfast :       4.570 micros/op 218806 ops/sec; (1000100 of
> 1000100 found, issued 46639 non-exist keys)
>
> ===========================
> then I modify readrandomfast to use Iterator API[0]:
>
> [root@hunter-node2 rocksdb]# ./db_bench -use_existing_db  -benchmarks
> readrandomfast
> LevelDB:    version 4.3
> Date:       Wed Jun  1 00:33:03 2016
> CPU:        32 * Intel(R) Xeon(R) CPU E5-2680 0 @ 2.70GHz
> CPUCache:   20480 KB
> Keys:       16 bytes each
> Values:     100 bytes each (50 bytes after compression)
> Entries:    1000000
> Prefix:    0 bytes
> Keys per prefix:    0
> RawSize:    110.6 MB (estimated)
> FileSize:   62.9 MB (estimated)
> Writes per second: 0
> Compression: Snappy
> Memtablerep: skip_list
> Perf Level: 0
> WARNING: Assertions are enabled; benchmarks unnecessarily slow
> ------------------------------------------------
> DB path: [/tmp/rocksdbtest-0/dbbench]
> readrandomfast :      45.188 micros/op 22129 ops/sec; (1000100 of
> 1000100 found, issued 46639 non-exist keys)
>
>
> 45.18 us/op vs 4.57us/op!
>
> The test can be repeated and easy to do! Plz correct if I'm doing
> foolish thing I'm not aware..

Excellent catch Haomai!  I'm not sure I will be able to test before I 
leave on holiday, but if I do I will report back.  Do you think upstream 
rocksdb can be improved to make the iterator implementation faster?

>
> So I proposal this PR: https://github.com/ceph/ceph/pull/9411
>
> We still can make further improvements by scanning all iterate usage
> to make it better!
>
> [0]:
> --- a/db/db_bench.cc
> +++ b/db/db_bench.cc
> @@ -2923,14 +2923,12 @@ class Benchmark {
>          int64_t key_rand = thread->rand.Next() & (pot - 1);
>          GenerateKeyFromInt(key_rand, FLAGS_num, &key);
>          ++read;
> -        auto status = db->Get(options, key, &value);
> -        if (status.ok()) {
> -          ++found;
> -        } else if (!status.IsNotFound()) {
> -          fprintf(stderr, "Get returned an error: %s\n",
> -                  status.ToString().c_str());
> -          abort();
> -        }
> +        Iterator* iter = db->NewIterator(options);
> +      iter->Seek(key);
> +      if (iter->Valid() && iter->key().compare(key) == 0) {
> +        found++;
> +      }
> +
>          if (key_rand >= FLAGS_num) {
>            ++nonexist;
>          }
>
