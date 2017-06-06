From: Xiaoxi Chen <superdebuger@gmail.com>
Subject: Re: blustore: revisiting rocksdb buffer settings
Date: Tue, 6 Jun 2017 23:23:28 +0800
Message-ID: <CAEYCsVJW8WKc=F1eBGSfrQse3LvMDX8+r2radwryUp4EeZcQ8w@mail.gmail.com>
References: <e71c9cf6-9db5-36f7-fc98-81e24b0c67fe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:33729 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdFFPXa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Jun 2017 11:23:30 -0400
Received: by mail-ot0-f175.google.com with SMTP id k4so17502774otd.0
        for <ceph-devel@vger.kernel.org>; Tue, 06 Jun 2017 08:23:30 -0700 (PDT)
In-Reply-To: <e71c9cf6-9db5-36f7-fc98-81e24b0c67fe@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Mark,
      Cool data, wondering if we take the compaction wallclock time
into account, is 32MB memtable still showing advantage on CPU
consumption?  I am expecting 256MB is better as compaction workload
reduced significantly.

Xiaoxi

2017-06-02 21:48 GMT+08:00 Mark Nelson <mnelson@redhat.com>:
> Hi all,
>
> Last fall we ran through some tests to try to determine how many and what
> size write buffers (ie the memtable size) should be used in rocksdb for
> bluestore:
>
> https://drive.google.com/file/d/0B2gTBZrkrnpZRFdiYjFRNmxLblU/view?usp=sharing
>
> As a result of that analysis, we chose to use larger than expected buffers.
> The advantage is that the number of compaction events and total amount of
> compacted data is greatly reduced in the tests we ran. The downside is that
> working on larger memtables is potentially slower.
>
> Since we did that analysis last fall, we've made a number of changes that
> potentially could affect the results. Specifically, we discovered that the
> compaction thread was under extremely heavy load, even with large buffers,
> doing small sequential reads due to a lack of compaction readahead.  The
> compaction thread is much less busy after that fix, so we decided to run a
> couple of new, smaller scale tests to verify our original findings.  As
> opposed to the previous tests, these tests were only run against a single
> OSD and used a larger 512GB RBD volume where not all of the onodes could fit
> in the bluestore cache.  Measurements were taken after the volume was
> pre-filled with 4MB writes followed by a 5 minute 4k random write workload.
>
> https://drive.google.com/file/d/0B2gTBZrkrnpZVXpzR2JNRmR0WFE/view?usp=sharing
>
> In these results, the effect of compaction on client IO is dramatically
> lower since the OSD is spending a significant amount of time doing onode
> reads from the DB.  Having said that, DB and compaction statistics still
> show a dramatic reduction in reads, writes, and write-amp when larger
> buffers/memtables are used.
>
> The question of whether or not the large memtables might be hurting in other
> ways remains.  To examine this, additional tests were run, this time with a
> smaller 16GB RBD volume so that all onodes stay in cache. 4k random write
> tests with 4 256MB and 32MB buffers were compared. Using 256MB buffers
> provided around a 10% performance advantage vs 32MB buffers, however tests
> with 32MB buffers showed less time spent doing key comparisons when adding
> data to the Memtables in kv_sync_thread:
>
> 32MB buffers:
>
> 34.45% rocksdb::MemTable::Add
> + 20.40% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator
> const&>::Insert<false>
> | + 18.65% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator
> const&>::RecomputeSpliceLevels
> | | + 18.45% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator
> const&>::FindSpliceForLevel
> | |   + 16.00% KeyIsAfterNode
> | |   | + 15.60% rocksdb::MemTable::KeyComparator::operator()
> | |   |   + 10.25% rocksdb::InternalKeyComparator::Compare
> | |   |   | + 6.95% rocksdb::(anonymous
> namespace)::BytewiseComparatorImpl::Compare
> | |   |   | | + 6.30% compare
> | |   |   | |   + 5.55% __memcmp_sse4_1
> | |   |   | |   + 0.10% memcmp@plt
> | |   |   | + 0.10% ExtractUserKey
> | |   |   + 4.00% GetLengthPrefixedSlice
> | |   |     + 0.45% GetVarint32Ptr
>
> 256MB buffers:
>
> 43.20% rocksdb::MemTable::Add
> + 30.85% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator
> const&>::Insert<false>
> | + 29.15% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator
> const&>::RecomputeSpliceLevels
> | | + 28.70% rocksdb::InlineSkipList<rocksdb::MemTableRep::KeyComparator
> const&>::FindSpliceForLevel
> | |   + 25.50% KeyIsAfterNode
> | |   | + 24.90% rocksdb::MemTable::KeyComparator::operator()
> | |   |   + 13.05% rocksdb::InternalKeyComparator::Compare
> | |   |   | + 9.35% rocksdb::(anonymous
> namespace)::BytewiseComparatorImpl::Compare
> | |   |   | | + 8.50% compare
> | |   |   | |   + 7.55% __memcmp_sse4_1
> | |   |   | |   + 0.30% memcmp@plt
> | |   |   | + 0.55% ExtractUserKey
> | |   |   + 10.05% GetLengthPrefixedSlice
> | |   |     + 2.05% GetVarint32Ptr
>
> So the takeaway here is that larger buffers still provide a performance
> advantage likely due to a much better compaction workload, but are causing
> the kv_sync_thread to spend more wallclock time and burn more CPU processing
> the memtable in KeyIsAfterNode. Using smaller buffers reduces the time spent
> from ~25.5% to ~16% during the actual writes, but results in higher write
> amp, more writes, and more reads during compaction.  Ultimately all of this
> only really matters if the onodes are kept in cache since cache misses
> quickly become a major bottleneck when the cache isn't large enough to hold
> all onodes in random write scenarios.
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
