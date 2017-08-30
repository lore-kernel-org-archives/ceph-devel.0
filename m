From: zengran zhang <z13121369189@gmail.com>
Subject: Re: question about bluefs log sync
Date: Wed, 30 Aug 2017 09:14:45 +0800
Message-ID: <CALi+v1-vfvOS880iGFjnbw8iFuHA3Ng8BxUyDNa3f-3op-yhSA@mail.gmail.com>
References: <CALi+v18qS_hU0P9_iMxABwZFx5HcdeGbAo00yHBk42i_RJTWJg@mail.gmail.com>
 <alpine.DEB.2.11.1708291317310.20435@piezo.novalocal> <CALi+v18P3Z2dUdy_7Ve0CQZKh-oRsfmm_CidDNMXart6CMxkXw@mail.gmail.com>
 <alpine.DEB.2.11.1708291344000.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:36453 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdH3BOq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Aug 2017 21:14:46 -0400
Received: by mail-it0-f52.google.com with SMTP id o132so807288itc.1
        for <ceph-devel@vger.kernel.org>; Tue, 29 Aug 2017 18:14:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708291344000.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org

hi Sage,
    I wrote 100% size of 4T rbd, the log seemed never been
compact...the perfcounter output as follow:
    "bluefs": {
        "gift_bytes": 0,
        "reclaim_bytes": 0,
        "db_total_bytes": 16106119168,
        "db_used_bytes": 16106119168,
        "wal_total_bytes": 5368705024,
        "wal_used_bytes": 5368705024,
        "slow_total_bytes": 79153848320,
        "slow_used_bytes": 2502942720,
        "num_files": 33,
        "log_bytes": 4380053504,
        "log_compactions": 0,
        "logged_bytes": 4378685440,
        "files_written_wal": 26,
        "files_written_sst": 206,
        "bytes_written_wal": 8219878782,
        "bytes_written_sst": 12998417672
    },
    my ceph version is 12.0.2
    bluestore_rocksdb_options = compression=kNoCompression,
max_write_buffer_number=2, min_write_buffer_number_to_merge=1,
write_buffer_size=268435456, writable_file_max_buffer_size=0

    missing any rocksdb options cause the problem?

    Thanks & Regards!

2017-08-29 21:45 GMT+08:00 Sage Weil <sweil@redhat.com>:
> On Tue, 29 Aug 2017, zengran zhang wrote:
>> thanks! i open the debug_bluefs to 10, but did not see the
>> "_should_compact_log" log when fio is writing the rbd...so how /offen
>> will BlueFS::sync_metadata() be called?
>
> Not that often.  We only need to write to the bluefs log when new rocksdb
> files are created.. and they are pretty big.  So it will need to age for
> quite a while before anything happens.
>
> You can get some sense of it by watching the 'ceph daemonperf osd.0'
> output on a running OSD and watching the bluefs.wal column.  There is also
> a bluefs.log_bytes counter in the full perf dump, although you won't see
> the estimated size to compare it against.
>
> sage
>
>>
>> 2017-08-29 21:19 GMT+08:00 Sage Weil <sweil@redhat.com>:
>> > On Tue, 29 Aug 2017, zengran zhang wrote:
>> >> hi Sage,
>> >>     I want to ask when will the bluefs log be compacted? I only sure
>> >> it will be compacted when umount the bluefs...
>> >> I see the log be compact when rocksdb call Dir.Fsync(), but want to
>> >> know how to trigger this...
>> >
>> > There is a heuristic for when it gets "too big":
>> >
>> > bool BlueFS::_should_compact_log()
>> > {
>> >   uint64_t current = log_writer->file->fnode.size;
>> >   uint64_t expected = _estimate_log_size();
>> >   float ratio = (float)current / (float)expected;
>> >   dout(10) << __func__ << " current 0x" << std::hex << current
>> >            << " expected " << expected << std::dec
>> >            << " ratio " << ratio
>> >            << (new_log ? " (async compaction in progress)" : "")
>> >            << dendl;
>> >   if (new_log ||
>> >       current < cct->_conf->bluefs_log_compact_min_size ||
>> >       ratio < cct->_conf->bluefs_log_compact_min_ratio) {
>> >     return false;
>> >   }
>> >   return true;
>> > }
>> >
>> > and the estimate for the (compacted) size is
>> >
>> > uint64_t BlueFS::_estimate_log_size()
>> > {
>> >   int avg_dir_size = 40;  // fixme
>> >   int avg_file_size = 12;
>> >   uint64_t size = 4096 * 2;
>> >   size += file_map.size() * (1 + sizeof(bluefs_fnode_t));
>> >   for (auto& p : block_all)
>> >     size += p.num_intervals() * (1 + 1 + sizeof(uint64_t) * 2);
>> >   size += dir_map.size() + (1 + avg_dir_size);
>> >   size += file_map.size() * (1 + avg_dir_size + avg_file_size);
>> >   return ROUND_UP_TO(size, super.block_size);
>> > }
>> >
>> > The default min_ratio is 5... so we compact when it's ~5x bigger than it
>> > needs to be.
>> >
>> > sage
>> >
>>
>>
