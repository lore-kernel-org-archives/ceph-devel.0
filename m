From: Sage Weil <sweil@redhat.com>
Subject: Re: question about bluefs log sync
Date: Tue, 29 Aug 2017 13:45:42 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708291344000.20435@piezo.novalocal>
References: <CALi+v18qS_hU0P9_iMxABwZFx5HcdeGbAo00yHBk42i_RJTWJg@mail.gmail.com> <alpine.DEB.2.11.1708291317310.20435@piezo.novalocal> <CALi+v18P3Z2dUdy_7Ve0CQZKh-oRsfmm_CidDNMXart6CMxkXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbdH2Npn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 29 Aug 2017 09:45:43 -0400
In-Reply-To: <CALi+v18P3Z2dUdy_7Ve0CQZKh-oRsfmm_CidDNMXart6CMxkXw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zengran zhang <z13121369189@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 29 Aug 2017, zengran zhang wrote:
> thanks! i open the debug_bluefs to 10, but did not see the
> "_should_compact_log" log when fio is writing the rbd...so how /offen
> will BlueFS::sync_metadata() be called?

Not that often.  We only need to write to the bluefs log when new rocksdb 
files are created.. and they are pretty big.  So it will need to age for 
quite a while before anything happens.

You can get some sense of it by watching the 'ceph daemonperf osd.0' 
output on a running OSD and watching the bluefs.wal column.  There is also 
a bluefs.log_bytes counter in the full perf dump, although you won't see 
the estimated size to compare it against.

sage

> 
> 2017-08-29 21:19 GMT+08:00 Sage Weil <sweil@redhat.com>:
> > On Tue, 29 Aug 2017, zengran zhang wrote:
> >> hi Sage,
> >>     I want to ask when will the bluefs log be compacted? I only sure
> >> it will be compacted when umount the bluefs...
> >> I see the log be compact when rocksdb call Dir.Fsync(), but want to
> >> know how to trigger this...
> >
> > There is a heuristic for when it gets "too big":
> >
> > bool BlueFS::_should_compact_log()
> > {
> >   uint64_t current = log_writer->file->fnode.size;
> >   uint64_t expected = _estimate_log_size();
> >   float ratio = (float)current / (float)expected;
> >   dout(10) << __func__ << " current 0x" << std::hex << current
> >            << " expected " << expected << std::dec
> >            << " ratio " << ratio
> >            << (new_log ? " (async compaction in progress)" : "")
> >            << dendl;
> >   if (new_log ||
> >       current < cct->_conf->bluefs_log_compact_min_size ||
> >       ratio < cct->_conf->bluefs_log_compact_min_ratio) {
> >     return false;
> >   }
> >   return true;
> > }
> >
> > and the estimate for the (compacted) size is
> >
> > uint64_t BlueFS::_estimate_log_size()
> > {
> >   int avg_dir_size = 40;  // fixme
> >   int avg_file_size = 12;
> >   uint64_t size = 4096 * 2;
> >   size += file_map.size() * (1 + sizeof(bluefs_fnode_t));
> >   for (auto& p : block_all)
> >     size += p.num_intervals() * (1 + 1 + sizeof(uint64_t) * 2);
> >   size += dir_map.size() + (1 + avg_dir_size);
> >   size += file_map.size() * (1 + avg_dir_size + avg_file_size);
> >   return ROUND_UP_TO(size, super.block_size);
> > }
> >
> > The default min_ratio is 5... so we compact when it's ~5x bigger than it
> > needs to be.
> >
> > sage
> >
> 
> 
