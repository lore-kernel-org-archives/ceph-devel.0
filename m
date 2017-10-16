From: Sage Weil <sage@newdream.net>
Subject: Re: preparing a bluestore OSD fails with no (useful) output
Date: Mon, 16 Oct 2017 20:01:23 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710162000330.26702@piezo.us.to>
References: <CAC-Np1wAy2VY6VSZBFgW4GjXd8YPU+5-C=AqymSDfNtfa0Vwdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.205.236]:54173 "EHLO
        tragedy.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754536AbdJPUB0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Oct 2017 16:01:26 -0400
In-Reply-To: <CAC-Np1wAy2VY6VSZBFgW4GjXd8YPU+5-C=AqymSDfNtfa0Vwdw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hey-

On Mon, 16 Oct 2017, Alfredo Deza wrote:
> I'm trying to manually get an OSD prepared, but can't seem to get the
> data directory fully populated with `--mkfs` and even though I've
> raised the log levels I can't see anything useful to point to what is
> the command missing.
> 
> The directory is created, chown'd to ceph:ceph, the block device is
> linked, and the data is mounted.
> 
> The /var/lib/ceph/osd/ceph-1 directory ends up with two files:
> activate.monmap (we fetch this from the monitor) and a 'block'
> symlink.
> 
> We then run the following command:
> 
> # sudo ceph-osd --cluster ceph --osd-objectstore bluestore --mkfs -i 1
> --monmap /var/lib/ceph/osd/ceph-1/activate.monmap --key
> AQDa6uRZBqjoIRAAJSNl6k9vGce2gGAYUF4nSg== --osd-data
> /var/lib/ceph/osd/ceph-1 --osd-uuid
> 3b3090c7-8bc2-4d01-bfb7-9a364d4c469a --setuser ceph --setgroup ceph

I just tried this and it works for me.  Are you using the 
wip-bluestore-superblock branch?

You can turn up debugging with --debug-bluestore 20 and --log-to-stderr.

sage

> 
> 
> Which will not give any stdout/stderr output and will return with a
> non-zero exit code of 1
> 
> 
> Inspecting the /var/lib/ceph/osd/ceph-1 directory now shows a few more files:
> 
> # ls -alh /var/lib/ceph/osd/ceph-1
> -rw-r--r--. 1 ceph ceph 183 Oct 16 17:22 activate.monmap
> lrwxrwxrwx. 1 ceph ceph  56 Oct 16 17:22 block ->
> /dev/ceph/osd-block-3b3090c7-8bc2-4d01-bfb7-9a364d4c469a
> -rw-r--r--. 1 ceph ceph   0 Oct 16 17:23 fsid
> -rw-r--r--. 1 ceph ceph  10 Oct 16 17:23 type
> 
> In this case "fsid" is empty, and "type" has "bluestore".
> 
> After raising log level output (debug_osd 20) shows the following:
> 
> 2017-10-16 18:03:54.679031 7f654a562d00  0 set uid:gid to 167:167 (ceph:ceph)
> 2017-10-16 18:03:54.679053 7f654a562d00  0 ceph version 12.2.1
> (3e7492b9ada8bdc9a5cd0feafd42fbca27f9c38e) luminous (stable), process
> (unknown), pid 5674
> 2017-10-16 18:03:54.679323 7f654a562d00  5 object store type is bluestore
> 2017-10-16 18:03:54.702667 7f6543733700  2 Event(0x7f6555a0bc80
> nevent=5000 time_id=1).set_owner idx=0 owner=140072900048640
> 2017-10-16 18:03:54.702681 7f6543733700 20 Event(0x7f6555a0bc80
> nevent=5000 time_id=1).create_file_event create event started fd=7
> mask=1 original mask is 0
> 2017-10-16 18:03:54.702683 7f6543733700 20 EpollDriver.add_event add
> event fd=7 cur_mask=0 add_mask=1 to 6
> 2017-10-16 18:03:54.702691 7f6543733700 20 Event(0x7f6555a0bc80
> nevent=5000 time_id=1).create_file_event create event end fd=7 mask=1
> original mask is 1
> 2017-10-16 18:03:54.702692 7f6543733700 10 stack operator() starting
> 2017-10-16 18:03:54.702972 7f6542f32700  2 Event(0x7f6555a0b680
> nevent=5000 time_id=1).set_owner idx=1 owner=140072891655936
> 2017-10-16 18:03:54.703095 7f6542f32700 20 Event(0x7f6555a0b680
> nevent=5000 time_id=1).create_file_event create event started fd=10
> mask=1 original mask is 0
> 2017-10-16 18:03:54.703169 7f6542f32700 20 EpollDriver.add_event add
> event fd=10 cur_mask=0 add_mask=1 to 9
> 2017-10-16 18:03:54.703178 7f6542f32700 20 Event(0x7f6555a0b680
> nevent=5000 time_id=1).create_file_event create event end fd=10 mask=1
> original mask is 1
> 2017-10-16 18:03:54.703181 7f6542f32700 10 stack operator() starting
> 2017-10-16 18:03:54.703474 7f6542731700  2 Event(0x7f6555a0a480
> nevent=5000 time_id=1).set_owner idx=2 owner=140072883263232
> 2017-10-16 18:03:54.703520 7f6542731700 20 Event(0x7f6555a0a480
> nevent=5000 time_id=1).create_file_event create event started fd=13
> mask=1 original mask is 0
> 2017-10-16 18:03:54.703524 7f6542731700 20 EpollDriver.add_event add
> event fd=13 cur_mask=0 add_mask=1 to 12
> 2017-10-16 18:03:54.703527 7f6542731700 20 Event(0x7f6555a0a480
> nevent=5000 time_id=1).create_file_event create event end fd=13 mask=1
> original mask is 1
> 2017-10-16 18:03:54.703529 7f6542731700 10 stack operator() starting
> 2017-10-16 18:03:54.703571 7f654a562d00 10 -- - ready -
> 2017-10-16 18:03:54.703575 7f654a562d00  1  Processor -- start
> 2017-10-16 18:03:54.703625 7f654a562d00  1 -- - start start
> 2017-10-16 18:03:54.703649 7f654a562d00 10 -- - shutdown -
> 2017-10-16 18:03:54.703650 7f654a562d00 10  Processor -- stop
> 2017-10-16 18:03:54.703652 7f654a562d00  1 -- - shutdown_connections
> 2017-10-16 18:03:54.703655 7f654a562d00 20 Event(0x7f6555a0bc80
> nevent=5000 time_id=1).wakeup
> 2017-10-16 18:03:54.703668 7f654a562d00 20 Event(0x7f6555a0b680
> nevent=5000 time_id=1).wakeup
> 2017-10-16 18:03:54.703673 7f654a562d00 20 Event(0x7f6555a0a480
> nevent=5000 time_id=1).wakeup
> 2017-10-16 18:03:54.703896 7f654a562d00 10 -- - wait: waiting for dispatch queue
> 2017-10-16 18:03:54.704285 7f654a562d00 10 -- - wait: dispatch queue is stopped
> 2017-10-16 18:03:54.704290 7f654a562d00  1 -- - shutdown_connections
> 2017-10-16 18:03:54.704293 7f654a562d00 20 Event(0x7f6555a0bc80
> nevent=5000 time_id=1).wakeup
> 2017-10-16 18:03:54.704300 7f654a562d00 20 Event(0x7f6555a0b680
> nevent=5000 time_id=1).wakeup
> 2017-10-16 18:03:54.704303 7f654a562d00 20 Event(0x7f6555a0a480
> nevent=5000 time_id=1).wakeup
> 
> 
> I can't tell what am I missing or if there is any need to pre-populate
> the path with something else.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
