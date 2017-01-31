From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: aio stalls in recent BlueStore
Date: Tue, 31 Jan 2017 14:35:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701311432120.3654@piezo.novalocal>
References: <08639759-b895-69fa-acd1-c6530a4f3f02@mirantis.com> <950145cc-94e3-79a9-74a5-9c88b0cfc21d@mirantis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47147 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdAaPAH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2017 10:00:07 -0500
In-Reply-To: <950145cc-94e3-79a9-74a5-9c88b0cfc21d@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 31 Jan 2017, Igor Fedotov wrote:
> The issue was introduced by commit:
> 
> c776710a8ec04a2fd810fc5a1899fa8868cbc80a
> 
> os/bluestore/BlueFS: increase size threshold before we flush
> 
> Mainly the bug applies to 'dummy' writes i.e. writes hat update object
> metadata only (enabled by bluestore_debug_omit_block_device_write=true )
> 
> See http://tracker.ceph.com/issues/18742
> 
> for more details.

That's super weird!  It looks to me like the small flush size is masking 
some underlying bug, since the IO submitted earlier is what takes >90s to 
complete.  A few thoughts:

1- We can verify the device is actually doing the IO by capturing a 
blktrace during the run...

2- We've had bugs in the past with subtle races or missed wakeups in the 
aio completion path.  This is my guess...  were there any other aios 
that were submitted and/or completed when the aio finally came back?  It's 
odd that it is always ~90s.

sage



> 
> Thanks,
> 
> Igor
> 
> 
> -------- Forwarded Message --------
> Subject:     aio stalls in recent BlueStore
> Date:     Mon, 30 Jan 2017 20:34:09 +0300
> From:     Igor Fedotov <ifedotov@mirantis.com>
> To:     ceph-devel <ceph-devel@vger.kernel.org>
> 
> 
> Hi,
> 
> as I mentioned during BlueStore standup I'm observing write stalls when
> performing append-only test  case from FIO.
> 
> Here is a log snippet.
> 
> Full log is available at
> https://drive.google.com/file/d/0B-4q9QFReegLd1lNVTdzUXRxZ2M/view?usp=sharing
> 
> Look for "LONG AIO_WAIT!!!" to locate all the occurrences.
> 
> Master branch clone made at mid December doesn't have the issue.
> 
> 2017-01-30 17:08:01.563477 7f72497f2700 20
> bdev(./fio-bluestore/block.wal) aio_write 0x233a000~81000 (direct)
> 2017-01-30 17:08:01.563650 7f72497f2700 20
> bdev(./fio-bluestore/block.wal) aio_write rebuilding buffer to be aligned
> 2017-01-30 17:08:01.563660 7f72497f2700 20
> bdev(./fio-bluestore/block.wal) _aio_log_start 0x233a000~81000
> 2017-01-30 17:08:01.563666 7f72497f2700  5
> bdev(./fio-bluestore/block.wal) aio_write 0x233a000~81000 aio 0x7f72301b3940
> 2017-01-30 17:08:01.563669 7f72497f2700 20
> bdev(./fio-bluestore/block.wal) aio_submit ioc 0x7f7230091ee0 pending 1
> running 0
> 2017-01-30 17:08:01.563671 7f72497f2700 20
> bdev(./fio-bluestore/block.wal) aio_submit  aio 0x7f72301b3940 fd 13
> 0x233a000~81000
> 2017-01-30 17:08:01.563757 7f72497f2700 20 bluefs _flush_range h
> 0x7f72301dd090 pos now 0x1eba17c
> 
> 2017-01-30 17:08:01.563807 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 537 < min_flush_size 524288
> 2017-01-30 17:08:01.563831 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 1080 < min_flush_size 524288
> 2017-01-30 17:08:01.563851 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 1618 < min_flush_size 524288
> 2017-01-30 17:08:01.563874 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 2163 < min_flush_size 524288
> 2017-01-30 17:08:01.563896 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 2701 < min_flush_size 524288
> 2017-01-30 17:08:01.563923 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 3239 < min_flush_size 524288
> 2017-01-30 17:08:01.563947 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 3776 < min_flush_size 524288
> 2017-01-30 17:08:01.563971 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 4320 < min_flush_size 524288
> 2017-01-30 17:08:01.563995 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 4864 < min_flush_size 524288
> 2017-01-30 17:08:01.564026 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 5409 < min_flush_size 524288
> 2017-01-30 17:08:01.564043 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 5946 < min_flush_size 524288
> 2017-01-30 17:08:01.564069 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 6483 < min_flush_size 524288
> 2017-01-30 17:08:01.564097 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 7028 < min_flush_size 524288
> 2017-01-30 17:08:01.564120 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 7565 < min_flush_size 524288
> 2017-01-30 17:08:01.564141 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 8103 < min_flush_size 524288
> 2017-01-30 17:08:01.564163 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 8646 < min_flush_size 524288
> 2017-01-30 17:08:01.564180 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 9183 < min_flush_size 524288
> 2017-01-30 17:08:01.564204 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 9720 < min_flush_size 524288
> 2017-01-30 17:08:01.564225 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 10265 < min_flush_size 524288
> 2017-01-30 17:08:01.564253 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 10802 < min_flush_size 524288
> 2017-01-30 17:08:01.564275 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 11346 < min_flush_size 524288
> 2017-01-30 17:08:01.564297 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 11883 < min_flush_size 524288
> 2017-01-30 17:08:01.564331 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 12426 < min_flush_size 524288
> 2017-01-30 17:08:01.564357 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 12963 < min_flush_size 524288
> 2017-01-30 17:08:01.564379 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 13508 < min_flush_size 524288
> 2017-01-30 17:08:01.564408 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 14051 < min_flush_size 524288
> 2017-01-30 17:08:01.564431 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 14595 < min_flush_size 524288
> 2017-01-30 17:08:01.564499 7f72497f2700 10 bluefs get_usage bdev 0 free
> 160581025792 (149 GB) / 161061269504 (149 GB), used 0%
> 2017-01-30 17:08:01.564510 7f72497f2700 10 bluefs get_usage bdev 1 free
> 107338530816 (102366 MB) / 107373125632 (102398 MB), used 0%
> 2017-01-30 17:08:01.564513 7f72497f2700 10 bluefs get_usage bdev 2 free
> 15032385536 (14336 MB) / 15033425920 (14336 MB), used 0%
> 2017-01-30 17:08:01.564519 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 14618 < min_flush_size 524288
> 2017-01-30 17:08:01.564521 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> ignoring, length 14618 < min_flush_size 524288
> 2017-01-30 17:08:01.564524 7f72497f2700 10 bluefs _fsync 0x7f72301dd090
> file(ino 15 size 0xdbe066c mtime 2017-01-30 17:07:58.151831 bdev 0
> extents [0:0x500000+c400000,0:0xcd00000+1800000])
> 2017-01-30 17:08:01.564538 7f72497f2700 10 bluefs _flush 0x7f72301dd090
> 0x1eba17c~391a to file(ino 15 size 0xdbe066c mtime 2017-01-30
> 17:07:58.151831 bdev 0 extents [0:0x500000+c400000,0:0xcd00000+1800000])
> 2017-01-30 17:08:01.564543 7f72497f2700 10 bluefs _flush_range
> 0x7f72301dd090 pos 0x1eba17c 0x1eba17c~391a to file(ino 15 size
> 0xdbe066c mtime 2017-01-30 17:07:58.151831 bdev 0 extents
> [0:0x500000+c400000,0:0xcd00000+1800000])
> 2017-01-30 17:08:01.564548 7f72497f2700 20 bluefs _flush_range file now
> file(ino 15 size 0xdbe066c mtime 2017-01-30 17:07:58.151831 bdev 0
> extents [0:0x500000+c400000,0:0xcd00000+1800000])
> 2017-01-30 17:08:01.564555 7f72497f2700 20 bluefs _flush_range in
> 0:0x500000+c400000 x_off 0x1eba17c
> 2017-01-30 17:08:01.564558 7f72497f2700 20 bluefs _flush_range using
> partial tail 0x17c
> 2017-01-30 17:08:01.564560 7f72497f2700 20 bluefs _flush_range waiting
> for previous aio to complete
> 2017-01-30 17:08:01.564562 7f72497f2700 10 bdev aio_wait 0x7f7230091ee0
> waiting for 1 aios and/or 0 readers to complete
> 
> >>>>>90 seconds!
> 
> 2017-01-30 17:09:32.117785 7f725d108700 20
> bdev(./fio-bluestore/block.wal) _aio_log_finish 1 0x233a000~81000
> 2017-01-30 17:09:32.117819 7f725d108700 10
> bdev(./fio-bluestore/block.wal) _aio_thread finished aio 0x7f72301b3940
> r 528384 ioc 0x7f7230091ee0 with  aios left
> 2017-01-30 17:09:32.117886 7f72497f2700 20 bdev aio_wait 0x7f7230091ee0 done
> 2017-01-30 17:09:32.117904 7f72497f2700 -1 bdev LONG AIO_WAIT!!!
> 2017-01-30 17:09:32.117914 7f72497f2700 20 bdev aio_wait 0x7f7230083f60 done
> 2017-01-30 17:09:32.117949 7f72497f2700 20 bdev aio_wait 0x7f72301ae810 done
> 2017-01-30 17:09:32.118018 7f72497f2700 20 bluefs _flush_range caching
> tail of 0xa96 and padding block with 0x56a
> 2017-01-30 17:09:32.118043 7f72497f2700 20
> bdev(./fio-bluestore/block.wal) aio_write 0x23ba000~4000 (direct)
> 2017-01-30 17:09:32.118100 7f72497f2700 20
> bdev(./fio-bluestore/block.wal) aio_write rebuilding buffer to be aligned
> 2017-01-30 17:09:32.118109 7f72497f2700 20
> bdev(./fio-bluestore/block.wal) _aio_log_start 0x23ba000~4000
> 2017-01-30 17:09:32.118123 7f72497f2700  5
> bdev(./fio-bluestore/block.wal) aio_write 0x23ba000~4000 aio 0x7f723000d6d0
> 2017-01-30 17:09:32.118127 7f72497f2700 20
> bdev(./fio-bluestore/block.wal) aio_submit ioc 0x7f7230091ee0 pending 1
> running 0
> 2017-01-30 17:09:32.118133 7f72497f2700 20
> bdev(./fio-bluestore/block.wal) aio_submit  aio 0x7f723000d6d0 fd 13
> 0x23ba000~4000
> 2017-01-30 17:09:32.118205 7f72497f2700 20 bluefs _flush_range h
> 0x7f72301dd090 pos now 0x1ebda96
> 2017-01-30 17:09:32.118219 7f72497f2700 10 bluefs _claim_completed_aios
> got 2 aios
> 2017-01-30 17:09:32.118224 7f72497f2700 10 bluefs wait_for_aio
> 0x7f72301dd090
> 2017-01-30 17:09:32.118227 7f72497f2700 10 bdev aio_wait 0x7f7230091ee0
> waiting for 1 aios and/or 0 readers to complete
> 2017-01-30 17:09:32.118316 7f725d108700 20
> bdev(./fio-bluestore/block.wal) _aio_log_finish 1 0x23ba000~4000
> 2017-01-30 17:09:32.118332 7f725d108700 10
> bdev(./fio-bluestore/block.wal) _aio_thread finished aio 0x7f723000d6d0
> r 16384 ioc 0x7f7230091ee0 with  aios left
> 2017-01-30 17:09:32.118376 7f72497f2700 20 bdev aio_wait 0x7f7230091ee0 done
> 2017-01-30 17:09:32.118381 7f72497f2700 20 bdev aio_wait 0x7f7230083f60 done
> 2017-01-30 17:09:32.118402 7f72497f2700 20 bdev aio_wait 0x7f72301ae810 done
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
