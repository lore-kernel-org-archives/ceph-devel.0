From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: File Journal O_DSYNC high latency
Date: Tue, 14 Mar 2017 15:43:24 -0700
Message-ID: <CAJ4mKGb=0JxxnyJOwFntiMDcrivP3_vMc7g47Lr+GTW1cJh1KQ@mail.gmail.com>
References: <CAF1ivSaprXY7za=vS86NvvSfyd7a5fn8Y-259qgJaaGbm2Ow-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f170.google.com ([74.125.82.170]:36689 "EHLO
        mail-ot0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750932AbdCNWn0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Mar 2017 18:43:26 -0400
Received: by mail-ot0-f170.google.com with SMTP id i1so385669ota.3
        for <ceph-devel@vger.kernel.org>; Tue, 14 Mar 2017 15:43:25 -0700 (PDT)
In-Reply-To: <CAF1ivSaprXY7za=vS86NvvSfyd7a5fn8Y-259qgJaaGbm2Ow-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ming Lin <minggr@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "LIU, Fei" <james.liu@alibaba-inc.com>, j.huo@alibaba-inc.com, wanjun.lp@alibaba-inc.com, caijin.caij@alibaba-inc.com

On Tue, Mar 14, 2017 at 3:32 PM, Ming Lin <minggr@gmail.com> wrote:
> Hi,
>
> ceph version: 10.2.5, filestore, raw block device as journal.
>
> Run fio randwrite test in a cluster, we saw average 5.26ms latency.
>
> Profiling data shows lots of IO wait in below kernel path when writing journal.
>
>  0xffffffff816366f0 : schedule+0x0/0x70 [kernel]
>  0xffffffff81634379 : schedule_timeout+0x209/0x2d0 [kernel]
>  0xffffffff81635cbe : io_schedule_timeout+0xae/0x130 [kernel]
>  0xffffffff81636de6 : wait_for_completion_io+0x116/0x170 [kernel]
>  0xffffffff812cb6f4 : blkdev_issue_flush+0xb4/0x110 [kernel]
>  0xffffffff812171d5 : blkdev_fsync+0x35/0x50 [kernel]
>  0xffffffff8120d952 : vfs_fsync_range+0x42/0xb0 [kernel]
>  0xffffffff8120dab1 : generic_write_sync+0x41/0x50 [kernel]
>  0xffffffff81217e2e : blkdev_aio_write+0xae/0xd0 [kernel]
>  0xffffffff8122dbc8 : do_io_submit+0x3b8/0x870 [kernel]
>  0xffffffff8122e090 : SyS_io_submit+0x10/0x20 [kernel]
>  0xffffffff8163b309 : kretprobe_trampoline+0x0/0x57 [kernel
>
> That's because journal block device is opened with O_DSYNC flag, so
> vfs_fsync_range was called to sync data for every request.
> So actually it's not "aio" any more. It's kind of sync IO.
>
> linux/fs/sync.c
>
> int generic_write_sync(struct file *file, loff_t pos, loff_t count)
> {
>         if (!(file->f_flags & O_DSYNC) && !IS_SYNC(file->f_mapping->host))
>                 return 0;
>         return vfs_fsync_range(file, pos, pos + count - 1,
>                                (file->f_flags & __O_SYNC) ? 0 : 1);
> }
>
> We did same test with O_DSYNC removed,
>
> diff --git a/src/os/filestore/FileJournal.cc b/src/os/filestore/FileJournal.cc
> index 9455152..2ae31b8 100644
> --- a/src/os/filestore/FileJournal.cc
> +++ b/src/os/filestore/FileJournal.cc
> @@ -56,7 +56,7 @@ int FileJournal::_open(bool forwrite, bool create)
>    if (forwrite) {
>      flags = O_RDWR;
>      if (directio)
> -      flags |= O_DIRECT | O_DSYNC;
> +      flags |= O_DIRECT;
>    } else {
>      flags = O_RDONLY;
>    }
>
> Then, fio latency dropped from ~5.26ms to ~3.0ms. That's a lot!
>
> IIUC, O_DSYNC flag is used to make sure journal data is really written to disk.
>
> But let's look at the code:
>
> FileJournal::write_aio_bl() -> io_submit()
> FileJournal::write_finish_thread_entry() -> io_getevents()
>
> Since we are doing directio, when io_getevents() returns(assume it
> returns successfully), we can also make sure journal data was written
> to disk.
> Then why do we need O_DSYNC? Am I missing any obvious thing?
>
> Big question: is it safe to remove O_DSYNC here?

IIRC the distinction is that O_DIRECT forces data into the drive, but
O_DSYNC forces it to the *platter*. ie, O_DIRECT just gets it into the
disk's volatile cache, whereas DSYNC make it durable. (see man 2 open
and man 2 fdatasync)

And yes, we need it to be durable.
-Greg
