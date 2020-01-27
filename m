From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [RFC PATCH 0/3] parallel 'copy-from' Ops in copy_file_range
Date: Mon, 27 Jan 2020 19:16:17 +0100
Message-ID: <CAOi1vP9RBBX9RtnZExk_9JX9-H-8B_2R6TQ6-iR3sRw047PfoQ@mail.gmail.com>
References: <20200127164321.17468-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200127164321.17468-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis Henriques <lhenriques@suse.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Jan 27, 2020 at 5:43 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> Hi,
>
> As discussed here[1] I'm sending an RFC patchset that does the
> parallelization of the requests sent to the OSDs during a copy_file_range
> syscall in CephFS.
>
>   [1] https://lore.kernel.org/lkml/20200108100353.23770-1-lhenriques@suse.com/
>
> I've also some performance numbers that I wanted to share. Here's a
> description of the very simple tests I've run:
>
>  - create a file with 200 objects in it
>    * i.e. tests with different object sizes mean different file sizes
>  - drop all caches and umount the filesystem
>  - Measure:
>    * mount filesystem
>    * full file copy (with copy_file_range)
>    * umount filesystem
>
> Tests were repeated several times and the average value was used for
> comparison.
>
>   DISCLAIMER:
>   These numbers are only indicative, and different clusters and client
>   configs will for sure show different performance!  More rigorous tests
>   would be require to validate these results.
>
> Having as baseline a full read+write (basically, a copy_file_range
> operation within a filesystem mounted without the 'copyfrom' option),
> here's some values for different object sizes:
>
>                           8M      4M      1M      65k
> read+write              100%    100%    100%     100%
> sequential               51%     52%     83%    >100%
> parallel (throttle=1)    51%     52%     83%    >100%
> parallel (throttle=0)    17%     17%     83%    >100%
>
> Notes:
>
> - 'parallel (throttle=0)' was a test where *all* the requests (i.e. 200
>   requests to copy the 200 objects in the file) were sent to the OSDs and
>   the wait for requests completion is done at the end only.
>
> - 'parallel (throttle=1)' was just a control test, where the wait for
>   completion is done immediately after a request is sent.  It was expected
>   to be very similar to the non-optimized ('sequential') tests.
>
> - These tests were executed on a cluster with 40 OSDs, spread across 5
>   (bare-metal) nodes.
>
> - The tests with object size of 65k show that copy_file_range definitely
>   doesn't scale to files with small object sizes.  '> 100%' actually means
>   more than 10x slower.
>
> Measuring the mount+copy+umount masks the actual difference between
> different throttle values due to the time spent in mount+umount.  Thus,
> there was no real difference between throttle=0 (send all and wait) and
> throttle=20 (send 20, wait, send 20, ...).  But here's what I observed
> when measuring only the copy operation (4M object size):
>
> read+write              100%
> parallel (throttle=1)    56%
> parallel (throttle=5)    23%
> parallel (throttle=10)   14%
> parallel (throttle=20)    9%
> parallel (throttle=5)     5%

Was this supposed to be throttle=50?

>
> Anyway, I'll still need to revisit patch 0003 as it doesn't follow the
> suggestion done by Jeff to *not* add another knob to fine-tune the
> throttle value -- this patch adds a kernel parameter for a knob that I
> wanted to use in my testing to observe different values of this throttle
> limit.
>
> The goal is to probably to drop this patch and do the throttling in patch
> 0002.  I just need to come up with a decent heuristic.  Jeff's suggestion
> was to use rsize/wsize, which are set to 64M by default IIRC.  Somehow I
> feel that it should be related to the number of OSDs in the cluster
> instead, but I'm not sure how.  And testing these sort of heuristics would
> require different clusters, which isn't particularly easy to get.  Anyway,
> comments are welcome!

I agree with Jeff, this throttle is certainly not worth a module
parameter (or a mount option).  I would start with something like
C * (wsize / object size) and pick C between 1 and 4.

Thanks,

                Ilya
