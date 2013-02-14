From: Jesus Cuenca <jcuenca@cnb.csic.es>
Subject: Re: OSD dies after seconds
Date: Thu, 14 Feb 2013 12:37:29 +0100
Message-ID: <CAGnkcrn1sFQMGb4WYt1J6=70F9qmd-U0uVb2VDgF67o=KBJbnQ@mail.gmail.com>
References: <CAGnkcrkf6GmTdUqM7zK=L7-1OREMaAsYF0fKpvRFMR_ck2QGmw@mail.gmail.com>
 <alpine.DEB.2.00.1302130918110.20247@cobra.newdream.net> <CAGnkcrm+U-B7Z=e8LbbTkXR4Chq8ACTZs8m=9k_-7RiCLriGhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:58910 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757468Ab3BNLiK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 06:38:10 -0500
Received: by mail-vb0-f42.google.com with SMTP id ff1so1394506vbb.1
        for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 03:38:09 -0800 (PST)
In-Reply-To: <CAGnkcrm+U-B7Z=e8LbbTkXR4Chq8ACTZs8m=9k_-7RiCLriGhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I upgraded to ceph 0.56-3 but the problem persist...

OSD starts but after a second it finishes:

2013-02-14 12:18:34.504391 7fae613ea760 10 journal _open journal is
not a block device, NOT checking disk write cache on
'/var/lib/ceph/osd/ceph-0/jour
nal'
2013-02-14 12:18:34.504400 7fae613ea760  1 journal _open
/var/lib/ceph/osd/ceph-0/journal fd 17: 10485760000 bytes, block size
4096 bytes, directio = 1
, aio = 0
2013-02-14 12:18:34.504458 7fae613ea760 10 journal journal_start
2013-02-14 12:18:34.504506 7fae5d3c6700 10 journal write_thread_entry start
2013-02-14 12:18:34.504515 7fae5d3c6700 20 journal write_thread_entry
going to sleep
2013-02-14 12:18:34.504706 7fae5cbc5700 10 journal
write_finish_thread_entry enter
2013-02-14 12:18:34.504716 7fae5cbc5700 20 journal
write_finish_thread_entry sleeping
2013-02-14 12:18:34.504893 7fae567fc700 20
filestore(/var/lib/ceph/osd/ceph-0) flusher_entry start
2013-02-14 12:18:34.504903 7fae567fc700 20
filestore(/var/lib/ceph/osd/ceph-0) flusher_entry sleeping
2013-02-14 12:18:34.505013 7fae613ea760  5
filestore(/var/lib/ceph/osd/ceph-0) umount /var/lib/ceph/osd/ceph-0
2013-02-14 12:18:34.505036 7fae567fc700 20
filestore(/var/lib/ceph/osd/ceph-0) flusher_entry awoke
2013-02-14 12:18:34.505044 7fae567fc700 20
filestore(/var/lib/ceph/osd/ceph-0) flusher_entry finish
2013-02-14 12:18:34.505113 7fae5dbc7700 20
filestore(/var/lib/ceph/osd/ceph-0) sync_entry force_sync set
2013-02-14 12:18:34.505129 7fae5dbc7700 10 journal commit_start
max_applied_seq 2, open_ops 0
2013-02-14 12:18:34.505136 7fae5dbc7700 10 journal commit_start
blocked, all open_ops have completed
2013-02-14 12:18:34.505138 7fae5dbc7700 10 journal commit_start nothing to do
2013-02-14 12:18:34.505141 7fae5dbc7700 10 journal commit_start
2013-02-14 12:18:34.505506 7fae613ea760 10 journal journal_stop
2013-02-14 12:18:34.505698 7fae613ea760  1 journal close
/var/lib/ceph/osd/ceph-0/journal
2013-02-14 12:18:34.505787 7fae5d3c6700 20 journal write_thread_entry woke up
2013-02-14 12:18:34.505796 7fae5d3c6700 10 journal write_thread_entry finish
2013-02-14 12:18:34.505845 7fae5cbc5700 10 journal
write_finish_thread_entry exit


On Wed, Feb 13, 2013 at 6:28 PM, Jesus Cuenca <jcuenca@cnb.csic.es> wrote:
> thanks for the fast answer.
>
> no, it does not segfault:
>
> gdb --args /usr/local/bin/ceph-osd -i 0
> ...
> (gdb) run
> Starting program: /usr/local/bin/ceph-osd -i 0
> [Thread debugging using libthread_db enabled]
> [New Thread 0x7ffff5fce700 (LWP 8920)]
> starting osd.0 at :/0 osd_data /var/lib/ceph/osd/ceph-0
> /var/lib/ceph/osd/ceph-0/journal
> [Thread 0x7ffff5fce700 (LWP 8920) exited]
>
> Program exited normally.
>
> --

>
>
> On Wed, Feb 13, 2013 at 6:21 PM, Sage Weil <sage@inktank.com> wrote:
>> On Wed, 13 Feb 2013, Jesus Cuenca wrote:
>>> Hi,
>>>
>>> I'm setting up a small ceph 0.56.2 cluster on 3 64-bit Debian 6
>>> servers with kernel 3.7.2.
>>
>> This might be
>>
>>         http://tracker.ceph.com/issues/3595
>>
>> which is problems with google perftools (which we use by default) and the
>> version in squeeze, which is buggy.  This doesn't seem to affect all
>> squeeze users.
>>
>> Does it seg fault?
>>
>> sage
>>
>>
>>>
>>> My problem is that OSD die. First I try to start them with the init script:
>>>
>>> > /etc/init.d/ceph start osd.0
>>> ...
>>> starting osd.0 at :/0 osd_data /var/lib/ceph/osd/ceph-0
>>> /var/lib/ceph/osd/ceph-0/journal
>>>
>>> > ps -ef | grep ceph
>>> (No ceph-osd process)
>>>
>>> I then run with debugging:
>>>
>>> > ceph-osd -i 0 --debug_ms 20 --debug_osd 20 --debug_filestore 20 --debug_journal 20 -d
>>> starting osd.0 at :/0 osd_data /var/lib/ceph/osd/ceph-0
>>> /var/lib/ceph/osd/ceph-0/journal
>>> 2013-02-13 18:04:40.351830 7fe98cd8a760 10 -- :/0 rank.bind :/0
>>> 2013-02-13 18:04:40.351895 7fe98cd8a760 10 accepter.accepter.bind
>>> 2013-02-13 18:04:40.351910 7fe98cd8a760 10 accepter.accepter.bind
>>> bound on random port 0.0.0.0:6800/0
>>> 2013-02-13 18:04:40.351919 7fe98cd8a760 10 accepter.accepter.bind
>>> bound to 0.0.0.0:6800/0
>>> 2013-02-13 18:04:40.351930 7fe98cd8a760  1 accepter.accepter.bind
>>> my_inst.addr is 0.0.0.0:6800/8438 need_addr=1
>>> 2013-02-13 18:04:40.351935 7fe98cd8a760 10 -- :/0 rank.bind :/0
>>> 2013-02-13 18:04:40.351938 7fe98cd8a760 10 accepter.accepter.bind
>>> 2013-02-13 18:04:40.351943 7fe98cd8a760 10 accepter.accepter.bind
>>> bound on random port 0.0.0.0:6801/0
>>> 2013-02-13 18:04:40.351946 7fe98cd8a760 10 accepter.accepter.bind
>>> bound to 0.0.0.0:6801/0
>>> 2013-02-13 18:04:40.351952 7fe98cd8a760  1 accepter.accepter.bind
>>> my_inst.addr is 0.0.0.0:6801/8438 need_addr=1
>>> 2013-02-13 18:04:40.351959 7fe98cd8a760 10 -- :/0 rank.bind :/0
>>> 2013-02-13 18:04:40.351961 7fe98cd8a760 10 accepter.accepter.bind
>>> 2013-02-13 18:04:40.351966 7fe98cd8a760 10 accepter.accepter.bind
>>> bound on random port 0.0.0.0:6802/0
>>> 2013-02-13 18:04:40.351969 7fe98cd8a760 10 accepter.accepter.bind
>>> bound to 0.0.0.0:6802/0
>>> 2013-02-13 18:04:40.351975 7fe98cd8a760  1 accepter.accepter.bind
>>> my_inst.addr is 0.0.0.0:6802/8438 need_addr=1
>>> 2013-02-13 18:04:40.352636 7fe98cd8a760  5
>>> filestore(/var/lib/ceph/osd/ceph-0) basedir /var/lib/ceph/osd/ceph-0
>>> journal /var/lib/ceph/osd/ceph-0/journa
>>> l
>>> 2013-02-13 18:04:40.352664 7fe98cd8a760 10
>>> filestore(/var/lib/ceph/osd/ceph-0) mount fsid is
>>> 0ab92be4-3b42-47bc-bd88-b0e11da5b450
>>> 2013-02-13 18:04:40.426222 7fe98cd8a760  0
>>> filestore(/var/lib/ceph/osd/ceph-0) mount FIEMAP ioctl is supported
>>> and appears to work
>>> 2013-02-13 18:04:40.426234 7fe98cd8a760  0
>>> filestore(/var/lib/ceph/osd/ceph-0) mount FIEMAP ioctl is disabled via
>>> 'filestore fiemap' config option
>>> 2013-02-13 18:04:40.426567 7fe98cd8a760  0
>>> filestore(/var/lib/ceph/osd/ceph-0) mount did NOT detect btrfs
>>> 2013-02-13 18:04:40.426575 7fe98cd8a760  0
>>> filestore(/var/lib/ceph/osd/ceph-0) mount syncfs(2) syscall not
>>> supported
>>> 2013-02-13 18:04:40.426630 7fe98cd8a760  0
>>> filestore(/var/lib/ceph/osd/ceph-0) mount no syncfs(2), must use
>>> sync(2).
>>> 2013-02-13 18:04:40.426631 7fe98cd8a760  0
>>> filestore(/var/lib/ceph/osd/ceph-0) mount WARNING: multiple ceph-osd
>>> daemons on the same host will be slow
>>> 2013-02-13 18:04:40.426701 7fe98cd8a760  0
>>> filestore(/var/lib/ceph/osd/ceph-0) mount found snaps <>
>>> 2013-02-13 18:04:40.426719 7fe98cd8a760  5
>>> filestore(/var/lib/ceph/osd/ceph-0) mount op_seq is 2
>>> 2013-02-13 18:04:40.515151 7fe98cd8a760 20 filestore (init)dbobjectmap: seq is 1
>>> 2013-02-13 18:04:40.515217 7fe98cd8a760 10
>>> filestore(/var/lib/ceph/osd/ceph-0) open_journal at
>>> /var/lib/ceph/osd/ceph-0/journal
>>> 2013-02-13 18:04:40.515243 7fe98cd8a760  0
>>> filestore(/var/lib/ceph/osd/ceph-0) mount: enabling WRITEAHEAD journal
>>> mode: btrfs not detected
>>> 2013-02-13 18:04:40.515252 7fe98cd8a760 10
>>> filestore(/var/lib/ceph/osd/ceph-0) list_collections
>>> 2013-02-13 18:04:40.515352 7fe98cd8a760 10 journal journal_replay fs op_seq 2
>>> 2013-02-13 18:04:40.515359 7fe98cd8a760  2 journal open
>>> /var/lib/ceph/osd/ceph-0/journal fsid
>>> 0ab92be4-3b42-47bc-bd88-b0e11da5b450 fs_op_seq 2
>>> 2013-02-13 18:04:40.515373 7fe98cd8a760 10 journal _open journal is
>>> not a block device, NOT checking disk write cache on
>>> '/var/lib/ceph/osd/ceph-0/jour
>>> nal'
>>> 2013-02-13 18:04:40.515385 7fe98cd8a760  1 journal _open
>>> /var/lib/ceph/osd/ceph-0/journal fd 17: 10485760000 bytes, block size
>>> 4096 bytes, directio = 1
>>> , aio = 0
>>> 2013-02-13 18:04:40.515393 7fe98cd8a760 10 journal read_header
>>> 2013-02-13 18:04:40.515409 7fe98cd8a760 10 journal header: block_size
>>> 4096 alignment 4096 max_size 10485760000
>>> 2013-02-13 18:04:40.515411 7fe98cd8a760 10 journal header: start 4096
>>> 2013-02-13 18:04:40.515412 7fe98cd8a760 10 journal  write_pos 4096
>>> 2013-02-13 18:04:40.515415 7fe98cd8a760 10 journal open header.fsid =
>>> 0ab92be4-3b42-47bc-bd88-b0e11da5b450
>>> 2013-02-13 18:04:40.515434 7fe98cd8a760  2 journal read_entry 4096 :
>>> seq 2 424 bytes
>>> 2013-02-13 18:04:40.515439 7fe98cd8a760  2 journal read_entry 8192 :
>>> bad header magic, end of journal
>>> 2013-02-13 18:04:40.515443 7fe98cd8a760 10 journal open reached end of journal.
>>> 2013-02-13 18:04:40.515446 7fe98cd8a760  2 journal read_entry 8192 :
>>> bad header magic, end of journal
>>> 2013-02-13 18:04:40.515447 7fe98cd8a760  3 journal journal_replay: end
>>> of journal, done.
>>> 2013-02-13 18:04:40.515444 7fe989567700 20
>>> filestore(/var/lib/ceph/osd/ceph-0) sync_entry waiting for
>>> max_interval 5.000000
>>> 2013-02-13 18:04:40.515457 7fe98cd8a760 10 journal _open journal is
>>> not a block device, NOT checking disk write cache on
>>> '/var/lib/ceph/osd/ceph-0/jour
>>> nal'
>>> 2013-02-13 18:04:40.515465 7fe98cd8a760  1 journal _open
>>> /var/lib/ceph/osd/ceph-0/journal fd 17: 10485760000 bytes, block size
>>> 4096 bytes, directio = 1
>>> , aio = 0
>>> 2013-02-13 18:04:40.515516 7fe98cd8a760 10 journal journal_start
>>> 2013-02-13 18:04:40.515545 7fe983fff700 10 journal
>>> write_finish_thread_entry enter
>>> 2013-02-13 18:04:40.515555 7fe983fff700 20 journal
>>> write_finish_thread_entry sleeping
>>> 2013-02-13 18:04:40.515550 7fe988d66700 10 journal write_thread_entry start
>>> 2013-02-13 18:04:40.515559 7fe988d66700 20 journal write_thread_entry
>>> going to sleep
>>> 2013-02-13 18:04:40.515840 7fe981ffb700 20
>>> filestore(/var/lib/ceph/osd/ceph-0) flusher_entry start
>>> 2013-02-13 18:04:40.515851 7fe981ffb700 20
>>> filestore(/var/lib/ceph/osd/ceph-0) flusher_entry sleeping
>>> 2013-02-13 18:04:40.515938 7fe98cd8a760  5
>>> filestore(/var/lib/ceph/osd/ceph-0) umount /var/lib/ceph/osd/ceph-0
>>> 2013-02-13 18:04:40.515958 7fe981ffb700 20
>>> filestore(/var/lib/ceph/osd/ceph-0) flusher_entry awoke
>>> 2013-02-13 18:04:40.515973 7fe981ffb700 20
>>> filestore(/var/lib/ceph/osd/ceph-0) flusher_entry finish
>>> 2013-02-13 18:04:40.515991 7fe989567700 20
>>> filestore(/var/lib/ceph/osd/ceph-0) sync_entry force_sync set
>>> 2013-02-13 18:04:40.516007 7fe989567700 10 journal commit_start
>>> max_applied_seq 2, open_ops 0
>>> 2013-02-13 18:04:40.516011 7fe989567700 10 journal commit_start
>>> blocked, all open_ops have completed
>>> 2013-02-13 18:04:40.516012 7fe989567700 10 journal commit_start nothing to do
>>> 2013-02-13 18:04:40.516015 7fe989567700 10 journal commit_start
>>> 2013-02-13 18:04:40.516199 7fe98cd8a760 10 journal journal_stop
>>> 2013-02-13 18:04:40.516338 7fe98cd8a760  1 journal close
>>> /var/lib/ceph/osd/ceph-0/journal
>>> 2013-02-13 18:04:40.516361 7fe983fff700 10 journal
>>> write_finish_thread_entry exit
>>> 2013-02-13 18:04:40.516413 7fe988d66700 20 journal write_thread_entry woke up
>>> 2013-02-13 18:04:40.516423 7fe988d66700 10 journal write_thread_entry finish
>>>
>>> Here it is my ceph.conf:
>>>
>>> [global]
>>>         auth cluster required = cephx
>>>         auth service required = cephx
>>>         auth client required = cephx
>>>
>>> [osd]
>>>
>>> [mon.a]
>>>         host = hosta
>>>         mon addr = 192.168.0.200:6789
>>>
>>> [mon.b]
>>>         host = hostb
>>>         mon addr = 192.168.0.186:6789
>>>
>>> [mon.c]
>>>         host = hostc
>>>         mon addr = 192.168.0.136:6789
>>>
>>> [osd.0]
>>>         host = hosta
>>>         osd mkfs type=xfs
>>>         devs = /dev/sdb1
>>>         filestore_xattr_use_omap = 1
>>>
>>> [osd.1]
>>>         host = hostb
>>>         osd mkfs type=xfs
>>>         devs = /dev/sdb1
>>>         filestore_xattr_use_omap = 1
>>>
>>> [mds.a]
>>>         host = hosta
>>>
>>> Any ideas?
>>>
>>> I began testing with ceph 0.56.1, and then upgraded to 0.56.2, hoping
>>> it might fix this strange problem.
>>>
>>> Thanks and kind regards,
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
