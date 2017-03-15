From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: [ceph-users] Log message --> "bdev(/var/lib/ceph/osd/ceph-x/block)
 aio_submit retries"
Date: Wed, 15 Mar 2017 18:38:54 +1000
Message-ID: <CAF-wwdFvgzkYMnkheomsWMikZoZU+THyrxzovORx3bCDfPZ7Ng@mail.gmail.com>
References: <CALWuvY8dEyWiUxg9VDaMkfQGwPSsWG0adrtzvGa9k7fhNmdsGw@mail.gmail.com>
 <CALWuvY9wY08n2AE9HMfZgZCU9ZEtk2XOwa353_stxT-7x7L30A@mail.gmail.com> <CALWuvY_9uWE_DKg5UaYZrc_GchfMK1EpX1rkWrJEuAV+Y3+Uww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36469 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbdCOIi4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Mar 2017 04:38:56 -0400
Received: by mail-io0-f173.google.com with SMTP id l7so15467978ioe.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Mar 2017 01:38:55 -0700 (PDT)
In-Reply-To: <CALWuvY_9uWE_DKg5UaYZrc_GchfMK1EpX1rkWrJEuAV+Y3+Uww@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nokia ceph <nokiacephusers@gmail.com>
Cc: Ceph Users <ceph-users@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, "Weil, Sage" <sage@redhat.com>, Mark Nelson <mnelson@redhat.com>

+ceph-devel

On Wed, Mar 15, 2017 at 5:25 PM, nokia ceph <nokiacephusers@gmail.com> wrote:
> Hello,
>
> We suspect these messages not only at the time of OSD creation. But in idle
> conditions also. May I know what is the impact of these error? Can we safely
> ignore this? Or is there any way/config to fix this problem
>
> Few occurrence for these events as follows:---
>
> ====
> 2017-03-14 17:16:09.500370 7fedeba61700  4 rocksdb: (Original Log Time
> 2017/03/14-17:16:09.453130) [default] Level-0 commit table #60 started
> 2017-03-14 17:16:09.500374 7fedeba61700  4 rocksdb: (Original Log Time
> 2017/03/14-17:16:09.500273) [default] Level-0 commit table #60: memtable #1
> done
> 2017-03-14 17:16:09.500376 7fedeba61700  4 rocksdb: (Original Log Time
> 2017/03/14-17:16:09.500297) EVENT_LOG_v1 {"time_micros": 1489511769500289,
> "job": 17, "event": "flush_finished", "lsm_state": [2, 4, 6, 0, 0, 0, 0],
> "immutable_memtables": 0}
> 2017-03-14 17:16:09.500382 7fedeba61700  4 rocksdb: (Original Log Time
> 2017/03/14-17:16:09.500330) [default] Level summary: base level 1 max bytes
> base 268435456 files[2 4 6 0 0 0 0] max score 0.76
>
> 2017-03-14 17:16:09.500390 7fedeba61700  4 rocksdb: [JOB 17] Try to delete
> WAL files size 244090350, prev total WAL file size 247331500, number of live
> WAL files 2.
>
> 2017-03-14 17:34:11.610513 7fedf3a71700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 6

These errors come from here.

void KernelDevice::aio_submit(IOContext *ioc)
{
...
    int r = aio_queue.submit(*cur, &retries);
    if (retries)
      derr << __func__ << " retries " << retries << dendl;

The submit function is this one which calls libaio's io_submit
function directly and increments retries if it receives EAGAIN.

#if defined(HAVE_LIBAIO)
int FS::aio_queue_t::submit(aio_t &aio, int *retries)
{
  // 2^16 * 125us = ~8 seconds, so max sleep is ~16 seconds
  int attempts = 16;
  int delay = 125;
  iocb *piocb = &aio.iocb;
  while (true) {
    int r = io_submit(ctx, 1, &piocb);     <-------------NOTE
    if (r < 0) {
      if (r == -EAGAIN && attempts-- > 0) {     <-------------NOTE
        usleep(delay);
        delay *= 2;
        (*retries)++;
        continue;
      }
      return r;
    }
    assert(r == 1);
    break;
  }
  return 0;
}


From the man page.

IO_SUBMIT(2)                                   Linux Programmer's
Manual                                  IO_SUBMIT(2)

NAME
       io_submit - submit asynchronous I/O blocks for processing
...
RETURN VALUE
       On success, io_submit() returns the number of iocbs submitted
(which may be 0 if nr is zero).  For the  failure
       return, see NOTES.

ERRORS
       EAGAIN Insufficient resources are available to queue any iocbs.

I suspect increasing bdev_aio_max_queue_depth may help here but some
of the other devs may have more/better ideas.

> 2017-03-14 17:34:11.672123 7fedf226e700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 6
> 2017-03-14 17:34:11.696253 7fedf2a6f700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 10
> 2017-03-14 17:34:11.739016 7fedf3a71700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 10
> 2017-03-14 17:51:08.808848 7fee05294700  4 rocksdb: reusing log 57 from
> recycle list
> =====
>
>
> =====
> 2017-03-14 18:32:06.910308 7fedeb260700  4 rocksdb: EVENT_LOG_v1
> {"time_micros": 1489516326910303, "job": 27, "event": "table_file_deletion",
> "file_number": 69}
> 2017-03-14 18:32:06.910326 7fedeb260700  4 rocksdb: EVENT_LOG_v1
> {"time_micros": 1489516326910325, "job": 27, "event": "table_file_deletion",
> "file_number": 51}
> 2017-03-14 18:32:06.910343 7fedeb260700  4 rocksdb: EVENT_LOG_v1
> {"time_micros": 1489516326910342, "job": 27, "event": "table_file_deletion",
> "file_number": 50}
> 2017-03-14 18:37:37.139963 7fedf3270700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 10
> 2017-03-14 18:37:37.144147 7fedf4a73700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 9
> 2017-03-14 18:37:37.179302 7fedf226e700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 10
> 2017-03-14 18:37:37.205677 7fedf2a6f700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 11
> 2017-03-14 18:37:37.226650 7fedf5274700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 11
> 2017-03-14 18:37:37.234589 7fedf3a71700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 11
> 2017-03-14 19:01:53.494364 7fee05294700  4 rocksdb: reusing log 61 from
> recycle list
> ======
>
> ======
> 2017-03-14 19:38:04.946439 7fedeba61700  4 rocksdb: (Original Log Time
> 2017/03/14-19:38:04.946355) EVENT_LOG_v1 {"time_micros": 1489520284946348,
> "job": 29, "event": "flush_finished", "lsm_state": [2, 4, 13, 0, 0, 0, 0],
> "immutable_memtables": 0}
> 2017-03-14 19:38:04.946441 7fedeba61700  4 rocksdb: (Original Log Time
> 2017/03/14-19:38:04.946383) [default] Level summary: base level 1 max bytes
> base 268435456 files[2 4 13 0 0 0 0] max score 0.85
>
> 2017-03-14 19:38:04.946461 7fedeba61700  4 rocksdb: [JOB 29] Try to delete
> WAL files size 244060984, prev total WAL file size 247581163, number of live
> WAL files 2.
>
> 2017-03-14 20:01:43.916418 7fedf4272700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 10
> 2017-03-14 20:01:43.951939 7fedf126c700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 11
> 2017-03-14 20:01:43.960599 7fedf3270700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 11
> 2017-03-14 20:01:43.969409 7fedf3a71700 -1
> bdev(/var/lib/ceph/osd/ceph-73/block) aio_submit retries 11
> 2017-03-14 20:13:04.291160 7fee05294700  4 rocksdb: reusing log 85 from
> recycle list
>
> 2017-03-14 20:13:04.291254 7fee05294700  4 rocksdb: [default] New memtable
> created with log file: #89. Immutable memtables: 0.
> =====
>
> Thanks
>
>
> On Wed, Mar 15, 2017 at 11:18 AM, nokia ceph <nokiacephusers@gmail.com>
> wrote:
>>
>> Hello,
>>
>> Can we get any update for this problem?
>>
>> Thanks
>>
>>
>> On Thu, Mar 2, 2017 at 2:16 PM, nokia ceph <nokiacephusers@gmail.com>
>> wrote:
>>>
>>> Hello,
>>>
>>> Env:- v11.2.0 - bluestore - EC 3 + 1
>>>
>>> We are getting below entries both in /var/log/messages and osd logs. May
>>> I know what is the impact of the below message and as these message were
>>> flooded in osd and sys logs.
>>>
>>> ~~~
>>>
>>> 2017-03-01 13:00:59.938839 7f6c96915700 -1
>>> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 2
>>>
>>> 2017-03-01 13:00:59.940939 7f6c96915700 -1
>>> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 4
>>>
>>> 2017-03-01 13:00:59.941126 7f6c96915700 -1
>>> bdev(/var/lib/ceph/osd/ceph-0/block) aio_submit retries 1
>>>
>>> ~~~
>>>
>>>
>>> I found these messages during the activation of ceph-osd's
>>>
>>>
>>> ~~~ From /var/log/messages
>>>
>>> Feb 27 13:59:46 PL6-CN2 sh: command_check_call: Running command:
>>> /usr/bin/systemctl start ceph-osd@39
>>>
>>> Feb 27 13:59:46 PL6-CN2 systemd: Started Ceph disk activation: /dev/sdk2.
>>>
>>> Feb 27 13:59:46 PL6-CN2 ceph-osd: 2017-02-27 13:59:46.540781 7f1f3f016700
>>> -1 bdev(/var/lib/ceph/osd/ceph-39/block) aio_submit retries 9
>>>
>>> Feb 27 13:59:46 PL6-CN2 ceph-osd: 2017-02-27 13:59:46.544670 7f1f3f016700
>>> -1 bdev(/var/lib/ceph/osd/ceph-39/block) aio_submit retries 2
>>>
>>> Feb 27 13:59:46 PL6-CN2 ceph-osd: 2017-02-27 13:59:46.544854 7f1f3f016700
>>> -1 bdev(/var/lib/ceph/osd/ceph-39/block) aio_submit retries 1
>>>
>>> Feb 27 13:59:47 PL6-CN2 kernel: sdl: sdl1
>>>
>>> Feb 27 13:59:47 PL6-CN2 kernel: sdl: sdl1
>>>
>>> Feb 27 13:59:48 PL6-CN2 kernel: sdl: sdl1 sdl2
>>>
>>> Feb 27 13:59:48 PL6-CN2 systemd: Cannot add dependency job for unit
>>> microcode.service, ignoring: Unit is not loaded properly: Invalid argument.
>>>
>>> Feb 27 13:59:48 PL6-CN2 systemd: Starting Ceph disk activation:
>>> /dev/sdl2...
>>>
>>> ~~~
>>>
>>> At the same time on OSD logs:-- /var/log/ceph/ceph-osd.43.log-20170228.gz
>>>
>>> 2017-02-27 14:00:17.121460 7f147351e940  0 osd.43 0 crush map has
>>> features 2199057072128, adjusting msgr requires for clients
>>> 2017-02-27 14:00:17.121466 7f147351e940  0 osd.43 0 crush map has
>>> features 2199057072128 was 8705, adjusting msgr requires for mons
>>> 2017-02-27 14:00:17.121468 7f147351e940  0 osd.43 0 crush map has
>>> features 2199057072128, adjusting msgr requires for osds
>>> 2017-02-27 14:00:17.121511 7f147351e940  0 osd.43 0 load_pgs
>>> 2017-02-27 14:00:17.121514 7f147351e940  0 osd.43 0 load_pgs opened 0 pgs
>>> 2017-02-27 14:00:17.121517 7f147351e940  0 osd.43 0 using 1 op queue with
>>> priority op cut off at 64.
>>> 2017-02-27 14:00:17.122364 7f147351e940 -1 osd.43 0 log_to_monitors
>>> {default=true}
>>> 2017-02-27 14:00:18.371762 7f147351e940  0 osd.43 0 done with init,
>>> starting boot process
>>> 2017-02-27 14:00:18.486559 7f1459952700 -1
>>> bdev(/var/lib/ceph/osd/ceph-43/block) aio_submit retries 7
>>> 2017-02-27 14:00:18.488770 7f1459952700 -1
>>> bdev(/var/lib/ceph/osd/ceph-43/block) aio_submit retries 4
>>> 2017-02-27 14:00:18.489306 7f1459952700 -1
>>> bdev(/var/lib/ceph/osd/ceph-43/block) aio_submit retries 2
>>> 2017-02-27 14:00:18.489826 7f1459952700 -1
>>> bdev(/var/lib/ceph/osd/ceph-43/block) aio_submit retries 2
>>> <snip>
>>> ..
>>> <snip>
>>> 2017-02-27 14:00:18.583234 7f145814f700  0 osd.43 93 crush map has
>>> features 2200130813952, adjusting msgr requires for clients
>>> 2017-02-27 14:00:18.583257 7f145814f700  0 osd.43 93 crush map has
>>> features 2200130813952 was 2199057080833, adjusting msgr requires for mons
>>> 2017-02-27 14:00:18.583271 7f145814f700  0 osd.43 93 crush map has
>>> features 2200130813952, adjusting msgr requires for osds
>>> ~~~~
>>>
>>> As per my understanding on a bluestore device, we can write with both
>>> O_DIRECT and aio way. For some reasons, bdev can't able to commit with aio
>>> type.
>>>
>>> ~~~
>>> "ms_type": "async"
>>> ~~~
>>>
>>> Need your suggestion how to skip these messages.
>>>
>>> Thanks
>>>
>>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



-- 
Cheers,
Brad
