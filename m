From: Ugis <ugis22@gmail.com>
Subject: Re: poor read performance on rbd+LVM, LVM overload
Date: Wed, 30 Oct 2013 16:53:38 +0200
Message-ID: <CAE63xUOGg9mRx-VSB+34dnqjHq_mWUeA06f8q46F6qwYEDTEHQ@mail.gmail.com>
References: <CAE63xUO1jhgxQoRbJU-8+j-cxRB7QEspu=JWvekp9ExzFmnjSA@mail.gmail.com>
	<alpine.DEB.2.00.1310160914360.22271@cobra.newdream.net>
	<20131017151828.GB28859@redhat.com>
	<CAE63xUPtovZwGq=4Xseq3DJ+uAyGJJmYbO70ry=WJqqGcBamRA@mail.gmail.com>
	<alpine.DEB.2.00.1310181657151.19763@cobra.newdream.net>
	<CAE63xUO4ZrzObMFeQ=FXGFnqpwWsjCiiDr2_VhOt91h=djofYw@mail.gmail.com>
	<alpine.DEB.2.00.1310202051240.29488@cobra.newdream.net>
	<20131021141147.GA30189@infradead.org>
	<20131021150129.GA28099@redhat.com>
	<20131021180616.GA7196@infradead.org>
	<20131021182717.GB29416@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:53049 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883Ab3J3Oxi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Oct 2013 10:53:38 -0400
Received: by mail-ie0-f179.google.com with SMTP id aq17so2436187iec.38
        for <ceph-devel@vger.kernel.org>; Wed, 30 Oct 2013 07:53:38 -0700 (PDT)
In-Reply-To: <20131021182717.GB29416@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alex Elder <elder@inktank.com>, Sage Weil <sage@inktank.com>, linux-lvm@redhat.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi, I'm back from trip, sorry for thread pause, wanted to wrap this up.
I reread thead, but actually do not see what could be done from admin
side to tune LVM for better read performance on ceph(parts of my LVM
config included below). At least for already deployed LVM.
It seems there is no clear agreement why io is lost, so, it seems that
LVM is not recommended on ceph rbd currently.

In case there is still hope for tuning here follows info.
Mike wrote:
"Should be pretty straight-forward to identify any limits that are
different by walking sysfs/queue, e.g.:
grep -r . /sys/block/rdbXXX/queue
vs
grep -r . /sys/block/dm-X/queue
"

Here it is
# grep -r . /sys/block/rbd2/queue/
/sys/block/rbd2/queue/nomerges:0
/sys/block/rbd2/queue/logical_block_size:512
/sys/block/rbd2/queue/rq_affinity:1
/sys/block/rbd2/queue/discard_zeroes_data:0
/sys/block/rbd2/queue/max_segments:128
/sys/block/rbd2/queue/max_segment_size:4194304
/sys/block/rbd2/queue/rotational:1
/sys/block/rbd2/queue/scheduler:noop [deadline] cfq
/sys/block/rbd2/queue/read_ahead_kb:128
/sys/block/rbd2/queue/max_hw_sectors_kb:4096
/sys/block/rbd2/queue/discard_granularity:0
/sys/block/rbd2/queue/discard_max_bytes:0
/sys/block/rbd2/queue/write_same_max_bytes:0
/sys/block/rbd2/queue/max_integrity_segments:0
/sys/block/rbd2/queue/max_sectors_kb:512
/sys/block/rbd2/queue/physical_block_size:512
/sys/block/rbd2/queue/add_random:1
/sys/block/rbd2/queue/nr_requests:128
/sys/block/rbd2/queue/minimum_io_size:4194304
/sys/block/rbd2/queue/hw_sector_size:512
/sys/block/rbd2/queue/optimal_io_size:4194304
/sys/block/rbd2/queue/iosched/read_expire:500
/sys/block/rbd2/queue/iosched/write_expire:5000
/sys/block/rbd2/queue/iosched/fifo_batch:16
/sys/block/rbd2/queue/iosched/front_merges:1
/sys/block/rbd2/queue/iosched/writes_starved:2
/sys/block/rbd2/queue/iostats:1

# grep -r . /sys/block/dm-2/queue/
/sys/block/dm-2/queue/nomerges:0
/sys/block/dm-2/queue/logical_block_size:512
/sys/block/dm-2/queue/rq_affinity:0
/sys/block/dm-2/queue/discard_zeroes_data:0
/sys/block/dm-2/queue/max_segments:128
/sys/block/dm-2/queue/max_segment_size:65536
/sys/block/dm-2/queue/rotational:1
/sys/block/dm-2/queue/scheduler:none
/sys/block/dm-2/queue/read_ahead_kb:0
/sys/block/dm-2/queue/max_hw_sectors_kb:4096
/sys/block/dm-2/queue/discard_granularity:0
/sys/block/dm-2/queue/discard_max_bytes:0
/sys/block/dm-2/queue/write_same_max_bytes:0
/sys/block/dm-2/queue/max_integrity_segments:0
/sys/block/dm-2/queue/max_sectors_kb:512
/sys/block/dm-2/queue/physical_block_size:512
/sys/block/dm-2/queue/add_random:0
/sys/block/dm-2/queue/nr_requests:128
/sys/block/dm-2/queue/minimum_io_size:4194304
/sys/block/dm-2/queue/hw_sector_size:512
/sys/block/dm-2/queue/optimal_io_size:4194304
/sys/block/dm-2/queue/iostats:0

Chunks of /etc/lvm/lvm.conf if this helps
devices {
    dir = "/dev"
    scan = [ "/dev/rbd" ,"/dev" ]
    preferred_names = [ ]
    filter = [ "a/.*/" ]
    cache_dir = "/etc/lvm/cache"
    cache_file_prefix = ""
    write_cache_state = 0
    types = [ "rbd", 250 ]
    sysfs_scan = 1
    md_component_detection = 1
    md_chunk_alignment = 1
    data_alignment_detection = 1
    data_alignment = 0
    data_alignment_offset_detection = 1
    ignore_suspended_devices = 0
}
...
activation {
    udev_sync = 1
    udev_rules = 1
    missing_stripe_filler = "error"
    reserved_stack = 256
    reserved_memory = 8192
    process_priority = -18
    mirror_region_size = 512
    readahead = "none"
    mirror_log_fault_policy = "allocate"
    mirror_image_fault_policy = "remove"
    use_mlockall = 0
    monitoring = 1
    polling_interval = 15
}

Hope something can be done still, or I will have to move several TB
off the LVM :)
Anyway, it does not feel like the problem cause is clear. May be I
need to file a bug if that is relevant, but where to?

Ugis

2013/10/21 Mike Snitzer <snitzer@redhat.com>:
> On Mon, Oct 21 2013 at  2:06pm -0400,
> Christoph Hellwig <hch@infradead.org> wrote:
>
>> On Mon, Oct 21, 2013 at 11:01:29AM -0400, Mike Snitzer wrote:
>> > It isn't DM that splits the IO into 4K chunks; it is the VM subsystem
>> > no?
>>
>> Well, it's the block layer based on what DM tells it.  Take a look at
>> dm_merge_bvec
>>
>> >From dm_merge_bvec:
>>
>>       /*
>>          * If the target doesn't support merge method and some of the devices
>>          * provided their merge_bvec method (we know this by looking at
>>          * queue_max_hw_sectors), then we can't allow bios with multiple vector
>>          * entries.  So always set max_size to 0, and the code below allows
>>          * just one page.
>>          */
>>
>> Although it's not the general case, just if the driver has a
>> merge_bvec method.  But this happens if you using DM ontop of MD where I
>> saw it aswell as on rbd, which is why it's correct in this context, too.
>
> Right, but only if the DM target that is being used doesn't have a
> .merge method.  I don't think it was ever shared which DM target is in
> use here.. but both the linear and stripe DM targets provide a .merge
> method.
>
>> Sorry for over generalizing a bit.
>
> No problem.
