From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: File Journal O_DSYNC high latency
Date: Tue, 14 Mar 2017 18:09:31 -0700
Message-ID: <CAJ4mKGZK_AhDnTm9S=yK=APuMaJ2ejDnEJX=ybbULziB5uG_Mw@mail.gmail.com>
References: <CAF1ivSaprXY7za=vS86NvvSfyd7a5fn8Y-259qgJaaGbm2Ow-Q@mail.gmail.com>
 <8b444025-06b2-4e11-8b56-41b3470da184.wanjun.lp@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f182.google.com ([74.125.82.182]:34476 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750768AbdCOBJd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Mar 2017 21:09:33 -0400
Received: by mail-ot0-f182.google.com with SMTP id o24so3191951otb.1
        for <ceph-devel@vger.kernel.org>; Tue, 14 Mar 2017 18:09:32 -0700 (PDT)
In-Reply-To: <8b444025-06b2-4e11-8b56-41b3470da184.wanjun.lp@alibaba-inc.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5YiY5pSAKOS4uOWQmyk=?= <wanjun.lp@alibaba-inc.com>
Cc: Ming Lin <minggr@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>, James <james.liu@alibaba-inc.com>, Jianjian <j.huo@alibaba-inc.com>, CAI Jin <caijin.caij@alibaba-inc.com>

If you have functioning hardware which provides this, you shouldn't
need to turn it off in software. AFAIK this is just always a bad idea
and usually results in grief because it turns out
* the battery is dead so the hardware started passing through flushes,
* the controller advertising is wrong and it is not power safe
* the controller is working but the drives are known not to so it has
to pass through flushes,

or some other situation. It's just not good. :/
-Greg

On Tue, Mar 14, 2017 at 6:00 PM, 刘攀(丸君) <wanjun.lp@alibaba-inc.com> wrote:
> Hi Greg,
>
> If there is already have Power Fail Safeguard, how about we remove O_DSYNC
> for journal write?
>
> Thanks
> Pan
>
> ------------------------------------------------------------------
> From:Gregory Farnum <gfarnum@redhat.com>
> Time:2017 Mar 15 (Wed) 06:43
> To:Ming Lin <minggr@gmail.com>
> Cc:Ceph Development <ceph-devel@vger.kernel.org>; James
> <james.liu@alibaba-inc.com>; Jianjian <j.huo@alibaba-inc.com>; Pan Liu
> <wanjun.lp@alibaba-inc.com>; CAI Jin <caijin.caij@alibaba-inc.com>
> Subject:Re: File Journal O_DSYNC high latency
>
> On Tue, Mar 14, 2017 at 3:32 PM, Ming Lin <minggr@gmail.com> wrote:
>> Hi,
>>
>> ceph version: 10.2.5, filestore, raw block device as journal.
>>
>> Run fio randwrite test in a cluster, we saw average 5.26ms latency.
>>
>> Profiling data shows lots of IO wait in below kernel path when writing
>> journal.
>>
>>  0xffffffff816366f0 : schedule+0x0/0x70 [kernel]
>>  0xffffffff81634379 : schedule_timeout+0x209/0x2d0 [kernel]
>>  0xffffffff81635cbe : io_schedule_timeout+0xae/0x130 [kernel]
>>  0xffffffff81636de6 : wait_for_completion_io+0x116/0x170 [kernel]
>>  0xffffffff812cb6f4 : blkdev_issue_flush+0xb4/0x110 [kernel]
>>  0xffffffff812171d5 : blkdev_fsync+0x35/0x50 [kernel]
>>  0xffffffff8120d952 : vfs_fsync_range+0x42/0xb0 [kernel]
>>  0xffffffff8120dab1 : generic_write_sync+0x41/0x50 [kernel]
>>  0xffffffff81217e2e : blkdev_aio_write+0xae/0xd0 [kernel]
>>  0xffffffff8122dbc8 : do_io_submit+0x3b8/0x870 [kernel]
>>  0xffffffff8122e090 : SyS_io_submit+0x10/0x20 [kernel]
>>  0xffffffff8163b309 : kretprobe_trampoline+0x0/0x57 [kernel
>>
>> That's because journal block device is opened with O_DSYNC flag, so
>> vfs_fsync_range was called to sync data for every request.
>> So actually it's not "aio" any more. It's kind of sync IO.
>>
>> linux/fs/sync.c
>>
>> int generic_write_sync(struct file *file, loff_t pos, loff_t count)
>> {
>>         if (!(file->f_flags & O_DSYNC) && !IS_SYNC(file->f_mapping->host))
>>                 return 0;
>>         return vfs_fsync_range(file, pos, pos + count - 1,
>>                                (file->f_flags & __O_SYNC) ? 0 : 1);
>> }
>>
>> We did same test with O_DSYNC removed,
>>
>> diff --git a/src/os/filestore/FileJournal.cc
>> b/src/os/filestore/FileJournal.cc
>> index 9455152..2ae31b8 100644
>> --- a/src/os/filestore/FileJournal.cc
>> +++ b/src/os/filestore/FileJournal.cc
>> @@ -56,7 +56,7 @@ int FileJournal::_open(bool forwrite, bool create)
>>    if (forwrite) {
>>      flags = O_RDWR;
>>      if (directio)
>> -      flags |= O_DIRECT | O_DSYNC;
>> +      flags |= O_DIRECT;
>>    } else {
>>      flags = O_RDONLY;
>>    }
>>
>> Then, fio latency dropped from ~5.26ms to ~3.0ms. That's a lot!
>>
>> IIUC, O_DSYNC flag is used to make sure journal data is really written to
>> disk.
>>
>> But let's look at the code:
>>
>> FileJournal::write_aio_bl() -> io_submit()
>> FileJournal::write_finish_thread_entry() -> io_getevents()
>>
>> Since we are doing directio, when io_getevents() returns(assume it
>> returns successfully), we can also make sure journal data was written
>> to disk.
>> Then why do we need O_DSYNC? Am I missing any obvious thing?
>>
>> Big question: is it safe to remove O_DSYNC here?
>
> IIRC the distinction is that O_DIRECT forces data into the drive, but
> O_DSYNC forces it to the *platter*. ie, O_DIRECT just gets it into the
> disk's volatile cache, whereas DSYNC make it durable. (see man 2 open
> and man 2 fdatasync)
>
> And yes, we need it to be durable.
> -Greg
