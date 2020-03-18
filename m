From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v4 0/4] ceph: add min/max/stdev latency support
Date: Wed, 18 Mar 2020 10:11:57 +0100
Message-ID: <CAOi1vP_gj6TuJHjKdyWCf47ukKgszJE30-BnrvxjD7cu5VnV0Q@mail.gmail.com>
References: <1584510355-6936-1-git-send-email-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:40360 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgCRJLy (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Mar 2020 05:11:54 -0400
Received: by mail-io1-f68.google.com with SMTP id h18so3489276ioh.7
        for <ceph-devel@vger.kernel.org>; Wed, 18 Mar 2020 02:11:53 -0700 (PDT)
In-Reply-To: <1584510355-6936-1-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Mar 18, 2020 at 6:46 AM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> Changed in V4:
> - fix the 32-bit arches div errors by using DIV64_U64_ROUND_CLOSEST instead. [1/4]
> - rebase and combine the stdev patch series [3/4][4/4]
> - remove the sum latency showing, which makes no sense for debugging, if it
>   is really needed in some case then just do (avg * total) in userland. [4/4]
> - switch {read/write/metadata}_latency_sum to atomic type since it will be
>   readed very time when updating the latencies to calculate the stdev. [4/4]
>
> Changed in V2:
> - switch spin lock to cmpxchg [1/4]
>
> Changed in V3:
> - add the __update_min/max_latency helpers [1/4]
>
>
>
> # cat /sys/kernel/debug/ceph/0f923fe5-00e6-4866-bf01-2027cb75e94b.client4150/metrics
> item          total       avg_lat(us)     min_lat(us)     max_lat(us)     stdev(us)
> -----------------------------------------------------------------------------------
> read          2312        9000            1000            100000          607.4
> write         21777       925000          2000            44551000        29700.3
> metadata      6           4179000         1000            21414000        19590.8
>
> item          total           miss            hit
> -------------------------------------------------
> d_lease       2               0               11
> caps          2               14              398418
>
>
>
> Xiubo Li (4):
>   ceph: switch to DIV64_U64_ROUND_CLOSEST to support 32-bit arches
>   ceph: add min/max latency support for read/write/metadata metrics
>   ceph: move the metric helpers into one separate file
>   ceph: add standard deviation support for read/write/metadata perf
>     metric
>
>  fs/ceph/Makefile     |   2 +-
>  fs/ceph/debugfs.c    |  89 ++++++++++++++++++------
>  fs/ceph/mds_client.c |  83 +---------------------
>  fs/ceph/metric.c     | 190 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ceph/metric.h     |  79 +++++++++++----------
>  5 files changed, 297 insertions(+), 146 deletions(-)
>  create mode 100644 fs/ceph/metric.c

Hi Xiubo,

I think these additions need to be merged with your previous series,
so that the history is clean.  Ideally the whole thing would start with
a single patch adding all of the metrics infrastructure to metric.[ch],
followed by patches introducing new metrics and ceph_update_*() calls.

Related metrics and ceph_update_*() calls should be added together.
No point in splitting read and write OSD latency in two patches as they
touch the same functions in addr.c and file.c.

Thanks,

                Ilya
