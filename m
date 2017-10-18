From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: preparing a bluestore OSD fails with no (useful) output
Date: Wed, 18 Oct 2017 20:20:50 +1000
Message-ID: <CAF-wwdEDZqhxK0L9E8Gs=P_1uVEE0=uzCWw_0TU4xEKQeKKi6Q@mail.gmail.com>
References: <CAC-Np1wAy2VY6VSZBFgW4GjXd8YPU+5-C=AqymSDfNtfa0Vwdw@mail.gmail.com>
 <alpine.DEB.2.11.1710162000330.26702@piezo.us.to>
 <CAC-Np1wgLSRKU9PKMgdBjXW1yjG4LJ3b2HxrmmfkE=WP-2k31g@mail.gmail.com>
 <alpine.DEB.2.11.1710162011280.26702@piezo.us.to>
 <CAC-Np1wbSpsAjW8aNNeZaTvBCV0=SeNDgKFCffF7KnCTp0-QKA@mail.gmail.com>
 <CAF-wwdGaEDTSacxvTbjZdRrSjAbAxxt7SKqpoup6MEg86xbwQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:43676 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757928AbdJRKU5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Oct 2017 06:20:57 -0400
Received: by mail-pg0-f48.google.com with SMTP id s75so3917215pgs.0
        for <ceph-devel@vger.kernel.org>; Wed, 18 Oct 2017 03:20:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAF-wwdGaEDTSacxvTbjZdRrSjAbAxxt7SKqpoup6MEg86xbwQQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>

Of course the '1' in this case is an exit code rather than a system error code
most likely.

This makes it more likely it's the tracker I mentioned. If nothing else the
strace may show the write being sent to stdout (file descriptor 2) shortly
before the exit.

On Wed, Oct 18, 2017 at 10:43 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
> Hi Alfredo,
>
> Try '--log_flush_on_exit' and see http://tracker.ceph.com/issues/21667
>
> Failing that...
>
> If the new branch does not resolve the issue you could [1] strace it
> to see where/what is failing?
>
> A return of '1' may imply EPERM and a strace would show if any system
> call is returning that.
>
> [1] sudo strace -fyyvttTo /tmp/strace.out -s 1024 ceph-osd --cluster
> ceph --osd-objectstore bluestore --mkfs -i 1
> --monmap /var/lib/ceph/osd/ceph-1/activate.monmap --key
> AQDa6uRZBqjoIRAAJSNl6k9vGce2gGAYUF4nSg== --osd-data
> /var/lib/ceph/osd/ceph-1 --osd-uuid
> 3b3090c7-8bc2-4d01-bfb7-9a364d4c469a --setuser ceph --setgroup ceph
>
> On Tue, Oct 17, 2017 at 6:53 AM, Alfredo Deza <adeza@redhat.com> wrote:
>> On Mon, Oct 16, 2017 at 4:12 PM, Sage Weil <sage@newdream.net> wrote:
>>> On Mon, 16 Oct 2017, Alfredo Deza wrote:
>>>> On Mon, Oct 16, 2017 at 4:01 PM, Sage Weil <sage@newdream.net> wrote:
>>>> > Hey-
>>>> >
>>>> > On Mon, 16 Oct 2017, Alfredo Deza wrote:
>>>> >> I'm trying to manually get an OSD prepared, but can't seem to get the
>>>> >> data directory fully populated with `--mkfs` and even though I've
>>>> >> raised the log levels I can't see anything useful to point to what is
>>>> >> the command missing.
>>>> >>
>>>> >> The directory is created, chown'd to ceph:ceph, the block device is
>>>> >> linked, and the data is mounted.
>>>> >>
>>>> >> The /var/lib/ceph/osd/ceph-1 directory ends up with two files:
>>>> >> activate.monmap (we fetch this from the monitor) and a 'block'
>>>> >> symlink.
>>>> >>
>>>> >> We then run the following command:
>>>> >>
>>>> >> # sudo ceph-osd --cluster ceph --osd-objectstore bluestore --mkfs -i 1
>>>> >> --monmap /var/lib/ceph/osd/ceph-1/activate.monmap --key
>>>> >> AQDa6uRZBqjoIRAAJSNl6k9vGce2gGAYUF4nSg== --osd-data
>>>> >> /var/lib/ceph/osd/ceph-1 --osd-uuid
>>>> >> 3b3090c7-8bc2-4d01-bfb7-9a364d4c469a --setuser ceph --setgroup ceph
>>>> >
>>>> > I just tried this and it works for me.  Are you using the
>>>> > wip-bluestore-superblock branch?
>>>>
>>>> I am not, because I am trying to get bluestore by having the small
>>>> 100MB data and block only for now until superblock gets merged
>>>
>>> It will merge as soon as Kefu reviews my revisions... probably tonight.
>>> Can you test this against that branch?  I changed several things in the
>>> mkfs behavior and it's confusing to think about the old behavior.  I think
>>> it's not worth implementing the separate partition behavior when it's
>>> about to be unnecessary...
>>
>> Sure. Can you push to ceph-ci so I can grab builds from
>> https://shaman.ceph.com/api/repos/ceph/wip-bluestore-superblock/
>>
>>
>>>
>>> sage
>>>
>>>>
>>>> >
>>>> > You can turn up debugging with --debug-bluestore 20 and --log-to-stderr.
>>>>
>>>> Didn't get anything extra other than these two lines:
>>>>
>>>> 2017-10-16 20:05:42.160992 7f6449b28d00 10
>>>> bluestore(/var/lib/ceph/osd/ceph-1) set_cache_shards 1
>>>> 2017-10-16 20:05:42.182607 7f6449b28d00 10
>>>> bluestore(/var/lib/ceph/osd/ceph-1) _set_csum csum_type crc32c
>>>>
>>>> >
>>>> > sage
>>>> >
>>>> >>
>>>> >>
>>>> >> Which will not give any stdout/stderr output and will return with a
>>>> >> non-zero exit code of 1
>>>> >>
>>>> >>
>>>> >> Inspecting the /var/lib/ceph/osd/ceph-1 directory now shows a few more files:
>>>> >>
>>>> >> # ls -alh /var/lib/ceph/osd/ceph-1
>>>> >> -rw-r--r--. 1 ceph ceph 183 Oct 16 17:22 activate.monmap
>>>> >> lrwxrwxrwx. 1 ceph ceph  56 Oct 16 17:22 block ->
>>>> >> /dev/ceph/osd-block-3b3090c7-8bc2-4d01-bfb7-9a364d4c469a
>>>> >> -rw-r--r--. 1 ceph ceph   0 Oct 16 17:23 fsid
>>>> >> -rw-r--r--. 1 ceph ceph  10 Oct 16 17:23 type
>>>> >>
>>>> >> In this case "fsid" is empty, and "type" has "bluestore".
>>>> >>
>>>> >> After raising log level output (debug_osd 20) shows the following:
>>>> >>
>>>> >> 2017-10-16 18:03:54.679031 7f654a562d00  0 set uid:gid to 167:167 (ceph:ceph)
>>>> >> 2017-10-16 18:03:54.679053 7f654a562d00  0 ceph version 12.2.1
>>>> >> (3e7492b9ada8bdc9a5cd0feafd42fbca27f9c38e) luminous (stable), process
>>>> >> (unknown), pid 5674
>>>> >> 2017-10-16 18:03:54.679323 7f654a562d00  5 object store type is bluestore
>>>> >> 2017-10-16 18:03:54.702667 7f6543733700  2 Event(0x7f6555a0bc80
>>>> >> nevent=5000 time_id=1).set_owner idx=0 owner=140072900048640
>>>> >> 2017-10-16 18:03:54.702681 7f6543733700 20 Event(0x7f6555a0bc80
>>>> >> nevent=5000 time_id=1).create_file_event create event started fd=7
>>>> >> mask=1 original mask is 0
>>>> >> 2017-10-16 18:03:54.702683 7f6543733700 20 EpollDriver.add_event add
>>>> >> event fd=7 cur_mask=0 add_mask=1 to 6
>>>> >> 2017-10-16 18:03:54.702691 7f6543733700 20 Event(0x7f6555a0bc80
>>>> >> nevent=5000 time_id=1).create_file_event create event end fd=7 mask=1
>>>> >> original mask is 1
>>>> >> 2017-10-16 18:03:54.702692 7f6543733700 10 stack operator() starting
>>>> >> 2017-10-16 18:03:54.702972 7f6542f32700  2 Event(0x7f6555a0b680
>>>> >> nevent=5000 time_id=1).set_owner idx=1 owner=140072891655936
>>>> >> 2017-10-16 18:03:54.703095 7f6542f32700 20 Event(0x7f6555a0b680
>>>> >> nevent=5000 time_id=1).create_file_event create event started fd=10
>>>> >> mask=1 original mask is 0
>>>> >> 2017-10-16 18:03:54.703169 7f6542f32700 20 EpollDriver.add_event add
>>>> >> event fd=10 cur_mask=0 add_mask=1 to 9
>>>> >> 2017-10-16 18:03:54.703178 7f6542f32700 20 Event(0x7f6555a0b680
>>>> >> nevent=5000 time_id=1).create_file_event create event end fd=10 mask=1
>>>> >> original mask is 1
>>>> >> 2017-10-16 18:03:54.703181 7f6542f32700 10 stack operator() starting
>>>> >> 2017-10-16 18:03:54.703474 7f6542731700  2 Event(0x7f6555a0a480
>>>> >> nevent=5000 time_id=1).set_owner idx=2 owner=140072883263232
>>>> >> 2017-10-16 18:03:54.703520 7f6542731700 20 Event(0x7f6555a0a480
>>>> >> nevent=5000 time_id=1).create_file_event create event started fd=13
>>>> >> mask=1 original mask is 0
>>>> >> 2017-10-16 18:03:54.703524 7f6542731700 20 EpollDriver.add_event add
>>>> >> event fd=13 cur_mask=0 add_mask=1 to 12
>>>> >> 2017-10-16 18:03:54.703527 7f6542731700 20 Event(0x7f6555a0a480
>>>> >> nevent=5000 time_id=1).create_file_event create event end fd=13 mask=1
>>>> >> original mask is 1
>>>> >> 2017-10-16 18:03:54.703529 7f6542731700 10 stack operator() starting
>>>> >> 2017-10-16 18:03:54.703571 7f654a562d00 10 -- - ready -
>>>> >> 2017-10-16 18:03:54.703575 7f654a562d00  1  Processor -- start
>>>> >> 2017-10-16 18:03:54.703625 7f654a562d00  1 -- - start start
>>>> >> 2017-10-16 18:03:54.703649 7f654a562d00 10 -- - shutdown -
>>>> >> 2017-10-16 18:03:54.703650 7f654a562d00 10  Processor -- stop
>>>> >> 2017-10-16 18:03:54.703652 7f654a562d00  1 -- - shutdown_connections
>>>> >> 2017-10-16 18:03:54.703655 7f654a562d00 20 Event(0x7f6555a0bc80
>>>> >> nevent=5000 time_id=1).wakeup
>>>> >> 2017-10-16 18:03:54.703668 7f654a562d00 20 Event(0x7f6555a0b680
>>>> >> nevent=5000 time_id=1).wakeup
>>>> >> 2017-10-16 18:03:54.703673 7f654a562d00 20 Event(0x7f6555a0a480
>>>> >> nevent=5000 time_id=1).wakeup
>>>> >> 2017-10-16 18:03:54.703896 7f654a562d00 10 -- - wait: waiting for dispatch queue
>>>> >> 2017-10-16 18:03:54.704285 7f654a562d00 10 -- - wait: dispatch queue is stopped
>>>> >> 2017-10-16 18:03:54.704290 7f654a562d00  1 -- - shutdown_connections
>>>> >> 2017-10-16 18:03:54.704293 7f654a562d00 20 Event(0x7f6555a0bc80
>>>> >> nevent=5000 time_id=1).wakeup
>>>> >> 2017-10-16 18:03:54.704300 7f654a562d00 20 Event(0x7f6555a0b680
>>>> >> nevent=5000 time_id=1).wakeup
>>>> >> 2017-10-16 18:03:54.704303 7f654a562d00 20 Event(0x7f6555a0a480
>>>> >> nevent=5000 time_id=1).wakeup
>>>> >>
>>>> >>
>>>> >> I can't tell what am I missing or if there is any need to pre-populate
>>>> >> the path with something else.
>>>> >> --
>>>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> >> the body of a message to majordomo@vger.kernel.org
>>>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> >>
>>>> >>
>>>> > --
>>>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> > the body of a message to majordomo@vger.kernel.org
>>>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Cheers,
> Brad



-- 
Cheers,
Brad
